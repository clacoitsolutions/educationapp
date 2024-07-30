// import 'dart:convert';
// import 'package:edyon/EducationDetails.dart';
// import 'package:edyon/register_adress.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// class EducationDetails extends StatelessWidget {
//   const EducationDetails({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Enter your details',
//               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20.0),
//             EducationFormField(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomButton(),
//     );
//   }
// }
//
// class BottomButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
//       child: ElevatedButton(
//         onPressed: () {
//           _submitEducationDetails(context);
//         },
//         child: Container(
//           height: 56.0,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.pink, Colors.blue],
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//             ),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Center(
//             child: Text(
//               'Submit',
//               style: TextStyle(color: Colors.white, fontSize: 16.0),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Future<void> _submitEducationDetails(BuildContext context) async {
//     String apiUrl = 'http://52.66.248.226/api/student/detail-step2'; // Replace this with your actual API endpoint
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//
//     if (token == null) {
//       // Handle the case when token is not found
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Token not found. Please log in again.'),
//         ),
//       );
//       return;
//     }
//
//     Map<String, String> headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//     Map<String, String?> data = {
//       'state': _EducationFormFieldState.selectedOption1,
//       'education_board': _EducationFormFieldState.selectedOption2,
//       'standard_class': _EducationFormFieldState.selectedOption3,
//     };
//
//     try {
//       http.Response response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(data),
//       );
//
//       if (response.statusCode == 200) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => AddressDetailsPage()),
//         );
//       } else {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Error'),
//               content: Text('Failed to submit education details.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } catch (error) {
//       print('Error: $error');
//     }
//   }
// }
//
// class EducationFormField extends StatefulWidget {
//   const EducationFormField({Key? key}) : super(key: key);
//
//   @override
//   _EducationFormFieldState createState() => _EducationFormFieldState();
// }
//
// class _EducationFormFieldState extends State<EducationFormField> {
//   static String? selectedOption1;
//   static String? selectedOption2;
//   static String? selectedOption3;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             labelText: 'State',
//             border: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey),
//             ),
//           ),
//           value: selectedOption1,
//           onChanged: (newValue) {
//             setState(() {
//               selectedOption1 = newValue;
//             });
//           },
//           items: [
//             'Andhra Pradesh',
//             'Arunachal Pradesh',
//             'Assam',
//             'Uttarakhand',
//             'West Bengal'
//           ].map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//         SizedBox(height: 20.0),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             labelText: 'Education Board',
//             border: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey),
//             ),
//           ),
//           value: selectedOption2,
//           onChanged: (newValue) {
//             setState(() {
//               selectedOption2 = newValue;
//             });
//           },
//           items: ['CBSE', 'ICSE', 'UP Board'].map<DropdownMenuItem<String>>(
//                 (String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             },
//           ).toList(),
//         ),
//         SizedBox(height: 20.0),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             labelText: 'Standard / Class',
//             border: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey),
//             ),
//           ),
//           value: selectedOption3,
//           onChanged: (newValue) {
//             setState(() {
//               selectedOption3 = newValue;
//             });
//           },
//           items: ['4rth', '5th', '6th', '7th', '8th', '9th', '10th', '11th', '12th']
//               .map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
//
//

import 'dart:convert';
import 'package:edyon/EducationDetails.dart';
import 'package:edyon/register_adress.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'registration.dart';

class EducationDetails extends StatelessWidget {
  const EducationDetails({Key? key}) : super(key: key);

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
                      RegistrationPage()), // Replace YourPage with your desired page
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your Academic details',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 20.0),
            EducationFormField(),
          ],
        ),
      ),
      bottomNavigationBar: BottomButton(),
    );
  }
}

class BottomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: ElevatedButton(
        onPressed: () {
          _submitEducationDetails(context);
        },
        child: Container(
          height: 56.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink, Colors.blue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitEducationDetails(BuildContext context) async {
    String apiUrl =
        'https://admin.edyone.site/api/student/detail-step2'; // Replace this with your actual API endpoint

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      // Handle the case when token is not found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Token not found. Please log in again.'),
        ),
      );
      return;
    }

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Map<String, String?> data = {
      'state': _EducationFormFieldState.selectedOption1,
      'board': _EducationFormFieldState.selectedOption2,
      'class': _EducationFormFieldState.selectedOption3,
    };

    try {
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddressDetailsPage()),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to submit education details.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error: $error');
      // Optionally show an error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

class EducationFormField extends StatefulWidget {
  const EducationFormField({Key? key}) : super(key: key);

  @override
  _EducationFormFieldState createState() => _EducationFormFieldState();
}

class _EducationFormFieldState extends State<EducationFormField> {
  static String? selectedOption1;
  static String? selectedOption2;
  static String? selectedOption3;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'State',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          value: selectedOption1,
          onChanged: (newValue) {
            setState(() {
              selectedOption1 = newValue;
            });
          },
          items: [
            'Andhra Pradesh',
            'Arunachal Pradesh',
            'Assam',
            'Uttarakhand',
            'West Bengal'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: 20.0),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Education Board',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          value: selectedOption2,
          onChanged: (newValue) {
            setState(() {
              selectedOption2 = newValue;
            });
          },
          items: ['CBSE', 'ICSE', 'UP Board'].map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
        ),
        SizedBox(height: 20.0),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Standard / Class',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          value: selectedOption3,
          onChanged: (newValue) {
            setState(() {
              selectedOption3 = newValue;
            });
          },
          items: [
            '4th',
            '5th',
            '6th',
            '7th',
            '8th',
            '9th',
            '10th',
            '11th',
            '12th'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
