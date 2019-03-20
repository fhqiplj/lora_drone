%% sets the parameters used in the simulations

% general parameters
time_limit = 30*60;     % 15 minutes
drone_speed = 1;        % 1 m/s
signal_type = 'esp';    % can be 'esp' or 'rssi'
altitude = 10;          % flies at 10m
number_measures = 2;    % makes 2 measures at each point

% boolean for plotting and printing
plot_bool = true;       
plot_movement_bool = true;
print_bool = true;

% node position and estimate from network
pos_true_node = [0, 0, 0];
pos_network_error = 150; 
pos_network_estimate = pos_true_node + [rand()*pos_network_error*cos(rand()*2*pi), rand()*pos_network_error*sin(rand()*2*pi), 0];

% name of the running script
file_run = dbstack(1);
file_run_name = file_run.name;

%% for gradient follow
switch file_run_name 
    
    case 'sim2_1drone_gradient'
        % distance increment
        dist_increment = 10;
        increment_0p0 = [0, dist_increment, 0];
        increment_0m0 = [0, -dist_increment, 0];
        increment_p00 = [dist_increment, 0, 0];
        increment_m00 = [-dist_increment, 0, 0];
        
        % drone starting position
        pos_drone = pos_network_estimate;
        
    case 'sim2_1drone_trilateration'
        % measuring positions
        size_around_estimation_v1 = 100;
        size_around_estimation_v2 = 30;
        measure_position1 = pos_network_estimate + [0, -size_around_estimation_v1, 0];   % south
        measure_position2 = pos_network_estimate + [size_around_estimation_v1*cos(pi/6), size_around_estimation_v1*sin(pi/6), 0];   % north east	
        measure_position3 = pos_network_estimate + [-size_around_estimation_v1*cos(pi/6), size_around_estimation_v1*sin(pi/6), 0];   % north east	
        
        % drone starting position
        pos_drone = pos_network_estimate;
        
        % number of loops of trilateration
        algo_loops_todo = 2;
        
    case 'sim2_1drone_trilateration_mod'
        % measuring positions
        size_around_estimation_v1 = 100;
        size_around_estimation_v2 = 30;
        angle_total = 120*pi/180;        % angle instead of 360deg
        measure_position1 = pos_network_estimate + [size_around_estimation_v1, 0, 0];   
        measure_position2 = pos_network_estimate + [size_around_estimation_v1*cos(angle_total/2), size_around_estimation_v1*sin(angle_total/2), 0];   
        measure_position3 = pos_network_estimate + [size_around_estimation_v1*cos(angle_total), size_around_estimation_v1*sin(angle_total), 0];   
        
        % drone starting position
        pos_drone = pos_network_estimate;
        
        % number of loops of trilateration
        algo_loops_todo = 2;
        
    case 'sim2_3drone_trilateration'
        % measureing positions
        size_around_estimation_v1 = 100;
        size_around_estimation_v2 = 30;
        measure_position1 = pos_network_estimate + [0, -size_around_estimation_v1, 0];   % south
        measure_position2 = pos_network_estimate + [size_around_estimation_v1*cos(pi/6), size_around_estimation_v1*sin(pi/6), 0];   % north east	
        measure_position3 = pos_network_estimate + [-size_around_estimation_v1*cos(pi/6), size_around_estimation_v1*sin(pi/6), 0];   % north east	
        
        % drone starting position
        pos_drone1 = pos_network_estimate;
        pos_drone2 = pos_network_estimate;
        pos_drone3 = pos_network_estimate;
        
        % number of loops of trilateration
        algo_loops_todo = 2;
        
    case 'sim2_1drone_continuous'
        % drone starting position
        pos_drone = pos_network_estimate;
        
        % pattern
        pattern_shape = 'circle';
        pattern_center = pos_network_estimate;
        pattern_radius = 70;
        pattern_radius_v2 = 30;
        pattern_angle_start = 0;
        pattern_anglerad_per_second = drone_speed / pattern_radius;
        pattern_anglerad_per_second_v2 = drone_speed / pattern_radius_v2;
        
        % number of loops
        algo_loops_todo = 2;
        
    case 'sim2_3drone_continuous'
        % drone starting position
        pos_drone1 = pos_network_estimate;
        pos_drone2 = pos_network_estimate;
        pos_drone3 = pos_network_estimate;
        
        % pattern
        pattern_shape = 'circle';
        pattern_dist_from_estimate = 100;
        pattern_center1 = pos_network_estimate + [0, -pattern_dist_from_estimate, 0];   % south
        pattern_center2 = pos_network_estimate + [pattern_dist_from_estimate*cos(pi/6), pattern_dist_from_estimate*sin(pi/6), 0];   % north east	
        pattern_center3 = pos_network_estimate + [-pattern_dist_from_estimate*cos(pi/6), pattern_dist_from_estimate*sin(pi/6), 0];   % north west	
        pattern_radius = 70;
        pattern_angle_start1 = pi/2;
        pattern_angle_start2 = 4*pi/3;
        pattern_angle_start3 = -pi/3;
        pattern_anglerad_per_second = drone_speed / pattern_radius;
        
    otherwise
        % drone starting position
        pos_drone = pos_network_estimate;
        
end


%% change based on experiment counter
if isfile('matlab_sim_v2/temp.mat')     % simulation run from 'multiple_run.m'
    plot_bool = false;
    print_bool = false;
    plot_movement_bool = false;
    load('matlab_sim_v2/temp.mat', 'experiment_counter', 'number_experiments');
    if experiment_counter < number_experiments/2

    else

    end
end