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
      body : Column(children: [
        [Text('홈페이지'), Text('샵페이지')][tab],
        
        Expanded(
         child : Column(
          children: [
              Image.asset('assets/images/trenbe.png'),
              // TextSpan(
              //   children: []
              // )
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
              )
              
          
          ],) 
        )

      ]),
      bottomNavigationBar: BottomWidget(tab: tab, changetab : changetab)
    );
  }
}


  // Theme(   //레이아웃 중간에 ThemeData()를 생성가능.
      //   data : ThemeData(

      //   ),
      //   child: Container()
      // )
      // Text("안녕", style : Theme.of(context).textTheme.bodyText2), //이렇게 하면 theme을 알아서 찾아서 그중에 원하는 style을 사용할 수 있음. 미리 만들어놓고 사용 가능!