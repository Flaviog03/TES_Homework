function Xk = myDft(xn)
    % Input: xn (segnale nel tempo, la sotto-finestra)
    % Output: Xk (segnale in frequenza trasformato)

    N = length(xn);
    Xk = zeros(N, 1);
    
    for k = 0:N-1
        somma = 0;
        for n = 0:N-1; 
            esponente = exp(-1j * 2 * pi * k * n / N);
            somma = somma + xn(n+1) * esponente;
        end
        Xk(k+1) = somma;
    end
end