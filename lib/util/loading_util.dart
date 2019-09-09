import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:IVAT/public_func/PublicFunc.dart';
import 'package:IVAT/global_config.dart';

class Loading extends StatelessWidget {
  Loading({@required this.child, this.title});
  final Widget child, title;
  @override
  Widget build(BuildContext context) {
    if (PublicFunc.loading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitWave(
            color: GlobalConfig.dark
                ? Colors.white
                : GlobalConfig.themeData.primaryColor,
            width: 50,
            height: 50,
            type: SpinKitWaveType.center,
          ),
          title
        ],
      );
    } else {
      return child;
    }
  }
}
