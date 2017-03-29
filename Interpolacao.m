% Author : Ana Jeessica de Oliveira Batista
%{ 
    - recebe um sinal e uma proporcao (taxa) relativa ao n�mero de amostras
    que devem ser adicionadas.
    - retorna um sinal que ter� (taxa*sinal) n�mero de amostras,as novas 
    amostras s�o calculadas atrav�z da m�dia das amostras vizinhas. 
%}

function x = Interpolacao(sinal,taxa)
    L = length(sinal);
    x = zeros(floor(taxa * L),1);
    x(1:taxa:end) = sinal;
    for j = 1:taxa:length(x)-taxa  
        x(j+1:j+taxa-1,1) = (x(j,1) + x(j+taxa,1))/2;
    end
end

