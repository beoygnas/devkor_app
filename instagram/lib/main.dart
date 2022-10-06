import 'package:flutter/material.dart';
import 'style/appbarStyle.dart' as appbarstyle;
import 'widget/BottomWidget.dart';

void main() {
  runApp(
    MaterialApp(
      theme : appbarstyle.appbartheme,
      home : MyApp()
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var tab = 0;
  void changetab(int a){
    setState(() {
      tab = a;
    });
  }

  List<Board> boards = <Board>[
    Board(
      img : Image.asset('assets/images/square.jpg', fit : BoxFit.fitWidth),
      writer : "김상엽",
      content : "안녕",
      likes: 10,
    ),
    Board(
      img : Image.asset('assets/images/square.jpg'),
      writer : "김상엽",
      content : "안녕",
      likes: 11,
    ),
    Board(
      img : Image.asset('assets/images/square.jpg'),
      writer : "김상엽",
      content : "안녕",
      likes: 12,
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        centerTitle: false,
        title: Text("Instagram"),
        actions : [IconButton(
          icon: Icon(Icons.add_box_outlined),
          onPressed: (){},
          iconSize: 30)
        ]
      ),
      body : 
        ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount : boards.length,
        itemBuilder: (BuildContext context, index){
          return boards[index];
          }
        ),
      // Column(
      //   children: [
      //     [Text('홈페이지'), Text('샵페이지')][tab],
          
      // ]),
      bottomNavigationBar: BottomWidget(tab: tab, changetab : changetab)
    );
  }
}

// ignore: must_be_immutable
class Board extends StatelessWidget {
  
  Image img;
  int likes;
  String writer;
  String content;
  
  Board({super.key, 
    required this.img, 
    required this.writer,
    required this.content, 
    required this.likes
    });

   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: 
        Column(
          children: [
          SizedBox(
            width : MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child : img
          ),
          DefaultTextStyle(
            child: Container(
              alignment: Alignment(-1.0, 1.0),
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("좋아요 100", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("글쓴이"),
                  Text("글내용")],
              ), 
            ),
            style : TextStyle(color : Colors.black)
          ),
        ],
      )
    );
  }
}

  // Theme(   //레이아웃 중간에 ThemeData()를 생성가능.
      //   data : ThemeData(

      //   ),
      //   child: Container()
      // )
      // Text("안녕", style : Theme.of(context).textTheme.bodyText2), //이렇게 하면 theme을 알아서 찾아서 그중에 원하는 style을 사용할 수 있음. 미리 만들어놓고 사용 가능!