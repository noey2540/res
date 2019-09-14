import 'package:flutter/material.dart';
import 'package:poppop/secondpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Restaurants',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Homepage'),
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
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(children: <Widget>[
                  FlatButton.icon(
                      onPressed: () => navigateToSecondPage(context),
                      icon: Icon(Icons.location_on),
                      label: Text("ค้นหาร้านอาหาร",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                  FlatButton.icon(
                      onPressed: () => navigateToSecondPage(context),
                      icon: Icon(Icons.local_dining),
                      label: Text("โปรโมชั่น",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                ]),
                Container(margin: EdgeInsets.only(left: 0),)
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(children: <Widget>[
                  FlatButton.icon(
                      onPressed: () => navigateToSecondPage(context),
                      icon: Icon(Icons.grade),
                      label: Text("ร้านแนะนำ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                  FlatButton.icon(
                      onPressed: () => navigateToSecondPage(context),
                      icon: Icon(Icons.fastfood),
                      label: Text("เมนูยอดฮิต",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                ]),
                Container(margin: EdgeInsets.only(left: 0),)
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(children: <Widget>[
                  FlatButton.icon(
                      onPressed: () => navigateToSecondPage(context),
                      icon: Icon(Icons.contact_phone),
                      label: Text("ติดต่อเรา",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                  FlatButton.icon(
                      onPressed: () => navigateToSecondPage(context),
                      icon: Icon(Icons.settings),
                      label: Text("Admin",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                ]),
                Container(margin: EdgeInsets.only(left: 0),)
              ]),

          titleSection,
          title2Section,
          title3Section,
          header4Section,
          FlatButton(
              color: Colors.red[300],
              child: Text("Next", style: TextStyle(color: Colors.white)),
              onPressed: () => navigateToSecondPage(context))
        ],
      ),
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

Widget header4Section = Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[
    _build3ButtonColumn(icon: Icons.alternate_email),
    _build3ButtonColumn(icon: Icons.phone),
    _build3ButtonColumn(icon: Icons.mail),
    _build3ButtonColumn(icon: Icons.location_on)
  ],
);

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

navigateToSecondPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return MySecondPage();
  }));
}