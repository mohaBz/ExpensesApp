import 'package:ExpensesApp/models/transaction.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class transactionList extends StatelessWidget {
  List<transaction> _userTransactions;
  Function _delete;
  transactionList(this._userTransactions, this._delete);
  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? Column(
            children: [
              Text(
                'No transaction found',
                style: Theme.of(context).textTheme.headline6,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                ),
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.contain,
                ),
              )
            ],
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                          '\$${_userTransactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    _userTransactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    _userTransactions[index].date.year.toString() +
                        "-" +
                        _userTransactions[index].date.month.toString() +
                        "-" +
                        _userTransactions[index].date.day.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () {
                      _delete(_userTransactions[index].id);
                    },
                  ),
                ),
              );
            },
            itemCount: _userTransactions.length,
          );
  }
}
