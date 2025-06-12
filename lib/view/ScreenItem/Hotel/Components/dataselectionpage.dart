import 'package:flutter/material.dart';
import 'package:tg_globle_app/view/ScreenItem/Hotel/Components/hotelresultspage.dart';
class DateSelectionPage extends StatefulWidget {
  int geoId;
  DateSelectionPage({Key? key, required this.geoId});

  @override
  State<DateSelectionPage> createState() => _DateSelectionPageState();
}

class _DateSelectionPageState extends State<DateSelectionPage> {
  DateTime? checkInDate;
  DateTime? checkOutDate;

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
        } else {
          checkOutDate = picked;
        }
      });
    }
  }

  void _goToHotels() {
    if (checkInDate != null && checkOutDate != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HotelResultsPage(
            geoId: widget.geoId,
            checkIn: checkInDate!,
            checkOut: checkOutDate!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select the check-in and check-out dates. ...'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Select the dates")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Date of entry'),
              subtitle: Text(
                checkInDate?.toLocal().toString().split(' ')[0] ??
                    'Choose the date',
              ),
              trailing: Icon(Icons.date_range),
              onTap: () => _selectDate(context, true),
            ),
            ListTile(
              title: Text('Departure Date'),
              subtitle: Text(
                checkOutDate?.toLocal().toString().split(' ')[0] ??
                    'Select the date',
              ),
              trailing: Icon(Icons.date_range),
              onTap: () => _selectDate(context, false),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: _goToHotels,
              child: Container(
                height: screenHeight / 15,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "View Hotel",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
