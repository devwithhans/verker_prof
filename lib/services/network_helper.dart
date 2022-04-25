import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  String url;

  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    String data = '';

    if (response.statusCode == 200) {
      data = response.body;

      return jsonDecode(data);
    } else {
      print('Noget gik galt i NetworkingHelper');
    }
  }
}
