import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:limosquizpart2/models/review.dart';
import 'package:limosquizpart2/services/database_service.dart';
import 'package:limosquizpart2/widgets/review_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review App'),
      ),
      body: StreamProvider<List<Review>>.value(
        value: DatabaseService().getReviews(),
        initialData: const [],
        child: const ReviewList(),
      ),
    );
  }
}

class ReviewList extends StatelessWidget {
  const ReviewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reviews = Provider.of<List<Review>>(context);

    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return ReviewCard(review: review);
      },
    );
  }
}