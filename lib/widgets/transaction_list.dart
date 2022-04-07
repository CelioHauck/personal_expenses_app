import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final void Function(int) _onRemove;

  const TransactionList({
    Key? key,
    required List<Transaction> userTransactions,
    required Function(int) onRemove,
  })  : _userTransactions = userTransactions,
        _onRemove = onRemove,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? LayoutBuilder(builder: ((context, constraints) {
            return Column(
              children: [
                Text(
                  'Não encontramos uma transação',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          }))
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: FittedBox(
                        child: Text(
                          _userTransactions[index].getAmountWithCurrency(),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    _userTransactions[index].getTitle(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    _userTransactions[index].getDateFormat(),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => _onRemove(
                      _userTransactions[index].hashCode,
                    ),
                  ),
                ),
              );
              // return Card(
              //   child: Row(
              //     children: [
              //       Container(
              //         margin: const EdgeInsets.symmetric(
              //           vertical: 10,
              //           horizontal: 15,
              //         ),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Theme.of(context).colorScheme.primary,
              //             width: 2,
              //           ),
              //         ),
              //         padding: const EdgeInsets.all(10),
              //         child: Text(
              //           _userTransactions[index].getAmountWithCurrency(),
              //           style: TextStyle(
              //             fontSize: 18,
              //             color: Theme.of(context).colorScheme.primary,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(_userTransactions[index].getTitle(),
              //               style: Theme.of(context).textTheme.headline6),
              //           Text(
              //             _userTransactions[index].getDateFormat(),
              //             style: const TextStyle(
              //               color: Colors.grey,
              //               fontSize: 14,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // );
            },
            itemCount: _userTransactions.length,
          );
  }
}
