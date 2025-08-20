import 'dart:typed_data';

import 'package:protobuf/protobuf.dart';
import 'package:protobuf_google/protobuf_google.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/proto/common.pbjson.dart';
import 'package:resonate/services/database.dart';

class DatabaseProtoStoreUtils<T extends GeneratedMessage> {
  DatabaseProtoStoreUtils(Uint8List descriptor, T message)
    : _descriptor = DescriptorProto.fromBuffer(descriptor),
      _message = message;

  final DescriptorProto _descriptor;
  final T _message;

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
      switch (field.type) {
        case FieldDescriptorProto_Type.TYPE_STRING:
        case FieldDescriptorProto_Type.TYPE_INT64:
        case FieldDescriptorProto_Type.TYPE_BOOL:
          storeMap['field_${field.number}'] = _message.getField(field.number);
          break;
        case FieldDescriptorProto_Type.TYPE_MESSAGE:
          var message = _message.getField(field.number);
          if (message.runtimeType == StorageMetadataMessage) {
            storeMap['field_${field.number}'] =
                DatabaseProtoStoreUtils(
                  storageMetadataMessageDescriptor,
                  message as StorageMetadataMessage,
                ).toStore();
            break;
          }
          // Handle nested messages
          throw UnimplementedError(
            'Nested message handling not implemented for field: ${field.name}',
          );
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
      if (storeMap.containsKey('field_${field.number}')) {
        var message = _message.getField(field.number);
        if (field.type == FieldDescriptorProto_Type.TYPE_MESSAGE &&
            message is StorageMetadataMessage) {
          if (!_message.hasField(field.number)) {
            // If the field is not set, then it's frozen..
            // we need to create a new instance.
            var m = StorageMetadataMessage();
            _message.setField(field.number, m);
            message = m;
          }
          DatabaseProtoStoreUtils(
            storageMetadataMessageDescriptor,
            message,
          ).fromStore(storeMap['field_${field.number}'] as DatabaseStoreType);
          continue;
        }
        _message.setField(field.number, storeMap['field_${field.number}']!);
      }
    }
  }
}
