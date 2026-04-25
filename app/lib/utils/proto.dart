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

  void messageFromString<K extends GeneratedMessage>(
    String storeMessage,
    K message,
  ) {
    message.mergeFromBuffer(latin1.encode(storeMessage));
  }

  DatabaseStoreType toStore() {
    final Map<String, Object> storeMap = {};
    for (var field in _descriptor.field) {
      bool isRepeated = false;
      if (!_message.hasField(field.number)) {
        continue; // Skip fields that are not set
      }
      if (field.label == FieldDescriptorProto_Label.LABEL_REPEATED) {
        if (_message.getField(field.number) is List &&
            (_message.getField(field.number) as List).isEmpty) {
          continue; // Skip fields that are empty arrays
        }
        isRepeated = true;
        // throw UnimplementedError(
        //   'Repeated field handling not implemented for field: ${field.name}',
        // );
      }
      var storeFieldName = 'field_${field.number}';
      switch (field.type) {
        case FieldDescriptorProto_Type.TYPE_INT64:
          storeMap[storeFieldName] =
              isRepeated
                  ? (_message.getField(field.number) as Iterable<Int64>)
                      .map((i) => i.toInt())
                      .toList()
                  : (_message.getField(field.number) as Int64).toInt();

        case FieldDescriptorProto_Type.TYPE_STRING:
        case FieldDescriptorProto_Type.TYPE_BOOL:
          storeMap[storeFieldName] = _message.getField(field.number);
          break;
        case FieldDescriptorProto_Type.TYPE_MESSAGE:
          if (!isRepeated) {
            var message = _message.getField(field.number) as GeneratedMessage;
            storeMap[storeFieldName] = messageToString(message);
          } else {
            var messages =
                _message.getField(field.number) as Iterable<GeneratedMessage>;
            storeMap[storeFieldName] =
                messages.map((i) => messageToString(i)).toList();
          }
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
      var isRepeated = field.label == FieldDescriptorProto_Label.LABEL_REPEATED;
      switch (field.type) {
        case FieldDescriptorProto_Type.TYPE_INT64:
          if (!isRepeated) {
            _message.setField(field.number, Int64(value as int));
          } else {
            _log.info("setting repeated field");
            _message
                .getField(field.number)
                .addAll(
                  (value as List<Object?>).map((i) => Int64((i! as int))),
                );
            // _message.setField(
            //   field.number,
            //   (value as List<Object?>).map((i) => Int64(i! as int)),
            // );
          }
        case FieldDescriptorProto_Type.TYPE_STRING:
          if (isRepeated) {
            _message
                .getField(field.number)
                .addAll((value as List<Object?>).map((i) => i! as String));
          } else {
            _message.setField(field.number, value);
          }
        case FieldDescriptorProto_Type.TYPE_BOOL:
          // TODO(duncan): I bet I need to cast the List..
          if (isRepeated) {
            _message
                .getField(field.number)
                .addAll((value as List<Object?>).map((i) => i! as bool));
          } else {
            _message.setField(field.number, value);
          }
        case FieldDescriptorProto_Type.TYPE_MESSAGE:
          var builder = _message.info_.fieldInfo[field.number]!.subBuilder!;
          if (!isRepeated) {
            // var subMessage =
            //     _message.getField(field.number) as GeneratedMessage;
            // if (!_message.hasField(field.number)) {
            //   subMessage = subMessage.createEmptyInstance();
            //   _message.setField(field.number, subMessage);
            // }
            var subMessage = builder();
            messageFromString(value as String, subMessage);
            _message.setField(field.number, subMessage);
          } else {
            var repeatedField =
                _message.getField(field.number) as List<GeneratedMessage>;
            // Again casting to List<String> seems to be possible here
            // You need to convert to List<Object?> then to String
            var values =
                (value as List<Object?>).map((i) {
                  var m = builder();
                  var s = i! as String;
                  messageFromString(s, m);
                  return m;
                }).toList();
            // For some reason I need to add these individually, since addAll
            // seems to not be able to identify this as the right message
            // and throws an error.
            for (var m in values) {
              repeatedField.add(m);
            }
          }
        default:
          throw UnimplementedError(
            'fromStore handling not implemented for field: ${field.name}',
          );
      }
    }
  }
}
