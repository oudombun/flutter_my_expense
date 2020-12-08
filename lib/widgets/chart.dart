import 'package:flutter/material.dart';
import 'package:flutterapp4myexpense/models/transaction.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);

  List<Map<String, Object>> get groupListTransaction {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double total = 0.0;
      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekday.day &&
            transactions[i].date.month == weekday.month &&
            transactions[i].date.year == weekday.year) {
          total += transactions[i].ammount;
        }
      }
      print("sam nas $index");
      return {'day': DateFormat.E().format(weekday), 'amount': total};
    }).reversed.toList();
  }

  double get totalSpendThisWeek{
    return groupListTransaction.fold(0.0, (sum, item) {
      return sum+= item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupListTransaction.map((data) {
            return Flexible(
                fit: FlexFit.tight,
                child:
                ChartBar(data['day'], data['amount'],totalSpendThisWeek==0.0 ? 0.0: (data['amount'] as double)/totalSpendThisWeek));
          }).toList(),
        ),
    ));
  }
}
