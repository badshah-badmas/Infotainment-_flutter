import 'package:flutter/material.dart';
import 'package:infotainment/src/const/enums.dart';

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
            child: Container(
              margin: EdgeInsets.all(2),

              width: double.maxFinite,
              child: Text(stopName),
            ),
          ),
        ],
      ),
    );
  }
}
