part of '../../home.dart';

class AdvertisementSection extends StatefulWidget {
  const AdvertisementSection({super.key});

  @override
  State<AdvertisementSection> createState() => _AdvertisementSectionState();
}

class _AdvertisementSectionState extends State<AdvertisementSection> {
  // final gps = GpsService();

  @override
  void initState() {
    // gps.start().then((value) {
    //   gps.stream.listen((data) {
    //     setState(() {
    //       text = '${data.latitude} : ${data.longitude}';
    //     });
    //   });
    // });
    super.initState();
  }

  // final YoutubePlayerController controller =
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return Expanded(
      flex: 3,
      child: Column(
        spacing: 8,
        children: [
          AdVideoPlayer(),
          Expanded(
            child: Container(
              // height: double.maxFinite,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10).h,
                color: colorScheme.primaryContainer,
              ),
              // child: Center(
              //   child: BlocBuilder<RouteInfoBloc, RouteInfoState>(
              //     builder: (context, state) {
              //       return Text(
              //         '${state.location != null ? state.stopProgressState?.stopInQuestion.getDistance(state.location!) : 'no location'} : ${state.stopProgressState?.stopInQuestion.location}: ${state.location} : index: ${state.index}',
              //       );
              //     },
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdVideoPlayer extends StatefulWidget {
  const AdVideoPlayer({super.key});

  @override
  State<AdVideoPlayer> createState() => _AdVideoPlayerState();
}

class _AdVideoPlayerState extends State<AdVideoPlayer> {
  // late VideoPlayerController _controller;

  @override
  void initState() {
    // _controller =
    //     VideoPlayerController.networkUrl(
    //         Uri.parse(
    //           'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    //         ),
    //       )
    //       ..initialize()
    //       ..play().then((_) {
    //         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //         setState(() {});
    //       });
    super.initState();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.white,
        child: Center(
          child: BlocBuilder<RouteInfoBloc, RouteInfoState>(
            builder: (context, state) {
              return Text(
                '${state.location != null ? state.stopProgressState?.stopInQuestion.getDistance(state.location!) : 'no location'} : ${state.stopProgressState?.stopInQuestion.location}: ${state.location} : index: ${state.index}',
                style: TextStyle(fontSize: 30),
              );
            },
          ),
        ),
      ),
      // Image.asset('assets/images/myg.jpg', fit: BoxFit.fill),
    );
  }
}
