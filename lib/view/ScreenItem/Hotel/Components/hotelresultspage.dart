import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HotelResultsPage extends StatefulWidget {
  final int geoId;
  final DateTime checkIn;
  final DateTime checkOut;

  const HotelResultsPage({
    super.key,
    required this.geoId,
    required this.checkIn,
    required this.checkOut,
  });

  @override
  State<HotelResultsPage> createState() => _HotelResultsPageState();
}

class _HotelResultsPageState extends State<HotelResultsPage> {
  List<dynamic> hotels = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHotels();
  }

  Future<void> fetchHotels() async {
    try {
      setState(() => isLoading = true);

      final url = Uri.parse(
        'https://tripadvisor16.p.rapidapi.com/api/v1/hotels/searchHotels'
        '?geoId=${widget.geoId}'
        '&checkIn=${widget.checkIn.toIso8601String().split("T")[0]}'
        '&checkOut=${widget.checkOut.toIso8601String().split("T")[0]}'
        '&pageNumber=1&currencyCode=USD',
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

        final hotelList = data['data']?['data'];
        if (hotelList != null && hotelList is List) {
          setState(() {
            hotels = hotelList;
            isLoading = false;
          });
        } else {
          setState(() => isLoading = false);

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('No hotel results found.')));
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
      appBar: AppBar(title: Text("Available Hotels")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                final hotel = hotels[index];
                final imageUrl = (hotel['cardPhotos']?.isNotEmpty ?? false)
                    ? hotel['cardPhotos'][0]['sizes']['urlTemplate']
                          .replaceAll('{width}', '300')
                          .replaceAll('{height}', '200')
                    : null;
                final bookingUrl = hotel['commerceInfo']?['externalUrl'];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // height: screenHeight / 4,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2, color: Colors.black),
                      // color: Colors.blue,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: screenHeight / 8,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            // color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                hotel['title'] ?? 'بدون اسم',
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
                                  Text(
                                    hotel['priceForDisplay'] ?? 'بدون اسم',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (bookingUrl != null)
                                    IconButton(
                                      icon: Icon(
                                        Icons.open_in_new,
                                        color: Colors.black,
                                      ),
                                      onPressed: () =>
                                          launchUrl(Uri.parse(bookingUrl)),
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
                // return Card(
                //   margin: EdgeInsets.all(8),
                //   child: ListTile(
                //     leading: imageUrl != null
                //         ? Image.network(imageUrl, width: 100, fit: BoxFit.cover)
                //         : Icon(Icons.hotel),
                //     title: Text(hotel['title'] ?? 'بدون اسم'),
                //     subtitle: Text(
                //       hotel['priceForDisplay'] ?? 'السعر غير متاح',
                //     ),
                // trailing: bookingUrl != null
                //     ? IconButton(
                //         icon: Icon(Icons.open_in_new),
                //         onPressed: () => launchUrl(Uri.parse(bookingUrl)),
                //       )
                //     : null,
                //   ),
                // );
              },
            ),
    );
  }
}
