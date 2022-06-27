class Address {
  final String address;
  final String zip;
  final double? lon;
  final double? lat;

  Address({required this.address, required this.zip, this.lon, this.lat});

  static Address fromJson(data) {
    return Address(
      address: "${data['adresse']['vejnavn']} ${data['adresse']['husnr']}",
      zip: "${data['adresse']['postnr']} ${data['adresse']['postnrnavn']}",
      lon: data['adresse']['x'],
      lat: data['adresse']['y'],
    );
  }

  Address copyWith({
    String? address,
    final String? zip,
    final double? lon,
    final double? lat,
  }) {
    return Address(
        address: address ?? this.address,
        zip: zip ?? this.zip,
        lon: lon ?? this.lon,
        lat: lat ?? this.lat);
  }

  static Address singleFromJson(Map data) {
    return Address(
      address: "${data['vejnavn']} ${data['husnr']}",
      zip: "${data['postnr']} ${data['postnrnavn']}",
      lon: data['x'],
      lat: data['y'],
    );
  }
}
