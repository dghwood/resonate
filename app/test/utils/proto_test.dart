import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:protobuf/protobuf.dart';
import 'package:protobuf_google/protobuf_google.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/proto/common.pbjson.dart';
import 'package:resonate/utils/proto.dart';

// class ProtoUtil<T extends GeneratedMessage> {
//   ProtoUtil(this.message, this.descriptor);
//   final T message;
//   final DescriptorProto descriptor;

//   void fromStore(List<Uint8List> store) {
//     for (var field in descriptor.field) {
//       if (field.label == FieldDescriptorProto_Label.LABEL_REPEATED) {
//         var repeatedField =
//             message.getField(field.number) as List<GeneratedMessage>;
//         var builder = message.info_.fieldInfo[field.number]!.subBuilder!;
//         repeatedField.addAll(
//           store.map((i) {
//             var m = builder();
//             m.mergeFromBuffer(i);
//             return m;
//           }),
//         );
//       }
//       break;
//     }
//   }
// }

void main() {
  group('DatabaseProtoStoreUtils Model Tests', () {
    // test('nestedDescriptors', () {
    //   var message = UserFeedMessage();
    //   var descriptor = DescriptorProto.fromBuffer(userFeedMessageDescriptor);
    //   var store = [
    //     UserFeedItemMessage(
    //       episodeItem: UserFeedItemEpisodeMessage(
    //         episode: EpisodeMessage(id: '1'),
    //       ),
    //     ).writeToBuffer(),
    //     UserFeedItemMessage(
    //       episodeItem: UserFeedItemEpisodeMessage(
    //         episode: EpisodeMessage(id: '2'),
    //       ),
    //     ).writeToBuffer(),
    //   ];

    //   var u = ProtoUtil(message, descriptor);
    //   u.fromStore(store);
    // });
    test(
      'toStore should correctly convert UserSubscriptionMessage to a Map',
      () {
        var subMessage = StorageMetadataMessage(
          isDeleted: false,
          updatedTimestamp: Int64(1),
          createdTimestamp: Int64(2),
        );
        var message = UserSubscriptionMessage(
          id: '123',
          userId: 'user_456',
          podcastId: 'podcast_789',
          metadata: subMessage,
        );

        var writeStore =
            DatabaseProtoStoreUtils(
              userSubscriptionMessageDescriptor,
              message,
            ).toStore();

        expect(writeStore['field_1'], '123'); // id
        expect(writeStore['field_2'], 'user_456'); // userId
        expect(writeStore['field_3'], 'podcast_789'); // podcastId

        var newMessage = UserSubscriptionMessage();
        var readStore = DatabaseProtoStoreUtils(
          userSubscriptionMessageDescriptor,
          newMessage,
        ).fromStore(writeStore);

        expect(newMessage.id, '123');
        expect(newMessage.userId, 'user_456');
        expect(newMessage.podcastId, 'podcast_789');
        expect(newMessage.metadata.isDeleted, false);
        expect(newMessage.metadata.updatedTimestamp, Int64(1));
        expect(newMessage.metadata.createdTimestamp, Int64(2));
      },
    );

    test('toStore should correctly convert UserFeedMessage to a Map', () {
      var message = UserFeedMessage(
        items: [
          UserFeedItemMessage(
            episodeItem: UserFeedItemEpisodeMessage(
              episode: EpisodeMessage(id: '1'),
            ),
          ),
          UserFeedItemMessage(
            episodeItem: UserFeedItemEpisodeMessage(
              episode: EpisodeMessage(id: '2'),
            ),
          ),
        ],
      );

      var writeStore =
          DatabaseProtoStoreUtils(userFeedMessageDescriptor, message).toStore();

      var newMessage = UserFeedMessage();
      var readStore = DatabaseProtoStoreUtils(
        userFeedMessageDescriptor,
        newMessage,
      ).fromStore(writeStore);

      expect(newMessage.items.length, 2);
      expect(newMessage.items[0].episodeItem.episode.id, '1');
      expect(newMessage.items[1].episodeItem.episode.id, '2');
    });
  });
}
