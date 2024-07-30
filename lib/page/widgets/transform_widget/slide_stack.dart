import 'package:flutter/material.dart';
import 'package:flutter_d0601/page/widgets/transform_widget/slide_container.dart';

import '../../../enum/slide_direction.dart';


class SlideStack extends StatefulWidget {
  /// The main widget.
  final Widget? child;

  /// The widget hidden below.
  final Widget? below;

  final double slideDistance;

  final double rotateRate;
  final double scaleRate;

  final Duration? scaleDuration;

  /// If the drag gesture is fast enough, it will auto complete the slide.
  final double? minAutoSlideDragVelocity;

  /// Called when the drawer starts to open.
  final VoidCallback? onSlideStarted;

  /// Called when the drawer is full opened.
  final VoidCallback? onSlideCompleted;

  /// Called when the drag gesture is canceled (the container goes back to the starting position).
  final VoidCallback? onSlideCanceled;

  final VoidCallback? refreshBelow;

  /// Called each time when the slide gesture is active.
  ///
  /// returns the position of the drawer between 0.0 and 1.0 (depends on the progress of animation).
  ///

  final SlideChanged<double, SlideDirection>? onSlide;

  const SlideStack({
    Key? key,
    required this.child,
    this.below,
    required this.slideDistance,
    this.rotateRate = 0.25,
    this.scaleRate = 1.08,
    this.scaleDuration = const Duration(milliseconds: 250),
    this.minAutoSlideDragVelocity = 600.0,
    this.onSlideStarted,
    this.onSlideCompleted,
    this.onSlideCanceled,
    this.onSlide,
    this.refreshBelow,
  })  : assert(child != null),
        assert(minAutoSlideDragVelocity != null),
        assert(scaleDuration != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _StackState();
}

class _StackState extends State<SlideStack> with TickerProviderStateMixin {
  double position = 0.0;
  double elevation = 0.0;
  AnimationController? controller;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.scaleDuration,
    )..addListener(() {
        setState(() {
          // if(controller?.value==1.0){
          //   controller?.value=0.0;
          //   if (widget.refreshBelow != null) widget.refreshBelow?.call();
          // }
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
            controller!
                .animateTo(0.0, duration: widget.scaleDuration)
                .whenCompleteOrCancel(() {
              elevation = 0.0;
              if (widget.refreshBelow != null) widget.refreshBelow?.call();
              try{
                setState(() {});
              }catch(e){
                debugPrint(e.toString());
              }
                  // if(elevation==1){
                  //
                  // }
            });
        }
      });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void onSlide(value, direction) {
    if (widget.onSlide != null) widget.onSlide?.call(value, direction);
    controller!.value = value;
    setState(() {});
  }

  void onSlideStarted() {
    if (widget.onSlideStarted != null) widget.onSlideStarted?.call();
    elevation = 1.0;
    setState(() {});
  }

  void onSlideCanceled() {
    if (widget.onSlideCanceled != null) widget.onSlideCanceled?.call();
    elevation = 0.0;
    setState(() {});
  }

  double get scale => 1 + controller!.value * (widget.scaleRate - 1.0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Visibility(
            visible: widget.below!=null,
            child: Transform.scale(
              scale: scale,
              child: widget.below,
            ),
          ),),
        Positioned(
          child: SlideContainer(
            slideDistance: widget.slideDistance,
            rotateRate: widget.rotateRate,
            minAutoSlideDragVelocity: widget.minAutoSlideDragVelocity,
            reShowDuration: widget.scaleDuration,
            onSlideStarted: onSlideStarted,
            onSlideCompleted: widget.onSlideCompleted,
            onSlideCanceled: onSlideCanceled,
            onSlide: onSlide,
            child: widget.child,
          ),),
      ],
    );
  }
}