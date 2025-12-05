function plotSpecsBilateral(xn, X_fft, fs, titolo)
   
    N = length(X_fft);
    t_axis = (0:N-1) / fs;

    X_shifted = fftshift(X_fft);
    energy_spectrum = abs(X_shifted).^2;

    f_axis = (-floor(N/2) : ceil(N/2)-1) * (fs / N);
    f_axis_kHz = f_axis / 1000; 

    figure('Name', ['Analisi Tempo-Frequenza - ' titolo]);
    
    subplot(2,1,1);
    plot(t_axis, xn, 'r');
    title(['Dominio del Tempo - ' titolo]);
    xlabel('Tempo (s)'); 
    ylabel('Ampiezza (a.u.)'); % Modificato
    grid on;
    xlim([0 max(t_axis)]); 
    
    subplot(2,1,2);
    plot(f_axis_kHz, 10*log10(energy_spectrum + eps), 'g');
    title(['Dominio della Frequenza (Spettro Bilaterale)']);
    xlabel('Frequenza (kHz)'); 
    ylabel('Energia (dB a.u.)'); % Modificato
    grid on;
    xlim([min(f_axis_kHz) max(f_axis_kHz)]);
       
    xline(0, '--r', 'DC');
end