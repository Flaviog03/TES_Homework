clc; 
clear; 
close all;
addpath('functions'); 
addpath('data')

audioFile = 'classic.flac';  % 'rock.flac' o 'classic.flac'  
M = 0.7; % durata finestre in secondi                    
analyze_all = false; % 'true' per analizzare tutte le finestre 
max_duration = 30; % limitiamo l'analisi del segnale audio ai primi 30s

fprintf('Caricamento di %s...\n', audioFile);

[y_full, Fs] = audioread(audioFile); % y_full = stereo
y_r = y_full(:, 2); % canale destro
X_r = fft(y_r); % fft del canale destro (durata completa)

% per zombie: grafici aggiuntivi
if strcmp(audioFile, 'rock.mp3')
    zombie(y_r, M, Fs, 2*60 + 34); % finestra solo voce
    zombie(y_r, M, Fs, 2*60 + 15); % finestra strumenti (1)
    zombie(y_r, M, Fs, 3*60 + 45); % finestra strumenti (2)
end

% per classic: grafici aggiuntivi
if strcmp(audioFile, 'classic.flac')
    classic(y_r, M, Fs, 0*60 + 40); % finestra solo voce
    classic(y_r, M, Fs, 3*60 + 40); % finestra strumenti
end

fprintf('Frequenza Campionamento: %d Hz\n', Fs);
disp('Generazione grafico intero file...');
plotSpecsBilateral(y_r, X_r, Fs, 'Analisi Globale Intero Brano'); 

% y contiene solo i campioni di y_r relativi ai primi 30s
samples_limit = min(length(y_r), max_duration * Fs);
y = y_r(1:samples_limit);

N_window = round(M * Fs); % numero di campioni in ogni finestra
num_windows = floor(length(y) / N_window); % numero di finestre in y

fprintf('Durata Finestra: %.2f s (%d campioni)\n', M, N_window);
fprintf('Numero Totale Finestre: %d\n', num_windows);

% vettori dei tempi impiegati per analizzare le finestre
times_myDft = zeros(1, num_windows);
times_fft = zeros(1, num_windows);

% scelta limit_loop
limit_loop = num_windows;
if ~analyze_all
    limit_loop = 2; % modificabile 
    fprintf('\n[MODALITA TEST] Analisi limitata alle prime %d finestre.\n', limit_loop);
    fprintf('Imposta analyze_all = true per processare tutto il file.\n');
end

id_w = 3; % modificabile, è la finestra da cui si parte

% ciclo sulle finestre
for i = id_w:(limit_loop+id_w)
    
    start_idx = (i-1) * N_window + 1;
    end_idx = start_idx + N_window - 1;
    xn = y(start_idx:end_idx); % contiene i campioni della finestra selezionata
    
    fprintf('\n--- Analisi Finestra %d/%d (Intervallo: %.2f - %.2f s) ---\n', ...
        i, num_windows, (i-1)*M, i*M);
    
    % fft su xn e calcolo tempo
    tic;
    X_fft = fft(xn);
    times_fft(i) = toc;
    fprintf('Tempo FFT (Matlab): %.6f s\n', times_fft(i));
    
    % dft su xn e calcolo tempo
    tic;
    X_dft = myDft(xn);
    times_myDft(i) = toc;
    fprintf('Tempo myDft:  %.6f s\n', times_myDft(i));
    
    % mostra i grafici di dft e fft sovrapposti
    titolo = sprintf('Finestra %d (%s) - M=%.1fs', i, audioFile, M);
    plotSpecs(X_fft, X_dft, Fs, titolo);
    drawnow;
end


if limit_loop > 1
    avg_fft = mean(times_fft(5:(limit_loop+5)));
    avg_my = mean(times_myDft(5:(limit_loop+5)));
    
    fprintf('\n=== RIEPILOGO PRESTAZIONI ===\n');
    fprintf('Tempo Medio FFT:   %.6f s\n', avg_fft);
    fprintf('Tempo Medio myDft: %.6f s\n', avg_my);
    fprintf('La FFT è circa %.1f volte più veloce della tua DFT.\n', avg_my/avg_fft);
end