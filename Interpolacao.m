% Author : Ana Jeessica de Oliveira Batista
%{ 
    - recebe um sinal e uma proporcao (taxa) relativa ao número de amostras
    que devem ser adicionadas.
    - retorna um sinal que terá (taxa*sinal) número de amostras,as novas 
    amostras são calculadas atravéz da média das amostras vizinhas. 
%}

function x = Interpolacao(sinal,taxa)
    L = length(sinal);
    x = zeros(floor(taxa * L),1);
    x(1:taxa:end) = sinal;
    for j = 1:taxa:length(x)-taxa  
        x(j+1:j+taxa-1,1) = (x(j,1) + x(j+taxa,1))/2;
    end
end

