import 'package:flutter/gestures.dart';

typedef MultiTouchGestureRecognizerCallback = void Function(
    bool correctNumberOfTouches);

class MultiTouchGestureRecognizer extends MultiTapGestureRecognizer {
  MultiTouchGestureRecognizer() {
    super.onTapDown = (pointer, details) => this.addTouch(pointer);
    super.onTapUp = (pointer, details) => this.removeTouch(pointer);
    super.onTapCancel = (pointer) => this.removeTouch(pointer);
    super.onTap = (pointer) => this.captureDefaultTap(pointer);
  }

  late MultiTouchGestureRecognizerCallback onMultiTap;
  var numberOfTouches = 0;
  int minNumberOfTouches = 0;

  void addTouch(int pointer) {
    this.numberOfTouches++;
  }

  void removeTouch(int pointer) {
    if (this.numberOfTouches == this.minNumberOfTouches) {
      this.onMultiTap(true);
    } else if (this.numberOfTouches != 0) {
      this.onMultiTap(false);
    }

    this.numberOfTouches = 0;
  }

  void captureDefaultTap(int pointer) {}

  @override
  set onTapDown(_onTapDown) {}

  @override
  set onTapUp(_onTapUp) {}

  @override
  set onTapCancel(_onTapCancel) {}

  @override
  set onTap(_onTap) {}
}
