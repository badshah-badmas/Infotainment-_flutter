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
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _sliverKey = GlobalKey();

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
        child: BlocSelector<RouteInfoBloc, RouteInfoState, String>(
          selector: (state) {
            return state.language;
          },
          builder: (context, language) {
            return BlocSelector<
              RouteInfoBloc,
              RouteInfoState,
              StopProgressState?
            >(
              selector: (state) {
                return state.stopProgressState;
              },
              builder: (context, stopProgress) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  final context = _sliverKey.currentContext;
                  if (context == null) return;

                  // final box = context.findRenderObject() as RenderBox;
                  // final offset = box.localToGlobal(
                  //   Offset.zero,
                  //   ancestor: context.findRenderObject(),
                  // );
                  final scrollOffset = _scrollController.offset + 50;
                  _scrollController.animateTo(
                    scrollOffset,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                });
                if (stopProgress == null) return SizedBox();
                final visitedStops = stopProgress.visitedStops.toList();
                final upcomingStops = stopProgress.upcomingStops.toList();
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverList.builder(
                      itemCount: visitedStops.length,
                      itemBuilder: (context, index) {
                        final stop = visitedStops[index];
                        return StopListItemWidget(
                          key: ValueKey(stop.getName(language)),
                          stage: StopPositionStage.passed,
                          stopName: stop.getName(language),
                          position: stop.position,
                        );
                      },
                    ),
                    SliverToBoxAdapter(
                      child: StopListItemWidget(
                        key: _sliverKey,
                        stage: stopProgress.stopInQuestion.stage,
                        stopName: stopProgress.stopInQuestion.getName(language),
                        position: stopProgress.stopInQuestion.position,
                      ),
                    ),
                    SliverList.builder(
                      itemCount: upcomingStops.length,

                      itemBuilder: (context, index) {
                        final stop = upcomingStops[index];
                        return StopListItemWidget(
                          key: ValueKey(stop.getName(language)),
                          stage: StopPositionStage.upcoming,
                          stopName: stop.getName(language),
                          position: stop.position,
                        );
                      },
                    ),
                  ],
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
