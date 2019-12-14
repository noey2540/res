import 'package:scoped_model/scoped_model.dart';

class Menu extends Model {
  String name;
  double price;
  String storeId;
  List<String> imageUrl;

  Menu({this.name, this.price, this.storeId, this.imageUrl});
}
