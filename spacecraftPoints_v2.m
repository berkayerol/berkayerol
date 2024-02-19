% Define the spacecraft vertices, faces, and patch colors
function [V, F, patchcolors] = spacecraft()
    % Define the vertices (physical location of vertices)
    V = [...
        1, 1, 0;    % point 1
        1, -1, 0;   % point 2
        -1, -1, 0;  % point 3
        -1, 1, 0;   % point 4
        1, 1, -2;   % point 5
        1, -1, -2;  % point 6
        -1, -1, -2; % point 7
        -1, 1, -2;  % point 8
        1.5, 1.5, 0;    % point 9
        1.5, -1.5, 0;   % point 10
        -1.5, -1.5, 0;  % point 11
        -1.5, 1.5, 0    % point 12
    ];
    
    % Define the faces as a list of vertices numbered above
    F = [...
        1, 2, 6, 5;  % front
        4, 3, 7, 8;  % back
        1, 5, 8, 4;  % right
        2, 6, 7, 3;  % left
        5, 6, 7, 8;  % top
        9, 10, 11, 12 % bottom
    ];

    % Define colors for each face
    myred = [1, 0, 0];
    mygreen = [0, 1, 0];
    myblue = [0, 0, 1];
    myyellow = [1, 1, 0];
    mycyan = [0, 1, 1];
    patchcolors = [...
        myred;      % front
        mygreen;    % back
        myblue;     % right
        myyellow;   % left
        mycyan;     % top
        mycyan      % bottom
    ];
end

% Draw the spacecraft body
function handle = drawSpacecraftBody(positionNorth, positionEast, positionDown, phi, theta, psi, handle, mode)
    % Define points on spacecraft
    [V, F, patchcolors] = spacecraft();
    
    % Rotate and then translate spacecraft
    V = rotate(V', phi, theta, psi)';
    V = translate(V', positionNorth, positionEast, positionDown)';
    
    % Transform NED to ENU for rendering
    R = [0, 1, 0; 1, 0, 0; 0, 0, -1];
    V = V * R;
    
    if isempty(handle)
        handle = patch('Vertices', V, 'Faces', F, ...
            'FaceVertexCData', patchcolors, ...
            'FaceColor', 'flat', ...
            'EraseMode', mode);
    else
        set(handle, 'Vertices', V, 'Faces', F);
        drawnow
    end
end
