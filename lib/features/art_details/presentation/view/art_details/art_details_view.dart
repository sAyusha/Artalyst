import 'package:flutter/material.dart';
import 'package:flutter_final_assignment/config/constants/app_color_constant.dart';
import 'package:flutter_final_assignment/features/bidding/presentation/view/bidding/bid_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/common/components/rounded_button_field.dart';
import '../../../../../core/common/widget/semi_big_text.dart';
import '../../../../home/domain/entity/home_entity.dart';
// import '../../../../home/presentation/viewmodel/home_viewmodel.dart';
import '../../../../navbar/presentation/view/bottom_navigation/bottom_navigation_bar.dart';
import '../../widget/art_image.dart';
import '../../widget/creator.dart';
import '../../widget/deadline.dart';
import '../../widget/previous_bidders.dart';

class ArtDetailsView extends ConsumerStatefulWidget {
  final HomeEntity? art;
  const ArtDetailsView({Key? key, this.art}) : super(key: key);

  @override
  ConsumerState<ArtDetailsView> createState() => _ArtDetailsViewState();
}

class _ArtDetailsViewState extends ConsumerState<ArtDetailsView> {
  bool _isArtExpired(HomeEntity? art) {
    // ignore: unnecessary_null_comparison
    if (art == null || art.endingDate == null) {
      return true; // Treat as expired if the art or endingDate is null
    }
    return art.endingDate.isBefore(DateTime.now());
  }

  void showBottomSheet(BuildContext context, HomeEntity art) {
    showModalBottomSheet(
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
      ),
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.4,
          maxChildSize: 0.9,
          minChildSize: 0.32,
          builder: (context, scrollController) => SingleChildScrollView(
              controller: scrollController, child: BiddingView(art: art))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final art = widget.art;

    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    final gap = SizedBox(height: isTablet ? 18.0 : 16.0);

    // Check if the art has expired
    final bool isExpired = _isArtExpired(art);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          (art?.categories ?? "").toUpperCase(),
        ),
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back.svg"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ButtomNavView(selectedIndex: 0),
              ),
            );
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: AppColorConstant.lightNeutralColor4, width: 1.0),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: isTablet
              ? EdgeInsets.all(AppColorConstant.kDefaultPadding)
              : EdgeInsets.all(AppColorConstant.kDefaultPadding / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(alignment: Alignment.center, child: ArtImage(art: art!)),
              gap,
              Deadline(art: art),
              gap,
              Text(
                art.title,
                style: TextStyle(
                  fontSize: isTablet ? 32 : 24,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: isTablet ? 15 : 10),
              Text(
                art.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: isTablet ? 24 : 19,
                  fontWeight: FontWeight.w500,
                  height: isTablet ? 1.6 : 1.5,
                ),
              ),
              gap,
              const SemiBigText(
                text: "Creator",
                spacing: 0,
                // size: 22,
              ),
              SizedBox(height: isTablet ? 15 : 10),
              Creator(art: art),
              SizedBox(height: isTablet ? 15 : 10),
              const SemiBigText(text: "Top Bidders", spacing: 0),
              SizedBox(height: isTablet ? 15 : 10),
              SizedBox(
                  width: double.infinity,
                  height: isTablet ? 200 : 150,
                  child: const PreviousBidders(
                    
                  )),
              gap,
              // Show the button only if the art is not expired
              if (!isExpired)
                SizedBox(
                  width: double.infinity,
                  child: RoundedButton(
                    text: "Make a Bid",
                    press: () async {
                      // await ref.watch(homeViewModelProvider.notifier).getArtById(art.artId!);
                      showBottomSheet(context, art);
                    },
                  ),
                ),
              if (isExpired) // Show a message if the art is expired
                Center(
                  child: Text(
                    "This art has expired and is no longer available for bidding.",
                    style: TextStyle(
                      fontSize: isTablet ? 24 : 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
