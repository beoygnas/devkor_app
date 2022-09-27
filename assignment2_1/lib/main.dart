import 'package:flutter/material.dart';
import 'widget/BottomWidget.dart';
import 'widget/AppBarWidget.dart';
import 'widget/BodyWidget.dart';

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
        primaryColor: Colors.black,
      ),
      home: const MyAppWidget(),
    );
  }  
}

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body : BodyWidget(),        
      bottomNavigationBar: BottomWidget(),  
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: Colors.white,
        child: const Icon(Icons.upload, color : Colors.black), 
      ),
    );
  }
}




// ignore: must_be_immutable




