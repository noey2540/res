import 'package:flutter/material.dart';
import 'package:poppop/secondpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Homepage'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Restaurants'),
      ),
      body: ListView(
        children: <Widget>[
            DropdownButton<String>(
              
              onChanged: (String newValue)  {
                print(newValue);
                navigateToSecondPage(context,newValue);
              },
              items: <String>['ปิ้งย่าง', 'ร้านอาหาร', 'ร้านส้มตำ', 'ร้านกาแฟ','ร้านน้ำชา']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              
            ),
          titleSection,
          title2Section,
          title3Section,
          
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[ 
            DrawerHeader(child: Text('ส่วนของผู้ส่งสินค้า',style: TextStyle(fontSize: 18,color: Colors.black) )),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(children: <Widget>[ 
                  FlatButton.icon(
                    //onPressed: () => navigateToSecondPage(),
                    icon: Icon(Icons.location_on,color: Colors.blue,size: 35,),
                    label: Text("Login",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                   ], ),
                //Container(margin: EdgeInsets.only(left: 0)),
              ],)
            // ListTile(title: Text('ช่วยเหลือ',style: TextStyle(fontSize: 20,color: Colors.black)),),
          ],),)
    );
  }
}
Widget titleSection = Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    Text("โปรเด็ด ลดจัดหนัก50%", style: TextStyle(fontSize: 18)),
    Container(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _buildCardListView(),
          _buildCardListView2(),
          _buildCardListView3(),
          _buildCardListView4()
        ],
      ),
    )
  ],
);

Card _buildCardListView() {
  return Card(
    child: Image.network(
        "https://www.tripgether.com/photos/shares/terr/terr2018/OCT/5_CAFE_KAMPANGSAN/1/23_5.jpg"),
  );
}

Card _buildCardListView2() {
  return Card(
    child: Image.network(
        "https://www.tripgether.com/photos/shares/terr/terr2018/OCT/5_CAFE_KAMPANGSAN/1/chinu_1.jpg"),
  );
}

Card _buildCardListView3() {
  return Card(
    child: Image.network(
        "https://www.tripgether.com/photos/shares/terr/terr2018/OCT/5_CAFE_KAMPANGSAN/1/soft_4.jpg"),
  );
}

Card _buildCardListView4() {
  return Card(
    child: Image.network(
        "https://www.tripgether.com/photos/shares/terr/terr2018/OCT/5_CAFE_KAMPANGSAN/1/des_4.jpg"),
  );
}

Widget title2Section = Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    Text("จัดเต็ม ซื้อ1แถม1", style: TextStyle(fontSize: 18)),
    Container(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _build1CardListView(),
          _build1CardListView2(),
          _build1CardListView3(),
          _build1CardListView4()
        ],
      ),
    )
  ],
);

Card _build1CardListView() {
  return Card(
    child: Image.network(
        "https://obs.line-scdn.net/0hReQ9IVSPDUpsQCK7GPZyHVYWDiVfLB5JCHZcSTAuU35JeE0aWHJCf0ASVnNDI0oUAi5LJExIFntGJUlMUXNC/w644"),
  );
}

Card _build1CardListView2() {
  return Card(
    child:
    Image.network("https://food.mthai.com/app/uploads/2016/06/Sushi-1.jpg"),
  );
}

Card _build1CardListView3() {
  return Card(
    child: Image.network(
        "https://i3.wp.com/www.catdumb.com/wp-content/uploads/2018/07/bubble-tea-ranking.jpg"),
  );
}

Card _build1CardListView4() {
  return Card(
    child: Image.network(
        "http://news.tlcthai.com/wp-content/uploads/2013/06/doughnuts.jpg"),
  );
}

Widget title3Section = Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    Text("ร้านดัง ต้องสั่ง!!", style: TextStyle(fontSize: 18)),
    Container(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _build2CardListView(),
          _build2CardListView2(),
          _build2CardListView3(),
        ],
      ),
    )
  ],
);

Card _build2CardListView() {
  return Card(
    child: Image.network(
        "https://www.chillpainai.com/src/wewakeup/scoop/images/a53a5fadd95fdc2cbd5f3d4df1b0aad7fd8784ef.jpg"),
  );
}

Card _build2CardListView2() {
  return Card(
    child: Image.network(
        "http://hotelandresortthailand.com/read/wp-content/uploads/2018/12/23CafeandBistro-800x416.jpg"),
  );
}

Card _build2CardListView3() {
  return Card(
    child: Image.network(
        "https://cdn1.th.orstatic.com/userphoto/photo/1/TX/005WXG56A5031316174B25px.jpg"),
  );
}



Column _build3ButtonColumn({IconData icon, String label}) {
  var icColor = Colors.blue.shade900;
  return Column(
    children: <Widget>[
      Icon(
        icon,
        color: icColor,
      ),
      Container(margin: EdgeInsets.only(top: 20))
    ],
  );
}

navigateToSecondPage(BuildContext context, String category) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return SecondPage(category: category);
  }));
}
