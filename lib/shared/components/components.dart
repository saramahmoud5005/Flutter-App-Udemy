import 'package:flutter/material.dart';

Widget defaultButton({
  required double width,
  required Color background,
  required Function? function(),
  required String text,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20.0,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        height: 60.0,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        bool isPassword = false,
        required String? Function(String?)? validate,
        required String label,
        required IconData prefix,
        IconData? suffix,
        required Function? suffixPressed(),
        Function()? onTap,
        bool isClickable = true}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      validator: validate,
      onTap: onTap,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget buildTaskItem(Map model) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            child: Text(
            model['time'],
            style: TextStyle(fontSize: 12.0,),
          ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                model['title'],
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                model['date'],
                style: TextStyle(),
              ),
            ],
          ),
        ],
      ),
    );
