import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:uquiz/members.dart';
import 'package:uquiz/shopping.dart';

import 'models.dart';

class UQuizController extends GetxController {
  var appName = 'uQuiz'.obs;
  var memberCount = 0.obs;
  var isAdmin = false.obs;
  var memberList = <Member>[].obs;
  final pb = PocketBase('http://127.0.0.1:8090');
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> authen(String email, String password) async {
    try {
      final res = pb.admins.authWithPassword(email, password);
      isAdmin = true.obs;
      print('admin logged in: ${email}');
      if (pb.authStore.isValid) {
        Get.to(()=> const MemberListPage());
      }
    } catch (e) {
      final res = pb.collection('users').authWithPassword(email, password);
      isAdmin = false.obs;
      print('user logged in: ${email}');
      if (pb.authStore.isValid) {
      Get.to(()=> const Shopping());
      }
    }
  }
}