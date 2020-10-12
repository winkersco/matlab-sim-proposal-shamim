function Neighbors = findNeighbors(Model, Sensors, Distances)

    n = Model.n;
    Neighbors = zeros(n + 1, n + 1);

    for i = 1:n + 1
        for j = 1:n + 1
            if (i ~= j && Distances(i, j) <= (Sensors(i).RR / 2))
                Neighbors(i, j) = 1;
            end
        end
    end

end
