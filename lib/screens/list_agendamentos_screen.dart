import 'package:flutter/material.dart';

class AgendamentosScreen extends StatelessWidget {
  final List<Map<String, dynamic>> agendamentos = [
    {
      'pet': 'Rex',
      'dataHora': '20/05/2024, 13h30',
      'servicos': 'Banho',
      'funcionario': 'Ana',
      'valor': 50.0,
    },
    {
      'pet': 'Luna',
      'dataHora': '22/05/2024, 10h00',
      'servicos': 'Consulta Veterinária',
      'funcionario': 'Dr. Silva',
      'valor': 100.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamentos'),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.deepPurple),
        titleTextStyle: TextStyle(color: Colors.deepPurple, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6141AC), Color(0xFFB487FD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: agendamentos.length,
          itemBuilder: (context, index) {
            final agendamento = agendamentos[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                contentPadding: EdgeInsets.all(20),
                title: Text(
                  agendamento['pet'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Data e Hora: ${agendamento['dataHora']}'),
                    Text('Serviço: ${agendamento['servicos']}'),
                    Text('Funcionário: ${agendamento['funcionario']}'),
                    Text('Valor: R\$${agendamento['valor'].toStringAsFixed(2)}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
