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
        child: BlocSelector<RouteInfoBloc, RouteInfoState, List<BusStopUI>>(
          selector: (state) {
            return state.routeStops;
          },
          builder: (context, routes) {
            return ListView.builder(
              itemCount: routes.length,
              itemBuilder: (context, index) {
                final position =
                    index == 0
                        ? StopItemPosition.first
                        : index == routes.length - 1
                        ? StopItemPosition.last
                        : StopItemPosition.middle;

                return StopListItemWidget(
                  stage: routes[index].stage,
                  stopName: routes[index].stopName,
                  position: position,
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
        child: Column(
          children: [
            Text('KZD-17A', style: Theme.of(context).textTheme.titleLarge),
            Text(
              'Palayam-Mavoor',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
