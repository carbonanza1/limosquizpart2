import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:limosquizpart2/models/review.dart';
import 'package:limosquizpart2/models/restaurant.dart';
import 'package:limosquizpart2/models/reviewer.dart';
import 'package:limosquizpart2/services/database_service.dart';
import 'package:limosquizpart2/widgets/star_rating.dart';

class ReviewEntryScreen extends StatefulWidget {
  const ReviewEntryScreen({Key? key}) : super(key: key);

  @override
  _ReviewEntryScreenState createState() => _ReviewEntryScreenState();
}

class _ReviewEntryScreenState extends State<ReviewEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedReviewerId;
  String? _selectedRestaurantId;
  int _rating = 3; // Default rating
  final _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void clearForm() {
    _reviewController.clear();
    setState(() {
      _selectedReviewerId = null;
      _selectedRestaurantId = null;
      _rating = 3; // Reset rating to default
    });
  }

  @override
  Widget build(BuildContext context) {
    final reviewers = Provider.of<List<Reviewer>>(context);
    final restaurants = Provider.of<List<Restaurant>>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Reviewer',
                ),
                value: _selectedReviewerId,
                onChanged: (value) {
                  setState(() {
                    _selectedReviewerId = value;
                  });
                },
                items: reviewers.map<DropdownMenuItem<String>>((Reviewer reviewer) {
                  return DropdownMenuItem<String>(
                    value: reviewer.id,
                    child: Text(reviewer.name),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Restaurant',
                ),
                value: _selectedRestaurantId,
                onChanged: (value) {
                  setState(() {
                    _selectedRestaurantId = value;
                  });
                },
                items: restaurants.map<DropdownMenuItem<String>>((Restaurant restaurant) {
                  return DropdownMenuItem<String>(
                    value: restaurant.id,
                    child: Text(restaurant.name),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              StarRating(
                rating: _rating.toDouble(),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating.round();
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _reviewController,
                decoration: const InputDecoration(
                  labelText: 'Review',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a review';
                  }
                  return null;
                },
                maxLines: 3,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() &&
                      _selectedReviewerId != null &&
                      _selectedRestaurantId != null) {
                    try {
                      final review = Review(
                        reviewerId: _selectedReviewerId!,
                        reviewerName: reviewers.firstWhere((r) => r.id == _selectedReviewerId).name,
                        restaurantId: _selectedRestaurantId!,
                        restaurantName: restaurants.firstWhere((r) => r.id == _selectedRestaurantId).name,
                        rating: _rating,
                        review: _reviewController.text,
                      );
                      await DatabaseService().addReview(review.toJson());
                      Fluttertoast.showToast(
                        msg: "Review added successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                      clearForm();
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: "Failed to add review: $e",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                      );
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
