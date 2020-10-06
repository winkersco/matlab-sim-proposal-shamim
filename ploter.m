function deadNum = ploter(Sensors, Model, Area)
    %% Developed by Amin Nazari
    % 	aminnazari91@gmail.com
    %	0918 546 2272
    deadNum = 0;
    n = Model.n;

    for i = 1:n
        %check dead node
        if (Sensors(i).E > 0)


            if (Sensors(i).type == 'N' && Model.Blackhole_attacker(Sensors(i).id) == 0 && ...
                    Model.Grayhole_attacker(Sensors(i).id) == 0)
                plot(Sensors(i).xd, Sensors(i).yd, 'o');
            elseif (Sensors(i).type == 'N' && (Model.Blackhole_attacker(Sensors(i).id) == 1 || ...
                    Model.Grayhole_attacker(Sensors(i).id) == 1)) %Blackhole attacker

                plot(Sensors(i).xd, Sensors(i).yd, 'ks', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
            else %Sensors.type=='C'
                plot(Sensors(i).xd, Sensors(i).yd, 'kx', 'MarkerSize', 10);
            end

        else
            deadNum = deadNum + 1;
            plot(Sensors(i).xd, Sensors(i).yd, 'red .');
        end

        hold on;

    end

    plot(Sensors(n + 1).xd, Sensors(n + 1).yd, 'g*', 'MarkerSize', 15);
    
    xlim([0 Area.x])
    ylim([0 Area.y])
    grid on
    axis square
    legend('Location','NorthEastOutside');

end
