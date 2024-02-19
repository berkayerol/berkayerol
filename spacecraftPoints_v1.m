function XYZ = spacecraftPoints()
% Define points on the spacecraft in local NED coordinates
XYZ = [
    1 1 0;    % point 1
    1 -1 0;   % point 2
    -1 -1 0;  % point 3
    -1 1 0;   % point 4
    1 1 0;    % point 1
    1 1 -2;   % point 5
    1 -1 -2;  % point 6
    1 -1 0;   % point 2
    1 -1 -2;  % point 6
    -1 -1 -2; % point 7
    -1 -1 0;  % point 3
    -1 -1 -2; % point 7
    -1 1 -2;  % point 8
    -1 1 0;   % point 4
    -1 1 -2;  % point 8
    1 1 -2;   % point 5
    1 1 0;    % point 1
    1.5 1.5 0;    % point 9
    1.5 -1.5 0;   % point 10
    1 -1 0;       % point 2
    1.5 -1.5 0;   % point 10
    -1.5 -1.5 0;  % point 11
    -1 -1 0;      % point 3
    -1.5 -1.5 0;  % point 11
    -1.5 1.5 0;   % point 12
    -1 1 0;       % point 4
    -1.5 1.5 0;   % point 12
    1.5 1.5 0;    % point 9
];
end

function XYZ = rotate(XYZ, phi, theta, psi)
% Define rotation matrices
R_roll = [
    1, 0, 0;
    0, cos(phi), -sin(phi);
    0, sin(phi), cos(phi)
];
R_pitch = [
    cos(theta), 0, sin(theta);
    0, 1, 0;
    -sin(theta), 0, cos(theta)
];
R_yaw = [
    cos(psi), -sin(psi), 0;
    sin(psi), cos(psi), 0;
    0, 0, 1
];
% Compute combined rotation matrix
R = R_roll * R_pitch * R_yaw;
% Rotate vertices
XYZ = R * XYZ;
end

function XYZ = translate(XYZ, pn, pe, pd)
XYZ = XYZ + repmat([pn; pe; pd], 1, size(XYZ, 2));
end

function handle = drawSpacecraftBody(pn, pe, pd, phi, theta, psi, handle, mode)
% Define points on spacecraft in local NED coordinates
NED = spacecraftPoints();
% Rotate spacecraft by phi, theta, psi
NED = rotate(NED, phi, theta, psi);
% Translate spacecraft to [pn; pe; pd]
NED = translate(NED, pn, pe, pd);
% Transform vertices from NED to XYZ (for MATLAB rendering)
R = [
    0, 1, 0;
    1, 0, 0;
    0, 0, -1
];
XYZ = R * NED;
% Plot spacecraft
if isempty(handle)
    handle = plot3(XYZ(1,:), XYZ(2,:), XYZ(3,:), 'EraseMode', mode);
else
    set(handle, 'XData', XYZ(1,:), 'YData', XYZ(2,:), 'ZData', XYZ(3,:));
    drawnow;
end
end
