import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:skywatch/app/modules/app_dependencies.dart';
import 'package:skywatch/app/modules/video/presentation/pages/camera/camera_page_controller.dart';
import 'package:skywatch/app/modules/video/presentation/pages/camera/video_review_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});
  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage>
    with SingleTickerProviderStateMixin {
  final PageController bottomPageController =
      PageController(viewportFraction: .2);
  final CameraPageController controller = CameraPageController();
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..repeat();
  late final Animation<double> _scaleAnimation =
      Tween<double>(begin: 0.6, end: 1.2).animate(animationController);
  late final Animation<double> _fadeAnimation =
      Tween<double>(begin: 1, end: 0.2).animate(animationController);

  @override
  void initState() {
    super.initState();
    animationController.stop();
    controller.getCamera().then((camera) {
      if (camera == null) return;
      setState(() {
        controller.controller = CameraController(
          camera,
          ResolutionPreset.high,
        );
        controller.controllerInitializer = controller.controller.initialize();
        controller.controllerInitializer!.whenComplete(() {
          setState(() {
            controller.cameraHorizontalPosition =
                -(MediaQuery.of(context).size.width *
                        controller.controller.value.aspectRatio) /
                    2;
          });
        });
      });
    });
  }

  @override
  void dispose() {
    controller.controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller.video,
        builder: (context, snapshot, _) {
          if (snapshot != null) {
            return VideoReviewPage(controller: controller, bloc: DependencyHandler().get(),);
          }
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned.fill(
                left: controller.cameraHorizontalPosition,
                right: controller.cameraHorizontalPosition,
                child: FutureBuilder(
                  future: controller.controllerInitializer,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CameraPreview(controller.controller);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              Positioned.fill(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                  ),
                  body: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        bottom: 50,
                        right: 40,
                        left: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                                onLongPressStart: (_) async {
                                  await controller.controller
                                      .startVideoRecording();
                                  animationController.repeat();
                                },
                                onLongPressEnd: (_) async {
                                  animationController.stop();
                                  controller.video.value = await controller
                                      .controller
                                      .stopVideoRecording();
                                },
                                child: Stack(
                                  children: [
                                    FadeTransition(
                                      opacity: _fadeAnimation,
                                      child: ScaleTransition(
                                        scale: _scaleAnimation,
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(35),
                                            ),
                                            border: Border.all(
                                              width: 10,
                                              color:
                                                  Colors.white.withOpacity(.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(25),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }
}
