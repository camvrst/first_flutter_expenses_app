import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Text(
                  'No transactions added yet...',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/emptyListPNG.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              // always take itemBuilder, who takes a function with a ctxt arg and an index that indicates which element should be rendered
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    // First element of the list tile
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text('${transactions[index].amount}€'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                        onPressed: () => deleteTransaction(transactions[index].id),
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor),
                  ),
                );
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
            ),
    );
  }
}
