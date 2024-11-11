import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String? cancelText;
  final double? width;
  final double? height;
  final Color? color;

  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.confirmText,
    this.cancelText,
    this.width,
    this.height,
    this.color,
    this.onConfirm,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: color ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 0.2,
                  offset: Offset(0, 1))
            ]),
        width: width ?? MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    content,
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (cancelText != null)
                  TextButton(
                    onPressed: onCancel ?? () => Navigator.of(context).pop(),
                    child: Text(
                      cancelText!,
                      style:
                          TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                    ),
                  ),
                TextButton(
                  onPressed: onConfirm ?? () => Navigator.of(context).pop(),
                  child: Text(
                    confirmText,
                    style:
                        TextStyle(fontFamily: 'Poppins', color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
