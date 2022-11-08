import '../models/receitas.dart';

class ReceitaRepository {
  static List<Receita> tabela = [
    Receita(
        nome: 'Salada',
        tempo: '42',
        curtidas: '0',
        imagem: 'images/salada.jpg',
        preparo:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
    Receita(
        nome: 'Panquecas',
        tempo: '10',
        curtidas: '2',
        imagem: 'images/panquecas.jpg',
        preparo: 'Primeiro pré aqueca o forno\n Depois coloque tudo lá'),
    Receita(
        nome: 'Super Cookies',
        tempo: '24',
        curtidas: '9',
        imagem: 'images/cookies.jpg',
        preparo: 'Primeiro pré aqueca o forno\n Depois coloque tudo lá'),
    Receita(
        nome: 'CheeseCake de Amora',
        tempo: '125',
        curtidas: '9',
        imagem: 'images/cheesecake.jpg',
        preparo:
            '1º Amasse a bolacha triturada e a manteiga com as pontas dos dedos, até obter uma farofa consistente.\n 2º Coloque em uma assadeira de aro removível.\n 3º Forre o fundo e laterais com a farofa.\n 4º Leve ao forno pré - aquecido para dourar levemente, por aproximadamente 5 minutos.\n 5º Retire e deixe esfriar.\n 6º Bata no liquidificador todos os ingredientes do recheio até ficar bem homogêneo.\n 7º Despeje sobre a massa pré - assada e fria.\n 8º Leve ao forno até que o creme esteja firme e levemente dourado.\n 9º Após esfriar, leve à geladeira sem desenformar.'),
    Receita(
        nome: 'Fricassê de Frango',
        tempo: '30',
        curtidas: '35',
        imagem: 'images/frango.png',
        preparo:
            '1º Bata no liquidificador o milho, o requeijão, o creme de leite e a água.\n 2º Refogue o creme do liquidificador com o frango desfiado, as azeitonas e o sal até ficar com uma textura espessa.\n 3º Coloque o refogado numa assadeira, cubra com mussarela e espalhe a batata palha por cima.\n 4º Leve ao forno até borbulhar.\n 5º Sirva com arroz branco'),
  ];
}
