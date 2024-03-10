import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
          height: 40,
          width: 120,
          child: SvgPicture.asset("assets/logo.svg", color: Colors.white)),
    );
  }
}
