-- Fantasy League - Dados Iniciais para Testes
USE fantasy_league;

-- Inserir jogadores reais de exemplo
INSERT INTO real_players (name, position, team, price, status) VALUES
-- Atacantes
('Cristiano Ronaldo', 'Atacante', 'Al Nassr', 12.5, 'available'),
('Lionel Messi', 'Atacante', 'Inter Miami', 12.0, 'available'),
('Neymar Jr', 'Atacante', 'Al Hilal', 11.5, 'available'),
('Kylian Mbappé', 'Atacante', 'Real Madrid', 13.0, 'available'),
('Erling Haaland', 'Atacante', 'Manchester City', 12.5, 'available'),
('Harry Kane', 'Atacante', 'Bayern Munich', 11.0, 'available'),
('Robert Lewandowski', 'Atacante', 'Barcelona', 10.5, 'available'),
('Mohamed Salah', 'Atacante', 'Liverpool', 11.5, 'available'),

-- Meio-campistas
('Kevin De Bruyne', 'Meio-campo', 'Manchester City', 10.0, 'available'),
('Luka Modrić', 'Meio-campo', 'Real Madrid', 8.5, 'available'),
('Bruno Fernandes', 'Meio-campo', 'Manchester United', 9.0, 'available'),
('Casemiro', 'Meio-campo', 'Manchester United', 8.0, 'available'),
('Rodri', 'Meio-campo', 'Manchester City', 8.5, 'available'),
('Jude Bellingham', 'Meio-campo', 'Real Madrid', 10.5, 'available'),

-- Defensores
('Virgil van Dijk', 'Zagueiro', 'Liverpool', 7.5, 'available'),
('Rúben Dias', 'Zagueiro', 'Manchester City', 7.0, 'available'),
('Marquinhos', 'Zagueiro', 'PSG', 6.5, 'available'),
('Sergio Ramos', 'Zagueiro', 'Sevilla', 6.0, 'available'),
('Trent Alexander-Arnold', 'Lateral', 'Liverpool', 7.5, 'available'),
('João Cancelo', 'Lateral', 'Barcelona', 7.0, 'available'),

-- Goleiros
('Alisson Becker', 'Goleiro', 'Liverpool', 6.0, 'available'),
('Ederson', 'Goleiro', 'Manchester City', 6.0, 'available'),
('Thibaut Courtois', 'Goleiro', 'Real Madrid', 5.5, 'available'),
('Marc-André ter Stegen', 'Goleiro', 'Barcelona', 5.5, 'available');

-- Inserir usuário de teste
INSERT INTO users (phone_number, name, email) VALUES
('+5511999999999', 'Usuário Teste', 'teste@fantasyleague.com'),
('+5511988888888', 'João Silva', 'joao@fantasyleague.com'),
('+5511977777777', 'Maria Santos', 'maria@fantasyleague.com');

-- Inserir liga de teste
INSERT INTO leagues (name, description, owner_id, league_code, status) VALUES
('Liga dos Campeões', 'Liga de teste entre amigos', 1, 'CHAMP2024', 'active'),
('Brasileirão Fantasy', 'Liga do Brasileirão', 2, 'BRA2024', 'active');

-- Inserir participantes na liga
INSERT INTO league_participants (league_id, user_id, team_name, points) VALUES
(1, 1, 'Time do Teste FC', 0),
(1, 2, 'João FC', 0),
(2, 2, 'João United', 0),
(2, 3, 'Maria FC', 0);

-- Inserir algumas partidas
INSERT INTO matches (round_number, home_team, away_team, match_date, status) VALUES
(1, 'Manchester City', 'Liverpool', '2025-10-25 15:00:00', 'scheduled'),
(1, 'Real Madrid', 'Barcelona', '2025-10-25 17:00:00', 'scheduled'),
(1, 'Bayern Munich', 'PSG', '2025-10-26 15:00:00', 'scheduled');

SELECT 'Seeds executados com sucesso!' as status;
