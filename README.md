-----

# Analisi Spettrale Audio: Confronto DFT vs FFT

Questo repository contiene lo svolgimento dell'**Esercitazione Software \#1** del corso di *Elaborazione dei Segnali* (A.A. 2025-2026).

L'obiettivo del progetto è l'analisi in frequenza di brani musicali campionati, confrontando due approcci per il calcolo dello spettro: l'implementazione esplicita della **DFT (Discrete Fourier Transform)** e l'utilizzo della libreria ottimizzata **FFT (Fast Fourier Transform)**.

## 📂 Struttura del Progetto

Il progetto è organizzato nelle seguenti cartelle e script:

```text
.
├── main.m                  # Script principale per l'elaborazione audio
├── functions/              # Libreria di funzioni personalizzate
│   ├── myDft.m             # Implementazione manuale della DFT
│   └── plotSpecs.m         # Funzione per la visualizzazione grafica
├── tests/                  # Script di test e validazione
│   └── test_dft_validation.m
├── data/                   # Cartella per i file audio (ignorata da git)
└── report/                 # Relazione e immagini dei risultati
```

## 🚀 Funzionalità e Implementazione

Di seguito viene spiegato il funzionamento dei moduli principali sviluppati per l'esercitazione.

### 1\. Calcolo della DFT (`functions/myDft.m`)

Questa funzione implementa la formula matematica della Trasformata Discreta di Fourier "senza semplificazioni", come richiesto dalle specifiche:

$$X(k) = \sum_{n=0}^{N-1} x(n) e^{-j \frac{2\pi}{N} k n}$$

  * **Input:** Un vettore colonna `xn` rappresentante la finestra temporale del segnale.
  * **Logica:** Utilizza un **doppio ciclo for** annidato per calcolare la sommatoria per ogni frequenza $k$.
  * **Complessità:** $O(N^2)$. Questo algoritmo è computazionalmente oneroso ed è utilizzato per dimostrare la differenza di prestazioni rispetto alla FFT.

### 2\. Visualizzazione Spettri (`functions/plotSpecs.m`)

Funzione ausiliaria per generare i grafici dello spettro di energia.

  * Calcola lo spettro di energia $|X(k)|^2$.
  * Genera automaticamente l'asse delle frequenze corretto (da $0$ a $f_s/2$) convertendolo in **kHz**.
  * Produce due grafici per ogni finestra:
      * **Scala Lineare:** Utile per vedere i picchi dominanti.
      * **Scala Logaritmica (dB):** Fondamentale per analizzare la dinamica del segnale e le componenti a bassa energia.

### 3\. Loop di Analisi (`main.m`)

Lo script principale orchestra l'intero processo:

1.  **Caricamento:** Legge i file audio (`.flac` o `.wav`) e ne ottiene la frequenza di campionamento ($F_s$).
2.  **Finestraggio:** Divide il segnale in sotto-finestre temporali di durata $M$ (configurabile, es. 0.5s).
3.  **Confronto Prestazionale:** Per ogni finestra, esegue sia la `fft` di MATLAB che la `myDft`, misurando i tempi di esecuzione con `tic` e `toc`.
4.  **Output:** Mostra a video i tempi e genera i grafici spettrali.

### 4\. Validazione (`tests/test_dft_validation.m`)

Prima di processare file audio pesanti, questo script verifica la correttezza matematica di `myDft`.

  * Genera un segnale sintetico (somma di sinusoidi note).
  * Confronta il risultato di `myDft` con la `fft` di MATLAB.
  * L'errore deve essere nell'ordine di $10^{-14}$ per considerare la funzione corretta.

## 🛠️ Istruzioni per l'uso

### Prerequisiti

  * MATLAB (versione R2020b o successiva consigliata).
  * Signal Processing Toolbox (opzionale, ma utile per `audioread`).

### Setup

1.  Clona il repository.
2.  Inserisci i tuoi file audio (es. `rock.flac`, `classic.flac`) nella cartella `data/`.
      * *Nota: I file audio non sono inclusi nel repo per motivi di dimensione.*

### Esecuzione

1.  **Validazione:** Esegui prima il test per assicurarti che tutto funzioni:
    ```matlab
    run tests/test_dft_validation.m
    ```
2.  **Analisi:** Apri `main.m`, configura il nome del file audio e la durata della finestra $M$, quindi esegui lo script.

## 📊 Risultati Attesi

L'esecuzione evidenzierà la drastica differenza di efficienza tra i due algoritmi. Esempio tipico su una finestra di 0.5s (44.1kHz):

| Algoritmo | Tempo Esecuzione (stimato) | Complessità |
| :--- | :--- | :--- |
| **FFT (Matlab)** | \< 1 ms | $O(N \log N)$ |
| **myDft (Manuale)** | \~ 40 s | $O(N^2)$ |

Questi dati dimostrano l'importanza dell'algoritmo FFT per l'elaborazione in tempo reale dei segnali digitali.

-----

**Autore:** [Flavio Grammatico]
**Corso:** Elaborazione dei Segnali, A.A. 2025-2026
