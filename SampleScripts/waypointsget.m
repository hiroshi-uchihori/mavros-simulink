clear

% ROS 2 ノードを作成
node = ros2node("/matlab_node");

% ミッションを取得するサービスクライアント
client = ros2svcclient(node,"/mavros/mission/pull","mavros_msgs/WaypointPull");

% サービスが準備できるまで待機
waitForServer(client);

% 呼び出し
req = ros2message(client);
resp = call(client, req);

% レスポンス確認
disp(resp);

%%
% サブスクライバを作成
sub = ros2subscriber(node,"/mavros/mission/waypoints");

pause(1.0); % 少し待つ（MAVROSがWaypointsを更新する時間）

% 最新メッセージを取得
msg = receive(sub,3); % タイムアウト3秒

% Waypointsの内容を表示
for i = 1:length(msg.waypoints)
    wp = msg.waypoints(i);
    fprintf("WP %d: lat=%.7f, lon=%.7f, alt=%.2f, command=%d\n", ...
        wp.frame, wp.x_lat, wp.y_long, wp.z_alt, wp.command);
end

