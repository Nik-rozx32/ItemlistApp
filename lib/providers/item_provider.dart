import 'package:flutter/material.dart';
import 'package:itemlistapp/models/item.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ItemProvider with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items => _items;

  ItemProvider() {
    loadItems();
  }

  void addItem(Item item) {
    _items.add(item);
    saveItems();
    notifyListeners();
  }

  void updateItem(int index, Item newItem) {
    _items[index] = newItem;
    saveItems();
    notifyListeners();
  }

  void deleteItem(int index) {
    _items.removeAt(index);
    saveItems();
    notifyListeners();
  }

  Future<void> saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = _items.map((item) => item.toJson()).toList();
    prefs.setString('items', jsonEncode(itemsJson));
  }

  Future<void> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('items');

    if (data != null) {
      final List<dynamic> jsonData = jsonDecode(data);
      _items = jsonData.map((e) => Item.fromJson(e)).toList();
      notifyListeners();
    }
  }
}
