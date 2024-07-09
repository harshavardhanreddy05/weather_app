import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(54, 116, 242, .8),
        body: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/cloud.png',
                  width: 270,
                  height: 350, // You can adjust the height as needed
                ),
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Weather",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 45.0,
                  ),
                ),
                Text(
                  "Forecasts",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 45.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Let the weather be your guide.",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/nextPage');
                  },
                  child: Container(
                    width: 220,
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(251, 195, 100, 1),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: GoogleFonts.poppins(
                          color: Color.fromRGBO(54, 116, 242, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
