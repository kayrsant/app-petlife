// Importação do pacote material.dart para acessar widgets e funcionalidades do Flutter
import 'package:flutter/material.dart';

// Definição de cores principais para o tema
const Color primaryColor = Color(0xFF6141AC); // Cor primária
const Color secondaryColor = Color(0xFFB487FD); // Cor secundária

// Classe para a tela de lista de pets
class ListPetsScreen extends StatelessWidget {
  // Construtor da classe, aceita uma chave opcional
  const ListPetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retorna um Scaffold que serve como a estrutura básica da interface do usuário
    return Scaffold(
      appBar: AppBar( // AppBar com título e configurações
        title: const Text('Lista de Pets'), // Título da barra de aplicativos
        backgroundColor: Colors.white, // Cor de fundo da barra de aplicativos
        elevation: 0, // Sem sombra
        centerTitle: true, // Centraliza o título
      ),
      body: Container( // Container principal que ocupa toda a tela
        decoration: const BoxDecoration( // Decoração do container com gradiente
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor], // Cores do gradiente
            begin: Alignment.topCenter, // Ponto de início do gradiente
            end: Alignment.bottomCenter, // Ponto final do gradiente
          ),
        ),
        child: ListView( // ListView para exibir a lista de pets
          children: const [ // Lista de widgets filhos
            // Exemplo de PetCard, pode haver mais conforme necessário
            PetCard(
              nome: 'Rex',
              idade: 3,
              raca: 'Labrador',
              tipo: 'Cachorro',
              peso: '25kg',
              genero: 'Macho',
              alergias: 'Comida',
              emTratamento: true,
            ),
            PetCard(
              nome: 'Mia',
              idade: 2,
              raca: 'Siamês',
              tipo: 'Gato',
              peso: '5kg',
              genero: 'Fêmea',
              alergias: 'Nenhuma',
              emTratamento: false,
            ),
            // Adicione mais pets aqui se necessário.
          ],
        ),
      ),
    );
  }
}

// Classe para o cartão individual de um pet
class PetCard extends StatelessWidget {
  // Propriedades do pet
  final String nome;
  final int idade;
  final String raca;
  final String tipo;
  final String peso;
  final String genero;
  final String alergias;
  final bool emTratamento;

  // Construtor da classe, requer todas as propriedades exceto a chave
  const PetCard({
    required this.nome,
    required this.idade,
    required this.raca,
    required this.tipo,
    required this.peso,
    required this.genero,
    required this.alergias,
    required this.emTratamento,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retorna um Card com informações do pet
    return Card(
      margin: const EdgeInsets.all(10.0), // Margem ao redor do cartão
      color: Colors.white, // Cor de fundo do cartão
      shape: RoundedRectangleBorder( // Forma do cartão
        borderRadius: BorderRadius.circular(15), // Bordas arredondadas
      ),
      child: Padding( // Espaçamento ao redor do conteúdo do cartão
        padding: const EdgeInsets.all(15.0), // Espaçamento uniforme de 15 pixels
        child: Column( // Organização vertical dos widgets filhos
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha os widgets à esquerda
          children: [
            // Textos que exibem as informações do pet
            Text('Nome: $nome', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Idade: $idade anos', style: const TextStyle(fontSize: 16)),
            Text('Raça: $raca', style: const TextStyle(fontSize: 16)),
            Text('Tipo: $tipo', style: const TextStyle(fontSize: 16)),
            Text('Peso: $peso', style: const TextStyle(fontSize: 16)),
            Text('Gênero: $genero', style: const TextStyle(fontSize: 16)),
            Text('Alergias: $alergias', style: const TextStyle(fontSize: 16)),
            Text('Em tratamento: ${emTratamento? 'Sim' : 'Não'}', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
