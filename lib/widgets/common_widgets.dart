import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final double? rating;

  const RatingBar({this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(rating!.floor(), (index) {
        return Icon(
          Icons.star,
          color: Colors.white,
          size: 16,
        );
      }),
    );
  }
}
