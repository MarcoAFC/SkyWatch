import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/video/domain/entities/upload_file.dart';
import 'package:skywatch/app/modules/video/domain/usecase/upload_video.dart';
import 'package:skywatch/app/modules/video/presentation/pages/camera/bloc/video_event.dart';
import 'package:skywatch/app/modules/video/presentation/pages/camera/bloc/video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc(this._usecase) : super(VideoEmptyState()) {
    on<UploadVideoEvent>(
      (event, emit) => _uploadVideo(video: event.video, emit: emit),
    );
  }

  final UploadVideo _usecase;

  Future<void> _uploadVideo(
      {required UploadFile video,
      required Emitter<VideoState> emit}) async {
    try {
      emit(VideoLoadingState());
      var response = await _usecase(video: video);
      if(response){
        emit(VideoSuccessState());
      }
    } on Failure catch (e) {
      emit(VideoFailureState(failure: e));
    } catch (e) {
      emit(VideoFailureState(
          failure: Failure(message: "An error has occurred.")));
    }
  }
}
