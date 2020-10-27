import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'themes.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primarygreen,
      child: Center(
        child: SpinKitChasingDots(
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
