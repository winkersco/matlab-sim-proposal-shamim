function nextHop = randomRouting(Sender, Model, Neighbors, Sensors, HopToSink, Packet)
    
    n = Model.n;
    candidates = [];
    
    if (Neighbors(Sender,n+1)==1)
        nextHop=n+1;
    else
        for j = 1:n
            if (Neighbors(Sender, j) == 1 && HopToSink(j) ~= -1 && Sensors(j).E > 0 && Sensors(j).T < Model.ThermalThreshold)
                if Packet.VisitedNodes(j) == 0
                    Candidate.id = j;
                    candidates = [candidates, Candidate];
                end
            end
        end

        if (isempty(candidates))
            nextHop = -1;
        else
            id = randperm(length(candidates),1);
            nextHop = candidates(id).id;
        end
    end

end

