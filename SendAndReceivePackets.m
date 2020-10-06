function [Send, Sensors, Packets] = SendAndReceivePackets(Sensors, Model, PacketType, t, Neighbors, dissink)

    global srp rrp frp sdp rdp fdp sapv rapv fapv
    sap = 0; % Send a packet
    rap = 0; % Receive a packet
    fap = 0; % Forward a packet

    if (strcmp(PacketType, 'Data'))
        PacketSize = Model.DpacketLen;
    else
        PacketSize = Model.HpacketLen;
    end

    n = Model.n;
    Send = zeros(n, n+1);
    Packets = cell(n,n+1);
    A = [];
    %reward=randi(n,n);

    %Sender for a send Packet
    for i = 1:n
        %for grayhole
        p = rand(1,1);
        
        if (mod(t, Sensors(i).DataRate) == 0)

            if (Sensors(i).E > 0 && Sensors(i).T < Model.ThermalThreshold)
                
                [nextHop] = SelectNextHop(i, Model, Neighbors, Sensors, dissink, -1);
                    
                % Sent a packet if have any neighbors

                if (nextHop ~= -1 && Model.Blackhole_attacker(i) == 0  &&  Model.Grayhole_attacker(i) == 0)

                    Packet = ConfigurePaket('Data', Model, i, nextHop);
                    Packets{i, nextHop} = Packet;
                    Send(i, nextHop) = 1;
                    sap = sap + 1;
                    sapv(i) = sapv(i) + 1;
                    Sensors(i).E = Sensors(i).E - ...
                        (Model.ETX * PacketSize + Model.Efs * PacketSize);
                    Sensors(i).T = Sensors(i).T + (PacketSize * Model.Ts);
                    
                elseif (nextHop ~= -1 && Model.Blackhole_attacker(i) == 0  &&  Model.Grayhole_attacker(i) == 1)
                    
                    if (p < Model.P_grayhole)
                        Packet = ConfigurePaket('Data', Model, i, nextHop);
                        Packets{i, nextHop} = Packet;
                        Send(i, nextHop) = 1;
                        sap = sap + 1;
                        sapv(i) = sapv(i) + 1;
                        Sensors(i).E = Sensors(i).E - ...
                            (Model.ETX * PacketSize + Model.Efs * PacketSize);
                        Sensors(i).T = Sensors(i).T + (PacketSize * Model.Ts);
                    end
                    
                end

            end

        end

        for b = 1:length(Sensors(i).Buffer)
            Packet = Sensors(i).Buffer{b};
            if (Sensors(i).E > 0 && ~isempty(Packet))
                
                [nextHop] = SelectNextHop(i, Model, Neighbors, Sensors, dissink, b);
                
                % Sent a packet if have any neighbors

                if (nextHop ~= -1 && Model.Blackhole_attacker(i) == 0 &&  Model.Grayhole_attacker(i) == 0)

                    Packets{i, nextHop} = Packet;
                    Send(i, nextHop) = 1;
                    sap = sap + 1;
                    fap = fap + 1;
                    sapv(i) = sapv(i) + 1;
                    fapv(i) = fapv(i) + 1;
                    Sensors(i).E = Sensors(i).E - ...
                        (Model.ETX * PacketSize + Model.Efs * PacketSize);
                    Sensors(i).T = Sensors(i).T + (PacketSize * Model.Ts);
                    Sensors(i).Buffer{b} = {};
                    
                elseif (nextHop ~= -1 && Model.Blackhole_attacker(i) == 0  &&  Model.Grayhole_attacker(i) == 1)
                    
                        if (p < Model.P_grayhole)
                            
                            Packets{i, nextHop} = Packet;
                            Send(i, nextHop) = 1;
                            sap = sap + 1;
                            fap = fap + 1;
                            sapv(i) = sapv(i) + 1;
                            fapv(i) = fapv(i) + 1;
                            Sensors(i).E = Sensors(i).E - ...
                                (Model.ETX * PacketSize + Model.Efs * PacketSize);
                            Sensors(i).T = Sensors(i).T + (PacketSize * Model.Ts);
                            Sensors(i).Buffer{b} = {};
                        
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
                    rap = rap + 1;
                    rapv(j) = rapv(j) + 1;
                    Sensors(j).E = Sensors(j).E - ...
                        ((Model.ERX + Model.EDA) * PacketSize);
                    Sensors(j).T = Sensors(j).T + (PacketSize * Model.Tr);
                    Packets{i,j}.VisitedNodes(j) = 1;
                    empty = find(cellfun(@isempty,Sensors(j).Buffer),1);
                    Sensors(j).Buffer{empty} = Packets{i,j};
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
