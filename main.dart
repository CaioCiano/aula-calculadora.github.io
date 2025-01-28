import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora'),
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
  String display = '0';
  String _operation = '';
  double? _firstOperand;
  double? _secondOperand;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        // Limpa tudo
        display = '0';
        _operation = '';
        _firstOperand = null;
        _secondOperand = null;
      } else if (value == '=') {
        // Realiza o cálculo
        if (_operation.isNotEmpty && _firstOperand != null) {
          _secondOperand = double.tryParse(display);
          if (_secondOperand != null) {
            switch (_operation) {
              case '+':
                display = (_firstOperand! + _secondOperand!).toString();
                break;
              case '-':
                display = (_firstOperand! - _secondOperand!).toString();
                break;
              case '×':
                display = (_firstOperand! * _secondOperand!).toString();
                break;
              case '÷':
                if (_secondOperand != 0) {
                  display = (_firstOperand! / _secondOperand!).toString();
                } else {
                  display = 'Erro';
                }
                break;
            }
          }
        }
        _operation = '';
        _firstOperand = null;
        _secondOperand = null;
      } else if ('+-×÷'.contains(value)) {
        // Define a operação
        _firstOperand = double.tryParse(display);
        _operation = value;
        display = '0';
      } else {
        // Atualiza o número mostrado
        if (display == '0') {
          display = value;
        } else {
          display += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 450,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(4, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Text(
                  display,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  padding: const EdgeInsets.all(8),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: [
                    '7', '8', '9', '÷',
                    '4', '5', '6', '×',
                    '1', '2', '3', '-',
                    '0', '.', '=', '+',
                    'C'
                  ].map((e) {
                    return ElevatedButton(
                      onPressed: () => _onButtonPressed(e),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        e,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
