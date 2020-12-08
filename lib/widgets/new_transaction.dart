import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {

  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime _selectDate;

  void _submitText(){
    final title = _titleController.text;
    final price = double.parse(_priceController.text);

    if(title.isEmpty || price <=0 || _selectDate==null){
      return;
    }
    widget.addTransaction(title,price,_selectDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(context: context, initialDate: DateTime.now(),
        firstDate:DateTime(2019), lastDate: DateTime.now())
    .then((value){
      setState(() {
        _selectDate=value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleController,

            ),
            TextField(
              decoration: InputDecoration(labelText: "Price"),
              controller: _priceController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
            ),
            Container(
              height: 70,
              child: Row(children: <Widget>[
                Expanded(child: Text(_selectDate==null ? "No Date Selected!":"Pick Date: "+DateFormat.yMd().format(_selectDate))),
                FlatButton(
                  child: Text("Choose Date",
                    style: TextStyle(color:  Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
                  onPressed: _presentDatePicker,
                )
              ],),
            ),
            RaisedButton(
              child: Text("Add Transaction",
              style: TextStyle(color: Theme.of(context).buttonColor)),
              color: Theme.of(context).primaryColor,
              onPressed: _submitText,
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
      ),
      elevation: 5,
    );
  }
}
