class ElectronicsItem {
  final String name;
  final double price;
  final String image;

  ElectronicsItem({required this.name, required this.price, required this.image});

  factory ElectronicsItem.fromJson(Map<String, dynamic> json) {
    return ElectronicsItem(
      name: json['name'],
      price: json['price'],
      image: json['image'],
    );
  }
}

class ElectronicsStore {
  final String name;
  final String location;
  final String image;
  final List<ElectronicsItem> items;

  ElectronicsStore({
    required this.name,
    required this.location,
    required this.image,
    required this.items,
  });

  factory ElectronicsStore.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<ElectronicsItem> itemsList =
    list.map((i) => ElectronicsItem.fromJson(i)).toList();

    return ElectronicsStore(
      name: json['name'],
      location: json['location'],
      image: json['image'],
      items: itemsList,
    );
  }
}
