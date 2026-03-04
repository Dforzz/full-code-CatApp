import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) => _checkAuth();

  RouteSettings? _checkAuth() {
    final auth = FirebaseAuth.instance;
    
    if (auth.currentUser != null) {
      return const RouteSettings(name: '/home');
    }
    return null;
  }
}