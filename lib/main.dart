import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.teal,
        errorColor: Colors.redAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                button: TextStyle(color: Colors.white),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //String titleInput;
  //String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(id: 't1', title: 'New shoes', amount: 75, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'Kenya\'s food', amount: 15.89, date: DateTime.now()),
    // Transaction(
    //     id: 't3', title: 'Groceries', amount: 155.76, date: DateTime.now()),
  ];

  // Get the new transactions

  List<Transaction> get _recentTransactions {
    // .where allows to run a function on every item in a list
    // If it returns true, the item is kept in a nemly returned list
    // Where returns an iterable, not a list as expected, then we add toList
    return _userTransaction.where((transaction) {
      // returns true if the date is after the other
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctxt) {
    // builder is a function that needs to return the widget that will be inside that modal btm sheet
    showModalBottomSheet(
      context: ctxt,
      builder: (_) {
        return GestureDetector(
          // Avoid the sheet to close if we tap on it
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((transaction) {
        return transaction.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransaction, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.yellowAccent,
        ),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}