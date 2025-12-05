function classic(y_r, M, Fs, start)
   % Input:
   % y_r: vettore campioni canale destro
   % M: durata finestra (usato solo per il titolo qui)
   % Fs: frequenza di campionamento
   % start: secondo di inizio taglio
   
   % Configurazione taglio
   l = 5; % durata taglio in secondi
   n = round(Fs * l); 
   
   id_start = round(Fs * start) + 1;
   id_end = id_start + n - 1; 
   
   % Controllo bounds
   if id_end > length(y_r)
       id_end = length(y_r);
   end
   
   % Estrazione e Normalizzazione
   y = y_r(id_start:id_end);
   y = y / max(abs(y)); 
   
   % Calcolo FFT
   Y_fft = fft(y);
   N = length(Y_fft);
   
   % Preparazione Assi Frequenza
   Y_shifted = fftshift(Y_fft);
   energy_spectrum = abs(Y_shifted).^2;
   f_axis = (-floor(N/2) : ceil(N/2)-1) * (Fs / N);
   f_axis_kHz = f_axis / 1000; 

   % Titolo dinamico
   titolo = sprintf('Analisi Classic - Start=%ds (Zoom -2/2 kHz)', start);

   figure('Name', titolo);
   
   % 1. Dominio del Tempo
   t_axis = (0:N-1) / Fs;
   subplot(2,1,1);
   plot(t_axis, y, 'b'); % <--- ORA È BLU ('b')
   title(['Dominio del Tempo - ' titolo]);
   xlabel('Tempo (s)'); 
   ylabel('Ampiezza (a.u.)');
   grid on;
   xlim([0 max(t_axis)]);
   
   % 2. Dominio della Frequenza (Zoomato)
   subplot(2,1,2);
   plot(f_axis_kHz, 10*log10(energy_spectrum + eps), 'b', 'LineWidth', 1.2);
   title('Spettro Bilaterale (dB) - Zoom Pianoforte');
   xlabel('Frequenza (kHz)'); 
   ylabel('Energia (dB a.u.)');
   grid on;
   
   % ZOOM RICHIESTO [-2, 2] kHz
   xlim([-2 2]); 
   xline(0, '--r', 'DC');
end