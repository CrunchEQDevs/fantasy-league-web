<?php
/**
 * Classe utilitária para padronizar respostas da API
 */

class Response {
    public static function success($data = null, $message = 'Sucesso', $statusCode = 200) {
        http_response_code($statusCode);
        echo json_encode([
            'success' => true,
            'message' => $message,
            'data' => $data
        ]);
        exit;
    }

    public static function error($message = 'Erro', $statusCode = 400, $errors = null) {
        http_response_code($statusCode);
        echo json_encode([
            'success' => false,
            'message' => $message,
            'errors' => $errors
        ]);
        exit;
    }

    public static function unauthorized($message = 'Não autorizado') {
        self::error($message, 401);
    }

    public static function notFound($message = 'Recurso não encontrado') {
        self::error($message, 404);
    }

    public static function validationError($errors, $message = 'Erro de validação') {
        self::error($message, 422, $errors);
    }
}
