%IEEE118 normal simulation
clear; clc;
define_constants;

fprintf('Loading IEEE 118-bus case...\n');

% Create MATPOWER options to suppress console output.
mpopt = mpoption('verbose', 0, 'out.all', 0, 'out.suppress_detail', 1);

mpc = loadcase('case118');

%arrays for results
samples = 15000;

voltage_results = zeros(samples, length(mpc.bus));
active_power_results = zeros(samples, length(mpc.bus));
reactive_power_results = zeros(samples, length(mpc.bus));


sigma = 0.05; % noise percentage
for i = 1:samples
    if mod(i,100) == 0
        fprintf("%d / %d done \n", i, samples)
    end

    run = runpf(mpc, mpopt);

    % Store voltage magnitude and angle
    active_power = run.bus(:,3); % Pd
    reactive_power = run.bus(:,4); % Qd
    voltages = run.bus(:, 8);  % Vm

    if run.success
    
        noise_V = sigma * randn(size(voltages));
        noise_P = sigma * randn(size(voltages));
        noise_Q = sigma * randn(size(voltages));

        voltages = voltages + noise_V;
        active_power = active_power + noise_P;
        reactive_power = reactive_power + noise_Q;
        
        voltage_results(i, :) = voltages; 
        active_power_results(i, :) = active_power;
        reactive_power_results (i, :) = reactive_power;
    else
        fprintf('didnt work')
    end
 end

%size(angle_results)
final_result = [voltage_results, reactive_power_results, active_power_results];

size(final_result)


% Write header and results to CSV file
csv_filename = 'IEE118_normal_results_15K.csv';
writematrix(final_result, csv_filename);

disp(['Results saved to ', csv_filename]);