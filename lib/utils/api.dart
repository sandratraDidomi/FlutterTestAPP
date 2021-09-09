import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

abstract class API {
  static Future<String> requestPOST(
      uri, body, Map<String, String>? header) async {
    log('body: ' + body.toString());
    var h = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    if (header != null) {
      h.addEntries(header.entries);
    }
    final response = await http.post(
      Uri.parse(uri),
      headers: h,
      body: jsonEncode(body),
    );
    log('statusCode: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      return response.body;
    } else {
      return 'Response KO';
    }
  }

  static Future<List<dynamic>> requestGET(uri, Map<String, String>? header) async {
    var h = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    if (header != null) {
      h.addEntries(header.entries);
    }
    final response = await http.get(
      Uri.parse(uri),
      headers: h,
    );
    log('statusCode: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      var myList = <dynamic>[];
      var json = jsonDecode(response.body);
      for (var i = 0; i < json.length; i++) {
        myList.add(json[i]);
      }
      return myList;
    } else {
      return <dynamic>[];
    }
  }
}
