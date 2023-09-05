// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hive/hive.dart';
// import 'package:lottie/lottie.dart';
// import 'package:mobile_wallet/card_name_screen/card_name_screen.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class PickImage extends StatefulWidget {
//   const PickImage({Key? key}) : super(key: key);

//   @override
//   State<PickImage> createState() => _PickImageState();
// }

// class _PickImageState extends State<PickImage>
//     with SingleTickerProviderStateMixin {
//   Future<void> _showImageDialog(BuildContext context, Uint8List imageBytes) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: Container(
//             width: 350,
//             height: 600,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 width: 1,
//                 color: Colors.black,
//               ),
//             ),
//             child: FittedBox(
//               fit: BoxFit.contain,
//               child: Image.memory(imageBytes),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   late AnimationController animationController;
//   File? image;
//   @override
//   void initState() {
//     super.initState();
//     animationController = AnimationController(vsync: this);
//   }

//   Future<void> galleryImage(BuildContext context) async {
//     final imagePicker = ImagePicker();
//     final pickedImage = await imagePicker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 80,
//     );
//     if (pickedImage != null) {
//       setState(() {
//         image = File(pickedImage.path);
//       });
//     }
//   }

//   Future<void> cameraImage(BuildContext context) async {
//     final imagePicker = ImagePicker();
//     final pickedImage = await imagePicker.pickImage(
//       source: ImageSource.camera,
//       imageQuality: 80,
//     );
//     if (pickedImage != null) {
//       setState(() {
//         image = File(pickedImage.path); // Add to the list
//       });
//     }
//   }

//   void dispose() {
//     super.dispose();
//     animationController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Pick Image",
//           style: GoogleFonts.openSans(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const CardNameScreen(),
//               ),
//             );
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//             size: 20,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       cameraImage(context);
//                     },
//                     child: Container(
//                       height: 100,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.black, width: 1),
//                       ),
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.camera,
//                               color: Colors.white,
//                               size: 40,
//                             ),
//                             Text(
//                               "Camera",
//                               style: GoogleFonts.poppins(
//                                 fontWeight: FontWeight.w300,
//                                 color: Colors.white,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       galleryImage(context);
//                     },
//                     child: Container(
//                       height: 100,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         color: Colors.blue,
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.black, width: 1),
//                       ),
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.photo,
//                               color: Colors.white,
//                               size: 40,
//                             ),
//                             Text(
//                               "Gallery",
//                               style: GoogleFonts.poppins(
//                                 fontWeight: FontWeight.w300,
//                                 color: Colors.white,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 300,
//                     width: 300,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         width: 1,
//                         color: Colors.black,
//                       ),
//                     ),
//                     child: FittedBox(
//                       fit: BoxFit.fill,
//                       child: image == null
//                           ? Lottie.asset("assets/json/no_image.json")
//                           : Image.file(image!),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       if (image != null) {
//                         final imageBytes = image!.readAsBytesSync();
//                         var box = await Hive.openBox("mobile_wallet");
//                         box.put("cards", imageBytes);
//                       }
//                       setState(() {});
//                     },
//                     child: Container(
//                       child: RichText(
//                         text: TextSpan(children: [
//                           TextSpan(
//                             text: "Add to ",
//                             style: GoogleFonts.openSans(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w400,
//                               color: const Color(0xff000000),
//                             ),
//                           ),
//                           TextSpan(
//                             text: "Wallet",
//                             style: GoogleFonts.openSans(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.red,
//                             ),
//                           )
//                         ]),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Your gym cards are:",
//                     style: GoogleFonts.openSans(
//                         fontWeight: FontWeight.bold, color: Colors.black),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   FutureBuilder(
//                     future: Hive.openBox("mobile_wallet"),
//                     builder: (context, snapshot) {
//                       final imageBytes =
//                           snapshot.data?.get("cards") as List<int>?;

//                       return InkWell(
//                         onTap: () {
//                           if (imageBytes != null) {
//                             _showImageDialog(
//                                 context, Uint8List.fromList(imageBytes));
//                           }
//                         },
//                         child: Container(
//                           height: 100,
//                           width: 100,
//                           child: FittedBox(
//                             fit: BoxFit.fill,
//                             child: imageBytes != null
//                                 ? Image.memory(Uint8List.fromList(imageBytes))
//                                 : const Text("No image"),
//                           ),
//                         ),
//                       );
//                     },
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
