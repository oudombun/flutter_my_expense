import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'package:intl/intl.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _startTransaction(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
          onTap: (){},
        );
      },
    );
  }

  final List<Transaction> _transactions = [
//    Transaction(id: "t1", title: "Watch", ammount: 10.3, date: DateTime.now()),
//    Transaction(id: "t2", title: "shoe", ammount: 20.3, date: DateTime.now().subtract(Duration(days: 1))),
  ];

  List<Transaction> get recentTransaction{
      return _transactions.where((element) {
        return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
      }).toList();
  }

  Function _addTransaction(String txTitle, double txAmount,DateTime txDate) {
    final newTx = Transaction(
        title: txTitle,
        ammount: txAmount,
        date: txDate,
        id: DateTime.now().toString());
    setState(() {
      _transactions.add(newTx);
    });
  }
  Function _deleteTransaction(String id){
    setState(() {
      _transactions.removeWhere((element) => element.id==id);
    });
  }

  @override
  Widget build(BuildContext con) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'QuickSand',
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.deepPurpleAccent,
//        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'Opensan',
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
            button: TextStyle(
                color: Colors.white
            )
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'Opensan',
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              )
          ),
        )
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("My Expense"),
          centerTitle: true,
          actions: <Widget>[
            Builder(
              builder: (context)=>IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startTransaction(context),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
          builder: (context)=> FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: ()=> _startTransaction(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child:Chart(recentTransaction),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TransactionList(_transactions,_deleteTransaction))
            ],
          ),
        ),
      ),
    );
  }
}
