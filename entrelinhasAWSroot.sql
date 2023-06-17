drop database entrelinhas;

create database entrelinhas;

use entrelinhas;

CREATE TABLE `conteudo` (
	`id_conteudo` bigint AUTO_INCREMENT,
	`perguntas` varchar(255),
	`respostas` varchar(255),
	`propriedades` INT,
	`descricao` TEXT,
	PRIMARY KEY (`id_conteudo`)
);

CREATE TABLE `status` (
	`id_status` bigint AUTO_INCREMENT,
	`status_usuarios` INT,
	`status_trilha` INT,
	`status_atividade` INT,
	PRIMARY KEY (`id_status`)
);

CREATE TABLE `ferramentas` (
	`id_ferramentas` bigint AUTO_INCREMENT,
	`nome_ferramenta` varchar(255),
	`servico_minimo` varchar(255),
	PRIMARY KEY (`id_ferramentas`)
);

CREATE TABLE `propriedades` (
	`id_propriedades` bigint AUTO_INCREMENT,
	`tipo_propriedade` varchar(255),
	`valor_propriedade` varchar(255),
	`id_ferramentas` bigint,
	PRIMARY KEY (`id_propriedades`), 
	FOREIGN KEY (`id_ferramentas`) REFERENCES `ferramentas`(`id_ferramentas`)
);

CREATE TABLE `atividades` (
	`id_atividades` bigint AUTO_INCREMENT,
	`nome_atividade` varchar(255),
	`status` varchar(255),
	`progresso` FLOAT,
	`id_conteudo` bigint,
	PRIMARY KEY (`id_atividades`), 
	FOREIGN KEY (id_conteudo) REFERENCES `conteudo`(id_conteudo)
);

CREATE TABLE `trilhas` (
	`id_trilhas` bigint AUTO_INCREMENT,
	`titulo` varchar(255),
	`status` varchar(255),
	`data_criacao` datetime,
	`nivel_minimo` INT,
	`id_atividades` bigint,
	`id_status` bigint,
	PRIMARY KEY (`id_trilhas`), 
	FOREIGN KEY (id_atividades) REFERENCES `atividades`(id_atividades), 
	FOREIGN KEY (id_status) REFERENCES `status`(id_status)
);

CREATE TABLE `plano` (
	`id_plano` bigint AUTO_INCREMENT,
	`nome` varchar(255),
	`descricao` TEXT,
	`preco` DECIMAL(10,2),
	`id_status` bigint,
	PRIMARY KEY (`id_plano`), 
	FOREIGN KEY (id_status) REFERENCES `status`(id_status)
);

CREATE TABLE `usuario` (
	`id_usuario` bigint AUTO_INCREMENT,
	`nome` varchar(255),
    `sobrenome` varchar(255),
	`email` varchar(255) UNIQUE,
	`senha` varchar(8),
	`cep` varchar(9),
	`data_inicio` DATE,
	`data_termino` DATE,
	`progresso` FLOAT,
	`endereco` varchar(255),
	`numero` varchar(11),
	`bairro` varchar(255),
	`cidade` varchar(255),
	`cpf` varchar(20),
	`cnpj` varchar(20),
	`id_plano` bigint,
	`id_status` bigint,
	`id_trilhas` bigint,
	PRIMARY KEY (`id_usuario`), 
	FOREIGN KEY (id_plano) REFERENCES `plano`(id_plano),
	FOREIGN KEY (id_status) REFERENCES `status`(id_status),
	FOREIGN KEY (id_trilhas) REFERENCES `trilhas`(id_trilhas)
);

CREATE TABLE `perfil` (
	`id_perfil` bigint AUTO_INCREMENT,
	`nivel` INT,
	`conquista` INT,
	`pontuacoes` INT,
	`servico` varchar(255),
	`daily` DATE,
	`combo` INT,
	`max_combo` INT,
	`id_usuario` bigint,
	`id_trilhas` bigint,
	`id_ferramentas` bigint,
	PRIMARY KEY (`id_perfil`), 
	FOREIGN KEY (id_usuario) REFERENCES `usuario`(id_usuario), 
	FOREIGN KEY (id_trilhas) REFERENCES `trilhas`(id_trilhas), 
	FOREIGN KEY (id_ferramentas) REFERENCES `ferramentas`(id_ferramentas)
);

CREATE TABLE `pedidos` (
	`id_pedidos` bigint AUTO_INCREMENT,
	`topicos_gerenciamento` varchar(255),
	`descricao_pedido` varchar(255),
	`quantidade` INT,
	`custo` DECIMAL(10,2),
	`id_usuario` bigint,
	`id_status` bigint,
	PRIMARY KEY (`id_pedidos`),
	FOREIGN KEY (id_usuario) REFERENCES `usuario`(id_usuario),
	FOREIGN KEY (id_status) REFERENCES `status`(id_status)
);

CREATE TABLE `precificacao` (
	`id_precificacao` bigint AUTO_INCREMENT,
	`material` varchar(255),
	`preco` DECIMAL(10,2),
	`quantidade` INT,
	`preco_total` DECIMAL(10,2),
	`id_pedidos` bigint,
	PRIMARY KEY (`id_precificacao`),
	FOREIGN KEY (id_pedidos) REFERENCES `pedidos`(id_pedidos)
);

CREATE TABLE `conquista` (
	`id_conquista` bigint AUTO_INCREMENT,
	`nome` varchar(255),
	`data_conquista` DATE,
	`id_perfil` bigint,
	PRIMARY KEY (`id_conquista`), 
	FOREIGN KEY (id_perfil) REFERENCES `perfil`(id_perfil)
);

CREATE TABLE `redes_sociais` (
	`id_rede` bigint AUTO_INCREMENT,
	`id_link` INT,
	`id_usuario` bigint,
	PRIMARY KEY (`id_rede`),
	FOREIGN KEY (id_usuario) REFERENCES `usuario`(id_usuario)
);

CREATE TABLE `notificacao` (
	`id_notificacao` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`nome_notificacao` varchar(255),
	`descricao` TEXT,
	`source` varchar(255),
  `id_usuario` bigint,
	FOREIGN KEY (id_usuario) REFERENCES `usuario`(id_usuario)
);

CREATE TABLE `materia` (
	`id_materia` bigint PRIMARY KEY AUTO_INCREMENT,
  `titulo_pag` VARCHAR(255),
  `img` VARCHAR(255),
  `txt1` TEXT,
  `txt2` TEXT,
  `txt3` TEXT
);

CREATE TABLE `pratica` (
	`id_pratica` bigint PRIMARY KEY AUTO_INCREMENT,
  `titulo_pag` VARCHAR(255),
  `subtitulo_pag` VARCHAR(255),
  `txt1` TEXT,
  `txt2` TEXT,
  `txt3` TEXT,
  `txt4` TEXT
);

CREATE TABLE `dica` (
	`id_dica` bigint PRIMARY KEY AUTO_INCREMENT,
  `titulo_pag` VARCHAR(255),
  `txt1` TEXT,
  `txt2` TEXT,
  `txt3` TEXT,
  `txt4` TEXT,
	`txt5` TEXT,
  `txt6` TEXT,
  `txt7` TEXT,
  `txt8` TEXT
);