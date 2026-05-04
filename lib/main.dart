import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/tarefas_provider.dart';
import 'telas/tela_inicial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => TarefasProvider(),
      child: MaterialApp(
        title: 'App de Tarefas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TelaInicial(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}