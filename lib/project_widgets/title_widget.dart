import 'package:eticon_desktop/project_widgets/pj_text.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String text;
  const TitleWidget({Key? key, this.text = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return               Row(
      children: [
        Container(width: 40, height: 1, color: Colors.grey,),
        SizedBox(
          width: 5,
        ),
        PjText(text: text, height: 0.9, color: Colors.grey,),
        SizedBox(
          width: 5,
        ),
        Expanded(child: Container(height: 1, color: Colors.grey,)),
      ],
    );
  }
}
