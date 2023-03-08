import 'package:flutter/material.dart';

class Category {
  String name;
  String image;
  String catId;

  Category({required this.name, required this.image, required this.catId});

  static List<Category> getCategories() {
    return [
      Category(name: 'Movies',image: 'assets/images/movies.png', catId: 'movies'),
      Category(name: 'Music', image: 'assets/images/music.png',catId: 'music'),
      Category( name: 'Sports', image: 'assets/images/sports.png',catId: 'sports')
    ];
  }
}
