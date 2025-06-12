import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class RestaurantResultsPage extends StatefulWidget {
  final int locationId;

  const RestaurantResultsPage({super.key, required this.locationId});

  @override
  State<RestaurantResultsPage> createState() => _RestaurantResultsPageState();
}

class _RestaurantResultsPageState extends State<RestaurantResultsPage> {
  List<dynamic> restaurants = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRestaurants();
  }

  Future<void> fetchRestaurants() async {
    try {
      setState(() => isLoading = true);

      final url = Uri.parse(
        'https://tripadvisor16.p.rapidapi.com/api/v1/restaurant/searchRestaurants'
        '?locationId=${widget.locationId}'
        '&pageNumber=1',
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
        final data = jsonDecode(response.body);

        final restaurantList = data['data']?['data'];
        if (restaurantList != null && restaurantList is List) {
          setState(() {
            restaurants = restaurantList;
            isLoading = false;
          });
        } else {
          setState(() => isLoading = false);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No Restaurant results found.')),
          );
        }
      } else {
        setState(() => isLoading = false);
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load: ${response.statusCode}')),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while connecting: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Available Restaurants")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                final rawUrl =
                    restaurant['thumbnail']?['photo']?['photoSizeDynamic']?['urlTemplate'];
                final safeUrl = rawUrl
                    ?.replaceAll('{width}', '500')
                    .replaceAll('{height}', '300');
                final reviewUrl =
                    restaurant['reviewSnippets']?['reviewSnippetsList']?[0]?['reviewUrl'];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2, color: Colors.black),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: screenHeight / 8,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(
                                safeUrl ??
                                    "https://tse2.mm.bing.net/th/id/OIF.uqcuIsG82j2B4inivr7yyA?rs=1&pid=ImgDetMain",
                              ),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                restaurant['name'] ?? 'بدون اسم',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  if (reviewUrl != null)
                                    IconButton(
                                      icon: Icon(
                                        Icons.open_in_new,
                                        color: Colors.black,
                                      ),
                                      onPressed: () =>
                                          launchUrl(Uri.parse(reviewUrl)),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
