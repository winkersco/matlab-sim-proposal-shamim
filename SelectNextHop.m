function [nextHop] = SelectNextHop(Sender, Model, Neighbors, Sensors, dissink, b)
    %   SELECTNEXTHOP Summary of this function goes here
    %   Detailed explanation goes here
    global Q
    n = Model.n;
    candidates = [];
    

    for j = 1:n

        if (Neighbors(Sender, j) == 1 && Sensors(j).E > 0)
            reward = calculateReward(Sensors(j), dissink);
            nextQ = cauculatenextQ(Sensors(j), Model, Neighbors, Q);
            Q(Sender, j) = Q(Sender, j) + Model.alpha * (reward + (Model.gamma * nextQ) - Q(Sender, j));
            % Q(Sender,j)=Q(Sender,j) + Model.Lr*(reward(Sender,j));
            %candidates=[candidates, j];
        end

    end

    for j = 1:n
        flag = 0;
        if (Q(Sender, j) ~= 0 && Sensors(j).E > 0 )
            if(b == -1)
                flag = 1;
            else
                Packet = Sensors(Sender).Buffer{b};
                if(Packet.VisitedNodes(j) == 0)
                    flag = 1;
                end
            end
        end
        if(flag)
            Candidate.id = j;
            Candidate.q = Q(Sender, j);
            candidates = [candidates, Candidate];
        end
    end

    if (isempty(candidates))
        nextHop = -1;
    else
        candidates = struct2table(candidates);
        candidates = sortrows(candidates, 'q', 'descend');
        candidates = table2struct(candidates);
        nextHop = candidates(1).id;
        %randomIndex = randi(length(candidates), 1);
        %nextHop = candidates(1,randomIndex);
    end

end
