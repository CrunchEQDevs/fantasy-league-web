<?php
/**
 * API Entry Point - Fantasy League
 */

require_once '../config/cors.php';
require_once '../config/database.php';
require_once '../utils/Response.php';

// Obter método HTTP e URI
$method = $_SERVER['REQUEST_METHOD'];
$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$uri = explode('/', trim($uri, '/'));

// Remover 'api' do array se existir
if (isset($uri[0]) && $uri[0] === 'api') {
    array_shift($uri);
}

// Roteamento básico
$endpoint = $uri[0] ?? 'health';

switch ($endpoint) {
    case 'health':
        Response::success([
            'status' => 'online',
            'timestamp' => date('Y-m-d H:i:s'),
            'version' => '1.0.0'
        ], 'API está funcionando');
        break;

    case 'auth':
        require_once '../controllers/AuthController.php';
        $controller = new AuthController();
        $controller->handleRequest($method, array_slice($uri, 1));
        break;

    case 'users':
        require_once '../controllers/UserController.php';
        $controller = new UserController();
        $controller->handleRequest($method, array_slice($uri, 1));
        break;

    case 'leagues':
        require_once '../controllers/LeagueController.php';
        $controller = new LeagueController();
        $controller->handleRequest($method, array_slice($uri, 1));
        break;

    case 'players':
        require_once '../controllers/PlayerController.php';
        $controller = new PlayerController();
        $controller->handleRequest($method, array_slice($uri, 1));
        break;

    default:
        Response::notFound('Endpoint não encontrado');
}
