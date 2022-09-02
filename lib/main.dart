import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                //button: TextStyle(color: Colors.white) ERROR
              ),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: '001', title: 'New shoes', amount: 99.99, date: DateTime.now()),
    // Transaction(
    //     id: '002',
    //     title: 'Weekly groceries',
    //     amount: 16.53,
    //     date: DateTime.now()),
    // Transaction(
    //     id: '002',
    //     title: 'Weekly groceries',
    //     amount: 16.53,
    //     date: DateTime.now()),
    // Transaction(
    //     id: '002',
    //     title: 'Weekly groceries',
    //     amount: 16.53,
    //     date: DateTime.now()),
    // Transaction(
    //     id: '002',
    //     title: 'Weekly groceries',
    //     amount: 16.53,
    //     date: DateTime.now()),
    // Transaction(
    //     id: '002',
    //     title: 'Weekly groceries',
    //     amount: 16.53,
    //     date: DateTime.now()),
    // Transaction(
    //     id: '002',
    //     title: 'Weekly groceries',
    //     amount: 16.53,
    //     date: DateTime.now()),
    // Transaction(
    //     id: '002',
    //     title: 'Weekly groceries',
    //     amount: 16.53,
    //     date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      final dateSevenDaysAgo = DateTime.now().subtract(Duration(days: 7));
      return transaction.date.isAfter(dateSevenDaysAgo);
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext buildContext) {
    showModalBottomSheet(
        context: buildContext,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_userTransactions, _deleteTransaction)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context)),
    );
  }
}
