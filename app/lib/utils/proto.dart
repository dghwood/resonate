import 'dart:convert';
import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:logging/logging.dart';
import 'package:protobuf/protobuf.dart';
import 'package:protobuf_google/protobuf_google.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/proto/common.pbjson.dart';
import 'package:resonate/services/database.dart';

Logger _log = Logger('utils/proto');

class DatabaseProtoStoreUtils<T extends GeneratedMessage> {
  DatabaseProtoStoreUtils(Uint8List descriptor, T message)
    : _descriptor = DescriptorProto.fromBuffer(descriptor),
      _message = message;

  final DescriptorProto _descriptor;
  final T _message;

  String messageToString(GeneratedMessage message) {
    // Should this be hex?
    return latin1.decode(message.writeToBuffer());
  }

  void messageFromString(String storeMessage, GeneratedMessage message) {
    message.mergeFromBuffer(latin1.encode(storeMessage));
  }

  DatabaseStoreType toStore() {
    final Map<String, Object> storeMap = {};
    for (var field in _descriptor.field) {
      if (!_message.hasField(field.number)) {
        continue; // Skip fields that are not set
      }
      if (field.label == FieldDescriptorProto_Label.LABEL_REPEATED) {
        if (_message.getField(field.number) is List &&
            (_message.getField(field.number) as List).isEmpty) {
          continue; // Skip fields that are empty arrays
        }
        throw UnimplementedError(
          'Repeated field handling not implemented for field: ${field.name}',
        );
      }
      var storeFieldName = 'field_${field.number}';
      switch (field.type) {
        case FieldDescriptorProto_Type.TYPE_INT64:
          storeMap[storeFieldName] =
              (_message.getField(field.number) as Int64).toInt();
        case FieldDescriptorProto_Type.TYPE_STRING:
        case FieldDescriptorProto_Type.TYPE_BOOL:
          storeMap[storeFieldName] = _message.getField(field.number);
          break;
        case FieldDescriptorProto_Type.TYPE_MESSAGE:
          var message = _message.getField(field.number) as GeneratedMessage;
          storeMap[storeFieldName] = messageToString(message);
        default:
          throw UnimplementedError(
            'toStore handling not implemented for field: ${field.name}',
          );
      }
    }
    return storeMap;
  }

  void fromStore(DatabaseStoreType storeMap) {
    for (var field in _descriptor.field) {
      var storeFieldName = 'field_${field.number}';
      if (!storeMap.containsKey(storeFieldName)) {
        continue; // Skip fields that are not in the store map
      }
      var value = storeMap[storeFieldName]!;

      switch (field.type) {
        case FieldDescriptorProto_Type.TYPE_INT64:
          _message.setField(field.number, Int64(value as int));
        case FieldDescriptorProto_Type.TYPE_STRING:
        case FieldDescriptorProto_Type.TYPE_BOOL:
          _message.setField(field.number, value);
        case FieldDescriptorProto_Type.TYPE_MESSAGE:
          var subMessage = _message.getField(field.number) as GeneratedMessage;
          if (!_message.hasField(field.number)) {
            subMessage = subMessage.createEmptyInstance();
            _message.setField(field.number, subMessage);
          }
          messageFromString(value as String, subMessage);
        default:
          throw UnimplementedError(
            'fromStore handling not implemented for field: ${field.name}',
          );
      }
    }
  }
}
