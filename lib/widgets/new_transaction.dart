import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final void Function(String, double) _onClick;

  NewTransaction({Key? key, required void Function(String, double) onClick})
      : _onClick = onClick,
        super(key: key);

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Titulo',
              ),
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Preço',
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.purple,
              ),
              onPressed: () {
                _onClick(
                  titleController.text,
                  double.parse(amountController.text),
                );
              },
              child: const Text('Adicionar compra'),
            )
          ],
        ),
      ),
    );
  }
}
