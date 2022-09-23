import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 35;

  List<ListTile> _contacts = [
    const ListTile(title : Text(("kim"))),
    const ListTile(title : Text(("park"))),
    const ListTile(title : Text(("kook"))),
  ];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _addContact(ListTile newContact){
    setState((){
      _contacts.add(newContact);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Text("$_counter"),
      // ListView.builder(
      //   itemBuilder: (context, index){
      //     return _contacts[index]; 
      //   }, 
      //   itemCount: _contacts.length
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showDialog(
            context: context,
            builder: (context){
              return TmpDialog(count : _counter, addContact : _addContact);
            }
          )
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class TmpDialog extends StatelessWidget {
   TmpDialog({
    Key? key,
    required this.count,
    required this.addContact,
  }) : super(key: key);

  final count; 
  final controller1 = TextEditingController();
  final addContact;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppBar(
            leading : TextButton(onPressed: (){}, child : const Text("취소", style : TextStyle(color: Colors.white))) , 
            actions: <Widget>[TextButton(onPressed: (){}, child : const Text("완료", style : TextStyle(color: Colors.white)))] ,
            title : const Text("새로운 연락처", style : TextStyle(fontWeight : FontWeight.bold))
          ),
          TextField(
            controller: controller1,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          Text("$count"),
          TextButton(
            onPressed : (){
              ListTile tmp = ListTile(title : Text((controller1.text)));
              addContact(tmp);
            }, child : const Text('확인')),
          TextButton(
            onPressed : (){
              Navigator.pop(context);
            }, child : const Text('취소'))
        ],
      )
    );
  }
}
