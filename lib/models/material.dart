// This is a materal model, that is used when making and managing offers

class VerkerMaterial {
  String name;
  double quantity;
  double price;

  VerkerMaterial(
      {required this.name, required this.price, required this.quantity});

  VerkerMaterial copyWith(
    String? name,
    double? quantity,
    double? price,
  ) {
    return VerkerMaterial(
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
