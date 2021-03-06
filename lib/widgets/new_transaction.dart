import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/widgets/adapative_text_button.dart';

class NewTransaction extends StatefulWidget {
  final void Function(String, double, DateTime) _onClick;

  const NewTransaction(
      {Key? key, required void Function(String, double, DateTime) onClick})
      : _onClick = onClick,
        super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime? _selectDate;

  void _submitData() {
    if (_amountController.text.isEmpty) return;

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectDate == null) {
      return;
    }

    widget._onClick(
      _titleController.text,
      double.parse(_amountController.text),
      _selectDate!,
    );

    Navigator.of(context).pop();
  }

  void _presentDataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                decoration: const InputDecoration(
                  labelText: 'Titulo',
                ),
              ),
              TextField(
                controller: _amountController,
                onSubmitted: (_) => _submitData(),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Pre??o',
                ),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectDate != null
                            ? 'Data escolhida: ${DateFormat.yMd('pt_BR').format(_selectDate as DateTime)}'
                            : 'Nenhuma data selecionada',
                      ),
                    ),
                    AdapativeTextButton(
                      onClick: _presentDataPicker,
                      text: 'Escolha uma data',
                    )
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
      ),
    );
  }
}
