import 'dart:async';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
//import 'package:custom_toast/toast_animation.dart';
import 'package:flutter/material.dart';

class ToastUtils {
  static Timer toastTimer;
  static OverlayEntry _overlayEntry;

  static void showCustomToast(BuildContext context, String message) {
    if (toastTimer == null || !toastTimer.isActive) {
      _overlayEntry = createOverlayEntry(context, message);
      Overlay.of(context).insert(_overlayEntry);
      toastTimer = Timer(Duration(seconds: 20), () {
        if (_overlayEntry != null) {
          _overlayEntry.remove();
        }
      });
    }
  }

  static OverlayEntry createOverlayEntry(BuildContext context, String message) {
    return OverlayEntry(
        builder: (context) => Positioned(
              top: MediaQuery.of(context).size.height - 70,
              width: MediaQuery.of(context).size.width - 20,
              left: 10,
              child: ToastMessageAnimation(Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(45, 55, 72, 0.9),
                      borderRadius: BorderRadius.circular(6)),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      message,
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              )),
            ));
  }
}

class ToastMessageAnimation extends StatelessWidget {
  final Widget child;

  ToastMessageAnimation(this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("translateY")
          .add(
            Duration(milliseconds: 250),
            Tween(begin: -100.0, end: 0.0),
            curve: Curves.easeOut,
          )
          .add(Duration(seconds: 1, milliseconds: 250),
              Tween(begin: 0.0, end: 0.0))
          .add(Duration(milliseconds: 250), Tween(begin: 0.0, end: -100.0),
              curve: Curves.easeIn),
      Track("opacity")
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0))
          .add(Duration(seconds: 1), Tween(begin: 1.0, end: 1.0))
          .add(Duration(milliseconds: 500), Tween(begin: 1.0, end: 0.0)),
    ]);

    return ControlledAnimation(
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]), child: child),
      ),
    );
  }
}
