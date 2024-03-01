import 'package:flutter/material.dart';
import 'package:flutter_final_assignment/config/constants/app_color_constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'explore_upcoming_view.dart';

class Body extends ConsumerWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    return SingleChildScrollView(
      child: Padding(
        padding: isTablet 
                ? EdgeInsets.all(AppColorConstant.kDefaultPadding)
                : EdgeInsets.all(AppColorConstant.kDefaultPadding / 2),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ExploreUpcoming(),
          ],
        ),
      ),
    );
  }
}
