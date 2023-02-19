import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  String no;
  IconData firstIcon;
  IconData lastIcon;
   CustomListTile({Key? key,required this.firstIcon,required this.lastIcon,required this.no}) : super(key: key);

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Row(
            children: [
              Text(widget.no,style: TextStyle(fontSize: 22),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(widget.firstIcon,size: 35,color: Colors.grey,),
              SizedBox(width: 5,),
              Icon(widget.lastIcon,size: 35,color: Colors.grey,),

            ],
          )

        ],
      ),
    );
  }
}
