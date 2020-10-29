function [ Senses ] = createRandomSenses(Model)

    Senses = zeros(Model.n, Model.TimeMax);
    
    senseProbability = 1/Model.n;
    randList = rand(Model.n ,Model.TimeMax);
    
    for i = 1:Model.n
        for j = 1:Model.TimeMax
            p = randList(i,j);
            if p < senseProbability
               select = 1; 
            else
               select = 0;
            end
            Senses(i,j)=select;
        end
    end
    
    save('Senses', 'Senses');
    
end

