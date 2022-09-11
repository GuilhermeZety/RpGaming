
  import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rpgaming/src/Util/navigate.dart';
import 'package:rpgaming/src/app_widget.dart';

import '../pages/report-error/report_error_page.dart';

void showToast({
  required FToast fToast,
  required String title,
  required Widget message,
  required Duration duration,
  Color color = Colors.white,
  Color backgroundColor = Colors.white,
  Icon icon = const Icon(Icons.verified)
}) {
  fToast.showToast(
    gravity: ToastGravity.TOP_RIGHT,
    toastDuration: duration,
    child: Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8)

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(7), 
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(blurRadius: 4,color: Colors.black.withOpacity(0.23), offset: Offset(0, 0), spreadRadius: 1)
                  ]
                ),            
                child: Container(            
                  padding: EdgeInsets.all(3),
                  child: icon,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(100)),
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                width: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey.shade900),),
                    Row(
                      children: [
                        message,
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // IconButton(icon: Icon(Icons.close, color: Theme.of(this).snackBarTheme.contentTextStyle!.color,), onPressed: () => _closeSnackbar(),),
        ],
      ),
      padding: EdgeInsets.all(10),
    )
  );
}

showSuccessToast({required String message, required FToast fToast, Duration? duration}){
  showToast(
    fToast: fToast, 
    title: 'Sucesso!',
    duration: duration ?? Duration(seconds: 4),
    message: Expanded(child: Text(message, style: TextStyle(color: Colors.grey.shade800),)),
    // backgroundColor: Color(0xFFB7FFD6).withOpacity(0.7), 
    backgroundColor: Color(0xFFf1f8f4), 
    color: Color(0xFF50dc6c), 
    icon: Icon(FontAwesomeIcons.check, color: Color(0xFF50dc6c), size: 18,)
  );
}

showWarningToast({required String message, required FToast fToast, Duration? duration}){
  showToast(
    fToast: fToast, 
    title: 'Aviso!', 
    duration: duration ?? Duration(seconds: 40),
    message: Expanded(child: Text(message, style: TextStyle(color: Colors.grey.shade800))),
    backgroundColor: Color(0xFFfef8eb), 
    color: Color(0xFFffcc14), 
    icon: Icon(FontAwesomeIcons.exclamation, color: Color(0xFFffcc14), size: 18,)    
  );
}

showInfoToast({required String message, required String title, required FToast fToast, Duration? duration}){
  showToast(
    fToast: fToast, 
    title: title, 
    duration: duration ?? Duration(seconds: 4),
    message: Expanded(child: Text(message, style: TextStyle(color: Colors.grey.shade800))),
    backgroundColor: Color(0xFFe7effa), 
    color: Color(0xFF3186ea), 
    icon: Icon(FontAwesomeIcons.info, color: Color(0xFF3186ea), size: 18,)
  );
}

showErrorToast({required String error, required FToast fToast, Duration? duration}){
  showToast(
    fToast: fToast,     
    duration: duration ?? Duration(seconds: 7),
    title: 'Há algo errado!', 
    message: Column(
      children: [
        Text('Aconteceu algo inesperado!'),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => _sendReport(error),
            child: Expanded(child: Text('Enviar Relatório.', style: TextStyle(color: Color(0xFFfb5050), decoration: TextDecoration.underline)))
          ),
        ),
      ],
    ), 
    backgroundColor: Color(0xFFfaefec), 
    color: Color(0xFFff8080), 
    icon: Icon(FontAwesomeIcons.xmark, color: Color(0xFFfb5050), size: 18,),
  );
}

_sendReport(String error) async {
  await to(navigatorKey.currentContext!, ReportErrorPage(error: error));
}