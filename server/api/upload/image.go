package upload

import (
	"context"

	"github.com/dghwood/resonate/errors"
	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/imagestore"
	"github.com/dghwood/resonate/utils"
)

type Image struct {
	Datastore imagestore.Imagestore
}

func (f Image) RequireSignIn() bool { return true }

func (f Image) RequestProto() *proto.UploadImageMessage_Request {
	return &proto.UploadImageMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Image) ResponseProto() *proto.UploadImageMessage_Response {
	return &proto.UploadImageMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *Image) Execute(
	ctx context.Context,
	loggedInUser *models.LoggedInUser,
	request *proto.UploadImageMessage_Request,
	response *proto.UploadImageMessage_Response) (err error) {

	// Check the image isn't too big
	log.Infof("Image size: %d bytes", len(request.ImageBytes))
	// TODO(duncan): Get the image size smaller
	if len(request.ImageBytes) > 500*1024 {
		err = errors.ERROR_UPLOAD_SIZE_EXCEEDED
		return
	}
	imageId := utils.GenerateUniqueID()

	err = f.Datastore.Put(imageId, request.ImageBytes)
	if err != nil {
		return
	}
	response.ImageUrl = "/images/users/" + imageId
	return
}
