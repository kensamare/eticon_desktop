import 'dart:io';

import 'package:eticon_desktop/project_widgets/input.dart';
import 'package:eticon_desktop/project_widgets/pj_button.dart';
import 'package:eticon_struct/eticon_structure.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eticon_desktop/project_utils/pj_utils.dart';
import 'package:eticon_desktop/project_widgets/pj_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateCubitScreen extends StatefulWidget {
  const CreateCubitScreen({Key? key}) : super(key: key);

  @override
  _CreateCubitScreenState createState() => _CreateCubitScreenState();
}

class _CreateCubitScreenState extends State<CreateCubitScreen> {
  bool showError = false;
  String path = 'Не выбрано';
  TextEditingController contr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PjAppBar(
        title: 'Создание кубита',
        leading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Input(
                controller: contr,
                hint: 'Введите название кубита...',
                onChanged: (v) {
                  setState(() {});
                },
              ),
              if (showError) ...[
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    PjText(
                      text: 'Такой кубит уже существует!',
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
              SizedBox(
                height: 15,
              ),
              PjText(
                text: path,
              ),
              SizedBox(
                height: 10,
              ),
              PjButton(text: 'Выбрать директорию', onTap: () async {
                String? path = await FilePicker.platform.getDirectoryPath();
                if(path != null) {
                  setState(() {
                    this.path = path;
                  });
                }
                },
              ),
              SizedBox(
                height: 15,
              ),
              PjButton(
                text: 'Создать кубит',
                onTap: () async {
                  Get.dialog(
                    Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    barrierDismissible: false,
                    barrierColor: Colors.white.withOpacity(0.3),
                  );
                  String name = contr.text;
                  if (name.endsWith('_')) {
                    name = name.substring(0, name.length - 1);
                  }
                  EticonStruct struct =
                  EticonStruct(projectDir: SgMetadata.instance.dir);
                  await struct.checkGit();
                  bool res = await struct.createCubitByPath(name, path);
                  if (res) {
                    Get.back();
                    Get.back();
                    Get.snackbar('Успех!', 'Кубит cb_${name} создан!',
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white,
                        borderRadius: 0,
                        margin: EdgeInsets.all(0));
                  } else {
                    Get.back();
                    Get.snackbar('Ошибка!', 'Кубит уже создан!',
                        backgroundColor: Colors.red,
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white,
                        borderRadius: 0,
                        margin: EdgeInsets.all(0));
                  }
                },
                enable: contr.text.length > 1 && path != 'Не выбрано',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
