import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundContainer extends StatefulWidget {
  String title;
  String icon;
   RoundContainer({Key? key,required this.icon,required this.title}) : super(key: key);

  @override
  State<RoundContainer> createState() => _RoundContainerState();
}

class _RoundContainerState extends State<RoundContainer> {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
      width: size.width*0.4,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 20,
              spreadRadius: 5,
            )
          ]

        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(widget.icon,width: 80,height: 80),
          SizedBox(height: 20,),
          Text(widget.title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Color(0xffF5591F)),),

        ],
      ),
    );
  }
}
