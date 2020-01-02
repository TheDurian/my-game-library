import 'package:flutter/material.dart';

class AnimatedFloatingActionButton extends StatefulWidget {

   final List<Widget> fabButtons;
   final Color startingAnimationColor;
   final Color endingAnimationColor;
   final AnimatedIconData animatedIconData;

   AnimatedFloatingActionButton(
     {Key key,
     this.fabButtons,
     this.startingAnimationColor,
     this.endingAnimationColor,
     this.animatedIconData})
     : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedFloatingActionButtonState();
}

class _AnimatedFloatingActionButtonState extends State<AnimatedFloatingActionButton> with SingleTickerProviderStateMixin{

  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  // Animation<double> _fabElevation;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: 500)
    )..addListener(() {
      setState(() {
      });
    });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
      begin: widget.startingAnimationColor,
      end: widget.endingAnimationColor
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve
      )
    ));
    // _fabElevation = Tween<double>(
    //   begin: 0,
    //   end: 6
    // ).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: _animateColor.value,
      onPressed: animate,
      tooltip: 'Toggle',
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
      ),
    );
  }

  List<Widget> _buildFABs() {
    List<Widget> list = new List();
    for(var i = widget.fabButtons.length-1; i >= 0;i--) {
      list.add(
        Transform(
          transform: Matrix4.translationValues(0.0, _translateButton.value*(i+1), 0.0),
          child: Container(
            child: widget.fabButtons[i],
          ),
        )
      );
    }
    list.add(toggle());
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: _buildFABs(),
    );
  }
  
}