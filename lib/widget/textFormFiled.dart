

import 'package:flutter/material.dart';

class TextFomfieldCustom extends StatefulWidget {
   TextFomfieldCustom({
    super.key,
    required this.controller,
    required this.labelText,
    required this.cursorColor,
    required this.prefixIcon,
    required this.textColor,
    required this.validator, 
    required this.bordercolor, 
    this.isPassword = false,
    
  });


  final TextEditingController controller;
  final String labelText;
  final Icon prefixIcon;
  final Color cursorColor;
  final Color textColor;
  final Color bordercolor;
  final String? Function(String?)?validator;
  final bool isPassword;
  @override
  State<TextFomfieldCustom> createState() => _TextFomfieldCustomState();
}

class _TextFomfieldCustomState extends State<TextFomfieldCustom> {

bool _obscurseText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
          controller: widget.controller,
          cursorColor: widget.cursorColor,
          obscureText: widget.isPassword ? _obscurseText : false,
          style:  TextStyle(
            color: widget.textColor,
          ),
          decoration: InputDecoration(
              
              border: const OutlineInputBorder(),
              prefixIcon: widget.prefixIcon,
              labelText: widget.labelText,
              labelStyle: const TextStyle(
                color: Color(0xFF909090),
                
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.bordercolor)),
              focusedBorder:  OutlineInputBorder(
                  borderSide: BorderSide(color: widget.bordercolor)),
              suffixIcon: widget.isPassword
                  ? IconButton(onPressed: (){
                    setState(() {
                      _obscurseText = !_obscurseText;
                    });
                  }, 
                  icon: Icon(_obscurseText ? Icons.visibility_off : Icons.visibility,color: Colors.grey,size: 18,))
                  : null , 
          ),

              
          validator: widget.validator,
        );
  }
}
