package memory

import (
	"fmt"

	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/utils"
)

type MemoryVerification struct {
	codes map[string]string
}

func (m *MemoryVerification) Send(phoneNumber string) (err error) {
	code := utils.GenerateRandomNumberString(6)
	return m.sendWithCode(phoneNumber, code)
}

func (m *MemoryVerification) sendWithCode(phoneNumber string, code string) (err error) {
	m.codes[phoneNumber] = code
	log.Infof("Verification code for %s is: %s", phoneNumber, code)
	return
}

func (m *MemoryVerification) Validate(phoneNumber string, code string) (err error) {
	mapcode, ok := m.codes[phoneNumber]
	if !ok {
		return fmt.Errorf("Code for phone number not found %s", phoneNumber)
	}
	if mapcode != code {
		return fmt.Errorf("Code does not match")
	}
	delete(m.codes, phoneNumber)
	return
}

func NewMemoryVerification() *MemoryVerification {
	return &MemoryVerification{
		codes: make(map[string]string),
	}
}
