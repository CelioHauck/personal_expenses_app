import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required List<Transaction> transactions})
      : _recentTransactions = transactions,
        super(key: key);

  final List<Transaction> _recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index + 1,
        ),
      );

      final day = DateFormat.E('pt_BR').format(weekDay);

      double sumAll = _recentTransactions.fold(0, (value, element) {
        if (element.getDayDate() == day) {
          return value + element.getAmount();
        }
        return 0.0;
      });
      return {'day': day, 'amount': sumAll};
    });
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + double.parse(element['amount'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.reversed.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'].toString(),
                spendingAmount: (data['amount'] as double),
                spendingPctOfTotal: maxSpending != 0.0
                    ? (data['amount'] as double) / maxSpending
                    : 0,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
