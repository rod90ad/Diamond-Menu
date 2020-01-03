import 'package:flutter/material.dart';

class DiamondTop extends StatefulWidget {
  
  final AnimationController animationController;

  DiamondTop(this.animationController);
  
  @override
  _DiamondTopState createState() => _DiamondTopState();
}

class _DiamondTopState extends State<DiamondTop> {
  
  Animation offset;
  Animation rotation;

  @override
  void initState() {
    offset = Tween<double>(begin: -0.212, end: 0.0).animate(widget.animationController);
    rotation = Tween<double>(begin: 225.0, end: 0.0).animate(widget.animationController);
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
      offset: Offset(0.0, size.width * offset.value),
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(rotation.value/360),
        child: widget.animationController.value>=0.98 ? 
          Scaffold(
            appBar: AppBar(
              title: Text("Blue", style: TextStyle(color: Colors.blue)), 
              centerTitle: true, 
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.blue),
                onPressed: () { turnToWindow(); },
              ),
            ),
            body: Container(color: Colors.blue),
          ) : 
          GestureDetector(
            child: Container(
              width: Tween<double>(begin: size.width * 0.3, end: size.width).animate(widget.animationController).value,
              height: Tween<double>(begin: size.width * 0.3, end: size.height).animate(widget.animationController).value,
              color: Colors.blue,
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