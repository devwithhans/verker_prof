import 'package:verker_prof/models/address.dart';
import 'package:verker_prof/models/material.dart';
import 'package:verker_prof/screens/make_offer_screen/materials/components/formats.dart';

class Offer {
  String id;
  String status;
  String consumerName;
  Address consumerAddress;
  String companyName;
  int cvr;
  Address companyAddress;
  String companyEmail;
  String? description;
  List<VerkerMaterial> materials;
  double materialPrice;
  double? hours;
  double? hourlyRate;
  DateTime? startDate;
  DateTime? offerExpires;
  DateTime offerSent;

  Offer({
    required this.offerSent,
    required this.status,
    required this.id,
    required this.companyAddress,
    required this.companyEmail,
    required this.companyName,
    required this.consumerAddress,
    required this.consumerName,
    required this.cvr,
    this.description,
    this.hourlyRate,
    this.hours,
    this.materials = const [],
    this.materialPrice = 0,
    this.offerExpires,
    this.startDate,
  });

  static convert(response) {
    _getMaterials(List material) {
      return material
          .map((e) => VerkerMaterial(
              name: e["name"], price: e["price"], quantity: e["quantity"]))
          .toList();
    }

    List<VerkerMaterial> materials = _getMaterials(response['materials']);

    _getTotalMaterialPrice(List<VerkerMaterial> material) {
      double price = 0;
      print(material);
      for (var i in material) {
        price = price + (i.price * i.quantity);
        print(price);
      }

      return price;
    }

    double totalMateralPrice = _getTotalMaterialPrice(materials);
    int hours = response['hours'];
    int hourlyRate = response['hourlyRate'];
    int startDate = int.parse(response['startDate']);

    return Offer(
      id: response['_id'] ??= null,
      status: response['status'] ??= null,
      consumerName: response['consumerName'] ??= null,
      consumerAddress: Address(
        address: response['consumerAddress']['address'],
        zip: response['consumerAddress']['zip'],
      ),
      companyName: response['companyName'] ??= null,
      cvr: response['cvr'] ??= null,
      companyAddress: Address(
        address: response['companyAddress']['address'] ??= null,
        zip: response['companyAddress']['zip'],
      ),
      companyEmail: response['companyEmail'] ??= null,
      offerSent: DateTime.now(),
      description: response['description'] ??= null,
      startDate: DateTime.fromMillisecondsSinceEpoch(startDate),
      materials: materials,
      materialPrice: _getTotalMaterialPrice(materials),
      hours: hours.toDouble(),
      hourlyRate: hourlyRate.toDouble(),
    );
  }
}

class ShortOffer {
  String status;
  String totalPrice;
  DateTime offerExpires;

  ShortOffer({
    required this.totalPrice,
    required this.offerExpires,
    required this.status,
  });

  static ShortOffer convert(response) {
    int offerExpires = int.parse(response['offerExpires']);
    String totalPrice = kFormatCurrency.format(response('totalPrice'));

    return ShortOffer(
      totalPrice: totalPrice,
      status: response['status'],
      offerExpires: DateTime.fromMillisecondsSinceEpoch(offerExpires),
    );
  }
}
