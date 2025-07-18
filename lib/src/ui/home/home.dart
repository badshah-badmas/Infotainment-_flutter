import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infotainment/src/bloc/route_info_bloc.dart';
import 'package:infotainment/src/const/enums.dart';
import 'package:infotainment/src/repo/service.dart';
import 'package:infotainment/src/ui/widgets/stop_list_items.dart';

import 'package:text_scroll/text_scroll.dart';
import 'package:video_player/video_player.dart';

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
  final bloc = RouteInfoBloc();
  @override
  void initState() {
    bloc.add(RouteInfoFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(30).h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              end: Alignment(0.2, 0.2),
              stops: [0.2, 0.5],
              colors: [colorScheme.surfaceBright, colorScheme.surface],
            ),
          ),
          child: Column(children: [HeaderSection(), BodySection()]),
        ),
      ),
    );
  }
}
