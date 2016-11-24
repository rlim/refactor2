function const = output_definition( constant, variable, default )
% data structure format changes
% +-------------------------------------------------------------
% | model       | rev  | Date   | Notes
% +-------------+------+--------+-------------------------------
% +-------------+------+--------+-------------------------------

const = [];

if nargin < 2,  variable = [];  end
if nargin < 3,  default  = [];  end

% --- if no parameter, return the empty structure
if nargin == 0,     return;     end;


switch upper( constant )
    % --- definition model version
    % --- ------------------------------------
    case 'FORMAT_VER',          const = '1.00';  return;
        
        
        % --- output definitions for show_clusters()  peak MNI data display
        % --- ------------------------------------
    case 'CLUSTER_HEADER', 	const = sprintf( '\n %17s %17s', 'Volume', 'Peak MNI Coord' );
        const = [ const '\n   Voxels    (mm)      x     y     z  loading'];
        const = [ const '\n ' separator_line( 45, '-' ) '\n' ];
        return;
        %    case 'MNI_HEADER_2', 		const = '  Voxels    (mm)      x     y     z  loading';     return;
        %    case 'MNI_HEADER_3', 		const = [ ' ' separator_line( 45, '-' ) ];  						return;
    case 'CLUSTER_FORMAT', 	const = '  %7d  %7d  %4d  %4d  %4d  %7.4f\n';        return;
    case 'CLUSTER_REGION',     const = '                    %4d  %4d  %4d  %7.4f'; return;
        
end;


