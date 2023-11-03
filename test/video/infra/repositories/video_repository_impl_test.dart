import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/video/data/adapters/video_adapter.dart';
import 'package:skywatch/app/modules/video/domain/entities/upload_file.dart';
import 'package:skywatch/app/modules/video/domain/entities/video.dart';
import 'package:skywatch/app/modules/video/infra/datasources/video_datasource.dart';
import 'package:skywatch/app/modules/video/infra/repositories/video_repository_impl.dart';

class MockVideoDatasource extends Mock implements VideoDatasource {}

void main() {
  VideoDatasource datasource = MockVideoDatasource();
  VideoRepositoryImpl repository =
      VideoRepositoryImpl(datasource: datasource);
  var video = VideoAdapter.fromJson({
    "thumbnail": "https://example.com/thumbnail1.jpg",
    "url": "https://example.com/video1.mp4",
    "description": "Video 1 Description",
    "author": "Author 1"
  });

  var file = UploadFile(file: File(""), description: "");

  group("Video repository tests", () {
    test("Video repository get Video returns valid response", () async {
      when(() => datasource.getVideos())
          .thenAnswer((invocation) async => [video]);
      var response = await repository.getVideos();
      expect(response, isA<List<Video>>());
    });

    test("Video repository get Video rethrows failure", () async {
      when(() => datasource.getVideos())
          .thenThrow(Failure(message: 'An unexpected error has ocurred, please try again later'));
      try {
        await repository.getVideos();
      } on Failure catch (e) {
        expect(e, isA<Failure>());
        expect(e.message, "An unexpected error has ocurred, please try again later");
      }
    });

    test("Video repository upload video returns valid response", () async {
      when(() => datasource.uploadVideo(file: file))
          .thenAnswer((invocation) async => true);
      var response = await repository.uploadVideo(file: file);
      expect(response, true);
    });

    test("Video repository upload video rethrows failure", () async {
      when(() => datasource.uploadVideo(file: file))
          .thenThrow(Failure(message: 'An unexpected error has ocurred, please try again later'));
      try {
        await repository.uploadVideo(file: file);
      } on Failure catch (e) {
        expect(e, isA<Failure>());
        expect(e.message, "An unexpected error has ocurred, please try again later");
      }
    });
  });
}
