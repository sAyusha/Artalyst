import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_assignment/config/constants/app_color_constant.dart';
import 'package:flutter_final_assignment/features/profile/presentation/viewmodel/logout_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/app.dart';
import '../../../../../core/common/widget/small_text.dart';
import '../../widget/body.dart';

class ProfilePageView extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ProfilePageView({super.key});

  @override
  ConsumerState<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends ConsumerState<ProfilePageView> {
  double _proximityValue = 0;
  final List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(proximityEvents!.listen((ProximityEvent event) {
      setState(() {
        _proximityValue = event.proximity;
        if (_proximityValue < 0.2) {
          // Change the theme to dark
          ref.read(themeProvider).isDark = true;
        } else {
          // Change the theme to light
          ref.read(themeProvider).isDark = false;
        }
      });
    }));
  }

  @override
  void dispose() {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = ref.watch(themeProvider);
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back.svg"),
          onPressed: () {
            // setState(() {
            //   Navigator.pushNamed(context, '/logInRoute');
            // });
          },
        ),
        title: const Text(
          'PROFILE',
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
            )),
        actions: [
          IconButton(
            onPressed: () {
              // ref.read(logoutViewModelProvider.notifier).logout(context);
              // themeNotifier.isDark = !themeNotifier.isDark;

              widget.scaffoldKey.currentState?.openEndDrawer();
            },
            icon: Icon(
              Icons.settings,
              size: isTablet ? 35 : 25,
              color: AppColorConstant.neutralColor,
            ),
          ),
        ],
      ),
      body: const Body(),
      endDrawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: Column(
            children: <Widget>[
              TextButton(
                  onPressed: () {
                    ref.read(logoutViewModelProvider.notifier).logout(context);
                  },
                  child:
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallText(text: 'Logout'),
                          Icon(Icons.logout), 
                        ]
                      ),
                    ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SmallText(text: 'Appearance'),
                  IconButton(
                      onPressed: () {
                        themeNotifier.isDark = !themeNotifier.isDark;
                      },
                      icon: const Icon(Icons.brightness_4)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
