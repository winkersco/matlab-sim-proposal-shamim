function SendAndReceivePackets(Sensors,Model,PacketType,t)
  
   global srp sdp
   sap=0;      % Send a packet
   
   n=Model.n;
   
   for i=1:n
       if (mod(Sensors(i).DataRate,t)==0)
           % Sent a packet
           sap=sap+1;
       end
   end
   
   if (strcmp(PacketType,'Data'))
        sdp=sdp+sap;
    else       
        srp=srp+sap;
    end
   
  
end