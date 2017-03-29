% Author : Ana Jeessica de Oliveira Batista
%{ 
    recebe um sinal, a frequencial do sinal fornecido ( pastFrequency) 
    e uma nova frequencia.
    retorna um vetor unidimensional com a nova frequencia "frequency"
%}
function [x,t] = Amostragem(pastSignal,frequency,pastFrequency,position)
   
    
    x = downsample(pastSignal,2);          %amostragem com nova frequencia
    t = (0:(length(x)-1))/(frequency);
    figure
    plot (t,x,'b');
    grid on;
    xlabel('Tempo (segundos)');
    ylabel('Amplitude dB');
    e = num2str(frequency/1000);
    k = horzcat( 'Sinal de Voz ',e, 'KHz');
    title(k);
end

