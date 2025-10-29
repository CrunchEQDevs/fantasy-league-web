<?php
/**
 * Model de Usuário
 */

class User {
    private $conn;
    private $table = 'users';

    public function __construct($db) {
        $this->conn = $db;
    }

    public function findById($id) {
        $query = "SELECT id, phone_number, name, email, profile_picture, created_at, is_active
                  FROM " . $this->table . "
                  WHERE id = :id LIMIT 1";
        $stmt = $this->conn->prepare($query);
        $stmt->execute([':id' => $id]);
        return $stmt->fetch();
    }

    public function findByPhone($phoneNumber) {
        $query = "SELECT id, phone_number, name, email, profile_picture, created_at, is_active
                  FROM " . $this->table . "
                  WHERE phone_number = :phone LIMIT 1";
        $stmt = $this->conn->prepare($query);
        $stmt->execute([':phone' => $phoneNumber]);
        return $stmt->fetch();
    }

    public function create($data) {
        $query = "INSERT INTO " . $this->table . "
                  (phone_number, name, email)
                  VALUES (:phone, :name, :email)";
        $stmt = $this->conn->prepare($query);

        $stmt->execute([
            ':phone' => $data['phone_number'],
            ':name' => $data['name'] ?? 'Novo Usuário',
            ':email' => $data['email'] ?? null
        ]);

        return $this->conn->lastInsertId();
    }

    public function update($id, $data) {
        $fields = [];
        $params = [':id' => $id];

        if (isset($data['name'])) {
            $fields[] = "name = :name";
            $params[':name'] = $data['name'];
        }

        if (isset($data['email'])) {
            $fields[] = "email = :email";
            $params[':email'] = $data['email'];
        }

        if (isset($data['profile_picture'])) {
            $fields[] = "profile_picture = :profile_picture";
            $params[':profile_picture'] = $data['profile_picture'];
        }

        if (empty($fields)) {
            return false;
        }

        $query = "UPDATE " . $this->table . " SET " . implode(', ', $fields) . " WHERE id = :id";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute($params);
    }

    public function getAll($limit = 100, $offset = 0) {
        $query = "SELECT id, phone_number, name, email, profile_picture, created_at
                  FROM " . $this->table . "
                  WHERE is_active = TRUE
                  ORDER BY created_at DESC
                  LIMIT :limit OFFSET :offset";
        $stmt = $this->conn->prepare($query);
        $stmt->bindValue(':limit', (int)$limit, PDO::PARAM_INT);
        $stmt->bindValue(':offset', (int)$offset, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll();
    }
}
