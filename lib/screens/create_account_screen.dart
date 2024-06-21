import 'package:PetLife/screens/login_screen.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTextField('Nome', nameController),
                    _buildTextField('E-mail', emailController, keyboardType: TextInputType.emailAddress),
                    _buildPasswordField('Senha', passwordController),
                    _buildPasswordField('Confirmar Senha', confirmPasswordController),
                    const SizedBox(height: 20),
                    _buildCreateAccountButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: label == 'E-mail' ? Icon(Icons.email, color: Colors.white70) : null,
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          hintText: label,
          hintStyle: TextStyle(color: Colors.white38),
        ),
        style: TextStyle(color: Colors.white),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        obscureText: true,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock, color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          hintText: label,
          hintStyle: TextStyle(color: Colors.white38),
        ),
        style: TextStyle(color: Colors.white),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCreateAccountButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            bool success = true;

            if (success) {
              _showSnackbar("Sucesso ao criar a conta, faça login");
              Future.delayed(Duration(seconds: 2), () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                (Route<dynamic> route) => false,
                );});
            } else {
              _showSnackbar("Erro ao criar a conta, tente novamente");
            }
          }
        },
        child: const Text(
          'Criar Conta',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF6141AC)),
        ),
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2), // Ajuste a duração conforme necessário
      ),
    );
  }
}

