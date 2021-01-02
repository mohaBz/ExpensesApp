import 'package:flutter/foundation.dart';

class transaction {
  final String id;
  final double amount;
  final String title;
  final DateTime date;

  transaction({@required this.id,@required this.amount,@required this.title,@required this.date});

}