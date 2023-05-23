import 'package:flutter/material.dart';
import '../abstracts/time.dart';

class Activity extends StatefulWidget {

  final String media;
  final String avatar;
  final String userName;
  final int time;
  final String status;
  const Activity({
    this.media = '',
    this.avatar = '',
    this.userName ='',
    this.time = 0,
    this.status =''
    });

  @override
  State<Activity> createState() => _Activity();
}

class _Activity extends State<Activity> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0,15, 24),
      height: 125,
      decoration: BoxDecoration(
      color: const Color.fromRGBO(241,250,250,1),
      borderRadius: BorderRadius.circular(8),
     ),
      child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Row(
      children: <Widget>[
      Flexible(
      flex: 2,
      child: Container(
      decoration:BoxDecoration(
      image: DecorationImage(
      fit: BoxFit.fill,
      image: NetworkImage(widget.media),
      )
      ) 
      ),
      ), 
      Expanded(
      flex: 6,
      child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
      height: double.infinity,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
      Row(
      children: <Widget>[
      Container(
      width: 100,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
      children: <Widget>[
      Expanded(
      flex: 2,
      child: Text(
      widget.userName,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      softWrap: false,
      ),),
      Expanded(
      flex: 1,
      child: Image(
      image: NetworkImage(widget.avatar),
      width: 40,
      height: 40,
      )
      ),
      ],
      ),
      ),
      Text(readTImeStamp(widget.time))
      ],),
      //resultRequest["text"] != null? Text(resultRequest["text"]): 
      Expanded(
        child: Text(
        style: const TextStyle(
        fontSize: 12,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        softWrap: false,
        widget.status),
      ) 
      ]
              ),
      ),
      )),

],
),
),
);
  }
}