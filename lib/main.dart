import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:personal_expenses_app/widgets/user_transactions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);
    return const MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.blue,
              // ignore: avoid_unnecessary_containers
              child: Container(
                width: double.infinity,
                child: const Text('Graficos'),
              ),
              elevation: 5,
            ),
            const UserTransactions(),
          ],
        ),
      ),
    );
  }
}
