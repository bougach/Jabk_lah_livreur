import 'package:flutter/material.dart';
class Background extends StatelessWidget {
  final Widget child;
  const Background({
    super.key,
    required this.child
  });


  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        children: [
          Positioned(child: Image.asset("assets/imgs/main_top.png"),
            top: 0,
            left: 0,
            width: size.width*0.35,
          ), Positioned(child: Image.asset("assets/imgs/login_bottom.png"),
            bottom: 0,
            right: 0,
            width: size.width*0.45,
          ),
          child,
        ],
      ),

    );
  }
}