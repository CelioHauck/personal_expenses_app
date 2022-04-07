import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final void Function(String, double) _onClick;

  const NewTransaction(
      {Key? key, required void Function(String, double) onClick})
      : _onClick = onClick,
        super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) return;

    widget._onClick(
      titleController.text,
      double.parse(amountController.text),
    );

    Navigator.of(context).pop();
  }

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
              onSubmitted: (_) => _submitData(),
              decoration: const InputDecoration(
                labelText: 'Titulo',
              ),
            ),
            TextField(
              controller: amountController,
              onSubmitted: (_) => _submitData(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Preço',
              ),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  const Text('Nenhuma data selecionada'),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Escolha uma data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.primary,
              ),
              onPressed: _submitData,
              child: Text(
                'Adicionar compra',
                style: TextStyle(
                  color: Theme.of(context).textTheme.button?.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
