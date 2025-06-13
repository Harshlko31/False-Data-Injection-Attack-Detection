%IEEE118 attack simulation
clear; clc;
define_constants;

fprintf('Loading IEEE 118-bus case...\n');

% Create MATPOWER options to suppress console output.
mpopt = mpoption('verbose', 0, 'out.all', 0, 'out.suppress_detail', 1);

mpc = loadcase('case118');

%arrays for results
samples = 3750;

voltage_results = zeros(samples*4, length(mpc.bus));
active_power_results = zeros(samples*4, length(mpc.bus));
reactive_power_results = zeros(samples*4, length(mpc.bus));


sigma = 0.05; % noise percentage

%% attack on 1 bus at a time
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
        % inducing some random (gaussian) noise
        noise_V = sigma * randn(size(voltages));
        noise_P = sigma * randn(size(voltages));
        noise_Q = sigma * randn(size(voltages));

        voltages = voltages + noise_V;
        active_power = active_power + noise_P;
        reactive_power = reactive_power + noise_Q;

        %ATTACK SIMULATION
        bus1 = randi([1,118]); %select a random bus

        voltage_scenarios = [-1,0,1]; % 0 represents no attack, 1 and -1 represent attack
        activeP_scenarios = [-1,0,1];
        reactiveP_scenarios = [-1,0,1];
        
        is_voltage_attack = voltage_scenarios(randi([1, 3])); 
        is_activeP_attack = activeP_scenarios(randi([1, 3])); 
        is_reactiveP_attack = reactiveP_scenarios(randi([1, 3])); 
        
        while ~(is_voltage_attack && is_activeP_attack && is_reactiveP_attack)
            is_voltage_attack = voltage_scenarios(randi([1, 3])); 
            is_activeP_attack = activeP_scenarios(randi([1, 3])); 
            is_reactiveP_attack = reactiveP_scenarios(randi([1, 3]));
        end
        
        scale_factor_v = randi([80,200]);
        voltages(bus1) = voltages(bus1) + scale_factor_v * is_voltage_attack / 100;

        if is_activeP_attack == -1
            active_power(bus1) = randi([0,10]);
        else
            scale_factor_p = randi([80,200]);
            active_power(bus1) = active_power(bus1) + scale_factor_p * active_power(bus1) * is_activeP_attack / 100;
        end

        if is_reactiveP_attack == -1
            reactive_power(bus1) = randi([0,10]);
        else 
            scale_factor_q = randi([80,200]);
            reactive_power(bus1) = reactive_power(bus1) + scale_factor_q * reactive_power(bus1) * is_reactiveP_attack / 100;
        end
        
        voltage_results(i, :) = voltages; 
        active_power_results(i, :) = active_power;
        reactive_power_results (i, :) = reactive_power;
    end
end

%% attack on 2 bus at a time
for i = 1+samples:samples*2
    if mod(i,100) == 0
        fprintf("%d / %d done 2 bus \n", i, samples)
    end

    run = runpf(mpc, mpopt);

    % Store voltage magnitude and angle
    active_power = run.bus(:,3); % Pd
    reactive_power = run.bus(:,4); % Qd
    voltages = run.bus(:, 8);  % Vm

    if run.success
        % inducing some random (gaussian) noise
        noise_V = sigma * randn(size(voltages));
        noise_P = sigma * randn(size(voltages));
        noise_Q = sigma * randn(size(voltages));

        voltages = voltages + noise_V;
        active_power = active_power + noise_P;
        reactive_power = reactive_power + noise_Q;

        %ATTACK SIMULATION
        bus1 = randi([1,118]); %select a random bus
        bus2 = randi([1,118]);

        voltage_scenarios = [-1,0,1]; % 0 represents no attack, 1 and -1 represent attack
        activeP_scenarios = [-1,0,1];
        reactiveP_scenarios = [-1,0,1];
        
        is_voltage_attack = voltage_scenarios(randi([1, 3])); 
        is_activeP_attack = activeP_scenarios(randi([1, 3])); 
        is_reactiveP_attack = reactiveP_scenarios(randi([1, 3])); 
        
        while ~(is_voltage_attack && is_activeP_attack && is_reactiveP_attack)
            is_voltage_attack = voltage_scenarios(randi([1, 3])); 
            is_activeP_attack = activeP_scenarios(randi([1, 3])); 
            is_reactiveP_attack = reactiveP_scenarios(randi([1, 3]));
        end

        scale_factor_v = randi([80,200]);
        voltages(bus1) = voltages(bus1) + scale_factor_v * is_voltage_attack / 100;
        voltages(bus2) = voltages(bus2) + scale_factor_v * 1.2 * is_voltage_attack / 100;

        if is_activeP_attack == -1
            active_power(bus1) = randi([0,10]);
            active_power(bus2) = randi([0,10]);
        else
            scale_factor_p = randi([80,200]);
            active_power(bus1) = active_power(bus1) + scale_factor_p * active_power(bus1) * is_activeP_attack / 100;
            active_power(bus2) = active_power(bus2) + scale_factor_p * 1.2 * active_power(bus2) * is_activeP_attack / 100;
        end

        if is_reactiveP_attack == -1
            reactive_power(bus1) = randi([0,10]);
            reactive_power(bus2) = randi([0,10]);
        else 
            scale_factor_q = randi([80,200]);
            reactive_power(bus1) = reactive_power(bus1) + scale_factor_q * reactive_power(bus1) * is_reactiveP_attack / 100;
            reactive_power(bus2) = reactive_power(bus2) + scale_factor_q * 1.2 * reactive_power(bus2) * is_reactiveP_attack / 100;
        end
        
        voltage_results(i, :) = voltages; 
        active_power_results(i, :) = active_power;
        reactive_power_results (i, :) = reactive_power;
    end
 end

%% attack on 3 bus at a time
for i = 1+samples*2:samples*3
    if mod(i,100) == 0
        fprintf("%d / %d done 3 bus \n", i, samples)
    end

    run = runpf(mpc, mpopt);

    % Store voltage magnitude and angle
    active_power = run.bus(:,3); % Pd
    reactive_power = run.bus(:,4); % Qd
    voltages = run.bus(:, 8);  % Vm

    if run.success
        % inducing some random (gaussian) noise
        noise_V = sigma * randn(size(voltages));
        noise_P = sigma * randn(size(voltages));
        noise_Q = sigma * randn(size(voltages));

        voltages = voltages + noise_V;
        active_power = active_power + noise_P;
        reactive_power = reactive_power + noise_Q;

        %ATTACK SIMULATION
        bus1 = randi([1,118]); %select a random bus
        bus2 = randi([1,118]);
        bus3 = randi([1,118]);

        voltage_scenarios = [-1,0,1]; % 0 represents no attack, 1 and -1 represent attack
        activeP_scenarios = [-1,0,1];
        reactiveP_scenarios = [-1,0,1];
        
        is_voltage_attack = voltage_scenarios(randi([1, 3])); 
        is_activeP_attack = activeP_scenarios(randi([1, 3])); 
        is_reactiveP_attack = reactiveP_scenarios(randi([1, 3])); 
        
        while ~(is_voltage_attack && is_activeP_attack && is_reactiveP_attack)
            is_voltage_attack = voltage_scenarios(randi([1, 3])); 
            is_activeP_attack = activeP_scenarios(randi([1, 3])); 
            is_reactiveP_attack = reactiveP_scenarios(randi([1, 3]));
        end

        scale_factor_v = randi([80,200]);
        voltages(bus1) = voltages(bus1) + scale_factor_v * is_voltage_attack / 100;
        voltages(bus2) = voltages(bus2) + scale_factor_v * 1.2 * is_voltage_attack / 100;
        voltages(bus3) = voltages(bus3) + scale_factor_v * 1.4 * is_voltage_attack / 100;

        if is_activeP_attack == -1
            active_power(bus1) = randi([0,10]);
            active_power(bus2) = randi([0,10]);
            active_power(bus3) = randi([0,10]);
        else
            scale_factor_p = randi([80,200]);
            active_power(bus1) = active_power(bus1) + scale_factor_p * active_power(bus1) * is_activeP_attack / 100;
            active_power(bus2) = active_power(bus2) + scale_factor_p * 1.2 * active_power(bus2) * is_activeP_attack / 100;
            active_power(bus3) = active_power(bus3) + scale_factor_p * 1.4 * active_power(bus3) * is_activeP_attack / 100;
        end

        if is_reactiveP_attack == -1
            reactive_power(bus1) = randi([0,10]);
            reactive_power(bus2) = randi([0,10]);
            reactive_power(bus3) = randi([0,10]);
        else 
            scale_factor_q = randi([80,200]);
            reactive_power(bus1) = reactive_power(bus1) + scale_factor_q * reactive_power(bus1) * is_reactiveP_attack / 100;
            reactive_power(bus2) = reactive_power(bus2) + scale_factor_q * 1.2 * reactive_power(bus2) * is_reactiveP_attack / 100;
            reactive_power(bus3) = reactive_power(bus3) + scale_factor_q * 1.4 * reactive_power(bus3) * is_reactiveP_attack / 100;
        end
        
        voltage_results(i, :) = voltages; 
        active_power_results(i, :) = active_power;
        reactive_power_results (i, :) = reactive_power;
    end
 end

%% attack on 4 bus at a time
for i = 1+samples*3:samples*4
    if mod(i,100) == 0
        fprintf("%d / %d done 4 bus \n", i, samples)
    end

    run = runpf(mpc, mpopt);

    % Store voltage magnitude and angle
    active_power = run.bus(:,3); % Pd
    reactive_power = run.bus(:,4); % Qd
    voltages = run.bus(:, 8);  % Vm

    if run.success
        % inducing some random (gaussian) noise
        noise_V = sigma * randn(size(voltages));
        noise_P = sigma * randn(size(voltages));
        noise_Q = sigma * randn(size(voltages));

        voltages = voltages + noise_V;
        active_power = active_power + noise_P;
        reactive_power = reactive_power + noise_Q;

        %ATTACK SIMULATION
        bus1 = randi([1,118]); %select a random bus
        bus2 = randi([1,118]);
        bus3 = randi([1,118]);
        bus4 = randi([1,118]);

        voltage_scenarios = [-1,0,1]; % 0 represents no attack, 1 and -1 represent attack
        activeP_scenarios = [-1,0,1];
        reactiveP_scenarios = [-1,0,1];
        
        is_voltage_attack = voltage_scenarios(randi([1, 3])); 
        is_activeP_attack = activeP_scenarios(randi([1, 3])); 
        is_reactiveP_attack = reactiveP_scenarios(randi([1, 3])); 
        
        while ~(is_voltage_attack && is_activeP_attack && is_reactiveP_attack)
            is_voltage_attack = voltage_scenarios(randi([1, 3])); 
            is_activeP_attack = activeP_scenarios(randi([1, 3])); 
            is_reactiveP_attack = reactiveP_scenarios(randi([1, 3]));
        end

        scale_factor_v = randi([80,200]);
        voltages(bus1) = voltages(bus1) + scale_factor_v * is_voltage_attack / 100;
        voltages(bus2) = voltages(bus2) + scale_factor_v * 1.2 * is_voltage_attack / 100;
        voltages(bus3) = voltages(bus3) + scale_factor_v * 1.4 * is_voltage_attack / 100;
        voltages(bus4) = voltages(bus4) + scale_factor_v * 1.6 * is_voltage_attack / 100;

        if is_activeP_attack == -1
            active_power(bus1) = randi([0,10]);
            active_power(bus2) = randi([0,10]);
            active_power(bus3) = randi([0,10]);
            active_power(bus4) = randi([0,10]);
        else
            scale_factor_p = randi([80,200]);
            active_power(bus1) = active_power(bus1) + scale_factor_p * active_power(bus1) * is_activeP_attack / 100;
            active_power(bus2) = active_power(bus2) + scale_factor_p * 1.2 * active_power(bus2) * is_activeP_attack / 100;
            active_power(bus3) = active_power(bus3) + scale_factor_p * 1.4 * active_power(bus3) * is_activeP_attack / 100;
            active_power(bus4) = active_power(bus4) + scale_factor_p * 1.6 * active_power(bus4) * is_activeP_attack / 100;
        end

        if is_reactiveP_attack == -1
            reactive_power(bus1) = randi([0,10]);
            reactive_power(bus2) = randi([0,10]);
            reactive_power(bus3) = randi([0,10]);
            reactive_power(bus4) = randi([0,10]);
        else 
            scale_factor_q = randi([80,200]);
            reactive_power(bus1) = reactive_power(bus1) + scale_factor_q * reactive_power(bus1) * is_reactiveP_attack / 100;
            reactive_power(bus2) = reactive_power(bus2) + scale_factor_q * 1.2 * reactive_power(bus2) * is_reactiveP_attack / 100;
            reactive_power(bus3) = reactive_power(bus3) + scale_factor_q * 1.4 * reactive_power(bus3) * is_reactiveP_attack / 100;
            reactive_power(bus4) = reactive_power(bus4) + scale_factor_q * 1.6 * reactive_power(bus4) * is_reactiveP_attack / 100;
        end
        
        voltage_results(i, :) = voltages; 
        active_power_results(i, :) = active_power;
        reactive_power_results (i, :) = reactive_power;
    end
 end

%size(angle_results)
final_result = [voltage_results, reactive_power_results, active_power_results];

size(final_result)


% Write header and results to CSV file
csv_filename = 'IEE118_attack_results_15k.csv';
writematrix(final_result, csv_filename);

disp(['Results saved to ', csv_filename]);