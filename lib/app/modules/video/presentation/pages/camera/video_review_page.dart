import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skywatch/app/core/widgets/text/text_title.dart';
import 'package:skywatch/app/modules/video/domain/entities/upload_file.dart';
import 'package:skywatch/app/modules/video/presentation/pages/camera/bloc/video_bloc.dart';
import 'package:skywatch/app/modules/video/presentation/pages/camera/bloc/video_event.dart';
import 'package:skywatch/app/modules/video/presentation/pages/camera/bloc/video_state.dart';
import 'package:skywatch/app/modules/video/presentation/pages/camera/camera_page_controller.dart';
import 'package:video_player/video_player.dart';

class VideoReviewPage extends StatefulWidget {
  const VideoReviewPage(
      {super.key, required this.controller, required this.bloc});
  final CameraPageController controller;
  final VideoBloc bloc;
  @override
  State<VideoReviewPage> createState() => _VideoReviewPageState();
}

class _VideoReviewPageState extends State<VideoReviewPage> {
  late VideoPlayerController videoPlayerController =
      VideoPlayerController.file(File(widget.controller.video.value!.path));
  late StreamSubscription subscription;
  @override
  void initState() {
    super.initState();
    videoPlayerController.initialize().then((value) => setState(() {
          videoPlayerController.setLooping(true);

          videoPlayerController.play();
        }));
    subscription = widget.bloc.stream.listen((state) {
      if (state is VideoLoadingState) {
        showModalBottomSheet(
          backgroundColor: Colors.white70,
          isDismissible: false,
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          builder: (context) {
            return const SizedBox(
              height: 128,
              child: SizedBox(
                width: 48,
                height: 48,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      }
      if (state is VideoSuccessState) {
        Navigator.pop(context);
        showModalBottomSheet(
          backgroundColor: Colors.white70,
          isDismissible: false,
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          builder: (context) {
            return const SizedBox(
              height: 128,
              child: SizedBox(
                width: 48,
                height: 48,
                child: Center(
                  child: TextTitle(text: "Video uploaded successfully!"),
                ),
              ),
            );
          },
        );
        Future.delayed(const Duration(seconds: 2)).then((value) =>
            Navigator.popUntil(context, (route) => route.settings.name == '/'));
      }
       if (state is VideoFailureState) {
        Navigator.pop(context);
        showModalBottomSheet(
          backgroundColor: Colors.white70,
          isDismissible: false,
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          builder: (context) {
            return SizedBox(
              height: 128,
              child: SizedBox(
                width: 48,
                height: 48,
                child: Center(
                  child: TextTitle(text: state.failure.message),
                ),
              ),
            );
          },
        );
        Future.delayed(const Duration(seconds: 2)).then((value) =>
            Navigator.popUntil(context, (route) => route.settings.name == '/'));
      }
    });
  }
  @override
  void dispose() {
    subscription.cancel();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                widget.controller.video.value = null;
              },
            ),
          ),
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                child: videoPlayerController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(videoPlayerController),
                      )
                    : Container(),
              ),
              Positioned(
                bottom: 50,
                right: 40,
                left: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        widget.bloc.add(UploadVideoEvent(
                            video: UploadFile(
                                file: File(widget.controller.video.value!.path),
                                description: "description")));
                      },
                      child: const SizedBox(
                        height: 70,
                        width: 70,
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
