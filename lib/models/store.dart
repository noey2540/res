class Store {
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
