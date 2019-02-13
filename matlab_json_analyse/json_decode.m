% opens the JSON file and stores it in variable
fname = 'database.json';
db = jsondecode(fileread(fname));

% note: the file should already be sorted with only messages we want
% so good SF, only gateway we want...

% to take only values from on gateway
gateway_we_want = "004A1092";

db = db(end-1:end);     % to work only on two last, temporary

% get values
number_message = length(db);
distances = zeros(number_message, 1);
RSSI = zeros(number_message, 1);
ESP = zeros(number_message, 1);
SNR = zeros(number_message, 1);
for i=1: number_message
    gateway_index = 0;
    distances(i) = db{i}.real_dist;
    for j=1: length(db{1}.gateway_id(:))
        if db{i}.gateway_id(j) == gateway_we_want
            gateway_index = j;
        end
    end
    if gateway_index ~= 0
        RSSI(i) = db{i}.gateway_rssi(gateway_index);
        SNR(i)  = db{i}.gateway_snr(gateway_index);
        ESP(i)  = db{i}.gateway_esp(gateway_index);        
    end
end

% plotting RSSI
figure();
scatter(distances, RSSI, 'filled');
xlabel('Real distance [m]');
ylabel('RSSI [dBm]');
title('RSSI function of distance');

% plotting ESP
figure();
scatter(distances, ESP, 'filled');
xlabel('Real distance [m]');
ylabel('ESP [dBm]');
title('ESP function of distance');