
import 'package:flutter/material.dart';

class BottomWidget extends StatefulWidget {
  const BottomWidget({super.key});
  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  int _idx = 2;
  
  void _onItemTapped(int index){
    setState(() {
      _idx = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
        currentIndex: _idx ,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: '카테고리',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard_outlined) ,
            label: '이벤트',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: '뉴 시즌',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: '나의 마이',
          ),
        ],
      
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: const TextStyle(color: Colors.black, fontSize: 10),
        showUnselectedLabels: true,
        backgroundColor: Colors.green,
        onTap: _onItemTapped,
      );    
  }
}
