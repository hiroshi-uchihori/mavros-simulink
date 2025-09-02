clear

node=ros2node('/matlab');

% サービスクライアント作成
wpClearClient = ros2svcclient(node, ...
    "/mavros/mission/clear","mavros_msgs/WaypointClear");

pause(1);

% リクエスト作成（フィールドなし）
reqClear = ros2message(wpClearClient);

% サービス呼び出し
respClear = call(wpClearClient, reqClear);

if respClear.success
    disp("Waypoints cleared successfully.");
else
    warning("Failed to clear waypoints.");
end