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

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  bool showError = false;
  int stf = 0;
  int cubit = 0;
  TextEditingController contr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PjAppBar(
        title: 'Создание экран',
        leading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Input(
                controller: contr,
                hint: 'Введите название экрана...',
                onChanged: (v) {
                  setState(() {

                  });
                },
              ),
              if (showError) ...[
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    PjText(
                      text: 'Такой экран уже существует!',
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
              const SizedBox(
                height: 15,
              ),
              const TitleWidget(
                text: 'Тип виджета',
              ),
              const SizedBox(
                height: 15,
              ),
              GroupButton(
                isRadio: true,
                spacing: 40,
                selectedButton: 0,
                // selectedButtons: [0],
                borderRadius: BorderRadius.circular(5.0),
                onSelected: (index, isSelected) => stf = index,
                buttons: const [
                  "Stateless",
                  "Stateful",
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const TitleWidget(
                text: 'Кубит',
              ),
              const SizedBox(
                height: 15,
              ),
              GroupButton(
                isRadio: true,
                spacing: 40,
                selectedButton: 0,
                // selectedButtons: [0],
                borderRadius: BorderRadius.circular(5.0),
                onSelected: (index, isSelected) => cubit = index,
                buttons: const [
                  "С кубитом",
                  "Без кубита",
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              PjButton(
                text: 'Создать экран',
                enable: contr.text.length > 1,
                onTap: () async {
                  Get.dialog(
                    Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    barrierDismissible: false,
                    barrierColor: Colors.white.withOpacity(0.3),
                  );
                  String name = contr.text;
                  if(name.endsWith('_screen')){
                    name = name.substring(0, name.length-7);
                  } else if(name.endsWith('_')){
                    name = name.substring(0, name.length-1);
                  }
                  EticonStruct struct =
                  EticonStruct(projectDir: SgMetadata.instance.dir);
                  await struct.checkGit();
                  bool res = await struct.createScreen(name, stf == 1, cubit == 0);
                  if (res) {
                    Get.back();
                    Get.back();
                    Get.snackbar('Успех!', 'Экран ${name}_screen создан',
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white,
                        borderRadius: 0,
                        margin: EdgeInsets.all(0));
                  } else {
                    Get.back();
                    Get.snackbar('Ошибка!', 'Экран уже существует',
                        backgroundColor: Colors.red,
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white,
                        borderRadius: 0,
                        margin: EdgeInsets.all(0));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
