import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inspire_me/views/favourite_screen.dart';
import '../controllers/quote_controller.dart';
import '../themes/theme_controller.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatelessWidget {
  final QuoteController quoteController = Get.put(QuoteController());
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("InspireMe"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Get.to(() => FavoritesScreen()),
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
                      quoteController.toggleFavorite(quote);
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
          SystemSound.play(SystemSoundType.click); // 🔊 Built-in sound
        },
      ),
    );
  }
}
