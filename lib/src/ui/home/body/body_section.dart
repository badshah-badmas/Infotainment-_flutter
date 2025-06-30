part of '../home.dart';
class BodySection extends StatelessWidget {
  const BodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          spacing: 16,
          children: [RouteInfoSection(), AdvertisementSection()],
        ),
      ),
    );
  }
}
