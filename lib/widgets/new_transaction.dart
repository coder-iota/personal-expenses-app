import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransaction;

  NewTransaction(this._addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData(BuildContext ctx) {
    
    if (titleController.text.isEmpty ||
        double.parse(amountController.text) <= 0 ||
        _selectedDate == null) 
          return;

    widget._addTransaction(
        titleController.text, 
        double.parse(amountController.text),
        this._selectedDate
      );

    Navigator.of(ctx).pop();
  }

  void _presentDatePicker(BuildContext ctx) {
    showDatePicker(
            context: ctx,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickeDate) {
      if (pickeDate == null) return;
      setState(() {
        _selectedDate = pickeDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          padding: EdgeInsets.only(
            top: 10, 
            left: 10, 
            right: 10, 
            bottom: MediaQuery.of(context).viewInsets.bottom + 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => this._presentDatePicker(context),
              ),
              Container(
                height: 65,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _selectedDate == null
                          ? Text(
                              'No Date Chosen !',
                              style: TextStyle(color: Colors.grey),
                            )
                          : Text('${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    FlatButton(
                      textColor: Theme.of(context).accentColor,
                      color: Colors.white,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'Oswald'),
                      ),
                      onPressed: () {
                        _presentDatePicker(context);
                      },
                    )
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('Add Transaction'),
                onPressed: () => _submitData(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
