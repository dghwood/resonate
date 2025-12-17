package log

import (
	"log/slog"
	"os"
)

var std = slog.New(slog.NewJSONHandler(os.Stderr, nil))

func Info(msg string, args ...any) {
	std.Info(msg, args...)
}

func Error(msg string, args ...any) {
	std.Error(msg, args...)
}
