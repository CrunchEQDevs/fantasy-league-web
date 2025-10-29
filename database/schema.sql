-- Fantasy League Database Schema
-- Criado em: 2025-10-23

-- Criar banco de dados
CREATE DATABASE IF NOT EXISTS fantasy_league CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE fantasy_league;

-- Tabela de usuários
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    profile_picture VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    INDEX idx_phone (phone_number),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela de autenticação OTP
CREATE TABLE IF NOT EXISTS auth_otp (
    id INT AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(20) NOT NULL,
    otp_code VARCHAR(6) NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    is_used BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_phone_otp (phone_number, otp_code),
    INDEX idx_expires (expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela de ligas
CREATE TABLE IF NOT EXISTS leagues (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    owner_id INT NOT NULL,
    max_participants INT DEFAULT 10,
    league_code VARCHAR(10) UNIQUE NOT NULL,
    start_date DATE,
    end_date DATE,
    status ENUM('draft', 'active', 'finished') DEFAULT 'draft',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_code (league_code),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela de participantes da liga
CREATE TABLE IF NOT EXISTS league_participants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    league_id INT NOT NULL,
    user_id INT NOT NULL,
    team_name VARCHAR(100) NOT NULL,
    points INT DEFAULT 0,
    ranking_position INT,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (league_id) REFERENCES leagues(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_league (league_id, user_id),
    INDEX idx_points (points DESC),
    INDEX idx_league (league_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela de jogadores reais
CREATE TABLE IF NOT EXISTS real_players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(20) NOT NULL,
    team VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    photo_url VARCHAR(255),
    total_points INT DEFAULT 0,
    status ENUM('available', 'injured', 'suspended') DEFAULT 'available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_position (position),
    INDEX idx_team (team),
    INDEX idx_price (price)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela de times dos participantes
CREATE TABLE IF NOT EXISTS participant_teams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    participant_id INT NOT NULL,
    player_id INT NOT NULL,
    is_captain BOOLEAN DEFAULT FALSE,
    is_bench BOOLEAN DEFAULT FALSE,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (participant_id) REFERENCES league_participants(id) ON DELETE CASCADE,
    FOREIGN KEY (player_id) REFERENCES real_players(id) ON DELETE CASCADE,
    UNIQUE KEY unique_participant_player (participant_id, player_id),
    INDEX idx_participant (participant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela de rodadas/partidas
CREATE TABLE IF NOT EXISTS matches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    round_number INT NOT NULL,
    home_team VARCHAR(50) NOT NULL,
    away_team VARCHAR(50) NOT NULL,
    match_date TIMESTAMP NOT NULL,
    status ENUM('scheduled', 'live', 'finished') DEFAULT 'scheduled',
    home_score INT DEFAULT 0,
    away_score INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_round (round_number),
    INDEX idx_date (match_date),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela de pontuação dos jogadores por partida
CREATE TABLE IF NOT EXISTS player_match_scores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    match_id INT NOT NULL,
    goals INT DEFAULT 0,
    assists INT DEFAULT 0,
    yellow_cards INT DEFAULT 0,
    red_cards INT DEFAULT 0,
    minutes_played INT DEFAULT 0,
    total_points DECIMAL(10, 2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (player_id) REFERENCES real_players(id) ON DELETE CASCADE,
    FOREIGN KEY (match_id) REFERENCES matches(id) ON DELETE CASCADE,
    UNIQUE KEY unique_player_match (player_id, match_id),
    INDEX idx_match (match_id),
    INDEX idx_player (player_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela de transferências
CREATE TABLE IF NOT EXISTS transfers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    participant_id INT NOT NULL,
    player_in_id INT NOT NULL,
    player_out_id INT NOT NULL,
    transfer_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (participant_id) REFERENCES league_participants(id) ON DELETE CASCADE,
    FOREIGN KEY (player_in_id) REFERENCES real_players(id) ON DELETE CASCADE,
    FOREIGN KEY (player_out_id) REFERENCES real_players(id) ON DELETE CASCADE,
    INDEX idx_participant (participant_id),
    INDEX idx_date (transfer_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela de notificações
CREATE TABLE IF NOT EXISTS notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    type ENUM('info', 'warning', 'success') DEFAULT 'info',
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user (user_id),
    INDEX idx_read (is_read)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
