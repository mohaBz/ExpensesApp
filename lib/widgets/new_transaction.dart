import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  Function _onSubmit;

  NewTransaction(this._onSubmit);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TextEditingController titleInput = TextEditingController();

  TextEditingController amountInput = TextEditingController();

  void submit() {
    final String title = titleInput.text;
    final double amount = double.parse(amountInput.text);
    if (title.isEmpty || amount <= 0) return;
    widget._onSubmit(
      title,
      amount,
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
          FlatButton(
            child: Text("Add Transaction"),
            textColor: Colors.redAccent,
            onPressed: submit,
          )
        ],
      ),
    );
  }
}
