import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Input.dart';

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
  }

  @override
  Widget build(BuildContext context) {    
    return Input(
      controller: widget.dateController, 
      type: TextInputType.datetime, 
      label: Text(widget.label),
      hintText: '', 
      onTap: () => pickDate(context, DateFormat('dd/MM/yyyy').parse(widget.dateController.text)), 
      minimumAcceptableDate: DateTime(DateTime.now().year - 5, DateTime.now().month, DateTime.now().day),
    );
    
  }

  Future pickDate(BuildContext context, initialDate) async {
    if(initialDate == null) {
      initialDate = DateTime.now();
    }

    final newDate = await showDatePicker(
      locale: Locale('pt'),
      context: context, 
      initialDate: initialDate, 
      firstDate: DateTime(DateTime.now().year - 100), 
      lastDate: DateTime.now(),
    );

    setState(() {
      date = newDate ?? initialDate;
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