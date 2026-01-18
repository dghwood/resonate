package firestore

import (
	"fmt"
	"strconv"

	firestore "cloud.google.com/go/datastore"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
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

func loadMeta(property firestore.Property) (meta *proto.StorageMetadataMessage, err error) {
	meta = &proto.StorageMetadataMessage{}
	if property.Name != "meta" {
		err = fmt.Errorf("property is not meta")
		return
	}
	entity := property.Value.(*firestore.Entity)
	for _, property := range entity.Properties {
		switch property.Name {
		case "updated_timestamp":
			meta.UpdatedTimestamp = property.Value.(int64)
		case "created_timestamp":
			meta.CreatedTimestamp = property.Value.(int64)
		case "is_deleted":
			meta.IsDeleted = property.Value.(bool)
		}
	}
	return
}

func (d *DatabaseModel) Load(props []firestore.Property) (err error) {
	item := datastore.DatastoreItem{}
	fields := make([]datastore.Field, 0)
	for _, property := range props {
		if property.Name == "meta" {
			// skip for meta
			meta, err := loadMeta(property)
			if err != nil {
				return err
			}
			item.Meta = meta
			continue
		}
		field, err := propertyToField(property)
		if err != nil {
			return err
		}
		fields = append(fields, field)
	}
	item.Fields = fields
	err = datastore.RetrieveFields(item, d.Model)
	return
}

func (d *DatabaseModel) Key() *firestore.Key {
	return firestore.NameKey(
		models.Kind(d.Model), d.Model.GetId(), nil)
}

func (d *DatabaseModel) Save() (props []firestore.Property, err error) {
	item, err := datastore.GetFields(d.Model)
	if err != nil {
		return
	}
	// The fields won't include meta
	for _, field := range item.Fields {
		property := fieldToProperty(field)
		props = append(props, property)
	}

	// Add meta seperately
	props = append(props, firestore.Property{
		Name: "meta",
		Value: &firestore.Entity{Properties: []firestore.Property{
			{Name: "updated_timestamp", Value: item.Meta.UpdatedTimestamp},
			{Name: "created_timestamp", Value: item.Meta.CreatedTimestamp},
			{Name: "is_deleted", Value: item.Meta.IsDeleted},
		}},
	})
	return
}

func fieldToProperty(field datastore.Field) firestore.Property {
	return firestore.Property{
		Name:    getFieldName(field.Number),
		Value:   field.Value,
		NoIndex: field.NoIndex,
	}
}
func propertyToField(property firestore.Property) (field datastore.Field, err error) {
	num, err := retrieveFieldName(property.Name)
	if err != nil {
		return
	}
	field = datastore.Field{
		Number:  num,
		Value:   property.Value,
		NoIndex: property.NoIndex,
	}
	return
}
