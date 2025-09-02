clear

%% ROS 2 ノード作成
ros2node = ros2node("/matlab_mavros_node");


%% トピック: 絶対座標で位置指定
posPub = ros2publisher(ros2node,"/","mavros_msgs/PositionTarget");

% 目的地の緯度・経度・高度を設定（例: 東京タワー付近）
targetPose = ros2message(posPub);

% NED座標系
targetPose.pose.position.
targetPose.pose.position.latitude = 32.697334;   % 緯度
targetPose.pose.position.longitude = 129.784267; % 経度
targetPose.pose.position.altitude = 5;        % 高度[m]

% g.coordinate_frame = uint8(msg.FRAME_LOCAL_NED);ヘッダータイムスタンプを現在時間に
%targetPose.header.stamp = rostime("now");

% 送信（OFFBOARD では一定周期で送る必要あり）
rate = ros2rate(ros2node,10); % 10Hz
for i = 1:10
    send(posPub, targetPose);
    waitfor(rate);
end

disp("位置指定送信完了");
