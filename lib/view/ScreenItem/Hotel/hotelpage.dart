import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tg_globle_app/controller/hotelcontroller.dart';
import 'package:tg_globle_app/view/ScreenItem/Hotel/Components/dataselectionpage.dart';

class HotelPage extends StatelessWidget {
  const HotelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hotel"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search for a destination',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: context
                  .read<Hotelcontroller>()
                  .countrienamecontroller,
              decoration: InputDecoration(
                hintText: 'Enter the city name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    context.read<Hotelcontroller>().getSearchResults(
                      context
                          .read<Hotelcontroller>()
                          .countrienamecontroller
                          .text,
                      context, // تمرير السياق
                    );
                  },
                ),
              ),
              // onSubmitted: (_) => _search(),
            ),
            SizedBox(height: 20),
            context.watch<Hotelcontroller>().isloading == 0
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: Center(
                      child: ListView.builder(
                        itemCount: context
                            .watch<Hotelcontroller>()
                            .searchResults
                            .length,
                        itemBuilder: (context, index) {
                          final city = context
                              .watch<Hotelcontroller>()
                              .searchResults[index];
                          return ListTile(
                            title: Text(
                              city.title.replaceAll(RegExp(r'<[^>]*>'), ''),
                            ),
                            subtitle: Text(city.secondaryText),
                            leading: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DateSelectionPage(geoId: city.geoId),
                                  ),
                                );
                              },
                              icon: Icon(Icons.arrow_forward),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
