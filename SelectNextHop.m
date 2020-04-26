function [ nextHop,Q ] = SelectNextHop( Sender, Model, Neighbors, Sensors, Q, reward)
%   SELECTNEXTHOP Summary of this function goes here
%   Detailed explanation goes here
    n=Model.n;
    candidates = [];
    for j=1:n
        if (Neighbors(Sender,j)==1 && Sensors(j).E>0)
            Q(Sender,j)=Q(Sender,j) + Model.Lr*(reward(Sender,j));
            %candidates=[candidates, j];
        end
    end
    
    for j=1:n
        if (Q(Sender,j)~=0 && Sensors(j).E>0)
             candidates=[candidates, Q(Sender,j)]
        end
    end
    
    
     if(isempty(candidates))
        nextHop = -1;
     else
        item=sort(candidates,'descend')
        nextHop=item(1);
        %randomIndex = randi(length(candidates), 1);
        %nextHop = candidates(1,randomIndex);
    end
end

