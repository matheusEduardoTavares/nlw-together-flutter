import 'package:flutter/material.dart';

class PageDefinition<T> {
  const PageDefinition({
    required this.title,
    required this.leading,
    required this.routeName,
    this.arguments,
  });

  final Widget leading;
  final String title;
  final T? arguments;
  final String routeName;
}