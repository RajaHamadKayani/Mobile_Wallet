import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_wallet/provider/provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderClass>(context);
    // ignore: unused_local_variable
    double height = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<ProviderClass>(
            builder: (context, value, child) {
              return IconButton(
                  onPressed: () {
                    provider.navigateToCategoriesScreen(context);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Color(0xff000000),
                    size: 20,
                  ));
            },
          ),
          SizedBox(
            width: width * .02,
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Color(0xff000000),
                size: 20,
              ))
        ],
        centerTitle: true,
        title: Text(
          "Cards",
          style: GoogleFonts.openSans(
              fontWeight: FontWeight.w600, color: const Color(0xff000000)),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Lottie.asset("assets/json/home_screen_animation.json",
                    onLoaded: (compostion) {
                  animationController.duration = compostion.duration;
                  animationController.repeat();
                }),
              ),
            ),
            SizedBox(
              height: height * .1,
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Add Cards to ",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff000000),
                      fontSize: 20)),
              TextSpan(
                  text: 'Wallet',
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.red))
            ]))
          ],
        ),
      ),
    );
  }
}
