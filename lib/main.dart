import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/tarefas_provider.dart';
import 'telas/tela_inicial.dart';
import 'telas/tela_boas_vindas.dart';
import 'telas/tela_detalhes.dart';

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
          primarySwatch: Colors.deepPurple,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const TelaBoasVindas(),
          '/home': (context) => const TelaInicial(),
          '/detalhes': (context) => const TelaDetalhes(),
        },
      ),
    );
  }
}