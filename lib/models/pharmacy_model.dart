// pharmacy_model.dart

class Pharmacy {
  final String name;
  final String address;
  final String image;
  final List<Drug> drugs;

  Pharmacy({
    required this.name,
    required this.address,
    required this.image,
    required this.drugs,
  });
}

class Drug {
  final String name;
  final String image;
  final double price;

  Drug({
    required this.name,
    required this.image,
    required this.price,
  });
}
