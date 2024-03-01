import 'dart:async';

import 'package:flutter/material.dart';

import '../../../config/constants/app_color_constant.dart';
// import '../widget/small_text.dart';

void showNotification(BuildContext context, String message, {IconData? icon}) {
  final screenSize = MediaQuery.of(context).size;
  final isTablet = screenSize.width > 600;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppColorConstant.kDefaultPadding, vertical: 10),
            decoration: BoxDecoration(
              color: AppColorConstant.whiteTextColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: AppColorConstant.successColor,
                    size: 40,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
                Text( 
                  message,
                  style: TextStyle(
                    fontSize: isTablet ? 22 : 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  // Close the dialog after 2 seconds
  Timer(const Duration(seconds: 2), () {
    Navigator.of(context).pop();
  });
}
