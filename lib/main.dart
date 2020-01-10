import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.blueGrey[300],
        fontFamily: 'Oswald',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(fontFamily: 'Special Elite', 
              fontSize: 15, 
              fontWeight: FontWeight.bold
            ),
          ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(fontFamily: 'Special Elite', fontSize: 25),
          ),
        )

      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [
    //Transaction(
      //id: 't1',
      //title: 'New Sweatshirt',
      //price: 799.0,
      //date: DateTime.now()
    //),
    //Transaction(
      //id: 't2',
      //title: 'Udemy Course',
      //price: 599.0,
      //date: DateTime.now()
    //),
    //Transaction(
      //id: 't3',
      //title: 'Ring',
      //price: 9799.0,
      //date: DateTime.now()
    //),
  ];

  List<Transaction> get _recentTransactions{
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime selectedDate){
    final newTx = Transaction(title: title, price: amount, id: DateTime.now().toString() , date: selectedDate );
  
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return NewTransaction(_addTransaction);
    } );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses App', ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_box),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions, this._deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}

