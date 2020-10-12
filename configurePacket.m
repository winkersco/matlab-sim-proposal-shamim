function Packet = configurePacket(PacketType, Model, seq, i)

    n=Model.n;
    Packet.seq = seq;
    Packet.VisitedNodes=zeros(1,n);
    
    if (strcmp(PacketType, 'Data'))
        Packet.PacketSize = Model.DpacketLength;
    else
        Packet.PacketSize = Model.HpacketLength;
    end
    
   Packet.VisitedNodes(i)=1;

end
