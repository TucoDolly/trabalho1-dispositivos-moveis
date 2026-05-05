import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarefas_provider.dart';
import 'tela_cadastro.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  void initState() {
    super.initState();
    Provider.of<TarefasProvider>(context, listen: false).carregarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
      ),
      body: Consumer<TarefasProvider>(
        builder: (ctx, tarefasProvider, child) {
          if (tarefasProvider.tarefas.isEmpty) {
            return const Center(
              child: Text('Nenhuma tarefa cadastrada.'),
            );
          }
          return ListView.builder(
            itemCount: tarefasProvider.tarefas.length,
            itemBuilder: (ctx, i) {
              final tarefa = tarefasProvider.tarefas[i];
              return ListTile(
                // Estrela amarela se for importante, cinza se não for
                leading: Icon(
                  tarefa.importante ? Icons.star : Icons.star_border,
                  color: tarefa.importante ? Colors.amber : Colors.grey,
                  size: 30,
                ),
                title: Text(
                  tarefa.titulo,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tarefa.descricao),
                    const SizedBox(height: 4),
                    // Exibindo a categoria com um destaque
                    Text(
                      'Categoria: ${tarefa.categoria}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                trailing: Text('${tarefa.dataPrevista.day}/${tarefa.dataPrevista.month}/${tarefa.dataPrevista.year}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const TelaCadastro(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}