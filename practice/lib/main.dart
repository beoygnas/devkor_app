import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 35;

  List<Contact> _contacts = [];

  getPermission() async{
    var status = await Permission.contacts.status;
    if(status.isGranted){
      print("허락됨");
    
      _contacts = await ContactsService.getContacts();
      setState((){});

    
    }else if(status.isDenied){
      print("거절됨");
      Permission.contacts.request();
    }
  }

  @override
  void initState(){
    super.initState();
    getPermission();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _addContact() async {
    _contacts = await ContactsService.getContacts();
    setState((){});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions : [
          IconButton(onPressed: (){getPermission();}, icon: Icon(Icons.contacts))
        ]
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
          return Text(_contacts[index].displayName.toString()); 
        }, 
        itemCount: _contacts.length
      ),
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
            onPressed : () async {
              var newPerson = Contact();
              newPerson.givenName = controller1.text;
              await ContactsService.addContact(newPerson);
              addContact();
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
