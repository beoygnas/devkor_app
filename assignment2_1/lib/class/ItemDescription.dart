import 'package:flutter/material.dart';

class ItemDescription extends StatelessWidget {
  const ItemDescription(
    {super.key, 
    required this.title, 
    required this.region, 
    required this.regdata, 
    required this.price, 
    required this.likes
  });

  final String title;
  final String region;
  final String regdata;
  final int price;
  final int likes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.5)),
          Text(
            '$region, $regdata',
            style: const TextStyle(
              fontSize: 10.0,
              color: Colors.black45
              ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.5)),
          Text(
            '$price원',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
          ),
          SizedBox(
            width : 300,
            child : Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(child: Icon(Icons.favorite, size : 20)),
                  TextSpan(text: '$likes'),
                ],
              ),
              textAlign: TextAlign.right  ,
              style : TextStyle(fontSize : 15.0)
            )
          ),
        ],
      ),
    );
  }
}

