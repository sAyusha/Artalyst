import 'package:flutter/material.dart';
import 'package:flutter_final_assignment/config/constants/app_color_constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../widget/body.dart';

// import 'components/body.dart';

class PostArtView extends ConsumerWidget {
   const PostArtView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
        'NEW ART',   
      ),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColorConstant.lightNeutralColor4, width: 1.0),
              ),
            ),
          )),
      ),
      body:  const Body(),
    );
  }
}
