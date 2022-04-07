import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:personal_expenses_app/widgets/chart.dart';
import 'widgets/new_transaction.dart';

import 'models/transaction.dart';
import 'widgets/transaction_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      // theme: ThemeData(primaryColor: Colors.amber, primarySwatch: Colors.amber),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: const TextStyle(color: Colors.white),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(onClick: _addNewTransaction);
      },
    );
  }

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Assinatura FFXIV',
    //   amount: 30.50,
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Pizza',
    //   amount: 50,
    // ),
  ];

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: date,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  List<Transaction> get _recentTransactions {
    final result = _userTransactions.where(
      (element) => element.getDate().isAfter(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          ),
    );
    return result.toList();
  }

  void _removeTransaction(int hashCode) {
    setState(() {
      _userTransactions.removeWhere((element) => element.hashCode == hashCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: const Icon(Icons.add),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              child: Chart(
                transactions: _recentTransactions,
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: TransactionList(
                userTransactions: _userTransactions,
                onRemove: _removeTransaction,
              ),
            ),
            // Chart(
            //   transactions: _recentTransactions,
            // ),
            // TransactionList(
            //   userTransactions: _userTransactions,
            //   onRemove: _removeTransaction,
            // ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
