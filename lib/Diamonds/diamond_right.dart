import 'package:flutter/material.dart';

class DiamondRight extends StatefulWidget {
  
  final AnimationController animationController;

  DiamondRight(this.animationController);
  
  @override
  _DiamondRightState createState() => _DiamondRightState();
}

class _DiamondRightState extends State<DiamondRight> {
  
  Animation offset;
  Animation rotation;

  @override
  void initState() {
    offset = Tween<double>(begin: 0.212, end: 0.0).animate(widget.animationController);
    rotation = Tween<double>(begin: 45.0, end: 0.0).animate(widget.animationController);
    widget.animationController.addListener((){
      if(this.mounted)
        setState((){});
    });
    super.initState();
  }

  void turnToWindow(){
    if(widget.animationController.value == 0.0){
      widget.animationController.forward();
    }else if(widget.animationController.value == 1.0){
      widget.animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Transform.translate(
      offset: Offset(size.width * offset.value, 0.0),
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(rotation.value/360),
        child: widget.animationController.value>=0.98 ? 
          Scaffold(
            appBar: AppBar(
              title: Text("Green", style: TextStyle(color: Colors.green)), 
              centerTitle: true, 
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.green),
                onPressed: () { turnToWindow(); },
              ),
            ),
            body: Container(color: Colors.green),
          ) : 
          GestureDetector(
            child: Container(
              width: Tween<double>(begin: size.width * 0.3, end: size.width).animate(widget.animationController).value,
              height: Tween<double>(begin: size.width * 0.3, end: size.height).animate(widget.animationController).value,
              color: Colors.green,
            ),
            onTap: (){ 
              if(widget.animationController.value==0.0)
                turnToWindow();
            },
          ),
      ),
    );
  }
}