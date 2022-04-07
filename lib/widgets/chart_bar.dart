import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
      {Key? key,
      required String label,
      required double spendingAmount,
      required double spendingPctOfTotal})
      : _label = label,
        _spendingAmount = spendingAmount,
        _spendingPctOfTotal = spendingPctOfTotal,
        super(key: key);

  final String _label;
  final double _spendingAmount;
  final double _spendingPctOfTotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: SizedBox(
            height: 20,
            child: Text(
              'R\$ ${_spendingAmount.toStringAsFixed(0)}',
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: _spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        Text(
          _label,
        )
      ],
    );
  }
}
