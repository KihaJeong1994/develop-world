import 'package:flutter/material.dart';

class FiveStarRate extends StatelessWidget {
  const FiveStarRate({
    Key? key,
    required this.rate,
  }) : super(key: key);

  final double rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < rate.floor(); i++)
          const Icon(
            Icons.star,
            color: Colors.amber,
          ),
        if (rate - rate.floor() > 0)
          const Icon(
            Icons.star_half,
            color: Colors.amber,
          ),
        for (int i = 0; i <= 5 - rate - 1; i++)
          const Icon(
            Icons.star_border,
            color: Colors.amber,
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
