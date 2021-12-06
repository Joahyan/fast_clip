import 'dart:io';

import 'package:fast_clip/pages/index.dart';
import 'package:fast_clip/route/route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'config/theme.dart';

void main() async{

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };

  // 确保初始化
  WidgetsFlutterBinding.ensureInitialized();
  // 缓存初始化
  // await StorageManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO判断是否登陆
    return MaterialApp(
      navigatorKey: navGk,
      title: 'Flutter Blog 练习',
      theme: ThemeData(
          scaffoldBackgroundColor: secondBgColor,
          hintColor: Colors.grey.withOpacity(0.3),
          splashColor: Colors.transparent,
          canvasColor: Colors.transparent
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) {
          return IndexPage();
        }
      },
    );
  }
}