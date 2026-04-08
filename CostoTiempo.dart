import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de viaje',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TravelCalculator(),
    );
  }
}

class TravelCalculator extends StatefulWidget {
  const TravelCalculator({super.key});

  @override
  State<TravelCalculator> createState() => _TravelCalculatorState();
}

class _TravelCalculatorState extends State<TravelCalculator> {
  final TextEditingController distanciaController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController consumoController = TextEditingController();
  final TextEditingController velocidadController = TextEditingController();

  double? costo;
  double? tiempo;

  void calcular() {
    final double? distancia = double.tryParse(distanciaController.text);
    final double? precio = double.tryParse(precioController.text);
    final double? consumo = double.tryParse(consumoController.text);
    final double? velocidad = double.tryParse(velocidadController.text);

    if (distancia == null ||
        precio == null ||
        consumo == null ||
        velocidad == null ||
        distancia <= 0 ||
        precio <= 0 ||
        consumo <= 0 ||
        velocidad <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rellenar todos los campos corretcamente')),
      );
      return;
    }

    setState(() {
      costo = (distancia / consumo) * precio;
      tiempo = distancia / velocidad;
    });
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Viaje'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildTextField('Distancia (km)', distanciaController),
            const SizedBox(height: 10),
            buildTextField('Precio del combustible (R\$/L)', precioController),
            const SizedBox(height: 10),
            buildTextField('Consumo del vehiculo (km/L)', consumoController),
            const SizedBox(height: 10),
            buildTextField('Velocidad media (km/h)', velocidadController),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: calcular,
              child: const Text('Calcular'),
            ),

            const SizedBox(height: 20),

            if (costo != null)
              Text(
                'Costo estimado: R\$ ${costo!.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
              ),

            if (tiempo != null)
              Text(
                'Tiempo estimado: ${tiempo!.toStringAsFixed(2)} horas',
                style: const TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}