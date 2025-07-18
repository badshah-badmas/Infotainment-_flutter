import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fvp/fvp.dart' as fvp;
import 'package:infotainment/src/app.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  fvp.registerWith();
  runApp(const App());
}
