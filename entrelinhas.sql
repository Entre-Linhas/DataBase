Drop database if exists entrelinhas;

create database entrelinhas;

use entrelinhas;

CREATE TABLE `Precificacao` (
	`id_precificacao` INT AUTO_INCREMENT,
	`material` varchar(255),
	`preco` DECIMAL(10,2),
	`quantidade` INT,
	`preco_total` DECIMAL(10,2),
	`id_pedidos` INT,
	PRIMARY KEY (`id_precificacao`)
);

CREATE TABLE `Pedidos` (
	`id_pedidos` INT AUTO_INCREMENT,
	`topicos_gerenciamento` INT,
	`descricao_pedido` varchar(255),
	`quantidade` INT,
	`custo` DECIMAL(10,2),
	`id_usuario` INT,
	`id_status` INT,
	PRIMARY KEY (`id_pedidos`)
);

CREATE TABLE `Redes_sociais` (
	`id_rede` INT AUTO_INCREMENT,
	`id_link` INT,
	`id_usuario` INT,
	PRIMARY KEY (`id_rede`)
);

CREATE TABLE `Status` (
	`id_status` INT AUTO_INCREMENT,
	`status_usuarios` INT,
	`status_trilha` INT,
	`status_atividade` INT,
	PRIMARY KEY (`id_status`)
);

CREATE TABLE `Conquista` (
	`id_conquista` INT AUTO_INCREMENT,
	`nome` varchar(255),
	`data_conquista` DATE,
	`id_perfil` INT,
	PRIMARY KEY (`id_conquista`)
);

CREATE TABLE `Plano` (
	`id_plano` INT AUTO_INCREMENT,
	`nome` varchar(255),
	`descricao` TEXT,
	`preco` DECIMAL(10,2),
	`id_status` INT,
	PRIMARY KEY (`id_plano`)
);

CREATE TABLE `Usuario` (
	`id_usuario` INT AUTO_INCREMENT,
	`nome` varchar(255),
	`e-mail` varchar(255) UNIQUE,
	`senha` varchar(8),
	`cep` varchar(9),
	`data_inicio` DATE,
	`data_termino` DATE,
	`progresso` FLOAT,
	`endereço` varchar(255),
	`numero` varchar(11),
	`bairro` varchar(255),
	`cidade` varchar(255),
	`cpf` varchar(20),
	`cnpj` varchar(20),
	`id_plano` INT,
	`id_status` INT,
	`id_trilhas` INT,
	PRIMARY KEY (`id_usuario`)
);

CREATE TABLE `Trilhas` (
	`id_trilhas` INT AUTO_INCREMENT,
	`titulo` varchar(255),
	`status` varchar(255),
	`data_criacao` DATE,
	`nivel_minimo` INT,
	`id_atividades` INT,
	`id_status` INT,
	PRIMARY KEY (`id_trilhas`)
);

CREATE TABLE `Conteudo` (
	`id_conteudo` INT AUTO_INCREMENT,
	`perguntas` varchar(255),
	`respostas` varchar(255),
	`propriedades` INT,
	`descricao` TEXT,
	PRIMARY KEY (`id_conteudo`)
);

CREATE TABLE `Atividades` (
	`id_atividades` INT AUTO_INCREMENT,
	`nome_atividade` INT,
	`status` varchar(255),
	`progresso` FLOAT,
	`id_conteudo` INT,
	PRIMARY KEY (`id_atividades`)
);

CREATE TABLE `Ferramentas` (
	`id_ferramentas` INT AUTO_INCREMENT,
	`nome_ferramenta` varchar(255),
	`servico_minimo` varchar(255),
	PRIMARY KEY (`id_ferramentas`)
);

CREATE TABLE `Propriedades` (
	`id_propriedades` INT AUTO_INCREMENT,
	`tipo_propriedade` varchar(255),
	`valor_propriedade` varchar(255),
	`id_ferramentas` INT,
	PRIMARY KEY (`id_propriedades`)
);

CREATE TABLE `Perfil` (
	`id_perfil` INT AUTO_INCREMENT,
	`nivel` INT,
	`conquista` INT,
	`pontuacoes` INT,
	`servico` varchar(255),
	`daily` DATE,
	`combo` INT,
	`max_combo` INT,
	`id_usuario` INT,
	`id_trilhas` INT,
	`id_ferramentas` INT,
	PRIMARY KEY (`id_perfil`)
);

ALTER TABLE `Conquista` ADD CONSTRAINT `Conquista_fk0` FOREIGN KEY (`id_perfil`) REFERENCES `Perfil` (`id_perfil`);

ALTER TABLE `Perfil` ADD CONSTRAINT `Perfil_fk0` FOREIGN KEY (`id_usuario`) REFERENCES `Usuario` (`id_usuario`);
ALTER TABLE `Perfil` ADD CONSTRAINT `Perfil_fk1` FOREIGN KEY (`id_trilhas`) REFERENCES `Trilhas` (`id_trilhas`);
ALTER TABLE `Perfil` ADD CONSTRAINT `Perfil_fk2` FOREIGN KEY (`id_ferramentas`) REFERENCES `Ferramentas` (`id_ferramentas`);

ALTER TABLE `Trilhas` ADD CONSTRAINT `Trilhas_fk0` FOREIGN KEY (`id_atividades`) REFERENCES `Atividades` (`id_atividades`);
ALTER TABLE `Trilhas` ADD CONSTRAINT `Trilhas_fk1` FOREIGN KEY (`id_status`) REFERENCES `Status` (`id_status`);

ALTER TABLE `Atividades` ADD CONSTRAINT `Atividades_fk0` FOREIGN KEY (`id_conteudo`) REFERENCES `Conteudo` (`id_conteudo`);

ALTER TABLE `Usuario` ADD CONSTRAINT `Usuario_fk0` FOREIGN KEY (`id_plano`) REFERENCES `Plano` (`id_plano`);
ALTER TABLE `Usuario` ADD CONSTRAINT `Usuario_fk1` FOREIGN KEY (`id_status`) REFERENCES `Status` (`id_status`);
ALTER TABLE `Usuario` ADD CONSTRAINT `Usuario_fk2` FOREIGN KEY (`id_trilhas`) REFERENCES `Trilhas` (`id_trilhas`);

ALTER TABLE `Redes_sociais` ADD CONSTRAINT `Redes_sociais_fk1` FOREIGN KEY (`id_usuario`) REFERENCES `Usuario` (`id_usuario`);

ALTER TABLE `Propriedades` ADD CONSTRAINT `Propriedades_fk0` FOREIGN KEY (`id_ferramentas`) REFERENCES `Ferramentas` (`id_ferramentas`);

ALTER TABLE `Pedidos` ADD CONSTRAINT `Pedidos_fk0` FOREIGN KEY (`id_usuario`) REFERENCES `Usuario` (`id_usuario`);
ALTER TABLE `Pedidos` ADD CONSTRAINT `Pedidos_fk1` FOREIGN KEY (`id_status`) REFERENCES `Status` (`id_status`);

ALTER TABLE `Precificacao` ADD CONSTRAINT `Precificacao_fk0` FOREIGN KEY (`id_pedidos`) REFERENCES `Pedidos` (`id_pedidos`);


