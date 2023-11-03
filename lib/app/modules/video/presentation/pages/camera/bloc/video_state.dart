import 'package:skywatch/app/core/errors/failure.dart';

abstract interface class VideoState {}

class VideoSuccessState extends VideoState{
  VideoSuccessState();
}

class VideoFailureState extends VideoState{
  final Failure failure;

  VideoFailureState({required this.failure});
}

class VideoLoadingState extends VideoState{}
class VideoEmptyState extends VideoState{}
