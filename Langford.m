clear  
close all

% Parameters for the simulation
fin = 10000;  % Number of time steps
h = 0.01;  % Time step size

% Constants for the differential equations
d = 1;
u = 0.7;
n = 0.6;
w = 3.5;
l = 0.25;
e = 0;

particles = 20;  % Number of particles

% Initialize arrays to store particle trajectories
x_str = zeros(particles,fin+1);
y_str = zeros(particles,fin+1);
z_str = zeros(particles,fin+1);

% Initial conditions for particles
x_str(:,1) = rand(particles,1)/100 + 1.1;
y_str(:,1) = rand(particles,1)/100 + 0.1;
z_str(:,1) = rand(particles,1)/100 + 1;

% Simulate particle trajectories
for i = 1:particles
    x = x_str(i,1);
    y = y_str(i,1);
    z = z_str(i,1);
    i  % Display the current particle index
    for t = 0:fin
        % Differential equations
        dx = (z - u)*x - w*y;
        dy = w*x + (z - u)*y;
        dz = n + d*z - (z^3)/3 - (x^2 + y^2)*(1 + l*z) + e*z*x^3;
        
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
        x_str(i,t+1) = x;
        y_str(i,t+1) = y;
        z_str(i,t+1) = z;
    end
end

% Create and configure the figure
f = figure;
f.Color = 'k';  % Set figure background color to black

% Plot the trajectories
color_str = parula(particles);  % Generate colors for particles
% v = VideoWriter('Langford.mp4','MPEG-4');  % Create video writer object
% open(v);  % Open the video writer
for jj = 1:particles
    p(jj) = plot3(x_str(jj,1),y_str(jj,1),z_str(jj,1),"Color",color_str(jj,:));  % Plot initial points
    hold on
    s(jj) = scatter3(x_str(jj,1),y_str(jj,1),z_str(jj,1),10,"filled","MarkerFaceColor",color_str(jj,:));  % Scatter initial points
end
view(10,20)  % Set view angle
daspect([1 1 1])  % Set data aspect ratio
axis([-2 2 -2 2 -2 2])  % Set axis limits
axis off  % Turn off axis
set(gca, 'LooseInset', get(gca, 'TightInset'));  % Adjust axis inset
hold off

% Update the plot and write frames to the video
for j = 1:fin
    if j > 300 && mod(j,10) ~= 0
        continue  % Skip frames for efficiency
    end
    for jj = 1:particles
        % Update plot data for each particle
        p(jj).XData = x_str(jj,1:j);
        p(jj).YData = y_str(jj,1:j);
        p(jj).ZData = z_str(jj,1:j);
        p(jj).Color = color_str(jj,:);
        hold on
        s(jj).XData = x_str(jj,j);
        s(jj).YData = y_str(jj,j);
        s(jj).ZData = z_str(jj,j);
        s(jj).MarkerFaceColor = color_str(jj,:);
    end
    j  % Display the current frame index
%     frame = getframe(gcf);  % Capture the current figure as a frame
%     writeVideo(v,frame);  % Write the frame to the video
    drawnow
end
% close(v);  % Close the video writer
