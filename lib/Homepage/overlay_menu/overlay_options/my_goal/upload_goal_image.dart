import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../../resources/storage_methods.dart';

class UploadImage{
  Future<String> UploadImageHere({required String path,required String filename,required Uint8List file}) async {
    String photoUrl = await StorageMethods().uploadImageToStorage(path, filename, file);

    return photoUrl;
  }
}