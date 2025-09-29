package firestore

import (
	firestore "cloud.google.com/go/datastore"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/services/datastore"
)

type DatabaseModel struct {
	Model models.Model
}

func (d *DatabaseModel) Load(props []firestore.Property) (err error) {
	fields := make([]datastore.Field, len(props))
	for _, property := range props {
		field := propertyToField(property)
		fields = append(fields, field)
	}
	datastore.RetrieveFields(fields, d.Model)
	return
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
		Name:  field.Name,
		Value: field.Value,
	}
}
func propertyToField(property firestore.Property) datastore.Field {
	return datastore.Field{
		Name:  property.Name,
		Value: property.Value,
	}
}
