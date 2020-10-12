function Distances = calculateDistances(Model, Sensors)

    n = Model.n;
    Distances = zeros(n + 1, n + 1);

    for i = 1:n + 1
        for j = 1:n + 1
            Distances(i, j) = sqrt((Sensors(i).xd - Sensors(j).xd)^2 + (Sensors(i).yd - Sensors(j).yd)^2);
            if j == n+1
                Sensors(i).dis2sink = Distances(i,j);
            end
        end
    end

end

