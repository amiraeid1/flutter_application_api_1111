import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'user/user.dart';
import 'package:riverpod/riverpod.dart';

final fetchUsersFromApi = FutureProvider<User?>((ref) async {
  try {
    var response = await Dio().get("https://reqres.in/api/users");
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    }
  } on Exception catch (e) {
    debugPrint("$e");
  }
  return null;
});

