import 'dart:typed_data';

import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/http.dart';

var mockHttpService = MockHttpService({
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
