import 'package:dio/dio.dart';
import 'package:skywatch/app/modules/video/domain/entities/upload_file.dart';

class UploadFileAdapter {
  static Future<Map<String, dynamic>> toJson(UploadFile file) async {
    return {
      "description": file.description,
      "file": await MultipartFile.fromFile(file.file.path,)
    };
  }
}
