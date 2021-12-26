import 'dart:io';

import 'package:eticon_desktop/project_utils/pj_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:eticon_api/eticon_api.dart';
import 'package:window_size/window_size.dart';
import 'screens/main_screen/main_screen.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Eticon Struct Beta');
    setWindowMinSize(const Size(500, 600));
    setWindowMaxSize(Size.infinite);
  }
  if(args.isNotEmpty){
    SgMetadata.instance.setDir(args[0]);
  }
  // SgMetadata.instance.setDir('/Users/andrejkurakov/StudioProjects/test_creat_str/');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
    );
  }
}
  