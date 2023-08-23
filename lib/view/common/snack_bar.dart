import 'package:flutter/material.dart';
import 'package:form_builder/constants/constant.dart';

class CustomSnackBar {
  final BuildContext context;
  CustomSnackBar(this.context);

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> build(
    String snackMsg,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackMsg),
        backgroundColor: black,
        dismissDirection: DismissDirection.horizontal,
        duration: const Duration(milliseconds: 1500),
        elevation: 1,
        padding: const EdgeInsets.fromLTRB(30, 15, 10, 15),
        margin: const EdgeInsets.fromLTRB(20, 15, 20, 30),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
