import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          Container(
            height: 300,
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(height: 20, color: Colors.grey.shade300),
                  SizedBox(height: 10),
                  Container(height: 20, color: Colors.grey.shade300),
                  SizedBox(height: 10),
                  Container(height: 100, color: Colors.grey.shade300),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
