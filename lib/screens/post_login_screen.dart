// Importações necessárias para o funcionamento do aplicativo
import 'package:PetLife/screens/create_agendamento_screen.dart';
import 'package:PetLife/screens/login_screen.dart';
import 'package:flutter/material.dart'; // Pacote Flutter para acessar widgets e funcionalidades
import 'package:PetLife/screens/list_pet_screen.dart';
import 'package:PetLife/screens/create_pet_screen.dart';
import 'package:PetLife/screens/list_agendamentos_screen.dart';

// Definição da classe PostLoginScreen, um widget sem estado
class PostLoginScreen extends StatelessWidget {
  // Construtor da classe, aceita uma chave opcional
  const PostLoginScreen({super.key});

  @override
  Widget build(BuildContext context) { // Método obrigatório para todos os StatelessWidgets
    return Scaffold( // Widget que fornece uma estrutura básica para a interface do usuário
      appBar: AppBar( // Barra de aplicativos
        title: const Text('Tela Inicial'), // Título da barra de aplicativos
        backgroundColor: Colors.white, // Cor de fundo da barra de aplicativos
        elevation: 0, // Elevation (sombra) da barra de aplicativos
        centerTitle: true, // Centraliza o título
        actions: [ // Ações disponíveis na barra de aplicativos
          IconButton( // Botão de ação (logout)
            icon: Icon(Icons.logout, color: Colors.deepPurple), // Ícone do botão
            onPressed: () { // Ação a ser executada quando o botão é pressionado
              Navigator.pushAndRemoveUntil( // Navega para a tela de login e remove todas as rotas anteriores
                context,
                MaterialPageRoute(builder: (context) => Login()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: Container( // Container principal que ocupa toda a tela
        height: MediaQuery.of(context).size.height - kToolbarHeight - kBottomNavigationBarHeight, // Altura ajustada para exibir todo o conteúdo
        decoration: BoxDecoration( // Decoração do container
          gradient: LinearGradient( // Gradiente linear de cores
            colors: [Color(0xFF6141AC), Color(0xFFB487FD)], // Cores do gradiente
            begin: Alignment.topCenter, // Ponto de início do gradiente
            end: Alignment.bottomCenter, // Ponto final do gradiente
          ),
        ),
        child: Padding( // Espaçamento ao redor do conteúdo central
          padding: const EdgeInsets.all(20.0), // Espaçamento uniforme de 20 pixels
          child: SingleChildScrollView( // Permite rolagem se o conteúdo exceder a altura do dispositivo
            child: Column( // Organização vertical dos widgets filhos
              crossAxisAlignment: CrossAxisAlignment.stretch, // Alinha os widgets à esquerda
              children: [ // Lista de widgets filhos
                // Seção de agendamentos
                _buildSectionCard(
                  context,
                  'Agendamentos',
                  Icons.schedule,
                  Colors.blue,
                  [
                    _buildCardButton(
                      context,
                      'Agendar Serviço',
                      Icons.add,
                      Colors.blue,
                          () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateAgendamentoScreen()),
                      ),
                    ),
                    _buildCardButton(
                      context,
                      'Ver Agendamentos',
                      Icons.view_list,
                      Colors.orange,
                          () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AgendamentosScreen()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30), // Espaçamento entre seções
                // Seção de pets
                _buildSectionCard(
                  context,
                  'Pets',
                  Icons.pets,
                  Colors.green,
                  [
                    _buildCardButton(
                      context,
                      'Adicionar Pet',
                      Icons.add,
                      Colors.green,
                          () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PetScreen()),
                      ),
                    ),
                    _buildCardButton(
                      context,
                      'Listar Pets',
                      Icons.list,
                      Colors.purple,
                          () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListPetsScreen()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar( // Barra de navegação inferior
        items: const [ // Itens da barra de navegação
          BottomNavigationBarItem(
            icon: Icon(Icons.pets, color: Colors.deepPurple), // Ícone do item
            label: 'Pets', // Rótulo do item
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule, color: Colors.deepPurple), // Ícone do item
            label: 'Agendamentos', // Rótulo do item
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.deepPurple), // Ícone do item
            label: 'Configurações', // Rótulo do item
          ),
        ],
        backgroundColor: Colors.white, // Cor de fundo da barra de navegação
        selectedItemColor: Colors.deepPurple, // Cor do item selecionado
        onTap: (index) { // Ação a ser executada quando um item é tocado
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListPetsScreen()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AgendamentosScreen()),
            );
          }
        },
      ),
    );
  }

  // Método auxiliar para construir um cartão de seção
  Widget _buildSectionCard(
      BuildContext context,
      String title,
      IconData icon,
      Color cardColor,
      List<Widget> buttons,
      ) {
    return Card( // Cartão visual
      shape: RoundedRectangleBorder( // Forma do cartão
        borderRadius: BorderRadius.circular(20), // Bordas arredondadas
      ),
      color: cardColor, // Cor de fundo do cartão
      elevation: 5, // Elevação (sombra) do cartão
      child: Padding( // Espaçamento ao redor do conteúdo do cartão
        padding: const EdgeInsets.all(20.0), // Espaçamento uniforme de 20 pixels
        child: Column( // Organização vertical dos widgets filhos
          crossAxisAlignment: CrossAxisAlignment.stretch, // Alinha os widgets à esquerda
          children: [ // Lista de widgets filhos
            Row( // Linha horizontal para o título e ícone
              children: [
                Icon(icon, color: Colors.white, size: 30), // Ícone do cartão
                const SizedBox(width: 10), // Espaçamento entre o ícone e o texto
                Text( // Título do cartão
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Espaçamento entre o título e os botões
            ...buttons, // Expansão do spread operator para incluir todos os botões
          ],
        ),
      ),
    );
  }

  // Método auxiliar para construir um botão de cartão
  Widget _buildCardButton(
      BuildContext context,
      String label,
      IconData icon,
      Color iconColor,
      VoidCallback onPressed,
      ) {
    return Padding( // Espaçamento ao redor do botão
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Espaçamento vertical uniforme de 8 pixels
      child: ElevatedButton.icon( // Botão elevado com ícone
        style: ElevatedButton.styleFrom( // Estilo do botão
          backgroundColor: Colors.white, // Cor de fundo do botão
          shape: RoundedRectangleBorder( // Forma do botão
            borderRadius: BorderRadius.circular(20), // Bordas arredondadas
          ),
          elevation: 5, // Elevação (sombra) do botão
        ),
        onPressed: onPressed, // Ação a ser executada quando o botão é pressionado
        icon: Icon(icon, color: iconColor), // Ícone do botão
        label: Text( // Rótulo do botão
          label,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: iconColor),
        ),
      ),
    );
  }
}
