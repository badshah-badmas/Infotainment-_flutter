part of '../../home.dart';

class RouteInfoSection extends StatelessWidget {
  const RouteInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        spacing: 8,
        children: [RouteInfoHeader(), RoutesListWidget()],
      ),
    );
  }
}

class RoutesListWidget extends StatefulWidget {
  const RoutesListWidget({super.key});

  @override
  State<RoutesListWidget> createState() => _RoutesListWidgetState();
}

class _RoutesListWidgetState extends State<RoutesListWidget> {
  final _scrollController = IndexedScrollController(initialScrollOffset: 1);

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return Expanded(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorScheme.primaryContainer,
        ),
        child: BlocConsumer<RouteInfoBloc, RouteInfoState>(
          listenWhen: (previous, current) {
            return previous.stopInQuestionIndex != current.stopInQuestionIndex;
          },
          listener: (context, state) {
            if (state.stopInQuestionIndex != null) {
              if (state.stopInQuestionIndex! >= 3) {
                _scrollController.jumpTo(state.stopInQuestionIndex! - 3);
              } else {
                _scrollController.jumpToIndex(0);
              }
            }
          },
          builder: (context, state) {
            final stopList = state.stopList;
            final language = state.language;
            if (stopList.isEmpty) return SizedBox();
            return IndexedListView.builder(
              key: ValueKey('routeBuilder'),
              controller: _scrollController,
              maxItemCount: stopList.length - 1,
              minItemCount: 3,
              itemBuilder: (context, index) {
                final stop = stopList[index];
                return StopListItemWidget(
                  key: ValueKey(stop.getName(language)),
                  stage: stop.stage,
                  stopName: stop.getName(language),
                  position: stop.position,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class RouteInfoHeader extends StatelessWidget {
  const RouteInfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colorScheme.primaryContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: BlocSelector<RouteInfoBloc, RouteInfoState, List<String>>(
          selector: (state) {
            return [state.routeId, state.routeName];
          },
          builder: (context, idAndName) {
            return Column(
              children: [
                TextScroll(
                  idAndName.first,
                  intervalSpaces: 1.sp.toInt(),
                  pauseBetween: Duration(seconds: 2),
                  delayBefore: Duration(seconds: 2),
                  velocity: Velocity(pixelsPerSecond: Offset(40, 0)),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextScroll(
                  idAndName.last,
                  intervalSpaces: 1.sp.toInt(),
                  pauseBetween: Duration(seconds: 2),
                  delayBefore: Duration(seconds: 2),
                  velocity: Velocity(pixelsPerSecond: Offset(40, 0)),
                  style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
