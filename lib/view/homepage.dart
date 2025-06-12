import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tg_globle_app/controller/homecontroller.dart';
import 'package:tg_globle_app/view/ScreenItem/Hotel/hotelpage.dart';
import 'package:tg_globle_app/view/ScreenItem/Restaurant/restaurantpage.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            'assets/images/triplogo.svg',
            height: 100,
            width: 190,
          ),
          SvgPicture.asset(
            'assets/images/dotlogo.svg',
            height: 100,
            width: 190,
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(color: Colors.white),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  height: screenHeight / 2,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(75),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 20),
                SvgPicture.asset(
                  'assets/images/tglogo.svg',
                  height: 200,
                  width: 200,
                ),
                SizedBox(height: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: GridView.builder(
                      itemCount: context.watch<Homecontroller>().items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 20,
                        childAspectRatio: 5 / 4,
                      ),
                      itemBuilder: (context, index) {
                        final item = context
                            .watch<Homecontroller>()
                            .items[index];
                        return InkWell(
                          onTap: () {
                            if (item['name'].toString() == "Hotels") {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => HotelPage(),
                                ),
                              );
                             } else if (item['name'].toString() ==
                                "Restaurant") {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RestaurantPage(),
                                ),
                              );
                            } 
                          },

                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 8,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.black,
                                  child: CircleAvatar(
                                    radius: 57,
                                    backgroundColor: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                        item['logo']!,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: FittedBox(
                                  child: Text(
                                    item['name']!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
