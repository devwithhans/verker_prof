import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:verker_prof/models/address.dart';
import 'package:verker_prof/models/material.dart';
import 'package:verker_prof/models/project.dart';

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
      materials: _getMaterials(response['materials'] ??= null),
      hours: hours.toDouble(),
      hourlyRate: hourlyRate.toDouble(),
    );
  }
}

        //  if (offer != null) {
        //                       // offerData = Offer.convert(offer);
        //                       // if (offerData != null) {
        //                       print(offer);
        //                       return BlocProvider<OfferbubleCubit>(
        //                         create: (context) =>
        //                             OfferbubleCubit()..getOfferById(offer),
        //                         child: OfferBuble(),
        //                       );
        //                       // }
        //                     } 
        