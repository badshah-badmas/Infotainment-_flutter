part of '../home.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return ColoredBox(
      color: colorScheme.surfaceDim,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: BlocSelector<RouteInfoBloc, RouteInfoState, String>(
                selector: (state) {
                  return state.headerTitle;
                },
                builder: (context, headerTitle) {
                  return TextScroll(
                    headerTitle,
                    intervalSpaces: 1.sp.toInt(),
                    pauseBetween: Duration(seconds: 2),
                    delayBefore: Duration(seconds: 2),
                    velocity: Velocity(pixelsPerSecond: Offset(40, 0)),
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w400,
                    ),
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
                  color: colorScheme.primaryContainer,
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
                        intervalSpaces: 1.sp.toInt(),
                        
                        pauseBetween: Duration(seconds: 2),
                        delayBefore: Duration(seconds: 2),
                        velocity: Velocity(pixelsPerSecond: Offset(40, 0)),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.sp,
                        ),
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
