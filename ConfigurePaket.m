function Packet=ConfigurePaket(PacketType,Model)

     if (strcmp(PacketType,'Data'))
       Packet.PacketSize=Model.DpacketLen;
    else
       Packet.PacketSize=Model.HpacketLen;
    end
    

end