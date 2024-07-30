import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'EducationDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'create_password.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  bool _agreeToTerms = false;
  String? _selectedGender;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // Set the color of the selected date
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _dobController.text) {
      setState(() {
        _dobController.text =
            picked.toString().split(' ')[0]; // Extract only the date part
      });
    }
  }

  void _continueButtonPressed() async {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      // Prepare data to send to the server
      Map<String, dynamic> userData = {
        'name': _fullNameController.text,
        'email': _emailController.text,
        'gender': _selectedGender?.toLowerCase(),
        'dob': _dobController.text,
        // 'zip_code': _zipCodeController.text,
      };

      // Retrieve the token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Token not found. Please log in again.'),
          ),
        );
        return;
      }

      // Add your token to the request headers
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type':
            'application/json', // Adjust content type as per your API requirements
      };

      // Perform API call to register user
      var response = await http.post(
        Uri.parse('https://admin.edyone.site/api/student/detail-step1'),
        headers: headers,
        body: jsonEncode(userData),
      );

      print(response.body); // Print response to console

      if (response.statusCode == 200) {
        // If registration is successful, navigate to EducationDetails page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EducationDetails()),
        );
      } else {
        // If registration fails, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to register. Please try again later.'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Please fill in all the fields and agree to the terms.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CreatePasswordPage()), // Replace YourPage with your desired page
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Header
              Row(
                children: [
                  Text(
                    'Enter Your Personal Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Open Sans',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Full Name Input
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Email Address Input
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Enter Email Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email address';
                  }
                  // Add more email validation logic if needed
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Gender Input
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: InputDecoration(labelText: 'Gender'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue!;
                  });
                },
                items: <String>['Male', 'Female', 'Other']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Date of Birth Input with Calendar
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your date of birth';
                  }
                  // Add more date validation logic if needed
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Zip Code Input
              // TextFormField(
              // controller: _zipCodeController,
              // decoration: InputDecoration(labelText: 'Enter Zip Code'),
              // validator: (value) {
              // if (value!.isEmpty) {
              // return 'Please enter your zip code';
              // }
              // // Add more zip code validation logic if needed
              // return null;
              // },
              // ),
              // SizedBox(height: 40),

              // Terms and Conditions Checkbox
              // Terms and Conditions Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value!;
                      });
                    },
                  ),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'By registering, I agree to ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Edyone Terms of Service',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to the Terms of Service page
                              },
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to the
                              },
                          ),
                          TextSpan(
                            text: '.',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
// SizedBox with ElevatedButton
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: SizedBox(
          height: 66.0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.pink], // Add your gradient colors
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(
                  8), // Same as the button's border radius
            ),
            child: ElevatedButton(
              onPressed: _continueButtonPressed,
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Colors
                    .transparent), // Transparent background to allow gradient to show through
              ),
              child: Text(
                "Continue",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
