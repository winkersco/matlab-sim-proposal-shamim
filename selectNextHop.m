function [nextHop] = selectNextHop(Sender, Model, Neighbors, Sensors, HopToSink, Packet)

    fprintf('------------------\n');
    fprintf('Sender #%i\n', Sender);
    fprintf('------------------\n');
    
    switch(Model.Routing)
        case 'myRouting'
            nextHop = myRouting(Sender, Model, Neighbors, Sensors, HopToSink, Packet);
        case 'shhRouting'
            nextHop = shhRouting(Sender, Model, Neighbors, Sensors, HopToSink, Packet);
        case 'randomRouting'
            nextHop = randomRouting(Sender, Model, Neighbors, Sensors, HopToSink, Packet);
        otherwise
            fprintf('Invalid routing\n' );
    end
    
    fprintf('******* NextHop #%i *******\n\n', nextHop);
end
