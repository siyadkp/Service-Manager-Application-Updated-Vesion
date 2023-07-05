import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TrieNotifier with ChangeNotifier {
  Map<String, QueryDocumentSnapshot> collectionOfDatas = {};
  TrieNode root = TrieNode();

  List<String> suggestions = [];
  List<String> collectionOfDatsKeys = [];
  Trie() {
    root = TrieNode();
  }

  void insert(String word) {
    TrieNode current = root;

    for (int i = 0; i < word.length; i++) {
      String char = word[i];

      if (!current.children.containsKey(char)) {
        current.children[char] = TrieNode();
      }

      current = current.children[char]!;
    }

    current.isEndOfWord = true;
  }

  void insertAll(List<String> words) {
    for (String word in words) {
      insert(word);
    }
  }

  void search(String prefix, TrieNode rootObj) {
    suggestions = [];
    TrieNode current = rootObj;

    for (int i = 0; i < prefix.length; i++) {
      String char = prefix[i];

      if (!current.children.containsKey(char)) {
        return; // Prefix not found, no suggestions
      }

      current = current.children[char]!;
    }

    getSuggestions(current, prefix, suggestions);
  }

  searchHelper(Map<String, QueryDocumentSnapshot> Datas, List<String> keys,
      String value, TrieNotifier trieNotifier) {
    print(Datas.length);
    print(keys.length);
    trieNotifier.collectionOfDatas = {};
    trieNotifier.collectionOfDatsKeys = [];
    search(value, trieNotifier.root);
    if (suggestions.isNotEmpty) {
      for (String suggestion in suggestions) {
        trieNotifier.collectionOfDatas[suggestion] = Datas[suggestion]!;
        trieNotifier.collectionOfDatsKeys.add(suggestion);
      }
    } else if (value.isEmpty) {
      trieNotifier.collectionOfDatas = Datas;
      trieNotifier.collectionOfDatsKeys = keys;
    }
    notifyListeners();
  }

  void getSuggestions(TrieNode node, String prefix, List<String> suggestions) {
    if (node.isEndOfWord) {
      suggestions.add(prefix);
    }

    for (String char in node.children.keys) {
      String newPrefix = prefix + char;
      getSuggestions(node.children[char]!, newPrefix, suggestions);
    }
  }
}

class TrieNode {
  Map<String, TrieNode> children = {};
  bool isEndOfWord = false;
  List<String> suggestions = [];

  TrieNode() {
    children;
    isEndOfWord;
    suggestions;
  }
}
