part of './stop_list_items.dart';

class PositionVerticalLine extends StatefulWidget {
  const PositionVerticalLine({
    super.key,
    required this.position,
    required this.stage,
  });

  final StopItemPosition position;
  final StopPositionStage stage;

  @override
  State<PositionVerticalLine> createState() => _PositionVerticalLineState();
}

class _PositionVerticalLineState extends State<PositionVerticalLine> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    late final Color topColor;
    late final Color bottomColor;
    switch (widget.stage) {
      case StopPositionStage.passed:
        topColor = bottomColor = colorScheme.primary;
        break;
      case StopPositionStage.atStop:
      case StopPositionStage.approaching:
        topColor = colorScheme.primary;
        bottomColor = colorScheme.outline;
        break;
      default:
        topColor = bottomColor = colorScheme.outline;
    }
    return Column(
      children: [
        Expanded(
          child:
              widget.position != StopItemPosition.first
                  ? VerticalDivider(color: topColor, thickness: 1.sp)
                  : SizedBox(),
        ),
        Expanded(
          child:
              widget.position != StopItemPosition.last
                  ? VerticalDivider(color: bottomColor, thickness: 1.sp)
                  : SizedBox(),
        ),
      ],
    );
  }
}
