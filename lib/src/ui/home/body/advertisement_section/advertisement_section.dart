part of '../../home.dart';

class AdvertisementSection extends StatelessWidget {
  AdvertisementSection({super.key});
  final YoutubePlayerController controller =
      YoutubePlayerController.fromVideoId(
        videoId: 'PXHjKTLd_W0',
        autoPlay: true,

        params: YoutubePlayerParams(),
      );
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        spacing: 8,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              // child: YoutubePlayer(controller: controller),
            ),
          ),
          Expanded(
            child: Container(
              // height: double.maxFinite,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Center(
                child: FilledButton(
                  onPressed: () {
                    BusRouteRepo.initializeRoute();
                  },
                  child: Text('Click'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
