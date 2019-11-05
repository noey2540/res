import 'package:flutter/material.dart';
import './screens/store/stores_page.dart';
import './screens/store/stores_page.dart';


class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);


  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  Widget _buildCardListView(String imagePath) {
    return Card(
      child: Image.network(imagePath),
    );
  }

  Widget titleSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: TextStyle(fontSize: 18)),
        Container(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildCardListView(
                  "https://obs.line-scdn.net/0hReQ9IVSPDUpsQCK7GPZyHVYWDiVfLB5JCHZcSTAuU35JeE0aWHJCf0ASVnNDI0oUAi5LJExIFntGJUlMUXNC/w644"),
              _buildCardListView(
                  "https://food.mthai.com/app/uploads/2016/06/Sushi-1.jpg"),
              _buildCardListView(
                  "https://i3.wp.com/www.catdumb.com/wp-content/uploads/2018/07/bubble-tea-ranking.jpg"),
              _buildCardListView(
                  "http://news.tlcthai.com/wp-content/uploads/2013/06/doughnuts.jpg")
            ],
          ),
        )
      ],
    );
  }

  Widget title2Section(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("จัดเต็ม ซื้อ1แถม1", style: TextStyle(fontSize: 18)),
        Container(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildCardListView(
                  "https://obs.line-scdn.net/0hReQ9IVSPDUpsQCK7GPZyHVYWDiVfLB5JCHZcSTAuU35JeE0aWHJCf0ASVnNDI0oUAi5LJExIFntGJUlMUXNC/w644"),
              _buildCardListView(
                  "https://food.mthai.com/app/uploads/2016/06/Sushi-1.jpg"),
              _buildCardListView(
                  "https://i3.wp.com/www.catdumb.com/wp-content/uploads/2018/07/bubble-tea-ranking.jpg"),
              _buildCardListView(
                  "http://news.tlcthai.com/wp-content/uploads/2013/06/doughnuts.jpg")
            ],
          ),
        )
      ],
    );
  }

  Widget title3Section(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("ร้านดัง ต้องสั่ง!!", style: TextStyle(fontSize: 18)),
        Container(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildCardListView(
                  "https://www.chillpainai.com/src/wewakeup/scoop/images/a53a5fadd95fdc2cbd5f3d4df1b0aad7fd8784ef.jpg"),
              _buildCardListView(
                  "http://hotelandresortthailand.com/read/wp-content/uploads/2018/12/23CafeandBistro-800x416.jpg"),
              _buildCardListView(
                  "https://cdn1.th.orstatic.com/userphoto/photo/1/TX/005WXG56A5031316174B25px.jpg"),
            ],
          ),
        )
      ],
    );
  }

  navigateToStoresPage(BuildContext context, String category) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return StoresPage(category: category);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LALLABUY'),
      ),
      body: Container(
          color: Colors.pink[50],
          child: ListView(
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    DropdownButton<String>(
                      hint: Text('ค้นหาประเภทร้านอาหาร',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      onChanged: (String newValue) {
                        print(newValue);
                        navigateToStoresPage(context, newValue);
                      },
                      items: <String>[
                        'ปิ้งย่าง',
                        'ร้านอาหาร',
                        'ร้านส้มตำ',
                        'ร้านกาแฟ',
                        'ร้านน้ำชา'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    titleSection("โปรเด็ด ลดจัดหนัก50%"),
                    title2Section("จัดเต็ม ซื้อ1แถม1"),
                    title3Section("ร้านดัง ต้องสั่ง!!"),
                  ]),
                  
            ],
          )),
      
    );
  }
}
