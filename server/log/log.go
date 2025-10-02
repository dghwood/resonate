package log

import (
	logger "log"
	"os"
)

var std = logger.New(
	os.Stderr, "",
	logger.Lshortfile|logger.LstdFlags)

func Info(v ...interface{}) {
	std.Print(append([]interface{}{"INFO: "}, v...)...)
}

func Infof(format string, v ...interface{}) {
	std.Printf("INFO: "+format, v...)
}

func Error(v ...interface{}) {
	std.Print(append([]interface{}{"ERROR: "}, v...)...)
}

func Errorf(format string, v ...interface{}) {
	std.Printf("ERROR: "+format, v...)
}

func Print(v ...interface{}) {
	Info(v...)
}
