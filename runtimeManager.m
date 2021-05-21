clc;
close all;
clear all;

timeStep = 0.1;
totalTime = 200;
steps = totalTime/timeStep;

road.length = 800;
road.lane.width = 5;
road.lane.number = 3;
road.lane.up.number = 0;
road.lane.down.number = road.lane.number - road.lane.up.number;
viewWidth = 800;
road.start = 0;
road.end = road.length;
road.wirelessRange = 30;
carNumber = 3;
maxVelocity = 30;
minVelocity = 10;

car1.length = 3;
cars = car1;

cars(1).length = 3;
cars(1).width = 1.5;
cars(1).y = road.start - 100;
cars(1).x = 0;
% cars(1).v = minVelocity + (maxVelocity - minVelocity) * rand();
cars(1).v = 10;
cars(1).a = 0.0;
cars(1).L = .7;
cars(1).phi = pi/2;
cars(1).psi = .0;
cars(1).color = 'blue';
cars(1).lidar.radius = 15;
cars(1).recX = [-cars(1).length/2 cars(1).length/2 cars(1).length/2 -cars(1).length/2 -cars(1).length/2];
cars(1).recY = [-cars(1).width/2 -cars(1).width/2 cars(1).width/2 cars(1).width/2 -cars(1).width/2];

for i = 1 : carNumber
    cars(i).length = 3;
    cars(i).width = 1.5;
    cars(i).y = road.start - 100;
    cars(i).x = 0;
%     cars(i).v = minVelocity + (maxVelocity - minVelocity) * rand();
    cars(i).v = 10;
    cars(i).a = 0;
    cars(i).L = .7;
    cars(i).phi = pi/2;
    cars(i).psi = .0;
    if i == 1
        cars(i).color = 'blue';
    elseif i==2
        cars(i).color = 'red';
    else
        cars(i).color = 'black';
    end
%     cars(i).color = rand(1,3);
    cars(i).lidar.radius = 20;
    cars(i).lane = randi([1 road.lane.number]);
    cars(i) = setCarPos(cars(i),road);
    cars(i).recX = [-cars(i).length/2 cars(i).length/2 cars(i).length/2 -cars(i).length/2 -cars(i).length/2];
    cars(i).recY = [-cars(i).width/2 -cars(i).width/2 cars(i).width/2 cars(i).width/2 -cars(i).width/2];
end
cars(1).lane = randi([1 road.lane.number]);
cars(1) = setCarPos(cars(1),road);


x0=300;
y0=10;
width=1400;
height=1000;
set(gcf,'position',[x0,y0,width,height])

distance  = zeros (carNumber, carNumber);
adjacencyMatrix  = zeros (carNumber, carNumber);
yMatrix = zeros (carNumber, carNumber);

for i = 1 : steps
 
%     drawingRoad(road);
    for j = 1 : carNumber
        cars(j) = positionCalc(cars(j),i,timeStep);
        subplot(1, 2, 1);
        drawingCar(cars(j),road);
        disp(j);
        disp(cars(j).y);
        for k = 1 : carNumber
        distance(j,k) = sqrt((cars(j).x - cars(k).x)^2 + (cars(j).y - cars(k).y)^2)
        yMatrix (j,j) = cars(j).y
        adjacencyMatrix = adjacencyGenerator(cars,distance,road.wirelessRange,adjacencyMatrix)
        end
    end
    pause(0.1);
    hold on 
    
    G = digraph(adjacencyMatrix);
    subplot(1, 2, 2);
%     figure(2);
%     cla;
    plot(G);
%     hold on
end
function adjacencyMatrix = adjacencyGenerator(cars,distanceMatrix, wirelessRange,adjacencyMatrix)
[rows,columns] = size(distanceMatrix);
% adjacencyMatrix = zeros(rows,columns);
for i = 1 : rows
    for j = 1 : columns
        if (distanceMatrix(i,j) < wirelessRange && distanceMatrix(i,j) ~= 0 && cars(i).y > cars(j).y)
            adjacencyMatrix(i,j) = distanceMatrix(i,j);
            adjacencyMatrix(j,i) = 0;
        
        end
    end
end

end
    


function car = setCarPos(car,road)
car.x = (car.lane - 1) * road.lane.width + road.lane.width / 2;
car.y = road.start - (100 - (100)*rand());
end

function drawingRoad(road)
axis([-50 50 road.start road.end ])
pSolid = plot([0 0],[road.start road.length],[(road.lane.number * road.lane.width) ...
    (road.lane.number * road.lane.width) ],[road.start road.end]);  
pSolid(1).LineWidth = 2;
pSolid(1).Color = 'black';
pSolid(2).LineWidth = 2;
pSolid(2).Color = 'black';
hold on 
for i = 1 : road.lane.number - 1
    pDash = plot([(i * road.lane.width) (i * road.lane.width)],[road.start road.length]);
    pDash.LineStyle = '--'; 
    pDash.Color = 'black';
end
end

function drawingCar(car,road)
% figure(1);
%  cla;
axis([-50 50 road.start road.end ])
pSolid = plot([0 0],[road.start road.length],[(road.lane.number * road.lane.width) ...
    (road.lane.number * road.lane.width) ],[road.start road.end]);  
pSolid(1).LineWidth = 2;
pSolid(1).Color = 'black';
pSolid(2).LineWidth = 2;
pSolid(2).Color = 'black';
hold on 
for i = 1 : road.lane.number - 1
    pDash = plot([(i * road.lane.width) (i * road.lane.width)],[road.start road.length]);
    pDash.LineStyle = '--'; 
    pDash.Color = 'black';
end
line(car.recX,car.recY,'Color', car.color );
viscircles([car.x car.y],car.lidar.radius,'Color',car.color);
text(car.x,car.y, num2str(car.y))

end

function car = positionCalc(car,i,timeStep)
    car.x = car.x + timeStep * car.v * cos(car.phi);
    car.y = car.y + timeStep * car.v * sin(car.phi);
    car.phi = car.phi + timeStep * (car.v/car.L) * tan(car.psi);
    car.v = car.v + timeStep * car.a;
    
    PosX = car.x;
    PosY = car.y;
    recX0 = [-car.length/2 car.length/2 car.length/2 -car.length/2 -car.length/2];
    recY0 = [-car.width/2 -car.width/2 car.width/2 car.width/2 -car.width/2];
    RrecX0 = recX0 * cos(car.phi) - recY0*sin(car.phi);
    RrecY0 = recX0 * sin(car.phi) + recY0*cos(car.phi);
    car.recX = RrecX0 + PosX;
    car.recY = RrecY0 + PosY;
end

