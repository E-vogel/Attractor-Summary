clear  
close all 

% Create and configure the figure
f = figure;  % Create a new figure window
f.Color = 'k';  % Set the figure background color to black

% Initialize parameters and arrays
n = 100000;  % Set the number of iterations

a = 0.008;  % Define parameter a
b = 0.05;  % Define parameter b
c = zeros(3049,1);  % Initialize the c array with zeros
c(1) = -0.4959;  % Set the initial value of c

X = zeros(3049,n);  % Initialize the X array with zeros
Y = zeros(3049,n);  % Initialize the Y array with zeros
X(1:3049,1) = 1;  % Set the first column of X to 1
Y(1:3049,1) = -1;  % Set the first column of Y to -1

% Set up video writer and scatter plot
% v = VideoWriter('Gumowski_Mira.avi','Uncompressed AVI');  % Create a video writer object
% open(v);  % Open the video writer

s = scatter(X(1,1),Y(1,1),1,'filled');  % Create a scatter plot
msg = "$\mu =$ " + sprintf('%.4f',c(1));  % Create the initial text message for mu
Tmu = text(15,16,msg,'Color','w','Interpreter','latex','FontSize',15);  % Display the text on the figure
ColorData = zeros(3049,n);  % Initialize the color data array
axis([-20 25 -20 20])  % Set the axis limits
daspect([1 1 1])  % Set the data aspect ratio
axis off  % Turn off the axis
set(gca, 'LooseInset', get(gca, 'TightInset'));  % Adjust the axis inset

% Update the c array
for ii = 2:3049
    ii  % Display the current index
    c(ii) = c(ii-1) - 0.0001;  % Update the value of c
end

% Compute the Gumowski-Mira map
for i = 2:n
    i  % Display the current index
    % Update the values of X and Y using the Gumowski-Mira equations
    X(1:end,i) = Y(1:end,i-1) + a*Y(1:end,i-1).*(1 - b*Y(1:end,i-1).^2) + c(1:end).*X(1:end,i-1) + 2*(1 - c(1:end)).*(X(1:end,i-1).^2)./(1 + X(1:end,i-1).^2);
    Y(1:end,i) = -X(1:end,i-1) + c(1:end).*X(1:end,i) + 2*(1 - c(1:end)).*(X(1:end,i).^2)./(1 + X(1:end,i).^2);
end

% Update the plot and write frames to the video
for ii = 1:3049
    ii  % Display the current index
    for i = 1:n
        ColorData(ii,i) = norm([X(ii,i) Y(ii,i)]);  % Calculate the color data based on the norm of X and Y
        if ii == 1
            if i < 1000
                i  % Display the current index
                % Update the scatter plot data
                s.XData = X(ii,1:i);
                s.YData = Y(ii,1:i);
                s.CData = ColorData(ii,1:i);
%                frame = getframe(gcf);  % Capture the current figure as a frame
%                writeVideo(v,frame);  % Write the frame to the video
            elseif i >= 1000 && i < 10000 && mod(i,100) == 0
                i  % Display the current index
                % Update the scatter plot data
                s.XData = X(ii,1:i);
                s.YData = Y(ii,1:i);
                s.CData = ColorData(ii,1:i);
%                frame = getframe(gcf);  % Capture the current figure as a frame
%                writeVideo(v,frame);  % Write the frame to the video
            elseif i >= 10000 && mod(i,1000) == 0
                i  % Display the current index
                % Update the scatter plot data
                s.XData = X(ii,1:i);
                s.YData = Y(ii,1:i);
                s.CData = ColorData(ii,1:i);
%                frame = getframe(gcf);  % Capture the current figure as a frame
%                writeVideo(v,frame);  % Write the frame to the video
            end
        end
    end
    msg = "$\mu =$ " + sprintf('%.4f',c(ii));  % Update the text message for mu
    Tmu.String = msg;  % Update the displayed text
    s.XData = X(ii,1:end);  % Update the scatter plot data
    s.YData = Y(ii,1:end);  % Update the scatter plot data
    s.CData = ColorData(ii,1:end);  % Update the scatter plot color data
%     frame = getframe(gcf);  % Capture the current figure as a frame
%     writeVideo(v,frame);  % Write the frame to the video
    drawnow
end

% Write the final frames to the video to pause at the end
for ii = 1:200
%     frame = getframe(gcf);  % Capture the current figure as a frame
%     writeVideo(v,frame);  % Write the frame to the video
    drawnow
end
% close(v);  % Close the video writer
