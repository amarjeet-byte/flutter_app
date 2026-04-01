import 'package:flutter/cupertino.dart';

class AppState extends ChangeNotifier {
  List<String> districtList = [
    "Araria", "Arwal", "Aurangabad", "Banka", "Begusarai", "Bettiah","Bhagalpur", "Bhojpur",
    "Buxur", "Darbhanga", "Gaya", "Gopalganj", "Jamui", "Jehanabad",
    "Kaimur", "Katihar", "Khagaria", "Kishanganj", "Lakhisarai", "Madhepura",
    "Madhubani", "Motihari", "Munger", "Muzaffarpur", "Nalanda", "Nawada", "Patna", "Purnia",
    "Rohtas", "Saharsa", "Samastipur", "Saran", "Sheikhpura", "Sheohar","Sitamarhi",
    "Siwan", "Supaul", "Vaishali",
  ];


  String district = "Bhagalpur";
  void setDistrict(String newDistrict) {
  district = newDistrict;
  notifyListeners();
  }
}