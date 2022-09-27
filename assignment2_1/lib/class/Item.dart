import 'package:flutter/material.dart';
import 'ItemDescription.dart';

class Item extends StatelessWidget {
  Widget thumbnail;
  String title;
  String region;
  String regdata;
  int price;
  int likes;
  
  Item({super.key, 
    required this.thumbnail, 
    required this.title, 
    required this.region, 
    required this.regdata, 
    required this.price, 
    required this.likes
    });

   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0,),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: thumbnail,
          ),  
          // ClipRRect로 둥근 썸네일을 만들 수 있음.
          Expanded(
            flex: 2,
            child: ItemDescription(
              title: title,
              region: region, 
              regdata: regdata,
              price: price,
              likes: likes,
            ),
          ),
        ],
      ),
    );
  }
}