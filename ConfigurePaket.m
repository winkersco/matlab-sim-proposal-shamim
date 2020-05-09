function Packet = ConfigurePaket(PacketType, Model, i, nextHop)

    n=Model.n;
    Packet.VisitedNodes=zeros(1,n);
    
    if (strcmp(PacketType, 'Data'))
        Packet.PacketSize = Model.DpacketLen;
    else
        Packet.PacketSize = Model.HpacketLen;
    end
    
   Packet.VisitedNodes(i)=1;
   Packet.VisitedNodes(nextHop)=1;

end
