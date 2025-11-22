function plotSpecs(X_fft, fs, titolo)
    % Input: 
    %   X_fft: il risultato della trasformata (vettore complesso)
    %   fs: frequenza di campionamento (per calcolare l'asse Hz)
    %   titolo: stringa per differenziare i grafici (es. "Finestra 1 - Rock")

    N = length(X_fft);
    
    % 1. Calcolo Spettro di Energia |X(k)|^2
    energy_spectrum = abs(X_fft).^2;
    
    % 2. Creazione Asse Frequenze
    % Genera vettore da 0 a fs
    f_axis = (0:N-1) * (fs / N); 
    % Converti in kHz come richiesto dal testo
    f_axis_kHz = f_axis / 1000; 
    
    % Consideriamo solo metà spettro (fino a Nyquist) per pulizia
    half_N = floor(N/2);
    
    figure('Name', titolo);
    
    % Grafico 1: Scala Lineare
    subplot(2,1,1);
    plot(f_axis_kHz(1:half_N), energy_spectrum(1:half_N));
    title(['Spettro Energia (Lineare) - ' titolo]);
    xlabel('Frequenza (kHz)'); ylabel('Energia');
    grid on;
    
    % Grafico 2: Scala Logaritmica (dB)
    subplot(2,1,2);
    % Aggiungiamo eps per evitare log(0)
    plot(f_axis_kHz(1:half_N), 10*log10(energy_spectrum(1:half_N) + eps));
    title(['Spettro Energia (Logaritmico) - ' titolo]);
    xlabel('Frequenza (kHz)'); ylabel('Energia (dB)');
    grid on;
end