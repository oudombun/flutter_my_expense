import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  double amount;
  String day;
  double percentage;

  ChartBar(this.day, this.amount, this.percentage);

  @override
  Widget build(BuildContext context) {
    print("percent" +percentage.toString());
    return Column(
      children: <Widget>[
        Container(height: 20,child: FittedBox(child: Text('\$$amount'))),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 100,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(day)
      ],
    );
  }
}
