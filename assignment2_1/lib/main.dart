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


class StatefulBottomWidget extends StatefulWidget {
  const StatefulBottomWidget({super.key});

  @override
  State<StatefulBottomWidget> createState() => _StatefulBottomWidgetState();
}


class _StatefulBottomWidgetState extends State<StatefulBottomWidget> {
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



class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'tren:be ', 
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
      ),
      body : 
            const TextField(
              decoration : InputDecoration(
                fillColor: Colors.grey,
                hintText : "트렌비X삼성전자 최대 20% 쿠폰!",
                border : OutlineInputBorder(),
              )
            ),
          
      // body: ListView(
      //   padding: const EdgeInsets.all(8),
      //   children: <Item>[
      //     Item(
      //       thumbnail : Container(
      //         decoration: const BoxDecoration(color: Colors.red),
      //         padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50)
      //       ),
      //       title: 'jBL. 사운드바',
      //       region: '역삼동',
      //       regdata: '끌올 1분전',
      //       price: 145000,
      //       likes: 6,
      //     ),
      //     Item(
      //       thumbnail : Container(
      //         decoration: const BoxDecoration(color: Colors.blue),
      //         padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50)
      //       ),
      //       title: '샤넬 캐비어 블랙 클래식 폰홀더',
      //       region: '강남구 논현동',
      //       regdata: '57초전',
      //       price: 2980000,
      //       likes: 0,

      //     ),
      //   ],
      // ),
      bottomNavigationBar: StatefulBottomWidget(),  
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


