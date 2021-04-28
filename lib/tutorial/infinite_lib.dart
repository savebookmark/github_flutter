library infinitelib;

import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';

final suggestions = <WordPair>[];
final biggerFont = const TextStyle(fontSize: 18.0);

Widget buildSuggestions() {
  return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        // Add a one-pixel-high divider widget before each row in theListView.
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        if (index >= suggestions.length) {
          suggestions.addAll(generateWordPairs().take(10));
        }
        return buildRow(suggestions[index]);
      });
}

Widget buildRow(WordPair pair) {
  return ListTile(
    title: Text(
      pair.asPascalCase,
      style: biggerFont,
    ),
  );
}
