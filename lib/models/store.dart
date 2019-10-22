class Store {
  String name;
  String description;
  String address;
  String category;
  List<double> location;
  List<String> imageUrl;

  Store(
      {this.name,
      this.category,
      this.description,
      this.address,
      this.location,
      this.imageUrl});
}
