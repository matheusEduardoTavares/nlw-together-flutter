// import 'package:flutter/material.dart';

// void main(List<String> args) {
//   runApp(
//     MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.purple,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Meu Primeiro App'),
//         ),
//         body: Container(
//           height: 500,
//           width: 500,
//           color: Colors.purple,
//           child: Center(
//             child: Container(
//               height: 200,
//               width: 200,
//               color: Colors.green,
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }

// import 'package:flutter/material.dart';

// void main(List<String> args) {
//   var _counter = 0;

//   runApp(
//     MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.purple,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Meu Primeiro App'),
//         ),
//         body: Center(
//           child: Text(
//             'CONTADOR\n$_counter',
//             textAlign: TextAlign.center,
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             print('print no FAB');
//           },
//           child: const Icon(Icons.add),
//         ),
//       ),
//     ),
//   );
// }

import 'package:counter_app/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      title: 'Meu primeiro APP',
      home: const HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
    ),
  );
}