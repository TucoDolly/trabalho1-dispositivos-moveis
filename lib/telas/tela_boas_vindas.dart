import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarefas_provider.dart';
import '../models/tarefa.dart';

class TelaBoasVindas extends StatefulWidget {
  const TelaBoasVindas({super.key});

  @override
  State<TelaBoasVindas> createState() => _TelaBoasVindasState();
}

class _TelaBoasVindasState extends State<TelaBoasVindas> {
  @override
  void initState() {
    super.initState();
    Provider.of<TarefasProvider>(context, listen: false).carregarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<TarefasProvider>(
        builder: (ctx, tarefasProvider, child) {
          Tarefa? tarefaProxima;
          bool isAtrasada = false;
          
          if (tarefasProvider.tarefas.isNotEmpty) {
            final pendentes = tarefasProvider.tarefas.where((t) => !t.realizada).toList();
            if (pendentes.isNotEmpty) {
              pendentes.sort((a, b) => a.dataPrevista.compareTo(b.dataPrevista));
              tarefaProxima = pendentes.first;
              
              final dataAtual = DateTime.now();
              final hoje = DateTime(dataAtual.year, dataAtual.month, dataAtual.day);
              final dataTarefa = DateTime(tarefaProxima.dataPrevista.year, tarefaProxima.dataPrevista.month, tarefaProxima.dataPrevista.day);
              isAtrasada = dataTarefa.isBefore(hoje);
            }
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isAtrasada ? Icons.warning_amber_rounded : Icons.task_alt, 
                    size: 100, 
                    color: isAtrasada ? Colors.red.shade400 : Colors.deepPurple.shade300
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Bem-vindo(a)!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  if (tarefaProxima != null) ...[
                    Text(
                      isAtrasada ? '⚠️ Atenção! Sua tarefa mais urgente está ATRASADA:' : 'Sua tarefa mais próxima de vencer é:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16, 
                        color: isAtrasada ? Colors.red : Colors.grey,
                        fontWeight: isAtrasada ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      elevation: 4,
                      color: isAtrasada ? Colors.red.shade50 : Colors.deepPurple.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              tarefaProxima.titulo,
                              style: TextStyle(
                                fontSize: 20, 
                                fontWeight: FontWeight.bold,
                                color: isAtrasada ? Colors.red.shade900 : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Data: ${tarefaProxima.dataPrevista.day}/${tarefaProxima.dataPrevista.month}/${tarefaProxima.dataPrevista.year}',
                              style: TextStyle(
                                color: isAtrasada ? Colors.red.shade700 : Colors.deepPurple.shade700,
                                fontWeight: isAtrasada ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    const Text(
                      'Você não tem tarefas pendentes.\nQue tal criar uma?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                  const SizedBox(height: 50),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/home');
                    },
                    child: const Text('Ir para Minhas Tarefas', style: TextStyle(fontSize: 16)),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}