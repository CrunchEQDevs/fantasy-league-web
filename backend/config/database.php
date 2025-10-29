<?php
/**
 * Configuração do Banco de Dados
 */

define('DB_HOST', 'localhost');
define('DB_NAME', 'fantasy_league');
define('DB_USER', 'root'); // Alterar para 'fantasy_app' em produção
define('DB_PASS', ''); // Alterar para senha segura em produção
define('DB_CHARSET', 'utf8mb4');

class Database {
    private $connection = null;

    public function getConnection() {
        if ($this->connection === null) {
            try {
                $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET;
                $this->connection = new PDO($dsn, DB_USER, DB_PASS);
                $this->connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                $this->connection->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
            } catch(PDOException $e) {
                http_response_code(500);
                echo json_encode([
                    'success' => false,
                    'message' => 'Erro de conexão com o banco de dados',
                    'error' => $e->getMessage()
                ]);
                exit;
            }
        }

        return $this->connection;
    }
}
