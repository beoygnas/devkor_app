import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'style/appbarStyle.dart' as appbarstyle;
import 'widget/BottomWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart'; //스크롤 높이와 관련 함수 사용가능
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => StateStore(),
      child: MaterialApp(
        theme : appbarstyle.appbartheme, 
        initialRoute: '/',
        // routes: {
        //   '/' : (c) => Text('첫페이지'),
        //   '/detail' : (c) => Text('둘째페이지')
        // },
        home : MyApp()
      ),
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
  var userImage;  
  var userContent;
  
  saveData() async {

    //서버로부터 가져온 걸 내장메모리에 저장해두면, 더 빠르게 업로드를 할 수 있다.
    var storage = await SharedPreferences.getInstance();
    // storage.setString('name', 'john');  
    // var result = storage.getString('name');
    var map = {'statuscode' : 200};
    storage.setString('map', jsonEncode(map));
    var result = storage.getString('map') ?? 'Nope';
    print(jsonDecode(result)['statuscode']);
  }

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

  addmydata(){
    var mydata = {
      'id' : data.length,
      'image' : userImage,
      'likes' : 0,
      'data' : 'July 25',
      'content' : userContent,
      'liked' : false,
      'user' : 'sangyeob'
    };
    print(mydata);
    setState(() {
      data.insert(0, mydata);
    });

  }

  setUserContent(text){
    setState(() => {
      userContent = text
    }); 
  }

  void initState(){
    super.initState();
    saveData();
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
          onPressed: () async{
            var picker = ImagePicker();
            var image = await picker.pickImage(source: ImageSource.gallery);
            if(image !=  null){
              setState(() {
                userImage = File(image.path);
              });
            }            
            Navigator.push(context, 
              MaterialPageRoute(builder :(c) => Upload(userImage : userImage, data : data, setUserContent: setUserContent, addmydata: addmydata))
            );
          },
          iconSize: 30)
        ]
      ),
      body : 
        [Home(data: data, scrollDown : scrollDown, scrollUp: scrollUp, setUserContent : setUserContent), Text('샵페이지')][tab],
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
    required this.setUserContent,
  }) : super(key: key);

  final data;
  final scrollDown;
  final scrollUp;
  final setUserContent;
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
              child : widget.data[i]['image'].runtimeType == String
                ? Image.network(widget.data[i]['image']) 
                : Image.file(widget.data[i]['image'])
            ),
            DefaultTextStyle(
              style : TextStyle(color : Colors.black),
              child: Container(
                alignment: Alignment(-1.0, 1.0),
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child : Text(
                        widget.data[i]['user'], 
                        style: TextStyle(fontWeight: FontWeight.bold)
                      ),
                      onTap : (){
                        Navigator.push(context, 
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => Profile(),
                            transitionsBuilder: (c, a1, a2, child) => 
                              // FadeTransition(opacity : a1, child : child),
                              SlideTransition(
                                position: Tween(
                                  begin: Offset(1.0, 0.0),
                                  end : Offset(0.0, 0.0),
                                ).animate(a1),
                                child : child 
                              )
                            // transitionDuration: Duration(microseconds: 500)  
                            

                          )
                        );
                      }

                    ),
                    Text("좋아요${widget.data[i]['likes']}", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(widget.data[i]['date']),
                    Text(widget.data[i]['content'])],
                ), 
              ),
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
  const Upload({Key? key, this.userImage, this.data, this.setUserContent, this.addmydata}):super(key : key);
  final userImage;
  final data;
  final setUserContent;
  final addmydata;

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar : AppBar(
        actions : [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () async{
              
              // var post = {};
              // post['id'] = widget.data.length;
              // post['image'] = widget.userImage;
              // post['likes'] = 0;
              // post['date'] = "November 10";
              // post['content'] = "안녕";
              // post['liked'] = false;
              // post['user'] = 'sangyeob';
              // setState(()=>{
              //   widget.data.add(post)
              // });
              print(userImage);
              addmydata();
              Navigator.pop(context);
              
            },
            iconSize: 30
          )
        ]
      ),
      body : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children : [
          Image.file(userImage),
          Text("이미지 업로드 화면"),
          TextField(
            onChanged: (text){
              setUserContent(text);
            },
          ),
          IconButton(
            onPressed : (){
              Navigator.pop(context);
            },
            icon : Icon(Icons.close)
          )
        ],
      ),
      
       
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


class StateStore extends ChangeNotifier{
  var name = 'john kim';
  var followers = 0;
  var followed = false;

  changeName(){
    name = 'john park';
    notifyListeners();
  }
  follow(){
    if(!followed){
      followers = followers + 1;
      followed = true;
    }
    else{
      followers = followers - 1;
      followed = false;
    } 

    notifyListeners();
  }

}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text(context.watch<StateStore>().name)
      ),
      body : Column(
        children: [
          ElevatedButton(
            onPressed: (){
              context.read<StateStore>().changeName();
            }, 
            child: Text('버튼')
          ),
          Text('팔로워 ${context.watch<StateStore>().followers} 명'),
          ElevatedButton(
            onPressed: (){
              context.read<StateStore>().follow();
            }, 
            child: context.watch<StateStore>().followed ? Text('언팔로우') : Text('팔로우')
          )
        ],
      )
    );
  }
}