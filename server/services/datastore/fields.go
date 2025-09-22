package datastore

import (
	"github.com/dghwood/resonate/models"
	"google.golang.org/protobuf/reflect/protoreflect"
)

func GetFields(message models.Model) (fields map[int64]string) {
	fields = make(map[int64]string)
	message.ProtoReflect().Range(
		func(
			fd protoreflect.FieldDescriptor,
			value protoreflect.Value) bool {
			fields[int64(fd.Number())] = value.String()
			return true
		})
	return
}
