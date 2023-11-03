import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skywatch/app/core/errors/failure.dart';
import 'package:skywatch/app/modules/video/domain/usecase/get_videos.dart';
import 'package:skywatch/app/modules/video/presentation/pages/videos/bloc/video_list_event.dart';
import 'package:skywatch/app/modules/video/presentation/pages/videos/bloc/video_list_state.dart';

class VideoListBloc extends Bloc<VideoListEvent, VideoListState> {
  VideoListBloc(this._usecase) : super(VideoListEmptyState()) {
    on<GetVideoListEvent>(
      (event, emit) => _getVideoList(emit: emit),
    );
  }

  final GetVideos _usecase;

  Future<void> _getVideoList({required Emitter<VideoListState> emit}) async {
    try {
      emit(VideoListLoadingState());
      var response = await _usecase();
      emit(VideoListSuccessState(videos: response));
    } on Failure catch (e) {
      emit(VideoListFailureState(failure: e));
    } catch (e) {
      emit(VideoListFailureState(
          failure: Failure(message: "An error has occurred.")));
    }
  }
}
