import 'package:ExpensesApp/models/transaction.dart';
import 'package:flutter/material.dart';
import '../widgets/chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<transaction> recentTransactions;
  Chart(this.recentTransactions);
  double get totalWeekAmount {
    double sum = 0.0;
    recentTransactions.forEach((element) {
      sum += element.amount;
    });
    return sum;
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year)
          totalSum += recentTransactions[i].amount;
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    e['day'],
                    e['amount'],
                    totalWeekAmount == 0.0
                        ? 0.0
                        : (e['amount'] as double) / totalWeekAmount),
              );
            }).toList()),
      ),
    );
  }
}
