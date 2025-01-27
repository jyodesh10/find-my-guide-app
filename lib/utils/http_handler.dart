import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future handleRequest(
    {required String method,
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body}) async {
  try {
    http.Response response;

    switch (method.toUpperCase()) {
      case 'GET':
        response = await http.get(Uri.parse(url), headers: headers);
        break;
      case 'POST':
        response = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(body));
        break;
      case 'PUT':
        response = await http.put(Uri.parse(url),
            headers: headers, body: jsonEncode(body));
        break;
      case 'DELETE':
        response = await http.delete(Uri.parse(url), headers: headers);
        break;
      case 'PATCH':
        response = await http.patch(Uri.parse(url),
            headers: headers, body: jsonEncode(body));
        break;
      default:
        throw Exception('Invalid HTTP method: $method');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // return jsonDecode(utf8.decode(response.bodyBytes));
      return jsonDecode(response.body);
    } else {
      // Handle specific error messages from the API
      if (response.body.isNotEmpty) {
        Map<String, dynamic> errorData = jsonDecode(response.body);
        if (errorData.containsKey('message')) {
          // Get.back();
          // customsnackBar(message: errorData['message'], backgroundColor: red.withOpacity(0.1));
          Fluttertoast.showToast(msg: errorData['message']);
          throw Exception('API Error: ${errorData['message']}');
        }
      }
      throw Exception(
          'HTTP request failed with status: ${response.statusCode}');
    }
  } on SocketException {
    throw Exception('No Internet connection');
  } on Exception catch (e) {
    throw Exception('Error during HTTP request: $e');
  }
}