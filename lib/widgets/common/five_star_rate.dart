import 'package:flutter/material.dart';

class FiveStarRate extends StatelessWidget {
  FiveStarRate({
    Key? key,
    required this.rate,
    this.starSize,
  }) : super(key: key);

  final double rate;
  final double? starSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < rate.floor(); i++)
          Icon(
            Icons.star,
            color: Colors.amber,
            size: starSize,
          ),
        if (rate - rate.floor() > 0)
          Icon(
            Icons.star_half,
            color: Colors.amber,
            size: starSize,
          ),
        for (int i = 0; i <= 5 - rate - 1; i++)
          Icon(
            Icons.star_border,
            color: Colors.amber,
            size: starSize,
          ),
        Text(
          '$rate',
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
          ),
        )
      ],
    );
  }
}
