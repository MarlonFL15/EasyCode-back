create table usuario(
	nome varchar(45) not null,
    senha varchar(45) null,
    email varchar(45) not null,
    foto longblob null,
    pathFoto varchar(100) null,
    primary key(email)
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

create table quiz(
	id int not null auto_increment,
    enunciado varchar(256) not null,
    codigo varchar(256) null,
    resposta varchar(100) not null, 
    assunto varchar(16) not null,
    primary key(id)
);

create table alternativa(
	id int not null auto_increment,
    label varchar(32) not null,
    idQuiz int not null,
    primary key(id),
    foreign key (idQuiz) references quiz(id)
);

create table form(
	id int not null auto_increment,
    titulo varchar(32) not null,
    descricao varchar(256) not null,
    primary key(id)
);

create table formQuiz(
	id int not null auto_increment,
    idQuiz int not null,
    idForm int not null,
    primary key (id),
    foreign key (idQuiz) references quiz(id),
    foreign key (idForm) references form(id)
);

create table respostaQuiz(
	id int not null auto_increment,
	idFormQuiz int not null,
    respostaUsuario varchar(100) not null,
    correto bool not null,
	primary key (id),
    foreign key (idFormQuiz) references formQuiz(id)
);

create table respostaQuestao(
	id int not null auto_increment,
	idQuestao int not null,
    idUsuario varchar(45) not null,
    codigo varchar(4000) not null,
    respostaUsuario varchar(100) not null,
    correto bool not null,
    dataEnvio date not null,
	primary key (id),
    foreign key (idQuestao) references questao(id),
    foreign key (idUsuario) references usuario(email)
);

create table respostaForm(
	id int not null auto_increment,
	idForm int not null,
    idUsuario varchar(45) not null,
    dataEnvio date not null,
	primary key (id),
    foreign key (idForm) references form(id),
    foreign key (idUsuario) references usuario(email)
);

create table conquista(
	id int not null auto_increment,
	icon longblob not null,
    titulo varchar(45) not null,
	primary key (id)
);

create table conquistaUsuario(
	emailUsuario varchar(45) not null,
    idConquista int not null,
	primary key (emailUsuario, idConquista),
    foreign key(emailUsuario) references usuario(email),
    foreign key(idConquista) references conquista(id)
);


insert into questao values(6, 'Fatorial','Faça um programa que calcule o fatorial de um número','Médio', 30, 'Laços');
insert into exemploQuestao values(16,'4\n',CONCAT_WS(CHAR(13 using utf8), '24', ''),6);
insert into exemploQuestao values(17,'6\n',CONCAT_WS(CHAR(13 using utf8), '720', ''),6);
insert into exemploQuestao values(18,'5\n',CONCAT_WS(CHAR(13 using utf8), '120', ''),6);


insert into questao values(5, 'Contando em strings','Faça um programa que retorne quantas vezes a letra "O" aparece em uma string lida do teclado','Médio', 30, 'Texto');
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
