function Xk = myDft(xn)
    % Input: xn (segnale nel tempo, la sotto-finestra)
    % Output: Xk (segnale in frequenza trasformato)

    N = length(xn);
    Xk = zeros(N, 1); % Inizializza il vettore risultato (complesso)
    
    % Doppio ciclo for: QUESTO è ciò che lo rende lento ed "esplicito"
    for k = 0:N-1
        somma = 0;
        for n = 0:N-1
            % Implementazione della formula esponenziale
            % Nota: in Matlab gli indici partono da 1, quindi useremo n+1 e k+1 per accedere agli array
            esponente = exp(-1j * 2 * pi * k * n / N);
            somma = somma + xn(n+1) * esponente;
        end
        Xk(k+1) = somma;
    end
end