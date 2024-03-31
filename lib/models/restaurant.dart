import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  final String id;
  final String name;

  Restaurant({required this.id, required this.name});

  factory Restaurant.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Restaurant(
      id: doc.id, // Capture the document ID from the snapshot
      name: doc.data()!['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
