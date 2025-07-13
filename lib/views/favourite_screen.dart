import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quote_controller.dart';
import '../models/quote_model.dart';

class FavoritesScreen extends StatelessWidget {
  final QuoteController quoteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Quotes")),
      body: Obx(() {
        if (quoteController.favorites.isEmpty) {
          return const Center(child: Text("No favorites yet!"));
        }
        return ListView.builder(
          itemCount: quoteController.favorites.length,
          itemBuilder: (context, index) {
            Quote quote = quoteController.favorites[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text('"${quote.text}"',
                    style: Theme.of(context).textTheme.bodyLarge),
                subtitle: Text("- ${quote.author}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    quoteController.toggleFavorite(quote);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
