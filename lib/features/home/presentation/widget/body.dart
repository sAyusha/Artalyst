import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'categories.dart';
import 'featured_art.dart';
import 'featured_artist.dart';
import 'home_content_title.dart';
import 'post_art_work.dart';
import 'search_box.dart';
import 'upcoming_arts.dart';

class Body extends ConsumerStatefulWidget {
  const Body({super.key});

  @override
  ConsumerState<Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<Body> {
  final searchController = TextEditingController();

  double getHeight(Size size) {
    double shorterDimension = size.shortestSide;
    if (shorterDimension >= 600) {
      // Tablet height
      return size.height * 0.47;
    } else {
      // Mobile height
      return size.height * 0.4;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    final gap = SizedBox(height: isTablet ? 25.0 : 15.0);
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        gap,
        HeaderWithSearchBox(searchController: searchController),
        gap,

        const HomeContentTitle(
          text: 'Featured Art',
        ),
        const FeaturedArt(),
        gap,
// SizedBox(
        //   width: double.infinity,
        //   height: getHeight(size),
        //   child: ListView(
        //     scrollDirection: Axis.horizontal,
        //     children: const [
        //       ArtView(),
        //     ],
        //   ),
        // ),
        const Categories(),

        gap,
        const HomeContentTitle(
          text: 'Upcoming',
        ),
        gap,
        const UpcomingArt(),

        gap,
        const HomeContentTitle(
          text: 'Featured Artist',
        ),
        // gap,
        const FeaturedArtist(),
        gap,
        const PostArt(),
      ],
    );
  }
}
