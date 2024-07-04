import 'package:flutter/material.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/location_sugetion.dart';

class SearchPlaceScreen extends StatefulWidget {
  const SearchPlaceScreen({super.key});

  @override
  _SearchPlaceScreenState createState() => _SearchPlaceScreenState();
}

class _SearchPlaceScreenState extends State<SearchPlaceScreen> {
  final TextEditingController _controller = TextEditingController();
  final PlacesService _placesService = PlacesService();
  List<dynamic> _suggestions = [];

  void _onSearchChanged() async {
    if (_controller.text.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }

    final suggestions =
        await _placesService.getPlaceSuggestions(_controller.text);
    setState(() {
      _suggestions = suggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Places'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search for a place',
              ),
              onChanged: (value) {
                _onSearchChanged();
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_suggestions[index]['description']),
                  onTap: () {
                    // Handle place selection
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
