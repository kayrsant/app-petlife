import 'package:flutter/material.dart';
import 'package:PetLife/screens/post_login_screen.dart';
import 'create_account_screen.dart';

// Definição de um widget com estado chamado Login
class Login extends StatefulWidget {
  const Login({super.key}); // Construtor da classe Login, com uma chave opcional

  @override
  State<Login> createState() => _LoginState(); // Cria o estado para o widget Login
}

// Estado associado ao widget Login
class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Define a cor de fundo da tela como branca
      appBar: AppBar(
        backgroundColor: Color(0xFF6141AC), // Define a cor de fundo da AppBar
        elevation: 0, // Remove a sombra da AppBar
        centerTitle: true, // Centraliza o título da AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6141AC), Color(0xFFB487FD)], // Define um gradiente de cores para o fundo
            begin: Alignment.topCenter, // Início do gradiente no topo
            end: Alignment.bottomCenter, // Fim do gradiente na parte inferior
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0), // Adiciona preenchimento horizontal
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centraliza os filhos verticalmente
              children: <Widget>[
                const Text(
                  'PetLife', // Título do aplicativo
                  style: TextStyle(
                    fontSize: 40, // Tamanho da fonte do título
                    fontWeight: FontWeight.bold, // Negrito
                    color: Colors.white, // Cor do texto branca
                  ),
                ),
                const SizedBox(height: 10), // Espaçamento vertical
                const Text(
                  'Seu Melhor PetShop!', // Subtítulo
                  style: TextStyle(
                    fontSize: 20, // Tamanho da fonte do subtítulo
                    color: Colors.white70, // Cor do texto com opacidade
                  ),
                ),
                const SizedBox(height: 40), // Espaçamento vertical
                _buildEmailField(), // Chama o método que cria o campo de email
                const SizedBox(height: 15), // Espaçamento vertical
                _buildPasswordField(), // Chama o método que cria o campo de senha
                const SizedBox(height: 10), // Espaçamento vertical
                _buildForgotPasswordButton(), // Chama o método que cria o botão "Esqueceu a senha?"
                const SizedBox(height: 20), // Espaçamento vertical
                _buildLoginButton(context), // Chama o método que cria o botão de login
                const SizedBox(height: 20), // Espaçamento vertical
                _buildCreateAccountButton(context), // Chama o método que cria o botão "Crie sua conta"
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para criar o campo de email
  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email, color: Colors.white70), // Ícone de email no campo de entrada
        filled: true, // Preenche o fundo do campo
        fillColor: Colors.white.withOpacity(0.1), // Cor de fundo com opacidade
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Bordas arredondadas
          borderSide: BorderSide.none, // Sem borda visível
        ),
        labelText: 'Email', // Texto de rótulo
        labelStyle: TextStyle(color: Colors.white70), // Cor do texto de rótulo
        hintText: 'exemplo@mail.com', // Texto de dica
        hintStyle: TextStyle(color: Colors.white38), // Cor do texto de dica
      ),
      style: TextStyle(color: Colors.white), // Cor do texto inserido pelo usuário
    );
  }

  // Método para criar o campo de senha
  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: true, // Oculta o texto inserido
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, color: Colors.white70), // Ícone de cadeado no campo de entrada
        filled: true, // Preenche o fundo do campo
        fillColor: Colors.white.withOpacity(0.1), // Cor de fundo com opacidade
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Bordas arredondadas
          borderSide: BorderSide.none, // Sem borda visível
        ),
        labelText: 'Senha', // Texto de rótulo
        labelStyle: TextStyle(color: Colors.white70), // Cor do texto de rótulo
      ),
      style: TextStyle(color: Colors.white), // Cor do texto inserido pelo usuário
    );
  }

  // Método para criar o botão "Esqueceu a senha?"
  Widget _buildForgotPasswordButton() {
    return TextButton(
      onPressed: () {
        // Lógica para o botão "Esqueceu a senha?" (a ser implementada)
      },
      child: const Text(
        'Esqueceu a senha?', // Texto do botão
        style: TextStyle(color: Colors.white70, fontSize: 15), // Estilo do texto do botão
      ),
    );
  }

  // Método para criar o botão de login
  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      height: 50, // Altura do botão
      width: double.infinity, // Largura total do botão
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // Cor de fundo do botão
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Bordas arredondadas
          ),
          elevation: 5, // Sombra do botão
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => PostLoginScreen()),
                (Route<dynamic> route) => false,
            // Navega para a tela PostLoginScreen
          );
        },
        child: const Text(
          'Login', // Texto do botão
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Estilo do texto do botão
        ),
      ),
    );
  }

  // Método para criar o botão "Crie sua conta"
  Widget _buildCreateAccountButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CreateAccountScreen()), // Navega para a tela CreateAccountScreen
        );
      },
      child: const Text(
        'Crie sua conta', // Texto do botão
        style: TextStyle(color: Colors.white), // Estilo do texto do botão
      ),
    );
  }
}
