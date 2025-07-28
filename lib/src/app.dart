import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infotainment/src/ui/home/home.dart';
import 'package:infotainment/src/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: const Size(1920, 1080),
      child: DefaultTextStyle(
        style: TextStyle(
          fontFamilyFallback: [
            GoogleFonts.anekMalayalam().fontFamily ?? '',
            GoogleFonts.tiroDevanagariHindi().fontFamily ?? '',
          ],
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: theme,
          darkTheme: darkTheme,
          home: HomeScreen(),
        ),
      ),
    );
  }
}
