package firestore

import (
	"fmt"
	"strconv"

	firestore "cloud.google.com/go/datastore"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/services/datastore"
)

func getFieldName(fieldNum int32) string {
	return fmt.Sprintf("f%d", fieldNum)
}
func retrieveFieldName(fieldName string) (num int32, err error) {
	numInt, err := strconv.Atoi(fieldName[1:])
	if err != nil {
		return
	}
	num = int32(numInt)
	return
}

type DatabaseModel struct {
	Model models.Model
}

func (d *DatabaseModel) Load(props []firestore.Property) (err error) {
	fields := make([]datastore.Field, len(props))
	for i, property := range props {
		field, err := propertyToField(property)
		if err != nil {
			return err
		}
		fields[i] = field
	}
	err = datastore.RetrieveFields(fields, d.Model)
	return
}

func (d *DatabaseModel) Key() *firestore.Key {
	return firestore.NameKey(
		models.Kind(d.Model), d.Model.GetId(), nil)
}

func (d *DatabaseModel) Save() (props []firestore.Property, err error) {
	fields := datastore.GetFields(d.Model)
	for _, field := range fields {
		property := fieldToProperty(field)
		props = append(props, property)
	}
	return
}

func fieldToProperty(field datastore.Field) firestore.Property {
	return firestore.Property{
		Name:  getFieldName(field.Number),
		Value: field.Value,
		// NoIndex: true,
	}
}
func propertyToField(property firestore.Property) (field datastore.Field, err error) {
	num, err := retrieveFieldName(property.Name)
	if err != nil {
		return
	}
	field = datastore.Field{
		Number: num,
		Value:  property.Value,
	}
	return
}
