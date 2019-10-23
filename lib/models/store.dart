class Store {
  String store_name;
  String description;
  String address;
  String store_category;
  List<double> location;
  List<String> imageUrl;

  Store(
      {this.store_name,
      this.store_category,
      this.description,
      this.address,
      this.location,
      this.imageUrl});
}
