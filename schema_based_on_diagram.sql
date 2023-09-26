/* DATA BASE BASED ON A DIAGRAM (README) */
-- CREATE TABLES
CREATE TABLE patient (
  id SERIAL PRIMARY KEY,
  name VARCHAR(25),
  date_of_birth DATE
);

CREATE TABLE medical_history (
  id SERIAL PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT,
  status VARCHAR(25),
  FOREIGN KEY(patient_id) REFERENCES patient(id)
);

CREATE TABLE treatment (
  id SERIAL PRIMARY KEY,
  type VARCHAR(25),
  name VARCHAR(25)
);

CREATE TABLE invoice (
  id SERIAL PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT UNIQUE,
  FOREIGN KEY (medical_history_id) REFERENCES medical_history(id)
);

CREATE TABLE invoice_item (
  id SERIAL PRIMARY KEY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  FOREIGN KEY (invoice_id) REFERENCES invoice(id),
  FOREIGN KEY (treatment_id) REFERENCES treatment(id)
);

CREATE TABLE medical_history_treatment (
  medical_history_id INT,
  treatment_id INT,
  FOREIGN KEY (medical_history_id) REFERENCES medical_history(id),
  FOREIGN KEY (treatment_id) REFERENCES treatment(id)
);

-- CREATE INDEXES
CREATE INDEX idx_medical_history_patient_id ON medical_history(patient_id);

CREATE INDEX idx_invoice_medical_history_id ON invoice(medical_history_id);

CREATE INDEX idx_invoice_item_invoice_id ON invoice_item(invoice_id);

CREATE INDEX idx_invoice_item_treatment_id ON invoice_item(treatment_id);

CREATE INDEX idx_medical_history_treatment_medical_history_id ON medical_history_treatment(medical_history_id);

CREATE INDEX idx_medical_histories__treatment_id ON medical_history_treatment(treatment_id);