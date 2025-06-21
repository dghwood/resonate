import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:resonate/api/user.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/http.dart';

void main() {
  group('CreateUserApi Tests', () {
    late MockHttpService mockHttpService;
    late CreateUserApi createUserApi;

    setUp(() {
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
      createUserApi = CreateUserApi(client: mockHttpService);
    });

    test('should successfully create a user', () async {
      final request = CreateUserApiRequest(CreateUserMessage_Request());
      final response = CreateUserApiResponse(CreateUserMessage_Response());
      await createUserApi.execute(request, response);

      expect(response, isA<CreateUserApiResponse>());
      expect(response.responsePb, isA<CreateUserMessage_Response>());
    });

    test(
      'should throw HttpServiceNotFoundException for invalid endpoint',
      () async {
        mockHttpService.response
            .clear(); // Simulate no response for the endpoint
        final request = CreateUserApiRequest(CreateUserMessage_Request());
        final response = CreateUserApiResponse(CreateUserMessage_Response());
        expect(
          () async => await createUserApi.execute(request, response),
          throwsA(isA<HttpServiceNotFoundException>()),
        );
      },
    );
  });
}
