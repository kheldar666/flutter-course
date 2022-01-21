import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:expense_planner/theme/expense_theme.dart';
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
  final ThemeData androidTheme = ExpenseTheme.android();

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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions =
      kDebugMode ? Transaction.sample() : [];

  bool _showChart = false;

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

  PreferredSizeWidget _buildAppBar() {
    return Platform.isIOS
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
  }

  // register our Listener
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (kDebugMode) {
      print(state);
    }
  }

  // Must clear the Listener to avoid performance issues
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget _appBar = _buildAppBar();

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
