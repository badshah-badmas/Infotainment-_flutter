part of './stop_list_items.dart';

class PositionVerticalLine extends StatelessWidget {
  const PositionVerticalLine({
    super.key,
    required this.position,
    required this.stage,
  });

  final StopItemPosition position;
  final StopPositionStage stage;

  @override
  Widget build(BuildContext context) {
    late final Color topColor;
    late final Color bottomColor;
    switch (stage) {
      case StopPositionStage.passed:
        topColor = bottomColor = Theme.of(context).colorScheme.primary;
        break;
      case StopPositionStage.atStop:
      case StopPositionStage.approaching:
        topColor = Theme.of(context).colorScheme.primary;
        bottomColor = Theme.of(context).colorScheme.outline;
        break;
      default:
        topColor = bottomColor = Theme.of(context).colorScheme.outline;
    }
    return Column(
      children: [
        Expanded(
          child:
              position != StopItemPosition.first
                  ? VerticalDivider(color: topColor)
                  : SizedBox(),
        ),
        Expanded(
          child:
              position != StopItemPosition.last
                  ? VerticalDivider(color: bottomColor)
                  : SizedBox(),
        ),
      ],
    );
  }
}
