import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  String _photoName = "";
  String _qrCode = "";

  String get photoName => _photoName;
  String get qrCode => _qrCode;

  void setPhotoName(String name) {
    _photoName = name;
    notifyListeners(); 
  }

  void setQRCode(String code) {
    _qrCode = code;
    notifyListeners(); 
  }
}