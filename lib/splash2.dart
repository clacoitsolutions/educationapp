import 'package:edyon/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';
import 'register_mobile.dart';
import 'otppage.dart';
import 'registration.dart';

class SplashScreens extends StatefulWidget {
  @override
  _SplashScreensState createState() => _SplashScreensState();
}

// Replace your existing _SplashScreensState class with this updated one
class _SplashScreensState extends State<SplashScreens> {
  final PageController _pageController = PageController();
  late Timer _timer;
  int _currentPage = 0;
  bool _isTimerActive = true; // Track if auto-scroll timer is active

  @override
  void initState() {
    super.initState();
    // Start the auto-scroll timer
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_isTimerActive) {
        int nextPage = _pageController.page!.round() + 1;
        if (nextPage == 3) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _skip() {
    // Navigate to the next screen (for example, RegisterOTP screen)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterOTP()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // Toggle the timer state on tap
          _isTimerActive = !_isTimerActive;
        });
      },
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                SplashScreenContent(
                  imagePath: 'images/logo.png',
                  title: 'Better way of learning is calling you',
                  description:
                      'Learn from the best teachers of India in a simple and easy way',
                ),
                SplashScreenContent(
                  imagePath: 'images/logo2.png',
                  title: 'Find yourself by learning whatever you learn',
                  description:
                      'Learn whatever you want to learn with the best content at an affordable price by looking for courses and batches.',
                ),
                SplashScreenContent(
                  imagePath: 'images/logo3.png',
                  title: 'It’s not just learning, It’s a promise!',
                  description:
                      'We will deliver our best to make you the best and it\'s our promise.',
                ),
              ],
            ),
            Positioned(
              bottom: 160,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: CustomizableEffect(
                    activeDotDecoration: DotDecoration(
                      width: 10,
                      height: 10,
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(6),
                      dotBorder: DotBorder(
                        color: Color(0xFF1A21BC),
                        width: 5,
                      ),
                    ),
                    dotDecoration: DotDecoration(
                      width: 8,
                      height: 8,
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    spacing: 16.0,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                onPressed: _skip,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 5),
                    Image.asset(
                      'images/skip.png', // Make sure the skip icon is in the assets folder
                      width: 45,
                      height: 22,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    width: 265,
                    height: 55,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFA10048), Color(0xFF2300FF)],
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to RegisterOTP screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterOTP()),
                        );
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.all(10.0)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.grey; // Silver color when disabled
                          }
                          return Colors
                              .transparent; // Transparent background to allow gradient to show
                        }),
                        foregroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.black54; // Text color when disabled
                          }
                          return Colors.white; // Text color when enabled
                        }),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                  Container(
                    width: 265,
                    height: 55,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to SignInPage screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInPage()),
                        );
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.all(10.0)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.white; // Silver color when disabled
                          }
                          return Colors
                              .transparent; // Transparent background to allow gradient to show
                        }),
                        foregroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.black54; // Text color when disabled
                          }
                          return Colors.white; // Text color when enabled
                        }),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SplashScreenContent extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  SplashScreenContent({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 219,
              height: 185,
            ),
            SizedBox(height: 0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9FA3A9), // Updated font color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
