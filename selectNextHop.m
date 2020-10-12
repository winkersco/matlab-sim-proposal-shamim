function [nextHop] = selectNextHop(Sender, Model, Neighbors, Sensors, HopToSink, b)
    %   SELECTNEXTHOP Summary of this function goes here
    %   Detailed explanation goes here
    global Q
    n = Model.n;
    candidates = [];

    fprintf('------------------\n');
    fprintf('Sender #%i\n', Sender);
    fprintf('------------------\n');

    for j = 1:n

        if (Neighbors(Sender, j) == 1 && Sensors(j).E > 0 && Sensors(j).T < Model.ThermalThreshold)
            reward = calculateReward(Model, Sensors(j), HopToSink);
            nextQ = cauculatenextQ(Sensors(j), Model, Neighbors, Q);
            Q(Sender, j) = Q(Sender, j) + Model.Alpha * (reward + (Model.Gamma * nextQ) - Q(Sender, j));
        end

    end
    
    if (Neighbors(Sender,n+1)==1)
        nextHop=n+1;
    else
        for j = 1:n
            flag = 0;
            if (Q(Sender, j) ~= 0 && Sensors(j).E > 0 && Sensors(j).T < Model.ThermalThreshold)
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
    
    fprintf('******* NextHop #%i *******\n\n', nextHop);
end