import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:redda_customer/constant/api_key.dart';

class PlacesService {
  Future<List<dynamic>> getPlaceSuggestions(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=${Config.apiKey}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['predictions'];
    } else {
      throw Exception('Failed to load place suggestions');
    }
  }
}
