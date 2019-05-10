import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_crop/arrangement_one/image_picker_handler.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with TickerProviderStateMixin, ImagePickerListener {
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePickerHandler;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePickerHandler = ImagePickerHandler(this, _controller);
    imagePickerHandler.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Image Picker and Cropper',
        ),
      ),
      body: GestureDetector(
        onTap: () {
          imagePickerHandler.showDialog(context);
        },
        child: Center(
          child: (_image == null)
              ? Card(
                  child: Container(
                    height: 200,
                    width: 130,
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: Container(
                    height: 200,
                    width: 130,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage(_image.path),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.black54, width: 1.0),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

//
  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}
