function nextHop = myRouting(Sender, Model, Neighbors, Sensors, HopToSink, Packet)

    global Q
    n = Model.n;
    candidates = [];
    
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
            if (Neighbors(Sender, j) == 1 && Sensors(j).E > 0 && Sensors(j).T < Model.ThermalThreshold)
                if Packet.VisitedNodes(j) == 0
                    Candidate.id = j;
                    Candidate.q = Q(Sender, j);
                    candidates = [candidates, Candidate];
                end
            end
        end

        if (isempty(candidates))
            nextHop = -1;
        else
            candidates = struct2table(candidates);
            candidates = sortrows(candidates, 'q', 'descend');
            candidates = table2struct(candidates);
            nextHop = candidates(1).id;
        end
    end

end

