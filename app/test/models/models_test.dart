import 'package:flutter_test/flutter_test.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';

void main() {
  group('Podcast Model Tests', () {
    test('toStore should correctly convert Podcast to a Map', () {
      final podcast = Podcast(
        id: '123',
        title: 'Test Podcast',
        description: 'A test podcast description',
        url: 'https://example.com',
        imageUrl: 'https://example.com/image.png',
        author: 'Test Author',
        episodes: [],
      );

      final storeMap = podcast.toStore();

      expect(storeMap['field_1'], '123'); // id
      expect(storeMap['field_2'], 'Test Podcast'); // title
      expect(storeMap['field_3'], 'A test podcast description'); // description
      expect(storeMap['field_4'], 'https://example.com'); // url
      expect(storeMap['field_5'], 'https://example.com/image.png'); // imageUrl
      expect(storeMap['field_6'], 'Test Author'); // author
      expect(storeMap['field_7'], null); // episodes
    });

    test('fromStore should correctly populate Podcast from a Map', () {
      final storeMap = {
        'field_1': '123', // id
        'field_2': 'Test Podcast', // title
        'field_3': 'A test podcast description', // description
        'field_4': 'https://example.com', // url
        'field_5': 'https://example.com/image.png', // imageUrl
        'field_6': 'Test Author', // author
      };

      final podcast = Podcast(id: '123');
      podcast.fromStore(storeMap);

      expect(podcast.id, '123');
      expect(podcast.title, 'Test Podcast');
      expect(podcast.description, 'A test podcast description');
      expect(podcast.url, 'https://example.com');
      expect(podcast.imageUrl, 'https://example.com/image.png');
      expect(podcast.author, 'Test Author');
    });
  });
}
