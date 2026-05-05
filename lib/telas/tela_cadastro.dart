import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tarefa.dart';
import '../providers/tarefas_provider.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();
  String _titulo = '';
  String _descricao = '';
  String _categoria = 'Estudos';
  DateTime _dataPrevista = DateTime.now();
  bool _importante = false;

  void _mostrarInterpretadorDeData() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    ).then((dataEscolhida) {
      if (dataEscolhida == null) return;
      setState(() {
        _dataPrevista = dataEscolhida;
      });
    });
  }

  void _salvarTarefa() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final novaTarefa = Tarefa(
      titulo: _titulo,
      descricao: _descricao,
      dataPrevista: _dataPrevista,
      importante: _importante,
      categoria: _categoria,
    );

    Provider.of<TarefasProvider>(context, listen: false).adicionarTarefa(novaTarefa);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (valor) => valor!.trim().isEmpty ? 'Informe o título' : null,
                onSaved: (valor) => _titulo = valor!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                minLines: 1, // Começa com 1 linha (perto do traço)
                maxLines: 5, // Cresce até 5 linhas se precisar
                keyboardType: TextInputType.multiline,
                validator: (valor) => valor!.trim().isEmpty ? 'Informe a descrição' : null,
                onSaved: (valor) => _descricao = valor!,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Data: ${_dataPrevista.day}/${_dataPrevista.month}/${_dataPrevista.year}',
                    ),
                  ),
                  TextButton(
                    onPressed: _mostrarInterpretadorDeData,
                    child: const Text('Selecionar Data'),
                  )
                ],
              ),
              DropdownButtonFormField<String>(
                value: _categoria,
                decoration: const InputDecoration(labelText: 'Categoria'),
                items: ['Estudos', 'Trabalho', 'Pessoal', 'Outros'].map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (valor) => setState(() => _categoria = valor!),
              ),
              SwitchListTile(
                title: const Text('É uma tarefa importante?'),
                value: _importante,
                onChanged: (valor) => setState(() => _importante = valor),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _salvarTarefa,
                child: const Text('Salvar Tarefa'),
              )
            ],
          ),
        ),
      ),
    );
  }
}