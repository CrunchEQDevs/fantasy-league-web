<?php
/**
 * Controller de Autenticação
 * Gerencia login via WhatsApp OTP
 */

require_once '../models/User.php';
require_once '../utils/Response.php';

class AuthController {
    private $userModel;

    public function __construct() {
        $database = new Database();
        $db = $database->getConnection();
        $this->userModel = new User($db);
    }

    public function handleRequest($method, $params) {
        $action = $params[0] ?? null;

        switch ($action) {
            case 'send-otp':
                if ($method === 'POST') {
                    $this->sendOTP();
                } else {
                    Response::error('Método não permitido', 405);
                }
                break;

            case 'verify-otp':
                if ($method === 'POST') {
                    $this->verifyOTP();
                } else {
                    Response::error('Método não permitido', 405);
                }
                break;

            default:
                Response::notFound('Ação não encontrada');
        }
    }

    private function sendOTP() {
        $data = json_decode(file_get_contents('php://input'), true);

        if (!isset($data['phone_number'])) {
            Response::validationError(['phone_number' => 'Número de telefone é obrigatório']);
        }

        $phoneNumber = $data['phone_number'];

        // Gerar código OTP de 6 dígitos
        $otpCode = str_pad(rand(0, 999999), 6, '0', STR_PAD_LEFT);

        // TODO: Integrar com Twilio/WhatsApp API para enviar OTP
        // Por enquanto, apenas retornar o código (REMOVER EM PRODUÇÃO)

        // Salvar OTP no banco
        $expiresAt = date('Y-m-d H:i:s', strtotime('+10 minutes'));

        try {
            $database = new Database();
            $db = $database->getConnection();

            $query = "INSERT INTO auth_otp (phone_number, otp_code, expires_at)
                      VALUES (:phone, :otp, :expires)";
            $stmt = $db->prepare($query);
            $stmt->execute([
                ':phone' => $phoneNumber,
                ':otp' => $otpCode,
                ':expires' => $expiresAt
            ]);

            Response::success([
                'phone_number' => $phoneNumber,
                'otp_code' => $otpCode, // REMOVER EM PRODUÇÃO
                'expires_in' => 600 // 10 minutos em segundos
            ], 'Código OTP enviado com sucesso');

        } catch (Exception $e) {
            Response::error('Erro ao enviar OTP: ' . $e->getMessage(), 500);
        }
    }

    private function verifyOTP() {
        $data = json_decode(file_get_contents('php://input'), true);

        if (!isset($data['phone_number']) || !isset($data['otp_code'])) {
            Response::validationError([
                'phone_number' => 'Número de telefone é obrigatório',
                'otp_code' => 'Código OTP é obrigatório'
            ]);
        }

        $phoneNumber = $data['phone_number'];
        $otpCode = $data['otp_code'];

        try {
            $database = new Database();
            $db = $database->getConnection();

            // Verificar OTP
            $query = "SELECT * FROM auth_otp
                      WHERE phone_number = :phone
                      AND otp_code = :otp
                      AND expires_at > NOW()
                      AND is_used = FALSE
                      ORDER BY created_at DESC
                      LIMIT 1";
            $stmt = $db->prepare($query);
            $stmt->execute([
                ':phone' => $phoneNumber,
                ':otp' => $otpCode
            ]);

            $otpRecord = $stmt->fetch();

            if (!$otpRecord) {
                Response::error('Código OTP inválido ou expirado', 401);
            }

            // Marcar OTP como usado
            $updateQuery = "UPDATE auth_otp SET is_used = TRUE WHERE id = :id";
            $updateStmt = $db->prepare($updateQuery);
            $updateStmt->execute([':id' => $otpRecord['id']]);

            // Buscar ou criar usuário
            $user = $this->userModel->findByPhone($phoneNumber);

            if (!$user) {
                // Criar novo usuário
                $userId = $this->userModel->create([
                    'phone_number' => $phoneNumber,
                    'name' => 'Novo Usuário' // Pode pedir nome posteriormente
                ]);
                $user = $this->userModel->findById($userId);
            }

            // Gerar token (simplificado - usar JWT em produção)
            $token = base64_encode($user['id'] . ':' . time());

            Response::success([
                'user' => $user,
                'token' => $token
            ], 'Login realizado com sucesso', 201);

        } catch (Exception $e) {
            Response::error('Erro ao verificar OTP: ' . $e->getMessage(), 500);
        }
    }
}
