import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class ApiService {
  Future<String> sendMessage(String message) async {
    final uri = Uri.parse(
      ApiConfig.baseUrl + ApiConfig.chatEndpoint,
    );

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "message": message,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Server returned ${response.statusCode}",
      );
    }

    final data = jsonDecode(response.body);

    if (data["success"] == true) {
      return data["response"];
    }

    throw Exception("Backend returned an error.");
  }
}