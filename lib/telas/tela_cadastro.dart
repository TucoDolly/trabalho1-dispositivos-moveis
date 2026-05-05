import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tarefa.dart';
import '../providers/tarefas_provider.dart';

class TelaCadastro extends StatefulWidget {
  final Tarefa? tarefaParaEdicao;

  const TelaCadastro({super.key, this.tarefaParaEdicao});

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

  @override
  void initState() {
    super.initState();
    if (widget.tarefaParaEdicao != null) {
      _titulo = widget.tarefaParaEdicao!.titulo;
      _descricao = widget.tarefaParaEdicao!.descricao;
      _categoria = widget.tarefaParaEdicao!.categoria;
      _dataPrevista = widget.tarefaParaEdicao!.dataPrevista;
      _importante = widget.tarefaParaEdicao!.importante;
    }
  }

  void _mostrarInterpretadorDeData() {
    showDatePicker(
      context: context,
      initialDate: _dataPrevista,
      firstDate: DateTime(2020),
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

    final tarefaSalva = Tarefa(
      id: widget.tarefaParaEdicao?.id,
      titulo: _titulo,
      descricao: _descricao,
      dataPrevista: _dataPrevista,
      importante: _importante,
      categoria: _categoria,
    );

    if (widget.tarefaParaEdicao == null) {
      Provider.of<TarefasProvider>(context, listen: false).adicionarTarefa(tarefaSalva);
    } else {
      Provider.of<TarefasProvider>(context, listen: false).atualizarTarefa(tarefaSalva);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tarefaParaEdicao == null ? 'Nova Tarefa' : 'Editar Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _titulo,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (valor) => valor!.trim().isEmpty ? 'Informe o título' : null,
                onSaved: (valor) => _titulo = valor!,
              ),
              TextFormField(
                initialValue: _descricao,
                decoration: const InputDecoration(labelText: 'Descrição'),
                minLines: 1,
                maxLines: 5,
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
                child: Text(widget.tarefaParaEdicao == null ? 'Salvar Tarefa' : 'Atualizar Tarefa'),
              )
            ],
          ),
        ),
      ),
    );
  }
}