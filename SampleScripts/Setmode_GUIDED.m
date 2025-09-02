clear

node=ros2node('/matlab');
% (1) GUIDEDモード要求
modeClient = ros2svcclient(node,"/mavros/set_mode","mavros_msgs/SetMode");
waitForServer(modeClient, "Timeout", 2);

modeReq = ros2message(modeClient);

modeReq.base_mode = uint8(0);  
modeReq.custom_mode = 'GUIDED';   % ← string として代入

resp = call(modeClient, modeReq, Timeout=5)

clear node

