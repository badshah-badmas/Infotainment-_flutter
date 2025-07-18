part of './stop_list_items.dart';

class PositionIndicatorWidget extends StatelessWidget {
  const PositionIndicatorWidget({super.key, required this.stage});
  final StopPositionStage stage;
  @override
  Widget build(BuildContext context) {
    late final Color color;
    late final Color borderColor;
    switch (stage) {
      case StopPositionStage.upcoming:
        color = Theme.of(context).colorScheme.outline;
        borderColor = Colors.transparent;
        break;
      case StopPositionStage.approaching:
        color = Colors.amber;
        borderColor = Colors.white;
      case StopPositionStage.atStop:
        color = Colors.green;
        borderColor = Colors.white;
      case StopPositionStage.passed:
        color = Colors.white;
        borderColor = Theme.of(context).colorScheme.primary;
        break;
    }
    return Center(
      child: Container(
        height: 8.sp,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 1.sp, color: borderColor),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
