import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget{
  const AppBarWidget({
    Key? key,
  }) : super(key: key);



  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.black,
        title: const Text(
            'tren:be ', 
              style: TextStyle(
              color: Colors.black,
              fontSize: 25.0, 
              fontWeight: FontWeight.bold,
            ),
          ),
        centerTitle: false,
        elevation : 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.favorite_outline_outlined),
            color: Colors.black,
            iconSize: 30,
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            color: Colors.black,
            iconSize: 30,
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
    );
  }
}
