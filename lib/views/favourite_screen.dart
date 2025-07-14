import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Favorites")),
        body: const Center(child: Text("Please log in to view favorites.")),
      );
    }

    final favsRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites');

    return Scaffold(
      appBar: AppBar(title: const Text("Your Favorites")),
      body: StreamBuilder<QuerySnapshot>(
        stream: favsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return const Center(child: Text("No favorite quotes yet."));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final text = data['text'] ?? '';
              final author = data['author'] ?? '';

              return ListTile(
                leading: const Icon(Icons.format_quote),
                title: Text('"$text"'),
                subtitle: Text("- $author"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () async {
                    await favsRef.doc(text).delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
