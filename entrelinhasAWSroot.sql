drop database entrelinhasdb;

create database entrelinhasdb;

use entrelinhasdb;

CREATE TABLE `materia` (
	`id_materia` bigint PRIMARY KEY AUTO_INCREMENT,
  `titulo_pag` VARCHAR(1000),
  `img` VARCHAR(1000),
  `txt1` TEXT,
  `txt2` TEXT,
  `txt3` TEXT
);

CREATE TABLE `pratica` (
	`id_pratica` bigint PRIMARY KEY AUTO_INCREMENT,
  `titulo_pag` VARCHAR(1000),
  `subtitulo_pag` VARCHAR(1000),
  `txt1` TEXT,
  `txt2` TEXT,
  `txt3` TEXT,
  `txt4` TEXT
);

CREATE TABLE `dica` (
	`id_dica` bigint PRIMARY KEY AUTO_INCREMENT,
  `titulo_pag` VARCHAR(1000),
  `txt1` TEXT,
  `txt2` TEXT,
  `txt3` TEXT,
  `txt4` TEXT,
	`txt5` TEXT,
  `txt6` TEXT,
  `txt7` TEXT,
  `txt8` TEXT
);

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
    `id_pedidos` bigint,
    `id_precificacao` bigint,
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
    `id_materia` bigint,
    `id_pratica` bigint,
    `id_dica` bigint,
	PRIMARY KEY (`id_atividades`), 
	FOREIGN KEY (id_conteudo) REFERENCES `conteudo`(id_conteudo),
    FOREIGN KEY (id_materia) REFERENCES `materia`(id_materia),
    FOREIGN KEY (id_pratica) REFERENCES `pratica`(id_pratica),
    FOREIGN KEY (id_dica) REFERENCES `dica`(id_dica)
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
	`senha` varchar(30),
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
	PRIMARY KEY (`id_usuario`), 
	FOREIGN KEY (id_plano) REFERENCES `plano`(id_plano),
	FOREIGN KEY (id_status) REFERENCES `status`(id_status)
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
	`progresso` FLOAT,
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
    `date` DATE,
	`title` varchar(255),
	`description` varchar(255),
    `nome` varchar(255),
	`quantidade` INT,
	`price` DECIMAL(10,2),
    `estado` varchar(255),
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

-- mudei a fk da conquista para usuario
CREATE TABLE `conquista` (
	`id_conquista` bigint AUTO_INCREMENT,
	`nome` varchar(255),
	`data_conquista` DATE,
	`id_usuario` bigint,
	PRIMARY KEY (`id_conquista`), 
	FOREIGN KEY (id_usuario) REFERENCES `usuario`(id_usuario)
);
-- mudei o nome da primary key para redeSocial e tirei troquei de id_link para link e de int para varchar(255)
CREATE TABLE `redes_sociais` (
	`id_rede_social` bigint AUTO_INCREMENT,
	`link` varchar(250),
	`id_usuario` bigint,
	PRIMARY KEY (`id_rede_social`),
	FOREIGN KEY (id_usuario) REFERENCES `usuario`(id_usuario)
);

CREATE TABLE `notificacao` (
	`id_notificacao` bigint AUTO_INCREMENT PRIMARY KEY,
	`nome_notificacao` varchar(255),
	`descricao` TEXT,
	`source` varchar(255),
  `id_usuario` bigint,
	FOREIGN KEY (id_usuario) REFERENCES `usuario`(id_usuario)
);

ALTER TABLE `entrelinhasdb`.`perfil` 
ADD COLUMN `foto` TEXT NULL AFTER `id_ferramentas`;
ALTER TABLE `ferramentas` ADD CONSTRAINT `ferramentas_fk0` FOREIGN KEY (`id_pedidos`) REFERENCES `pedidos`(`id_pedidos`);
ALTER TABLE `ferramentas` ADD CONSTRAINT `ferramentas_fk1` FOREIGN KEY (`id_precificacao`) REFERENCES `precificacao`(`id_precificacao`);

-- BASES para colocar os conteudos da trilha educacional

-- INSERT INTO dica (column1) VALUES (value1); -- considere o id
-- TOPICO 1 - MATERIA 1
INSERT INTO materia (id_materia, titulo_pag, img, txt1, txt2, txt3) VALUES (
1,
 "Pesquisando o Mercado: A importância da pesquisa de mercado para conhecer o seu negócio",
 "/1.1.jpg",
 "A pesquisa de mercado é essencial para conhecer o mercado, os clientes e os concorrentes, permitindo tomar decisões estratégicas embasadas. Ela fornece insights sobre o comportamento do consumidor, identifica oportunidades de negócio e auxilia no desenvolvimento de produtos e estratégias de marketing eficazes. Compreender o mercado de forma aprofundada é fundamental para o crescimento e a satisfação dos clientes.",
 "",
 ""), 
 
 (2,
 "Pesquisando o Mercado: Métodos e técnicas de pesquisa de mercado",
 "/1.1.jpg",
 "Existem diversas técnicas e métodos para realizar uma pesquisa de mercado eficaz. A escolha do método adequado depende dos objetivos, do orçamento e dos recursos disponíveis. Alguns métodos comuns são:\n
1 - Pesquisa quantitativa: Envolve a coleta de dados numéricos por meio de questionários estruturados ou pesquisas online. Esses dados são analisados estatisticamente para identificar padrões, tendências e relações entre as variáveis.\n
2- Pesquisa qualitativa: Baseia-se em entrevistas individuais, grupos focais ou observação direta. Esse método busca explorar as percepções, opiniões e experiências dos participantes, proporcionando uma compreensão mais aprofundada dos motivadores e preferências dos consumidores.\n
3- Pesquisa secundária: Consiste em utilizar dados e informações já disponíveis, como relatórios de mercado, estatísticas governamentais e pesquisas de outras empresas. Essa abordagem pode fornecer insights valiosos a um custo menor e em menos tempo.\n
Cada método tem suas vantagens e limitações, e a combinação de diferentes abordagens pode enriquecer a pesquisa, proporcionando uma visão abrangente do mercado e dos consumidores. A escolha dos métodos adequados é essencial para obter informações relevantes e embasar decisões estratégicas.
",
"",
""),
 
 (3,
 "Pesquisando o Mercado: Como interpretar os dados coletados e utilizá-los para tomar decisões estratégicas",
 "/1.1.jpg",
 "Após a coleta dos dados da pesquisa de mercado, é fundamental interpretá-los corretamente para extrair informações relevantes e usá-las na tomada de decisões estratégicas. Nesse processo, é importante considerar os seguintes pontos:\n
1 - Análise estatística: Para dados quantitativos, é essencial aplicar técnicas estatísticas, como identificar tendências, calcular médias, medianas, desvios padrão e realizar testes de significância. Essa análise proporcionará uma compreensão quantitativa dos dados coletados.\n
2- Análise qualitativa: Para dados qualitativos, é necessário realizar uma análise interpretativa. Isso envolve identificar temas, padrões e insights-chave presentes em respostas abertas, entrevistas ou grupos focais. A análise qualitativa auxilia na compreensão detalhada das motivações e comportamentos dos consumidores.\n
3- Utilização dos resultados: Com base na análise dos dados, é possível tomar decisões estratégicas embasadas. Isso inclui ajustar estratégias de marketing, desenvolver novos produtos ou serviços, identificar oportunidades de crescimento e estabelecer metas realistas para o negócio. Os resultados da pesquisa de mercado servem como guia para orientar as ações da empresa e aumentar suas chances de sucesso.
",
"",
""),
 
 (4,
 "Análise de Concorrência: Identificando os concorrentes diretos e indiretos",
 "/1.1.jpg",
 "Ao analisar a concorrência, é crucial identificar tanto os concorrentes diretos quanto os indiretos. Os concorrentes diretos oferecem produtos ou serviços similares e competem diretamente pela mesma base de clientes. Por outro lado, os concorrentes indiretos atendem às mesmas necessidades dos clientes, mesmo que de forma diferente. Identificar ambos os tipos de concorrentes proporciona uma visão mais ampla do mercado e permite compreender todas as opções disponíveis para os clientes.",
 "",
 ""),
 
 (5,
 "Análise de Concorrência: Avaliando o posicionamento e estratégias dos concorrentes",
 "/1.1.jpg",
 "Após identificar os concorrentes, é fundamental avaliar seu posicionamento e estratégias adotadas. Isso envolve analisar sua comunicação com o público, canais de distribuição, pontos fortes e fracos, preços, promoções e estratégias de marketing. Ao avaliar o posicionamento dos concorrentes, é possível identificar suas diferenciações no mercado e como são percebidos pelos clientes. Isso auxilia na identificação de oportunidades a serem exploradas e pontos fracos a serem aproveitados para obter vantagem competitiva.",
 "",
 ""),
 
  (6,
 "Análise de Concorrência: Como utilizar a análise de concorrência para identificar oportunidades e diferenciais competitivos",
 "/1.1.jpg",
 "A análise de concorrência é uma ferramenta poderosa para identificar oportunidades e criar diferenciais competitivos. Compreender as estratégias dos concorrentes permite encontrar áreas onde seu negócio pode se destacar e oferecer algo único aos clientes. Isso pode envolver aprimorar a qualidade do produto, oferecer um serviço excepcional, criar uma experiência de compra personalizada ou explorar um nicho de mercado específico. Além disso, a análise de concorrência ajuda a identificar lacunas no mercado, possibilitando o desenvolvimento de produtos ou serviços inovadores que atendam às necessidades não atendidas pelos concorrentes.",
"",
 ""),
 
 (7,
 "Segmentação de Mercado: O que é segmentação de mercado e por que é importante",
 "/1.1.jpg",
 "A segmentação de mercado é o processo de dividir um mercado amplo em grupos menores e mais específicos, chamados segmentos. Isso permite que as empresas direcionem seus esforços de marketing de forma mais eficiente e eficaz, reconhecendo as características e necessidades distintas de cada segmento. A importância da segmentação de mercado está na capacidade de identificar e compreender melhor o público-alvo, personalizando mensagens e ofertas de acordo com as preferências de cada grupo. Isso resulta em uma maior conexão com os clientes, aumentando a satisfação e lealdade.
",
 "",
 ""),

(8,
 "Segmentação de Mercado: Critérios de segmentação demográficos, psicográficos e comportamentais",
 "/1.1.jpg",
 "Existem critérios demográficos, psicográficos e comportamentais para segmentar o mercado. Os critérios demográficos consideram informações básicas como idade, sexo, renda e localização geográfica. Os critérios psicográficos incluem fatores subjetivos como personalidade, estilo de vida e valores. Já os critérios comportamentais analisam padrões de compra, lealdade à marca e outros comportamentos relacionados ao consumo. Esses critérios permitem entender melhor as necessidades e preferências dos consumidores, possibilitando a criação de estratégias de marketing mais direcionadas.",
 "",
 ""),

(9,
 "Segmentação de Mercado: Como identificar e atender às necessidades específicas de cada segmento",
 "/1.1.jpg",
 "Após identificar os segmentos de mercado, é crucial desenvolver estratégias para atender às suas necessidades específicas. Isso envolve conduzir pesquisas de mercado, coletar dados e obter insights relevantes sobre cada segmento. Personalizar a oferta de produtos e serviços, adaptando design, embalagem, comunicação de marketing e preços, é fundamental para atender às necessidades de cada segmento. É importante acompanhar as mudanças nas necessidades dos segmentos ao longo do tempo para garantir a satisfação e lealdade dos clientes.",
 "",
 ""),

-- TOPICO 2 - MATERIA 1
(10,
 "Definição do Público-Alvo: O que é o público-alvo e por que é importante conhecê-lo",
 "/1.2.jpg",
 "O público-alvo refere-se ao grupo de pessoas que são o foco principal das estratégias de marketing de uma empresa. Conhecê-lo é fundamental para o sucesso do negócio, pois permite direcionar esforços de forma mais eficiente e eficaz, garantindo que as mensagens e ofertas sejam relevantes e atrativas para o público certo.",
 "",
 ""),

(11,
 "Definição do Público-Alvo: Como definir o perfil do público-alvo",
 "/1.2.jpg",
 "Definir o perfil do público-alvo envolve a criação de uma descrição detalhada das características demográficas, psicográficas e comportamentais desse grupo. Essas informações ajudam a entender quem são os consumidores ideais, seus interesses, necessidades, desejos, comportamentos de compra e preferências. Com base nesse perfil, é possível personalizar estratégias de marketing e desenvolver produtos e serviços que atendam às suas demandas específicas.",
 "",
 ""
 ),

(12,
 "Definição do Público-Alvo: Ferramentas e técnicas para identificar e compreender o público-alvo",
 "/1.2.jpg",
 "Existem diversas ferramentas e técnicas para identificar e compreender o público-alvo. Pesquisas de mercado, análise de dados demográficos e comportamentais, além do uso de dados online, como comportamento de navegação e interações em redes sociais, são eficazes nesse processo. A criação de personas também é útil para visualizar e segmentar o público-alvo de forma mais precisa. Observar o comportamento do consumidor, incluindo seus hábitos de compra e interações com a marca, fornece insights valiosos para adaptar as estratégias de marketing. Essas abordagens auxiliam na criação de estratégias direcionadas e na entrega de uma experiência mais satisfatória aos consumidores.
",
 "",
 ""
 ),

(13,
 "Comportamento do Consumidor: Fatores que influenciam o comportamento do consumido",
 "/1.2.jpg",
 "O comportamento do consumidor é influenciado por uma variedade de fatores que podem afetar suas decisões de compra. Esses fatores podem ser divididos em fatores internos, como necessidades, desejos, percepções e atitudes, e fatores externos, como cultura, sociedade, grupos de referência, influências familiares, econômicas e tecnológicas.",
 "",
 ""
 ),

(14,
 "Comportamento do Consumidor: O processo de tomada de decisão do consumidor",
 "/1.2.jpg",
 "O processo de tomada de decisão do consumidor é o conjunto de etapas que um indivíduo passa ao tomar uma decisão de compra. Esse processo geralmente envolve cinco etapas: reconhecimento do problema ou necessidade, busca por informações, avaliação de alternativas, decisão de compra e avaliação pós-compra. Durante cada etapa, o consumidor é influenciado por diversos fatores, como percepções, emoções, conhecimento, experiências anteriores e influências sociais.
",
 "",
 ""
 ),

(15,
 "Comportamento do Consumidor: Como utilizar o conhecimento do comportamento do consumidor para criar estratégias eficazes",
 "/1.2.jpg",
 "O conhecimento do comportamento do consumidor é fundamental para criar estratégias de marketing eficazes. Ao compreender as necessidades, desejos e motivações dos consumidores, as empresas podem segmentar o mercado, direcionar mensagens e ofertas específicas, desenvolver produtos adequados e proporcionar experiências personalizadas. Além disso, esse conhecimento permite antecipar tendências e identificar oportunidades de mercado, proporcionando uma vantagem competitiva. Em resumo, entender o comportamento do consumidor é essencial para o sucesso das estratégias de marketing.",
 "",
 ""
 ),

(16,
 "Persona do Cliente: O que é uma persona e como criar uma persona do cliente",
 "/1.2.jpg",
 "Uma persona é um perfil fictício que representa um segmento específico do público-alvo de uma empresa. Ela é criada com base em dados demográficos, comportamentais, psicográficos e preferências do cliente. Para criar uma persona do cliente, é necessário realizar pesquisas de mercado, coletar informações relevantes e criar uma descrição detalhada do perfil do cliente ideal.\n
Para desenvolver uma persona, é preciso considerar elementos como idade, sexo, profissão, interesses, desafios, objetivos, preferências de compra e comportamentos de consumo. Essas informações ajudam a humanizar e visualizar o público-alvo, permitindo que as empresas compreendam melhor seus clientes e criem estratégias direcionadas.
",
 "",
 ""
 ),

(17,
 "Persona do Cliente: Benefícios de ter personas bem definidas",
 "/1.2.jpg",
 "Ter personas bem definidas traz diversos benefícios para as empresas. Em primeiro lugar, as personas permitem uma segmentação mais precisa do mercado, direcionando as estratégias de marketing de forma eficiente. Com personas claras, as empresas podem personalizar mensagens e campanhas, tornando-as mais relevantes para cada segmento do público-alvo. Isso aumenta a conexão com os clientes, melhorando o engajamento e a eficácia das ações de marketing.\n
Além disso, as personas ajudam a empresa a entender as necessidades e desejos dos clientes de maneira mais profunda. Ao conhecer as características, preferências e motivações de cada persona, as empresas podem desenvolver produtos ou serviços que atendam a essas necessidades específicas. Isso resulta em uma oferta mais alinhada com as expectativas dos consumidores, aumentando as chances de sucesso no mercado.
",
 "",
 ""
 ),
 
(18,
 "Persona do Cliente: Como utilizar personas na criação de campanhas de marketing e no desenvolvimento de produtos",
 "/1.2.jpg",
 "As personas também são valiosas no desenvolvimento de campanhas de marketing. Com base nas características e preferências de cada persona, as empresas podem criar mensagens persuasivas e direcionadas, escolher os canais de comunicação mais adequados e selecionar os pontos de contato que melhor alcançam cada segmento do público-alvo. Isso melhora a eficácia das campanhas, aumentando o envolvimento dos clientes e impulsionando os resultados de marketing.\n
No desenvolvimento de produtos, as personas são úteis para orientar as decisões de design, funcionalidades e usabilidade. Com base nas necessidades e preferências das personas, as empresas podem criar produtos que atendam às demandas específicas de cada segmento do público-alvo. Isso resulta em produtos mais relevantes, aumentando a satisfação dos clientes e a competitividade da empresa.
",
 "",
 ""
 ),
 
 -- TOPICO 3 - MATERIA 1
 (19,
 "Introdução à Análise SWOT: O que é a análise de swot?",
 "/1.3.jpg",
 "A análise SWOT é uma ferramenta de gestão que permite uma compreensão abrangente da situação de uma empresa, projeto ou ideia de negócio. Ela é composta por quatro elementos-chave: forças, fraquezas, oportunidades e ameaças.",
 "",
 ""
 ),

 (20,
 "Introdução à Análise SWOT: O que faz a análise de swot?",
 "/1.3.jpg",
 "É importante ressaltar que a análise SWOT é um ponto de partida e deve ser complementada com outras ferramentas e análises mais aprofundadas. Por exemplo, a análise do ambiente externo, a análise do mercado e a pesquisa de mercado podem fornecer informações adicionais para embasar as decisões estratégicas.",
 "",
 ""
 ),

 (21,
 "Introdução à Análise SWOT: Adaptando Estratégias para o Sucesso Contínuo",
 "/1.3.jpg",
 "Além disso, a análise SWOT não é um processo único e estático. Ela deve ser revisada e atualizada regularmente, uma vez que as circunstâncias internas e externas estão sujeitas a mudanças constantes. Manter-se atualizado e adaptar as estratégias de acordo com as mudanças do ambiente é fundamental para o sucesso contínuo da organização. Em suma, a análise SWOT é uma ferramenta valiosa para empresas e organizações que desejam ter uma visão clara de sua situação atual e tomar decisões estratégicas fundamentadas. Ao identificar as forças, fraquezas, oportunidades e ameaças, as empresas podem capitalizar seus pontos fortes, melhorar suas fraquezas, aproveitar oportunidades e enfrentar ameaças de maneira mais eficaz, fortalecendo sua posição no mercado e impulsionando seu sucesso.
",
 "",
 ""
 ),
 
  (22,
 "Identificando Forças e Fraquezas: Potencializando Vantagens Competitivas e Reputação da Organização",
 "/1.3.jpg",
 "As forças referem-se aos aspectos internos positivos da organização, como recursos tangíveis e intangíveis, habilidades e conhecimentos, vantagens competitivas e reputação. Identificar as forças é importante para capitalizar-las e utilizá-las como diferenciais no mercado",
 "",
 ""
 ), 

 (23,
 "Identificando Forças e Fraquezas: Fortalecendo a Posição Competitiva da Organização",
 "/1.3.jpg",
 "As fraquezas, por sua vez, são os aspectos internos negativos que podem afetar o desempenho da organização. Podem incluir falta de recursos, deficiências operacionais, baixa qualidade de produtos ou serviços, ou até mesmo falta de reconhecimento da marca. Identificar e abordar as fraquezas é essencial para melhorar a posição competitiva da empresa
",
 "",
 ""
 ), 

 (24,
 "Identificando Forças e Fraquezas: Potencializando o Desempenho e Posicionamento no Mercado",
 "/1.3.jpg",
 "Em resumo, as forças referem-se aos aspectos internos positivos da organização, como recursos, habilidades, vantagens competitivas e reputação. Identificar essas forças é fundamental, pois elas podem ser capitalizadas e usadas como diferenciais no mercado, fortalecendo a posição da empresa e impulsionando seu desempenho.",
 "",
 ""
 ), 

 (25,
 "Identificando Oportunidades e Ameaças: Aproveitando as Oportunidades Externas: Impulsionando o Crescimento e Sucesso Organizacional",
 "/1.3.jpg",
 "As oportunidades são fatores externos positivos que podem ser aproveitados para impulsionar o crescimento e o sucesso da organização. Elas podem surgir de mudanças no mercado, avanços tecnológicos, demanda crescente, novos segmentos de mercado ou parcerias estratégicas. Identificar as oportunidades é crucial para direcionar os esforços da empresa e aproveitar os benefícios do ambiente externo.
",
 "",
 ""
 ), 

 (26,
 "Identificando Oportunidades e Ameaças: Navegando pelas Ameaças Externas: Estratégias para Mitigar Riscos e Desafios Organizacionais",
 "/1.3.jpg",
 "Por fim, as ameaças são fatores externos negativos que podem representar riscos e desafios para a organização. Isso pode incluir a concorrência acirrada, mudanças nas preferências do consumidor, avanços tecnológicos disruptivos, instabilidade econômica ou mudanças regulatórias. Identificar as ameaças permite que a empresa esteja preparada e desenvolva estratégias para mitigar seus impactos negativos.",
 "",
 ""
 ), 

 (27,
 "Identificando Oportunidades e Ameaças: Aproveitando as Oportunidades Externas: Impulsionando o Crescimento e Vantagem Competitiva da Organização",
 "/1.3.jpg",
 "Em resumo, as oportunidades são fatores externos positivos que podem impulsionar o crescimento e o sucesso da organização. Elas surgem de mudanças no mercado, avanços tecnológicos, demanda crescente, novos segmentos de mercado ou parcerias estratégicas. Identificar essas oportunidades é crucial, pois direciona os esforços da empresa para aproveitar os benefícios do ambiente externo e buscar vantagens competitivas.",
 "",
 ""
 ), 

-- TOPICO 4 - MATERIA 1
 (28,
 "Análise de viabilidade econômica: Avaliação dos custos, investimentos e projeção de receitas para um negócio",
 "/1.4.jpg",
 "A análise de viabilidade econômica é uma etapa crucial no processo de avaliação de um negócio. Ela envolve a avaliação dos custos e investimentos necessários para iniciar o negócio, bem como a projeção de receitas e lucros potenciais.\n
Uma parte fundamental dessa análise é a identificação e quantificação de todos os custos envolvidos na operação do negócio, como custos de produção, custos fixos (aluguel, salários, despesas gerais), custos de marketing e publicidade, entre outros. Essa avaliação permite ter uma visão clara dos investimentos necessários para iniciar e operar o negócio.
",
 "",
 ""
 ), 

  (29,
 "Avaliação de viabilidade econômica: Projeção de receitas, ponto de equilíbrio e análise de sensibilidade para o sucesso do negócio",
 "/1.4.jpg",
 "Além disso, é importante projetar as receitas potenciais com base em uma análise realista do mercado e das estratégias de precificação. Essa projeção envolve estimar o volume de vendas e o preço médio do produto ou serviço oferecido. A partir dessas informações, é possível calcular os lucros potenciais e identificar a viabilidade financeira do negócio.\n
Outro aspecto relevante da análise de viabilidade econômica é o cálculo do ponto de equilíbrio, que representa o volume de vendas necessário para cobrir todos os custos e despesas e atingir o ponto em que o negócio começa a gerar lucro. Além disso, a análise de sensibilidade permite avaliar o impacto de variações nos custos, preços ou volume de vendas na viabilidade econômica do negócio.
",
 "",
 ""
 ), 

  (30,
 "Análise de Viabilidade Econômica: Avaliação Completa para Decisões Estratégicas",
 "/1.4.jpg",
 "Em resumo, a análise de viabilidade econômica envolve a avaliação dos custos e investimentos necessários, a projeção de receitas e lucros potenciais, o cálculo do ponto de equilíbrio e a análise de sensibilidade. Esses elementos fornecem uma visão abrangente da viabilidade financeira do negócio e auxiliam na tomada de decisões estratégicas.",
 "",
 ""
 ), 

  (31,
 "Análise de Viabilidade Mercadológica: Avaliando o Potencial de Sucesso no Mercado",
 "/1.4.jpg",
 "A análise de viabilidade mercadológica é uma etapa essencial para avaliar se um negócio tem potencial de sucesso no mercado. Ela envolve a avaliação do tamanho do mercado, da demanda pelo produto ou serviço, da concorrência e dos diferenciais competitivos.\n
A primeira etapa dessa análise é avaliar o tamanho do mercado e a demanda existente. Isso envolve identificar o público-alvo, segmentar o mercado e estimar a demanda atual e futura. Com base nessas informações, é possível avaliar se há espaço para a entrada do negócio e se existe demanda suficiente para sustentá-lo.\n
Além disso, é importante analisar a concorrência e identificar os principais concorrentes diretos e indiretos. Isso envolve identificar seus pontos fortes, fraquezas e estratégias de mercado. Compreender a concorrência permite identificar oportunidades de diferenciação e definir os pontos únicos de venda do negócio.
",
 "",
 ""
 ), 

(32, 
"Análise de Viabilidade Mercadológica: Identificando Diferenciais Competitivos e Potencial de Crescimento",
"/1.4.jpg",
"Os diferenciais competitivos são fatores que tornam o produto ou serviço oferecido único e atraente para os clientes. Eles podem incluir características exclusivas, qualidade superior, atendimento personalizado, preços competitivos ou uma proposta de valor diferenciada. Identificar e destacar esses diferenciais é fundamental para se destacar no mercado e conquistar clientes.\n
A estimativa da participação de mercado e do potencial de crescimento é outro aspecto importante na análise de viabilidade mercadológica. Isso envolve analisar a fatia de mercado que o negócio pode alcançar e identificar oportunidades de expansão e crescimento. Essa análise ajuda a determinar se o negócio tem espaço para se consolidar e prosperar no mercado.
",
"",
""), 

 (33,
 "Análise de Viabilidade Mercadológica: Determinando Oportunidades e Viabilidade no Mercado",
 "/1.4.jpg",
 "Em resumo, a análise de viabilidade mercadológica envolve a avaliação do tamanho do mercado e da demanda, a análise da concorrência e dos diferenciais competitivos, e a estimativa da participação de mercado e do potencial de crescimento. Esses elementos são fundamentais para determinar se o negócio tem viabilidade e se há oportunidades de sucesso no mercado.",
 "",
 ""
 ),

 (34,
 "Análise de Viabilidade Operacional: Avaliando Recursos e Desafios para uma Operação Eficiente.",
 "/1.4.jpg",
 "A análise de viabilidade operacional é uma etapa essencial na avaliação de um negócio, pois envolve a análise dos recursos necessários, dos processos operacionais e da identificação de possíveis desafios e soluções operacionais.\n
Avaliar os recursos necessários é fundamental para garantir que o negócio tenha os recursos adequados para operar de forma eficiente. Isso envolve identificar e dimensionar os recursos humanos, como mão de obra qualificada, equipe de gestão e especialistas técnicos. Além disso, é importante considerar os recursos físicos, como equipamentos, instalações e infraestrutura necessários para o funcionamento do negócio. Também é preciso avaliar os recursos financeiros disponíveis para cobrir os custos operacionais.
",
 "",
 ""
 ),

  (35,
 "Análise de Viabilidade Operacional: Mapeando Processos, Identificando Desafios e Desenvolvendo Soluções Eficientes.",
 "/1.4.jpg",
 "A análise dos processos operacionais e logísticos é outro aspecto importante na viabilidade operacional. Isso envolve mapear e analisar todas as etapas do processo de produção ou prestação de serviços, desde o recebimento de matéria-prima até a entrega final ao cliente. Identificar possíveis gargalos, ineficiências ou áreas de melhoria nos processos é fundamental para garantir uma operação eficiente e com qualidade.\n
Além disso, é necessário identificar possíveis desafios operacionais que possam surgir no decorrer das atividades do negócio. Isso pode incluir questões relacionadas a fornecedores, logística, capacidade de produção, gerenciamento de estoque, entre outros. A análise desses desafios permite antecipar problemas e desenvolver soluções operacionais eficazes para superá-los.
",
 "",
 ""
 ),

  (36,
 "Análise de Viabilidade Operacional: Garantindo Recursos, Eficiência e Soluções Operacionais.",
 "/1.4.jpg",
 "Em resumo, a análise de viabilidade operacional envolve a avaliação dos recursos necessários, a análise dos processos operacionais e logísticos, e a identificação de possíveis desafios e soluções operacionais. Esses elementos são essenciais para garantir que o negócio possua os recursos adequados, opere de forma eficiente e esteja preparado para enfrentar os desafios operacionais que possam surgir.",
 "",
 ""
 ),
 
 -- Topico 1 - Materia 2
 (37,
 "Importância da Coleta de Informações Pessoais para Conhecer o Cliente: Papel fundamental da coleta de informações pessoais na compreensão do cliente",
 "/2.1.jpg",
 "A coleta de informações pessoais desempenha um papel fundamental na compreensão do seu cliente. Essas informações abrangem aspectos como nome, idade, profissão, interesses e preferências. No entanto, é crucial garantir que esses dados sejam obtidos de forma ética e transparente, respeitando a privacidade do cliente.
",
 "",
 ""
 ),

 (38,
 "Importância da Coleta de Informações Pessoais para Conhecer o Cliente: O poder dos dados pessoais na personalização de soluções e fortalecimento de relacionamentos",
 "/2.1.jpg",
 "Ao coletar informações pessoais, você pode criar um retrato mais completo e detalhado do seu cliente. Esses dados permitem que você entenda melhor suas características individuais, suas necessidades e seus desejos. Dessa forma, você pode oferecer soluções mais personalizadas e direcionadas, aumentando a satisfação do cliente e fortalecendo o relacionamento com ele.",
 "",
 ""
 ),

 (39,
 "Importância da Coleta de Informações Pessoais para Conhecer o Cliente: Aprimoramento de produtos e serviços através da análise de dados pessoais: competitividade e segurança em foco",
 "/2.1.jpg",
 "Além disso, a coleta de informações pessoais também pode auxiliar no aprimoramento contínuo de produtos e serviços. Ao analisar os dados coletados, é possível identificar padrões e tendências que podem fornecer insights valiosos para o desenvolvimento de novas ofertas e melhorias nos produtos existentes. Com base nas preferências e interesses dos clientes, é possível antecipar suas necessidades futuras e adaptar as estratégias de negócios de forma proativa, aumentando a competitividade no mercado. No entanto, é importante lembrar que a segurança dos dados pessoais deve ser uma prioridade, com a implementação de medidas de proteção e conformidade com as leis e regulamentações de privacidade de dados. A transparência na coleta e uso dessas informações é essencial para garantir a confiança do cliente e promover relacionamentos duradouros com a marca.
",
 "",
 ""
 ),

(40,
 "Criando Perfis de Clientes Através da Coleta de Informações Pessoais: A coleta de informações pessoais para a criação de perfis de clientes: compreensão aprofundada e segmentação precisa",
 "/2.1.jpg",
 "A coleta de informações pessoais possibilita a criação de perfis de clientes que contribuem para uma compreensão mais aprofundada de suas necessidades. Esses perfis podem ser construídos por meio de diferentes métodos, como formulários, entrevistas ou análise de dados de compras anteriores.",
 "",
 ""
 ),

 (41,
 "Criando Perfis de Clientes Através da Coleta de Informações Pessoais: Personalização e engajamento: estratégias eficazes baseadas em perfis de clientes",
 "/2.1.jpg",
 "Ao construir perfis de clientes, você reúne informações relevantes sobre eles, como preferências de produtos, comportamentos de compra, motivações e desafios. Esses perfis permitem que você segmente seu público-alvo de forma mais precisa e crie estratégias de marketing mais eficazes. Com base nesses perfis, é possível personalizar suas abordagens, conteúdos e ofertas, aumentando as chances de engajamento e conversão.",
 "",
 ""
 ),

 (42,
 "Criando Perfis de Clientes Através da Coleta de Informações Pessoais: Personalização e engajamento: estratégias eficazes baseadas em perfis de clientes",
 "/2.1.jpg",
 "Ao construir perfis de clientes, você reúne informações relevantes sobre eles, como preferências de produtos, comportamentos de compra, motivações e desafios. Esses perfis permitem que você segmente seu público-alvo de forma mais precisa e crie estratégias de marketing mais eficazes. Com base nesses perfis, é possível personalizar suas abordagens, conteúdos e ofertas, aumentando as chances de engajamento e conversão.",
 "",
 ""
 ),

 (43,
 "Criando Perfis de Clientes Através da Coleta de Informações Pessoais: Estabelecendo relacionamentos personalizados: fidelização e lealdade através da criação de perfis de clientes",
 "/2.1.jpg",
 "Além disso, a criação de perfis de clientes também oferece a oportunidade de estabelecer um relacionamento mais próximo e personalizado com cada indivíduo. Com base nas informações coletadas, você pode desenvolver estratégias de fidelização, como programas de recompensas, promoções exclusivas ou recomendações personalizadas. Essas ações demonstram aos clientes que você valoriza suas preferências e está comprometido em atender às suas necessidades específicas, fortalecendo assim a lealdade à sua marca.",
 "",
 ""
 ),

 (44,
 "Ampliando a Coleta de Informações para Melhorar a Segmentação e Personalização Estabelecendo relacionamentos personalizados: Coleta de dados demográficos: segmentação precisa para estratégias personalizadas",
 "/2.1.jpg",
 "Ao aprimorar suas estratégias de marketing, é essencial considerar a coleta de dados demográficos em conjunto com as informações básicas do seu público. Esses dados adicionais, como idade, gênero, renda e localização geográfica, fornecem insights valiosos para segmentar seu público de acordo com características específicas. Com a segmentação precisa dos dados demográficos, você pode adaptar suas mensagens, conteúdos e abordagens de marketing para cada grupo demográfico. Isso resulta em estratégias personalizadas que são mais relevantes e eficazes para atender às necessidades e preferências específicas de cada segmento.
",
 "",
 ""
 ),

 (45,
 "Ampliando a Coleta de Informações para Melhorar a Segmentação e Personalização Estabelecendo relacionamentos personalizados: Dados comportamentais: insights valiosos para a personalização das ofertas",
 "/2.1.jpg",
 "Além da coleta de dados demográficos, os dados comportamentais são fundamentais para aprimorar suas estratégias de marketing. Ao analisar o histórico de compras, interações online e preferências de produtos, você obtém insights valiosos sobre o comportamento do cliente. Esses dados permitem entender quais são os produtos ou serviços mais populares, quais são os momentos ideais para oferecer promoções e descontos, e quais são as preferências de compra e comunicação de cada cliente. Com base nesses insights, você pode personalizar suas ofertas de forma mais precisa, direcionando recomendações relevantes e criando campanhas mais segmentadas.
",
 "",
 ""
 ),

 (46,
 "Ampliando a Coleta de Informações para Melhorar a Segmentação e Personalização Estabelecendo relacionamentos personalizados: Ampliando a coleta de informações: aprimorando a segmentação e relevância das campanhas",
 "/2.1.jpg",
 "Para maximizar a eficácia das suas estratégias de marketing, é importante ampliar a coleta de informações demográficas e comportamentais. A coleta contínua desses dados permite uma segmentação mais refinada e personalização das suas campanhas. Com dados demográficos e comportamentais atualizados, você pode acompanhar as mudanças nas preferências e necessidades do seu público ao longo do tempo. Isso garante que suas estratégias permaneçam relevantes e eficazes, direcionando mensagens mais impactantes e aumentando as chances de engajamento e conversão. A ampliação da coleta de informações possibilita uma abordagem mais direcionada e segmentada, impulsionando os resultados de marketing de forma significativa.
",
 "",
 ""
 ),
 
 -- Topico 2 - Materia 2

 (47,
 "Compreendendo as Necessidades e Desejos do Cliente: A Chave para Agregar Valor: Compreendendo as necessidades do cliente através de pesquisas e feedbacks",
 "/2.1.jpg",
 "Compreender as necessidades e desejos do seu cliente é essencial para oferecer produtos ou serviços de valor. Para alcançar essa compreensão, é importante realizar pesquisas de mercado, acompanhar tendências e, acima de tudo, ouvir atentamente o feedback dos clientes. As pesquisas de mercado fornecem insights valiosos sobre o que seu público-alvo procura em termos de soluções e experiências. Além disso, o feedback direto dos clientes oferece informações precisas sobre suas necessidades e desejos atuais. É por meio dessas ações que você pode identificar expectativas, desafios e preferências, fundamentais para direcionar suas estratégias de negócio.
 ",
 "",
 ""
 ),

 (48,
 "Compreendendo as Necessidades e Desejos do Cliente: A Chave para Agregar Valor: A importância do feedback dos clientes para a melhoria contínua",
 "/2.2.jpg",
 "Ao estar aberto ao feedback dos clientes, você tem a oportunidade de compreender suas experiências, desafios e preferências. Ouvir atentamente o que eles têm a dizer revela insights inestimáveis sobre o que está funcionando bem em seu negócio e onde podem ser feitas melhorias. O feedback dos clientes pode ser obtido por meio de várias fontes, como pesquisas de satisfação, avaliações online, interações nas redes sociais ou até mesmo conversas pessoais. Essas informações diretas dos clientes são valiosas para ajustar sua oferta e direcionar seus esforços para atender às necessidades e desejos em constante mudança do seu público.
 ",
 "",
 ""
 ),

(49,
 "Comunicação Clara e Aberta para Identificar Necessidades Não Atendidas: Estabelecendo uma comunicação aberta com os clientes para obter insights valiosos
",
 "/2.2.jpg",
 "Uma comunicação clara e aberta com os clientes desempenha um papel crucial no entendimento de suas necessidades. Além de coletar informações, é importante criar um ambiente onde os clientes se sintam à vontade para expressar suas opiniões. Isso pode ser alcançado através da realização de perguntas abertas, que incentivam respostas detalhadas e genuínas. Ao criar espaço para o feedback dos clientes e estar disponível para responder a perguntas e resolver problemas, você demonstra um compromisso em ouvir ativamente e compreender suas necessidades não atendidas.
 ",
 "",
 ""
 ),

 (50,
 "Comunicação Clara e Aberta para Identificar Necessidades Não Atendidas: A importância de ouvir ativamente o feedback dos clientes",
 "/2.2.jpg",
 "A comunicação aberta e receptiva é uma oportunidade valiosa para ouvir ativamente o que os clientes têm a dizer. Durante essas interações, os clientes podem expressar desejos não atendidos, insatisfações com produtos ou serviços existentes e até mesmo fornecer ideias inovadoras. Ao demonstrar um interesse genuíno pelas opiniões dos clientes e responder de maneira proativa, você mostra que valoriza o seu feedback. Essa abordagem permite identificar oportunidades de melhoria e oferecer soluções que atendam às necessidades não atendidas dos clientes, fortalecendo assim o relacionamento com eles.
 ",
 "",
 ""
 ),

 (51,
 "Comunicação Clara e Aberta para Identificar Necessidades Não Atendidas: Transformando feedback em oportunidades de melhoria",
 "/2.2.jpg",
 "Ao estabelecer uma comunicação aberta e receptiva com os clientes, você pode transformar o feedback recebido em oportunidades de melhoria. Ouvir ativamente o que os clientes têm a dizer ajuda a identificar áreas onde seus produtos ou serviços podem ser aprimorados. Ao demonstrar uma resposta proativa e resolver as preocupações dos clientes, você mostra que valoriza a sua satisfação. Além disso, ao utilizar essas informações para fazer ajustes e inovações, você pode atender às necessidades não atendidas dos clientes e criar soluções que superem suas expectativas. Dessa forma, a comunicação aberta e receptiva se torna uma poderosa ferramenta para fortalecer o relacionamento com os clientes e impulsionar o crescimento do seu negócio.
 ",
 "",
 ""
 ),

 (52,
 "Utilizando Personas para Personalizar as Estratégias de Marketing: Compreendendo os clientes por meio das personas",
 "/2.2.jpg",
 "Uma maneira eficaz de compreender as necessidades e desejos dos clientes é criar personas. As personas são representações fictícias de clientes ideais, baseadas em dados reais sobre suas características e comportamentos. Elas ajudam a ter uma visão mais clara das motivações, desafios e preferências dos clientes, facilitando a personalização das estratégias de marketing.
 ",
 "",
 ""
 ),

 (53,
 "Utilizando Personas para Personalizar as Estratégias de Marketing: Criando perfis detalhados com personas",
 "/2.2.jpg",
 "Ao desenvolver personas, você cria perfis detalhados de diferentes tipos de clientes que representam segmentos específicos do seu público-alvo. Essas personas ajudam a visualizar e entender melhor as necessidades, desejos e comportamentos dos clientes. Com base nessas informações, é possível adaptar as mensagens, abordagens e ofertas de acordo com cada persona, resultando em estratégias de marketing mais direcionadas, relevantes e eficazes.
 ",
 "",
 ""
 ),

 (54,
 "Utilizando Personas para Personalizar as Estratégias de Marketing: Estratégias de marketing personalizadas para o sucesso",
 "/2.2.jpg",
 "Ao utilizar as personas como guias, você pode direcionar suas estratégias de marketing de forma mais personalizada. Compreender as motivações e desafios de cada persona permite criar mensagens e abordagens que se conectem de maneira significativa com seus clientes. Essa personalização gera maior relevância e engajamento, aumentando as chances de sucesso em suas campanhas e fortalecendo o relacionamento com o público-alvo.
 ",
 "",
 ""
 ),

 -- Topico 3 - Materia 2

(55,
 "Monitorando e Antecipando as Necessidades dos Clientes: A Importância da Análise do Comportamento: Compreendendo as preferências dos clientes através da análise do comportamento",
 "/2.3.jpg",
 "Entender as preferências e interações dos consumidores é essencial para o sucesso de qualquer negócio. Por meio da análise do comportamento do cliente, utilizando ferramentas de análise de dados, é possível acompanhar sua jornada e identificar padrões que revelam suas necessidades futuras. Essa análise proporciona insights valiosos sobre as preferências, interesses e comportamentos de compra dos clientes.
 ",
 "",
 ""
 ),

 (56,
 "Monitorando e Antecipando as Necessidades dos Clientes: A Importância da Análise do Comportamento: Personalizando ofertas e experiências com base na análise do comportamento",
 "/2.3.jpg",
 "Ao monitorar as interações dos clientes, é possível obter informações importantes para personalizar ofertas e aprimorar a experiência do cliente. Compreender suas preferências e comportamentos de compra possibilita que a empresa atenda às suas necessidades de forma mais eficiente e eficaz. Utilizando esses insights, é possível adaptar as estratégias de marketing e oferecer soluções que se alinhem com as expectativas dos clientes.
 ",
 "",
 ""
 ),

 (57,
 "Monitorando e Antecipando as Necessidades dos Clientes: A Importância da Análise do Comportamento:  Identificando oportunidades de melhoria com a análise do comportamento",
 "/2.3.jpg",
 "A análise do comportamento do cliente também desempenha um papel crucial na identificação de pontos de melhoria nos processos de vendas e atendimento ao cliente. Ao compreender como os clientes interagem com a empresa, é possível otimizar as estratégias de marketing e vendas, direcionando recursos para as áreas mais impactantes. Essa análise permite identificar oportunidades de aprimoramento, aperfeiçoar a comunicação com os clientes e aprimorar a eficiência dos processos internos.
 ",
 "",
 ""
 ),

 (58,
 "Aproveitando Oportunidades de Venda e Aumentando a Satisfação do Cliente: Identificando oportunidades de venda cruzada e upselling através da análise do comportamento",
 "/2.3.jpg",
 "A análise do comportamento do cliente permite identificar oportunidades de venda cruzada e upselling, estratégias que podem beneficiar tanto a empresa quanto o cliente. Ao compreender as preferências e histórico de compras do cliente, a empresa pode oferecer produtos ou serviços complementares aos itens já adquiridos. Essa abordagem inteligente aumenta a satisfação do cliente, oferecendo soluções mais abrangentes e relevantes, ao mesmo tempo em que contribui para o crescimento dos negócios.
 ",
 "",
 ""
 ),

 (59,
 "Aproveitando Oportunidades de Venda e Aumentando a Satisfação do Cliente:  Personalizando a experiência de compra com base no comportamento do cliente",
 "/2.3.jpg",
 "Ao sugerir produtos ou serviços relevantes com base no comportamento do cliente, a empresa cria uma experiência de compra personalizada e sob medida. Essa abordagem proativa demonstra um entendimento profundo das necessidades do cliente e mostra que a empresa se preocupa em oferecer soluções que realmente atendam às suas necessidades. Além de impulsionar o crescimento dos negócios, essa personalização fortalece o relacionamento de longo prazo com os clientes, criando vínculos de confiança e fidelidade.
 ",
 "",
 ""
 ),

 (60,
 "Aproveitando Oportunidades de Venda e Aumentando a Satisfação do Cliente: Aumentando o valor médio de cada transação com venda cruzada e upselling",
 "/2.3.jpg",
 "Ao aproveitar as oportunidades de venda cruzada e upselling, a empresa pode aumentar o valor médio de cada transação. Oferecer produtos ou serviços adicionais relevantes para o cliente não apenas aumenta a satisfação do cliente, mas também contribui para o crescimento financeiro da empresa. Essa estratégia inteligente permite maximizar o potencial de cada interação com o cliente, agregando valor às suas compras e proporcionando uma experiência de compra mais completa.
 ",
 "",
 ""
 ),

 (61,
 "Retendo Clientes e Fortalecendo Relacionamentos: Identificando clientes em risco de churn através da análise do comportamento",
 "/2.3.jpg",
 "A análise do comportamento do cliente desempenha um papel crucial na identificação de clientes que estão propensos a abandonar a empresa, também conhecido como churn. Ao analisar os dados comportamentais, é possível detectar sinais de insatisfação, redução de atividade ou mudanças de comportamento que indicam a possibilidade de perda desses clientes. Essa compreensão antecipada permite que a empresa adote medidas proativas para evitar o churn.
 ",
 "",
 ""
 ),

 (62,
 "Retendo Clientes e Fortalecendo Relacionamentos: Retendo clientes em risco de churn através de ações proativas",
 "/2.3.jpg",
 "Ao identificar os clientes em risco de churn, a empresa pode tomar medidas proativas para retê-los. Essas ações podem incluir oferecer descontos personalizados, melhorar o atendimento ao cliente, fornecer soluções para problemas identificados ou oferecer benefícios exclusivos. O objetivo principal é fortalecer o relacionamento com esses clientes, demonstrando cuidado e atenção às suas necessidades. Essa abordagem visa incentivá-los a permanecerem fiéis à marca e evitar a perda de clientes valiosos.
 ",
 "",
 ""
 ),

 (63,
 "Retendo Clientes e Fortalecendo Relacionamentos: Fortalecendo o relacionamento com os clientes",
 "/2.3.jpg",
 "Ao adotar medidas proativas para reter clientes em risco de churn, a empresa busca fortalecer o relacionamento com eles. Ações como oferecer descontos personalizados, melhorar o atendimento ao cliente e fornecer soluções para problemas demonstram cuidado e atenção às necessidades individuais dos clientes. Ao mostrar interesse genuíno em mantê-los satisfeitos, a empresa aumenta as chances de incentivá-los a permanecerem fiéis à marca. O objetivo é construir uma relação de confiança duradoura, reduzindo assim a possibilidade de churn e garantindo a fidelidade dos clientes.
 ",
 "",
 ""
 ),

 -- Topico 4 - Materia 2

 (64,
 "Construindo Canais de Comunicação Eficientes para o Feedback do Cliente: Estabelecendo canais de comunicação eficientes para coletar feedback valioso",
 "/2.4.jpg",
 "Para obter feedback contínuo do cliente, é crucial estabelecer canais de comunicação eficientes. Isso pode incluir pesquisas de satisfação, análise de comentários em redes sociais e um atendimento ao cliente de qualidade. Esses canais permitem que os clientes expressem suas opiniões e experiências, fornecendo informações valiosas que ajudam a empresa a melhorar seus produtos, serviços e processos.
 ",
 "",
 ""
 ),

 (65,
 "Construindo Canais de Comunicação Eficientes para o Feedback do Cliente: Promovendo transparência e fortalecendo o relacionamento com os clientes",
 "/2.4.jpg",
 "Ao disponibilizar diferentes formas para os clientes expressarem suas opiniões e experiências, a empresa demonstra um compromisso genuíno em ouvir e compreender suas necessidades. Isso cria um ambiente propício para o feedback honesto e construtivo. Além disso, promove a transparência e fortalece o relacionamento com os clientes, pois eles se sentem valorizados e envolvidos no processo de melhoria contínua da empresa.
 ",
 "",
 ""
 ),

 (66,
 "Construindo Canais de Comunicação Eficientes para o Feedback do Cliente: Utilizando o feedback para aprimorar produtos, serviços e processos",
 "/2.4.jpg",
 "O feedback coletado por meio dos canais de comunicação eficientes tem um papel fundamental no aprimoramento dos produtos, serviços e processos da empresa. As informações valiosas fornecidas pelos clientes permitem identificar áreas de melhoria e implementar as mudanças necessárias. Dessa forma, a empresa pode atender de forma mais precisa e eficiente às necessidades e expectativas dos clientes, garantindo sua satisfação e fidelidade.
 ",
 "",
 ""
 ),

 (67,
 "Agindo com Base no Feedback do Cliente para Melhorias Contínuas: Agindo com base no feedback para melhorar a experiência do cliente",
 "/2.4.jpg",
 "Coletar feedback dos clientes é apenas o primeiro passo. É importante agir com base nas informações recebidas e fazer os ajustes necessários para aprimorar a experiência do cliente. Mostrar aos clientes que suas opiniões são valorizadas e que a empresa está comprometida em oferecer a melhor experiência possível é essencial para o crescimento e sucesso do negócio.
 ",
 "",
 ""
 ),

 (68,
 "Agindo com Base no Feedback do Cliente para Melhorias Contínuas: Cultivando uma mentalidade de melhoria contínua",
 "/2.4.jpg",
 "Ao implementar mudanças com base no feedback do cliente, a empresa demonstra uma mentalidade de melhoria contínua. Isso significa que está sempre em busca de maneiras de aprimorar seus produtos, serviços e processos para atender cada vez melhor às necessidades e expectativas dos clientes. Essa abordagem cria uma cultura organizacional centrada no cliente e contribui para a satisfação geral.
 ",
 "",
 ""
 ),

 (69,
 "Agindo com Base no Feedback do Cliente para Melhorias Contínuas: Comunicando as mudanças aos clientes e reforçando o compromisso",
 "/2.4.jpg",
 "Além de implementar as mudanças, é importante comunicá-las aos clientes. Ao fazer isso, a empresa reforça seu compromisso em atender às necessidades e expectativas dos clientes. Isso mostra transparência e ajuda a fortalecer o relacionamento com os clientes, aumentando sua confiança na empresa. Com uma comunicação clara e efetiva, a empresa pode garantir que os clientes estejam cientes das melhorias e dos esforços contínuos para oferecer a melhor experiência possível.
 ",
 "",
 ""
 ),

 (70,
 "Utilizando Métricas de Desempenho para Avaliar a Satisfação e Fidelidade dos Clientes: Avaliando a satisfação e fidelidade dos clientes",
 "/2.4.jpg",
 "Utilizar métricas de desempenho, como o Net Promoter Score (NPS) e a Taxa de Retenção de Clientes, é uma forma eficaz de avaliar o nível de satisfação e fidelidade dos clientes. Essas métricas fornecem informações valiosas sobre a percepção dos clientes em relação à empresa, permitindo identificar áreas de melhoria e compreender como a empresa está performando em termos de satisfação e retenção de clientes.
 ",
 "",
 ""
 ),

 (71,
 "Utilizando Métricas de Desempenho para Avaliar a Satisfação e Fidelidade dos Clientes: Tomando medidas proativas para melhorar a experiência do cliente",
 "/2.4.jpg",
 "Ao monitorar regularmente essas métricas, a empresa pode identificar tendências e tomar medidas proativas para melhorar a experiência do cliente. Isso significa estar atento aos indicadores de satisfação e fidelidade dos clientes e agir de forma ágil para corrigir possíveis problemas e atender às necessidades dos clientes. O acompanhamento contínuo dessas métricas permite um ajuste constante das estratégias e a implementação de melhorias para proporcionar uma experiência cada vez melhor.
 ",
 "",
 ""
 ),

 (72,
 "Utilizando Métricas de Desempenho para Avaliar a Satisfação e Fidelidade dos Clientes: Estratégias de retenção e fidelização baseadas em dados",
 "/2.4.jpg",
 "Ao utilizar métricas de desempenho, a empresa pode definir estratégias de retenção e fidelização embasadas em dados concretos. Com base nas informações obtidas, é possível identificar os pontos fortes e fracos da experiência do cliente, implementar ações corretivas e desenvolver iniciativas personalizadas para fortalecer o relacionamento com os clientes. Isso contribui para aumentar a fidelidade dos clientes, reduzir o churn e construir uma base sólida de clientes leais à marca.
 ",
 "",
 ""
 ),

 -- Topico 1 - Materia 3

 (73,
 "Planejamento Estratégico: Definindo objetivos e caminhos para o sucesso",
 "/3.1.jpg",
 "O planejamento estratégico é uma etapa fundamental para o sucesso do seu negócio. Trata-se de um processo que envolve a definição de objetivos a longo prazo da empresa e a criação de estratégias para alcançá-los. É necessário analisar tanto o ambiente externo, identificando oportunidades e ameaças, quanto o ambiente interno, considerando as forças e fraquezas do negócio. Com base nessa análise, é possível estabelecer metas claras e realistas, traçar as estratégias adequadas e criar um plano de ação detalhado.
 ",
 "",
 ""
 ),

 (74,
 "Planejamento Estratégico: Visão panorâmica e preparação para desafios",
 "/3.1.jpg",
 "O planejamento estratégico proporciona uma visão panorâmica do seu negócio, permitindo uma compreensão mais profunda do mercado em que está inserido. Isso significa estar preparado para enfrentar desafios e tomar decisões estratégicas de forma mais assertiva. Ao analisar o ambiente externo e interno, você identifica tendências, oportunidades e ameaças que podem afetar o seu negócio. Dessa forma, o planejamento estratégico ajuda a antecipar e responder a essas mudanças de forma proativa.
 ",
 "",
 ""
 ),

 (75,
 "Planejamento Estratégico: Direcionamento eficiente e alocação de recursos",
 "/3.1.jpg",
 "Um dos principais benefícios do planejamento estratégico é a capacidade de direcionar eficientemente os esforços e recursos da empresa. Ao estabelecer metas e estratégias claras, você cria um roteiro para ação. Isso significa que cada decisão, cada alocação de recursos, cada esforço realizado pela empresa está alinhado com os objetivos estratégicos definidos. Isso evita desperdícios, maximiza o uso dos recursos disponíveis e aumenta as chances de sucesso a longo prazo.
 ",
 "",
 ""
 ),

 (76,
 "Organização: Traduzindo estratégias em ações práticas",
 "/3.1.jpg",
 "Uma vez que as estratégias tenham sido definidas no planejamento estratégico, é necessário transformá-las em ações práticas. Isso envolve alinhar as metas e objetivos estabelecidos com as responsabilidades e tarefas atribuídas a cada membro da equipe. É importante garantir que todos entendam suas responsabilidades e como elas contribuem para o alcance dos objetivos estabelecidos. Além disso, é fundamental monitorar regularmente o progresso e realizar ajustes quando necessário para garantir que o negócio esteja no caminho certo.
 ",
 "",
 ""
 ),

 (77,
 "Organização: Maximizando as chances de sucesso com integração estratégica e organizacional",
 "/3.1.jpg",
 "A integração eficaz do planejamento estratégico e organização é essencial para maximizar as chances de sucesso do seu negócio. Ao estabelecer metas claras no planejamento estratégico e organizar os recursos de forma eficiente, você estará construindo uma base sólida para o crescimento e desenvolvimento. É importante garantir que as estratégias sejam executadas de forma coerente e alinhada, com todos os membros da equipe trabalhando em direção aos mesmos objetivos. Além disso, é fundamental monitorar regularmente o progresso, identificar possíveis desvios e realizar ajustes para manter o negócio no caminho certo.
 ",
 "",
 ""
 ),

 (78,
 "Organização: Construindo uma base sólida para o crescimento",
 "/3.1.jpg",
 "Ao integrar o planejamento estratégico com uma organização eficiente, você está construindo uma base sólida para o crescimento e desenvolvimento do seu negócio. Ao estabelecer metas claras, atribuir responsabilidades e tarefas adequadas, e monitorar regularmente o progresso, você está aumentando suas chances de alcançar o sucesso. Lembre-se de que o planejamento estratégico e a organização são processos contínuos, que exigem revisões e ajustes ao longo do tempo. Mantenha-se comprometido com a execução de suas estratégias e adapte-se às mudanças do mercado para manter seu negócio no caminho certo.
 ",
 "",
 ""
 ),

 (79,
 "Integração do Planejamento Estratégico e Organização: Transformando estratégias em ações práticas",
 "/3.1.jpg",
 "Depois de definir suas estratégias no planejamento estratégico, é hora de transformá-las em ações práticas. Isso significa alinhar as metas e objetivos estabelecidos com as responsabilidades e tarefas atribuídas a cada membro da equipe. É essencial garantir que todos entendam claramente o que precisam fazer para alcançar essas metas. Além disso, é importante acompanhar regularmente o progresso, revisar as estratégias conforme necessário e fazer ajustes para manter o negócio no caminho certo.
 ",
 "",
 ""
 ),

 (80,
 "Integração do Planejamento Estratégico e Organização: Maximizando as chances de sucesso com uma integração eficaz",
 "/3.1.jpg",
 "A integração eficaz entre o planejamento estratégico e a organização é fundamental para maximizar as chances de sucesso do seu negócio. Ao estabelecer metas claras no planejamento estratégico e organizar seus recursos de forma eficiente, você está criando uma base sólida para o crescimento e desenvolvimento. Garanta que suas estratégias sejam implementadas de maneira coerente e alinhada, com todos os membros da equipe trabalhando juntos para atingir os mesmos objetivos. Além disso, monitore regularmente o progresso, identifique possíveis desvios e faça ajustes conforme necessário para manter seu negócio no caminho certo.
 ",
 "",
 ""
 ),

 (81,
 "Integração do Planejamento Estratégico e Organização: Construindo uma base sólida para o crescimento",
 "/3.1.jpg",
 "Ao integrar o planejamento estratégico com uma organização eficaz, você está construindo uma base sólida para o crescimento do seu negócio. Estabeleça metas claras e tangíveis, atribua responsabilidades de forma adequada e eficiente, e acompanhe regularmente o progresso. Lembre-se de que o planejamento estratégico e a organização são processos contínuos que exigem revisões e ajustes ao longo do tempo. Mantenha-se comprometido em executar suas estratégias e adapte-se às mudanças do mercado para manter seu negócio no caminho certo. Dessa forma, você estará construindo uma base sólida para o crescimento e desenvolvimento sustentável do seu negócio.
 ",
 "",
 ""
 ),

-- Topico 2 - Materia 3

(82,
 "Planejamento Financeiro: Estabelecendo metas financeiras claras",
 "/3.2.jpg",
 "O planejamento financeiro é essencial para o sucesso do seu negócio, pois permite ter controle e visibilidade sobre as finanças da empresa. Para isso, é importante estabelecer metas financeiras claras. Isso envolve definir objetivos como aumentar a receita, reduzir os custos e alcançar uma margem de lucro desejada. Estabelecer metas financeiras ajuda a direcionar os esforços e recursos para alcançar resultados financeiros sólidos.
 ",
 "",
 ""
 ),

(83,
 "Planejamento Financeiro: Projeções e plano de investimentos",
 "/3.2.jpg",
 "No planejamento financeiro, é necessário realizar projeções de receitas e despesas. Isso envolve fazer estimativas realistas sobre o fluxo de caixa futuro, levando em consideração fatores como sazonalidade e tendências do mercado. Essas projeções ajudam a antecipar desafios e oportunidades financeiras. Além disso, é fundamental criar um plano de investimentos. Definir prioridades e prazos para a alocação de recursos permite direcionar o investimento de forma estratégica, maximizando o retorno financeiro.
 ",
 "",
 ""
 ),

(84,
 "Planejamento Financeiro: Gestão eficiente do fluxo de caixa",
 "/3.2.jpg",
 "Um aspecto importante do planejamento financeiro é a gestão do fluxo de caixa. É necessário monitorar de perto as entradas e saídas de dinheiro da empresa. Isso ajuda a garantir que haja recursos disponíveis para as operações do dia a dia e para lidar com eventuais imprevistos. A gestão eficiente do fluxo de caixa envolve o controle rigoroso das contas a pagar e a receber, o planejamento de prazos de pagamento e recebimento, além de estratégias para lidar com possíveis variações no fluxo de caixa.
No geral, um planejamento financeiro sólido é essencial para a saúde financeira do seu negócio. Estabelecer metas financeiras claras, realizar projeções e criar um plano de investimentos são passos fundamentais. Além disso, a gestão eficiente do fluxo de caixa garante que a empresa tenha recursos disponíveis para suas operações diárias e para enfrentar eventuais desafios. Ao realizar um planejamento financeiro cuidadoso, você estará no caminho certo para o sucesso e crescimento sustentável do seu negócio.
 ",
 "",
 ""
 ),


(85,
 "Controle Financeiro: Registre e organize suas transações financeiras",
 "/3.2.jpg",
 "O controle financeiro é essencial para o sucesso do seu negócio e consiste em gerenciar e monitorar de forma contínua as atividades financeiras. Para isso, é importante registrar e categorizar todas as transações financeiras, como receitas, despesas, pagamentos e recebimentos. Mantenha um sistema contábil atualizado e organizado, para que você possa ter uma visão clara da situação financeira da empresa e tomar decisões embasadas.
 ",
 "",
 ""
 ),

(86,
 "Controle Financeiro: Faça a conciliação bancária e mantenha seus registros atualizados",
 "/3.2.jpg",
 "Um aspecto crucial do controle financeiro é a conciliação bancária. Esse processo consiste em comparar as movimentações financeiras registradas na contabilidade com as transações efetuadas no banco. Dessa forma, você garante que seus registros contábeis estejam alinhados com as movimentações bancárias. Manter essa conciliação em dia ajuda a identificar possíveis erros ou divergências e contribui para a precisão e confiabilidade das informações financeiras.
 ",
 "",
 ""
 ),

(87,
 "Controle Financeiro: Analise indicadores financeiros e identifique oportunidades de melhoria",
 "/3.2.jpg",
 "Para avaliar o desempenho financeiro da empresa, é fundamental analisar periodicamente indicadores financeiros relevantes. Alguns exemplos são a lucratividade, que mede a rentabilidade dos negócios, a rentabilidade, que indica o retorno sobre os investimentos realizados, e a liquidez, que avalia a capacidade da empresa de honrar suas obrigações financeiras. Ao analisar esses indicadores, você identifica pontos fortes e fracos da sua gestão financeira, possibilitando tomar ações corretivas e identificar oportunidades de melhoria para impulsionar o sucesso do seu negócio.\n
 Em resumo, o controle financeiro envolve o registro e a organização de todas as transações financeiras da empresa, a conciliação bancária para manter os registros atualizados e a análise dos indicadores financeiros para avaliar o desempenho e identificar oportunidades de melhoria. Ao implementar um controle financeiro eficaz, você terá uma visão clara da saúde financeira do seu negócio e poderá tomar decisões informadas e estratégicas para impulsionar seu crescimento.
 ",
 "",
 ""
 ),

(88,
 "Gestão de Custos: Análise e controle seus gastos de forma eficiente",
 "/3.2.jpg",
 "A gestão de custos é essencial para manter a saúde financeira do seu negócio. Isso envolve analisar cuidadosamente os gastos, identificando e classificando os custos fixos (que são aqueles que se mantêm constantes independentemente do volume de produção ou vendas) e os custos variáveis (que variam de acordo com a quantidade produzida ou vendida). É importante identificar oportunidades de redução de despesas, como renegociar contratos, buscar fornecedores mais competitivos e otimizar o uso de recursos. Dessa forma, você poderá maximizar os lucros e evitar desperdícios.
 ",
 "",
 ""
 ),

(89,
 "Gestão de Custos: Estabeleça preços competitivos e rentáveis",
 "/3.2.jpg",
 "A gestão de custos também está diretamente ligada à precificação dos produtos ou serviços oferecidos pela empresa. É fundamental calcular os custos de produção ou prestação de serviços, considerando tanto os custos diretos (materiais, mão de obra) quanto os custos indiretos (aluguel, energia, marketing, entre outros). Com base nesses dados, é possível estabelecer um preço que seja competitivo no mercado e, ao mesmo tempo, gere lucratividade para o negócio. Uma precificação adequada contribui para a sustentabilidade financeira e a longevidade da empresa.
 ",
 "",
 ""
 ),

(90,
 "Gestão de Custos: Fortaleça sua base financeira e aumente as chances de sucesso",
 "/3.2.jpg",
 "Adotar uma abordagem estratégica para o planejamento financeiro, implementar um controle financeiro eficiente e gerenciar os custos de forma inteligente são passos fundamentais para fortalecer a base financeira do seu negócio. Ao analisar os gastos, buscar redução de despesas e estabelecer preços adequados, você estará maximizando os lucros, evitando desperdícios e aumentando as chances de sucesso da sua empresa. Uma gestão de custos eficiente é um pilar essencial para manter a saúde financeira, garantir a sustentabilidade e impulsionar o crescimento do seu negócio.
 ",
 "",
 ""
 ),

-- Topico 3 - Materia 3

(91,
 "Recrutamento e Seleção: Atraia candidatos qualificados para sua empresa",
 "/3.3.jpg",
 "O recrutamento e seleção de pessoal são etapas essenciais na gestão de pessoas de uma empresa. No processo de recrutamento, é importante atrair candidatos qualificados para as vagas disponíveis. Isso pode ser feito por meio da divulgação de vagas em sites especializados, redes sociais, indicações de funcionários ou agências de recrutamento. O objetivo é alcançar profissionais talentosos e interessados em fazer parte da sua equipe.
 ",
 "",
 ""
 ),

(92,
 "Recrutamento e Seleção: Identifique os profissionais mais adequados para sua empresa",
 "/3.3.jpg",
 "Após atrair candidatos, é necessário realizar a etapa de seleção. Nesse processo, os candidatos são avaliados por meio de entrevistas, análise de currículos e testes, a fim de identificar os profissionais mais adequados para as posições em aberto. É importante considerar não apenas as habilidades técnicas, mas também as competências comportamentais e valores que estejam alinhados com a cultura da empresa. Dessa forma, é possível formar uma equipe qualificada e engajada.
 ",
 "",
 ""
 ),

(93,
 "Recrutamento e Seleção: Equipe qualificada e engajada para o sucesso da organização",
 "/3.3.jpg",
 "Um processo eficiente de recrutamento e seleção contribui para a formação de uma equipe qualificada e engajada, fundamental para o sucesso da organização. Ao contratar profissionais com as habilidades certas e que compartilhem os valores da empresa, é possível potencializar a produtividade, a criatividade e a colaboração no ambiente de trabalho. Além disso, a presença de talentos adequados às necessidades da empresa promove um clima organizacional positivo, favorecendo o crescimento e a conquista dos objetivos empresariais.
 ",
 "",
 ""
 ),


(94,
 "Revisando Finanças e aplicando na sua empresa: Investindo no crescimento dos colaboradores",
 "/3.3.jpg",
 "O desenvolvimento de pessoas é um investimento importante para o crescimento e aprimoramento dos colaboradores. Por meio de treinamentos, capacitações e workshops, a empresa oferece oportunidades para que os profissionais adquiram novos conhecimentos e desenvolvam habilidades específicas. Essas ações visam ampliar a competência técnica e comportamental dos colaboradores, preparando-os para enfrentar desafios e contribuir de forma significativa para o sucesso da organização.
 ",
 "",
 ""
 ),

(95,
 "Revisando Finanças e aplicando na sua empresa: Benefícios para a empresa e os colaboradores",
 "/3.3.jpg",
 "Ao investir no desenvolvimento de pessoas, a empresa obtém diversos benefícios. O estímulo ao aprendizado contínuo promove a atualização constante dos conhecimentos dos colaboradores, tornando-os mais preparados para lidar com as demandas do mercado. Além disso, a valorização e motivação dos colaboradores são reforçadas, o que contribui para a retenção de talentos e para a formação de uma cultura organizacional sólida. Esse investimento reflete diretamente na qualidade do trabalho realizado e nos resultados alcançados pela empresa.
 ",
 "",
 ""
 ),

(96,
 "Revisando Finanças e aplicando na sua empresa: Fortalecendo a equipe e impulsionando o sucesso",
 "/3.3.jpg",
 "O desenvolvimento de pessoas fortalece a equipe de trabalho e impulsiona o sucesso da organização. Ao investir no crescimento dos colaboradores, a empresa está investindo em seu maior ativo. Profissionais capacitados e motivados têm um desempenho superior, demonstram maior engajamento e colaboram de forma mais efetiva para o alcance dos objetivos empresariais. O desenvolvimento de pessoas, portanto, é um pilar fundamental para o crescimento sustentável e a excelência do negócio.
 ",
 "",
 ""
 ),

(97,
 "Revisando Gestão de Pessoas na sua empresa: Avaliação sistemática e feedback construtivo",
 "/3.3.jpg",
 "A gestão do desempenho é um processo que visa avaliar o desempenho dos colaboradores de forma sistemática, por meio de avaliações periódicas. Nesse processo, são identificadas as competências e habilidades que estão sendo bem desenvolvidas e aquelas que precisam de melhoria. Com base nessa análise, é possível oferecer feedbacks construtivos, destacando os pontos fortes e apontando áreas que podem ser aprimoradas. Essa abordagem contribui para o desenvolvimento individual dos colaboradores e para o aperfeiçoamento das suas contribuições para a empresa.
 ",
 "",
 ""
 ),

(98,
 "Revisando Gestão de Pessoas na sua empresa: Estabelecimento de metas claras e alinhadas",
 "/3.3.jpg",
 "A gestão do desempenho também envolve o estabelecimento de metas claras e objetivas para cada colaborador, alinhadas aos objetivos estratégicos da empresa. Essas metas devem ser desafiadoras, porém alcançáveis, e devem estar relacionadas às responsabilidades e competências de cada profissional. Além disso, é importante oferecer suporte e recursos para que os colaboradores possam alcançar essas metas. Isso pode ser feito por meio de acompanhamento regular, capacitação adequada e orientação adequada, proporcionando o suporte necessário para que os profissionais atinjam o seu melhor desempenho.
 ",
 "",
 ""
 ),

(99,
 "Revisando Gestão de Pessoas na sua empresa: Estímulo ao crescimento individual e identificação de talentos",
 "/3.3.jpg",
 "A gestão do desempenho não apenas contribui para o crescimento individual dos colaboradores, mas também estimula a melhoria contínua e identifica talentos internos. Ao oferecer feedbacks construtivos e estabelecer metas desafiadoras, a empresa incentiva o desenvolvimento das competências e habilidades dos colaboradores, impulsionando seu crescimento profissional. Além disso, esse processo permite identificar talentos internos e potenciais líderes, que podem ser desenvolvidos e preparados para assumir novas responsabilidades e cargos de maior importância dentro da organização. Dessa forma, a gestão do desempenho contribui para a construção de uma equipe mais eficiente e para o sucesso a longo prazo da empresa.
 ",
 "",
 ""
 ),

-- Topico 4 - Materia 3

(100,
 "Revisando Planejamento e Organização e aplicando na sua empresa: Ganhe eficiência e crescimento com um planejamento estratégico
sólido",
 "/3.4.jpg",
 "Fortaleça seu negócio de costura com um planejamento estratégico bem estruturado.
Identifique seus objetivos, analise o mercado, conheça seu público-alvo e defina
estratégias para alcançar o sucesso. Com um plano sólido, você poderá tomar
decisões mais assertivas, direcionar seus esforços de forma eficiente e impulsionar o
crescimento do seu empreendimento. Não deixe de investir tempo e energia em um
planejamento estratégico que colocará sua empresa de costura no caminho do
sucesso.
 ",
 "",
 ""
 ),

(101,
 "Revisando Planejamento e Organização e aplicando na sua empresa: Organize-se para uma produção de costura eficiente",
 "/3.4.jpg",
 "A organização é a chave para uma produção de costura eficiente. Estabeleça
processos claros e bem definidos, crie um fluxo de trabalho eficiente e mantenha seu
espaço de trabalho organizado. Isso permitirá que você otimize seu tempo, reduza
erros e entregue produtos de alta qualidade dentro dos prazos estabelecidos. Utilize
ferramentas e tecnologias adequadas para gerenciar seus pedidos, estoque de
materiais e comunicação com os clientes. A organização é o segredo para garantir o
sucesso contínuo do seu negócio de costura e as ferramentas do Entre Linhas são a
escolha certa para isso!
 ",
 "",
 ""
 ),

(102,
 "Revisando Planejamento e Organização e aplicando na sua empresa: Alinhe sua equipe e maximize os resultados",
 "/3.4.jpg",
 "O sucesso de uma empresa de costura depende de uma equipe alinhada e
comprometida. Invista em comunicação clara e eficiente, incentive o trabalho em
equipe e promova um ambiente colaborativo. Defina metas compartilhadas, ofereça
treinamentos e reconheça o desempenho dos seus colaboradores. Com uma equipe
engajada e alinhada, você maximiza os resultados, aumenta a produtividade e
fortalece a reputação do seu negócio. Não subestime o poder de uma equipe unida na
busca pelo sucesso na indústria da costura.
 ",
 "",
 ""
 ),

(103,
 "Revisando Finanças e aplicando na sua empresa: Mantenha suas finanças em ordem para o sucesso do seu negócio
de costura",
 "/3.4.jpg",
 "Para garantir a sustentabilidade e o crescimento da sua empresa de costura, é
fundamental manter as finanças em ordem. Realize um planejamento financeiro
detalhado, acompanhe de perto as receitas e despesas, e mantenha um controle
rigoroso do fluxo de caixa. Identifique áreas de oportunidade para reduzir custos e
maximize suas receitas. Além disso, esteja atento aos prazos de pagamento e à
gestão de estoque, para evitar desperdícios e prejuízos. Uma gestão financeira
eficiente é a base para o sucesso do seu negócio de costura.
 ",
 "",
 ""
 ), 

(104,
 "Revisando Finanças e aplicando na sua empresa: Planeje seu crescimento financeiro estrategicamente",
 "/3.4.jpg",
 "Se você deseja expandir seu negócio de costura, é essencial um planejamento
financeiro estratégico. Avalie cuidadosamente o investimento necessário para a
expansão, estude opções de financiamento e estabeleça metas de crescimento
realistas. Além disso, diversifique suas fontes de receita e esteja atento a
oportunidades de parcerias ou novos segmentos de mercado. Um planejamento
financeiro estratégico o ajudará a tomar decisões acertadas e a impulsionar o
crescimento sustentável do seu empreendimento de costura.
 ",
 "",
 ""
 ), 

(105,
 "Revisando Finanças e aplicando na sua empresa: Faça projeções financeiras para o futuro do seu negócio",
 "/3.4.jpg",
 "Não subestime o poder das projeções financeiras para o futuro do seu negócio de
costura. Faça análises financeiras periódicas, projete seus resultados e estabeleça
metas claras. Avalie os principais indicadores de desempenho, como margem de
lucro, retorno sobre o investimento e ponto de equilíbrio. Com base nessas
informações, você poderá tomar decisões mais embasadas, identificar oportunidades
de crescimento e se preparar para eventuais desafios financeiros. Projetar o futuro
financeiro do seu negócio é essencial para garantir sua saúde financeira e sucesso a
longo prazo.
 ",
 "",
 ""
 ), 

(106,
 "Revisando Gestão de Pessoas na sua empresa: Fortaleça o engajamento da sua equipe de costura para impulsionar
o sucesso",
 "/3.4.jpg",
 "A gestão de pessoas é fundamental para o sucesso da sua empresa de costura.
Invista em um ambiente de trabalho positivo, promova a comunicação aberta e
incentive o desenvolvimento profissional da sua equipe. Reconheça e valorize o
trabalho de cada membro, estimulando o engajamento e a motivação. Quando sua
equipe está engajada, o trabalho flui de forma mais eficiente, a criatividade é
estimulada e a qualidade das peças de costura se destaca. A gestão de pessoas é um
pilar essencial para o crescimento sustentável do seu negócio.
 ",
 "",
 ""
 ), 

(107,
 "Revisando Gestão de Pessoas na sua empresa: Desenvolva lideranças na sua equipe para impulsionar o
crescimento",
 "/3.4.jpg",
 "Investir no desenvolvimento de lideranças na sua equipe de costura é uma estratégia
poderosa. Identifique talentos promissores, ofereça treinamentos e incentive a
liderança situacional. Líderes capacitados serão capazes de inspirar e motivar suas
equipes, resolver conflitos e tomar decisões acertadas. Com líderes fortes, sua
empresa terá uma base sólida para o crescimento, além de contar com profissionais
engajados e produtivos. Não subestime o poder do desenvolvimento de lideranças na
indústria da costura.
 ",
 "",
 ""
 ), 

(108,
 "Revisando Gestão de Pessoas na sua empresa: Valorize a diversidade e promova a inclusão na sua equipe de
costura",
 "/3.4.jpg",
 "A diversidade e a inclusão são elementos-chave para o sucesso da sua equipe de
costura. Valorize e respeite as diferenças individuais, promova um ambiente inclusivo
e estimule a troca de ideias. Uma equipe diversa traz perspectivas únicas, estimula a
inovação e melhora a tomada de decisão. Além disso, a inclusão garante que todos os
membros da equipe se sintam valorizados, contribuindo para um clima de trabalho
positivo e colaborativo. Ao promover a diversidade e a inclusão, sua empresa de
costura se torna mais forte e competitiva.
 ",
 "",
 ""
 ), 

-- Topico 1 - Materia 4

(109,
 "Análise de mercado: Compreendendo os consumidores e identificando oportunidades",
 "/4.1.jpg",
 "A análise de mercado desempenha um papel essencial no sucesso de estratégias de marketing e inovação. Por meio de pesquisas de mercado, as empresas podem obter uma compreensão aprofundada das necessidades, preferências e comportamentos dos consumidores. Isso fornece insights valiosos para identificar oportunidades de mercado promissoras. Ao compreender as demandas não atendidas ou mal atendidas pelos produtos ou serviços existentes, as empresas podem desenvolver soluções inovadoras que atendam a essas necessidades de forma eficaz.
 ",
 "",
 ""
 ), 

(110,
 "Análise de mercado: Destacando-se da concorrência e oferecendo valor adicional",
 "/4.1.jpg",
 "Uma pesquisa de mercado bem executada permite que as empresas se destaquem da concorrência. Ao compreender as preferências e expectativas dos consumidores, é possível desenvolver estratégias de marketing mais direcionadas e eficazes. Além disso, a análise de mercado ajuda a identificar lacunas no mercado que podem ser exploradas para oferecer valor adicional aos consumidores. Ao desenvolver produtos ou serviços inovadores e personalizados, as empresas podem atender às necessidades dos consumidores de maneira única, fortalecendo sua posição no mercado.
 ",
 "",
 ""
 ), 

(111,
 "Análise de mercado: Um processo contínuo para se manter atualizado",
 "/4.1.jpg",
 "A análise de mercado não é um processo único, mas sim contínuo. O mercado está em constante evolução, assim como as preferências dos consumidores e as condições competitivas. Portanto, é fundamental que as empresas realizem pesquisas regulares, monitorem as tendências e analisem os dados em tempo real. Dessa forma, elas podem adaptar suas estratégias de marketing e inovação às mudanças do mercado, identificando novas oportunidades e antecipando as necessidades dos consumidores.
 ",
 "",
 ""
 ),

(112,
 "Análise de mercado: Tipos de pesquisa de mercado",
 "/4.1.jpg",
 "Existem diferentes tipos de pesquisa de mercado que podem ser conduzidos para analisar o mercado de forma eficaz. Dois dos principais tipos são a pesquisa quantitativa e a pesquisa qualitativa.\n
 A pesquisa quantitativa envolve a coleta e análise de dados numéricos e estatísticos. Isso é feito por meio de questionários estruturados ou pesquisas online. É útil para obter informações quantitativas sobre as preferências, comportamentos e opiniões dos consumidores em uma escala maior. Essa pesquisa é ideal para medir a demanda, satisfação dos clientes e identificar tendências e padrões do mercado.\n
 Por outro lado, a pesquisa qualitativa busca obter uma compreensão mais profunda dos aspectos subjetivos e motivacionais do comportamento do consumidor. Ela utiliza técnicas como entrevistas em profundidade, grupos focais e observação direta. Esse tipo de pesquisa é valioso para explorar percepções, atitudes e experiências dos consumidores, proporcionando uma visão mais rica e detalhada do mercado.
 ",
 "",
 ""
 ), 

(113,
 "Análise de mercado: O valor da pesquisa de mercado",
 "/4.1.jpg",
 "A pesquisa de mercado desempenha um papel fundamental na tomada de decisões empresariais. Ela fornece informações relevantes e atualizadas sobre os consumidores, o mercado e a concorrência. Ao realizar pesquisas de mercado, as empresas podem tomar decisões mais embasadas e desenvolver estratégias de marketing direcionadas.\n
 A pesquisa de mercado também ajuda as empresas a identificar oportunidades de mercado, antecipar tendências e ajustar seus produtos e serviços às necessidades dos consumidores. Ao compreender as preferências e comportamentos dos consumidores, as empresas podem se adaptar às mudanças do mercado e oferecer soluções que atendam às expectativas dos clientes.
 ",
 "",
 ""
 ), 

(114,
 "Análise de mercado: Decisões embasadas e sucesso empresarial",
 "/4.1.jpg",
 "Realizar pesquisas de mercado é essencial para o sucesso empresarial. Ela permite que as empresas entendam melhor seus clientes, identifiquem lacunas no mercado e ajustem suas estratégias de acordo. Com informações relevantes e atualizadas, as empresas podem tomar decisões embasadas em dados concretos, minimizando riscos e aumentando suas chances de alcançar o sucesso.\n
 Além disso, a pesquisa de mercado auxilia as empresas a estabelecer uma vantagem competitiva. Ao compreender o mercado e a concorrência, as empresas podem identificar oportunidades únicas e se destacar dos concorrentes. Isso permite que elas ofereçam produtos e serviços diferenciados, atendendo às necessidades dos consumidores de maneira mais eficaz e conquistando sua fidelidade.
 ",
 "",
 ""
 ), 

(115,
 "Análise de mercado:  O que é a análise SWOT e seus benefícios",
 "/4.1.jpg",
 "A análise SWOT, ou FOFA (Forças, Fraquezas, Oportunidades e Ameaças), é uma ferramenta valiosa para avaliar a posição de uma empresa no mercado. Com ela, podemos identificar fatores internos e externos que afetam o desempenho e a competitividade do negócio. Essa análise nos ajuda a compreender melhor nossa situação e nos preparar para tomar decisões mais acertadas. Vamos explorar como ela funciona e os benefícios que pode trazer.
 ",
 "",
 ""
 ), 

(116,
 "Análise de mercado:  Conhecendo as partes da análise SWOT",
 "/4.1.jpg",
 "Nessa análise, dividimos em quatro partes principais:\n
 Forças (Strengths):
Aqui, identificamos as vantagens competitivas da empresa em relação aos concorrentes. Isso pode incluir a qualidade dos produtos ou serviços, a expertise da equipe, a eficiência operacional e a tecnologia utilizada. Ao reconhecer e aproveitar essas forças, conseguimos destacar nossa empresa no mercado e fortalecer nossa posição competitiva.\n
Fraquezas (Weaknesses):
Nessa etapa, olhamos para dentro da empresa e identificamos áreas de fraqueza. Podem ser processos internos pouco eficientes, recursos limitados ou falta de experiência em algumas áreas. Reconhecer essas fraquezas é o primeiro passo para desenvolver planos de melhoria e superar os obstáculos existentes.\n
Oportunidades (Opportunities):
Aqui, buscamos identificar tendências ou necessidades emergentes que podemos explorar para crescer no mercado. Isso pode incluir a expansão para novos segmentos, lançar novos produtos alinhados com as demandas dos clientes ou formar parcerias estratégicas. Aproveitar essas oportunidades pode impulsionar o crescimento do nosso negócio.\n
Ameaças (Threats):
Por fim, olhamos para as ameaças externas que podem nos afetar negativamente. Isso pode ser a entrada de novos concorrentes, mudanças na legislação ou avanços tecnológicos. Ao antecipar essas ameaças, podemos nos preparar melhor e tomar medidas para nos proteger.
 ",
 "",
 ""
 ), 

(117,
 "Análise de mercado: A importância da análise SWOT para a empresa",
 "/4.1.jpg",
 "Realizar a análise SWOT nos permite tomar decisões estratégicas mais informadas, melhorar nosso desempenho e nos adaptar às mudanças do mercado. Com esse conhecimento, conseguimos impulsionar o crescimento sustentável da empresa e nos manter competitivos e inovadores em um ambiente de negócios dinâmico. É uma prática fundamental para empresas que desejam se destacar e prosperar no mercado atual.
 ",
 "",
 ""
 ), 

-- Topico 2 - Materia 4

(118,
 "Segmentação de mercado: O que é segmentação de mercado e sua importância",
 "/4.2.jpg",
 "A segmentação de mercado é o processo de dividir um mercado amplo em grupos menores com características semelhantes. Isso nos ajuda a entender melhor os clientes, suas necessidades e preferências específicas. Com essa compreensão mais profunda, podemos adaptar nossas estratégias de marketing, produtos e serviços para atender às demandas exclusivas de cada grupo. Essa abordagem personalizada nos permite construir relacionamentos duradouros com os clientes.
 ",
 "",
 ""
 ),

(119,
 "Segmentação de mercado: Benefícios da segmentação de mercado",
 "/4.2.jpg",
 "A segmentação de mercado traz vários benefícios para as empresas:\n
 Melhor compreensão do cliente: Ao conhecer as necessidades e desejos específicos de diferentes grupos de clientes, podemos oferecer soluções personalizadas. Isso nos ajuda a construir relacionamentos mais fortes e duradouros com os clientes.\n
 Direcionamento eficaz: Ao focar nossos esforços e recursos de marketing nos segmentos mais relevantes, podemos obter um maior impacto e retorno sobre o investimento. Evitamos desperdiçar recursos públicos que não são relevantes para o nosso negócio.\n
 Vantagem competitiva: Ao identificar nichos e oportunidades não exploradas, podemos desenvolver produtos ou serviços diferenciados que atendam a demandas específicas. Isso nos destaca da concorrência e oferece um valor exclusivo aos consumidores.
 ",
 "",
 ""
 ),

(120,
 "Segmentação de mercado: O papel da segmentação de mercado para o sucesso do negócio",
 "/4.2.jpg",
 "A segmentação de mercado é fundamental para o sucesso do negócio. Ela nos permite entender nossos clientes de maneira mais profunda, atender suas necessidades específicas e direcionar nossos esforços de marketing de forma eficaz. Ao oferecer soluções personalizadas e se destacar da concorrência, podemos criar uma vantagem competitiva e conquistar a preferência dos consumidores. Portanto, a segmentação de mercado é uma prática importante para empresas que desejam prosperar em um mercado cada vez mais competitivo.
 ",
 "",
 ""
 ),

(121,
 "Segmentação de mercado: Aspectos importantes na segmentação de mercado",
 "/4.2.jpg",
 "Durante o processo de segmentação de mercado, é crucial considerar alguns aspectos essenciais. Um deles é a análise das características demográficas, como idade, gênero, renda, ocupação, nível educacional e estado civil. Esses dados nos ajudam a entender as diferenças e semelhanças entre os consumidores com base em variáveis demográficas.
 ",
 "",
 ""
 ),

(122,
 "Segmentação de mercado: Comportamento do consumidor como critério de segmentação",
 "/4.2.jpg",
 "Outro aspecto relevante é analisar o comportamento do consumidor. Isso envolve observar o padrão de compra, o uso do produto ou serviço, os hábitos de consumo, as preferências e os estilos de vida dos clientes. Essas informações valiosas podem ser obtidas por meio de pesquisas de mercado, análise de dados de vendas, dados de navegação na internet e outras fontes comportamentais.
 ",
 "",
 ""
 ),

(123,
 "Segmentação de mercado: Necessidades, desejos e localização geográfica",
 "/4.2.jpg",
 "A compreensão das necessidades, desejos, motivações e problemas enfrentados pelos consumidores também é fundamental para a segmentação de mercado. Pesquisas, entrevistas, análise de reclamações de clientes e feedbacks são maneiras de obter essas informações valiosas. Além disso, em setores onde a proximidade geográfica é relevante, considerar características como região, tamanho da cidade ou área de distribuição pode ser um fator importante na segmentação de mercado.\n
 Ao levar em conta esses diversos aspectos durante o processo de segmentação, as empresas podem identificar segmentos mais relevantes e alinhar suas estratégias de marketing de forma mais eficaz. Isso permite atender às necessidades e desejos dos clientes de maneira mais precisa e direcionada, alcançando resultados mais satisfatórios. É importante lembrar que a segmentação pode combinar vários critérios, dependendo do setor, do produto ou serviço oferecido e dos objetivos da empresa.
 ",
 "",
 ""
 ),

(124,
 "Segmentação de mercado: Conheça o seu público-alvo",
 "/4.2.jpg",
 "Para criar estratégias de marketing persuasivas por meio da segmentação de mercado, é crucial conhecer profundamente o seu público-alvo. Isso envolve compreender os interesses, preferências, valores e comportamentos específicos do segmento que você está direcionando. Para isso, é possível utilizar pesquisas de mercado, análise de dados e interação direta com os clientes. Quanto mais você souber sobre o seu público-alvo, melhor será capaz de direcionar suas estratégias de marketing.
 ",
 "",
 ""
 ),

(125,
 "Segmentação de mercado: Personalize as mensagens de marketing",
 "/4.2.jpg",
 "Uma vez que você tenha compreendido o seu público-alvo, é importante adaptar suas mensagens de marketing de acordo com as necessidades e desejos específicos desse grupo. Personalizar as mensagens de marketing significa criar uma comunicação direcionada que ressoe com as preocupações e aspirações do público-alvo. Utilize as informações obtidas sobre o segmento para criar uma abordagem que seja relevante e impactante para esse grupo específico.
 ",
 "",
 ""
 ),

(126,
 "Segmentação de mercado: Destaque os benefícios relevantes",
 "/4.2.jpg",
 "Outra diretriz importante é identificar os principais benefícios que seu produto ou serviço oferece ao segmento específico e destacá-los em sua comunicação. Mostre como seu produto ou serviço atende às necessidades exclusivas desse grupo de consumidores. Ao destacar os benefícios relevantes, você demonstra o valor que seu produto ou serviço traz para o público-alvo, aumentando sua persuasão e engajamento.\n
 Ao criar estratégias persuasivas por meio da segmentação de mercado, é essencial lembrar que cada segmento possui características únicas. A personalização e a adaptação às necessidades específicas do público-alvo são fundamentais para conquistar a atenção e a confiança dos consumidores. Ao entender profundamente o seu público-alvo e direcionar suas estratégias de marketing de forma personalizada, você aumenta as chances de sucesso e impacto positivo em suas ações de marketing.
 ",
 "",
 ""
 ),

-- Topico 3 - Materia 4

(127,
 "Inovação de produtos e serviços: Vantagem competitiva através da inovação",
 "/4.3.jpg",
 "A inovação de produtos e serviços permite que as empresas se destaquem da concorrência, oferecendo algo único e valioso aos clientes. Ao desenvolver novas tecnologias, materiais, recursos, funcionalidades ou designs, as empresas podem criar uma vantagem competitiva, tornando-se uma opção preferencial no mercado. A capacidade de inovar e oferecer algo diferenciado ajuda a construir uma reputação positiva e a atrair mais clientes.
 ",
 "",
 ""
 ),

(128,
 "Inovação de produtos e serviços: Atendimento às necessidades dos clientes por meio da inovação",
 "/4.3.jpg",
 "A inovação é essencial para identificar e atender às necessidades e desejos dos clientes de maneira mais eficiente. Ao criar produtos ou serviços inovadores, as empresas podem proporcionar soluções que agreguem valor e satisfação aos consumidores. Isso envolve entender as demandas do mercado, as tendências e as preferências dos clientes, e desenvolver soluções que estejam alinhadas com essas necessidades. A inovação capacita as empresas a oferecerem experiências positivas e a estabelecerem relacionamentos duradouros com os clientes.
 ",
 "",
 ""
 ),

(129,
 "Inovação de produtos e serviços: Aumento da lucratividade por meio da inovação",
 "/4.3.jpg",
 "A inovação de produtos e serviços pode impulsionar a lucratividade das empresas. Ao desenvolver novos produtos ou serviços inovadores, as empresas podem aproveitar margens de lucro mais altas e gerar receita adicional. Além disso, a inovação fortalece a fidelidade dos clientes, o que contribui para o crescimento dos negócios a longo prazo. A capacidade de oferecer algo único e valioso no mercado permite que as empresas se destaquem e obtenham uma vantagem financeira.\n
 Em resumo, a inovação de produtos e serviços desempenha um papel crucial no crescimento e sucesso de uma empresa. Ela não apenas impulsiona a competitividade, mas também atende às necessidades dos clientes, expande mercados, aumenta a lucratividade e mantém a relevância em um mercado competitivo em constante evolução. Ao investir em inovação, as empresas podem se manter na vanguarda do mercado e garantir um futuro próspero.
 ",
 "",
 ""
 ),

(130,
 "Inovação de produtos e serviços: Compreender as necessidades dos clientes",
 "/4.3.jpg",
 "Para desenvolver a inovação de produtos e serviços, é essencial compreender as necessidades, desejos e desafios dos clientes. Realizar pesquisas de mercado, entrevistar os clientes, analisar tendências e feedbacks são maneiras de identificar lacunas e oportunidades de melhoria. Ao entender profundamente o que os clientes precisam e desejam, é possível direcionar os esforços de inovação para desenvolver soluções que atendam às suas demandas.
 ",
 "",
 ""
 ),

(131,
 "Inovação de produtos e serviços: Estimular a cultura da inovação",
 "/4.3.jpg",
 "Para promover a inovação, é fundamental criar um ambiente propício à criatividade e ao pensamento inovador. Isso pode ser alcançado encorajando a colaboração entre os membros da equipe, incentivando a experimentação e o compartilhamento de ideias. Reconhecer e recompensar as contribuições inovadoras também é importante para incentivar a participação de todos. Ao estimular uma cultura da inovação, a empresa amplia as oportunidades de gerar ideias inovadoras e de encontrar soluções criativas para os desafios que enfrenta.
 ",
 "",
 ""
 ),

(132,
 "Inovação de produtos e serviços: Estar atento às tendências e ao mercado",
 "/4.3.jpg",
 "Manter-se atualizado sobre as tendências de mercado, as tecnologias emergentes, as mudanças nas preferências dos consumidores e as práticas inovadoras na indústria é essencial para impulsionar a inovação. Ao estar atento ao ambiente externo, a empresa pode identificar oportunidades e se inspirar para o desenvolvimento de novos produtos e serviços. Observar o que outras empresas estão fazendo, aprender com seus sucessos e fracassos, e adaptar as melhores práticas ao contexto da própria empresa também contribui para a inovação.\n
 Em resumo, desenvolver a inovação de produtos e serviços requer compreender as necessidades dos clientes, estimular uma cultura da inovação dentro da empresa e estar atento às tendências e ao mercado. Ao seguir essas etapas, a empresa estará preparada para identificar oportunidades, gerar ideias criativas e desenvolver soluções inovadoras que agreguem valor aos clientes e impulsionem o crescimento do negócio.
 ",
 "",
 ""
 ),

(133,
 "Inovação de produtos e serviços: Faça conexões criativas para estimular a inovação",
 "/4.3.jpg",
 "Uma forma eficaz de estimular a criatividade e a inovação é fazendo conexões entre ideias aparentemente distintas. Ao buscar semelhanças, analogias e metáforas, é possível abrir espaço para novas perspectivas e abordagens. Através dessas conexões criativas, você pode encontrar soluções inovadoras para problemas complexos, identificar oportunidades de melhoria e desenvolver produtos e serviços únicos no mercado.
 ",
 "",
 ""
 ),

(134,
 "Inovação de produtos e serviços: Cultive a curiosidade e a busca pelo conhecimento",
 "/4.3.jpg",
 "A curiosidade desempenha um papel fundamental na estimulação da criatividade. Cultivar a curiosidade em relação ao mundo ao seu redor é essencial para despertar novas ideias e insights. Faça perguntas, pesquise, explore diferentes áreas de conhecimento e esteja aberto ao aprendizado constante. Quanto mais você buscar conhecimento e expandir seus horizontes, maior será o leque de possibilidades criativas que surgirão em sua mente.
 ",
 "",
 ""
 ),

(135,
 "Inovação de produtos e serviços: Experimente, arrisque-se e aprenda com os erros",
 "/4.3.jpg",
 "Para desenvolver a criatividade e a inovação, é importante superar o medo de cometer erros e experimentar coisas novas. A criatividade requer coragem para explorar territórios desconhecidos e estar disposto a aceitar desafios. Ao se arriscar, você pode descobrir soluções originais e encontrar caminhos inovadores. Lembre-se de que os erros fazem parte do processo criativo e podem fornecer valiosas lições e insights para futuras tentativas.\n
 Ao adotar essas abordagens, você estará estimulando sua criatividade e abrindo espaço para a inovação em sua vida pessoal e profissional. Fazer conexões criativas, cultivar a curiosidade e experimentar novas ideias são estratégias poderosas para encontrar soluções únicas, superar desafios e se destacar em um mundo cada vez mais dinâmico e competitivo.
 ",
 "",
 ""
 ),

-- Topico 4 - Materia 4

(136,
 "Estratégias de marketing eficazes: Compreendendo o público-alvo e suas necessidades",
 "/4.4.jpg",
 "Para criar estratégias de marketing eficazes, é essencial compreender profundamente o público-alvo e suas necessidades. Isso pode ser alcançado por meio da análise de mercado e da segmentação, identificando as características, preferências e comportamentos dos consumidores. Ao conhecer o público-alvo de forma detalhada, é possível direcionar as mensagens de marketing de maneira mais assertiva e utilizar os canais de comunicação adequados para alcançar o público-alvo de forma eficaz.
 ",
 "",
 ""
 ),

(137,
 "Estratégias de marketing eficazes: A importância da inovação contínua",
 "/4.4.jpg",
 "A inovação de produtos e serviços desempenha um papel fundamental na criação de estratégias de marketing eficazes. Através da inovação, a empresa pode se diferenciar no mercado, oferecendo soluções únicas e relevantes para os consumidores. A constante busca por melhorias e novas ideias garante que a empresa esteja sempre à frente da concorrência e em sintonia com as demandas em constante evolução dos consumidores. A inovação proporciona uma vantagem competitiva, atraindo e retendo a atenção do público-alvo.
 ",
 "",
 ""
 ),

(138,
 "Estratégias de marketing eficazes: Outros fatores a considerar",
 "/4.4.jpg",
 "Além da análise de mercado, segmentação e inovação, existem outros fatores que devem ser considerados na criação de estratégias de marketing eficazes. O posicionamento da marca, por exemplo, é essencial para transmitir a proposta de valor e destacar-se no mercado. Também é importante definir metas claras, que sejam específicas, mensuráveis, alcançáveis, relevantes e com prazo determinado. A escolha dos canais de comunicação adequados, de acordo com o perfil do público-alvo, é crucial para alcançar o público de forma efetiva. Por fim, monitorar e avaliar constantemente os resultados é fundamental para identificar oportunidades de melhoria e ajustar as estratégias conforme necessário, garantindo o sucesso a longo prazo.
 ",
 "",
 ""
 ),

(139,
 "Estratégias de marketing eficazes: Conheça seu público-alvo e defina metas claras",
 "/4.4.jpg",
 "Para desenvolver estratégias de marketing eficazes, é fundamental conhecer profundamente seu público-alvo. Isso envolve compreender suas características demográficas, comportamentais, necessidades, desejos e preferências. Essas informações permitem direcionar suas estratégias de forma mais precisa, criando mensagens e ações que se conectem diretamente com seu público. Além disso, é essencial estabelecer metas claras e mensuráveis para suas estratégias de marketing. Esses objetivos podem variar desde aumentar a conscientização da marca, gerar leads, aumentar as vendas até melhorar o engajamento nas mídias sociais. Ter metas bem definidas ajuda a direcionar seus esforços e medir o sucesso de suas estratégias.
 ",
 "",
 ""
 ),

(140,
 "Estratégias de marketing eficazes: Escolha os canais de marketing apropriados",
 "/4.4.jpg",
 "Para alcançar seu público-alvo de maneira eficaz, é importante selecionar os canais de marketing adequados. Avalie quais canais são mais relevantes para seu negócio e público-alvo. Isso pode incluir mídias sociais, e-mail marketing, anúncios pagos, marketing de conteúdo, SEO (otimização para mecanismos de busca), entre outros. Considere também a utilização de canais de marketing offline, como eventos ou publicidade impressa, se for apropriado para o seu público. Ao escolher os canais certos, você garante que suas mensagens alcancem as pessoas certas, no momento certo e da maneira mais eficaz.
 ",
 "",
 ""
 ),

(141,
 "Estratégias de marketing eficazes: Desenvolva uma presença online consistente",
 "/4.4.jpg",
 "A presença nas mídias sociais desempenha um papel significativo nas estratégias de marketing. Identifique as plataformas de mídia social mais relevantes para o seu negócio e estabeleça uma presença consistente nelas. Interaja com seu público, compartilhe conteúdo relevante e monitore as conversas sobre sua marca. A presença nas mídias sociais permite que você se conecte diretamente com seu público-alvo, construa relacionamentos e crie uma imagem positiva da sua marca. Lembre-se de adaptar sua abordagem e conteúdo para cada plataforma, aproveitando as características e recursos específicos de cada uma.\n
 Em suma, ao conhecer seu público-alvo, estabelecer metas claras, escolher os canais de marketing apropriados e desenvolver uma presença online consistente, você estará no caminho certo para criar estratégias de marketing eficazes. Essas ações ajudam a direcionar suas mensagens de forma precisa, alcançar seu público-alvo de maneira efetiva e construir relacionamentos sólidos com seus clientes.
 ",
 "",
 ""
 ),

 (142,
 "Estratégias de marketing eficazes: Defina métricas de desempenho alinhadas aos objetivos",
 "/4.4.jpg",
 "A avaliação regular dos resultados das suas estratégias de marketing é essencial para saber se elas estão dando certo. Para isso, é importante estabelecer indicadores-chave de desempenho (KPIs) que estejam alinhados aos seus objetivos de marketing. Por exemplo, se o seu objetivo é aumentar as vendas, acompanhe métricas como o volume de vendas, a taxa de conversão e o valor médio de compra. Definir metas claras e mensuráveis ajudará a determinar se suas estratégias estão alcançando os resultados desejados.
 ",
 "",
 ""
 ),

 (143,
 "Estratégias de marketing eficazes: Analise os dados para obter insights",
 "/4.4.jpg",
 "A análise de dados é uma ferramenta poderosa para avaliar a eficácia das suas estratégias de marketing. Utilize ferramentas de análise para coletar e interpretar dados relevantes. Analise métricas como o tráfego do site, as taxas de abertura e cliques em e-mails, o engajamento nas mídias sociais e outras métricas específicas do canal utilizado. Esses dados fornecerão insights valiosos sobre o desempenho das suas estratégias e ajudarão a identificar áreas de melhoria. A análise dos dados permite tomar decisões mais embasadas e direcionar seus esforços para as ações mais efetivas.
 ",
 "",
 ""
 ),

 (144,
 "Estratégias de marketing eficazes: Colete feedback dos clientes para compreender sua percepção",
 "/4.4.jpg",
 "O feedback dos clientes é uma fonte valiosa de informação para avaliar a eficácia das suas estratégias de marketing. Realize pesquisas de satisfação, conduza entrevistas ou acompanhe as interações dos clientes nas redes sociais. Essas práticas ajudarão a coletar opiniões e percepções diretas do seu público-alvo. O feedback dos clientes fornecerá insights sobre a percepção da sua marca, o nível de satisfação dos clientes e se suas estratégias estão atingindo o público-alvo de forma positiva. Utilize essas informações para ajustar e melhorar suas estratégias de marketing.\n
 Em resumo, para avaliar a eficácia das suas estratégias de marketing, defina métricas de desempenho alinhadas aos objetivos, analise os dados relevantes e colete feedback dos clientes. Lembre-se de que os resultados podem levar tempo para serem percebidos, então seja paciente e esteja disposto a fazer ajustes conforme necessário. A avaliação constante e a adaptação das suas estratégias garantirão que você esteja no caminho certo para alcançar seus objetivos de marketing.
 ",
 "",
 ""
 );
 
 -- PRATICA 1 - Topico 1
INSERT INTO pratica (id_pratica, titulo_pag, subtitulo_pag, txt1, txt2, txt3, txt4) VALUES (
1,
 "HORA DE APERTAR OS PONTOS!",
 "Em suma, a segmentação de mercado é uma estratégia poderosa que permite às empresas atenderem de forma mais precisa às necessidades dos consumidores. Ao identificar segmentos com base em critérios demográficos, psicográficos e comportamentais, as empresas podem personalizar suas estratégias de marketing e criar ofertas que atendam às necessidades específicas de cada grupo. Isso resulta em uma maior satisfação do cliente, fidelidade à marca e sucesso no mercado.\n
Questões:\n
 1 - Quais são os benefícios de realizar uma pesquisa de mercado antes de iniciar um negócio?",
 "(a) Identificar oportunidades de mercado e demanda pelos produtos ou serviços oferecidos.", 
 "(b) Determinar o preço ideal para os produtos ou serviços, maximizando os lucros.",
 "(c) Reduzir os custos operacionais e otimizar a eficiência da produção.",
 "(d) Estabelecer parcerias estratégicas com fornecedores e concorrentes para aumentar a participação de mercado."
 ),
 
(2,
 "",
 "2) Como a análise da concorrência pode ajudar a identificar oportunidades no mercado?",
 "(a) Identificar as estratégias de marketing dos concorrentes e copiá-las para obter sucesso no mercado.", 
 "(b) Observar as fraquezas dos concorrentes e explorá-las para ganhar participação de mercado",
 "(c) Entender as necessidades não atendidas dos clientes pelos concorrentes e desenvolver produtos ou serviços para preencher essas lacunas.",
 "(d) Monitorar os preços dos concorrentes e reduzir o preço dos produtos ou serviços para atrair mais clientes."
 ),
 
  -- PRATICA 1 - Topico 2
 (3,
 "HORA DE APERTAR OS PONTOS",
 "Em resumo, as personas são ferramentas poderosas para compreender o público-alvo, segmentar o mercado, personalizar estratégias de marketing e desenvolver produtos de sucesso. Ao criar personas bem definidas, as empresas podem obter benefícios significativos, como melhorar a conexão com os clientes, aumentar a eficácia das campanhas e desenvolver produtos alinhados com as necessidades do mercado.\n
 Questões:\n 
 1 - Qual a importância de conhecer o público-alvo para o sucesso de um negócio?",
 "(a) O conhecimento do público-alvo é essencial para identificar novas oportunidades de negócio.", 
 "(b) Conhecer o público-alvo permite personalizar a experiência do cliente e aumentar a fidelização.",
 "(c) A compreensão do público-alvo auxilia na definição de estratégias de venda e distribuição mais eficientes.",
 "(d) Entender o público-alvo é fundamental para a criação de produtos e serviços que atendam às necessidades do mercado"
 ),
 
  (4,
 "2- Como as personas do cliente podem ser úteis na criação de estratégias de marketing?",
 "",
 "(a) As personas do cliente fornecem insights sobre os interesses e comportamentos do público-alvo, permitindo direcionar as estratégias de marketing de forma mais precisa.", 
 "(b) Por meio das personas do cliente, é possível segmentar o público-alvo e criar mensagens e campanhas personalizadas para cada segmento.",
 "(c) As personas do cliente ajudam a identificar os canais de comunicação mais adequados para alcançar o público-alvo de forma efetiva.",
 "(d)  Ao criar personas do cliente, é possível entender as necessidades, desafios e objetivos do público-alvo, auxiliando na criação de produtos e serviços que atendam às suas demandas."
 ),
 
  -- PRATICA 1 - Topico 3
 (5,
 "HORA DE APERTAR OS PONTOS!",
 "Em resumo, as oportunidades são fatores externos positivos que podem impulsionar o crescimento e o sucesso da organização. Elas surgem de mudanças no mercado, avanços tecnológicos, demanda crescente, novos segmentos de mercado ou parcerias estratégicas. Identificar essas oportunidades é crucial, pois direciona os esforços da empresa para aproveitar os benefícios do ambiente externo e buscar vantagens competitivas.
Questões:\n
 1 - Quais são os benefícios de realizar uma análise SWOT para o planejamento estratégico do seu negócio?",
 "(a) A análise SWOT permite identificar as forças e fraquezas internas da empresa, auxiliando na definição de estratégias que aproveitem as vantagens competitivas e minimizem as fraquezas.", 
 "(b) Por meio da análise SWOT, é possível identificar as oportunidades e ameaças do ambiente externo, permitindo adaptar o planejamento estratégico para aproveitar as oportunidades e se precaver contra as ameaças.",
 "(c) Realizar uma análise SWOT proporciona uma visão abrangente do mercado, dos concorrentes e das tendências, fornecendo insights valiosos para a tomada de decisões estratégicas.",
 "(d) A análise SWOT é útil para identificar os recursos e capacidades internas da empresa, auxiliando no planejamento de investimentos e no alinhamento de metas e objetivos."
 ),
 
 (6,
 "",
 "2- Como identificar as oportunidades e ameaças externas ao seu negócio?",
 "(a) Através de pesquisas de mercado e análise de tendências, é possível identificar oportunidades e ameaças externas ao negócio.", 
 "(b) A interação com clientes, fornecedores e parceiros pode fornecer insights sobre oportunidades e ameaças no ambiente externo.",
 "(c) Monitorar o ambiente competitivo, analisar as ações dos concorrentes e observar as mudanças no cenário econômico e regulatório são formas de identificar oportunidades e ameaças externas.",
 "(d) Participar de eventos do setor, como conferências e feiras, e estar atento às novidades da indústria são maneiras eficazes de identificar oportunidades e ameaças externas."
 ),
 
  -- PRATICA 1 - Topico 4
 (7,
 "HORA DE APERTAR OS PONTOS!",
 "Em resumo, a análise de viabilidade operacional envolve a avaliação dos recursos necessários, a análise dos processos operacionais e logísticos, e a identificação de possíveis desafios e soluções operacionais. Esses elementos são essenciais para garantir que o negócio possua os recursos adequados, opere de forma eficiente e esteja preparado para enfrentar os desafios operacionais que possam surgir.\n
Questões:\n
 1 - Por que é importante realizar um estudo de viabilidade antes de iniciar um negócio?",
 "(a) Um estudo de viabilidade permite avaliar a viabilidade econômica do negócio, identificando se o empreendimento é financeiramente sustentável e lucrativo.", 
 "(b) Realizar um estudo de viabilidade ajuda a identificar potenciais desafios e obstáculos que podem afetar o sucesso do negócio, permitindo tomar medidas preventivas.",
 "(c) O estudo de viabilidade permite avaliar a demanda e o potencial de mercado do produto ou serviço, auxiliando na identificação de oportunidades e na definição de estratégias de entrada no mercado.",
 "(d) Realizar um estudo de viabilidade ajuda a identificar os recursos necessários para iniciar o negócio, como capital, mão de obra e infraestrutura, possibilitando um planejamento adequado."
 ),
 
 (8,
 "",
 "2- Quais são os principais aspectos a serem considerados em uma análise de viabilidade econômica?",
 "(a) Os custos de produção, incluindo matéria-prima, mão de obra e custos operacionais, são aspectos essenciais a serem considerados em uma análise de viabilidade econômica.", 
 "(b) A projeção de receitas e a estimativa de demanda são aspectos cruciais para avaliar a viabilidade econômica de um empreendimento.",
 "(c) O estudo de mercado, incluindo análise de concorrência e tendências do setor, é um aspecto importante a ser considerado em uma análise de viabilidade econômica.",
 "(d) A análise dos custos fixos e variáveis, bem como a estimativa do ponto de equilíbrio e do retorno sobre o investimento, são aspectos-chave em uma análise de viabilidade econômica."
 ),
 
-- PRATICA 2 - Topico 1
(9,
 "Questão",
 "1 - Quais informações pessoais você considera mais relevantes para conhecer seus clientes?",
 "(a) Idade e gênero.", 
 "(b) Localização geográfica e preferências de compra.",
 "(c) Histórico de compras e comportamento de navegação.",
 "(d) Profissão e estado civil."
 ), 

 (10,
 "",
 "2- Como você garante a privacidade e segurança das informações pessoais coletadas?",
 "(a) Criptografar todas as informações armazenadas.", 
 "(b) Implementar medidas de segurança física para proteger os servidores.",
 "(c) Obter consentimento explícito dos clientes para coletar e utilizar suas informações.",
 "(d) Contratar uma equipe especializada em segurança da informação."
 ),

-- PRATICA 2 - Topico 2
 (11,
 "Questão",
 "Como você identifica as necessidades e desejos dos seus clientes?",
 "(a) Realizando pesquisas de mercado e coletando feedback dos clientes.", 
 "(b) Analisando o comportamento de compra e os padrões de navegação dos clientes.",
 "(c) Realizando entrevistas e conduzindo grupos focais com os clientes.",
 "(d) Monitorando as interações e o engajamento dos clientes nas redes sociais."
 ), 

 (12,
 "",
 "Como você utiliza as personas para aprimorar suas estratégias de marketing?",
 "(a) Segmentando o público-alvo e adaptando as mensagens de marketing para cada
persona.", 
 "(b) Criando campanhas publicitárias com base nos perfis demográficos das personas.",
 "(c) Personalizando a experiência do cliente de acordo com as características das personas.",
 "(d) Utilizando as personas como referência para definir preços e políticas de desconto."
 ),

 -- PRATICA 2 - Topico 3
 (13,
 "Questão",
 "Quais ferramentas você utiliza para analisar o comportamento do cliente?",
 "(a) Google Analytics.", 
 "(b) CRM (Customer Relationship Management).",
 "(c) Pesquisas de satisfação.",
 "(d) Testes A/B."
 ), 

 (14,
 "",
 "Como você utiliza os insights obtidos com a análise do comportamento do cliente para tomar
decisões estratégicas?",
 "(a) Personalizando ofertas e promoções com base nos interesses do cliente.", 
 "(b) Adaptando a comunicação e o conteúdo de marketing de acordo com as preferências do
cliente.",
 "(c) Identificando oportunidades de melhorias nos produtos e serviços com base no feedback
do cliente.",
 "(d) Ajustando estratégias de precificação e posicionamento de mercado com base no
comportamento de compra do cliente."
 ),

-- PRATICA 2 - Topico 4
 (15,
 "Questão",
 "1 - Como você coleta o feedback dos seus clientes de forma eficiente?",
 "(a) Envio de pesquisas de satisfação por e-mail após a conclusão de uma compra ou interação
com a empresa.", 
 "(b) Utilização de ferramentas de feedback online, como formulários ou chats em tempo
real.",
 "(c) Realização de entrevistas ou chamadas telefônicas para obter feedback personalizado.",
 "(d) Monitoramento de redes sociais e análise de comentários e avaliações dos clientes."
 ), 

 (16,
 "",
 "2- Como você utiliza o feedback dos clientes para melhorar seus produtos, serviços e
processos?",
 "(a) Identificando pontos fracos e realizando melhorias específicas com base no feedback
recebido.", 
 "(b) Incorporando sugestões e ideias dos clientes no desenvolvimento de novos produtos ou
serviços.",
 "(c) Realizando treinamentos internos com base no feedback para aprimorar o atendimento
ao cliente.",
 "(d) Implementando mudanças nos processos internos para resolver problemas apontados
pelos clientes."
 ),

-- Pratica 3 - Topico 1
(17,
 "Questão",
 "1 - Qual é a importância do planejamento estratégico para o sucesso do negócio?",
 "(a) Permite uma estrutura organizacional eficiente.", 
 "(b) Facilita a comunicação interna da empresa.",
 "(c) Define metas claras e direciona os esforços da empresa.",
 "(d) Garante uma alocação eficiente de recursos financeiros."
 ), 

 (18,
 "",
 "2- Qual é o objetivo da organização no gerenciamento do negócio?",
 "(a) Aumentar a eficiência e produtividade da equipe.", 
 "(b) Definir metas e estratégias de longo prazo.",
 "(c) Analisar o ambiente externo e identificar oportunidades.",
 "(d) Elaborar um plano de ação detalhado."
 ),

-- Pratica 3 - Topico 2
 (19,
 "Questão",
 "Pergunta 1: Qual é um dos aspectos importantes do planejamento financeiro?",
 "(a) Definir metas de vendas e aumentar a receita.", 
 "(b) Realizar projeções de receitas e despesas.",
 "(c) Monitorar de perto as entradas e saídas de dinheiro.",
 "(d) Elaborar um plano de investimentos."
 ), 

 (20,
 "",
 "2- O que envolve a gestão de custos em um negócio?",
 "(a) Controlar o fluxo de caixa e monitorar as transações financeiras.", 
 "(b) Identificar, classificar e controlar os gastos de forma eficiente.",
 "(c) Analisar os indicadores financeiros e avaliar o desempenho.",
 "(d) Renegociar contratos e buscar fornecedores mais competitivos."
 ),

 -- Pratica 3 - Topico 3
 (21,
 "Questão",
 "1 - Qual é a finalidade do processo de recrutamento e seleção?",
 "(a) Aumentar a produtividade da equipe de RH.", 
 "(b) Identificar talentos internos para promoção.",
 "(c) Contratar profissionais adequados para as vagas disponíveis.",
 "(d) Oferecer oportunidades de desenvolvimento para os colaboradores."
 ), 

 (22,
 "",
 "2- Por que é importante investir no desenvolvimento de pessoas?",
 "(a) Para aumentar a rotatividade de funcionários.", 
 "(b) Para fortalecer a cultura organizacional.",
 "(c) Para reduzir os custos com treinamentos.",
 "(d) Para criar um ambiente de trabalho desafiador."
 ),

-- Pratica 3 - Topico 4
 (23,
 "Questão",
 "1 - Qual é a importância do planejamento financeiro para empresas de profissionais
da costura?",
 "(a) Garantir um fluxo de caixa positivo.", 
 "(b) Aumentar o número de colaboradores.",
 "(c) Reduzir a qualidade dos produtos.",
 "(d) Ignorar o controle de estoque."
 ), 

 (24,
 "",
 "2- Como a gestão de pessoas pode beneficiar uma empresa de costura?",
 "(a) Aumentando os custos operacionais.", 
 "(b) Reduzindo a produtividade da equipe.",
 "(c) Melhorando o ambiente de trabalho e o engajamento dos colaboradores.",
 "(d) Ignorando o desenvolvimento de lideranças."
 ),

-- Pratica 4 - Topico 1
 (25,
 "Pergunta 1:",
 "Como você realiza a análise de mercado para identificar oportunidades e
tendências?",
 "(a) Realizo pesquisas de mercado para entender as necessidades e preferências dos
consumidores.", 
 "(b) Acompanho as tendências de moda estrangeira por meio de análise de redes
sociais.",
 "(c) Participo de feiras e eventos do setor para identificar oportunidades e
tendências.",
 "(d) Utilizo ferramentas de monitoramento de mídias sociais para identificar insights
sobre o mercado."
 ), 

 (26,
 "Pergunta 2:",
 "Como a análise SWOT pode ajudar o desenvolvimento do seu negócio?",
 "(A) A análise SWOT ajuda a identificar as fraquezas internas do concorrente.", 
 "(B) A análise SWOT auxilia na identificação de oportunidades no mercado.",
 "(C) A análise SWOT fornece informações sobre as tendências de consumo.",
 "(D) A análise SWOT permite identificar os concorrentes do negócio."
 ),

-- Pratica 4 - Topico 2
 (27,
 "Pergunta 1:",
 "Como segmentar o mercado é importante para o seu negócio?",
 "(a) A segmentação de mercado ajuda a identificar nichos de mercado não
atendidos.", 
 "(b) A segmentação de mercado permite direcionar estratégias de marketing de forma
mais eficiente.",
 "(c) A segmentação de mercado facilita o desenvolvimento de produtos genéricos
para atender a todos os públicos.",
 "(d) A segmentação de mercado é irrelevante para o sucesso de um negócio."
 ), 

 (28,
 "Pergunta 2:",
 "Como você poderia criar um conteúdo personalizado para os seus clientes?",
 "(a) Utilizando abordagens genéricas que se apliquem a todos os segmentos de
mercado.", 
 "(b) Coletando informações demográficas amplas dos clientes.",
 "(c) Analisando o comportamento de compra dos clientes e adaptando as mensagens
de acordo.",
 "(d) Ignorando as preferências e necessidades dos clientes e fornecendo um
conteúdo padrão."
 ),

 -- Pratica 4 - Topico 3
 (29,
 "Pergunta 1:",
 "Qual a importância da inovação para o seu negócio?",
 "(a) A inovação é importante para reduzir os custos operacionais.", 
 "(b) A inovação é importante para manter o status quo e evitar mudanças.",
 "(b) A inovação é importante para manter o status quo e evitar mudanças.",
 "(d) A inovação é importante para se manter competitivo e impulsionar o
crescimento."
 ), 

 (30,
 "Pergunta 2:",
 "Como desenvolver a sua capacidade criativa?",
 "(a) Seguindo rigidamente métodos e processos estabelecidos.", 
 "(b) Evitando o trabalho em equipe e colaboração com outras pessoas.",
 "(c) Expondo-se a diferentes estímulos e experiências variadas.",
 "(d) Limitando-se a uma única área de conhecimento."
 ),

 -- Pratica 4 - Topico 4
 (31,
 "Pergunta 1:",
 "Qual a importância das estratégias de marketing?",
 "(a) Aumentar a visibilidade da empresa no mercado.", 
 "(b) Melhorar a relação com os fornecedores.",
 "(c) Reduzir os custos operacionais da empresa.",
 "(d) Aumentar o capital social da empresa."
 ), 

 (32,
 "Pergunta 2",
 "Como saber se minhas estratégias de marketing estão dando certo?",
 "(a) Analisar as ações dos concorrentes.", 
 "(b) Coletar feedback dos clientes.",
 "(c) Realizar pesquisas de mercado.",
 "(d) Aumentar os investimentos em publicidade."
 );

-- DICA
INSERT INTO dica (id_dica, titulo_pag, txt1, txt2, txt3, txt4, txt5, txt6, txt7, txt8) VALUES (
1,
 "tituloText7777",
 "txt",
 "txt",
 "txt",
 "txt",
 "txt",
 "txt",
 "txt",
 "txt"),
 (
2,
 "tituloText100%",
 "txt",
 "txt",
 "txt",
 "txt",
 "txt",
 "txt",
 "txt",
 "txt"); 

-- TESTES para a API
-- INSERT INTO perfil (nivel) VALUES (10); -- desnecessario 

-- SELECT * FROM entrelinhasdb.usuario;
-- SELECT * FROM entrelinhasdb.perfil;
-- SELECT * FROM entrelinhasdb.trilhas;
-- SELECT * FROM entrelinhasdb.atividades;
-- SELECT * FROM entrelinhasdb.materia;
 -- SELECT * FROM entrelinhasdb.pedidos;

-- INSERT INTO trilhas (id_trilhas, titulo, `status`, data_criacao, nivel_minimo, id_atividades, id_status) VALUES (1, null, null, null, 0, null, null);