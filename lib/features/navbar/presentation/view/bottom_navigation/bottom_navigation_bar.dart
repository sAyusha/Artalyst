import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../home/presentation/view/home/home_page_view.dart';
import '../../../../home/presentation/viewmodel/home_viewmodel.dart';
import '../../../../post/presentation/view/post/post_art_view.dart';
import '../../../../profile/presentation/view/profile/profile_page_view.dart';
import '../../../../profile/presentation/viewmodel/profile_viewmodel.dart';
import '../../../../upcoming/presentation/view/upcoming/upcoming_page_view.dart';
import '../../../../updates/presentation/view/updates/updates_page_view.dart';

// import '../home/home_page_view.dart';

class ButtomNavView extends ConsumerStatefulWidget {
  final int selectedIndex;

  const ButtomNavView({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  ConsumerState<ButtomNavView> createState() => _ButtomNavViewState();
}

class _ButtomNavViewState extends ConsumerState<ButtomNavView> {
  int _selectedIndex = 0;

  List<Widget> lstBottomScreen = [
    const HomePageView(),
    const UpcomingPageView(),
    const PostArtView(),
    const UpdatesPageView(),
    ProfilePageView()
  ];
  
  final double shakeThreshold = 15.0;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.selectedIndex;
    _accelerometerSubscription =
        accelerometerEvents?.listen((AccelerometerEvent? event) {
      if (event != null) {
        // Access accelerometer data here
        double x = event.x;
        double y = event.y;
        double z = event.z;

        // Implement shake detection logic here and change the bottom navigation index accordingly
        if (x.abs() > shakeThreshold ||
            y.abs() > shakeThreshold ||
            z.abs() > shakeThreshold) {
          setState(() {
            _selectedIndex = (_selectedIndex + 1) % lstBottomScreen.length;
          });
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider.notifier).getAllArt();
      ref.read(profileViewModelProvider.notifier).getUserProfile();
      ref.read(homeViewModelProvider.notifier).getUserArts();
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    // final gap = SizedBox(height: isTablet ? 5.0 : 20.0);
    return Scaffold(
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: isTablet ? 40 : 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore_outlined,
              size: isTablet ? 40 : 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_rounded,
              size: isTablet ? 40 : 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.update_outlined,
              size: isTablet ? 40 : 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: isTablet ? 40 : 30,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
