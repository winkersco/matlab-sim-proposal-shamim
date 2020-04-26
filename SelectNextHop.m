function [ nextHop,Q ] = SelectNextHop( Sender, Model, Neighbors, Sensors, Q)
%   SELECTNEXTHOP Summary of this function goes here
%   Detailed explanation goes here
    n=Model.n;
    %candidates = [];
    reward=randi(n,n);
    for j=1:n
        if (Neighbors(Sender,j)==1 && Sensors(j).E>0)
            Q(Sender,j)=Q(Sender,j) + Model.Lr*(reward(Sender,j));
            %candidates=[candidates, j];
        end
    end
    [Qmax,idx]=max(Q);
    for i=1:n
        if (Qmax(j)==0)
            nextHop=-1;
        else
            nextHop=idx(j);
        end
    end
    
    %if (isempty(candidates))
        %nextHop = -1;
    %else
        %randomIndex = randi(length(candidates), 1);
        %nextHop = candidates(1,randomIndex);
    %end
end

