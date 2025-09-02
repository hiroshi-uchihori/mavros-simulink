%% MATLAB: MAVROS グローバル座標取得
clear;

% ROS2ノード作成
node = ros2node("/mavros_listener");

% コールバック関数
function gpsCallback(msg, ~)
    lat = msg.latitude;
    lon = msg.longitude;
    alt = msg.altitude;
    fprintf("GPS: lat = %.6f, lon = %.6f, alt = %.2f m\n", lat, lon, alt);
end

% Subscriber作成（MAVROS と互換性のある QoS）
gpsSub = ros2subscriber(node, "/mavros/global_position/global", "sensor_msgs/NavSatFix", @gpsCallback, "Reliability", "besteffort");

disp('グローバル座標の取得を開始...');

