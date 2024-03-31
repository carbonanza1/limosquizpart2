import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String reviewerId;
  final String reviewerName; // Added field
  final String restaurantId;
  final String restaurantName; // Added field
  final int rating;
  final String review;

  Review({
    required this.reviewerId,
    required this.reviewerName, // Initialize in constructor
    required this.restaurantId,
    required this.restaurantName, // Initialize in constructor
    required this.rating,
    required this.review,
  });

  factory Review.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Review(
      reviewerId: doc.data()!['reviewerId'],
      reviewerName: doc.data()!['reviewerName'] ?? '', // Provide a default value
      restaurantId: doc.data()!['restaurantId'],
      restaurantName: doc.data()!['restaurantName'] ?? '', // Provide a default value
      rating: doc.data()!['rating'],
      review: doc.data()!['review'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviewerId': reviewerId,
      'reviewerName': reviewerName,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'rating': rating,
      'review': review,
    };
  }

  
}
