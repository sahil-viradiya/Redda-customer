import 'dart:convert';
import 'package:http/http.dart' as http;

class PlacesService {
  final String apiKey = 'AIzaSyD6b4Qd9lmcgNWZZBmRdkdU0-g9TaxakYU';

  Future<List<dynamic>> getPlaceSuggestions(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);


      return data['predictions'];
    } else {
      throw Exception('Failed to load place suggestions');
    }
  }
}
