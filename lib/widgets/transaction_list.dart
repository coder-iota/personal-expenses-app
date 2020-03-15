import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;

  /// Received in constructor.

  final Function _deleteTx;

  /// Used to delete the transaction. Defined in MyHomePageState class in main.dart

  TransactionList(this._userTransactions, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, cnst) {
            /// Ternary operator to render widget tree differently for non-empty and empty list.
            return Center(
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
                      height: cnst.maxHeight * 0.65,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              ),
            );
          })
        :
        /// Widget tree for a non-empty list [_userTransactions].
        ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 4, vertical: 7),
                child: ListTile(
                  /// Creates the circular price tag.
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          '\$' +
                              _userTransactions[index].price.toStringAsFixed(2),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Adds transaction title to each tile.
                  title: Text(
                    _userTransactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),

                  /// Adds the transaction date to the tile.
                  subtitle: Text(
                    DateFormat.yMMMMd().format(_userTransactions[index].date),
                    style: TextStyle(color: Colors.grey),
                  ),

                  ///  Delete transaction button at the right end of the tile.
                  trailing: MediaQuery.of(context).size.width >= 450 ? FlatButton.icon(
                       onPressed: () {
                          _deleteTx(_userTransactions[index].id);
                       }, 
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      textColor: Theme.of(context).errorColor,
                      label: Text('Delete')
                    )
                    : 
                    IconButton(
                      icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () {
                      _deleteTx(_userTransactions[index].id);
                    },
                  ),
                ),
              );
            },

            /// Determines the total number of tile items that could be built.
            itemCount: _userTransactions.length,
          );
  }
}
