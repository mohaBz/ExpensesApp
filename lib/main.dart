import 'dart:ui';
import 'dart:io';

import 'package:ExpensesApp/widgets/chart.dart';
import 'package:ExpensesApp/widgets/new_transaction.dart';
import 'package:ExpensesApp/widgets/transactionList.dart';
import 'package:ExpensesApp/models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.tealAccent,
          errorColor: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
          ),
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<transaction> _userTransactions = [
    transaction(amount: 50, title: "sdsd", date: DateTime.now(), id: "152"),
    transaction(amount: 50, title: "sdsd", date: DateTime.now(), id: "152"),
    transaction(amount: 50, title: "sdsd", date: DateTime.now(), id: "152"),
    transaction(amount: 50, title: "sdsd", date: DateTime.now(), id: "152"),
    transaction(amount: 50, title: "sdsd", date: DateTime.now(), id: "152"),
    transaction(amount: 50, title: "sdsd", date: DateTime.now(), id: "152"),
    transaction(amount: 50, title: "sdsd", date: DateTime.now(), id: "152")
  ];
  bool showChart = true;

  void deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  List<transaction> get recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTransaction = transaction(
      title: title,
      amount: amount,
      id: DateTime.now().toString(),
      date: date,
    );
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void showAddTransactionSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(
            _addNewTransaction,
          );
        });
  }

  void switchPresed(bool value) {
    setState(() {
      showChart = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("Expenses App"),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => showAddTransactionSheet(context),
        )
      ],
    );
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final txList = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: transactionList(
        _userTransactions,
        deleteTransaction,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (isLandScape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Show Chart"),
                    Switch.adaptive(
                        activeColor: Theme.of(context).accentColor,
                        value: showChart,
                        onChanged: (value) {
                          switchPresed(value);
                        })
                  ],
                ),
              if (!isLandScape)
                Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(recentTransactions),
                ),
              if (!isLandScape) txList,
              if (isLandScape)
                showChart
                    ? Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.7,
                        child: Chart(recentTransactions),
                      )
                    : txList
            ],
          ),
        ),
      ),
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => showAddTransactionSheet(context),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
