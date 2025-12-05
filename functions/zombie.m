function zombie(y_r, M, Fs, start)
   % input: vettore y_r con tutti i campioni del canale destro
   % output: 3 grafici di sottofinestre di y_r
   % 1. solo voce (2:34 - 2:29)
   % 2. solo strumenti (2:15 - 2:20)
   % 3. solo strumenti (diverso) (3:45 - 3:50)

   l = 5; % lunghezza della finestra analizzata
   n = Fs*l; % numero di campioni nella finestra
   
   id_start = Fs*start; % indice del primo campione
   id_end = id_start + n - 1; % supponendo che non si esca dal vettore y_r
   y = y_r(id_start:id_end);
   Y_fft = fft(y);
   titolo = sprintf('Finestra (zombie) - M=%.1fs, start=%d', M, start);
   y = y / max(abs(y)); % normalizzazione per non avere troppa differenza tra le ampiezze dei 3 grafici
   plotSpecsBilateral(y, Y_fft, Fs, titolo); % mostra una finestra con il grafico di y nel tempo e Y_fft in frequenza
     
end