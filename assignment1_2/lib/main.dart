import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title : 'MyApp',
      theme : ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white,
        ),
        brightness: Brightness.light,
        primaryColor: Colors.black,
      ),
      home: const MyAppBar(),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            '대치 2동 ', 
            style: TextStyle(
              color: Colors.black,
              fontSize: 25.0, 
              fontWeight: FontWeight.bold,
            ),
          ),
        centerTitle: false,
        elevation : 1,
        actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              color: Colors.black,
              iconSize: 30,
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.black,
              iconSize: 30,
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.add_alert_outlined),
              color: Colors.black,
              iconSize: 30,
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ],
      ),
      body: ListView(
      padding: const EdgeInsets.all(8),
      children: <Item>[
        Item(
          thumbnail : Container(
            decoration: const BoxDecoration(color: Colors.red),
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50)
          ),
          title: 'jBL. 사운드바',
          region: '역삼동',
          regdata: '끌올 1분전',
          price: 145000,
          likes: 6,
        ),
        Item(
          thumbnail : Container(
            decoration: const BoxDecoration(color: Colors.blue),
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50)
          ),
          title: '샤넬 캐비어 블랙 클래식 폰홀더',
          region: '강남구 논현동',
          regdata: '57초전',
          price: 2980000,
          likes: 0,

        ),
      ],
    ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color : Colors.black),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work_outlined, color : Colors.black) ,
            label: '동네생활',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place_outlined, color : Colors.black),
            label: '내 근처',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline, color :Colors.black),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined, color : Colors.black),
            label: '나의 당근',
          ),
        ],
        // currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: const TextStyle(color: Colors.black, fontSize: 13),
        showUnselectedLabels: true,
        
        // onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add), 
      ),
    );
  }
}

// ignore: must_be_immutable
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
                  WidgetSpan(child: Icon(Icons.thumb_up_alt_outlined, size : 20)),
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


