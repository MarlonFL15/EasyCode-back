drop database easycode;
create database easycode;
use  easycode;

create table usuario(
    id int not null auto_increment,
	nome varchar(45) not null,
    senha varchar(45) null,
    email varchar(45) not null,
    foto longblob null,
    pontuacao bigint default 0,
    google boolean not null,
    primary key(id)
);

create table Questao(
	id int not null auto_increment,
    titulo varchar(64) null,
    enunciado varchar(256) not null,
    nivel varchar(10) null,
    pontos int null,
    assunto varchar(16) not null,
    primary key(id)
);

create table exemploQuestao(
	id int not null auto_increment,
    entrada varchar(50) null,
    saida varchar(50),
    idQuestao int not null,
    primary key(id),
    foreign key(idQuestao) references questao(id)
);

create table pergunta(
	id int not null auto_increment,
    enunciado varchar(256) not null,
    codigo varchar(256) null,
    resposta varchar(100) not null, 
    assunto varchar(16) not null,
    primary key(id)
);

create table alternativa(
	id int not null auto_increment,
    alternativa varchar(50) not null,
    idPergunta int not null,
    primary key(id),
    foreign key (idPergunta) references pergunta(id)
);

create table form(
	id int not null auto_increment,
    assunto varchar(32) not null,
    percentual int null,
    idUsuario int not null,
    datacriacao datetime not null,
    primary key(id),
    foreign key (idUsuario) references Usuario(id)
);

create table Form_Pergunta(
	id int not null auto_increment,
    idPergunta int not null,
    idForm int not null,
    respostaUsuario varchar(100) not null,
    correto bool not null,
    primary key(id),
    foreign key (idPergunta) references pergunta(id),
    foreign key (idForm) references form(id)
);


create table respostaQuestao(
	id int not null auto_increment,
	idQuestao int not null,
    idUsuario int not null,
    codigo varchar(4000) not null,
    correto bool not null,
    dataEnvio datetime not null,
    roleta bool not null,
	primary key (id),
    foreign key (idQuestao) references questao(id),
    foreign key (idUsuario) references usuario(id)
);


create table conquista(
	id int not null auto_increment,
	pontuacao int null,
    titulo varchar(45) not null,
    descricao varchar(100),
	primary key (id)
);

create table conquistaUsuario(
	idUsuario int not null,
    idConquista int not null,
	primary key (idUsuario, idConquista),
    foreign key(idUsuario) references usuario(id),
    foreign key(idConquista) references conquista(id)
);


create table tabela_verdade(
	id bigint not null auto_increment,
    nome varchar(100) not null,
    nivel varchar(100) not null,
    descricao varchar(4000) not null,
    url varchar(100) not null,
    primary key(id)
);
create table tabela_verdade_usuario(
	id bigint not null auto_increment,
    idUsuario int not null,
    idQuestao bigint not null,
    dataresposta datetime not null,
    primary key(id),
    foreign key (idUsuario) references Usuario(id),
    foreign key (idQuestao) references Tabela_Verdade(id)
);

insert into questao values(6, 'Fatorial','Faça um programa que calcule o fatorial de um número','Médio', 30, 'Repetição');
insert into exemploQuestao values(16,'4\n',CONCAT_WS(CHAR(13 using utf8), '24', ''),6);
insert into exemploQuestao values(17,'6\n',CONCAT_WS(CHAR(13 using utf8), '720', ''),6);
insert into exemploQuestao values(18,'5\n',CONCAT_WS(CHAR(13 using utf8), '120', ''),6);


insert into questao values(5, 'Contando em strings','Faça um programa que retorne quantas vezes a letra "O" aparece em uma string lida do teclado','Médio', 30, 'Textos');
insert into exemploQuestao values(13,'EasyCode\n',CONCAT_WS(CHAR(13 using utf8), '1', ''),5);
insert into exemploQuestao values(14,'Coronavirus',CONCAT_WS(CHAR(13 using utf8), '2', ''),5);
insert into exemploQuestao values(15,'Essa é mais uma frase para testar o algoritmo',CONCAT_WS(CHAR(13 using utf8), '3', ''),5);

insert into questao values(4, 'MDC', 'Faça um programa que calcule o MDC de dois números','Médio', 30,'Matemática');
insert into exemploQuestao values(10,'5\n15',CONCAT_WS(CHAR(13 using utf8), '5', ''),4);
insert into exemploQuestao values(11,'3\n12',CONCAT_WS(CHAR(13 using utf8), '3', ''),4);
insert into exemploQuestao values(12,'320\n150',CONCAT_WS(CHAR(13 using utf8), '10', ''),4);

insert into questao values(3, 'Par ou ímpar', 'Faça um programa que imprima "PAR" se o número for par, "IMPAR" se não for','Fácil', 10, 'Seleção');
insert into exemploQuestao values(6,'1\n',CONCAT_WS(CHAR(13 using utf8), 'IMPAR', ''),3);
insert into exemploQuestao values(7,'3\n',CONCAT_WS(CHAR(13 using utf8), 'IMPAR', ''),3);
insert into exemploQuestao values(8,'4\n',CONCAT_WS(CHAR(13 using utf8), 'PAR', ''),3);
insert into exemploQuestao values(9,'10\n',CONCAT_WS(CHAR(13 using utf8), 'PAR', ''),3);

insert into questao values(2, 'Soma de inteiros', 'Faça um programa que calcule a soma de 2 números','Fácil', 10, 'Sequência');
insert into exemploQuestao values(2,'1\n1',CONCAT_WS(CHAR(13 using utf8), '2.0', ''),2);
insert into exemploQuestao values(4,'2\n2',CONCAT_WS(CHAR(13 using utf8), '4.0', ''),2);
insert into exemploQuestao values(5,'3\n5',CONCAT_WS(CHAR(13 using utf8), '8.0', ''),2);

insert into questao values(1, 'Olá mundo', 'Faça um programa que imprima "Ola mundo"','Fácil', 10,'Sequência');
insert into exemploQuestao values(1,null,CONCAT_WS(CHAR(13 using utf8), 'Ola mundo', ''),1);

insert into pergunta(enunciado, codigo, resposta, assunto) values('O que o código abaixo retorna?', 'printf("Ola mundo")', 'Ola mundo', 'Sequência');

insert into alternativa(alternativa, idPergunta) values('Ola mundo', 1);
insert into alternativa(alternativa, idPergunta) values('"Ola mundo"', 1);
insert into alternativa(alternativa, idPergunta) values('printf("Ola mundo")', 1);
insert into alternativa(alternativa, idPergunta) values('Nenhuma das alternativas', 1);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Qual são as funções para escrita e leitura, respectivamente?', null, 'Printf e scanf', 'Sequência');
insert into alternativa(alternativa, idPergunta) values('Scanf e printf', 2);
insert into alternativa(alternativa, idPergunta) values('Printf e scanf', 2);
insert into alternativa(alternativa, idPergunta) values('Print e scan', 2);
insert into alternativa(alternativa, idPergunta) values('cout e cin', 2);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Qual é o nome da biblioteca que importa as funções de entrada e saída?', null, 'stdio', 'Sequência');
insert into alternativa(alternativa, idPergunta) values('stdio', 3);
insert into alternativa(alternativa, idPergunta) values('stdlib', 3);
insert into alternativa(alternativa, idPergunta) values('scanner', 3);
insert into alternativa(alternativa, idPergunta) values('conio', 3);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Selecione a alternativa que está com a sintaxe correta', null, 'scanf("%d", &numero)', 'Sequência');
insert into alternativa(alternativa, idPergunta) values('scanf("%d", &numero)', 4);
insert into alternativa(alternativa, idPergunta) values('scanf("%d", numero)', 4);
insert into alternativa(alternativa, idPergunta) values('scanf(%d, &numero)', 4);
insert into alternativa(alternativa, idPergunta) values('scanf(numero)', 4);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Quais são os principais tipos de dados existentes em C?', null, 'int, float e char', 'Sequência');
insert into alternativa(alternativa, idPergunta) values('int, float e char', 5);
insert into alternativa(alternativa, idPergunta) values('int, float, char e texto', 5);
insert into alternativa(alternativa, idPergunta) values('int e char', 5);
insert into alternativa(alternativa, idPergunta) values('numero, texto e bool', 5);

insert into pergunta(enunciado, codigo, resposta, assunto) values('O que o operador && representa?', null, 'E', 'Seleção');
insert into alternativa(alternativa, idPergunta) values('E', 6);
insert into alternativa(alternativa, idPergunta) values('OU', 6);
insert into alternativa(alternativa, idPergunta) values('NÃO', 6);
insert into alternativa(alternativa, idPergunta) values('Maior que', 6);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Sabendo x é igual a 5, que o código abaixo retorna?', 'x >=5 && x<=10', 'Verdadeiro', 'Seleção');
insert into alternativa(alternativa, idPergunta) values('Verdadeiro', 7);
insert into alternativa(alternativa, idPergunta) values('Falso', 7);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Como representamos o operador "Maior ou igual" em C?',null , '>=', 'Seleção');
insert into alternativa(alternativa, idPergunta) values('>=', 8);
insert into alternativa(alternativa, idPergunta) values('<=', 8);
insert into alternativa(alternativa, idPergunta) values('>', 8);
insert into alternativa(alternativa, idPergunta) values('<', 8);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Escolha o único operador que NÃO faz parte da linguagem C',null , '^^', 'Seleção');
insert into alternativa(alternativa, idPergunta) values('&&', 9);
insert into alternativa(alternativa, idPergunta) values('||', 9);
insert into alternativa(alternativa, idPergunta) values('!', 9);
insert into alternativa(alternativa, idPergunta) values('^^', 9);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Sabendo que y = 6 e x = 5, quando o código abaixo retorna?', 'x + y >= 11' , 'Verdadeiro', 'Seleção');
insert into alternativa(alternativa, idPergunta) values('Verdadeiro', 10);
insert into alternativa(alternativa, idPergunta) values('False', 10);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Qual das palavras abaixo NÃO é usada para definir uma estrutura de repetição?',null , 'switch', 'Repetição');
insert into alternativa(alternativa, idPergunta) values('for', 11);
insert into alternativa(alternativa, idPergunta) values('switch', 11);
insert into alternativa(alternativa, idPergunta) values('do', 11);
insert into alternativa(alternativa, idPergunta) values('while', 11);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Marque qual das alternativas está com a sintaxe correta',null , 'for(i = 0;  i <= 10; i++)', 'Repetição');
insert into alternativa(alternativa, idPergunta) values('for(i = 0;  i <= 10; i++)', 12);
insert into alternativa(alternativa, idPergunta) values('for(i = 0,  i <= 10, i++)', 12);
insert into alternativa(alternativa, idPergunta) values('for(i = 0; i++; i <= 10;)', 12);
insert into alternativa(alternativa, idPergunta) values('for(i = 0, i++, i <= 10;)', 12);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Sabendo que i = 0, qual será o valor da variável i após o laço?','while(i<=10){\ni++}' , '11', 'Repetição');
insert into alternativa(alternativa, idPergunta) values('11', 13);
insert into alternativa(alternativa, idPergunta) values('10', 13);
insert into alternativa(alternativa, idPergunta) values('9', 13);
insert into alternativa(alternativa, idPergunta) values('10', 13);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Defina o nome das 3 partes do for', null, 'inicialização; condição; incremento', 'Repetição');
insert into alternativa(alternativa, idPergunta) values('condição; inicialização; incremento', 14);
insert into alternativa(alternativa, idPergunta) values('inicialização; condição; incremento', 14);
insert into alternativa(alternativa, idPergunta) values('inicialização; incremento; condição', 14);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Qual é o nome da palavra usada para interromper um laço?', null, 'break', 'Repetição');
insert into alternativa(alternativa, idPergunta) values('return 0', 15);
insert into alternativa(alternativa, idPergunta) values('break', 15);
insert into alternativa(alternativa, idPergunta) values('continue', 15);
insert into alternativa(alternativa, idPergunta) values('goto', 15);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Qual é o nome da biblioteca que importa as funções de matemática?', null, 'math', 'Matemática');
insert into alternativa(alternativa, idPergunta) values('math', 16);
insert into alternativa(alternativa, idPergunta) values('matemática', 16);
insert into alternativa(alternativa, idPergunta) values('maht', 16);
insert into alternativa(alternativa, idPergunta) values('calc', 16);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Qual é o nome da função que calcula a raíz quadrada?', null, 'sqrt', 'Matemática');
insert into alternativa(alternativa, idPergunta) values('sqrt', 17);
insert into alternativa(alternativa, idPergunta) values('pow', 17);
insert into alternativa(alternativa, idPergunta) values('cos', 17);
insert into alternativa(alternativa, idPergunta) values('max', 17);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Sabendo que x = 3 e y = 2, quando retorna o código abaixo?', 'pow(x,y)', '9', 'Matemática');
insert into alternativa(alternativa, idPergunta) values('9', 18);
insert into alternativa(alternativa, idPergunta) values('6', 18);
insert into alternativa(alternativa, idPergunta) values('8', 18);
insert into alternativa(alternativa, idPergunta) values('27', 18);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Qual é a função do operador "%"?', null, 'resto da divisão', 'Matemática');
insert into alternativa(alternativa, idPergunta) values('resto da divisão', 19);
insert into alternativa(alternativa, idPergunta) values('porcentagem', 19);
insert into alternativa(alternativa, idPergunta) values('divisão', 19);
insert into alternativa(alternativa, idPergunta) values('diferença', 19);


insert into pergunta(enunciado, codigo, resposta, assunto) values('Quanto vai ser o valor de i?', 'int i = 3+5*5', '28', 'Matemática');
insert into alternativa(alternativa, idPergunta) values('28', 20);
insert into alternativa(alternativa, idPergunta) values('40', 20);

insert into usuario(nome, senha, email, google) values('Marlon', '1', 'teste', 0);
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (1,'Amigas na Escola','Muito Fácil','Descubra qual a matéria preferida, o animal de estimação, o suco que mais gostam, a cor da mochila e a cidade brasileira que as 5 amigas pretendem visitar nas próximas férias.','amigas-na-escola');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (2,'Amigas na Piscina','Muito Fácil','Num dia ensolarado quatro amigas se reuniram para nadar na piscina. Descubra as características delas seguindo as dicas.','amigas-na-piscina');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (3,'Compras do Mês','Fácil','Cinco mulheres estão fazendo as compras do mês no supermercado. Cada uma delas está acompanhada por alguém, esqueceu de algum item e está usando uma bolsa de cor diferente.','compras-do-mês');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (4,'Presentes de Natal','Fácil','Descubra o que cada um dos cinco meninos quer ganhar de natal.','presentes-de-natal');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (5,'Políticos Corruptos','Fácil','Cinco políticos corruptos estão lado a lado numa sala discutindo negócios. Descubra as características deles seguindo as dicas.','políticos-corruptos');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (6,'Escritório de Advocacia','Fácil','Use a lógica e descubra as características dos advogados de um escritório de advocacia.','escritório-de-advocacia');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (7,'Fila do Banco','Fácil','Cinco homens estão lado a lado aguardando na fila de um banco para pagar uma conta. Descubra qual a conta que cada um foi pagar.','fila-do-banco');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (8,'Amigas na Piscina - II','Fácil','Cinco amigas estão curtindo um dia de sol na piscina. Elas estão lado a lado brincando dentro da piscina. Use a lógica para descobrir as características delas.','amigas-na-piscina---ii');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (9,'Show de Talentos','Fácil','Descubra as características de cada um dos candidatos do show de talentos.','show-de-talentos');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (10,'Meia Maratona','Fácil','Cinco corredores acabaram de disputar uma meia maratona. Use a lógica para descobrir as características deles.','meia-maratona');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (11,'Barraca de Pastel','Fácil','Cinco pessoas estão em uma barraca de pastel de feira. Descubra qual pastel cada uma irá comer.','barraca-de-pastel');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (12,'Livros de Colorir','Fácil','Cinco mulheres estão numa fila para comprar livros de colorir. Descubra qual livro de colorir cada uma irá comprar.','livros-de-colorir');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (13,'Pacientes no Ortopedista','Fácil','Cinco pacientes estão em um consultório de um ortopedista, cada uma com uma dor específica. Descubra qual é a localização da dor e qual é o convênio médico de cada uma.','pacientes-no-ortopedista');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (14,'Navios no Porto','Normal','Encontre a nacionalidade, origem, bandeira, destino e horário de partida de cada um dos 5 navios.','navios-no-porto');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (15,'Nadadores Olímpicos','Normal','Descubra a nacionalidade, a idade e a cor da touca dos 4 nadadores olímpicos, junto com a sua especialidade e o número de medalhas conquistadas em sua carreira.','nadadores-olímpicos');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (16,'Carros no Estacionamento','Normal','Descubra a posição dos cinco veículos estacionados. Os carros são de cores, montadoras, e anos de fabricação diferente. Além disso, cada carro é de um tipo e possúi uma placa distinta.','carros-no-estacionamento');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (17,'Amigas na Escola - II','Normal','Deduza o nome e gostos pessoais de cinco amigas, como matérias, cores e sucos favoritos.','amigas-na-escola---ii');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (18,'Passeio no Zoológico','Normal','Cinco amigas estão esperando na fila para entrar no zoológico. Descubra as preferências de cada uma delas.','passeio-no-zoológico');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (19,'Carros no Mecânico','Normal','Descubra as características dos cinco carros de diferentes montadoras, anos, donos e cores que foram para o mecânico para reparar um problema.','carros-no-mecânico');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (20,'Amigos no Inglês','Normal','Cinco colegas estudam inglês juntos na mesma escola de idiomas e planejam viajar para treinar. Além disso, eles fazem cursos diferentes na faculdade e falam um outro idioma.','amigos-no-inglês');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (21,'Corrida de Kart','Normal','Cinco pilotos acabaram de disputar uma corrida de kart. Descubra a posição de cada um deles.','corrida-de-kart');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (22,'Amigos na Biblioteca','Normal','Cinco amigos estão na fila da biblioteca para pegar um livro emprestado. Descubra as características e os gostos de cada um deles.','amigos-na-biblioteca');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (23,'Réveillon na Praia','Normal','Descubra as características das cinco amigas que estão na praia esperando o ano novo chegar.','réveillon-na-praia');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (24,'Festa de Aniversário','Normal','Cinco amigas foram convidadas para uma festa de aniversário. Siga as dicas para encontrar as características e os gostos delas.','festa-de-aniversário');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (25,'Lutadores de Judô','Normal','Cinco lutadores de judô estão lado a lado se preparando para uma competição. Descubra as características de cada um deles. ','lutadores-de-judô');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (26,'Jogadores de Futebol','Normal','Prepare-se para encontrar as características de cinco jogadores de futebol.','jogadores-de-futebol');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (27,'Almoço de Negócios','Normal','Cinco executivos estão reunidos num restaurante para um almoço de negócios. Descubra quais são as características de cada um deles.','almoço-de-negócios');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (28,'Rodízio de Pizza','Normal','Descubra as características dos cinco amigos que estão aguardando para comer no rodízio de pizza.','rodízio-de-pizza');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (29,'Residencial Cientistas Famosos','Normal','Descubra as características dos cinco prédios e dos seus respectivos arquitetos do residencial Cientistas Famosos.','residencial-cientistas-famosos');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (30,'Campeonato de Boliche','Normal','Descubra qual é a situação de cada uma das equipes participantes do campeonato de boliche.','campeonato-de-boliche');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (31,'Fila da Farmácia','Normal','Cinco mulheres estão na fila do caixa da farmácia. Descubra quais as características delas e o que cada uma foi comprar.','fila-da-farmácia');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (32,'Dia Internacional da Mulher','Normal','Cinco casais estão na fila de espera para jantar num restaurante no Dia Internacional de Mulher. Descubra as características de cada um dos casais.','dia-internacional-da-mulher');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (33,'Casamento Coletivo','Normal','Cinco casais estão participando de um casamento coletivo. Cada casal se conheceu num lugar específico e vai passar a lua de mel na capital de algum estado brasileiro.','casamento-coletivo');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (34,'Passeio de Bicicleta','Normal','Faça o possível para encontrar as características das meninas que estão andando de bicicleta.','passeio-de-bicicleta');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (35,'Feira de Antiguidades','Normal','Cinco colecionadores estão visitando uma feira de antiguidades em busca de novos itens para colecionar. Descubra as características deles usando a lógica.','feira-de-antiguidades');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (36,'Ilha Tropical','Normal','Cinco casais aproveitaram alguns dias de folga numa ilha tropical. Descubra o que eles fizeram e o que compraram de souvenir.','ilha-tropical');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (37,'Dia das Crianças','Normal','Descubra qual brinquedo cada um dos meninos ganhou de dia das crianças.','dia-das-crianças');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (38,'Astrônomos Amadores','Normal','Cinco astrônomos amadores estão lado a lado observando o céu. Descubra qual constelação cada um está observando.','astrônomos-amadores');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (39,'Visita ao Mercado Municipal','Normal','Cinco amigas foram passear no Mercado Municipal. Elas foram comprar produtos diferentes e experimentar frutas exóticas distintas.','visita-ao-mercado-municipal');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (40,'Laboratório de Informática','Normal','Cinco alunos estão no laboratório de informática da escola jogando os seus jogos favoritos do Racha Cuca. Descubra as características de cada um deles.','laboratório-de-informática');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (41,'Bebês no Berçário','Normal','Cinco bebês com poucas horas de vida estão lado a lado num berçário de um hospital. Descubra as características de cada um deles.','bebês-no-berçário');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (42,'Posto de Gasolina','Normal','Cinco carros estão numa fila aguardando para abastecer e aproveitar a promoção de um posto de gasolina.','posto-de-gasolina');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (43,'Turistas na Copa','Normal','Cinco turistas europeus acabaram de chegar no Brasil para acompanhar a Copa e conhecer o Brasil. Use as dicas para descobrir as características deles.','turistas-na-copa');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (44,'Prato Feito','Normal','Cinco homens estão no restaurante para comer um prato feito. Descubra qual prato cada um pediu.','prato-feito');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (45,'Escola de Música','Normal','Cinco alunos estão esperando as suas aulas de música começar. Siga as dicas e descubra as características de cada um.','escola-de-música');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (46,'Previsão do Futuro','Normal','Cinco amigas estão juntas discutindo as previsões do futuro que acabaram de receber. Descubra qual previsão cada uma recebeu.','previsão-do-futuro');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (47,'Escovando os Dentes','Normal','Cinco meninos estão escovando os dentes depois do recreio da escola. Descubra a cor da escova, o sabor da pasta de dente e outras informações sobre eles.','escovando-os-dentes');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (48,'Carro do Morango','Normal','Cinco mulheres estão na fila do carro do morango. Descubra qual doce de morango cada uma pretende fazer.','carro-do-morango');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (49,'Fila da Lavanderia','Normal','Cinco homens estão na fila da lavanderia. Descubra o tipo de roupa que cada um levou para lavar.','fila-da-lavanderia');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (50,'Ponto de Ônibus','Normal','Cinco mulheres estão no ponto de ônibus. Descubra qual ônibus cada uma vai pegar e aonde elas vão.','ponto-de-ônibus');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (51,'Políticos Corruptos - II','Normal','Cinco políticos estão sendo julgados por roubos dos cofre públicos. Analise atentamente as dicas para descobrir as características deles.','políticos-corruptos---ii');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (52,'Ceia de Natal','Normal','Cinco mulheres foram convidadas para participar da ceia de natal da família. Descubra as características delas.','ceia-de-natal');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (53,'Crise Hídrica','Normal','Cinco famílias estão enfrentando a crise hídrica brasileira. Descubra quais são as características dessas famílias.','crise-hídrica');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (54,'Viagem de Carnaval','Normal','Cinco casais de namorados estão na fila do aeroporto aguardando para viajar no carnaval. Descubra para qual cidade cada um dos casais vai.','viagem-de-carnaval');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (55,'Dia na Praia','Normal','Cinco famílias estão aproveitando um lindo dia de sol na praia. Use a lógica para descobrir as características delas.','dia-na-praia');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (56,'Passeio Fotográfico','Normal','Cinco fotógrafos estão participando de um passeio fotográfico. Descubra as características deles através das dicas.','passeio-fotográfico');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (57,'Restaurante Italiano','Normal','Cinco mulheres acompanhadas estão na fila para almoçar num restaurante italiano. Descubra quais são as características delas.','restaurante-italiano');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (58,'Materiais de Construção','Normal','Cinco casais estão sendo atendidos numa loja de materiais de construção. Descubra o que cada um deles quer reformar.','materiais-de-construção');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (59,'Self-Service','Normal','Cinco clientes estão no self-service para almoçar. Descubra o que cada um deles vai comer.','self-service');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (60,'Pronto Socorro','Normal','Cinco pacientes estão aguardando para serem atendidos no pronto socorro de um hospital. Descubra qual é o sintoma de cada um deles.','pronto-socorro');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (61,'Compras no Açougue','Normal','Cinco pessoas acabaram de comprar carne no açougue. Tente descobrir qual carne cada um comprou.','compras-no-açougue');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (62,'Turistas na Oktoberfest','Normal','Cinco turista estão em Santa Catarina curtindo a Oktoberfest. Descubra qual cerveja cada um gosta de beber.','turistas-na-oktoberfest');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (63,'Recepção do Hotel','Normal','Cinco hóspedes estão na recepção de um hotel aguardando para fazer check-in. Descubra quanto tempo cada um ficará no hospedado.','recepção-do-hotel');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (64,'Loja de Calçados','Normal','Cinco mulheres estão numa loja para comprar calçados. Descubra qual calçado cada uma experimentou.','loja-de-calçados');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (65,'Casa de Esfirra','Normal','Cinco clientes estão esperando pelas esfirras que acabaram de comprar. Descubra quantas e quais esfirras cada um comprou.','casa-de-esfirra');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (66,'Colecionadores de Moedas','Normal','Cinco colecionadores estão participando de um encontro de colecionadores de moedas. Descubra quais moedas que cada um deles coleciona.','colecionadores-de-moedas');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (67,'Cachorros no Parque','Normal','Cinco cachorros foram levados no parque para passear. Descubra as características de cada um deles.','cachorros-no-parque');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (68,'Fila do Correio','Normal','Cinco clientes estão na fila do correio esperando para enviar um pacote. Para qual cidade cada um enviará o seu pacote?','fila-do-correio');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (69,'Sala dos Professores','Normal','Cinco professoras estão na sala dos professores durante o intervalo. Descubra para qual série cada uma irá dar aula após o intervalo.','sala-dos-professores');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (70,'Loja de Conveniência','Normal','Cinco pessoas param no posto de combustível para abastecer e fazer compras na loja de conveniência. Descubra o que cada um deles vai comprar.','loja-de-conveniência');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (71,'Exposição de Esculturas','Normal','Cinco esculturas estão em uma exibição especial relacionadas ao mundo da criatividade e das ideias. Através das dicas, descubra as características delas.','exposição-de-esculturas');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (72,'Entrevista de Emprego','Normal','Cinco candidatos estão aguardando para fazer uma entrevista de emprego. Descubra quais são as características de cada um deles.','entrevista-de-emprego');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (73,'Serra Gaúcha','Normal','Cinco casais estão no aeroporto voltando de uma viagem pela Serra Gaúcha. Descubra em qual cidade cada casal se hospedou e a duração de cada viagem.','serra-gaúcha');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (74,'Amigos na Hamburgueria','Normal','Cinco amigos estão em uma hamburgueria. Descubra qual hambúrguer cada um irá comer.','amigos-na-hamburgueria');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (75,'Festa de Formatura','Normal','Cinco mulheres estão curtindo a festa de formatura dos cursos delas. Descubra qual curso cada uma fez.','festa-de-formatura');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (76,'Banca de Jornal','Normal','Cinco mulheres estão na banca de jornal. Descubra qual revista cada uma está lendo.','banca-de-jornal');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (77,'Aluguel de Temporada','Normal','Cinco casas de praia foram alugadas para cinco famílias diferentes. Descubra qual casa cada família alugou.','aluguel-de-temporada');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (78,'Bilhetes Premiados','Normal','Cinco sortudos ganharam prêmios em uma rifa. Descubra o que cada um deles ganhou.','bilhetes-premiados');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (79,'Amigas na Praia','Normal','Cinco amigas estão curtindo um dia de sol na praia. Através da lógica, descubra as características delas.','amigas-na-praia');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (80,'Comadres Tricotando','Normal','Cinco mulheres estão tricotando juntas. Descubra o que cada uma delas está tricotando e quem elas irão presentear.','comadres-tricotando');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (81,'Iogurtes Deliciosos','Normal','Cinco amigas estão lado a lado comendo iogurte. Descubra qual o sabor do iogurte que cada uma delas está comendo.','iogurtes-deliciosos');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (82,'Reforma em Casa','Normal','Cinco pedreiros estão trabalhando na reforma de uma casa. Descubra em qual lugar da casa cada um está trabalhando.','reforma-em-casa');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (83,'Ciclo de Palestras','Normal','Cinco palestrantes estão participando de um ciclo de palestras. Descubra qual será o tema apresentado por cada um deles.','ciclo-de-palestras');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (84,'Prêmio Nobel','Normal','Cinco homens estão em uma confraternização que reune ganhadores do prêmio Nobel. Descubra qual prêmio cada um deles ganhou.','prêmio-nobel');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (85,'Ensaio da Bateria','Normal','Cinco ritmistas estão participando de um ensaio da bateria de uma escola de samba. Tente descobrir qual instrumento de percursão que cada um toca.','ensaio-da-bateria');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (86,'Desfile da Independência','Normal','Cinco espectadores estão assistindo ao desfile da independência do Brasil. Use a lógica para descobrir as características de cada um deles.','desfile-da-independência');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (87,'Investindo no Futuro','Normal','Cinco amigos estão conversando sobre investimentos que fizeram recentemente. Siga as dicas e descubra qual foi a aplicação de cada um deles.','investindo-no-futuro');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (88,'Viciados em Séries','Normal','Cinco amigos estão conversando sobre as suas séries favoritas que estão atualmente no ar. Use as dicas e descubra qual é a série que cada um gosta.','viciados-em-séries');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (89,'Escola de Idiomas','Normal','Cinco turmas estão tendo aula em uma escola de idiomas. Descubra qual idioma e qual assunto cada turma está aprendendo.','escola-de-idiomas');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (90,'Concursos Públicos','Normal','Cinco concurseiros estão em um cursinho estudando para prestarem concurso público. Use as dicas para descobrir qual concurso cada um irá prestar.','concursos-públicos');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (91,'Jogadores de Basquete','Normal','Cinco jogadores de basquete de um mesmo time estão aguardando o início de um jogo. Use as dicas para descobrir quais são as características deles.','jogadores-de-basquete');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (92,'Liquidação de Eletrodomésticos','Normal','Cinco cliente estão aproveitando a liquidação de eletrodomésticos de uma loja. Descubra o que cada uma delas está comprando.','liquidação-de-eletrodomésticos');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (93,'Sudeste Asiático','Normal','Cinco casais estão na área de embarque do aeroporto aguardando para viajar. Descubra para qual país do sudeste asiático cada casal irá viajar.','sudeste-asiático');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (94,'Embaixadores no Brasil','Normal','Cinco embaixadores brasileiros estão participando de uma reunião de embaixadores em Brasília. Descubra qual país cada um deles representa.','embaixadores-no-brasil');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (95,'Haja Paciência','Normal','Cinco mulheres estão conversando sobre os seus jogos de paciência favoritos. Descubra qual jogo cada uma gosta de jogar.','haja-paciência');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (96,'Curso de Tricô','Normal','Cinco mulheres acabaram de participar de um curso de tricô. Cada uma está tricotando algo que acabou de aprender. Use as dicas para descobrir o que cada uma está tricotando.','curso-de-tricô');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (97,'Sebo do Moisés','Normal','Cinco cliente estão na fila do caixa do sebo do Moisés. Cada cliente escolheu um livro de um determinado assunto para comprar. Use as dicas para descobrir qual livro que cada um deles escolheu.','sebo-do-moisés');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (98,'Lava Rápido','Normal','Cinco carros estão recebendo procedimentos de limpeza diferentes em um lava rápido. Descubra qual carro está recebendo a limpeza completa.','lava-rápido');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (99,'Compras no Mercado','Normal','Cinco clientes acabaram de fazer compras no supermercado. Descubra quais produtos eles compraram e quem obteve o maior desconto.','compras-no-mercado');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (100,'Papelaria Universitária','Normal','Cinco estudantes acabaram de fazer compras em uma papelaria da universidade. Descubra o que cada um deles comprou.','papelaria-universitária');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (101,'Personal Trainers','Normal','Cinco mulheres estão treinando na academia com o auxílio de seus respectivos personal trainers. Siga as dicas para descobrir o que cada uma delas está treinando.','personal-trainers');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (102,'Passeio de Escuna','Normal','Cinco famílias estão aproveitando um feriado para fazer um passeio de escuna. Descubra qual passeio cada uma das famílias fará.','passeio-de-escuna');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (103,'Loja de Molduras','Normal','Cinco mulheres estão em uma loja de molduras. Use as dicas e a lógica para descobrir o que cada uma delas levou para emoldurar.','loja-de-molduras');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (104,'Bolsa de Valores','Normal','Cinco investidores estão conversando sobre investimentos no mercado de ações. Use a lógica para descobrir quanto cada um tem investido.','bolsa-de-valores');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (105,'Casa de Câmbio','Normal','Cinco mulheres estão na casa de câmbio para comprar moedas estrangeiras. Siga as dicas para descobrir qual moeda cada uma delas irá comprar.','casa-de-câmbio');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (106,'Competição de Imitação','Normal','Cinco humoristas acabaram de participar de uma competição de imitação. Descubra qual imitação que cada um fez.','competição-de-imitação');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (107,'Cultura Japonesa','Normal','Cinco amigos, netos de japoneses, estão conversando sobre a cultura japonesa e a origem de suas famílias. Descubra quais são as características deles.','cultura-japonesa');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (108,'Encomendas na Portaria','Normal','Cinco moradores estão na portaria do prédio no qual moram para pegar encomendas que acabaram de chegar. Sigas as dicas para descobrir quantos dias o tablet demorou para ser entregue.','encomendas-na-portaria');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (109,'Trufas Saborosas','Normal','Cinco amigas acabaram de comprar trufas em uma loja de doces. Descubra quantas trufas cada uma delas comprou.','trufas-saborosas');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (110,'Motoristas no Aeroporto','Normal','Cinco motoristas particulares estão aguardando os seus respectivos passageiros no aeroporto. Sigas as dicas e descubra qual é o passageiro de cada um deles.','motoristas-no-aeroporto');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (111,'Marinheiros no Porto','Normal','Cinco marinheiros estão no porto de Santos conversando enquanto aguardam o horário de partida de seus respectivos navios. Use as dicas para descobrir qual é a tatuagem de cada um deles.','marinheiros-no-porto');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (112,'Balcão de Trocas','Normal','Cinco mulheres estão no balcão de trocas de uma loja de roupas. Descubra qual delas está trocando a roupa que ganhou por uma mesma roupa só que de tamanho correto.','balcão-de-trocas');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (113,'Passeio no Parque','Normal','Cinco meninos estão passeando de bicicleta no parque. Descubra qual deles tem um gato como animal de estimação.','passeio-no-parque');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (114,'Consulados no Brasil','Normal','Cinco consulados funcionam lado a lado em uma determinada rua. Descubra qual país cada um representa e o seu horário de funcionamento.','consulados-no-brasil');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (115,'Esquadrilha de Aviões','Difícil','Descubra a posição de cada um dos 5 aviões e suas anomalias, bem como seus pilotos e seus gostos pessoais.','esquadrilha-de-aviões');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (116,'Amigas no Cinema','Difícil','Descubra o nome, idade, cor favorita, estilo de filme e o nome do namorado de cada uma das cinco amigas.','amigas-no-cinema');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (117,'Colegas na Academia','Difícil','Cinco colegas, que frequentam a academia no mesmo horário, estão fazendo musculação. Cada um deles está usando um aparelho para exercitar um grupo muscular.','colegas-na-academia');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (118,'Campeonato de Surf','Difícil','Encontre as características das pranchas e dos surfistas que estão aguardando para disputar uma competição de surf.','campeonato-de-surf');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (119,'Sala de Espera','Difícil','Cinco pacientes estão numa sala de espera, lado a lado, aguardando para serem atendidos por suas respectivas dentistas.','sala-de-espera');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (120,'Desfile de Moda','Difícil','Descubra quais são as características de 5 modelos de um desfile de moda.','desfile-de-moda');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (121,'Dia das Mães','Difícil','Cinco rapazes estão na fila do caixa para pagar pelo presente que vão comprar de Dia das Mães. Descubra o que eles vão comprar e quanto vão gastar.','dia-das-mães');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (122,'Visita ao Pet Shop','Difícil','Descubra quais são as características dos cachorros e dos seus donos que estão num pet shop.','visita-ao-pet-shop');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (123,'Visita ao Aquário','Difícil','Cinco amigas estão visitando um aquário que possuí vários tipos de peixes e mamíferos aquático. Tente descobrir qual animal cada menina deseja ver.','visita-ao-aquário');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (124,'Ovos de Páscoa','Difícil','Cinco mães estão na fila do supermercado para comprar um ovo de páscoa para os filhos.','ovos-de-páscoa');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (125,'Carros no Pedágio','Difícil','Descubra as características dos carros que estão passando ao mesmo tempo por um pedágio.','carros-no-pedágio');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (126,'Campeonato de Skate','Difícil','Cinco skatistas disputam um campeonato de skate. Descubra as características deles seguindo as dicas.','campeonato-de-skate');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (127,'Dia do Trabalho','Difícil','Cinco trabalhadores estão participando das festividades do dia do trabalho. Siga as dicas para encontrar as características deles.','dia-do-trabalho');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (128,'Feirão de Imóveis','Difícil','Cinco casais estão na fila para falar com um corretor num feirão de imóveis. Siga as dicas para descobrir qual apartamento cada casal deseja comprar.','feirão-de-imóveis');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (129,'Feira de Intercâmbio','Difícil','Cinco estudantes estão aproveitando uma feira de intercâmbio para concretizar os planos de estudar fora do país. Descubra para qual país cada estudante vai.','feira-de-intercâmbio');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (130,'Entregas Rápidas','Difícil','Cinco motoboys estão se preparando para fazer entregas. Descubra quais são as características deles e qual é o destino de cada um.','entregas-rápidas');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (131,'Black Friday','Difícil','Cinco mulheres estão aproveitando as promoções da Black Friday em uma loja. Descubra o que cada uma comprou.','black-friday');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (132,'Aula de Yoga','Difícil','Cinco mulheres estão participando de uma aula de yoga. Descubra qual é a posição favorita de yoga de cada uma delas.','aula-de-yoga');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (133,'Corrida de Cavalo','Difícil','Cinco jóqueis estão aguardando o início de uma corrida. Descubra quais são as características de cada um deles.','corrida-de-cavalo');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (134,'Degustação de Vinho','Difícil','Cinco homens estão participando da degustação de vinhos. Tente descobrir qual vinho cada um está provando.','degustação-de-vinho');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (135,'Artes Marciais','Difícil','Cinco lutadoras estão conversando sobre a arte marcial que cada uma pratica. Cabe a você descobrir a luta que cada uma treina.','artes-marciais');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (136,'Cortes Artísticos','Difícil','Cinco homens estão no cabeleireiro fazendo cortes artísticos. Descubra qual corte artístico cada um escolheu.','cortes-artísticos');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (137,'Dia de Faxina','Difícil','Cinco irmãos vão ajudar os pais a fazer a faxina da casa onde eles moram. Use a dica para descobrir qual item de limpeza cada um deles escolheu para ajudar na limpeza da casa.','dia-de-faxina');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (138,'Apresentadoras de TV','Difícil','Cinco apresentadoras de TV estão conversando nos bastidores. Siga as dicas e descubra qual programa cada uma delas apresenta.','apresentadoras-de-tv');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (139,'Roupa Suja','Difícil','Cinco mulheres estão em uma lavanderia. Cada uma delas deixou uma peça de roupa para lavar. Siga as dicas para descobrir qual peça cada uma delas deixo pra lavar.','roupa-suja');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (140,'Aula de Pintura','Difícil','Cinco alunas estão pintando em suas respectivas telas durante uma aula de pintura. Descubra qual aluna está usando o avental vermelho.','aula-de-pintura');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (141,'Piratas na Taverna','Difícil','Cinco piratas estão bebendo em uma taverna. Siga as dicas e use a lógica para descobrir qual tesouro cada um deles enterrou.','piratas-na-taverna');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (142,'Funcionários do Banco','Difícil','Cinco funcionários de um banco estão aproveitando a hora do café da tarde para comer um lanche e beber um suco. Siga as dicas para descobrir qual é o cargo ocupado pelo Celso.','funcionários-do-banco');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (143,'Motos Estilosas','Difícil','Cinco motos estilosas estão estacionadas em um estacionamento. Siga as dicas para descobrir qual é a moto do Luciano.','motos-estilosas');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (144,'Viagem de Ônibus','Difícil','Cinco mulheres estão em uma fila para entrar em um ônibus e viajar. Use a lógica para descobrir quais parentes cada uma delas irá visitar.','viagem-de-ônibus');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (145,'Tortas Vegetarianas','Difícil','Cinco amigas estão em um restaurante comendo tortas vegetarianas. Siga as dicas para descobrir qual delas está lendo uma biografia.','tortas-vegetarianas');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (146,'Viciados em Curiosidades','Difícil','Cinco amigos estão conversando sobre as curiosidades que eles mais gostam. Através da lógica, descubra qual o tipo de curiosidade favorita do corretor.','viciados-em-curiosidades');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (147,'Analistas de Investimentos','Difícil','Cinco analistas de investimentos estão conversando no centro financeiro de São Paulo. Descubra quanto cada um deles espera de alta para os seus respectivos segmentos favoritos.','analistas-de-investimentos');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (148,'Salão de Beleza','Muito Difícil','Deduza o nome, a profissão e o que as cinco amigas foram fazer no Salão de Beleza. Além disso, descubra a cor da bolsa, o suco favorito e o estado de origem de cada uma delas.','salão-de-beleza');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (149,'Navios no Porto - II','Muito Difícil','Encontre a cor da chaminé, nacionalidade, horário de partida, carregamento, destino e nome do capitão de cada um dos 5 navios. ','navios-no-porto---ii');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (150,'Esquadrilha de Aviões - II','Muito Difícil','Descubra quem pilota cada um dos 5 aviões na formação e suas anomalias, bem como outras informações pessoais de cada piloto.','esquadrilha-de-aviões---ii');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (151,'Acampamento de Férias','Muito Difícil','Cinco garotos estão dentro de suas respectivas barracas aguardando o início de uma gincana. Descubra qual a equipe de cada um deles.','acampamento-de-férias');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (152,'Recital de Poesia','Muito Difícil','Cinco meninas aguardam lado a lado para recitar um poema no recital. Siga as dicas para descobrir as característica delas.','recital-de-poesia');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (153,'Carros Antigos','Muito Difícil','Cinco carros estão estacionados numa exibição de carros antigos. Descubra quais são as características deles.','carros-antigos');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (154,'Visita ao Museu','Muito Difícil','Cinco mulheres estão visitando um museu. Descubra qual é o pintor favorito de cada uma delas.','visita-ao-museu');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (155,'Bebês na Creche','Muito Difícil','Cinco bebês estão passando o dia em uma creche. Através das dicas, descubra as características deles.','bebês-na-creche');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (156,'Reunião de Condomínio','Muito Difícil','Cinco moradores estão participando de uma reunião de condomínio. Descubra qual é a reclamação de cada um deles.','reunião-de-condomínio');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (157,'Problema 1','Muito Fácil','Problema muito fácil com apenas 3 dicas e 3 casas.','problema-1');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (158,'Problema 2','Fácil','Com 6 dicas e 3 casas, esse problema é fácil.','problema-2');
INSERT INTO TABELA_VERDADE (`id`,`nome`,`nivel`,`descricao`,`url`) VALUES (159,'Problema 3','Normal','Com 9 dicas e 4 casas, esse problema já não é tão trivial.','problema-3');

insert into conquista(pontuacao, titulo, descricao) values (100, 'Olá mundo', 'Resolva a questão "Olá mundo"');
insert into conquista(pontuacao, titulo, descricao) values (100, 'Primeiro quiz', 'Resolva seu primeiro quiz');
insert into conquista(pontuacao, titulo, descricao) values (100, 'Tentando a sorte', 'Gire a roleta');
insert into conquista(pontuacao, titulo, descricao) values (100, 'Ora ora...', 'Resolva sua primeira tabela verdade');
insert into conquista(pontuacao, titulo, descricao) values (200, 'Programador iniciante', 'Resolva todas as questões de sequência');
insert into conquista(pontuacao, titulo, descricao) values (200, 'Acertando tudo', 'Gabarite um quiz');
insert into conquista(pontuacao, titulo, descricao) values (200, 'De tudo um pouco', 'Resolva uma questão de cada assunto');
insert into conquista(pontuacao, titulo, descricao) values (500, 'Programador intermediário', 'Resolva todas as questões de seleção');
insert into conquista(pontuacao, titulo, descricao) values (500, 'Viciado na sorte', 'Resolva 3 questões pela roleta');
insert into conquista(pontuacao, titulo, descricao) values (1000, 'Programador avançado', 'Resolva todas as questões de repetição');
insert into conquista(pontuacao, titulo, descricao) values (1000, 'Solucionador de problemas', 'Resolva 10 questões de programação');
insert into conquista(pontuacao, titulo, descricao) values (1000, 'Sherlock Holmes', 'Resolva 10 tabelas verdade');
insert into conquista(pontuacao, titulo, descricao) values (1000, 'Viciado em quiz', 'Resolva 10 quizzes');
insert into conquista(pontuacao, titulo, descricao) values (1000, 'Nível Einstein', 'Resolva uma tabela verdade nível muito difícil');

