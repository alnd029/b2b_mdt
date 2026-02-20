CREATE TABLE IF NOT EXISTS mdt_reports (
  id VARCHAR(64) PRIMARY KEY,
  identifier VARCHAR(80) NOT NULL,
  payload LONGTEXT NOT NULL,
  status VARCHAR(32) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  INDEX idx_identifier (identifier),
  INDEX idx_status (status)
);
CREATE TABLE IF NOT EXISTS mdt_citizens (identifier VARCHAR(80) PRIMARY KEY, payload LONGTEXT NOT NULL, updated_at DATETIME NOT NULL, INDEX idx_identifier (identifier));
CREATE TABLE IF NOT EXISTS mdt_vehicles (plate VARCHAR(20) PRIMARY KEY, vin VARCHAR(64), owner_identifier VARCHAR(80), payload LONGTEXT NOT NULL, INDEX idx_owner (owner_identifier), INDEX idx_vin (vin));
CREATE TABLE IF NOT EXISTS mdt_weapons (serial VARCHAR(64) PRIMARY KEY, model VARCHAR(80), owner_identifier VARCHAR(80), payload LONGTEXT NOT NULL, INDEX idx_model (model), INDEX idx_owner (owner_identifier));
