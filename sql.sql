
create database easycode;
use  easycode;

create table usuario(
    id int not null auto_increment,
	nome varchar(45) not null,
    senha varchar(45) null,
    email varchar(45) not null,
    foto longblob null,
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
    primary key(id),
    foreign key (idPergunta) references pergunta(id),
    foreign key (idForm) references form(id)
);

create table respostaPergunta(
	id int not null auto_increment,
    idFormPergunta int not null,
    respostaUsuario varchar(100) not null,
    correto bool not null,
    primary key(id),
    foreign key (idFormPergunta) references Form_Pergunta(id)
);

create table respostaQuestao(
	id int not null auto_increment,
	idQuestao int not null,
    idUsuario int not null,
    codigo varchar(4000) not null,
    correto bool not null,
    dataEnvio datetime not null,
	primary key (id),
    foreign key (idQuestao) references questao(id),
    foreign key (idUsuario) references usuario(id)
);


create table conquista(
	id int not null auto_increment,
	icon blob null,
    titulo varchar(45) not null,
    descricao varchar(45),
	primary key (id)
);

create table conquistaUsuario(
	idUsuario int not null,
    idConquista int not null,
	primary key (idUsuario, idConquista),
    foreign key(idUsuario) references usuario(id),
    foreign key(idConquista) references conquista(id)
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

select * from pergunta;
select * from alternativa;

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
insert into alternativa(alternativa, idPergunta) values('for(i = 0;  i <= 10; i++)', 13);
insert into alternativa(alternativa, idPergunta) values('for(i = 0,  i <= 10, i++)', 13);
insert into alternativa(alternativa, idPergunta) values('for(i = 0; i++; i <= 10;)', 13);
insert into alternativa(alternativa, idPergunta) values('for(i = 0, i++, i <= 10;)', 13);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Sabendo que i = 0, qual será o valor da variável i após o laço?','while(i<=10){\ni++}' , '11', 'Repetição');
insert into alternativa(alternativa, idPergunta) values('11', 14);
insert into alternativa(alternativa, idPergunta) values('10', 14);
insert into alternativa(alternativa, idPergunta) values('9', 14);
insert into alternativa(alternativa, idPergunta) values('10', 14);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Defina o nome das 3 partes do for', null, 'inicialização; condição; incremento', 'Repetição');
insert into alternativa(alternativa, idPergunta) values('condição; inicialização; incremento', 15);
insert into alternativa(alternativa, idPergunta) values('inicialização; condição; incremento', 15);
insert into alternativa(alternativa, idPergunta) values('inicialização; incremento; condição', 15);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Qual é o nome da palavra usada para interromper um laço?', null, 'break', 'Repetição');
insert into alternativa(alternativa, idPergunta) values('return 0', 16);
insert into alternativa(alternativa, idPergunta) values('break', 16);
insert into alternativa(alternativa, idPergunta) values('continue', 16);
insert into alternativa(alternativa, idPergunta) values('goto', 16);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Qual é o nome da biblioteca que importa as funções de matemática?', null, 'math', 'Matemática');
insert into alternativa(alternativa, idPergunta) values('math', 17);
insert into alternativa(alternativa, idPergunta) values('matemática', 17);
insert into alternativa(alternativa, idPergunta) values('maht', 17);
insert into alternativa(alternativa, idPergunta) values('calc', 17);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Qual é o nome da função que calcula a raíz quadrada?', null, 'sqrt', 'Matemática');
insert into alternativa(alternativa, idPergunta) values('sqrt', 18);
insert into alternativa(alternativa, idPergunta) values('pow', 18);
insert into alternativa(alternativa, idPergunta) values('cos', 18);
insert into alternativa(alternativa, idPergunta) values('max', 18);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Sabendo que x = 3 e y = 2, quando retorna o código abaixo?', 'pow(x,y)', '9', 'Matemática');
insert into alternativa(alternativa, idPergunta) values('9', 19);
insert into alternativa(alternativa, idPergunta) values('6', 19);
insert into alternativa(alternativa, idPergunta) values('8', 19);
insert into alternativa(alternativa, idPergunta) values('27', 19);

insert into pergunta(enunciado, codigo, resposta, assunto) values('Qual é a função do operador "%"?', null, 'resto da divisão', 'Matemática');
insert into alternativa(alternativa, idPergunta) values('resto da divisão', 20);
insert into alternativa(alternativa, idPergunta) values('porcentagem', 20);
insert into alternativa(alternativa, idPergunta) values('divisão', 20);
insert into alternativa(alternativa, idPergunta) values('diferença', 20);


insert into pergunta(enunciado, codigo, resposta, assunto) values('Quanto vai ser o valor de i?', 'int i = 3+5*5', '28', 'Matemática');
insert into alternativa(alternativa, idPergunta) values('28', 21);
insert into alternativa(alternativa, idPergunta) values('40', 21);
insert into alternativa(alternativa, idPergunta) values('20', 21);
insert into alternativa(alternativa, idPergunta) values('15', 21);

