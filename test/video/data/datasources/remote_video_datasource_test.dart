
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skywatch/app/modules/video/data/datasources/remote_video_datasource.dart';
import 'package:skywatch/app/modules/video/domain/entities/upload_file.dart';
import 'package:skywatch/app/modules/video/domain/entities/video.dart';

void main(){
  // these tests should be improved when responses stop being mocked
  RemoteVideoDatasource datasource = RemoteVideoDatasource(dio: Dio());
  group("Remote Video datasource tests", () {
    test("getForecast returns valid response", () async {
      var response = await datasource.getVideos();

      expect(response, isA<List<Video>>());
      expect(response.length, 3);
    });

    test("uploadVideo returns valid response", () async {
      var response = await datasource.uploadVideo(file: UploadFile(file: File(""), description: ""));

      expect(response, true);
    });
  });
}