package api

import (
	"bytes"
	"context"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	pb "google.golang.org/protobuf/proto"
)

type ApiTest struct {
	IsExecuted bool
}

func (f ApiTest) RequireSignIn() bool { return false }
func (f ApiTest) RequestProto() *proto.EditUserMessage_Request {
	return &proto.EditUserMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f ApiTest) ResponseProto() *proto.EditUserMessage_Response {
	return &proto.EditUserMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}
func (f *ApiTest) Execute(
	ctx context.Context,
	loggedInUser *models.LoggedInUser,
	request *proto.EditUserMessage_Request,
	response *proto.EditUserMessage_Response) (err error) {
	f.IsExecuted = true
	return
}

func TestParse(t *testing.T) {
	api := &ApiTest{}
	requestProto := &proto.EditUserMessage_Request{
		RequestInfo: &proto.RequestInfo{},
		User: &proto.UserMessage{
			Id: "test",
		},
	}
	requestBytes, err := pb.Marshal(requestProto)
	if err != nil {
		t.Errorf("failed to marshal request")
	}
	req := httptest.NewRequest(http.MethodPost, "/", bytes.NewReader(requestBytes))
	// res := httptest.NewRecorder()
	request := api.RequestProto()
	parseProto(req, request)
	if request.User.Id != "test" {
		t.Errorf("failed to parse request")
	}
}

func TestApi(t *testing.T) {
	api := &ApiTest{}
	requestProto := &proto.EditUserMessage_Request{
		RequestInfo: &proto.RequestInfo{},
		User: &proto.UserMessage{
			Id: "test",
		},
	}

	requestBytes, err := pb.Marshal(requestProto)
	if err != nil {
		t.Errorf("failed to marshal request")
	}

	req := httptest.NewRequest(http.MethodPost, "/", bytes.NewReader(requestBytes))
	res := httptest.NewRecorder()

	handle(api)(res, req)

	response := api.ResponseProto()
	err = pb.Unmarshal(res.Body.Bytes(), response)
	if err != nil {
		t.Errorf("failed to unmarshal response")
	}
	if !response.GetResponseInfo().Success {
		t.Errorf("failed to execute request")
	}
	if !api.IsExecuted {
		t.Errorf("failed to execute request")
	}
	if res.Header().Get("Access-Control-Allow-Origin") != "*" {
		t.Errorf("failed to set Access-Control-Allow-Origin")
	}
}
