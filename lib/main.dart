import 'package:flutter/material.dart';
import 'package:kindacode/games/tictactoa.dart';
import 'package:kindacode/provider/darkmodesettingprovider.dart';
import 'package:kindacode/provider/playersettingprovider.dart';
import 'package:kindacode/provider/soundeffectsettingprovider.dart';
import 'package:kindacode/screen/audioplayerscreeb.dart';
import 'package:kindacode/screen/chipscreen.dart';
import 'package:kindacode/screen/iconpicker.dart';
import 'package:kindacode/screen/imageslider.dart';
import 'package:kindacode/screen/scaffoldscreen.dart';
import 'package:kindacode/screen/tabscreen.dart';
import 'package:kindacode/screen/testscreen.dart';
import 'package:kindacode/screen/texttospeech.dart';
import 'package:kindacode/widgets/daterangepicker.dart';
import 'package:kindacode/widgets/youtubevideoplayer.dart';
import 'package:provider/provider.dart';

import 'code/listwheelsample.dart';
import 'screen/borderedelevatedbutton.dart';
import 'screen/confetti.dart';
import 'screen/convexbottomnavigationbar.dart';
import 'screen/listwheelscrollviewwidget.dart';
import 'screen/sliders.dart';
import 'screen/transparentmodal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkModeSettingProvider>(
            create: (context) => DarkModeSettingProvider()),
        ChangeNotifierProvider<PlayerSettingProvider>(
          create: ((context) => PlayerSettingProvider()),
        ),
        ChangeNotifierProvider<SoundEffectSettingProvider>(
          create: ((context) => SoundEffectSettingProvider()),
        )
      ],
      child: Consumer<DarkModeSettingProvider>(
        builder: ((context, provider, child) => MaterialApp(
              title: 'Flutter Demo',
              themeMode: provider.isDarkModeEnabled()
                  ? ThemeMode.dark
                  : ThemeMode.light,
              darkTheme: ThemeData.dark(),
              theme: ThemeData(
                primarySwatch: Colors.amber,
              ),
              home: ChipScreen(),
            )),
      ),
    );
  }
}
