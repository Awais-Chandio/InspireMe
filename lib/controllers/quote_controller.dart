import 'dart:math';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quote_model.dart';
import '../data/quotes.dart';

class QuoteController extends GetxController {
  var currentQuote = localQuotes[0].obs;
  var favorites = <Quote>[].obs;

  void getNewQuote() {
    final random = Random();
    currentQuote.value =
        localQuotes[random.nextInt(localQuotes.length)];
  }

  void toggleFavorite(Quote quote) {
    quote.isFavorite = !quote.isFavorite;
    currentQuote.refresh();

    if (quote.isFavorite) {
      if (!favorites.contains(quote)) {
        favorites.add(quote);
      }
    } else {
      favorites.removeWhere((q) => q.text == quote.text);
    }

    saveFavorites();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favs = favorites.map((q) => q.text).toList();
    await prefs.setStringList('favorites', favs);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList('favorites') ?? [];
    for (var quote in localQuotes) {
      if (favs.contains(quote.text)) {
        quote.isFavorite = true;
        favorites.add(quote);
      }
    }
  }

  @override
  void onInit() {
    loadFavorites();
    super.onInit();
  }
}
