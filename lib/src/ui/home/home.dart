import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infotainment/src/bloc/route_info_bloc.dart';
import 'package:infotainment/src/const/enums.dart';
import 'package:infotainment/src/model/route_ui.dart';
import 'package:infotainment/src/ui/widgets/stop_list_items.dart';

import 'package:text_scroll/text_scroll.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

part './header/header_section.dart';
part './body/body_section.dart';

part './body/route_info_section/route_info_section.dart';
part './body/advertisement_section/advertisement_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final YoutubePlayerController controller;
  final bloc = RouteInfoBloc();
  @override
  void initState() {
    bloc.add(RouteInfoFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
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
              HeaderSection(),
              BodySection(),
              // Expanded(child: Container(color: Colors.amber)),
            ],
          ),
        ),
      ),
    );
  }
}
