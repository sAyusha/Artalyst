import 'package:flutter/material.dart';
import 'package:flutter_final_assignment/config/constants/app_color_constant.dart';
import 'package:flutter_final_assignment/config/constants/size_config.dart';
import 'package:flutter_final_assignment/core/common/widget/small_text.dart';
import 'package:flutter_final_assignment/features/art_details/presentation/view/art_details/art_details_view.dart';
import 'package:flutter_final_assignment/features/home/domain/entity/home_entity.dart';
import 'package:flutter_final_assignment/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../home/presentation/viewmodel/home_viewmodel.dart';
import '../viewmodel/profile_viewmodel.dart';

class PostedArt extends ConsumerStatefulWidget {
  const PostedArt({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<PostedArt> createState() => _PostedArtState();
}

class _PostedArtState extends ConsumerState<PostedArt> {

  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(profileViewModelProvider);
    List<ProfileEntity> userData = userState.userData;

    var userArtsState = ref.watch(homeViewModelProvider);
    List<HomeEntity> userArts = userArtsState.userArts;

    if (userData.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(), // Show loader
      );
    }

    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;

    return SingleChildScrollView(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: isTablet ? 225 / 260 : 95 / 130,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: userArts.length,
        itemBuilder: (context, index) {
          if (userArts.isEmpty) {
            return const Center(
              child: SmallText(
                text: 'You have not posted any arts yet.',
              ),
            );
          }
          final art = userArts[index];
          //check is the artType is "Recent"
          if (art.artType == "Recent") {
            // Check if the endDate has passed the current date and time
            final isExpired = art.endingDate.isBefore(DateTime.now());
            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onDoubleTap: () {
                      if (!isExpired) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ArtDetailsView(art: art)),
                        );
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        art.image == ""
                            ? "https://i.pinimg.com/564x/17/99/92/179992c2d7c70f86bfba2726f9e29afd.jpg"
                            : '${ApiEndpoints.baseUrl}/uploads/${art.image}',
                        fit: isTablet ? BoxFit.fill : BoxFit.cover,
                        width: isTablet ? 350 : 250,
                        height: isTablet ? 350 : 190,
                      ),
                    ),
                  ),
                  SizedBox(height: isTablet ? 15.0 : 5.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        art.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isTablet ? 26 : 20,
                        ),
                      ),
                      if (isExpired) // Show "Expired" text for expired arts
                        SmallText(
                            text: "(Expired)",
                            color: AppColorConstant.errorColor),
                      // Text(
                      //   "posted by @${userData[0].username}",
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: isTablet ? 22 : 18,
                      //     color: AppColorConstant.neutralColor,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            );
          }
          // If the artType is "upcoming", return an empty container to exclude it from the grid
          return Container();
        },
      ),
    );
  }
}
