function [Sensors , Send] = sendAndReceivePackets(Sensors, Model, PacketType, t, Neighbors, Distances, Senses, HopToSink)

    global srp rrp frp sdp rdp fdp sapv rapv fapv
    sap = 0; % Send a packet
    rap = 0; % Receive a packet
    fap = 0; % Forward a packet

    if (strcmp(PacketType, 'Data'))
        PacketSize = Model.DpacketLength;
    else
        PacketSize = Model.HpacketLength;
    end

    n = Model.n;
    Send = zeros(n, n+1);
    Packets = cell(n,n+1);

    %Sender for a send Packet
    for i = 1:n
        
        for j = 1:n+1
            Packets{i, j} = CQueue();
        end
        
        if (Senses(i,t)==1 && Sensors(i).E > 0 && Sensors(i).T < Model.ThermalThreshold)
            % Sent a packet if have any neighbors
            if (Model.BlackholeAttacker(i) == 0  &&  Model.GrayholeAttacker(i) == 0)
                seq = sdp + sap + 1;
                Packet = configurePacket('Data', Model, seq, i);
                [nextHop] = selectNextHop(i, Model, Neighbors, Sensors, HopToSink, Packet);
                if nextHop ~=-1
                    Packets{i, nextHop}.push(Packet);
                    Send(i, nextHop) = 1;
                    sap = sap + 1;
                    sapv(i) = sapv(i) + 1;
                    Sensors(i).E = Sensors(i).E - (Model.ETE * PacketSize + Model.EAC * PacketSize * Distances(i, nextHop) ^ 2);
                    Sensors(i).T = Sensors(i).T + Model.Ts;
                end
            elseif (Model.BlackholeAttacker(i) == 0  &&  Model.GrayholeAttacker(i) == 1)
                %for grayhole
                p = rand();
                if (p < Model.GrayholePossibility)
                    seq = sdp + sap + 1;
                    Packet = configurePacket('Data', Model, seq, i);
                    [nextHop] = selectNextHop(i, Model, Neighbors, Sensors, HopToSink, Packet);
                    if nextHop ~=-1 
                        Packets{i, nextHop}.push(Packet);
                        Send(i, nextHop) = 1;
                        sap = sap + 1;
                        sapv(i) = sapv(i) + 1;
                        Sensors(i).E = Sensors(i).E - (Model.ETE * PacketSize + Model.EAC * PacketSize * Distances(i, nextHop) ^ 2);
                        Sensors(i).T = Sensors(i).T + Model.Ts;
                    end
                end 
            end
        end
        
        while ~Sensors(i).Buffer.isempty() && Sensors(i).E > 0 && Sensors(i).T < Model.ThermalThreshold
            Packet = Sensors(i).Buffer.pop();
            % Sent a packet if have any neighbors
            if (Model.BlackholeAttacker(i) == 0 &&  Model.GrayholeAttacker(i) == 0)
                [nextHop] = selectNextHop(i, Model, Neighbors, Sensors, HopToSink, Packet);
                if nextHop ~= -1
                    Packets{i, nextHop}.push(Packet);
                    Send(i, nextHop) = 1;
                    fap = fap + 1;
                    fapv(i) = fapv(i) + 1;
                    Sensors(i).E = Sensors(i).E - (Model.ETE * PacketSize + Model.EAC * PacketSize * Distances(i, nextHop) ^ 2);
                    Sensors(i).T = Sensors(i).T + Model.Ts;
                end
            elseif (Model.BlackholeAttacker(i) == 0  &&  Model.GrayholeAttacker(i) == 1)
                %for grayhole
                p = rand();
                if (p < Model.GrayholePossibility)
                    [nextHop] = selectNextHop(i, Model, Neighbors, Sensors, HopToSink, Packet);
                    if nextHop ~= -1
                        Packets{i, nextHop}.push(Packet);
                        Send(i, nextHop) = 1;
                        fap = fap + 1;
                        fapv(i) = fapv(i) + 1;
                        Sensors(i).E = Sensors(i).E - (Model.ETE * PacketSize + Model.EAC * PacketSize * Distances(i, nextHop) ^ 2);
                        Sensors(i).T = Sensors(i).T + Model.Ts; 
                    end
                end
            end
        end
    end

    %Receiver for Receive Packet
    for i = 1:n
        if Send(i,n+1) == 1
            queue = Packets{i, n+1};
            while ~queue.isempty()
                queue.pop();
                rap = rap + 1;
                rapv(n+1) = rapv(n+1) + 1;
            end
        end
        for j = 1:n
            if (Send(i, j) == 1)
                %Received a Packet
                queue = Packets{i,j};
                while ~queue.isempty() && Sensors(j).E > 0 && Sensors(j).T < Model.ThermalThreshold
                    fprintf('------------------\n');
                    fprintf('#%i Recieve from #%i\n', j, i);
                    fprintf('------------------\n');
                    if Sensors(j).Buffer.size() >= Sensors(j).BufferLength
                        Sensors(j).Buffer.pop(); 
                    end
                    Packet = queue.pop();
                    rap = rap + 1;
                    rapv(j) = rapv(j) + 1;
                    Sensors(j).E = Sensors(j).E - (Model.ERE * PacketSize);
                    Sensors(j).T = Sensors(j).T + Model.Tr;
                    Packet.VisitedNodes(j) = 1;
                    Sensors(j).Buffer.push(Packet);
                end
            end
        end
    end

    % Thermal management
    for i = 1:n
        if Model.To <= Sensors(i).T
            Sensors(i).T = Sensors(i).T - Model.Tc;
        end
    end

    if (strcmp(PacketType, 'Data'))
        sdp = sdp + sap;
        rdp = rdp + rap;
        fdp = fdp + fap;
    else
        srp = srp + sap;
        rrp = rrp + rap;
        frp = frp + fap;
    end

end
