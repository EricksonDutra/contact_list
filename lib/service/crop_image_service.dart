import 'package:flutter/material.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:share_plus/share_plus.dart';

class CropImageService{

  static cropImage(XFile imageFile, String imagemPath, Function(XFile) onUpdate) async{
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.indigo,
            toolbarWidgetColor: Colors.white, 
            activeControlsWidgetColor: Colors.indigo,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    // if (croppedFile != null){
    //   await GallerySaver.saveImage(croppedFile.path);
    //   onUpdate(XFile(croppedFile.path));
    // }
  }
}