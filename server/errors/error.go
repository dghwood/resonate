package errors

import (
	"github.com/dghwood/resonate/proto"
)

type Error struct {
	Enum    proto.ErrorEnum
	Message string
}

func (e Error) Error() string {
	return e.Enum.String()
}

var (
	ERROR_PERMISSION_DENIED = Error{
		Enum:    proto.ErrorEnum_ERROR_PERMISSION_DENIED,
		Message: "The user does not have permission to perform this action.",
	}

	ERROR_INTERNAL = Error{
		Enum:    proto.ErrorEnum_ERROR_INTERNAL,
		Message: "An internal error has occurred.",
	}

	ERROR_UNKNOWN = Error{
		Enum:    proto.ErrorEnum_ERROR_UNKNOWN,
		Message: "An unknown error has occurred.",
	}

	ERROR_INVALID_CREDENTIALS = Error{
		Enum:    proto.ErrorEnum_ERROR_INVALID_CREDENTIALS,
		Message: "The provided credentials are invalid.",
	}

	ERROR_TOO_MANY_ATTEMPTS = Error{
		Enum:    proto.ErrorEnum_ERROR_TOO_MANY_ATTEMPTS,
		Message: "Too many attempts have been made.",
	}

	ERROR_TIME_EXPIRED = Error{
		Enum:    proto.ErrorEnum_ERROR_TIME_EXPIRED,
		Message: "The time has expired.",
	}
)
