import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/review.dart';
import '../models/reviewer.dart';
import '../models/restaurant.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Review> get reviewCollection => _db.collection('reviews').withConverter<Review>(
        fromFirestore: (snapshots, _) => Review.fromFirestore(snapshots),
        toFirestore: (review, _) => review.toJson(),
      );

  CollectionReference<Reviewer> get reviewerCollection => _db.collection('reviewers').withConverter<Reviewer>(
        fromFirestore: (snapshots, _) => Reviewer.fromFirestore(snapshots),
        toFirestore: (reviewer, _) => reviewer.toJson(),
      );

  CollectionReference<Restaurant> get restaurantCollection => _db.collection('restaurants').withConverter<Restaurant>(
        fromFirestore: (snapshots, _) => Restaurant.fromFirestore(snapshots),
        toFirestore: (restaurant, _) => restaurant.toJson(),
      );

Future<void> addReview(Map<String, dynamic> reviewData) {
  var review = Review(
    reviewerId: reviewData['reviewerId'],
    reviewerName: reviewData['reviewerName'],
    restaurantId: reviewData['restaurantId'],
    restaurantName: reviewData['restaurantName'],
    rating: reviewData['rating'],
    review: reviewData['review'],
  );
  return reviewCollection.add(review);
}


  // Corrected addReviewer method
  Future<void> addReviewer(String name) {
    // Creating a new Reviewer instance to pass to .add()
    var newReviewer = Reviewer(id: '', name: name); // Firestore generates the ID
    return reviewerCollection.add(newReviewer);
  }

  // Corrected addRestaurant method
  Future<void> addRestaurant(String name) {
    // Creating a new Restaurant instance to pass to .add()
    var newRestaurant = Restaurant(id: '', name: name); // Firestore generates the ID
    return restaurantCollection.add(newRestaurant);
  }

  Stream<List<Review>> getReviews() {
    return reviewCollection.snapshots().map((snapshot) => snapshot.docs
        .map((snapshot) => snapshot.data()!)
        .toList());
  }

  Stream<List<Reviewer>> getReviewers() {
    return reviewerCollection.snapshots().map((snapshot) => snapshot.docs
        .map((snapshot) => snapshot.data()!)
        .toList());
  }

  Stream<List<Restaurant>> getRestaurants() {
    return restaurantCollection.snapshots().map((snapshot) => snapshot.docs
        .map((snapshot) => snapshot.data()!)
        .toList());
  }
}
