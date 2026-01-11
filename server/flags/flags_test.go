package flags

import (
	"os"
	"testing"
)

func TestParse(t *testing.T) {
	Parse()
	if FLAGS.EnableSms == true {
		t.Error("EnableSms not set")
	}
}

func TestParseSet(t *testing.T) {
	os.Setenv("ENABLE_SMS", "1")
	Parse()
	if FLAGS.EnableSms == false {
		t.Error("EnableSms should be true")
	}
}

func TestPrint(t *testing.T) {
	Parse()
	_, err := Print()
	if err != nil {
		t.Error(err)
	}
}
