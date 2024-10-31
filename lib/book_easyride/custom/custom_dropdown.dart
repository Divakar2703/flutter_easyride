import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final Icon;
  final String? labelText;
  final List<String>? items;
  final String? hint;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;
  final activecolor;

  CustomDropdownField({
    Key? key,
    this.labelText,
    this.Icon,
    this.items,
    this.hint,
    this.selectedValue,
    this.onChanged,
    this.validator,
    this.activecolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: DropdownButtonFormField<String>(
        iconDisabledColor: Colors.grey,
        iconEnabledColor: Colors.grey,
        value: selectedValue,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          filled: true,
          fillColor: Colors.white,
        ),
        isExpanded: true,
        items: items?.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
        style: TextStyle(color: Colors.grey, fontSize: 16),
        dropdownColor: Colors.white,
        hint: Text(hint ?? 'Please select an option'),
      ),
    );
  }
}
