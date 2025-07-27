import 'package:dart_periphery/dart_periphery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterpi_gstreamer_video_player/flutterpi_gstreamer_video_player.dart';
import 'package:infotainment/src/app.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  loadLibFromFlutterAssetDir(false);
  setCustomLibrary('/home/badmas/libperiphery_arm64.so');
  useLocalLibrary();
  FlutterpiVideoPlayer.registerWith();
  // init music here
  // init routes here
  // init ads here
  runApp(const App());
}
