import 'package:desktop_window/desktop_window.dart';
import 'package:eticon_desktop/project_widgets/pj_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PjAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool leading;

  const PjAppBar({Key? key, this.title = '', this.leading = false})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        leading: leading
            ? GestureDetector(
                onTap: () async {
                  Get.back();
                  bool s = await DesktopWindow.getFullScreen();
                  if(!s){
                    DesktopWindow.setWindowSize(Size(500, 600));
                  }
                },
                behavior: HitTestBehavior.translucent,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ))
            : null,
        title: PjText(
          text: title,
          color: Colors.white,
          fontSize: 20,
        ));
  }
}
