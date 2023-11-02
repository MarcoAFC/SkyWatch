import 'package:skywatch/app/modules/video/domain/entities/upload_file.dart';
import 'package:skywatch/app/modules/video/domain/entities/video.dart';

abstract interface class VideoRepository{
  Future<List<Video>> getVideos();

  Future<bool> uploadVideo({required UploadFile file});
}