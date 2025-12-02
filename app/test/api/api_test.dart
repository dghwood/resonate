import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:resonate/api/user.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/http/http.dart';

void main() {
  group('CreateUserApi Tests', () {
    late MockHttpService mockHttpService;
    late CreateUserApi createUserApi;
    late TestUser user;

    setUp(() {
      user = TestUser(id: '123');
      mockHttpService = MockHttpService({
        '/api/user/create': Uint8List.fromList(
          CreateUserMessage_Response(
            responseInfo: ResponseInfo(success: true),
            user: UserMessage(
              id: '123',
              name: 'Test User',
              email: 'example@example.com',
            ),
          ).writeToBuffer(),
        ),
      });
      createUserApi = CreateUserApi(client: mockHttpService, user: user);
    });

    test('should successfully create a user', () async {
      final request = CreateUserApiRequest();
      final response = CreateUserApiResponse();
      await createUserApi.execute(request, response);

      expect(response, isA<CreateUserApiResponse>());
      expect(response.responsePb, isA<CreateUserMessage_Response>());
    });

    test(
      'should throw HttpServiceNotFoundException for invalid endpoint',
      () async {
        mockHttpService.response
            .clear(); // Simulate no response for the endpoint
        final request = CreateUserApiRequest();
        final response = CreateUserApiResponse();
        expect(
          () async => await createUserApi.execute(request, response),
          throwsA(isA<HttpServiceNotFoundException>()),
        );
      },
    );
  });
}
