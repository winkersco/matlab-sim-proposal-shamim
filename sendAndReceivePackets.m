function [Send, Sensors, Packets] = sendAndReceivePackets(Sensors, Model, PacketType, t, Neighbors, Distances, HopToSink)

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
        %for grayhole
        p = rand(1,1);
        
        if (mod(t, Sensors(i).DataRate) == 0)

            if (Sensors(i).E > 0 && Sensors(i).T < Model.ThermalThreshold)
                
                % Sent a packet if have any neighbors
                if (Model.BlackholeAttacker(i) == 0  &&  Model.GrayholeAttacker(i) == 0)
                    
                    [nextHop] = selectNextHop(i, Model, Neighbors, Sensors, HopToSink, -1);
                    if nextHop ~=-1
                        seq = sdp + sap + 1;
                        Packet = configurePacket('Data', Model, seq, i);
                        Packets{i, nextHop} = Packet;
                        Send(i, nextHop) = 1;
                        sap = sap + 1;
                        sapv(i) = sapv(i) + 1;
                        Sensors(i).E = Sensors(i).E - (Model.ETE * PacketSize + Model.EAC * PacketSize * Distances(i, nextHop) ^ 2);
                        Sensors(i).T = Sensors(i).T + Model.Ts;
                    end
                    
                elseif (Model.BlackholeAttacker(i) == 0  &&  Model.GrayholeAttacker(i) == 1)
                  
                    if (p < Model.GrayholePossibility)
                        [nextHop] = selectNextHop(i, Model, Neighbors, Sensors, HopToSink, -1);
                        if nextHop ~=-1 
                            seq = sdp + sap + 1;
                            Packet = configurePacket('Data', Model, seq, i);
                            Packets{i, nextHop} = Packet;
                            Send(i, nextHop) = 1;
                            sap = sap + 1;
                            sapv(i) = sapv(i) + 1;
                            Sensors(i).E = Sensors(i).E - (Model.ETE * PacketSize + Model.EAC * PacketSize * Distances(i, nextHop) ^ 2);
                            Sensors(i).T = Sensors(i).T + Model.Ts;
                        end
                    end
                end

            end

        end

        for b = 1:length(Sensors(i).Buffer)
            Packet = Sensors(i).Buffer{b};
            if (Sensors(i).E > 0 && ~isempty(Packet))
                
                % Sent a packet if have any neighbors
                if (Model.BlackholeAttacker(i) == 0 &&  Model.GrayholeAttacker(i) == 0)
                    
                    [nextHop] = selectNextHop(i, Model, Neighbors, Sensors, HopToSink, b);
                    if nextHop ~= -1
                        Packets{i, nextHop} = Packet;
                        Send(i, nextHop) = 1;
                        sap = sap + 1;
                        fap = fap + 1;
                        sapv(i) = sapv(i) + 1;
                        fapv(i) = fapv(i) + 1;
                        Sensors(i).E = Sensors(i).E - (Model.ETE * PacketSize + Model.EAC * PacketSize * Distances(i, nextHop) ^ 2);
                        Sensors(i).T = Sensors(i).T + Model.Ts;
                        Sensors(i).Buffer{b} = {};
                    end
                    
                elseif (Model.BlackholeAttacker(i) == 0  &&  Model.GrayholeAttacker(i) == 1)
                    
                    if (p < Model.GrayholePossibility)

                        [nextHop] = selectNextHop(i, Model, Neighbors, Sensors, HopToSink, b);
                        if nextHop ~= -1
                            Packets{i, nextHop} = Packet;
                            Send(i, nextHop) = 1;
                            sap = sap + 1;
                            fap = fap + 1;
                            sapv(i) = sapv(i) + 1;
                            fapv(i) = fapv(i) + 1;
                            Sensors(i).E = Sensors(i).E - (Model.ETE * PacketSize + Model.EAC * PacketSize * Distances(i, nextHop) ^ 2);
                            Sensors(i).T = Sensors(i).T + Model.Ts;
                            Sensors(i).Buffer{b} = {}; 
                        end

                    end
                end

            end

        end

    end

    %Receiver for Receive Packet
    for i = 1:n
        
      if (Send(i,n+1)==1)
            rap = rap + 1;
            rapv(n+1) = rapv(n+1) + 1;
      else
          
        for j = 1:n

            if (Send(i, j) == 1)
                %Received a Packet
                if (Sensors(j).E > 0 && Sensors(j).T < Model.ThermalThreshold)
                    empty = find(cellfun(@isempty,Sensors(j).Buffer),1);
                    if ~isempty(empty)
                        fprintf('------------------\n');
                        fprintf('#%i Recieve from #%i\n', j, i);
                        fprintf('------------------\n');
                        rap = rap + 1;
                        rapv(j) = rapv(j) + 1;
                        Sensors(j).E = Sensors(j).E - (Model.ERE * PacketSize);
                        Sensors(j).T = Sensors(j).T + Model.Tr;
                        Packets{i,j}.VisitedNodes(j) = 1;
                        Sensors(j).Buffer{empty} = Packets{i,j};
                    end
                end

            end

        end
     end

    end

    % Thermal management
    for i = 1:n
        Sensors(i).T = Sensors(i).T - Model.Tc;
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
