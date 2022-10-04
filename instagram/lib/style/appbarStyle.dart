import 'package:flutter/material.dart';

var appbartheme = ThemeData(
  textButtonTheme: TextButtonThemeData(
    style : TextButton.styleFrom( //버튼관련 스타일
      backgroundColor: Colors.grey,
    )
  ),
  
  iconTheme: IconThemeData(color: Colors.blue),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    elevation: 1,
    actionsIconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black, 
      fontSize: 25,
      fontWeight : FontWeight.bold
    ) 
  ),
  textTheme : TextTheme(
    bodyText2: TextStyle(color : Colors.red)  //위젯마다 다름. bodyText2같은 
  )
);