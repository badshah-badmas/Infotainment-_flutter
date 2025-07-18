part of '../../home.dart';

class AdvertisementSection extends StatelessWidget {
  AdvertisementSection({super.key});
  // final YoutubePlayerController controller =
  //     YoutubePlayerController.fromVideoId(
  //       videoId: 'PXHjKTLd_W0',
  //       autoPlay: true,

  //       params: YoutubePlayerParams(),
  //     );
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
              child: Center(child: Text('${DateTime.now()}')),
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
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(
          'https://videos.pexels.com/video-files/2235742/2235742-hd_1280_720_30fps.mp4',
        ),
        videoPlayerOptions: VideoPlayerOptions(),
      )
      ..initialize().then((value) {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child:
          _controller.value.isInitialized
              ? VideoPlayer(_controller)
              : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                // child: YoutubePlayer(controller: controller),
              ),
    );
  }
}
