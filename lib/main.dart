import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

/// This is the root widget.

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses App',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.blueGrey[300],

          /// Font file present in ./assets folder.
          fontFamily: 'Oswald',

          /// Theme data for titles.
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'Special Elite',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),

          /// AppBar Theme similar to text theme.
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(fontFamily: 'Special Elite', fontSize: 25),
                ),
          )),

      /// Main Display Widget.
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// List to keep user entered transactions.
  final List<Transaction> _userTransactions = [];

  /// Controls the chart switch and display.
  bool _showChart = false;

  void _switchChart() {
    this._showChart = !(this._showChart);
  }

  /// Used by chart widget to get transactions for past 7 days.
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  /// Used by new transaction widget to add a new element to the [_userTransaction] list.
  void _addTransaction(String title, double amount, DateTime selectedDate) {
    final newTx = Transaction(
        title: title,
        price: amount,
        id: DateTime.now().toString(),
        date: selectedDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  /// Used by TransactioList widget to delete the specified transaction via the delete button.
  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  /// Used by floating action button and icon button to display the new transaction modal sheet.
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(
              _addTransaction); // Defined in ./widgets/new_transaction.dart
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =  MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar = AppBar(
      title: Text(
        'Expenses App',
      ),
      actions: <Widget>[
        /// Icon button on the top right corner.
        IconButton(
          icon: Icon(Icons.add_box),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );

    return Scaffold(
      appBar: appbar,
      // Makes the entire screen scrollable, thus avoiding any overflow.
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: isLandscape ? <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('Show Chart'),
                Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _switchChart();
                      });
                    })
              ],
            ),
            this._showChart ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: Chart(_recentTransactions))
                : // Defined in ./widgets/chart.dart
                Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.73,
                    child: TransactionList(_userTransactions,
                        this._deleteTransaction)), // Defined in ./widgets/transaction_list.dart
          ]
          :
          <Widget>[
            Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.3,
                    child: Chart(_recentTransactions))
                , // Defined in ./widgets/chart.dart
            Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top) * 0.73,
                  child: TransactionList(_userTransactions,
                      this._deleteTransaction)), // Defined in ./widgets/transaction_list.dart
          ]
          ,
        ),
      ),

      /// Floatingaction button displayed at the bottom center.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
