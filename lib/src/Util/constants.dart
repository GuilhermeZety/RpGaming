import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../pages/report-error/report_error_page.dart';
import 'navigate.dart';

final supabase = Supabase.instance.client;
final supabaseInstanse = Supabase.instance;

extension ShowSnackBar on BuildContext {
  
  _closeSnackbar(){
    ScaffoldMessenger.of(this).clearSnackBars();
  }

  _sendReport(String error) async {
    await to(this, ReportErrorPage(error: error));
  }

  void showSnackBar({
    required String title,
    required Widget message,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Icon icon = const Icon(Icons.verified)
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Row(
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
                width: MediaQuery.of(this).size.width * 0.7,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
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
          IconButton(icon: Icon(Icons.close, color: Theme.of(this).snackBarTheme.contentTextStyle!.color,), onPressed: () => _closeSnackbar(),),
        ],
      ),
      padding: EdgeInsets.all(10),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(side: BorderSide(color: color, width: 1), borderRadius: BorderRadius.circular(10))
      // shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(10)),
    ));
  }

  void showErrorSnackBar({required String error}) {
    showSnackBar(
      title: 'Há algo errado!', 
      message: Row(
        children: [
          Text('Aconteceu algo inesperado!'),
          GestureDetector(
            onTap: () => _sendReport(error),
            child: Center(child: Text('Enviar Relatório.', style: TextStyle(color: Color(0xFFfb5050), decoration: TextDecoration.underline)))
          ),
        ],
      ), 
      backgroundColor: Color(0xFFfaefec), 
      color: Color(0xFFff8080), 
      icon: Icon(FontAwesomeIcons.xmark, color: Color(0xFFfb5050), size: 18,)
    );
  }

  void showWarningSnackBar({required String message}) {
    showSnackBar(
      title: 'Aviso!', 
      message: Expanded(child: Text(message)),
      backgroundColor: Color(0xFFfef8eb), 
      color: Color(0xFFffcc14), 
      icon: Icon(FontAwesomeIcons.exclamation, color: Color(0xFFffcc14), size: 18,)
    );
  }

  void showInfoSnackBar({required String title, required String message}) {
    showSnackBar(
      title: title, 
      message: Expanded(child: Text(message)),
      backgroundColor: Color(0xFFe7effa), 
      color: Color(0xFF3186ea), 
      icon: Icon(FontAwesomeIcons.info, color: Color(0xFF3186ea), size: 18,)
    );
  }
  void showSuccessSnackBar({required String message}) {
    showSnackBar(
      title: 'Sucesso!', 
      message: Expanded(child: Text(message)),
      backgroundColor: Color(0xFFf1f8f4), 
      color: Color(0xFF50dc6c), 
      icon: Icon(FontAwesomeIcons.check, color: Color(0xFF50dc6c), size: 18,)
    );
  }
}

Orientation getWhatSize(BuildContext c){
  return MediaQuery.of(c).orientation;
}