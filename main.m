%% 1. Setup e Caricamento
clc; clear; close all;
addpath('functions'); % Assicuriamoci che le funzioni siano visibili
addpath('data')

% Configurazioni Utente
audioFile = 'rock2.flac';    % Cambia con 'classic.flac' per l'altro brano
M = 0.5;                    % Durata finestra in secondi (es. 0.5s o 1.0s) [cite: 7]
analyze_all = false;        % Metti 'true' per analizzare TUTTO il file (LENTO!)

% Caricamento Audio
fprintf('Caricamento di %s...\n', audioFile);
[y_full, Fs] = audioread(audioFile);

% Analisi Globale (Fuori dal ciclo)
disp('Generazione grafico intero file...');

% Calcola la FFT su TUTTO il segnale y
X_total = fft(y_full); 

% Passa 'y' intero e la sua FFT
plotSpecsBilateral(y_full, X_total, Fs, 'Analisi Globale Intero Brano');

% Prendiamo solo i primi 30 secondi come da specifiche (o tutto se minore)
max_duration = 30; 
samples_limit = min(length(y_full), max_duration * Fs);
y = y_full(1:samples_limit);

% Calcolo parametri finestra
N_window = round(M * Fs);   % Numero campioni per finestra
num_windows = floor(length(y) / N_window);

fprintf('Frequenza Campionamento: %d Hz\n', Fs);
fprintf('Durata Finestra: %.2f s (%d campioni)\n', M, N_window);
fprintf('Numero Totale Finestre: %d\n', num_windows);

%% 2. Ciclo di Analisi (Finestraggio)
% Prepara vettori per memorizzare i tempi
times_myDft = zeros(1, num_windows);
times_fft = zeros(1, num_windows);

% Se analyze_all è false, analizziamo solo le prime 2 finestre per test
limit_loop = num_windows;
if ~analyze_all
    fprintf('\n[MODALITA TEST] Analisi limitata alle prime 2 finestre.\n');
    fprintf('Imposta analyze_all = true per processare tutto il file.\n');
    limit_loop = 2; 
end

for i = 1:limit_loop
    % 2.1 Estrazione della sotto-finestra
    start_idx = (i-1) * N_window + 1;
    end_idx = start_idx + N_window - 1;
    xn = y(start_idx:end_idx);
    
    fprintf('\n--- Analisi Finestra %d/%d (Intervallo: %.2f - %.2f s) ---\n', ...
        i, num_windows, (i-1)*M, i*M);
    
    % 2.2 Calcolo FFT (Veloce) - Libreria Matlab
    tic;
    X_fft = fft(xn);
    times_fft(i) = toc;
    fprintf('Tempo FFT (Matlab): %.6f s\n', times_fft(i));
    
    % 2.3 Calcolo DFT (Lento) - La tua funzione
    % Nota: su finestre lunghe (es. 1s a 44kHz) questo può impiegare molto!
    tic;
    X_my = myDft(xn);
    times_myDft(i) = toc;
    fprintf('Tempo myDft (Tuo):  %.6f s\n', times_myDft(i));
    
    % 2.4 Visualizzazione (Solo per finestre significative)
    % Plotta lo spettro usando la FFT (più veloce per il grafico) o myDft
    titolo = sprintf('Finestra %d (%s) - M=%.1fs', i, audioFile, M);
    
    % Usiamo X_my per verificare che sia corretto, ma potresti usare X_fft
    plotSpecs(X_my, Fs, titolo);
    
    % Pausa opzionale per guardare il grafico
    drawnow;
end

%% 3. Statistiche Finali (se hai analizzato più finestre)
if limit_loop > 1
    avg_fft = mean(times_fft(1:limit_loop));
    avg_my = mean(times_myDft(1:limit_loop));
    
    fprintf('\n=== RIEPILOGO PRESTAZIONI ===\n');
    fprintf('Tempo Medio FFT:   %.6f s\n', avg_fft);
    fprintf('Tempo Medio myDft: %.6f s\n', avg_my);
    fprintf('La FFT è circa %.1f volte più veloce della tua DFT.\n', avg_my/avg_fft);
end