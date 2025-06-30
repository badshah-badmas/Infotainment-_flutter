part of '../home.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceDim,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: BlocSelector<RouteInfoBloc, RouteInfoState, String>(
                selector: (state) {
                  return state.headerTitle;
                },
                builder: (context, headerTitle) {
                  return Text(
                    headerTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: AspectRatio(
              aspectRatio: 9.5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10),
                  ),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: BlocSelector<RouteInfoBloc, RouteInfoState, String>(
                    selector: (state) {
                      return state.header;
                    },
                    builder: (context, header) {
                      return TextScroll(
                        header,
                        style: Theme.of(context).textTheme.headlineLarge,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
