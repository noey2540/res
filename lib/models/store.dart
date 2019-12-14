import 'package:scoped_model/scoped_model.dart';

class Store extends Model {
  String storeName;
  String description;
  String address;
  String storeCategory;
  List<double> location;
  List<String> imageUrl;

  Store(
      {this.storeName,
      this.storeCategory,
      this.description,
      this.address,
      this.location,
      this.imageUrl});
}
