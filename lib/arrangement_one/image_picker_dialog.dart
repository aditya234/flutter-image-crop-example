import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_image_crop/arrangement_one/image_picker_handler.dart';

class ImagePickerDialog extends StatelessWidget {
  ImagePickerHandler _listener;
  AnimationController _controller;
  BuildContext context;

  ImagePickerDialog(this._listener, this._controller);

  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;

  void initState() {
    _drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  getImage(BuildContext context) {
    if (_controller == null ||
        _drawerDetailsPosition == null ||
        _drawerContentsOpacity == null) {
      return;
    }
    _controller.forward();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => FadeTransition(
            opacity:
                Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: _controller,
              curve: Curves.fastOutSlowIn,
            )),
            child: FadeTransition(
              opacity: ReverseAnimation(_drawerContentsOpacity),
              child: this,
            ),
          ),
    );
  }

  void dispose() {
    _controller.dispose();
  }

  startTime() async {
    var _duration = Duration(milliseconds: 10000);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pop(context);
  }

  dismissDialog() {
    _controller.reverse();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () => _listener.openCamera(),
            child: roundedButton(
                "Camera",
                EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                const Color(0xFF167F67),
                const Color(0xFFFFFFFF)),
          ),
          GestureDetector(
            onTap: () => _listener.openGallery(),
            child: roundedButton(
                "Gallery",
                EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                const Color(0xFF167F67),
                const Color(0xFFFFFFFF)),
          ),
        ],
      ),
    );
  }

  Widget roundedButton(
      String buttonLabel, EdgeInsets margin, Color bgColor, Color textColor) {
    var loginBtn = Container(
      margin: margin,
      padding: EdgeInsets.all(15.0),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(const Radius.circular(100.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: TextStyle(
            color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }
}
