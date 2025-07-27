import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infotainment/src/const/enums.dart';
import 'package:text_scroll/text_scroll.dart';

part './position_vertical_line.dart';
part './position_indicator.dart';

class StopListItemWidget extends StatelessWidget {
  const StopListItemWidget({
    super.key,
    this.position = StopItemPosition.middle,
    this.stage = StopPositionStage.upcoming,
    required this.stopName,
  });
  final StopItemPosition position;
  final StopPositionStage stage;
  final String stopName;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5,
      child: Row(
        children: [
          AspectRatio(
            key: ValueKey(position),
            aspectRatio: 1,
            child: Stack(
              children: [
                Positioned.fill(
                  child: PositionVerticalLine(position: position, stage: stage),
                ),
                Positioned.fill(child: PositionIndicatorWidget(stage: stage)),
              ],
            ),
          ),
          Expanded(
            child: _TextPart(key: ValueKey(stopName), stopName: stopName),
          ),
        ],
      ),
    );
  }
}

class _TextPart extends StatelessWidget {
  const _TextPart({super.key, required this.stopName});

  final String stopName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),

      width: double.maxFinite,
      child: TextScroll(
        stopName,
        key: ValueKey(stopName),
        intervalSpaces: 1.sp.toInt(),
        pauseBetween: Duration(seconds: 2),
        delayBefore: Duration(seconds: 2),
        velocity: Velocity(pixelsPerSecond: Offset(40, 0)),
        style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w600),
      ),
    );
  }
}
