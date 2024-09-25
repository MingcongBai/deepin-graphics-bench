echo '正在运行 glmark2 测试 ...'
@PREFIX@/bin/glmark2

echo '正在启动下一个测试 ...'
xterm -e /bin/bash -l -c "${_PREFIX}"/bench-scripts/glxgears.bash

read -p '当前测试已完成，按 [Enter] 键可退出'
