import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tg_globle_app/model/cityhotelmodel.dart';

class Hotelcontroller with ChangeNotifier {
  TextEditingController countrienamecontroller = TextEditingController();
  int isloading = 1;
  List<CityHotelModel> searchResults = [];
  Future<void> getSearchResults(
    String countriename,
    BuildContext context,
  ) async {
    try {
      isloading = 0;
      notifyListeners();

      final url = Uri.parse(
        'https://tripadvisor16.p.rapidapi.com/api/v1/hotels/searchLocation?query=$countriename',
      );

      final response = await http.get(
        url,
        headers: {
          'x-rapidapi-key':
              '055a593bdfmsh14297c556a3a9fep19a1d2jsn49a632aedd9d',
          'x-rapidapi-host': 'tripadvisor16.p.rapidapi.com',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true && data['data'] != null) {
          final list = List<Map<String, dynamic>>.from(data['data']);
          searchResults = list.map((e) => CityHotelModel.fromJson(e)).toList();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${searchResults.length} result')),
          );
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('No results found.')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred during the search: $e')),
      );
    } finally {
      isloading = 1;
      notifyListeners();
    }
  }
}
