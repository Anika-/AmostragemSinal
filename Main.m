%{ 
    2 Trabalho de Sistemas Lineares
    Professor Francisco José Aquino
    Alunos:
        Ana Jeessica de Oliveira Batista
        Ana Katarina Hachém
    
    O código a seguir realiza amostragem sucessiva de um sinal em 44,1KHz 
    , 22KHz, 11KHz e exibe os resultados em 4 gráficos. Em seguida, 
    interpola o sinal de volta a 44,1 KHz e computa o vetor diferença entre
    o sinal interpolado e a primeira amostragem.
%}


%Inicializacao

[x,Fr] = audioread('sinalVoz.wav');    % Lendo arquivo de áudio
info = audioinfo('sinalVoz.wav');      % captando informações do arquivo         
x = x(:,1);
L = length(x);
t = (0:(L-1))/Fr;                      % criando vetor tempo
figure
plot (t,x);                            % plotagem do sinal original
grid on;
xlabel('Tempo (segundos)');
ylabel('Amplitude');
title('Sinal de Voz original 48KHz');



% taxas de amostragem
fs  = 44100;                    
fs2 = 22050;
fs3 = 11000;
       

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            AMOSTRAGEM              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x1 = resample(x,Fr,fs);
x1 = [x1; 0];                       %consertando diferenca entre dimensoes 
                                    % apos interpolacao
t1 = (0:(length(x1)-1))/fs;
figure
plot (t,x,'b');
grid on;
xlabel('Tempo (segundos)');
ylabel('Amplitude dB');
title('Sinal de Voz 44,1 KHz');
    
[x2,t2] = Amostragem(x1,fs2,fs,3);
[x3,t3] = Amostragem(x2,fs3,fs2,4);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          INTERPOLACAO              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = Interpolacao(x3,2);
b = Interpolacao(a,2);
   
vetorDif = x1 - b;              %vetor diferença 44KHz
taxaErro = (vetorDif == 0);
totAmostrasOriginais_44Hz = sum(taxaErro(:));

figure
plot(t1,vetorDif);
grid on;
xlabel('Tempo (segundos)');
ylabel('Amplitude dB');
title('Diferença entre os sinais de 44,1KHz');

figure;
plot(t1,b);
grid on;
xlabel('Tempo (segundos)');
ylabel('Amplitude dB');
title('Sinal de Voz 44,1KHz apos interpolação');

%=============================================%

vetorDif2 = x2 - a;              %vetor diferença 22KHz
taxaErro2 = (vetorDif2 == 0);
totAmostrasOriginais_22Hz = sum(taxaErro2(:));


figure
plot(t2,vetorDif2);
grid on;
xlabel('Tempo (segundos)');
ylabel('Amplitude dB');
title('Diferença entre os sinais de 22,1KHz');

figure;
plot(t2,a);
grid on;
xlabel('Tempo (segundos)');
ylabel('Amplitude dB');
title('Sinal de Voz 22,1KHz apos interpolação');


%TODO gerar vetor diferenca de b para sinal de 41

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            ESPECTRO                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


T = 1/fs;                   % sampling period
L = length(x1);             % Length of signal(n de amostras)
t = (0:L-1)*T;              % Time vector

spectrum = fft(x1);         % Vetor com numeros complexos representando a 
                            %    transformada do sinal    
                            
P2 = abs(spectrum/L);       % magnitude dos valores do vetor "spectrum"

P1 = P2(1:L/2+1);           % pegar numeros positivos (de 0 ate Nyquist)

P1(2:end-1) = 2*P1(2:end-1);       

f = fs*(0:(L/2))/L;         % normalizando frequencia

figure;
plot(f,P1);
title('Spectro da amplitude do sinal 44,1KHz (Domínio da frequencia)')
xlabel('f (Hz)')
ylabel('|P1(f)| Potencia relativa');
