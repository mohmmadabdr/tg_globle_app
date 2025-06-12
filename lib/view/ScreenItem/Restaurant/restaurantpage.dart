import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tg_globle_app/controller/restaurantcontroller.dart';
import 'package:tg_globle_app/view/ScreenItem/Restaurant/Components/restaurantresultspage.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant"),
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
                  .read<Restaurantcontroller>()
                  .countrienamecontroller,
              decoration: InputDecoration(
                hintText: 'Enter the city name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    context.read<Restaurantcontroller>().getSearchResults(
                      context
                          .read<Restaurantcontroller>()
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
            context.watch<Restaurantcontroller>().isloading == 0
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: Center(
                      child: ListView.builder(
                        itemCount: context
                            .watch<Restaurantcontroller>()
                            .searchResults
                            .length,
                        itemBuilder: (context, index) {
                          final city = context
                              .watch<Restaurantcontroller>()
                              .searchResults[index];
                          return ListTile(
                            title: Text(city.localizedName),
                            // subtitle: Text(city.secondaryText),
                            // onTap: () {
                            //   context.read<Restaurantcontroller>().selectcountrie(
                            //     city.localizedName,
                            //     city.locationId,
                            //   );
                            // },
                            leading: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RestaurantResultsPage(
                                      locationId: city.locationId,
                                    ),
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
