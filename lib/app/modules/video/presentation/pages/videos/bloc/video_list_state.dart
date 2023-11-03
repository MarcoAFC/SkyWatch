import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/video/domain/entities/video.dart';

abstract interface class VideoListState {}

class VideoListSuccessState extends VideoListState {
  final List<Video> videos;
  VideoListSuccessState({required this.videos});
}

class VideoListFailureState extends VideoListState {
  final Failure failure;

  VideoListFailureState({required this.failure});
}

class VideoListLoadingState extends VideoListState {}

class VideoListEmptyState extends VideoListState {}
