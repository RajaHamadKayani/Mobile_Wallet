import 'package:flutter/material.dart';
import 'package:mobile_wallet/card_name_screen/card_name_screen.dart';

class ProviderClass with ChangeNotifier {
  navigateToCategoriesScreen(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const CardNameScreen()));
    notifyListeners();
  }
}
