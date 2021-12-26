import 'package:eticon_desktop/project_widgets/input.dart';
import 'package:eticon_desktop/project_widgets/pj_button.dart';
import 'package:eticon_desktop/project_widgets/title_widget.dart';
import 'package:eticon_struct/eticon_structure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eticon_desktop/project_utils/pj_utils.dart';
import 'package:eticon_desktop/project_widgets/pj_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

class CreateSingletonScreen extends StatefulWidget {
  const CreateSingletonScreen({Key? key}) : super(key: key);

  @override
  _CreateSingletonScreenState createState() => _CreateSingletonScreenState();
}

class _CreateSingletonScreenState extends State<CreateSingletonScreen> {
  bool showError = false;
  TextEditingController contr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PjAppBar(
        title: 'Создание синглтон',
        leading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Input(
                controller: contr,
                hint: 'Введите название синглтона...',
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
                      text: 'Такой синглтон уже существует!',
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
              SizedBox(
                height: 15,
              ),
              PjButton(
                text: 'Создать синглтон',
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
                  bool res =
                      await struct.createSingleton(name);
                  if (res) {
                    Get.back();
                    Get.back();
                    Get.snackbar('Успех!', 'Синглтон ${name} создан',
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white,
                        borderRadius: 0,
                        margin: EdgeInsets.all(0));
                  } else {
                    Get.back();
                    Get.snackbar('Ошибка!', 'Синглтон уже существует',
                        backgroundColor: Colors.red,
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white,
                        borderRadius: 0,
                        margin: EdgeInsets.all(0));
                  }
                },
                enable: contr.text.length > 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
