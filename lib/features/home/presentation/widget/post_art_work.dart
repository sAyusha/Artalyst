import 'package:flutter/material.dart';
import 'package:flutter_final_assignment/features/navbar/presentation/view/bottom_navigation/bottom_navigation_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/app_color_constant.dart';
import '../../../../core/common/widget/small_text.dart';

class PostArt extends ConsumerWidget {
  const PostArt({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    final gap = SizedBox(height: isTablet ? 15.0 : 10.0);
    return Container(
      padding: isTablet
          ? const EdgeInsets.fromLTRB(0, 20, 0, 20)
          : const EdgeInsets.fromLTRB(0, 10, 0, 10),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Sell Your Own Artwork",
            style: TextStyle(
              fontFamily: "Laila",
              fontSize: isTablet ? 30 : 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          gap,
          SizedBox(
            width: isTablet ? 650 : double.infinity,
            child: Text(
              "Let our experts find the best sales option for you to direct lisiting on Artalyst",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isTablet ? 25 : 19,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          gap,
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ButtomNavView(selectedIndex: 2,))
              );
            },
            child: const SmallText(
              text: "Submit",
              color: AppColorConstant.mainSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
