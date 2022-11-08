import 'package:flutter/material.dart';
import 'style/appbarStyle.dart' as appbarstyle;
import 'widget/BottomWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart'; //스크롤 높이와 관련 함수 사용가능

void main() {
  runApp(
    MaterialApp(
      theme : appbarstyle.appbartheme, 
      initialRoute: '/',
      // routes: {
      //   '/' : (c) => Text('첫페이지'),
      //   '/detail' : (c) => Text('둘째페이지')
      // },
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
  var scrolldown = false;
  var data = [];
  
  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    if(result.statusCode == 200){
      //예외처리
    }
    else{

    }
    var result2 = jsonDecode(result.body);
  
    setState(() {
      data = result2;
    });  
  }

  void initState(){
    super.initState();
    getData();
  }

  void scrollDown(){
    setState((){
      scrolldown = true;
    });
  }

  void scrollUp(){
    setState((){
      scrolldown = false;
    });
  }

  void changetab(int a){
    setState(() {
      tab = a;
    });
  }

  // List<Board> data = <Board>[
  //   Board(
  //     img : Image.asset('assets/images/square.jpg', fit : BoxFit.fitWidth),
  //     writer : "김상엽",
  //     content : "안녕",
  //     likes: 10,
  //   ),
  //   Board(
  //     img : Image.asset('assets/images/square.jpg'),
  //     writer : "김상엽",
  //     content : "안녕",
  //     likes: 11,  
  //   ),
  //   Board(
  //     img : Image.asset('assets/images/square.jpg'),
  //     writer : "김상엽",
  //     content : "안녕",
  //     likes: 12,
  //   ),
  // ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        centerTitle: false,
        title: Text("Instagram"),
        actions : [IconButton(
          icon: Icon(Icons.add_box_outlined),
          onPressed: (){
            Navigator.push(context, 
              MaterialPageRoute(builder :(c) => Upload())
            );
          },
          iconSize: 30)
        ]
      ),
      body : 
        [Home(data: data, scrollDown : scrollDown, scrollUp: scrollUp), Text('샵페이지')][tab],
      // Column(
      //   children: [
      //     [Text('홈페이지'), Text('샵페이지')][tab],
          
      // ]),
      bottomNavigationBar : !scrolldown ? BottomWidget(tab: tab, changetab : changetab) : null 
      
      // ((){
      //   if(scrolldown) return BottomWidget(tab: tab, changetab : changetab);
      //   }())
      
      
    );
  }
}

class Home extends StatefulWidget {
  Home({
    Key? key,
    required this.data,
    required this.scrollDown,
    required this.scrollUp,
  }) : super(key: key);

  final data;
  final scrollDown;
  final scrollUp;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var scroll = ScrollController();

//밑으로 스크롤바도 해보기

  @override
  void initState(){
    super.initState();
    scroll.addListener(() async { 
      if(scroll.position.pixels == scroll.position.maxScrollExtent){
        var result = await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
        
        setState(() {
          widget.data.add(jsonDecode(result.body));  
        });
        
        print(jsonDecode(result.body));
        print(widget.data);
      }
      if(scroll.position.userScrollDirection == ScrollDirection.reverse){
        widget.scrollDown();
      }
      else{
        widget.scrollUp();
      }
      
    });
  }
  @override
  Widget build(BuildContext context) {
    
    print(widget.data);
    if(widget.data.isNotEmpty){
      return ListView.builder(
      controller: scroll,
      padding: const EdgeInsets.all(0),
      itemCount : widget.data.length,
      itemBuilder: (c, i){
      
        return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: 
          Column(
            children: [
            SizedBox(
              width : MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child : Image.network(widget.data[i]['image'])
            ),
            DefaultTextStyle(
              child: Container(
                alignment: Alignment(-1.0, 1.0),
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("좋아요${widget.data[i]['likes']}", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(widget.data[i]['user']),
                    Text(widget.data[i]['content'])],
                ), 
              ),
              style : TextStyle(color : Colors.black)
            ),
          ],
        )
      );
        }
      );
    }
    else{
      return Text('로딩중임');
    }
  }
}


class Upload extends StatelessWidget{
  const Upload({Key? key}):super(key : key);

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar : AppBar(),
      body : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children : [
          Text("이미지 업로드 화면"),
          IconButton(
            onPressed : (){
              Navigator.pop(context);
            },
            icon : Icon(Icons.close)
          )
        ],
        )
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