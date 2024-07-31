## Sistema Anti-DDOS e Otimização para SA-MP

Este script para SA-MP (San Andreas Multiplayer) foi desenvolvido com o objetivo de proteger o servidor contra ataques DDOS e otimizar o desempenho, monitorando e controlando várias atividades que podem sobrecarregar o servidor. 

### Funcionalidades

1. **Monitoramento de Conexões**:
   - **Função**: `CheckDDOS`
   - **Descrição**: Verifica o número de jogadores conectados e, se exceder um limite definido (`MAX_PLAYER_CONNECT`), desconecta todos os jogadores para evitar um possível ataque DDOS.

2. **Monitoramento de Explosões**:
   - **Função**: `CheckExplosions`
   - **Descrição**: Monitora o número de explosões no servidor. Se o número de explosões ultrapassar o limite definido (`MAX_EXPLOSION`), o servidor será reiniciado automaticamente para prevenir possíveis abusos ou ataques.

3. **Monitoramento de Mortes**:
   - **Função**: `CheckKills`
   - **Descrição**: Controla o número de mortes no servidor. Caso o número de mortes exceda o limite estabelecido (`MAX_KILLS`), o servidor será reiniciado para evitar abusos.

4. **Monitoramento de Veículos Próximos**:
   - **Função**: `CheckVehicles`
   - **Descrição**: Verifica a proximidade dos veículos em relação aos jogadores. Se mais de um número definido de veículos (`MAX_CAR_WITHIN_5_METERS`) estiverem muito próximos, eles serão reposicionados aleatoriamente para evitar congestionamentos e possíveis travamentos.

5. **Eventos de Conexão e Desconexão de Jogadores**:
   - **Funções**: `OnPlayerConnect` e `OnPlayerDisconnect`
   - **Descrição**: Controla a contagem de jogadores conectados e desconectados, exibindo mensagens de boas-vindas e tradução.

6. **Eventos de Morte de Jogadores**:
   - **Função**: `OnPlayerDeath`
   - **Descrição**: Incrementa a contagem de mortes e define um temporizador para resetar essa contagem após um período.

7. **Eventos de Explosão de Veículos**:
   - **Função**: `OnVehicleExplode`
   - **Descrição**: Incrementa a contagem de explosões e define um temporizador para resetar essa contagem após um período.

### Estrutura do Código

- **Constantes**: Definidas para controlar os limites de conexões, explosões, veículos próximos e mortes.
- **Variáveis Globais**: Usadas para manter a contagem de jogadores conectados, explosões e mortes.
- **Protótipos de Funções**: Declaradas para organizar e antecipar o uso das funções no código.
- **Funções Auxiliares**: Inclui funções como `floatrandom` para gerar números aleatórios e `GetDistanceBetweenPoints3D` para calcular a distância entre dois pontos 3D.

### Como Usar

1. **Instalação**:
   - Coloque o script `Ant_ddos.pwn` na pasta `filterscripts` do seu servidor SA-MP.

2. **Compilação**:
   - Compile o script utilizando o compilador Pawn incluído no pacote SA-MP Server.

3. **Configuração**:
   - Adicione `Ant_ddos` à linha `filterscripts` no arquivo `server.cfg` para carregar o script quando o servidor iniciar.

### Créditos

- **Desenvolvimento e Tradução**: Shaka

Este script é uma ferramenta poderosa para manter seu servidor SA-MP protegido contra abusos e ataques, garantindo um ambiente de jogo mais estável e seguro.
