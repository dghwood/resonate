import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idb_sqflite/idb_sqflite.dart';
import 'package:resonate/api/user.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/firebase_options.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pbserver.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http.dart';

void main() {
  group('UserApi', () {
    late TestUser user;
    late MockHttpService mockHttpService;
    late DatabaseService mockDatabaseService;
    late UserApi userApi;

    setUp(() async {
      user = TestUser(id: '321');
      mockHttpService = MockHttpService({
        '/api/user/create':
            CreateUserMessage_Response(
              responseInfo: ResponseInfo(success: true),
              user: UserMessage(id: '321', name: 'Test User'),
            ).writeToBuffer(),
      });
      mockDatabaseService = DatabaseService(idbFactoryMemory, user);
      userApi = UserApi(
        httpService: mockHttpService,
        databaseService: mockDatabaseService,
        user: user,
      );
      await mockDatabaseService.init();
    });

    test('should create a user and return it', () async {
      final results = await userApi.create().toList();

      expect(results.length, 1);
      var result = results[0];
      switch (result) {
        case ApiOk():
          expect(result.value.id, '321');
          expect(result.value.name, 'Test User');
        case ApiError():
          fail('Expected ApiOk, got ${result.error}');
      }
    });
  });
}
