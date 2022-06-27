import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:verker_prof/utils/config.dart';

class FileUploader {
  static Future<List> uploadFile(List files) async {
    String? token = await FirebaseAuth.instance.currentUser!.getIdToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type":
          "multipart/form-data; boundary=<calculated when request is sent>"
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('$serverUrl/file/uploadProjectFiles'))
      ..headers.addAll(headers);

    for (File i in files) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'files',
        i.path,
        contentType: MediaType('image', i.path.split('.').last.toLowerCase()),
      );

      request.files.add(multipartFile);
    }

    http.Response response =
        await http.Response.fromStream(await request.send());

    var images = jsonDecode(response.body);

    return images['path'];
  }
}
