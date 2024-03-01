import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_assignment/config/constants/app_color_constant.dart';
import 'package:flutter_final_assignment/config/router/app_route.dart';
import 'package:flutter_final_assignment/core/shared_preferences/user_shared_prefs.dart';
import 'package:flutter_final_assignment/features/home/presentation/widget/body.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../profile/presentation/viewmodel/logout_view_model.dart';

class HomePageView extends ConsumerStatefulWidget {
  const HomePageView({super.key});

  @override
  ConsumerState<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends ConsumerState<HomePageView> {
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
          UserSharedPrefs.clearSharedPrefs();
          ref.read(logoutViewModelProvider.notifier).logout(context);

          Navigator.pushReplacementNamed(context, AppRoute.loginRoute);
          // ignore: avoid_print
          print('logout');
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'AUCTIONS',
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
      ),
      body: const Body(),
    );
  }
}
