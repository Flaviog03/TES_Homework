function plotSpecs(X_fft, X_dft, fs, titolo) 

    N = length(X_fft); % X_dft e X_fft hanno la stessa lunghezza
    X_shifted_fft = fftshift(X_fft); 
    X_shifted_dft = fftshift(X_dft); 
    
    energy_spectrum_fft = abs(X_shifted_fft).^2; 
    energy_spectrum_dft = abs(X_shifted_dft).^2; 
    
    f_axis = (-floor(N/2) : ceil(N/2)-1) * (fs / N); 
    f_axis_kHz = f_axis / 1000;  
    figure('Name', titolo); 
    
    subplot(2,1,1); 
    plot(f_axis_kHz, energy_spectrum_fft, 'y', 'LineWidth', 2.5);
    hold on;
    plot(f_axis_kHz, energy_spectrum_dft, 'm', 'LineWidth', 0.5);
    legend('FFT', 'DFT');
    title(['Spettro Energia (Lineare) fft - Zoom [-2, 2] kHz - ' titolo], 'Interpreter', 'none'); 
    xlabel('Frequenza (kHz)'); 
    ylabel('Energia'); 
    grid on; 
    xlim([-2 2]);  
    
    subplot(2,1,2); 
    plot(f_axis_kHz, 10*log10(energy_spectrum_fft + eps), 'y', 'LineWidth', 2.5);
    hold on;
    plot(f_axis_kHz, 10*log10(energy_spectrum_dft + eps), 'm', 'LineWidth', 0.5);
    legend('FFT', 'DFT');
    title(['Spettro Energia (dB) - Zoom [-2, 2] kHz - ' titolo], 'Interpreter', 'none'); 
    xlabel('Frequenza (kHz)'); 
    ylabel('Energia (dB)'); 
    grid on; 
    xlim([-2 2]); 
   
end
