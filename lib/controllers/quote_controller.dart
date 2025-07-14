import 'dart:math';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/quote_model.dart';
import '../data/quotes.dart';

class QuoteController extends GetxController {
  var currentQuote = localQuotes[0].obs;
  var favorites = <Quote>[].obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void getNewQuote() {
    final random = Random();
    currentQuote.value = localQuotes[random.nextInt(localQuotes.length)];
  }

  Future<void> toggleFavorite(Quote quote) async {
    final user = _auth.currentUser;
    if (user == null) return;

    quote.isFavorite = !quote.isFavorite;
    currentQuote.refresh();

    final favRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(quote.text); // use short id in real apps

    if (quote.isFavorite) {
      favorites.addIf(!favorites.contains(quote), quote);
      await favRef.set({
        'text': quote.text,
        'author': quote.author,
      });
    } else {
      favorites.removeWhere((q) => q.text == quote.text);
      await favRef.delete();
    }
  }

  Future<void> loadFavorites() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .get();

    favorites.clear();
    for (var doc in snapshot.docs) {
      final text = doc['text'];
      final author = doc['author'];
      final match = localQuotes.firstWhereOrNull((q) => q.text == text);
      if (match != null) {
        match.isFavorite = true;
        favorites.add(match);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }
}
