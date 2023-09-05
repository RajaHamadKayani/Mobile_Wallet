import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_wallet/home_screen/home_screen.dart';
import 'package:mobile_wallet/pick_image/pick_gym_card.dart';
import 'package:mobile_wallet/pick_image/pick_id_card.dart';

class CardNameScreen extends StatefulWidget {
  const CardNameScreen({super.key});

  @override
  State<CardNameScreen> createState() => _CardNameScreenState();
}

class _CardNameScreenState extends State<CardNameScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationControllerAtm = AnimationController(vsync: this);
    animationControllerGym = AnimationController(vsync: this);
    animationControllerId = AnimationController(vsync: this);
    animationControllerStudent = AnimationController(vsync: this);
  }

  late AnimationController animationControllerAtm;
  late AnimationController animationControllerId;
  late AnimationController animationControllerGym;

  late AnimationController animationControllerStudent;

  List<String> images = [
    "assets/images/ATM.png",
    "assets/images/id.png",
    "assets/images/gym.png",
    "assets/images/student_1.jpg"
  ];
  List<String> names = ["ATM Card", "Id Card", "Gym Card", "Student Card"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            icon: const Icon(
              Icons.close,
              color: Color(0xff000000),
              size: 20,
            )),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PickGymImage()));
                        },
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PickIdCard()));
                          },
                          child: ReusableRow(
                              animationController: animationControllerAtm,
                              firstText: "Gym",
                              secondText: "Card",
                              animation: "assets/json/gym.json"),
                        ),
                      ),
                      ReusableRow(
                          animationController: animationControllerId,
                          firstText: "ID",
                          secondText: "Card",
                          animation: "assets/json/id_card.json"),
                      ReusableRow(
                          animationController: animationControllerAtm,
                          firstText: "ATM",
                          secondText: "Card",
                          animation: "assets/json/atm_animation.json"),
                      ReusableRow(
                          animationController: animationControllerStudent,
                          firstText: "Student",
                          secondText: "Card",
                          animation: "assets/json/student_card.json")
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReusableRow extends StatefulWidget {
  String firstText;
  var animation;
  String secondText;
  AnimationController animationController;
  ReusableRow(
      {super.key,
      required this.animationController,
      required this.firstText,
      required this.secondText,
      required this.animation});

  @override
  State<ReusableRow> createState() => _ReusableRowState();
}

class _ReusableRowState extends State<ReusableRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1)),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child:
                      Lottie.asset(widget.animation, onLoaded: (composition) {
                    widget.animationController.duration = composition.duration;
                    widget.animationController.repeat();
                  }),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "${widget.firstText} ",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    )),
                TextSpan(
                    text: widget.secondText,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ))
              ]))
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
