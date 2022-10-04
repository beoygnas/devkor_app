import 'package:flutter/material.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({
    Key? key,
    required this.tab,
    required this.changetab

  }) : super(key: key);

  final tab;
  final changetab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      onTap:(i){
        // setState((){tab = i;});
        changetab(i);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined) ,
          label: '이벤트',
        ),
      ],
    );
  }
}