import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/video/domain/entities/upload_file.dart';
import 'package:skywatch/app/modules/video/domain/repositories/video_repository.dart';

class UploadVideo{
  final VideoRepository repository;

  UploadVideo({required this.repository});

  Future<bool> call({required UploadFile video}) async {
    if(video.file.path.isEmpty){
      throw Failure(message: "Invalid file.");
    }

    return await repository.uploadVideo(file: video);
  }
}