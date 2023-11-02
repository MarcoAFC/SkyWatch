import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPageController{
  late CameraController controller;
  Future<void>? controllerInitializer;
  double cameraHorizontalPosition = 0;
  
  ValueNotifier<XFile?> video = ValueNotifier(null);

  Future<CameraDescription?> getCamera() async {
    final c = await availableCameras();
    if (c.isEmpty) {
      return null;
    }
    return c.first;
  }

}