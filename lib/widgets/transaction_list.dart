import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  Function deleteList;

  TransactionList(this.transactions,this.deleteList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Container(
                  height: 300,
                  child: Image.asset(
                  "assets/images/notfound.png",
                  fit: BoxFit.contain,
                )),
                SizedBox(height: 30,),
                Text(
                  "No Transaction added",
                  style: Theme.of(context).textTheme.title,
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, i) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                  elevation: 7,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(padding:EdgeInsets.all(6),child: FittedBox(child: Text('\$${transactions[i].ammount}'))),
                    ),
                    title: Text('${transactions[i].title}'),
                    subtitle: Text(DateFormat.yMMMd().format(transactions[i].date)),
                    trailing: IconButton(icon: Icon(Icons.delete),color: Theme.of(context).errorColor,onPressed: (){ deleteList(transactions[i].id);},),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
