import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTx;

  TransactionList(this._userTransactions, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 495,
      child: _userTransactions.isEmpty
          ? Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'No Transactions yet.',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 300,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 4, vertical: 7),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            '\$' +
                                _userTransactions[index]
                                    .price
                                    .toStringAsFixed(2),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      _userTransactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(_userTransactions[index].date),
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Theme.of(context).errorColor,),
                      onPressed: () {
                        _deleteTx(_userTransactions[index].id);
                      },
                    ),
                  ),
                );
              },
              itemCount: _userTransactions.length,
            ),
    );
  }
}
