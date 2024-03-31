import 'package:cloud_firestore/cloud_firestore.dart';

class Reviewer {
  final String id;
  final String name;

  Reviewer({required this.id, required this.name});

  factory Reviewer.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Reviewer(
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
