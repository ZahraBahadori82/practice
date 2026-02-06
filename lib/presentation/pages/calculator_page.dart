import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection_container.dart';
import '../bloc/calculator_bloc.dart';
import '../bloc/calculator_event.dart';
import '../bloc/calculator_state.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  String _selectedOperator = '+';

  @override
  void dispose() {
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }

  void _calculate(BuildContext context) {
    final num1Text = _num1Controller.text.trim();
    final num2Text = _num2Controller.text.trim();

    if (num1Text.isEmpty || num2Text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('please enter the number')),
      );
      return;
    }

    try {
      final num1 = double.parse(num1Text);
      final num2 = double.parse(num2Text);

      context.read<CalculatorBloc>().add(
        CalculateEvent(
          num1: num1,
          num2: num2,
          operator: _selectedOperator,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('please enter the valid number')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('simple calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<CalculatorBloc>().add(ResetCalculatorEvent());
              _num1Controller.clear();
              _num2Controller.clear();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _num1Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'first number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.looks_one),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _num2Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'second number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.looks_two),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedOperator,
              decoration: const InputDecoration(
                labelText: 'operator',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calculate),
              ),
              items: const [
                DropdownMenuItem(value: '+', child: Text('sum (+)')),
                DropdownMenuItem(value: '-', child: Text('sub (-)')),
                DropdownMenuItem(value: '*', child: Text('multi (×)')),
                DropdownMenuItem(value: '/', child: Text('div (÷)')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedOperator = value!;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _calculate(context),
              icon: const Icon(Icons.calculate),
              label: const Text('calculating', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            const SizedBox(height: 32),
            BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
                if (state is CalculatorInitial) {
                  return const Text(
                    'preparing ...',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  );
                } else if (state is CalculatorLoading) {
                  return const CircularProgressIndicator();
                } else if (state is CalculatorSuccess) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'result:',
                          style: TextStyle(fontSize: 18, color: Colors.green),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${state.result}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is CalculatorError) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Text(
                      'error: ${state.message}',
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}