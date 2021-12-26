import 'package:eticon_desktop/project_widgets/pj_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PjButton extends StatefulWidget {
  final Function()? onTap;
  final String text;
  final bool enable;
  final double width;

  const PjButton({Key? key, this.onTap, required this.text, this.enable = true, this.width = 400})
      : super(key: key);

  @override
  _PjButtonState createState() => _PjButtonState();
}

class _PjButtonState extends State<PjButton> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if(widget.enable && widget.onTap != null){
            widget.onTap!();
          }
        },
        child: Container(
          width: widget.width,
          padding: EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: widget.enable ? Colors.blue : Colors.blueGrey,
          ),
          child: Center(child: PjText(text: widget.text, color: Colors.white, fontSize: 24,)),
        ),
      ),
    );
  }
}
