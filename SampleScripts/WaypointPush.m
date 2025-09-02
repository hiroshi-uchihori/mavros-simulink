clear

node=ros2node('/matlab');

% サービスクライアント作成
wpClearClient = ros2svcclient(node, ...
    "/mavros/mission/clear", ...
    "mavros_msgs/WaypointClear");

pause(0.5);

% リクエスト作成（フィールドなし）
reqClear = ros2message(wpClearClient);

% サービス呼び出し
respClear = call(wpClearClient, reqClear);

if respClear.success
    disp("Waypoints cleared successfully.");
else
    warning("Failed to clear waypoints.");
end


wp0 = ros2message("mavros_msgs/Waypoint");
wp0.frame = uint8(3);  % MAV_FRAME_GLOBAL_REL_ALT
wp0.command = uint16(16);  % MAV_CMD_NAV_WAYPOINT
wp0.is_current = true;
wp0.autocontinue = true;
wp0.x_lat = 32.698307;  % 緯度
wp0.y_long = 129.783437; % 経度
wp0.z_alt = 10;         % 高度[m]

wp1 = ros2message("mavros_msgs/Waypoint");
wp1.frame = uint8(3);  % MAV_FRAME_GLOBAL_REL_ALT
wp1.command = uint16(16);  % MAV_CMD_NAV_WAYPOINT
wp1.is_current = false;
wp1.autocontinue = true;
wp1.x_lat = 32.697292;  % 緯度
wp1.y_long = 129.784437; % 経度
wp1.z_alt = 10;         % 高度[m]

% Waypoint 2: Navigate to point
wp2 = ros2message("mavros_msgs/Waypoint");
wp2.frame = uint8(3);
wp2.command = uint16(16);  % MAV_CMD_NAV_WAYPOINT
wp2.is_current = false;
wp2.autocontinue = true;
wp2.x_lat = 32.698020;
wp2.y_long = 129.785450;
wp2.z_alt = 10;

wpPushClient   = ros2svcclient(node,"/mavros/mission/push","mavros_msgs/WaypointPush");
wpPushMsg = ros2message(wpPushClient);
wpPushMsg.start_index = uint16(0); 
wpPushMsg.waypoints = [wp0,wp1,wp2];

pause(0.5);
respPush = call(wpPushClient,wpPushMsg);


if respPush.success
    disp(['Waypoints pushed: ', num2str(respPush.wp_transfered)]);
else
    warning("Failed to push waypoints.");
end