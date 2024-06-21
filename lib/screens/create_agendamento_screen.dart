import 'package:flutter/material.dart';

class CreateAgendamentoScreen extends StatefulWidget {
  const CreateAgendamentoScreen({Key? key}) : super(key: key);

  @override
  State<CreateAgendamentoScreen> createState() => _CreateAgendamentoScreenState();
}

class _CreateAgendamentoScreenState extends State<CreateAgendamentoScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController dataController = TextEditingController();

  final List<String> pets = ['Rex', 'Bobby', 'Luna'];
  final Map<String, List<String>> servicos = {
    'Banho': ['Ana', 'João'],
    'Tosa': ['Carlos', 'Marina'],
    'Consulta Veterinária': ['Dr. Silva', 'Dra. Clara'],
  };
  final Map<String, double> servicoPreco = {
    'Banho': 50.0,
    'Tosa': 75.0,
    'Consulta Veterinária': 100.0,
  };

  final List<String> horariosDisponiveis = [
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00'
  ];

  String? petSelecionado;
  DateTime? dataSelecionada;
  String? horarioSelecionado;
  List<Map<String, String>> servicosSelecionados = [];

  @override
  void dispose() {
    dataController.dispose();
    super.dispose();
  }

  double calcularValorTotal() {
    double total = 0.0;
    for (var servico in servicosSelecionados) {
      total += servicoPreco[servico['servico']]?? 0.0;
    }
    return total;
  }

  void _showConfirmationDialog() {
    final dataHoraFormatada = "${dataSelecionada != null ? "${dataSelecionada!.day.toString().padLeft(2, '0')}/${dataSelecionada!.month.toString().padLeft(2, '0')}/${dataSelecionada!.year}" : 'Não selecionada'}${horarioSelecionado != null ? ", $horarioSelecionado" : ''}";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Agendamento'),
          content: Text(
              'Deseja confirmar o agendamento?\n'
                  'Data e Hora: $dataHoraFormatada\n'
                  'Valor: R\$${calcularValorTotal().toStringAsFixed(2)}'
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirmar'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != dataSelecionada) {
      setState(() {
        dataSelecionada = pickedDate;
        dataController.text = "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
      });
    }
  }

  void _addServico() {
    setState(() {
      servicosSelecionados.add({'servico': '', 'funcionario': ''});
    });
  }

  void _removeServico(int index) {
    setState(() {
      servicosSelecionados.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Agendamento'),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.deepPurple),
        titleTextStyle: const TextStyle(color: Colors.deepPurple, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6141AC), Color(0xFFB487FD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDropdownField('Selecione o Pet', pets, petSelecionado, (value) {
                      setState(() {
                        petSelecionado = value;
                      });
                    }),
                    _buildDatePickerField('Data', dataController, _selectDate),
                    if (dataSelecionada != null)
                      _buildDropdownField('Hora', horariosDisponiveis, horarioSelecionado, (value) {
                        setState(() {
                          horarioSelecionado = value;
                        });
                      }),
                    ..._buildServicosFields(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: _addServico,
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text('Adicionar Serviço', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Valor Total: R\$${calcularValorTotal().toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    _buildCreateAgendamentoButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildServicosFields() {
    List<Widget> widgets = [];
    for (int i = 0; i < servicosSelecionados.length; i++) {
      widgets.add(Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdownField('Serviço', servicos.keys.toList(), servicosSelecionados[i]['servico'], (value) {
                setState(() {
                  servicosSelecionados[i]['servico'] = value!;
                  servicosSelecionados[i]['funcionario'] = ''; // Resetar o funcionário ao selecionar um novo serviço
                });
              }),
              if (servicosSelecionados[i]['servico'] != null && servicosSelecionados[i]['servico']!.isNotEmpty)
                _buildDropdownField('Funcionário', servicos[servicosSelecionados[i]['servico']!]!, servicosSelecionados[i]['funcionario'], (value) {
                  setState(() {
                    servicosSelecionados[i]['funcionario'] = value!;
                  });
                }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () => _removeServico(i),
                    icon: const Icon(Icons.remove, color: Color(0xFFb01010)),
                    label: const Text('Remover', style: TextStyle(color: Color(0xFFb01010))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
    }
    return widgets;
  }

  Widget _buildDropdownField(String label, List<String> items, String? selectedValue, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.deepPurple),
          hintText: label,
          hintStyle: const TextStyle(color: Colors.white),
          floatingLabelStyle: const TextStyle(color: Colors.white),
        ),
        value: items.contains(selectedValue) ? selectedValue : null,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        dropdownColor: Colors.white,
        style: const TextStyle(color: Colors.deepPurple),
        validator: (value) => value == null || value.isEmpty ? 'Por favor, selecione $label' : null,
      ),
    );
  }

  Widget _buildDatePickerField(String label, TextEditingController controller, Function(BuildContext) selectDate) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
    controller: controller,
    readOnly: true,
    onTap: () => selectDate(context),
    decoration: InputDecoration(
    filled: true,
    fillColor: Colors.white.withOpacity(0.8),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide.none,
    ),
    labelText: label,
    labelStyle: const TextStyle(color: Colors.deepPurple),
      hintText: label,
      hintStyle: const TextStyle(color: Colors.white),
      floatingLabelStyle: const TextStyle(color: Colors.white),
      suffixIcon: const Icon(Icons.calendar_today, color: Colors.deepPurple),
    ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, selecione $label';
        }
        return null;
      },
    ),
    );
  }

  Widget _buildCreateAgendamentoButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _showConfirmationDialog();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Text(
          'Criar Agendamento',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
