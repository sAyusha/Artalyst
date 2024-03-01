import 'package:flutter/material.dart';
import 'package:flutter_final_assignment/features/auth/presentation/view/signup/components/body.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPageView extends ConsumerWidget {
  const SignUpPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Body(
        child: Column(),
      ),
    );
  }
}