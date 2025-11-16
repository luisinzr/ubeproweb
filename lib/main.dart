import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // cambio del título original "Flutter Demo"
      title: 'HOLA MUNDO de LUIS',

      theme: ThemeData(
        //  cambió el color por defecto (deepPurple)
        // por un  verde personalizado.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 68, 183, 58),
        ),
      ),

      // cambió en título de  pantalla inicial
      home: const MyHomePage(title: 'Mi pagina de hola mundo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // cambio el texto mostrado en pantalla
            const Text(
              'HOLA MUNDO desde Flutter - Luis Zambrano'
            ),
            
            // cambio en contador ahora se muestara un texto en lugar del valor numérico
            Text(
              'Contador desactivado ($_counter)', 
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),

      // 
     floatingActionButton: FloatingActionButton(
  // cambio en el  botón flotante con color tambien otro icono
  onPressed: _incrementCounter,
  tooltip: 'Incrementar',
  backgroundColor: const Color.fromARGB(255, 68, 183, 58), // mismo verde del tema
  child: const Icon(
    Icons.thumb_up, // icono cambiado 
    size: 30,
  ),
),
    );
  }
  
}

