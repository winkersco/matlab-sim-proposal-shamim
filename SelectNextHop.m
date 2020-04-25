function [ nextHop ] = SelectNextHop( Sender, Model, Neighbors, Sensors )
%   SELECTNEXTHOP Summary of this function goes here
%   Detailed explanation goes here
    n=Model.n;
    candidates = [];
    for j=1:n
        if (Neighbors(Sender,j)==1 && Sensors(j).E>0)
            candidates=[candidates, j];
        end
    end
    
    if (isempty(candidates))
        nextHop = -1;
    else
        randomIndex = randi(length(candidates), 1);
        nextHop = candidates(1,randomIndex);
    end
end

