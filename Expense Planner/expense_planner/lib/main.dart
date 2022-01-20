import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/transaction_chart.dart';
import 'package:expense_planner/widgets/transaction_form.dart';
import 'package:expense_planner/widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); // Must set that before the next line
  // SystemChrome.setPreferredOrientations([ //Disabling Landscape mode
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ThemeData androidTheme = ThemeData(
      primarySwatch: Colors.purple,
      fontFamily: 'Quicksand',
      colorScheme:
          ThemeData.light().colorScheme.copyWith(secondary: Colors.amber),
      iconTheme: ThemeData.light().iconTheme.copyWith(color: Colors.black),
      textTheme: ThemeData.light().textTheme.copyWith(
          headline6: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18)),
      appBarTheme: const AppBarTheme(
        toolbarTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ));

  @override
  Widget build(BuildContext context) {
    // We use MaterialApp because CupertinoApp is
    // very limited in theming and the bottom form
    // does not show up.

    return MaterialApp(
      title: 'Expense Planner',
      theme: androidTheme,
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(title: 'Tx 1', amount: 15, date: DateTime.now()),
    Transaction(
        title: 'Tx 2',
        amount: 20,
        date: DateTime.now().subtract(const Duration(days: 1))),
    Transaction(
        title: 'Tx 3',
        amount: 30,
        date: DateTime.now().subtract(const Duration(days: 2))),
    Transaction(
        title: 'Tx 4',
        amount: 45,
        date: DateTime.now().subtract(const Duration(days: 3))),
    Transaction(
        title: 'Tx 5',
        amount: 50,
        date: DateTime.now().subtract(const Duration(days: 5))),
    Transaction(
        title: 'Tx 6',
        amount: 15,
        date: DateTime.now().subtract(const Duration(days: 5))),
    Transaction(
        title: 'Tx 7',
        amount: 20,
        date: DateTime.now().subtract(const Duration(days: 6))),
    Transaction(
        title: 'Tx 8',
        amount: 35,
        date: DateTime.now().subtract(const Duration(days: 0))),
    Transaction(
        title: 'Tx 9',
        amount: 45,
        date: DateTime.now().subtract(const Duration(days: 1))),
  ];

  List<Transaction> get recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    Transaction newTransaction = Transaction(
      title: txTitle,
      amount: txAmount,
      date: txDate,
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id2Delete) {
    setState(() {
      _userTransactions
          .removeAt(_userTransactions.indexWhere((tx) => tx.id == id2Delete));
    });
  }

  void _displayTransactionForm(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          // Avoid close the form when you Tap on it
          child: TransactionForm(callback: _addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget _appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              'Expense Planner',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _displayTransactionForm(context),
                  child: const Icon(CupertinoIcons.add),
                )
              ],
            ),
          ) as PreferredSizeWidget
        : AppBar(
            title: const Text(
              'Expense Planner',
            ),
            actions: [
              IconButton(
                onPressed: () => _displayTransactionForm(context),
                icon: const Icon(Icons.add),
              )
            ],
          );

    final _mediaQuery = MediaQuery.of(context);
    final _isLandscape = _mediaQuery.orientation == Orientation.landscape;
    final _availableSize = _mediaQuery.size.height -
        _mediaQuery.padding.top - // Status Bar at the top
        _appBar.preferredSize.height;

    final _txChart = TransactionChart(
      recentTransaction,
      height: _isLandscape ? _availableSize * 0.85 : _availableSize * 0.35,
    );

    final _txList = TransactionList(
      _userTransactions,
      _deleteTransaction,
      height: _isLandscape ? _availableSize * 0.85 : _availableSize * 0.65,
    );

    final _txDspSwitch = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Show Chart'),
        SizedBox(
          height: _availableSize * 0.15,
          child: Switch.adaptive(
              activeColor: Theme.of(context).colorScheme.secondary,
              value: _showChart,
              onChanged: (value) {
                setState(() {
                  _showChart = value;
                });
              }),
        ),
      ],
    );

    final _pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isLandscape) _txDspSwitch,
            if (_isLandscape) _showChart ? _txChart : _txList,
            if (!_isLandscape) ...[_txChart, _txList],
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _pageBody,
            navigationBar: _appBar as CupertinoNavigationBar,
          )
        : Scaffold(
            appBar: _appBar as AppBar,
            body: _pageBody,
            floatingActionButton: Platform.isIOS
                ? Container() // Don't display Floating button on iOS
                : FloatingActionButton(
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () => _displayTransactionForm(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
