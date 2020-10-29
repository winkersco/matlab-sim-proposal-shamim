function nextHop = shhRouting(Sender, Model, Neighbors, Sensors, HopToSink, Packet)
    
    n = Model.n;
    candidates = [];
    
    if (Neighbors(Sender,n+1)==1)
        nextHop=n+1;
    else
        for j = 1:n
            if (Neighbors(Sender, j) == 1 && HopToSink(j) ~= -1 && Sensors(j).E > 0 && Sensors(j).T < Model.ThermalThreshold)
                if Packet.VisitedNodes(j) == 0
                    Candidate.id = j;
                    Candidate.q = HopToSink(j);
                    candidates = [candidates, Candidate];
                end
            end
        end

        if (isempty(candidates))
            nextHop = -1;
        else
            candidates = struct2table(candidates);
            candidates = sortrows(candidates, 'q', 'ascend');
            candidates = table2struct(candidates);
            nextHop = candidates(1).id;
        end
    end

end

