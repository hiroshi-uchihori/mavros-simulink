clear
% ROS 2 ノードに接続（ROS_DOMAIN_IDは環境に合わせて設定済みと仮定）
ros2node = ros2node("/matlab_node");

takeoffClient = ros2svcclient(ros2node, "/mavros/cmd/takeoff", "mavros_msgs/CommandTOL");
reqTakeoff = ros2message(takeoffClient);

reqTakeoff.altitude = single(3);  % 離陸高度 (m)
reqTakeoff.latitude = single(0);    % 0で無視（現在位置を使う）
reqTakeoff.longitude = single(0);
reqTakeoff.min_pitch = single(0);
reqTakeoff.yaw = single(0);

resp = call(takeoffClient, reqTakeoff, "Timeout", 5)
