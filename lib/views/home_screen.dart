import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inspire_me/views/favourite_screen.dart';
import 'package:share_plus/share_plus.dart';
import '../controllers/quote_controller.dart';
import '../themes/theme_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  final QuoteController quoteController = Get.find<QuoteController>();
  final ThemeController themeController = Get.find<ThemeController>();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("InspireMe"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              if (user != null) {
                Get.to(() => FavoritesScreen());
              } else {
                Get.snackbar("Login Required", "Please login to view favorites");
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Share.share(quoteController.currentQuote.value.text);
            },
          ),
          IconButton(
            icon: Obx(() => Icon(themeController.isDark.value
                ? Icons.sunny
                : Icons.nightlight)),
            onPressed: themeController.toggleTheme,
          ),
        ],
      ),
      body: Obx(() {
        final quote = quoteController.currentQuote.value;
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Column(
                key: ValueKey(quote.text),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '"${quote.text}"',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text("- ${quote.author}",
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 40),
                  IconButton(
                    icon: Icon(
                      quote.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: quote.isFavorite ? Colors.red : Colors.grey,
                      size: 32,
                    ),
                    onPressed: () {
                      if (user != null) {
                        quoteController.toggleFavorite(quote);
                      } else {
                        Get.snackbar("Login Required",
                            "Please login to save favorites");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Inspire Me"),
        icon: const Icon(Icons.auto_awesome),
        onPressed: () {
          quoteController.getNewQuote();
          SystemSound.play(SystemSoundType.click);
        },
      ),
    );
  }
}
