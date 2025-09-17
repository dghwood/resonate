import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('test redirect in http client', () async {
    var url =
        'https://pdst.fm/e/arttrk.com/p/CRMDA/claritaspod.com/measure/pscrb.fm/rss/p/mgln.ai/e/284/pdrl.fm/b85a46/stitcher.simplecastaudio.com/9aa1e238-cbed-4305-9808-c9228fc6dd4f/episodes/0ba25cc3-528a-41c6-9569-a53ed26bcdb2/audio/128/default.mp3?aid=rss_feed&awCollectionId=9aa1e238-cbed-4305-9808-c9228fc6dd4f&awEpisodeId=0ba25cc3-528a-41c6-9569-a53ed26bcdb2&feed=dxZsm5kX';
    var uri = Uri.parse(url);
    var client = http.Client();
    final request = http.Request('GET', uri);
    request.maxRedirects = 10;
    request.followRedirects = true;

    final response = await client.send(request);
    print(response.statusCode);
    var i = 0;
    await for (var chunk in response.stream) {
      i += 1;
    }
    print('chunks $i');
  });
}
