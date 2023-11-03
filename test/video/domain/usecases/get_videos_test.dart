import 'package:skywatch/app/core/errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skywatch/app/modules/video/data/adapters/video_adapter.dart';
import 'package:skywatch/app/modules/video/domain/entities/video.dart';
import 'package:skywatch/app/modules/video/domain/repositories/video_repository.dart';
import 'package:skywatch/app/modules/video/domain/usecase/get_videos.dart';



class MockVideoRepository extends Mock implements VideoRepository {}

void main() {
  VideoRepository repository = MockVideoRepository();
  GetVideos usecase =
      GetVideos(repository: repository);
  var video = VideoAdapter.fromJson({
    "thumbnail": "https://example.com/thumbnail1.jpg",
    "url": "https://example.com/video1.mp4",
    "description": "Video 1 Description",
    "author": "Author 1"
  });
  group("Get videos usecase tests", () {
    test("get Video returns valid response", () async {
      when(() => repository.getVideos())
          .thenAnswer((invocation) async => [video]);
      var response = await usecase();
      expect(response, isA<List<Video>>());
    });

    test("get Video rethrows failure", () async {
      when(() => repository.getVideos())
          .thenThrow(Failure(message: 'An unexpected error has ocurred, please try again later'));
      try {
        await usecase();
      } on Failure catch (e) {
        expect(e, isA<Failure>());
        expect(e.message, "An unexpected error has ocurred, please try again later");
      }
    });

    });
}
