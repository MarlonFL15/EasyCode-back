create database easycode;
use easycode;
drop database easycode;

select * from usuario;
select * from pergunta;

insert into pergunta values(8,'Palíndromo', 'Faça um programa que diga se uma palavra é um palíndromo','Difícil', 50,'código', 'P', 'Laços');
insert into pergunta values(7, 'Primo', 'Faça um programa que diga se um número é primo ou não','Difícil', 50,'código', 'P', 'Laços');

insert into pergunta values(6, 'Fatorial','Faça um programa que calcule o fatorial de um número','Médio', 30,'código', 'P', 'Laços');
insert into exemploQuestao values(16,'4\n',CONCAT_WS(CHAR(13 using utf8), '24', ''),6);
insert into exemploQuestao values(17,'6\n',CONCAT_WS(CHAR(13 using utf8), '720', ''),6);
insert into exemploQuestao values(18,'5\n',CONCAT_WS(CHAR(13 using utf8), '120', ''),6);


insert into pergunta values(5, 'Contando em strings','Faça um programa que retorne quantas vezes a letra "O" aparece em uma string lida do teclado','Médio', 30,'código', 'P', 'Texto');
insert into exemploQuestao values(13,'EasyCode\n',CONCAT_WS(CHAR(13 using utf8), '1', ''),5);
insert into exemploQuestao values(14,'Coronavirus',CONCAT_WS(CHAR(13 using utf8), '2', ''),5);
insert into exemploQuestao values(15,'Essa é mais uma frase para testar o algoritmo',CONCAT_WS(CHAR(13 using utf8), '3', ''),5);

insert into pergunta values(4, 'MDC', 'Faça um programa que calcule o MDC de dois números','Médio', 30,'código', 'P', 'Matemática');
insert into exemploQuestao values(10,'5\n15',CONCAT_WS(CHAR(13 using utf8), '5', ''),4);
insert into exemploQuestao values(11,'3\n12',CONCAT_WS(CHAR(13 using utf8), '3', ''),4);
insert into exemploQuestao values(12,'320\n150',CONCAT_WS(CHAR(13 using utf8), '10', ''),4);

insert into pergunta values(3, 'Par ou ímpar', 'Faça um programa que imprima "PAR" se o número for par, "IMPAR" se não for','Fácil', 10,'código', 'P', 'Seleção');
insert into exemploQuestao values(6,'1\n',CONCAT_WS(CHAR(13 using utf8), 'IMPAR', ''),3);
insert into exemploQuestao values(7,'3\n',CONCAT_WS(CHAR(13 using utf8), 'IMPAR', ''),3);
insert into exemploQuestao values(8,'4\n',CONCAT_WS(CHAR(13 using utf8), 'PAR', ''),3);
insert into exemploQuestao values(9,'10\n',CONCAT_WS(CHAR(13 using utf8), 'PAR', ''),3);
SELECT * from exemploQuestao;

insert into pergunta values(2, 'Soma de inteiros', 'Faça um programa que calcule a soma de 2 números','Fácil', 10,'código', 'P', 'Sequência');
insert into exemploQuestao values(2,'1\n1','1.0',2);
insert into exemploQuestao values(4,'2\n2','4.0',2);
insert into exemploQuestao values(5,'3\n5','8.0',2);

update exemploQuestao set saida=CONCAT_WS(CHAR(13 using utf8), '8.0', '') where id=5;
insert into pergunta values(1, 'Olá mundo', 'Faça um programa que imprima "Olá mundo"','Fácil', 10,'código', 'P', 'Sequência');
insert into exemploQuestao values(1,null,'Olá mundo',1);
update exemploQuestao set saida=CONCAT_WS(CHAR(13 using utf8), 'Ola mundo', '') where id=1;
update pergunta set enunciado = 'Faça um programa que imprima "Ola mundo"' where id=1;

create table usuario(
	nome varchar(45) not null,
    senha varchar(45) not null,
    email varchar(45) not null,
    primary key(email)
);

create table pergunta(
	id int not null auto_increment,
    titulo varchar(64) null,
    enunciado varchar(256) not null,
    nivel varchar(10) null,
    pontos int null,
    codigo varchar(256) null,
    tipo char not null, /*Q, P ou T*/
    assunto varchar(16) not null,
    primary key(id)
);

create table exemploQuestao(
	id int not null auto_increment,
    entrada varchar(50) null,
    saida varchar(50),
    idQuestao int not null,
    primary key(id),
    foreign key(idQuestao) references pergunta(id)
);

create table alternativa(
	id int not null auto_increment,
    valor varchar(32) not null,
    idPergunta int not null,
    primary key(id),
    foreign key (idPergunta) references pergunta(id)
);

create table resposta(
	id int not null auto_increment,
    resp varchar(256) not null,
    idPergunta int not null,
    emailUsuario varchar(20) not null,
    dateResposta date not null,
    primary key(id),
    foreign key (idPergunta) references pergunta(id),
    foreign key (emailUsuario) references usuario(email)
);
