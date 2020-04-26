function [ nextHop,Q ] = SelectNextHop( Sender, Model, Neighbors, Sensors )
%   SELECTNEXTHOP Summary of this function goes here
%   Detailed explanation goes here
    n=Model.n;
   % candidates = [];
    Q=zeros(n,n);
    r=ones(n,n);
    for j=1:n
        if (Neighbors(Sender,j)==1 && Sensors(j).E>0)
            Q(Sender,j)=Q(Sender,j) + Model.Lr(r(Sender,j));
            %candidates=[candidates, j];
        end
    end
    
    if (isempty(Q(Sender,j)))
        nextHop = -1;
    else
        nextHop=max(Q(j,Sender));
        %randomIndex = randi(length(candidates), 1);
        %nextHop = candidates(1,randomIndex);
    end
end

