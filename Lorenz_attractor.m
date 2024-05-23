clear 
close all

% Parameters for the simulation
fin = 3000;  % Number of time steps
h = 0.001;  % Time step size

% Constants for the Lorenz attractor
a = 10;
b = 28;
c = 8/3;

% Generate initial points on a sphere
[Xs, Ys, Zs] = sphere(100);
X = []; Y = []; Z = [];
for i = 1:101
    X = [X; 240*Xs(:,i)];
    Y = [Y; 240*Ys(:,i)];
    Z = [Z; 240*Zs(:,i)];
end

% Initialize arrays to store particle trajectories
x_str = zeros(fin+1, length(X));
y_str = zeros(fin+1, length(Y));
z_str = zeros(fin+1, length(Z));

% Initial conditions for particles
x = X;
y = Y;
z = Z;

x_str(1,:) = x;
y_str(1,:) = y;
z_str(1,:) = z;

w = waitbar(0);  % Create a waitbar to track progress

% Simulate particle trajectories
for t = 0:fin
    msg = "(" + t + "/" + fin + ")";
    waitbar(t/fin, w, msg);  % Update waitbar
    dx = -a*x + a*y;
    dy = -x.*z + b*x - y;
    dz = x.*y - c.*z;
    
    % Runge-Kutta 4th order method for x
    kx1 = dx;
    kx2 = dx + h*kx1/2;
    kx3 = dx + h*kx2/2;
    kx4 = dx + h*kx3;
    x = x + h*(1/6)*(kx1+2*kx2+2*kx3+kx4);
    
    % Runge-Kutta 4th order method for y
    ky1 = dy;
    ky2 = dy + h*ky1/2;
    ky3 = dy + h*ky2/2;
    ky4 = dy + h*ky3;
    y = y + h*(1/6)*(ky1+2*ky2+2*ky3+ky4);
    
    % Runge-Kutta 4th order method for z
    kz1 = dz;
    kz2 = dz + h*kz1/2;
    kz3 = dz + h*kz2/2;
    kz4 = dz + h*kz3;
    z = z + h*(1/6)*(kz1+2*kz2+2*kz3+kz4);
    
    % Store computed values
    x_str(t+1,:) = x;
    y_str(t+1,:) = y;
    z_str(t+1,:) = z;
end

% Calculate color data for scatter plot
ColorData = zeros(size(X));
for g = 1:length(X)
    ColorData(g) = norm([x_str(g) y_str(g) z_str(g)]);
end
colormap parula  % Set colormap

% Set up video writer and initial plot
% v = VideoWriter('Lorenz_attractor.mp4', 'MPEG-4');
% open(v);

s = scatter3(x_str(1,:), y_str(1,:), z_str(1,:), 5, 'filled', 'CData', ColorData/max(ColorData));
daspect([1 1 1])  % Set data aspect ratio
view(25, 15)  % Set view angle
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
zlabel('$z$', 'Interpreter', 'latex')
set(gca, 'TickLabelInterpreter', 'latex')

% Update the plot and write frames to the video
for n = 1:2:fin+1
    n  % Display the current frame index
    s.XData = x_str(n,:);
    s.YData = y_str(n,:);
    s.ZData = z_str(n,:);
    
    % Adjust axis limits and marker size dynamically
    if n <= 700
        axis([-250 250 -250 250 -250 300])
    elseif n > 700 && n <= 1050
        axis([-250 250 -250 250 -250 300] * (0.995^(n-700)))
        s.SizeData = 5 * (0.996^(n-700));
    else
        axis([-250 250 -250 250 -250*(0.99^(n-1050)) 300] * (0.995^(1050-700)))
    end
%     frame = getframe(gcf);  % Capture the current figure as a frame
%     writeVideo(v, frame);  % Write the frame to the video
    drawmow
end
% close(v);  % Close the video writer
