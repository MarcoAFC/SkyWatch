import 'package:skywatch/app/modules/video/domain/entities/video.dart';
import 'package:skywatch/app/modules/video/domain/repositories/video_repository.dart';

class GetVideos {
  final VideoRepository repository;

  GetVideos({required this.repository});
  
  Future<List<Video>> call() async {
    return await repository.getVideos();
  }
}
