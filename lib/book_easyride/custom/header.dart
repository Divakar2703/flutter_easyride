import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String? title;
  final String? text;
  final String? image;

  const Header({
    Key? key,
    this.title,
    this.text,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (image != null) 
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image!,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                ), 
              ),
            ),
          ),
        Container(
          child: Text(
            title ?? '',
            style: const TextStyle(
              fontSize: 15,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        if (text != null)
          Text(
            text!,
            style: const TextStyle(color: Colors.grey),
          ),
      ],
    );
  }
}
