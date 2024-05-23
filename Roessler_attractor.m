clear  
close all  

% Parameters for the simulation
fin = 10000;  % Number of time steps
n = 1000;  % Number of particles

h = 0.005;  % Time step size

% Constants for the Rössler attractor
a = 5.7;
c = 0.2;

% Initial conditions for particles
X = 1;
Y = 1;
Z = 0;

% Initialize arrays to store particle trajectories
for i = 1:n
    x_str{i} = zeros(fin+1, 1);
    y_str{i} = zeros(fin+1, 1);
    z_str{i} = zeros(fin+1, 1);
    x{i} = X;
    y{i} = Y;
    z{i} = Z;
    x_str{i}(1) = x{i};
    y_str{i}(1) = y{i};
    z_str{i}(1) = z{i};
end

% Parallel loop to simulate particle trajectories
parfor i = 1:n
    i  % Display the current particle index
    b = 0.01 * i;  % Vary parameter b for each particle
    for t = 0:fin
        dx = -y{i} - z{i};
        dy = x{i} + c * y{i};
        dz = b + x{i} .* z{i} - a * z{i};
        
        % Runge-Kutta 4th order method for x
        kx1 = dx;
        kx2 = dx + h * kx1 / 2;
        kx3 = dx + h * kx2 / 2;
        kx4 = dx + h * kx3;
        x{i} = x{i} + h * (1/6) * (kx1 + 2 * kx2 + 2 * kx3 + kx4);
        
        % Runge-Kutta 4th order method for y
        ky1 = dy;
        ky2 = dy + h * ky1 / 2;
        ky3 = dy + h * ky2 / 2;
        ky4 = dy + h * ky3;
        y{i} = y{i} + h * (1/6) * (ky1 + 2 * ky2 + 2 * ky3 + ky4);
        
        % Runge-Kutta 4th order method for z
        kz1 = dz;
        kz2 = dz + h * kz1 / 2;
        kz3 = dz + h * kz2 / 2;
        kz4 = dz + h * kz3;
        z{i} = z{i} + h * (1/6) * (kz1 + 2 * kz2 + 2 * kz3 + kz4);
        
        % Store computed values
        x_str{i}(t+1) = x{i};
        y_str{i}(t+1) = y{i};
        z_str{i}(t+1) = z{i};
    end
end

% Create and configure the figure
f = figure;
f.Color = 'k';  % Set figure background color to black

% Set up video writer and initial plot
% v = VideoWriter('Roessler_eqv2.mp4', 'MPEG-4');
% open(v);

s1 = plot3(x_str{1}(1:end), y_str{1}(1:end), z_str{1}(1:end), 'r');  % Plot initial trajectory
axis([-15 15 -15 15 -5 30])  % Set axis limits
daspect([1 1 1])  % Set data aspect ratio
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
zlabel('$z$', 'Interpreter', 'latex')
axis off  % Turn off axis
set(gca, 'LooseInset', get(gca, 'TightInset'));  % Adjust axis inset

% Update the plot and write frames to the video
for j = 1:n
    s1.XData = x_str{j}(1:end);
    s1.YData = y_str{j}(1:end);
    s1.ZData = z_str{j}(1:end);
%     frame = getframe(gcf);  % Capture the current figure as a frame
%     writeVideo(v, frame);  % Write the frame to the video
    drawnow
end
% close(v);  % Close the video writer
