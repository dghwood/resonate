package datastore

import (
	"log"

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
				bytes, err := proto.Marshal(value.Message().Interface())
				if err != nil {
					log.Print("error marshalling proto")
					return true
				}
				field.Value = bytes
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
		log.Print(field)
		descriptor := model.ProtoReflect().
			Descriptor().Fields().
			ByNumber(protoreflect.FieldNumber(num))

		switch descriptor.Kind() {
		case protoreflect.MessageKind:
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
