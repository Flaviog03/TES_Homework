function plotSpecsBilateral(xn, X_fft, fs, titolo)
    % Input: 
    %   xn: il segnale nel dominio del tempo (vettore reale)
    %   X_fft: il risultato della trasformata (vettore complesso)
    %   fs: frequenza di campionamento
    %   titolo: stringa per identificare il grafico

    N = length(X_fft);
    
    % --- Preparazione Dati Tempo ---
    % Crea vettore dei tempi da 0 a M secondi
    t_axis = (0:N-1) / fs;
    
    % --- Preparazione Dati Frequenza ---
    % 1. Shift: Sposta la componente DC (0 Hz) al centro
    X_shifted = fftshift(X_fft);
    
    % 2. Calcola Spettro di Energia |X(k)|^2
    energy_spectrum = abs(X_shifted).^2;
    
    % 3. Crea Asse Frequenze Centrato (-Fs/2 ... 0 ... +Fs/2)
    f_axis = (-floor(N/2) : ceil(N/2)-1) * (fs / N);
    f_axis_kHz = f_axis / 1000; 
    
    % --- Creazione Figura ---
    figure('Name', ['Analisi Tempo-Frequenza - ' titolo]);
    
    % GRAFICO 1: Dominio del Tempo (L'onda sonora)
    subplot(2,1,1);
    plot(t_axis, xn);
    title(['Dominio del Tempo - ' titolo]);
    xlabel('Tempo (s)'); 
    ylabel('Ampiezza');
    grid on;
    xlim([0 max(t_axis)]); % Fissa i limiti da 0 alla fine della finestra
    
    % GRAFICO 2: Dominio della Frequenza (Spettro Bilaterale)
    subplot(2,1,2);
    % Usiamo scala Logaritmica (dB) perché è la più leggibile
    plot(f_axis_kHz, 10*log10(energy_spectrum + eps));
    title(['Dominio della Frequenza (Spettro Bilaterale)']);
    xlabel('Frequenza (kHz)'); 
    ylabel('Energia (dB)');
    grid on;
    xlim([min(f_axis_kHz) max(f_axis_kHz)]);
    
    % Linea rossa sullo zero Hz per riferimento
    xline(0, '--r', 'DC');
end