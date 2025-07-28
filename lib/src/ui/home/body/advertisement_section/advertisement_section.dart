part of '../../home.dart';

class AdvertisementSection extends StatefulWidget {
  const AdvertisementSection({super.key});

  @override
  State<AdvertisementSection> createState() => _AdvertisementSectionState();
}

class _AdvertisementSectionState extends State<AdvertisementSection> {
  @override
  void initState() {
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
          // AdVideoPlayer(),
          Expanded(
            child: Center(
              child: Text(
                'Hello മലയാളം हिंदी',
                // style: TextStyle(
                  
                // ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              // height: double.maxFinite,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10).h,
                color: colorScheme.primaryContainer,
              ),
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
  late VideoPlayerController _controller;

  @override
  void initState() {
    try {
      _controller =
          VideoPlayerController.asset(
              'assets/video/video.mp4',
              videoPlayerOptions: VideoPlayerOptions(),
            )
            ..initialize()
            ..play().then((_) {
              // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
              setState(() {});
            });
      _controller.addListener(() {
        if (_controller.value.isCompleted) _controller.play();
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(8),
        child: VideoPlayer(_controller),
      ),
      // Image.asset('assets/images/myg.jpg', fit: BoxFit.fill),
    );
  }
}
