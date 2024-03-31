import 'package:flutter/material.dart';
import 'package:limosquizpart2/utils/constants.dart';
import 'package:limosquizpart2/widgets/star_rating.dart';
import 'package:limosquizpart2/models/review.dart';
class ReviewCard extends StatelessWidget {
  final Review review;

  ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Assuming `review` now contains the names or that you fetch them elsewhere
    String reviewerName = review.reviewerName; // Assuming you have reviewerName in Review model
    String restaurantName = review.restaurantName; // Assuming you have restaurantName in Review model

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurantName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 8.0),
            StarRating(
              rating: review.rating.toDouble(),
              onRatingUpdate: (_) {}, // Dummy function for display only
            ),
            const SizedBox(height: 8.0),
            Text(
              review.review,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Reviewed by: $reviewerName',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
