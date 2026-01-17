package datastore

import (
	"encoding/json"

	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/utils"

	// "log"

	"github.com/dghwood/resonate/models"
	pb "github.com/dghwood/resonate/proto"
	"google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/reflect/protoreflect"
	"google.golang.org/protobuf/types/descriptorpb"
)

// datastore.Property
type Field struct {
	Name    string
	Number  int32
	Value   any
	NoIndex bool
}

type DatastoreItem struct {
	Fields []Field
	Meta   *pb.StorageMetadataMessage
}

func getIndex(fd protoreflect.FieldDescriptor) bool {
	options, ok := fd.Options().(*descriptorpb.FieldOptions)
	if !ok {
		return false
	}
	val := proto.GetExtension(options, pb.E_Index)
	if val != nil {
		indexed, ok := val.(bool)
		if ok {
			return indexed
		}
	}
	return false
}

func GetFields(message models.Model) (item DatastoreItem) {
	fields := make([]Field, 0)

	message.ProtoReflect().Range(
		func(
			fd protoreflect.FieldDescriptor,
			value protoreflect.Value) bool {

			if fd.Name() == "meta" {
				// Skip for meta
				return true
			}

			field := Field{
				Name:    string(fd.Name()),
				Number:  int32(fd.Number()),
				NoIndex: !getIndex(fd),
			}

			switch fd.Kind() {
			case protoreflect.MessageKind:
				if fd.IsList() {
					v := value.List()
					b := make([][]byte, v.Len())
					for i := 0; i < v.Len(); i++ {
						bytes, err := proto.Marshal(v.Get(i).Message().Interface())
						if err != nil {
							log.Error("error marshalling proto")
							return true
						}
						b[i] = bytes
					}
					bytes, err := json.Marshal(b)
					if err != nil {
						return true
					}
					field.Value = bytes
				} else {
					bytes, err := proto.Marshal(value.Message().Interface())
					if err != nil {
						log.Error("error marshalling proto")
						return true
					}
					field.Value = bytes
				}
			default:
				field.Value = value.Interface()
			}

			fields = append(fields, field)

			return true
		})
	item.Fields = fields

	// Populate Meta
	meta := message.GetMetadata()
	if meta == nil {
		// meta is not set..
		meta = &pb.StorageMetadataMessage{}
		meta.CreatedTimestamp = utils.Now()
		meta.UpdatedTimestamp = utils.Now()
	} else if meta.UpdatedTimestamp == 0 {
		meta.UpdatedTimestamp = utils.Now()
	}
	item.Meta = meta
	return
}

func RetrieveFields(item DatastoreItem, model models.Model) (err error) {
	if item.Meta != nil {
		model.SetMetadata(item.Meta)
	}
	for _, field := range item.Fields {
		if field.Name == "meta" {
			// Handle metadata
			continue
		}
		num := field.Number
		descriptor := model.ProtoReflect().
			Descriptor().Fields().
			ByNumber(protoreflect.FieldNumber(num))

		switch descriptor.Kind() {
		case protoreflect.MessageKind:
			if descriptor.IsList() {
				// Seems like there is Mutable vs. Get
				// TODO(duncan): refactor this file for Mutable?
				list := model.ProtoReflect().Mutable(descriptor).List()
				value := field.Value.([]byte)
				var b [][]byte
				err = json.Unmarshal(value, &b)
				if err != nil {
					return
				}
				for _, bytes := range b {
					nested := list.AppendMutable().Message()
					proto.Unmarshal(
						bytes,
						nested.Interface())
				}
				continue
			}
			// Need to init the message first
			nested := model.ProtoReflect().Get(descriptor).
				Message().New()
			proto.Unmarshal(
				field.Value.([]byte),
				nested.Interface())
			model.ProtoReflect().Set(descriptor, protoreflect.ValueOf(nested))
		default:
			model.ProtoReflect().Set(descriptor, protoreflect.ValueOf(field.Value))
		}
	}
	return
}
