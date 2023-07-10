// TODO Implement this library.
import 'package:flutter/material.dart';

import '../app_drawer.dart';

class SuggestionsPage extends StatelessWidget {
  const SuggestionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/other');
              },
              child: const Text('Go to Other Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/stock');
              },
              child: const Text('Go to Stock Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/another');
              },
              child: const Text('Go to Another Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class AnotherPage extends StatelessWidget {
  const AnotherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}
