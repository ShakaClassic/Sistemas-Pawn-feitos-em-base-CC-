/*
Codigo publico para uso geral, codigo inicialmente feito em C++ para testes, após isso foi adaptado para Pawn. By: Shaka

Scripting: Shaka, Translation: Shaka.
*/

#include <a_samp>
#include <sscanf2>
#include <zcmd>
#include <streamer>

// Constantes
#define MAX_PLAYER_CONNECT 50
#define MAX_EXPLOSION 20
#define MAX_CAR_WITHIN_5_METERS 20
#define MAX_KILLS 50

// Variáveis globais
new playerCount;
new explosionCount;
new killCount;
new Float:vehiclePositions[MAX_PLAYERS][3]; // [playerid][x, y, z]

// Protótipos de função
forward CheckDDOS();
forward CheckExplosions();
forward CheckKills();
forward CheckVehicles();
forward ResetKillCount(playerid);
forward OnVehicleExplode(vehicleid);
forward ResetExplosionCount();
forward Float:floatrandom(Float:min, Float:max);

// Função para calcular a distância entre dois pontos 3D
Float:GetDistanceBetweenPoints3D(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2) {
    return floatsqroot(floatpower(x2 - x1, 2) + floatpower(y2 - y1, 2) + floatpower(z2 - z1, 2));
}

// Função auxiliar para gerar número float aleatório
Float:floatrandom(Float:min, Float:max) {
    return min + (max - min) * float(random(10001)) / 10000.0;
}

public OnGameModeInit() {
    playerCount = 0;
    explosionCount = 0;
    killCount = 0;
    SetTimer("CheckDDOS", 1000, true);
    SetTimer("CheckExplosions", 1000, true);
    SetTimer("CheckKills", 1000, true);
    SetTimer("CheckVehicles", 1000, true);
    return 1;
}

public CheckDDOS() {
    if (playerCount > MAX_PLAYER_CONNECT) {
        for (new i = 0; i < MAX_PLAYERS; i++) {
            if (IsPlayerConnected(i)) {
                Kick(i);
            }
        }
        SendClientMessageToAll(-1, "Muitos jogadores conectados! Desconectando-os devido a um possível ataque DDOS.");
    }
    return 1;
}

public CheckExplosions() {
    if (explosionCount > MAX_EXPLOSION) {
        SendRconCommand("gmx");
        SendClientMessageToAll(-1, "Muitas explosões detectadas! Reiniciando o servidor.");
    }
    return 1;
}

public CheckKills() {
    if (killCount > MAX_KILLS) {
        SendRconCommand("gmx");
        SendClientMessageToAll(-1, "Muitas mortes detectadas! Reiniciando o servidor.");
    }
    return 1;
}

public CheckVehicles() {
    for (new i = 0; i < MAX_PLAYERS; i++) {
        if (IsPlayerConnected(i)) {
            new vehiclesInRange = 0;
            new Float:x1, Float:y1, Float:z1;
            GetPlayerPos(i, x1, y1, z1);
            vehiclePositions[i][0] = x1;
            vehiclePositions[i][1] = y1;
            vehiclePositions[i][2] = z1;
            for (new j = 0; j < MAX_PLAYERS; j++) {
                if (i != j && IsPlayerConnected(j)) {
                    new Float:x2, Float:y2, Float:z2;
                    GetPlayerPos(j, x2, y2, z2);
                    if (GetDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2) < 5.5) {
                        vehiclesInRange++;
                        if (vehiclesInRange > MAX_CAR_WITHIN_5_METERS) {
                            SetPlayerPos(j, x2 + floatrandom(-5.0, 5.0), y2 + floatrandom(-5.0, 5.0), z2);
                        }
                    }
                }
            }
        }
    }
    return 1;
}

public OnPlayerConnect(playerid) {
    playerCount++;
    SendClientMessage(playerid, -1, "Sistema de ANT-DDOS e otimização desenvolvido por: Shaka script");
    SendClientMessage(playerid, -1, "Tradução do sistema de ANT-DDOS e otimização por: Shaka.");
    return 1;
}

public OnPlayerDisconnect(playerid, reason) {
    playerCount--;
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason) {
    killCount++;
    SetTimerEx("ResetKillCount", 10000, false, "i", playerid);
    return 1;
}

public ResetKillCount(playerid) {
    killCount--;
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[]) {
    return 0; // Permitindo outros comandos de filterscripts funcionarem
}

public OnPlayerPickUpPickup(playerid, pickupid) {
    return 1;
}

public OnVehicleExplode(vehicleid) {
    explosionCount++;
    SetTimer("ResetExplosionCount", 10000, false);
    return 1;
}

public ResetExplosionCount() {
    explosionCount = 0;
    return 1;
}
