import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        //convertendo os elementos para elementos visuais
        children: transactions.map((tr) {
          return Card(
            child: Row(children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.purple,
                    width: 2,
                  )),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'R\$ ${tr.value.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.purple),
                  )),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  tr.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  DateFormat('d MMM y').format(tr.date),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ])
            ]),
          );
        }).toList(),
      ),
    );
  }
}
