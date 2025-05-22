import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "https://api.sampleapis.com/beers/ale";

  Future<String> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return jsonEncode(response.body);
    } else {
      throw Exception("Failed to load api service");
    }
  }
}
