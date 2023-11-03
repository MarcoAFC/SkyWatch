import 'package:flutter_test/flutter_test.dart';
import 'package:skywatch/app/modules/video/data/adapters/video_adapter.dart';
import 'package:skywatch/app/modules/video/domain/entities/video.dart';

void main(){
  var json = {
    "thumbnail": "https://example.com/thumbnail1.jpg",
    "url": "https://example.com/video1.mp4",
    "description": "Video 1 Description",
    "author": "Author 1"
  };
  group("Video adapter tests", () {
    test("Video adapter correctly parses json", () async {
      var response = VideoAdapter.fromJson(json);
      expect(response, isA<Video>());
      expect(response.author, "Author 1");
      expect(response.description, "Video 1 Description");
      expect(response.url, "https://example.com/video1.mp4");
      expect(response.thumbnail, "https://example.com/thumbnail1.jpg");
    });

  });
}