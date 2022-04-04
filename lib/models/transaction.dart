import 'package:intl/intl.dart';

class Transaction {
  final String _id;
  final String _title;
  final double _amount;
  final DateTime _date;

  Transaction({
    required String id,
    required String title,
    required double amount,
    DateTime? date,
  })  : _id = id,
        _title = title,
        _amount = amount,
        _date = date ?? DateTime.now();

  String getTitle() {
    return _title;
  }

  double getAmount() {
    return _amount;
  }

  String getAmountWithCurrency() {
    return 'R\$: ${_amount.toStringAsFixed(2)}';
  }

  String getDate() {
    var format = DateFormat.yMMMEd('pt_BR');
    var dateString = format.format(_date);
    return dateString;
  }

  @override
  String toString() {
    return 'Transactsion(_id: $_id, _title: $_title, _amount: $_amount, _date: $_date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transaction &&
        other._id == _id &&
        other._title == _title &&
        other._amount == _amount &&
        other._date == _date;
  }

  @override
  int get hashCode {
    return _id.hashCode ^ _title.hashCode ^ _amount.hashCode ^ _date.hashCode;
  }
}
