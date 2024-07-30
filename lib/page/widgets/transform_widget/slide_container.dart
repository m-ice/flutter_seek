import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:flutter_d0601/enum/slide_direction.dart';
/// Container that can be slid.
///
/// Will automatically finish the slide animation when the drag gesture ends.
class SlideContainer extends StatefulWidget {
  final Widget? child;
  final double slideDistance;

  final double? rotateRate;

  final Duration? reShowDuration;

  final double? minAutoSlideDragVelocity;

  final VoidCallback? onSlideStarted;

  final VoidCallback? onSlideCompleted;

  final VoidCallback? onSlideCanceled;

  final SlideChanged<double, SlideDirection>? onSlide;

  const SlideContainer({
    Key? key,
    required this.child,
    required this.slideDistance,
    this.rotateRate = 0.25,
    this.minAutoSlideDragVelocity = 600.0,
    this.reShowDuration,
    this.onSlideStarted,
    this.onSlideCompleted,
    this.onSlideCanceled,
    this.onSlide,
  })  : assert(child != null),
        assert(rotateRate != null),
        assert(minAutoSlideDragVelocity != null),
        assert(reShowDuration != null),
        super(key: key);

  @override
  ContainerState createState() => ContainerState();
}

class ContainerState extends State<SlideContainer>
    with TickerProviderStateMixin {
  final Map<Type, GestureRecognizerFactory> gestures =
  <Type, GestureRecognizerFactory>{};

  //RestartableTimer
  RestartableTimer? timer;

  // User's finger move value.
  double dragValue = 0.0;

  // How long should the container move.
  double dragTarget = 0.0;
  bool? isFirstDragFrame;
  AnimationController? animationController;
  Ticker? fingerTicker;

  double get maxDragDistance => widget.slideDistance;

  double get minAutoSlideDistance => maxDragDistance * 0.5;

  // The translation offset of the container.(decides the position of the container)
  double get containerOffset =>
      animationController!.value *
          maxDragDistance *
          (1.0 + (widget.rotateRate??1)) *
          dragTarget.sign;

  set containerOffset(double value) {
    containerOffset = value;
  }

  @override
  void initState() {
    animationController =
    AnimationController(vsync: this, duration: widget.reShowDuration)
      ..addListener(() {
        if (widget.onSlide != null) {
          widget.onSlide?.call(animationController!.value, slideDirection);
        }
        setState(() {});
      });

    fingerTicker = createTicker((_) {
      if ((dragValue - dragTarget).abs() <= 1.0) {
        dragTarget = dragValue;
      } else {
        dragTarget += (dragValue - dragTarget);
      }
      animationController!.value = dragTarget.abs() / maxDragDistance;
    });

    _registerGestureRecognizer();

    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    fingerTicker?.dispose();
    timer?.cancel();
    super.dispose();
  }

  GestureRecognizerFactoryWithHandlers<T>
  createGestureRecognizer<T extends DragGestureRecognizer>(
      GestureRecognizerFactoryConstructor<T> constructor) =>
      GestureRecognizerFactoryWithHandlers<T>(
        constructor,
            (T instance) {
          instance
            ..onStart = handleDragStart
            ..onUpdate = handleDragUpdate
            ..onEnd = handleDragEnd;
        },
      );

  void _registerGestureRecognizer() {
    gestures[HorizontalDragGestureRecognizer] =
        createGestureRecognizer<HorizontalDragGestureRecognizer>(
                () => HorizontalDragGestureRecognizer());
  }

  double getVelocity(DragEndDetails details) =>
      details.velocity.pixelsPerSecond.dx;

  double getDelta(DragUpdateDetails details) => details.delta.dx;

  void reShow() {
    setState(() {
      animationController!.value = 0.0;
    });
  }

  void _startTimer() {
    if (timer == null) {
      timer = RestartableTimer(widget.reShowDuration??const Duration(milliseconds: 1000), reShow);
    } else {
      timer?.reset();
    }
  }

  void _completeSlide() => animationController?.forward().then((_) {
    if (widget.onSlideCompleted != null) widget.onSlideCompleted?.call();
    print("执行了1");
    _startTimer();
  });

  void _cancelSlide() => animationController?.reverse().then((_) {
    if (widget.onSlideCanceled != null) widget.onSlideCanceled?.call();
  });

  void handleDragStart(DragStartDetails details) {
    isFirstDragFrame = true;
    dragValue = animationController!.value * maxDragDistance * dragTarget.sign;
    dragTarget = dragValue;
    fingerTicker?.start();
    if (widget.onSlideStarted != null) widget.onSlideStarted?.call();
  }

  void handleDragUpdate(DragUpdateDetails details) {
    if (isFirstDragFrame??false) {
      isFirstDragFrame = false;
      return;
    }
    dragValue = (dragValue + getDelta(details))
        .clamp(-maxDragDistance, maxDragDistance);

    if (slideDirection == SlideDirection.left) {
      dragValue = dragValue.clamp(-maxDragDistance, 0.0);
    } else if (slideDirection == SlideDirection.right) {
      dragValue = dragValue.clamp(0.0, maxDragDistance);
    }
  }

  void handleDragEnd(DragEndDetails details) {
    if (getVelocity(details) * dragTarget.sign >
        (widget.minAutoSlideDragVelocity??0)) {
      _completeSlide();
    } else if (getVelocity(details) * dragTarget.sign <
        -(widget.minAutoSlideDragVelocity??0)) {
      _cancelSlide();
    } else {
      dragTarget.abs() > minAutoSlideDistance
          ? _completeSlide()
          : _cancelSlide();
    }
    fingerTicker?.stop();
  }

  SlideDirection get slideDirection =>
      dragValue.isNegative ? SlideDirection.left : SlideDirection.right;

  double get rotation => animationController!.value * (widget.rotateRate??0);

  Matrix4 get transformMatrix => slideDirection == SlideDirection.left
      ? (Matrix4.rotationZ(rotation)..invertRotation())
      : (Matrix4.rotationZ(rotation));

  Widget _getContainer() {
    return Transform(
      transform: transformMatrix,
      alignment: FractionalOffset.center,
      child: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) => RawGestureDetector(
    gestures: gestures,
    child: Transform.translate(
      offset: Offset(
        containerOffset,
        0.0,
      ),
      child: _getContainer(),
    ),
  );
}





typedef SlideChanged<double, SlideDirection> = void Function(
    double value, SlideDirection value2);

