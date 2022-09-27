import 'package:flutter/material.dart';
import 'package:assignment2_1/class/item.dart';


class BodyWidget extends StatefulWidget {
  const BodyWidget({
    Key? key,
  }) : super(key: key);
  
  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> with TickerProviderStateMixin {

  late TabController _tabController;

  @override 
  void initState(){
    _tabController = TabController(
      length: 6,
      vsync: this,  //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {
    return 
      Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            color : Colors.white,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              decoration : InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                hintText : "트렌비X삼성전자 최대 20% 쿠폰!",
                hintStyle: TextStyle(fontSize : 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide(   // border 없애줌
                    width: 0, 
                    style: BorderStyle.none,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide(   // border 없애줌
                    width: 0, 
                    style: BorderStyle.none,
                  ),
                ),
                suffixIcon: Icon(Icons.search), //검색 아이콘 추가
                contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0)
              )
            ),
          ),
          Container(
            color: Colors.white,
            child: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.white,
              controller: _tabController,
              tabs: const <Widget>[
                Tab(child: Text("홈", style : TextStyle(fontSize: 13, fontWeight : FontWeight.bold),)),
                Tab(child: Text("기획전", style : TextStyle(fontSize: 12.5, fontWeight : FontWeight.bold),) ), 
                Tab(child: Text("랭킹", style : TextStyle(fontSize: 13, fontWeight : FontWeight.bold),)),
                Tab(child: Text("브랜드", style : TextStyle(fontSize: 12.5, fontWeight : FontWeight.bold),)),
                Tab(child: Text("IT:EM", style : TextStyle(fontSize: 11, fontWeight : FontWeight.bold),)),
                Tab(child: Text("매거진", style : TextStyle(fontSize: 12.5, fontWeight : FontWeight.bold),)),
              ],
            ),
          ),
          Expanded(
            child : TabBarView(
              controller: _tabController,
              children:  <Widget>[
                Container(
                  color : Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/trenbe.png'),
                      Expanded(child: Menu()),  //gridview를 column에 쓰려면 Expanded로 묶어야함.
                    ],
                  ),
                ),
                Menu(),
                Center(
                  child: Text("empty"),
                ),
                Center(
                  child: Text("empty"),
                ),
                Center(
                  child: Text("empty"),
                ),
                Center(
                  child: Text("empty"),
                ),
              ],
            ),
          ),
          
        ],
      );
  }
}

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding : const EdgeInsets.all(10),
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(0),
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        crossAxisCount: 5,
        children: <Widget>[
          Column(
            children: [
              Image.asset('assets/images/woman.png', height : 45 , width: 45,),                
              Text("여성", style : TextStyle(fontSize: 10, fontWeight : FontWeight.bold))
            ],
          ),
          Column(
            children: [
              Image.asset('assets/images/man.png', height : 45 , width: 45,),                 
              Text("남성", style : TextStyle(fontSize: 10, fontWeight : FontWeight.bold))
            ],
          ),
          Column(
            children: [
              Image.asset('assets/images/kids.png', height : 45 , width: 45,),                 
              Text("키즈", style : TextStyle(fontSize: 10, fontWeight : FontWeight.bold))
            ],
          ),
          Column(
            children: [
              Image.asset('assets/images/resale.png', height : 45 , width: 45,),                 
              Text("리세일", style : TextStyle(fontSize: 10, fontWeight : FontWeight.bold))
            ],
          ),
          Column(
            children: [
              Image.asset('assets/images/outlet.png', height : 45 , width: 45,),                 
              Text("아울렛", style : TextStyle(fontSize: 10, fontWeight : FontWeight.bold))
            ],
          ),
          Column(
            children: [
              Image.asset('assets/images/highend.png', height : 45 , width: 45,),                
              Text("하이엔드", style : TextStyle(fontSize: 10, fontWeight : FontWeight.bold))
            ],
          ),
          Column(
            children: [
              Image.asset('assets/images/fox.png', height : 45 , width: 45,),                 
              Text("컨텔럭셔리", style : TextStyle(fontSize: 10, fontWeight : FontWeight.bold))
            ],
          ),
          Column(
            children: [
              Image.asset('assets/images/shoes.png', height : 45 , width: 45,),                 
              Text("스니커즈", style : TextStyle(fontSize: 10, fontWeight : FontWeight.bold))
            ],
          ),
          Column(
            children: [
              Image.asset('assets/images/lamp.png', height : 45 , width: 45,),                 
              Text("홈리빙", style : TextStyle(fontSize: 10, fontWeight : FontWeight.bold))
            ],
          ),
          Column(
              children: [
                Image.asset('assets/images/sale.png', height : 45 , width: 45,),                 
                Text("리저브", style : TextStyle(fontSize: 10, fontWeight : FontWeight.bold))
              ],
            ),
        ],
      ),
    );
  }
}