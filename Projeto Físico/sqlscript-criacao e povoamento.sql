REM   Script: criacaoEpovoamento
REM   criação E povoamento

CREATE TABLE condominios ( 
    endereco VARCHAR(80), 
    CONSTRAINT pk_condominio PRIMARY KEY(endereco) 
);

CREATE TABLE predios ( 
    num_predio INT, 
    quantidade_apartamentos INT, 
    endereco VARCHAR(80) NOT NULL, 
    CONSTRAINT pk_num_predio PRIMARY KEY(num_predio), 
    CONSTRAINT fk_condominio FOREIGN KEY(endereco) 
        REFERENCES condominios(endereco) 
);

CREATE TABLE apartamentos ( 
    num_apartamento INT, 
    num_comodos INT, 
    metragem FLOAT, 
    num_predio INT NOT NULL, 
    CONSTRAINT pk_apartamentos PRIMARY KEY(num_apartamento), 
    CONSTRAINT fk_predio FOREIGN KEY(num_predio) 
        REFERENCES predios(num_predio) 
);

CREATE TABLE areas_comuns ( 
    endereco VARCHAR(80), 
    tipo VARCHAR(20), 
    CONSTRAINT pk_endereco PRIMARY KEY(endereco, tipo), 
    CONSTRAINT fk_condominio_ac FOREIGN KEY(endereco) 
        REFERENCES condominios(endereco) 
);

CREATE TABLE pessoas ( 
    cpf VARCHAR(11), 
    nome VARCHAR(80), 
    email VARCHAR(80), 
    CONSTRAINT pk_cpf PRIMARY KEY(cpf) 
);

CREATE TABLE telefones ( 
    telefone VARCHAR(11), 
    cpf VARCHAR(11), 
    CONSTRAINT pk_telefone PRIMARY KEY(telefone, cpf), 
    CONSTRAINT fk_pessoa_t FOREIGN KEY(cpf) 
        REFERENCES pessoas(cpf) 
);

CREATE TABLE moradores( 
    cpf VARCHAR(11), 
    num_apartamento INT, 
    CONSTRAINT pk_cpf_m PRIMARY KEY(cpf), 
    CONSTRAINT fk_cpf_m FOREIGN KEY (cpf) 
    REFERENCES pessoas(cpf), 
    CONSTRAINT fk_num_apartamento_m FOREIGN KEY(num_apartamento) 
    REFERENCES apartamentos(num_apartamento) 
);

CREATE TABLE sindicos ( 
    cpf VARCHAR(11), 
    profissao VARCHAR(20), 
    num_predio INT UNIQUE, 
    CONSTRAINT pk_sindico PRIMARY KEY(cpf), 
    CONSTRAINT fk_sindico_pessoa FOREIGN KEY(cpf) REFERENCES pessoas(cpf), 
    CONSTRAINT fk_sindico_predio FOREIGN KEY(num_predio) REFERENCES predios(num_predio) 
);

CREATE TABLE funcionarios ( 
    cpf VARCHAR(11), 
    cargo VARCHAR(20), 
    salario FLOAT, 
    cpf_supervisor VARCHAR(11), 
    num_predio INT NOT NULL, 
    CONSTRAINT pk_funcionario PRIMARY KEY(cpf), 
    CONSTRAINT fk_cpf_funcionario FOREIGN KEY(cpf) REFERENCES pessoas(cpf), 
    CONSTRAINT fk_cpf_supervisor FOREIGN KEY(cpf_supervisor) REFERENCES pessoas(cpf), 
    CONSTRAINT fk_predio_funcionario FOREIGN KEY(num_predio) REFERENCES predios(num_predio) 
);

CREATE TABLE visitantes ( 
    cpf VARCHAR(11), 
    num_apartamento_informado INT, 
    num_predio_informado INT, 
    CONSTRAINT pk_visitantes PRIMARY KEY(CPF), 
    CONSTRAINT fk_pessoa_v FOREIGN KEY(cpf) REFERENCES pessoas(cpf) 
);

CREATE TABLE registros ( 
     
    cod_registro INT, 
    foto_RG BLOB, 
    CONSTRAINT pk_cod_registro PRIMARY KEY(cod_registro) 
);

CREATE TABLE visitas ( 
    cod_registro INT, 
    cpf VARCHAR(11), 
    data_visita DATE, 
    horario_visita TIMESTAMP, 
    num_apartamento INT NOT NULL, 
    
    CONSTRAINT pk_visita PRIMARY KEY(cpf, cod_registro, data_visita, horario_visita), 
    CONSTRAINT fk_visitante FOREIGN KEY(cpf) REFERENCES visitantes(cpf), 
    CONSTRAINT fk_registro FOREIGN KEY(cod_registro) REFERENCES registros(cod_registro), 
    CONSTRAINT fk_apartamento_v FOREIGN KEY(num_apartamento) REFERENCES apartamentos(num_apartamento) 
);

CREATE TABLE empresas_servicos ( 
    CNPJ VARCHAR(14), 
    CONSTRAINT pk_servico_terceiros PRIMARY KEY(CNPJ) 
);

CREATE TABLE servicos ( 
    num_apartamento INT, 
    CPF VARCHAR(11), 
    data_servico DATE, 
    horario_servico TIMESTAMP, 
    descricao_servico VARCHAR(200), 
     
 
    CONSTRAINT pk_servico PRIMARY KEY(num_apartamento,cpf, data_servico, horario_servico), 
    CONSTRAINT fk_apartamento_s FOREIGN KEY(num_apartamento) REFERENCES apartamentos(num_apartamento), 
    CONSTRAINT fk_funcionario_s FOREIGN KEY(cpf) REFERENCES pessoas (cpf) 
 
);

CREATE TABLE contrata ( 
    num_apartamento INT, 
    cpf VARCHAR(11), 
    data_servico DATE, 
    horario_servico TIMESTAMP, 
    CNPJ VARCHAR(14), 
    CONSTRAINT pk_contrata PRIMARY KEY(num_apartamento, cpf, data_servico,horario_servico, CNPJ), 
    CONSTRAINT pk_servicos FOREIGN KEY (num_apartamento, CPF, data_servico, horario_servico) REFERENCES servicos (num_apartamento, CPF, data_servico, horario_servico), 
    CONSTRAINT fk_cnpj FOREIGN KEY(CNPJ) REFERENCES empresas_servicos(CNPJ) 
 
);

CREATE TABLE reservas ( 
    num_apartamento INT, 
    endereco VARCHAR(80), 
    tipo VARCHAR(20), 
    data_reserva DATE, 
    horario_reserva TIMESTAMP, 
    CONSTRAINT pk_reserva PRIMARY KEY(num_apartamento,endereco, tipo,data_reserva, horario_reserva), 
    CONSTRAINT fk_apartamento_r FOREIGN KEY(num_apartamento) REFERENCES apartamentos(num_apartamento), 
    CONSTRAINT fk_areas_comuns_r FOREIGN KEY(endereco, tipo) REFERENCES areas_comuns(endereco, tipo) 
);

INSERT INTO condominios (endereco) VALUES ('Rua das Flores, 123');

INSERT INTO condominios (endereco) VALUES ('Avenida dos Anjos, 456');

INSERT INTO predios (num_predio, quantidade_apartamentos, endereco) VALUES (1, 10, 'Rua das Flores, 123');

INSERT INTO predios (num_predio, quantidade_apartamentos, endereco) VALUES (2, 8, 'Avenida dos Anjos, 456');

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (101, 3, 80.5, 1);

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (102, 4, 100.2, 1);

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (103, 4, 100, 1);

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (104, 3, 80.5, 1);

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (105, 3, 80.5, 1);

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (106, 3, 80.5, 1);

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (107, 3, 80.5, 1);

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (108, 4, 100, 1);

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (109, 3, 80.5, 1);

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (110, 4, 100,  1);

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (201, 2, 60.3, 2);

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (202, 3, 75.8, 2);

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (203, 5, 81.3, 2);

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (204, 5, 81.3, 2);

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (205, 5, 81.3, 2);

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (206, 5, 81.3, 2);

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (207, 5, 81.3, 2);

INSERT INTO apartamentos (num_apartamento, num_comodos, metragem, num_predio) VALUES (208, 5, 81.3, 2);

INSERT INTO areas_comuns (endereco, tipo) VALUES ('Rua das Flores, 123', 'Piscina');

INSERT INTO areas_comuns (endereco, tipo) VALUES ('Avenida dos Anjos, 456', 'Salão de Festas');

INSERT INTO areas_comuns (endereco, tipo) VALUES ('Avenida dos Anjos, 456', 'Piscina');

INSERT INTO pessoas (cpf, nome, email) VALUES ('12345678901', 'João Silva', 'joao@example.com');

INSERT INTO pessoas (cpf, nome, email) VALUES ('23456789012', 'Maria Souza', 'maria@example.com');

INSERT INTO pessoas (cpf, nome, email) VALUES ('34567890123', 'Carlos Oliveira', 'carlos@example.com');

INSERT INTO pessoas (cpf, nome, email) VALUES ('98765432109', 'José Santos', 'jose@example.com');

INSERT INTO pessoas (cpf, nome, email) VALUES ('56789012345', 'Paulo Fernando', 'pf@example.com');

INSERT INTO pessoas (cpf, nome, email) VALUES ('67890123456', 'Lula', 'fol@example.com');

INSERT INTO pessoas (cpf, nome, email) VALUES ('87890123421', 'Cris', 'cris@example.com');

INSERT INTO pessoas (cpf, nome, email) VALUES ('11111111111', 'Davi', 'davi@example.com');

INSERT INTO pessoas (cpf, nome, email) VALUES ('22222222222', 'Bianca', 'bianca@example.com');

INSERT INTO pessoas (cpf, nome, email) VALUES ('45678901234', 'Ana Santos', 'ana@example.com');

INSERT INTO pessoas (cpf, nome, email) VALUES ('12344321567', 'João Pedro Pedrosa', 'joaopedrosa@example.com');

INSERT INTO pessoas (cpf, nome, email) VALUES ('98989898989', 'Maria Mariana de Jesus', 'mariamariana@example.com');

INSERT INTO telefones (telefone, cpf) VALUES ('9988776655', '12345678901');

INSERT INTO telefones (telefone, cpf) VALUES ('9977665544', '23456789012');

INSERT INTO telefones (telefone, cpf) VALUES ('9966554433', '34567890123');

INSERT INTO telefones (telefone, cpf) VALUES ('9955443322', '45678901234');

INSERT INTO moradores(cpf, num_apartamento) VALUES ('11111111111', '201');

INSERT INTO moradores(cpf, num_apartamento) VALUES ('22222222222', '201');

INSERT INTO moradores(cpf, num_apartamento) VALUES ('45678901234', '101');

INSERT INTO moradores(cpf, num_apartamento) VALUES ('12344321567', '201');

INSERT INTO moradores(cpf, num_apartamento) VALUES ('98989898989', '201');

INSERT INTO sindicos (cpf, profissao, num_predio) VALUES ('12345678901', 'Advogado', 1);

INSERT INTO sindicos (cpf, profissao, num_predio) VALUES ('23456789012', 'Engenheiro', 2);

INSERT INTO funcionarios (cpf, cargo, salario, cpf_supervisor, num_predio) VALUES ('98765432109', 'Supervisor', 2500.00, '98765432109', 1);

INSERT INTO funcionarios (cpf, cargo, salario, cpf_supervisor, num_predio) VALUES ('12345678901', 'Porteiro', 2800.00,'98989898989', 2);

INSERT INTO funcionarios (cpf, cargo, salario, cpf_supervisor, num_predio) VALUES ('23456789012', 'Zelador', 2800.00, '98765432109', 1);

INSERT INTO funcionarios (cpf, cargo, salario, cpf_supervisor, num_predio) VALUES ('34567890123', 'Zelador', 2800.00, '98989898989', 2);

INSERT INTO funcionarios (cpf, cargo, salario, cpf_supervisor, num_predio) VALUES ('98989898989', 'Supervisora', 2800.00, '98989898989', 2);

INSERT INTO registros (cod_registro, foto_RG) VALUES (1, EMPTY_BLOB());

INSERT INTO registros (cod_registro, foto_RG) VALUES (2, EMPTY_BLOB());

INSERT INTO registros (cod_registro, foto_RG) VALUES (3, EMPTY_BLOB());

INSERT INTO visitantes (cpf, num_apartamento_informado, num_predio_informado) VALUES ('56789012345', 101,1);

INSERT INTO visitantes (cpf, num_apartamento_informado, num_predio_informado) VALUES ('67890123456', 102,1);

INSERT INTO visitantes (cpf, num_apartamento_informado, num_predio_informado) VALUES ('87890123421', 101,1);

INSERT INTO visitas (cod_registro, cpf, data_visita, horario_visita, num_apartamento ) VALUES (1, '56789012345', TO_DATE('2024-03-10', 'YYYY-MM-DD'), TO_TIMESTAMP('18:00:00', 'HH24:MI:SS'), 101);

INSERT INTO visitas (cod_registro, cpf, data_visita, horario_visita, num_apartamento) VALUES (2, '67890123456', TO_DATE('2024-03-12','YYYY-MM-DD'), TO_TIMESTAMP('11:00:00', 'HH24:MI:SS'),102);

INSERT INTO visitas (cod_registro, cpf, data_visita, horario_visita, num_apartamento) VALUES (3, '87890123421', TO_DATE('2024-02-10','YYYY-MM-DD'), TO_TIMESTAMP('15:00:00','HH24:MI:SS'), 101);

INSERT INTO servicos (num_apartamento, cpf, data_servico, horario_servico, descricao_servico) VALUES (202,  '23456789012', TO_DATE('2024-03-19', 'YYYY-MM-DD'), TO_TIMESTAMP('14:05:00','HH24:MI:SS'), 'Limpeza de caixa de gordura');

INSERT INTO servicos (num_apartamento, cpf, data_servico, horario_servico, descricao_servico) VALUES (101,   '12345678901', TO_DATE('2024-03-18','YYYY-MM-DD'), TO_TIMESTAMP('15:00:00','HH24:MI:SS'),  'Manutenção de ar-condicionados') ;

INSERT INTO empresas_servicos (CNPJ) VALUES ('12345678901234');

INSERT INTO servicos (num_apartamento, cpf, data_servico, horario_servico, descricao_servico) VALUES (101,   '12345678901' ,TO_DATE('2024-03-15','YYYY-MM-DD'), TO_TIMESTAMP('16:00:00','HH24:MI:SS'),  'Manutenção de ar-condicionados');

INSERT INTO empresas_servicos (CNPJ) VALUES ( '12345678901256');

INSERT INTO empresas_servicos (CNPJ) VALUES ( '12345678901253');

INSERT INTO contrata (num_apartamento, cpf, data_servico, horario_servico, cnpj) VALUES (202, '23456789012',TO_DATE('2024-03-19','YYYY-MM-DD'), TO_TIMESTAMP('14:05:00','HH24:MI:SS'),'12345678901234');

INSERT INTO contrata (num_apartamento, cpf, data_servico, horario_servico, cnpj) VALUES (101, '12345678901', TO_DATE('2024-03-18','YYYY-MM-DD'), TO_TIMESTAMP('15:00:00','HH24:MI:SS'), '12345678901256');

INSERT INTO contrata (num_apartamento, cpf, data_servico, horario_servico, cnpj) VALUES (101, '12345678901', TO_DATE('2024-03-15','YYYY-MM-DD'), TO_TIMESTAMP('16:00:00','HH24:MI:SS'), '12345678901253');

INSERT INTO reservas (num_apartamento, endereco, tipo, data_reserva, horario_reserva) VALUES (101,'Rua das Flores, 123', 'Piscina', TO_DATE ('2024-03-05','YYYY-MM-DD'), TO_TIMESTAMP('15:00:00', 'HH24:MI:SS'));

INSERT INTO reservas (num_apartamento, endereco, tipo, data_reserva, horario_reserva) VALUES (201, 'Avenida dos Anjos, 456', 'Salão de Festas', TO_DATE('2024-03-10','YYYY-MM-DD'), TO_TIMESTAMP('18:00:00', 'HH24:MI:SS'));

INSERT INTO reservas (num_apartamento, endereco, tipo, data_reserva, horario_reserva) VALUES (201, 'Avenida dos Anjos, 456', 'Piscina', TO_DATE('2024-03-10','YYYY-MM-DD'), TO_TIMESTAMP('18:00:00','HH24:MI:SS'));

