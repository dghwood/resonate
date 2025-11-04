package datastore

import (
	"encoding/json"

	"github.com/dghwood/resonate/log"

	// "log"

	"github.com/dghwood/resonate/models"
	"google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/reflect/protoreflect"
)

// datastore.Property
type Field struct {
	Name    string
	Number  int32
	Value   any
	NoIndex bool
}

func GetFields(message models.Model) (fields []Field) {
	fields = make([]Field, 0)
	message.ProtoReflect().Range(
		func(
			fd protoreflect.FieldDescriptor,
			value protoreflect.Value) bool {

			field := Field{
				Name:   string(fd.Name()),
				Number: int32(fd.Number()),
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
	return
}

func RetrieveFields(fields []Field, model models.Model) (err error) {
	for _, field := range fields {
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
				// for _, hexBytes := range field.Value.([]byte) {
				// 	nested := list.AppendMutable().Message()
				// 	bytes, err := hex.DecodeString(hexBytes)
				// 	if err != nil {
				// 		return err
				// 	}
				// 	proto.Unmarshal(
				// 		bytes,
				// 		nested.Interface())
				// }
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
