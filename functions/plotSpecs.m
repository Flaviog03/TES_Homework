function plotSpecs(X_fft, fs, titolo)
    % Input: 
    %   X_fft: il risultato della trasformata (vettore complesso)
    %   fs: frequenza di campionamento
    %   titolo: stringa per il grafico

    N = length(X_fft);
    
    % 1. Applicazione di fftshift
    % Sposta la componente a frequenza zero al centro dello spettro
    X_shifted = fftshift(X_fft);
    
    % 2. Calcolo Spettro di Energia |X(k)|^2
    energy_spectrum = abs(X_shifted).^2;
    
    % 3. Creazione Asse Frequenze Centrato
    % L'asse ora va da -fs/2 a +fs/2 (circa)
    % Usiamo floor/ceil per gestire sia N pari che dispari in modo robusto
    f_axis = (-floor(N/2) : ceil(N/2)-1) * (fs / N);
    
    % Converti in kHz
    f_axis_kHz = f_axis / 1000; 
    
    figure('Name', titolo);
    
    % Grafico 1: Scala Lineare
    subplot(2,1,1);
    plot(f_axis_kHz, energy_spectrum); % Plottiamo TUTTO il vettore, non solo metà
    title(['Spettro Energia (Lineare) Centrato - ' titolo]);
    xlabel('Frequenza (kHz)'); ylabel('Energia');
    grid on;
    xlim([min(f_axis_kHz) max(f_axis_kHz)]); % Fissa i limiti dell'asse X
    
    % Grafico 2: Scala Logaritmica (dB)
    subplot(2,1,2);
    % Aggiungiamo eps per evitare log(0)
    plot(f_axis_kHz, 10*log10(energy_spectrum + eps));
    title(['Spettro Energia (Logaritmico) Centrato - ' titolo]);
    xlabel('Frequenza (kHz)'); ylabel('Energia (dB)');
    grid on;
    xlim([min(f_axis_kHz) max(f_axis_kHz)]);
end