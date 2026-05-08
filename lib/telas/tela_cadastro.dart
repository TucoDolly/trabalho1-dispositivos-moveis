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
  bool _carregado = false;
  Tarefa? _tarefaParaEdicao;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_carregado) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args != null && args is Tarefa) {
        _tarefaParaEdicao = args;
        _titulo = _tarefaParaEdicao!.titulo;
        _descricao = _tarefaParaEdicao!.descricao;
        _categoria = _tarefaParaEdicao!.categoria;
        _dataPrevista = _tarefaParaEdicao!.dataPrevista;
        _importante = _tarefaParaEdicao!.importante;
      }
      _carregado = true;
    }
  }

  void _mostrarInterpretadorDeData() {
    
    final dataAtual = DateTime.now();
    final hoje = DateTime(dataAtual.year, dataAtual.month, dataAtual.day);
    final dataInicial = DateTime(_dataPrevista.year, _dataPrevista.month, _dataPrevista.day);

    showDatePicker(
      context: context,
      initialDate: _dataPrevista,
      
      // BLOQUEIA DATAS PASSADAS
      firstDate: dataInicial.isBefore(hoje) ? _dataPrevista : hoje,
      
      // ATIVA DATAS PASSADAS
      //firstDate: DateTime(2000),
      
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
      id: _tarefaParaEdicao?.id,
      titulo: _titulo,
      descricao: _descricao,
      dataPrevista: _dataPrevista,
      importante: _importante,
      categoria: _categoria,
      realizada: _tarefaParaEdicao?.realizada ?? false,
    );

    if (_tarefaParaEdicao == null) {
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
        title: Text(_tarefaParaEdicao == null ? 'Nova Tarefa' : 'Editar Tarefa'),
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
                child: Text(_tarefaParaEdicao == null ? 'Salvar Tarefa' : 'Atualizar Tarefa'),
              )
            ],
          ),
        ),
      ),
    );
  }
}