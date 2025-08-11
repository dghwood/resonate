import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/http.dart';

var mockHttpService = MockHttpService({
  '/api/login/request': Uint8List.fromList(
    LoginRequestMessage_Response(
      responseInfo: ResponseInfo(success: true),
    ).writeToBuffer(),
  ),
  '/api/login': Uint8List.fromList(
    LoginUserMessage_Response(
      responseInfo: ResponseInfo(success: true),
      user: UserMessage(
        id: '123',
        name: 'Test User',
        email: 'example@example.com',
      ),
      refreshToken: TokenMessage(token: 'mock-refresh-token'),
      accessToken: TokenMessage(
        token: 'mock-token',
        expiryUtcTimestamp: Int64(
          DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch,
        ),
      ),
    ).writeToBuffer(),
  ),
  '/api/user/get': Uint8List.fromList(
    GetUserMessage_Response(
      responseInfo: ResponseInfo(success: true),
      user: UserMessage(
        id: '123',
        name: 'Test User',
        email: 'example@example.com',
      ),
    ).writeToBuffer(),
  ),
});
