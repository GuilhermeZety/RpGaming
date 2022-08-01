import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rpgaming/src/components/Input.dart';

class InputDateTime extends StatefulWidget {
  const InputDateTime({Key? key, required this.dateController, required this.label, this.onchange}) : super(key: key);

  final TextEditingController dateController;
  final String label;
  final void Function()? onchange;

  @override
  State<InputDateTime> createState() => _InputDateTimeState();
}

class _InputDateTimeState extends State<InputDateTime> {
  DateTime date = DateTime.now();

  
  @override
  void initState() {
    super.initState();

    Timer.run(() => widget.dateController.text = DateFormat('dd/MM/yyyy').format(date));
  }

  @override
  Widget build(BuildContext context) {    
    return Input(
      controller: widget.dateController, 
      type: TextInputType.datetime, 
      label: Text(widget.label),
      hintText: '', 
      onTap: () => pickDate(context), 
      minimumAcceptableDate: DateTime(DateTime.now().year - 10, DateTime.now().month, DateTime.now().day),
    );
    
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context, 
      initialDate: initialDate, 
      firstDate: DateTime(DateTime.now().year - 100), 
      lastDate: DateTime.now()
    );

    setState(() {
      date = newDate ?? date;
    });
    setState(() {      
      widget.dateController.text = DateFormat('dd/MM/yyyy').format(date);
    });

    if(widget.onchange != null){
      widget.onchange!();
    }
  }

  String getDateText(){    
    var localformatter = DateFormat('dd/MM/yyyy');

    return localformatter.format(date);

  }
}