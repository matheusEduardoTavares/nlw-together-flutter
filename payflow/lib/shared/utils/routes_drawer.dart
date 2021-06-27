import 'package:flutter/material.dart';
import 'package:payflow/shared/models/page_definition.dart';
import 'package:payflow/shared/utils/routes_name.dart';

///Classe que contém a definição das rotas para 
abstract class RoutesDrawer {
  static const items = <PageDefinition>[
    PageDefinition(
      title: 'Boletos', 
      leading: const Icon(Icons.description), 
      routeName: RoutesName.home,
    ),
    PageDefinition(
      title: 'Configurações', 
      leading: const Icon(Icons.settings), 
      routeName: RoutesName.configs,
    ),
  ];
}