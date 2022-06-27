import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:verker_prof/features/address/models/address.dart';
import 'package:verker_prof/utils/services/network_helper.dart';

Future<List<Address>> findPlace(String placeName) async {
  List<Address> predictions = [];
  if (placeName.length < 3) return [];

  String autoCompleteUrl =
      'https://api.dataforsyningen.dk/adresser/autocomplete?q=$placeName';

  var res = await NetworkHelper(autoCompleteUrl).getData();

  for (var i in jsonDecode(res)) {
    predictions.add(Address.fromJson(i));
  }
  return predictions;
}

Future<List<Address>> findPlaceByCoordinates(Position coordinates) async {
  List<Address> predictions = [];
  String searchUrl =
      'https://api.dataforsyningen.dk/adgangsadresser/reverse?x=${coordinates.longitude}&y=${coordinates.latitude}&struktur=mini';
  var res = await NetworkHelper(searchUrl).getData();
  predictions.add(Address.singleFromJson(jsonDecode(res)));

  return predictions;
}
