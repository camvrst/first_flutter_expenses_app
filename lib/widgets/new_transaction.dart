import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    // widget is available in a state class and give you access to the connected widget
    widget.addNewTransaction(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    // Close the topmost screen that is displayed (btm sheet here)
    // context is a special property that is available in the state
    Navigator.of(context).pop();
  }

  // Date picker

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((datePicked) {
      if (datePicked == null) {
        return;
      }

      setState(() {
        _selectedDate = datePicked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                cursorColor: Colors.pink,
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                /*onChanged: (value) {
                        titleInput = value;
                      },*/
              ),
              TextField(
                cursorColor: Colors.orange,
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                // Here, we need a value arg even if it's not used. The convention is to write an _ = not used arg
                onSubmitted: (_) => _submitData(),
                /*onChanged: (value) {
                        amountInput = value;
                      },*/
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No date chosen.'
                            : 'Picked date : ${DateFormat.yMMMMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveFlatButton('Pick a date', _presentDatePicker),
                  ],
                ),
              ),
              FlatButton(
                onPressed: _submitData,
                color: Colors.teal,
                child: Text('Add transaction'),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
