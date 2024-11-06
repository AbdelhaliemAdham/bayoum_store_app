import 'package:bayoum_store_app/screens/MainScreens/search_screen.dart';
import 'package:flutter/material.dart';

class SearchDelegateBar extends SearchDelegate {
  List<String> searchResult = [
    'men shampoo',
    'black shoes',
    'women razors',
    'women pursue',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          }
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.search),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchEngine(product: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResult.where((result) {
      return result.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return SizedBox(
      height: 150,
      child: ListView.builder(
          itemCount: suggestions.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(suggestions[index]),
              onTap: () {
                query = suggestions[index];
              },
            );
          }),
    );
  }
}
