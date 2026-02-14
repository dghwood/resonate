package proto

import (
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
)

type ImportOpmlMessage struct {
	Request  *ImportOpmlMessage_Request
	Response *ImportOpmlMessage_Response
}

func (m *ImportOpmlMessage) ProtoMessage() {}
func (m *ImportOpmlMessage) ProtoReflect() protoreflect.Message {
	return nil
}

type ImportOpmlMessage_Request struct {
	RequestInfo *RequestInfo
	OpmlBytes   []byte
}

func (m *ImportOpmlMessage_Request) ProtoMessage() {}
func (m *ImportOpmlMessage_Request) ProtoReflect() protoreflect.Message {
	return nil
}

func (x *ImportOpmlMessage_Request) GetRequestInfo() *RequestInfo {
	if x != nil {
		return x.RequestInfo
	}
	return nil
}

func (x *ImportOpmlMessage_Request) SetRequestInfo(v *RequestInfo) {
	x.RequestInfo = v
}

func (x *ImportOpmlMessage_Request) GetOpmlBytes() []byte {
	if x != nil {
		return x.OpmlBytes
	}
	return nil
}

type ImportOpmlMessage_Response struct {
	ResponseInfo  *ResponseInfo
	Subscriptions []*UserSubscriptionMessage
}

func (m *ImportOpmlMessage_Response) ProtoMessage() {}
func (m *ImportOpmlMessage_Response) ProtoReflect() protoreflect.Message {
	return nil
}

func (x *ImportOpmlMessage_Response) GetResponseInfo() *ResponseInfo {
	if x != nil {
		return x.ResponseInfo
	}
	return nil
}

func (x *ImportOpmlMessage_Response) SetResponseInfo(v *ResponseInfo) {
	x.ResponseInfo = v
}

func (x *ImportOpmlMessage_Response) GetSubscriptions() []*UserSubscriptionMessage {
	if x != nil {
		return x.Subscriptions
	}
	return nil
}
