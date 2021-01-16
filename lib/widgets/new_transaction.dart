import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function _onSubmit;

  NewTransaction(this._onSubmit);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TextEditingController titleInput = TextEditingController();
  TextEditingController amountInput = TextEditingController();
  DateTime _selectedDate;
  void _pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        _selectedDate = value;
      });
    });
  }

  void submit() {
    final String title = titleInput.text;
    final double amount = double.parse(amountInput.text);
    if (title.isEmpty || amount <= 0 || _selectedDate == null) return;
    widget._onSubmit(
      title,
      amount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
            ),
            controller: titleInput,
            onSubmitted: (_) => submit(),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
            controller: amountInput,
            onSubmitted: (_) => submit(),
            keyboardType: TextInputType.number,
          ),
          Row(
            children: [
              Text(
                _selectedDate == null
                    ? 'No date is picked'
                    : "Day picked: ${DateFormat.yMd().format(_selectedDate)}",
              ),
              FlatButton(
                child: Text('Pick a date',
                    style: TextStyle(color: Theme.of(context).primaryColor)),
                onPressed: _pickDate,
              )
            ],
          ),
          RaisedButton(
            child:
                Text("Add Transaction", style: TextStyle(color: Colors.white)),
            color: Theme.of(context).primaryColor,
            onPressed: submit,
          )
        ],
      ),
    );
  }
}
