%% 1. Definizione del File
% Assicurati che il file sia nella cartella corrente o usa il percorso completo
rockFile = 'rock.flac'; 
classicFile = 'classic.flac';

%% 2. Ottenere le informazioni (senza caricare tutto)
% Usiamo audioinfo per scoprire la frequenza (Fs) e la durata totale
rockInfo = audioinfo(rockFile);
rockFs = rockInfo.SampleRate;

classicInfo = audioinfo(classicFile);
classicFs = classicInfo.SampleRate;

%% 3. Calcolare l'intervallo di 30 secondi
% Moltiplichiamo i secondi desiderati per la frequenza
secondsToPlay = 30;
rockEndSample = secondsToPlay * rockFs;
classicEndSample = secondsToPlay * classicFs;

%% 4. Leggere e Riprodurre
% Leggiamo solo dal campione 1 fino al campione calcolato
[y, Fs] = audioread(classicFile, [1, classicEndSample]);

disp(['Riproduzione dei primi ', num2str(secondsToPlay), ' secondi...']);
sound(y, Fs);