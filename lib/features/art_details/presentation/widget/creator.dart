import 'package:flutter/material.dart';
import 'package:flutter_final_assignment/core/common/components/show_alert_dialog.dart';
import 'package:flutter_final_assignment/features/home/domain/entity/home_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/app_color_constant.dart';
import '../../../../core/common/widget/small_text.dart';

class Creator extends ConsumerStatefulWidget {
  final HomeEntity art;
  const Creator({
    super.key,
    required this.art,
  });

  @override
  ConsumerState<Creator> createState() => _CreatorState();
}

class _CreatorState extends ConsumerState<Creator> {
  @override
  Widget build(BuildContext context) {
    final art = widget.art;
    // final homeState = ref.watch(homeViewModelProvider);
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    final gap = SizedBox(height: isTablet ? 15.0 : 10.0);
    return Card(
      color: AppColorConstant.primaryAccentColor,
      shadowColor: AppColorConstant.primaryAccentColor,
      elevation: 0,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: AppColorConstant.mainTeritaryColor,
            radius: isTablet ? 30 : 24,
            backgroundImage: const NetworkImage(
                "https://flyclipart.com/thumb2/person-137537.png"),
          ),
          gap,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: isTablet
                      ? const EdgeInsets.only(left: 20.0)
                      : const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title
                      Text(
                        // "John Doe",
                        art.creator,
                        style: TextStyle(
                          fontSize: isTablet ? 26 : 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // subtitle
                      Text(
                        "Artist",
                        style: TextStyle(
                          fontSize: isTablet ? 22 : 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showNotification(context, "Following",
                  icon: Icons.check_circle_outline_rounded);
            },
            child: SmallText(
              text: "Follow",
              color: AppColorConstant.whiteTextColor,
              // size: 14,
            ),
          ),
        ],
      ),
    );
  }
}
