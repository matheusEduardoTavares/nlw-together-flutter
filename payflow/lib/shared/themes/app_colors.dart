import  'package:flutter/material.dart';

///OBS: Uma classe que apenas contém 
///atributos / métodos estáticos (no
///caso só atributos), deve ser 
///abstrata, afinal, não faz
///sentido instanciá-la
///Referência:
///https://github.com/rocketseat-education/nlw-06-flutter/tree/colors
abstract class AppColors{
  static final primary = Color(0xFFFF941A);
  static final grey = Color(0xFF585666);
  static final delete = Color(0xFFE83F5B);
  static final heading = Color(0xFF585666);
  static final body = Color(0xFF706E7A);
  static final stroke = Color(0xFFE3E3E6);
  static final shape = Color(0xFFFAFAFC);
  static final background = Color(0xFFFFFFFF);
  static final input = Color(0xFFB1B0B8);
}