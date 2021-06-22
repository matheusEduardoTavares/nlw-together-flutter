// import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({ Key? key }) : super(key: key);

//   final _counter = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Meu Primeiro App'),
//       ),
//       body: Center(
//         child: Text(
//           'CONTADOR\n$_counter',
//           textAlign: TextAlign.center,
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           print('aq');
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Primeiro App'),
      ),
      body: Center(
        child: Text(
          'CONTADOR\n$_counter',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}