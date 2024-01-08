import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_connectivity_hook/flutter_connectivity_hook.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    useConnectivity(
      config: ConnectivityConfig(
        url: 'www.iconica.nl',
        handler: CustomHandler(),
        checker: CustomInternetChecker(),
      ),
    );

    var counter = useState<int>(0);

    void incrementCounter() => counter.value++;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${counter.value}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CustomInternetChecker implements ConnectivityChecker {
  @override
  Future<bool> checkConnection(ConnectivityConfig config) async {
    try {
      var result = await InternetAddress.lookup(config.url);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}

class CustomHandler implements ConnectivityHandler {
  @override
  void onConnectionLost() {
    debugPrint('Connection lost');
  }

  @override
  void onConnectionRestored() {
    debugPrint('Connection restored');
  }
}
