import 'package:flutter/material.dart';
import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'No transactions added yet...',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/emptyListPNG.png',
                      fit: BoxFit.cover,
                    ))
              ],
            );
          })
        : ListView.builder(
            // always take itemBuilder, who takes a function with a ctxt arg and an index that indicates which element should be rendered
            itemBuilder: (context, index) {
              return TransactionItem(transaction: transactions[index], deleteTransaction: deleteTransaction);
              // return Card(
              //   child: Row(
              //     children: <Widget>[
              //       Container(
              //         margin:
              //             EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //               color: Theme.of(context).primaryColorLight,
              //               width: 2),
              //           borderRadius: BorderRadius.circular(12),
              //         ),
              //         padding: EdgeInsets.all(10),
              //         child: Text(
              //           '${transactions[index].amount.toStringAsFixed(2)} €',
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 14,
              //               color: Theme.of(context).primaryColor),
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Text(
              //             transactions[index].title,
              //             style: Theme.of(context).textTheme.headline6,
              //           ),
              //           Text(
              //             DateFormat('dd-MM-yyyy')
              //                 .format(transactions[index].date),
              //             style: TextStyle(color: Colors.grey),
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // );
            },
            itemCount: transactions.length,
            // Tells how many times the function should be executed
            //     children: transactions.map((transaction) {
            //       // here, as it's not a map, we can access the properties with a . instead of ['title']
            //       return
            //     }).toList(),
          );
  }
}

