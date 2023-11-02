import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/video/domain/entities/upload_file.dart';
import 'package:skywatch/app/modules/video/domain/entities/video.dart';
import 'package:skywatch/app/modules/video/domain/repositories/video_repository.dart';
import 'package:skywatch/app/modules/video/infra/datasources/video_datasource.dart';

class VideoRepositoryImpl implements VideoRepository{
  final VideoDatasource datasource;

  VideoRepositoryImpl({required this.datasource});
  @override
  Future<List<Video>> getVideos() async {
    try {
      return await datasource.getVideos();
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw Failure(
          message: 'An unexpected error has ocurred, please try again later',
          stackTrace: stackTrace);
    }
  }

  @override
  Future<bool> uploadVideo({required UploadFile file}) async {
    try {
      return await datasource.uploadVideo(file: file);
    } on Failure {
      rethrow;
    } catch (error, stackTrace) {
      throw Failure(
          message: 'An unexpected error has ocurred, please try again later',
          stackTrace: stackTrace);
    }
  }

}