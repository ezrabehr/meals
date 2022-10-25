import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  const Category({
    //the curly brackets is so that I will be able to see the parameter name in the caller code.
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });
}
