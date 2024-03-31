import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:limosquizpart2/utils/constants.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final void Function(double) onRatingUpdate; // Change this line

  const StarRating({
    Key? key,
    required this.rating,
    required this.onRatingUpdate, // Change this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: kAccentColor,
      ),
      onRatingUpdate: onRatingUpdate, // No change needed here
      ignoreGestures: false, // Remove this line
    );
  }
}