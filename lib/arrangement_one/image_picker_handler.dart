import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_crop/arrangement_one/image_picker_dialog.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHandler {
  ImagePickerDialog imagePickerDialog;
  AnimationController _controller;
  ImagePickerListener _listener;

  ImagePickerHandler(this._listener, this._controller);

  openCamera() async {
    imagePickerDialog.dismissDialog();
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    cropImage(image);
  }

  openGallery() async {
    imagePickerDialog.dismissDialog();
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    cropImage(image);
  }

  void init() {
    imagePickerDialog = ImagePickerDialog(this, _controller);
    imagePickerDialog.initState();
  }

  Future cropImage(File image) async {
    //Cropping image in size 1024x1024 since 1MB == 1024KB
    //Just making a wild guess while cropping
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        ratioX: 1.0,
        ratioY: 1.0,
        maxWidth: 1024,
        maxHeight: 1024,
//        statusBarColor: Colors.pink,
//        toolbarWidgetColor: Colors.pinkAccent,
//        toolbarColor: Colors.pinkAccent,
        toolbarTitle: 'Edit your Profile pic');
    _listener.userImage(croppedFile);
  }

  showDialog(BuildContext context) {
    imagePickerDialog.getImage(context);
  }
}

abstract class ImagePickerListener {
  userImage(File _image);
}
