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
}
