import 'package:dio/dio.dart';
import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/video/data/adapters/video_adapter.dart';
import 'package:skywatch/app/modules/video/domain/entities/upload_file.dart';
import 'package:skywatch/app/modules/video/domain/entities/video.dart';
import 'package:skywatch/app/modules/video/infra/datasources/video_datasource.dart';

class RemoteVideoDatasource implements VideoDatasource {
  final Dio dio;

  RemoteVideoDatasource({required this.dio});

  @override
  Future<List<Video>> getVideos() async {
    try {
      // TODO: uncomment when api is ready
      // final response = await dio.get('/videos');
      final response = Response(
          requestOptions: RequestOptions(path: "/videos"),
          statusCode: 200,
          data: {"data": videoData});
      if (response.statusCode != 200) {
        throw Failure(
            message: response.statusMessage ??
                "Our server might be unavailable at the moment, please try again later.");
      }
      return response.data?['data']
              ?.map((e) => VideoAdapter.fromJson(e))
              .toList() ??
          [];
    } on DioException catch (e, stackTrace) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Failure(
            message: "Please check your connection.", stackTrace: stackTrace);
      }
      throw Failure(
          message: "An unexpected connection error has ocurred.",
          stackTrace: stackTrace);
    }
  }

  @override
  Future<bool> uploadVideo({required UploadFile file}) async {
    try {
      // TODO: uncomment when api is ready
      //final task = UploadTask(url: '/videos', filename: basename(file.file.path), fields: {"description": file.description  });

      //final response = await FileDownloader().upload(task, onProgress: (progress){
      //alert ui
      //});
      await Future.delayed(const Duration(seconds: 2));
      final response = Response(
          requestOptions: RequestOptions(path: "/videos"),
          statusCode: 200,
          data: true);
      if (response.statusCode != 200) {
        throw Failure(
            message: response.statusMessage ??
                "Our server might be unavailable at the moment, please try again later.");
      }
      return response.data ?? false;
    } on DioException catch (e, stackTrace) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Failure(
            message: "Please check your connection.", stackTrace: stackTrace);
      }
      throw Failure(
          message: "An unexpected connection error has ocurred.",
          stackTrace: stackTrace);
    }
  }
}

const videoData = [
  {
    "thumbnail":
        "https://robedgcumbe.com/wp-content/uploads/2022/01/c59f3614.jpg",
    "url": "https://example.com/video1.mp4",
    "description": "Video 1 Description",
    "author": "Author 1"
  },
  {
    "thumbnail":
        "https://images.foxtv.com/static.fox32chicago.com/www.fox32chicago.com/content/uploads/2023/03/932/524/Rainbow-in-Oak-Forest-by-Shelby-Collins.jpg?ve=1&tl=1",
    "url": "https://example.com/video2.mp4",
    "description": "Video 2 Description",
    "author": "Author 2"
  },
  {
    "thumbnail":
        "https://cdn.vox-cdn.com/uploads/chorus_image/image/63680428/shutterstock_112306580.0.jpg",
    "url": "https://example.com/video3.mp4",
    "description": "Video 3 Description",
    "author": "Author 3"
  },
  {
    "thumbnail":
        "https://cdn.choosechicago.com/uploads/2019/06/skydeck-1800x900.jpg",
    "url": "https://example.com/video4.mp4",
    "description": "Video 4 Description",
    "author": "Author 4"
  }
];
