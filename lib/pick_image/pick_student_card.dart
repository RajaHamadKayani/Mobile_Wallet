import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_wallet/card_name_screen/card_name_screen.dart';
import 'package:mobile_wallet/models/hive_model.dart';

class PickStudentCard extends StatefulWidget {
  const PickStudentCard({super.key});

  @override
  State<PickStudentCard> createState() => _PickStudentCardState();
}

class _PickStudentCardState extends State<PickStudentCard>
    with SingleTickerProviderStateMixin {
  var imageBox;
  List<Uint8List> imagesList = [];

  Future<void> getBoxName() async {
    imageBox = await Hive.openBox<Uint8List>("students_cards");
    imagesList = imageBox.values.toList();
    setState(() {});
  }

  Future<void> storeImage(Uint8List imageData) async {
    await imageBox.add(imageData);
    imagesList = imageBox.values.toList();
    setState(() {});
  }

  Future<void> removeImage(int index) async {
    await imageBox.deleteAt(index);
    imagesList = imageBox.values.toList();
    setState(() {});
  }

  Future<void> _showImageDialog(BuildContext context, Uint8List imageBytes) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 350,
            height: 450,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.memory(imageBytes),
            ),
          ),
        );
      },
    );
  }

  deleteImage(BuildContext context, int index) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Delete Image",
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Are you sure want to delete image?",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            actions: [
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.red),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () async {
                          await imageBox.deleteAt(index);
                          imagesList = imageBox.values.toList();
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Delete",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.blue),
                        )),
                  ],
                ),
              )
            ],
          );
        });
  }

  late AnimationController animationController;
  File? image;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    getBoxName();
  }

  Future<void> galleryImage(BuildContext context) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedImage != null) {
      final imageBytes = await pickedImage.readAsBytes();
      storeImage(Uint8List.fromList(imageBytes));
    }
  }

  Future<void> cameraImage(BuildContext context) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (pickedImage != null) {
      final imageBytes = await pickedImage.readAsBytes();
      storeImage(Uint8List.fromList(imageBytes));
    }
  }

  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pick Image",
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CardNameScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      cameraImage(context);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              "Camera",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      galleryImage(context);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              "Gallery",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: image == null
                          ? Lottie.asset("assets/json/no_image.json")
                          : Image.file(image!),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      if (imagesList != null) {
                        // final imageBytes = image!.readAsBytesSync();
                        // storeImage(Uint8List.fromList(imageBytes));
                        imageBox =
                            await Hive.openBox<Uint8List>("students_cards");
                        storeImage(ImagesData as Uint8List);
                      }
                      setState(() {});
                    },
                    child: Container(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Add to ",
                            style: GoogleFonts.openSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff000000),
                            ),
                          ),
                          TextSpan(
                            text: "Wallet",
                            style: GoogleFonts.openSans(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your gym cards are:",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: imagesList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ClipRRect(
                            child: InkWell(
                              onTap: () {
                                _showImageDialog(context, imagesList[index]);
                              },
                              onLongPress: () {
                                deleteImage(context, index);
                              },
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.memory(imagesList[index]),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
