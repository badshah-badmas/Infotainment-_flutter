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

class RoutesListWidget extends StatelessWidget {
  const RoutesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryContainer,
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
                if (stopProgress == null) return SizedBox();
                final visitedStops = stopProgress.visitedStops.toList();
                final upcomingStops = stopProgress.upcomingStops.toList();
                return CustomScrollView(
                  slivers: [
                    SliverList.builder(
                      itemCount: visitedStops.length,
                      itemBuilder: (context, index) {
                        final stop = visitedStops[index];
                        return StopListItemWidget(
                          stage: StopPositionStage.passed,
                          stopName: stop.getName(language),
                          position: stop.position,
                        );
                      },
                    ),
                    SliverToBoxAdapter(
                      child: StopListItemWidget(
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
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
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
                Text(
                  idAndName.first,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  idAndName.last,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
