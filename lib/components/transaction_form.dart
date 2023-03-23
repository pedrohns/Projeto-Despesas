import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime(1900, 1, 1);

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0 || _selectedDate == DateTime(1900, 1, 1))
      return;
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      _selectedDate = pickedDate;

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            //bottom: MediaQuery.of(context).viewInsets.bottom + 10, Isso funciona porem null safety n deixa
            bottom: 10,
          ),
          child: Column(
            children: [
              TextField(
                //onChanged: (newValue) => title = newValue, //caso usado com variaveis mutaveis
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(labelText: 'Valor (R\$)'),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == DateTime(1900, 1, 1)
                          ? 'Nenhuma data selecionada!'
                          : "Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}",
                    ),
                  ),
                  TextButton(
                      onPressed: _showDatePicker,
                      child: Text('Selecionar data'),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.purple),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: Text('Nova Transação'),
                    onPressed: _submitForm,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
