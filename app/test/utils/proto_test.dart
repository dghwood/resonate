import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/proto/common.pbjson.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/utils/proto.dart';

void main() {
  group('DatabaseProtoStoreUtils Model Tests', () {
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
  });
}
