import 'package:skywatch/app/modules/video/domain/entities/upload_file.dart';

abstract interface class VideoEvent{}

class UploadVideoEvent implements VideoEvent{
  final UploadFile video;
  UploadVideoEvent({required this.video});

}