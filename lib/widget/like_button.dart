import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({Key? key}) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  bool isLike = false;
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _colorAnimation = ColorTween(begin: Colors.grey, end: Colors.pink)
        .animate(_animationController);
    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 30, end: 50), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 50, end: 30), weight: 50),
    ]).animate(_animationController);
    _animationController.addListener(() {
      print(_animationController.value);
      print(_colorAnimation.value);
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isLike = true;
        });
      } else {
        setState(() {
          isLike = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // アニメーションを再生しているときも中央ぞろえにしたいがうまくいかない
      children: [
        AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, _) {
              return IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: _colorAnimation.value,
                  size: _sizeAnimation.value,
                ),
                onPressed: () {
                  isLike
                      ? _animationController.reverse()
                      : _animationController.forward();
                },
              );
            }),
      ],
    );
  }
}
