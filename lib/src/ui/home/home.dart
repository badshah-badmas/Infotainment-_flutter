import 'package:flutter/material.dart';
import 'package:infotainment/src/const/enums.dart';

import 'package:text_scroll/text_scroll.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final YoutubePlayerController controller;
  @override
  void initState() {
    controller = YoutubePlayerController.fromVideoId(
      params: YoutubePlayerParams(
        enableJavaScript: true,
        showFullscreenButton: false,
        showControls: false,
        loop: true,
        playsInline: true,
        showVideoAnnotations: false,
        mute: true,
      ),
      videoId: 'kzPFIme3U7o',
      autoPlay: true,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment(0.2, 0.2),
            stops: [0.2, 0.5],
            colors: [
              Theme.of(context).colorScheme.surfaceBright,
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: Column(
          children: [
            ColoredBox(
              color: Theme.of(context).colorScheme.surfaceDim,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Next Stop',
                        style: Theme.of(context).textTheme.headlineMedium,
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
                          child: TextScroll(
                            'Koyilandy railway station stop',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 8,
                        children: [
                          Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 10,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'KZD-17A',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    'Palayam-Mavoor',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                              ),
                              child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  late final stage;
                                  if (index < 5) {
                                    stage = StopPositionStage.passed;
                                  } else if (index == 5) {
                                    stage = StopPositionStage.atStop;
                                  } else if (index == 6) {
                                    stage = StopPositionStage.approaching;
                                  } else {
                                    stage = StopPositionStage.upcoming;
                                  }
                                  if (index == 0) {
                                    return StopListItemWidget(
                                      position: StopItemPosition.first,
                                      stage: stage,
                                    );
                                  } else if (index == 9) {
                                    return StopListItemWidget(
                                      position: StopItemPosition.last,
                                      stage: stage,
                                    );
                                  } else {
                                    return StopListItemWidget(stage: stage);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        spacing: 8,
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              // height: double.maxFinite,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Expanded(child: Container(color: Colors.amber)),
          ],
        ),
      ),
    );
  }
}

class StopListItemWidget extends StatelessWidget {
  const StopListItemWidget({
    super.key,
    this.position = StopItemPosition.middle,
    this.stage = StopPositionStage.upcoming,
  });
  final StopItemPosition position;
  final StopPositionStage stage;

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
              child: Text('Kozhikode'),
            ),
          ),
        ],
      ),
    );
  }
}

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
        height: 15,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 2, color: borderColor),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
