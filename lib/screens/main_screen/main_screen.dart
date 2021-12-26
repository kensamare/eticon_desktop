import 'dart:io';

import 'package:eticon_desktop/project_widgets/pj_button.dart';
import 'package:eticon_desktop/screens/create_cubit_screen/create_cubit_screen.dart';
import 'package:eticon_desktop/screens/create_project_screen/create_project_screen.dart';
import 'package:eticon_desktop/screens/create_screen/create_screen.dart';
import 'package:eticon_desktop/screens/create_singleton_screen/create_singleton_screen.dart';
import 'package:eticon_desktop/screens/json_to_dart_screen/json_to_dart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eticon_desktop/project_utils/pj_utils.dart';
import 'package:eticon_desktop/project_widgets/pj_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:desktop_window/desktop_window.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  SizedBox s15 = SizedBox(
    height: 15,
  );

  @override
  void initState() {
    DesktopWindow.setWindowSize(Size(500, 600));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool create = false;
    if (Directory('${SgMetadata.instance.dir}lib/project_utils').existsSync()) {
      create = true;
    }
    print(SgMetadata.instance.dir.split('/'));
    return Scaffold(
      appBar: PjAppBar(
        title: 'Проект: ' + SgMetadata.instance.dir.substring(0, SgMetadata.instance.dir.length - 1).split('/').last,
      ),
      body: Center(
        child: Column(

          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 40,
            ),
            PjButton(
              text: 'Создать структуру',
              enable: !create,
                onTap: () {
                  Get.to(() => CreateProjectScreen())!.then((value){
                    setState(() {
                    });
                  });
                },
            ),
            s15,
            PjButton(
              text: 'Создать экран',
              enable: create,
              onTap: () {
                Get.to(() => CreateScreen());
              },
            ),
            s15,
            PjButton(text: 'Создать синглтон', enable: create,
              onTap: () {
                Get.to(() => CreateSingletonScreen());
              },),
            s15,
            PjButton(text: 'Создать кубит(вне экрана)', enable: create,
                onTap: () {
                  Get.to(() => CreateCubitScreen());
                }),
            s15,
            PjButton(text: 'Json2Dart', enable: true,
                onTap: () {
                  Get.to(() => JsonToDartScreen());
                }),
          ],
        ),
      ),
    );
  }
}
