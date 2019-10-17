USE mobile_collection;


ALTER TABLE phones_clients
    ADD CONSTRAINT phones_clients_id_fk
        FOREIGN KEY (id_type_phone) REFERENCES types_phones(id)
            ON DELETE CASCADE;


ALTER TABLE phones_clients
    ADD CONSTRAINT id_phone_id_fk
        FOREIGN KEY (id_client) REFERENCES clients(id)
            ON DELETE CASCADE;

ALTER TABLE addresses_clients
    ADD CONSTRAINT id_addr_id_fk
        FOREIGN KEY (id_client) REFERENCES clients(id)
            ON DELETE CASCADE;


ALTER TABLE addresses_clients
    ADD CONSTRAINT id_type_addr_id_fk
        FOREIGN KEY (id_type) REFERENCES types_adresses(id)
            ON DELETE CASCADE;


ALTER TABLE accounts
    ADD CONSTRAINT id_client_fk
        FOREIGN KEY (id_client) REFERENCES clients(id)
            ON DELETE CASCADE;

ALTER TABLE accounts
    ADD CONSTRAINT id_bank_fk
        FOREIGN KEY (id_bank) REFERENCES banks(id)
            ON DELETE CASCADE;

ALTER TABLE accounts
    ADD CONSTRAINT id_product_fk
        FOREIGN KEY (id_type_product) REFERENCES types_products(id)
            ON DELETE CASCADE;

ALTER TABLE payments
    ADD CONSTRAINT id_payment_fk
        FOREIGN KEY (id_account) REFERENCES accounts(id)
            ON DELETE CASCADE;


ALTER TABLE promises
    ADD CONSTRAINT id_promise_fk
        FOREIGN KEY (id_account) REFERENCES accounts(id)
            ON DELETE CASCADE;

ALTER TABLE promises
    ADD CONSTRAINT id_prom_empl_fk
        FOREIGN KEY (id_employee) REFERENCES profiles_employeers(id)
            ON DELETE CASCADE;



ALTER TABLE profiles_employeers
    ADD CONSTRAINT id_position_fk
        FOREIGN KEY (id_pozition) REFERENCES positions(id)
            ON DELETE CASCADE;


ALTER TABLE actions_employees
    ADD CONSTRAINT id_act_empl_fk
        FOREIGN KEY (id_employee) REFERENCES profiles_employeers(id)
            ON DELETE CASCADE;

ALTER TABLE actions_employees
    ADD CONSTRAINT id_act_clien_fk
        FOREIGN KEY (id_client) REFERENCES clients(id)
            ON DELETE CASCADE;


ALTER TABLE actions_employees
    ADD CONSTRAINT id_act_type_fk
        FOREIGN KEY (id_type_action) REFERENCES types_actions(id)
            ON DELETE CASCADE;

ALTER TABLE actions_employees
    ADD CONSTRAINT id_act_result_fk
        FOREIGN KEY (id_result_action) REFERENCES results_actions(id)
            ON DELETE CASCADE;

ALTER TABLE contacts_employees
    ADD CONSTRAINT id_cont_emp_fk
        FOREIGN KEY (id_employee) REFERENCES profiles_employeers(id)
            ON DELETE CASCADE;

ALTER TABLE regions
    ADD CONSTRAINT id_reg_parent_fk
        FOREIGN KEY (id_parent) REFERENCES regions(id)
            ON DELETE CASCADE;

alter table regions
    drop foreign key id_reg_parent_fk;



ALTER TABLE profiles_employeers
    ADD CONSTRAINT id_reg_empl_fk
        FOREIGN KEY (id_region) REFERENCES regions(id)
            ON DELETE CASCADE;

alter table profiles_employeers
    drop foreign key id_reg_empl_fk;


ALTER TABLE clients_employees
    ADD CONSTRAINT id_cl_cl_fk
        FOREIGN KEY (id_client) REFERENCES clients(id)
            ON DELETE CASCADE;

ALTER TABLE clients_employees
    ADD CONSTRAINT id_em_em_fk
        FOREIGN KEY (id_employee) REFERENCES profiles_employeers(id)
            ON DELETE CASCADE;


ALTER TABLE employees
    ADD CONSTRAINT id_em_em_fk
        FOREIGN KEY (id_employee) REFERENCES profiles_employeers(id)
            ON DELETE CASCADE;



ALTER TABLE employees
    ADD CONSTRAINT id_employ_fk
        FOREIGN KEY (id) REFERENCES profiles_employeers(id)
            ON DELETE CASCADE;

ALTER TABLE addresses_clients
    ADD CONSTRAINT id_addr_region_fk
        FOREIGN KEY (id) REFERENCES profiles_employeers(id_region)
            ON DELETE CASCADE;

ALTER TABLE employees
    ADD CONSTRAINT id_addr_region_fk
        FOREIGN KEY (id) REFERENCES profiles_employeers(id_region)
            ON DELETE CASCADE;


ALTER TABLE actions_employees
    ADD CONSTRAINT id_prom_action_fk
        FOREIGN KEY (id_promise) REFERENCES promises(id)
            ON DELETE CASCADE;

ALTER TABLE promises
    ADD CONSTRAINT id_prom_action_fk
        FOREIGN KEY (id_promise) REFERENCES actions_employees(id)
            ON DELETE CASCADE;


alter table profiles_employeers
    drop foreign key id_group_fk;


ALTER TABLE profiles_employeers
    ADD CONSTRAINT id_group_fk
        FOREIGN KEY (id_group) REFERENCES groups_employees(id)
            ON DELETE CASCADE;

ALTER TABLE clients
    ADD CONSTRAINT id_type_client_fk
        FOREIGN KEY (id_type_client) REFERENCES types_clients(id)
            ON DELETE CASCADE;