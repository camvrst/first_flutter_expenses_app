// To be able to use @required
import 'package:flutter/foundation.dart';

// Blueprint of a normal Dart object. Not a widget.

class Transaction {
  // properties

  // Final because they should never change, they're runtime constant.
  // They get their values when the transaction is created but the balue thereafter never changes.

  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.id, 
    @required this.title, 
    @required this.amount, 
    @required this.date});
}
