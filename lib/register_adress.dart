import 'dart:convert'; // Import dart:convert package
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Navbar.dart';
import 'register_mobile.dart';

class AddressDetailsPage extends StatefulWidget {
  const AddressDetailsPage({Key? key}) : super(key: key);

  @override
  _AddressDetailsPageState createState() => _AddressDetailsPageState();
}

class _AddressDetailsPageState extends State<AddressDetailsPage> {
  final TextEditingController _floorHouseController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  String? _selectedState;
  String? _selectedCity;
  List<String> _states = ['Up', 'MP', 'Bihar'];
  List<String> _cities = ['Lucknow', 'kanpur', 'Delhi'];
  late String _token;
  late int _userId;

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
    _userId = prefs.getInt('id') ?? 0;
  }

  Future<void> _submitAddressDetails() async {
    // Prepare data to send to the server
    Map<String, dynamic> addressData = {
      'house_no': _floorHouseController.text,
      'state': _selectedState,
      'address': _addressController.text,
      'zip_code': _zipcodeController.text,
      'city': _selectedCity,
      'landmark': _landmarkController.text,
    };

    try {
      // Perform API call to save address details
      var response = await http.post(
        Uri.parse('https://admin.edyone.site/api/student/detail-step3'),
        headers: {
          'Authorization': 'Bearer $_token', // Add token to headers
          'Content-Type': 'application/json', // Specify content type
        },
        body: jsonEncode(addressData), // Encode data to JSON
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Address details saved successfully, navigate to the next screen
        // For example:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Navbar()));
      } else {
        // Show error message if the request fails
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(
                  'Failed to save address details. Please try again later.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle any exceptions that might occur
      print('Error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred. Please try again later.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30.0, 60.0, 30.0, 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Handle arrow click
                  },
                  child: Icon(Icons.arrow_back_ios_sharp), // Arrow icon
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RegisterOTP()), // Replace YourPage with your desired page
                    );
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(
                height: 20), // Added space between arrow button and text
            const Text(
              'Enter Your Address',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(
                height: 10), // Added space between arrow button and text
            TextFormField(
              controller: _floorHouseController,
              decoration: InputDecoration(labelText: 'Floor/House No.'),
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextFormField(
              controller: _landmarkController,
              decoration: InputDecoration(labelText: 'Landmark'),
            ),
            TextFormField(
              controller: _zipcodeController,
              decoration: InputDecoration(labelText: 'Zipcode'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedState,
              onChanged: (value) {
                setState(() {
                  _selectedState = value;
                });
              },
              items: _states.map((state) {
                return DropdownMenuItem(
                  value: state,
                  child: Text(state),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'State'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedCity,
              onChanged: (value) {
                setState(() {
                  _selectedCity = value;
                });
              },
              items: _cities.map((city) {
                return DropdownMenuItem(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'City'),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.pink],
                    stops: [0.0, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(15.0)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    foregroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.black54; // Text color when disabled
                      }
                      return Colors.white; // Text color when enabled
                    }),
                  ),
                  onPressed: _submitAddressDetails,
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
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
