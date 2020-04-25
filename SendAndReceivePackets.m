function SendAndReceivePackets(Sensors,Model,PacketType,t,Neighbors)
  
   global srp sdp
   sap=0;      % Send a packet
   
   n=Model.n;
   
   for i=1:n
       if (mod(t,Sensors(i).DataRate)==0)
           nextHop = SelectNextHop(i,Model, Neighbors)
           % Sent a packet if have any neighbors
           if (nextHop ~= -1)
               sap=sap+1;
           end
       end
   end
   
   if (strcmp(PacketType,'Data'))
        sdp=sdp+sap;
    else       
        srp=srp+sap;
    end
   
  
end