import 'package:ExpensesApp/models/transaction.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class transactionList extends StatelessWidget {
  List<transaction> _userTransactions;
  transactionList(this._userTransactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _userTransactions.isEmpty
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
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          '\$${_userTransactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _userTransactions[index].title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
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
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: _userTransactions.length,
            ),
    );
  }
}
