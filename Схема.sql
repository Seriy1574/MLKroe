CREATE TABLE accounts (
  id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  number_count varchar(50) DEFAULT NULL,
  id_client bigint(20) unsigned NOT NULL,
  id_type_product int(10) unsigned NOT NULL,
  sum_credit float NOT NULL,
  date_credit datetime NOT NULL,
  credit_term int(10) unsigned NOT NULL,
  dpd int(10) unsigned NOT NULL,
  id_bank int(10) unsigned NOT NULL,
  sum_dept float unsigned DEFAULT NULL,
  UNIQUE KEY id (id),
  KEY id_client_fk (id_client),
  KEY id_product_fk (id_type_product),
  KEY id_bank_fk (id_bank),
  CONSTRAINT id_bank_fk FOREIGN KEY (id_bank) REFERENCES banks (id) ON DELETE CASCADE,
  CONSTRAINT id_client_fk FOREIGN KEY (id_client) REFERENCES clients (id) ON DELETE CASCADE,
  CONSTRAINT id_product_fk FOREIGN KEY (id_type_product) REFERENCES types_products (id) ON DELETE CASCADE
);

CREATE TABLE actions_employees (
  id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  id_client bigint(20) unsigned NOT NULL,
  id_employee bigint(20) unsigned NOT NULL,
  id_type_action int(10) unsigned NOT NULL,
  id_result_action int(10) unsigned NOT NULL,
  date_action datetime DEFAULT CURRENT_TIMESTAMP,
  id_contact int(10) unsigned NOT NULL,
  id_promise bigint(20) DEFAULT NULL,
  UNIQUE KEY id (id),
  KEY id_act_empl_fk (id_employee),
  KEY id_act_clien_fk (id_client),
  KEY id_act_type_fk (id_type_action),
  KEY id_act_result_fk (id_result_action),
  KEY id_type_cont_fk (id_contact),
  CONSTRAINT id_act_clien_fk FOREIGN KEY (id_client) REFERENCES clients (id) ON DELETE CASCADE,
  CONSTRAINT id_act_empl_fk FOREIGN KEY (id_employee) REFERENCES profiles_employeers (id) ON DELETE CASCADE,
  CONSTRAINT id_act_result_fk FOREIGN KEY (id_result_action) REFERENCES results_actions (id) ON DELETE CASCADE,
  CONSTRAINT id_act_type_fk FOREIGN KEY (id_type_action) REFERENCES types_actions (id) ON DELETE CASCADE,
  CONSTRAINT id_type_cont_fk FOREIGN KEY (id_contact) REFERENCES contacts (id) ON DELETE CASCADE
);

CREATE TABLE addresses_clients (
  id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  id_client bigint(20) unsigned DEFAULT NULL,
  id_type int(10) unsigned NOT NULL,
  actual tinyint(1) DEFAULT NULL,
  id_region bigint(20) unsigned NOT NULL,
  address varchar(200) DEFAULT NULL,
  UNIQUE KEY id (id),
  KEY id_addr_id_fk (id_client),
  KEY id_type_addr_id_fk (id_type),
  KEY id_reg_reg_fk (id_region),
  CONSTRAINT id_addr_id_fk FOREIGN KEY (id_client) REFERENCES clients (id) ON DELETE CASCADE,
  CONSTRAINT id_reg_reg_fk FOREIGN KEY (id_region) REFERENCES regions (id) ON DELETE CASCADE,
  CONSTRAINT id_type_addr_id_fk FOREIGN KEY (id_type) REFERENCES types_adresses (id) ON DELETE CASCADE
);

CREATE TABLE banks (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(20) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id)
); 

CREATE TABLE clients (
  id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  first_name varchar(20) NOT NULL,
  last_name varchar(20) NOT NULL,
  patronymic varchar(20) NOT NULL,
  passport varchar(20) NOT NULL,
  birthday datetime NOT NULL,
  UNIQUE KEY id (id)
) ;
CREATE TABLE clients_employees (
  id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  id_employee bigint(20) unsigned NOT NULL,
  id_client bigint(20) unsigned NOT NULL,
  ds datetime DEFAULT CURRENT_TIMESTAMP,
  df datetime DEFAULT NULL,
  UNIQUE KEY id (id),
  KEY id_cl_cl_fk (id_client),
  KEY id_em_em_fk (id_employee),
  CONSTRAINT id_cl_cl_fk FOREIGN KEY (id_client) REFERENCES clients (id) ON DELETE CASCADE,
  CONSTRAINT id_em_em_fk FOREIGN KEY (id_employee) REFERENCES profiles_employeers (id) ON DELETE CASCADE
);

CREATE TABLE contacts (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(20) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id)
);

CREATE TABLE contacts_employees (
  id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  id_employee bigint(20) unsigned NOT NULL,
  phone_number varchar(20) DEFAULT NULL,
  email varchar(50) NOT NULL,
  UNIQUE KEY id (id),
  UNIQUE KEY email (email),
  KEY id_cont_emp_fk (id_employee),
  CONSTRAINT id_cont_emp_fk FOREIGN KEY (id_employee) REFERENCES profiles_employeers (id) ON DELETE CASCADE
);

CREATE TABLE payments (
  id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  id_account bigint(20) unsigned NOT NULL,
  sum_payment float NOT NULL,
  date_payment datetime NOT NULL,
  UNIQUE KEY id (id),
  KEY id_payment_fk (id_account),
  CONSTRAINT id_payment_fk FOREIGN KEY (id_account) REFERENCES accounts (id) ON DELETE CASCADE
);

CREATE TABLE phones_clients (
  id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  id_client bigint(20) unsigned NOT NULL,
  number varchar(50) DEFAULT NULL,
  actual tinyint(1) NOT NULL,
  id_type_phone int(10) unsigned NOT NULL,
  UNIQUE KEY id (id),
  KEY phones_clients_id_fk (id_type_phone),
  KEY id_phone_id_fk (id_client),
  CONSTRAINT id_phone_id_fk FOREIGN KEY (id_client) REFERENCES clients (id) ON DELETE CASCADE,
  CONSTRAINT phones_clients_id_fk FOREIGN KEY (id_type_phone) REFERENCES types_phones (id) ON DELETE CASCADE
);

CREATE TABLE positions (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(30) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE profiles_employeers (
  id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  first_name varchar(50) NOT NULL,
  last_name varchar(50) NOT NULL,
  patronymic varchar(50) NOT NULL,
  birthday datetime DEFAULT NULL,
  id_region bigint(20) unsigned DEFAULT NULL,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  block tinyint(1) DEFAULT NULL,
  date_block datetime DEFAULT NULL,
  id_pozition int(10) unsigned DEFAULT NULL,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY id (id),
  KEY id_position_fk (id_pozition),
  KEY id_reg_empl_fk (id_region),
  CONSTRAINT id_position_fk FOREIGN KEY (id_pozition) REFERENCES positions (id) ON DELETE CASCADE,
  CONSTRAINT id_reg_empl_fk FOREIGN KEY (id_region) REFERENCES regions (id) ON DELETE CASCADE
);

CREATE TABLE promises (
  id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  id_account bigint(20) unsigned DEFAULT NULL,
  date_promise datetime DEFAULT CURRENT_TIMESTAMP,
  date_payment datetime NOT NULL,
  id_employee bigint(20) unsigned NOT NULL,
  id_promise bigint(20) unsigned NOT NULL,
  UNIQUE KEY id (id),
  KEY id_prom_action_fk (id_promise),
  KEY id_prom_empl_fk (id_employee),
  KEY id_promise_fk (id_account),
  CONSTRAINT id_prom_action_fk FOREIGN KEY (id_promise) REFERENCES actions_employees (id) ON DELETE CASCADE,
  CONSTRAINT id_prom_empl_fk FOREIGN KEY (id_employee) REFERENCES profiles_employeers (id) ON DELETE CASCADE,
  CONSTRAINT id_promise_fk FOREIGN KEY (id_account) REFERENCES accounts (id) ON DELETE CASCADE
);

CREATE TABLE regions (
  id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) DEFAULT NULL,
  id_parent bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  UNIQUE KEY id_2 (id),
  KEY id_reg_parent_fk (id_parent),
  CONSTRAINT id_reg_parent_fk FOREIGN KEY (id_parent) REFERENCES regions (id) ON DELETE CASCADE
);

CREATE TABLE results_actions (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(20) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id)
);

CREATE TABLE types_actions (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id)
);

CREATE TABLE types_adresses (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(20) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id)
);

CREATE TABLE types_phones (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(20) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE types_products (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(20) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id)
);
