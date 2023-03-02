import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallLike;
  LikeAnimation(
      {required this.child,
      required this.isAnimating,
      this.duration = const Duration(milliseconds: 150),
      this.onEnd,
      this.smallLike = false
      });

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2),
    );
    scale = Tween<double>(begin: 1 ,end: 1.2).animate(controller);
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(widget.isAnimating != oldWidget.isAnimating){
      print("start animation");
      startAnimation();
      print("end animation");
    }
  }

  startAnimation()async{
    if(widget.isAnimating || widget.smallLike ){
      await controller.forward();
      print("await the controller to forward");
      await controller.reverse();
      print("await the controller to reverse");
      await Future.delayed(const Duration(milliseconds: 200,),);
      print("await the delayed to end");

      if(widget.onEnd != null){
        widget.onEnd!();
        print("the onEnd is not null");
      }
    }

  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    print("Dispose the controller");
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
