import 'dart:convert';
import 'dart:developer';

import 'package:code_text_field/code_text_field.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eticon_desktop/project_utils/pj_utils.dart';
import 'package:eticon_desktop/project_widgets/pj_widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/json.dart';
import 'package:flutter_highlight/themes/idea.dart';
import 'package:flutter_highlight/themes/isbl-editor-light.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:eticon_struct/eticon_structure.dart';
import 'package:window_size/window_size.dart';


class JsonToDartScreen extends StatefulWidget {
  const JsonToDartScreen({Key? key}) : super(key: key);

  @override
  _JsonToDartScreenState createState() => _JsonToDartScreenState();
}

class _JsonToDartScreenState extends State<JsonToDartScreen> {
  late CodeController _jsonController;
  late CodeController _dartController;

  late TextEditingController className = TextEditingController();

  bool resReady = false;
  bool buttonTap = false;

  @override
  void initState() {
    _jsonController = CodeController(
      text: '',
      language: json,
      theme: ideaTheme,
    );
    _dartController = CodeController(
      text: '',
      language: dart,
      theme: isblEditorLightTheme,
    );
    init();
    super.initState();
  }

  void init() async{
    bool s = await DesktopWindow.getFullScreen();
    if(!s){
      DesktopWindow.setWindowSize(Size(1000, 700));
    }
}

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle();
    textStyle = textStyle.copyWith(
      color: textStyle.color ?? _dartController.theme?['root']?.color ?? Colors.grey.shade200,
      fontSize: textStyle.fontSize ?? 16.0,
    );
    return Scaffold(
      appBar: PjAppBar(
        title: 'Eticon Json2Dart',
        leading: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: MediaQuery.of(context).size.width > 1000
              ? MediaQuery.of(context).size.width
              : 1000,
          color: Color.fromRGBO(250, 250, 250, 1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 350,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'JSON',
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CodeField(
                              controller: _jsonController,
                              maxLines: 20,
                              minLines: 20,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextField(
                              controller: className,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                              ],
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  hintText: "Input dart class name...",
                                  fillColor: Colors.white70),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if(!buttonTap && className.text.isNotEmpty){
                                  setState(() {
                                    buttonTap = true;
                                  });
                                  try{
                                    Map<String, dynamic> json = {};
                                    var jsonRaw = jsonDecode(_jsonController.rawText);
                                    _jsonController.text = prettyJson(jsonRaw,);
                                    if(jsonRaw is List){
                                      json = jsonRaw[0];
                                    }
                                    else{
                                      json = jsonRaw;
                                    }
                                    String classNameText = className.text;
                                    if(!className.text.endsWith('Model')){
                                      classNameText += 'Model';
                                    }
                                    _dartController.rawText;
                                    _dartController.text = JsonToDart.jsonToDart(json, classNameText);
                                    Clipboard.setData(ClipboardData(text: _dartController.text));
                                    Get.snackbar('Json2Dart', 'Код скопирован в буфер обмена!',
                                        backgroundColor: Colors.green,
                                        snackPosition: SnackPosition.BOTTOM,
                                        colorText: Colors.white,
                                        borderRadius: 0,
                                        margin: EdgeInsets.all(0));
                                    setState(() {
                                      buttonTap = false;
                                    });
                                  } catch(e){
                                    setState(() {
                                      buttonTap = false;
                                    });
                                    log(e.toString());
                                    Get.dialog(
                                      CupertinoAlertDialog(
                                        title: Text("Oh no, error"),
                                        content: Text("JSON syntax error!"),
                                        actions: [
                                          CupertinoDialogAction(
                                              child: Text("Ok"),
                                              onPressed: ()
                                              {
                                                Get.back();
                                              }
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }
                              },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: buttonTap ? Colors.grey : Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text(
                                    'Generate Dart Code',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: 600,
                        child: CodeField(
                          controller: _dartController,
                          lineNumberBuilder: (i, style){
                            return TextSpan();
                          },
                          background: Color.fromRGBO(250, 250, 250, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
    