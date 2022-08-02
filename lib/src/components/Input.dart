// ignore_for_file: file_names

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Input extends StatefulWidget {
  const Input({Key? key, 
    this.controller,
    required this.type,
    required this.label,
    required this.hintText,
    this.initialText,
    this.onTap,
    this.obscure = false,
    this.compare,
    this.minimumAcceptableDate,
    this.onchange,
    this.big = false,

  }) : super(key: key);
  
  final TextEditingController? controller;
  final TextInputType type;
  final Widget label;
  final String hintText;
  final bool obscure;
  final bool big;
  final String? initialText;
  final TextEditingController? compare;
  final void Function()? onTap;
  final DateTime? minimumAcceptableDate;
  final void Function()? onchange;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  String? Function(String?)? validator;

  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    if(widget.type == TextInputType.emailAddress){
      validator = (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor insira um email.';
        }
        else if(!EmailValidator.validate(value)){
          return 'Preencha um email válido.';
        }
        return null;
      };
    }
    else if(widget.type == TextInputType.text){
      validator = (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor insira algo.';
        }        
        return null;
      };
    }
    else if(widget.type == TextInputType.name){
      validator = (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor insira algo.';
        }
        else if(value.length < 2){
          return 'no mínimo 2 caracteres';
        }
        return null;
      };
    }
    else if(widget.type == TextInputType.datetime){
      validator = (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor insira algo.';
        }
        else if(widget.minimumAcceptableDate != null){
          if(DateFormat('dd/MM/yyyy').parse(value).isAfter(widget.minimumAcceptableDate!) ){
            return 'Insira antes que ${DateFormat('dd/MM/yyyy').format(widget.minimumAcceptableDate!)}';
          }
        }
        return null;
      };
    }
    else if(widget.type == TextInputType.visiblePassword){
      if(widget.compare == null){
        validator = (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor insira uma senha.';
          }
          else if(value.length < 8){
            return 'No mínimo 8 caracteres.';
          }
          return null;
        };
      }
      else{
        validator = (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor insira uma senha.';
          }
          else if(value != widget.compare!.text){
            return 'As senhas não coincidem.';
          }
          return null;
        };
      }
    }

    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialText,
      onTap: widget.onTap,
      onChanged: widget.onchange != null ? (e) => widget.onchange!() : null,
      readOnly: widget.type == TextInputType.datetime ? true : false,
      minLines: 1,
      maxLines: widget.big ? 7 : 1,
      decoration: InputDecoration(
        border: widget.big ? OutlineInputBorder() : const UnderlineInputBorder(),
        label: widget.label,
        hintText: widget.hintText,
        suffixIcon: widget.type == TextInputType.visiblePassword ?        
        IconButton(
          icon: Icon(
              passwordVisible
              ? Icons.visibility_off
              : Icons.visibility,
              color: Theme.of(context).secondaryHeaderColor,
              ),
          onPressed: () {
              setState(() {
                  passwordVisible = !passwordVisible;
              });
            },
          )
        : null
      ),
      validator: validator,
      
      keyboardType: widget.type,
      obscureText: widget.obscure ? passwordVisible : false,
    );
  }
}