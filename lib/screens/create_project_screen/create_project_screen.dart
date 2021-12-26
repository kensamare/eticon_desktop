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

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({Key? key}) : super(key: key);

  @override
  _CreateProjectScreenState createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  int stf = 0;
  int cubit = 0;
  List<String> libr = [
    'eticon_api',
    'get',
    'flutter_screenutil',
    'flutter_bloc',
    'flutter_svg',
    'get_storage',
    'sentry_flutter',
    'intl',
  ];

  List<int> indexList = [];

  @override
  void initState() {
    for (int i = 0; i < libr.length; i++) {
      indexList.add(i);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PjAppBar(
        title: 'Создание проекта',
        leading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
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
              const TitleWidget(
                text: 'Библиотеки',
              ),
              const SizedBox(
                height: 15,
              ),
              GroupButton(
                isRadio: false,
                spacing: 20,
                runSpacing: 10,
                selectedButtons: indexList,
                borderRadius: BorderRadius.circular(5.0),
                onSelected: (index, isSelected) {
                  if (isSelected) {
                    if (!indexList.contains(index)) {
                      indexList.add(index);
                    }
                  } else {
                    if (indexList.contains(index)) {
                      indexList.remove(index);
                    }
                  }
                  print(indexList);
                },
                buttons: libr,
              ),
              const SizedBox(
                height: 30,
              ),
              PjButton(
                text: 'Создать структуру',
                enable: true,
                onTap: () async {
                  Get.dialog(
                    Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    barrierDismissible: false,
                    barrierColor: Colors.white.withOpacity(0.3),
                  );
                  List<String> libs = [];
                  for (int elm in indexList) {
                    libs.add(libr[elm]);
                  }
                  EticonStruct struct =
                      EticonStruct(projectDir: SgMetadata.instance.dir);
                  await struct.checkGit();
                  String res = await struct.createStructure(
                      stf: stf == 1, withCubit: cubit == 1, libs: libs);
                  if (res.isEmpty) {
                    Get.back();
                    Get.back();
                    Get.snackbar('Успех!', 'Структура создана!',
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.BOTTOM,
                        borderRadius: 0,
                    colorText: Colors.white,
                    margin: EdgeInsets.all(0));
                  } else {
                    Get.back();
                    Get.snackbar('Ошибка!', res,
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
