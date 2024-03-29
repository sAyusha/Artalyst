import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_assignment/config/constants/size_config.dart';
import 'package:flutter_final_assignment/config/router/app_route.dart';
import 'package:flutter_final_assignment/features/home/domain/entity/home_entity.dart';
import 'package:flutter_final_assignment/features/home/domain/use_case/home_use_case.dart';
import 'package:flutter_final_assignment/features/home/presentation/viewmodel/home_viewmodel.dart';
import 'package:flutter_final_assignment/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter_final_assignment/features/profile/domain/use_case/profile_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';

import '../test/unit_test/home_unit_test.mocks.dart';
import '../test_data/profile_entity_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late HomeUseCase mockHomeUseCase;
  late ProfileUseCase mockProfileUseCase;
  late List<HomeEntity> homeEntity;
  late List<ProfileEntity> profileEntity;

  setUpAll(() async {
    mockHomeUseCase = MockHomeUseCase();
    mockProfileUseCase = MockProfileUseCase();
    homeEntity = [
      HomeEntity(
          image: "IMG-1690725538470.jpg",
          title: "Love & Hate 2",
          creator: "Juliana Yoshida",
          description: "This is the content of my art auction app.",
          startingBid: 1085.99,
          artType: "Upcoming",
          endingDate: DateTime.parse("2023-08-20 11:29"),
          upcomingDate: DateTime.parse("2023-08-20 11:29"),
          categories: "Painting")
    ];
        profileEntity = await getProfileTest();

    SizeConfig.screenWidth = 360; // Set the desired width value
    SizeConfig.screenHeight = 640; // Set the desired height value
  });

  testWidgets('Upcoming View', (tester) async {
    when(mockHomeUseCase.getAllArt())
        .thenAnswer((_) async => Right(homeEntity));
     when(mockProfileUseCase.getUserProfile())
        .thenAnswer((_) async => const Right([]));
     // Mock the response of getUserArts to return an empty list instead of executing the actual implementation.
    when(mockHomeUseCase.getUserArts())
      .thenAnswer((_) async => const Right([]));
    when(mockHomeUseCase.getAlertArts())
      .thenAnswer((_) async => const Right([]));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          homeViewModelProvider
              .overrideWith((ref) => HomeViewModel(mockHomeUseCase)),
        ],
        child: MaterialApp(
          routes: AppRoute.getApplicationRoute(),
          initialRoute: AppRoute.upcomingRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('UPCOMING'), findsOneWidget);
  });
}
