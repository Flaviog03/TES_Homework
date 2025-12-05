function plotSpecs(X_fft, X_dft, fs, titolo) 

    N = length(X_fft); % X_dft e X_fft hanno la stessa lunghezza
    
    % Shift per centrare lo spettro
    X_shifted_fft = fftshift(X_fft); 
    X_shifted_dft = fftshift(X_dft); 
    
    % Calcolo energia
    energy_spectrum_fft = abs(X_shifted_fft).^2; 
    energy_spectrum_dft = abs(X_shifted_dft).^2; 
    
    % Assi frequenza
    f_axis = (-floor(N/2) : ceil(N/2)-1) * (fs / N); 
    f_axis_kHz = f_axis / 1000;  
    
    figure('Name', titolo); 
    
    %% Layout 4x1 (Una colonna verticale)
    
    % 1. FFT Lineare (BLU)
    subplot(4,1,1); 
    plot(f_axis_kHz, energy_spectrum_fft, 'b', 'LineWidth', 1.5);
    title(['FFT (Lineare) - ' titolo], 'Interpreter', 'none'); 
    xlabel('Frequenza (kHz)'); 
    ylabel('Energia (a.u.)'); 
    grid on; 
    xlim([-2 2]);  
    
    % 2. DFT Lineare (ROSSO)
    subplot(4,1,2); 
    plot(f_axis_kHz, energy_spectrum_dft, 'r', 'LineWidth', 1.5);
    title(['DFT (Lineare) - ' titolo], 'Interpreter', 'none'); 
    xlabel('Frequenza (kHz)'); 
    ylabel('Energia (a.u.)'); 
    grid on; 
    xlim([-2 2]); 
    
    % 3. FFT Logaritmica (BLU)
    subplot(4,1,3); 
    plot(f_axis_kHz, 10*log10(energy_spectrum_fft + eps), 'b', 'LineWidth', 1.5);
    title(['FFT (dB) - ' titolo], 'Interpreter', 'none'); 
    xlabel('Frequenza (kHz)'); 
    ylabel('Energia (dB a.u.)'); 
    grid on; 
    xlim([-2 2]); 
   
    % 4. DFT Logaritmica (ROSSO)
    subplot(4,1,4); 
    plot(f_axis_kHz, 10*log10(energy_spectrum_dft + eps), 'r', 'LineWidth', 1.5);
    title(['DFT (dB) - ' titolo], 'Interpreter', 'none'); 
    xlabel('Frequenza (kHz)'); 
    ylabel('Energia (dB a.u.)'); 
    grid on; 
    xlim([-2 2]); 

end