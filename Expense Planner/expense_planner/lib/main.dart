import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/transaction_chart.dart';
import 'package:expense_planner/widgets/transaction_form.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  final ThemeData theme = ThemeData(
      primarySwatch: Colors.purple,
      fontFamily: 'Quicksand',
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
    return MaterialApp(
      title: 'Expense Planner',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          secondary: Colors.amber,
        ),
      ),
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
    Transaction(id: '1', title: 'Tx 1', amount: 15, date: DateTime.now()),
    Transaction(
        id: '2',
        title: 'Tx 2',
        amount: 20,
        date: DateTime.now().subtract(const Duration(days: 1))),
    Transaction(
        id: '3',
        title: 'Tx 3',
        amount: 30,
        date: DateTime.now().subtract(const Duration(days: 2))),
    Transaction(
        id: '4',
        title: 'Tx 4',
        amount: 45,
        date: DateTime.now().subtract(const Duration(days: 3))),
    Transaction(
        id: '5',
        title: 'Tx 5',
        amount: 50,
        date: DateTime.now().subtract(const Duration(days: 5))),
    Transaction(
        id: '6',
        title: 'Tx 6',
        amount: 15,
        date: DateTime.now().subtract(const Duration(days: 5))),
    Transaction(
        id: '7',
        title: 'Tx 7',
        amount: 20,
        date: DateTime.now().subtract(const Duration(days: 6))),
    Transaction(
        id: '8',
        title: 'Tx 8',
        amount: 35,
        date: DateTime.now().subtract(const Duration(days: 0))),
    Transaction(
        id: '9',
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
      id: DateTime.now().toString(),
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
    final _appBar = AppBar(
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

    final _availableSize = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top - // Status Bar at the top
        _appBar.preferredSize.height;

    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Show Chart'),
                Switch(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    }),
              ],
            ),
            _showChart
                ? TransactionChart(
                    recentTransaction,
                    height: _availableSize * 0.35,
                  )
                : TransactionList(
                    _userTransactions,
                    _deleteTransaction,
                    height: _availableSize * 0.65,
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _displayTransactionForm(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
