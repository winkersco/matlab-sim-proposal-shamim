function Send=SendAndReceivePackets(Sensors,Model,PacketType,t,Neighbors)
  
   global srp rrp sdp rdp
   sap=0;      % Send a packet
   rap=0;      % Receive a packet
   if (strcmp(PacketType,'Data'))
       PacketSize=Model.DpacketLen;
   else
       PacketSize=Model.HpacketLen;
   end
   
   n=Model.n;
   Send=zeros(n,n);
   
   %Sender for a send Packet
   for i=1:n
       if (mod(t,Sensors(i).DataRate)==0)
            Sensors(i).E=Sensors(i).E- ...
                    (Model.ETX*PacketSize + Model.Efs*PacketSize);
                if(Sensors(i).E>0)
                   nextHop = SelectNextHop(i,Model, Neighbors)
                   % Sent a packet if have any neighbors
                   if (nextHop ~= -1)
                       Send(i,nextHop)=1;
                       sap=sap+1;
                       Sensors(i).T=Sensors(i).T+(PacketSize*0.0001);
                   end
                end
       end
   end
   
   %Receiver for Receive Packet
   for i=1:n
       for j=1:n
           if (Send(i,j)==1)
               Sensors(j).E =Sensors(j).E- ...
                    ((Model.ERX + Model.EDA)*PacketSize);
               Sensors(j).T=Sensors(j).T+(PacketSize*0.0001);
           end
       end
   end
   
   for i=1:n
       for j=1:n

            %Received a Packet
            if(Sensors(i).E>0 && Sensors(j).E>0)
                rap=rap+1;
            end
       end 
   end
   
   if (strcmp(PacketType,'Data'))
        sdp=sdp+sap;
        rdp=rdp+rap;
    else       
        srp=srp+sap;
        rrp=rrp+rap;
    end
   
  
end