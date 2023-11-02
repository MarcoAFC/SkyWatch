import 'package:skywatch/app/modules/video/domain/entities/video.dart';

class VideoAdapter {
  static Video fromJson(Map<String, dynamic> json) {
    return Video(
      thumbnail: json['thumbnail'],
      url: json['url'],
      description: json['description'],
      author: json['author'],
    );
  }
}
