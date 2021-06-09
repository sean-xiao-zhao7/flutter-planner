import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _pickedDate;

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _pickedDate = pickedDate;
      });
    });
  }

  void _submitData() {
    final title = titleController.text.toString();
    final amount = amountController.text.toString();

    if (title.isEmpty || double.parse(amount) <= 0 || _pickedDate == null) {
      return;
    }

    widget.addTransaction(title, double.parse(amount), _pickedDate);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => {_submitData()},
              ),
              Container(
                height: 60,
                child: Row(
                  children: <Widget>[
                    Text(_pickedDate != null
                        ? DateFormat.yMd().format(_pickedDate)
                        : 'No date chosen.'),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text('Choose date.',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        _showDatePicker();
                      },
                    )
                  ],
                ),
              ),
              RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  onPressed: _submitData,
                  child: Text('Add transaction',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  textColor: Theme.of(context).textTheme.button.color,
                  color: Colors.purple),
            ],
          ),
        ),
      ),
    );
  }
}
