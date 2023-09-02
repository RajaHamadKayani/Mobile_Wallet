import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wallet/home_screen/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  goToHome() {
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    goToHome();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * .2,
            ),
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                child: FittedBox(
                    fit: BoxFit.cover,
                    child:
                        Lottie.asset("assets/json/splash_screen_animation.json",
                            onLoaded: (composition) {
                      animationController.duration = composition.duration;
                      animationController.repeat();
                    })),
              ),
            ),
            SizedBox(
              height: height * .1,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Mobile ",
                        style: GoogleFonts.openSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff000000))),
                    TextSpan(
                        text: "Wallet",
                        style: GoogleFonts.openSans(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.red))
                  ])),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
