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
        var message = UserSubscriptionMessage(
          id: '123',
          userId: 'user_456',
          podcastId: 'podcast_789',
          metadata: StorageMetadataMessage(
            isDeleted: false,
            updatedTimestamp: Int64(1),
            createdTimestamp: Int64(2),
          ),
        );

        var writeStore =
            DatabaseProtoStoreUtils(
              userSubscriptionMessageDescriptor,
              message,
            ).toStore();

        expect(writeStore['field_1'], '123'); // id
        expect(writeStore['field_2'], 'user_456'); // userId
        expect(writeStore['field_3'], 'podcast_789'); // podcastId
        expect(
          (writeStore['field_4'] as DatabaseStoreType)['field_1'],
          false,
        ); // metadata.isDeleted
        expect(
          (writeStore['field_4'] as DatabaseStoreType)['field_2'],
          Int64(1),
        ); // metadata.isDeleted
        expect(
          (writeStore['field_4'] as DatabaseStoreType)['field_3'],
          Int64(2),
        ); // metadata.isDeleted

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
