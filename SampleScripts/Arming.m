clear
% ROS 2 ノードに接続（ROS_DOMAIN_IDは環境に合わせて設定済みと仮定）
ros2node = ros2node("/matlab_node");

% サービスクライアントを作成
client = ros2svcclient(ros2node, "/mavros/cmd/arming", "mavros_msgs/CommandBool");

% リクエストメッセージを生成
req = ros2message(client);

% データを設定（trueでアーム、falseでディスアーム）
req.value = true;

% サービス呼び出し
resp = call(client, req, Timeout=5)