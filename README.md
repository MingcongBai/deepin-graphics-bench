deepin 自动化图形测试集
===

本仓库提供一个最小化环境中运行 deepin 图形化对比测试的工具集，运行如下几个测试：

- glmark2（标准流程）
- glxgears（标准大小、无垂直同步，运行 60 秒）
- UnixBench 2D 测试

支持如下系统作为对比：

- deepin V20 及 V23
- Debian >= 10
- Ubuntu >= 20.04
- 其他兼容或基于上述发行版衍生的系统

用法
---

以 root 用户在 TTY 环境下，确保无其他 X 会话运行后，运行如下命令：

```
./bench.bash
```

随后，本工具集将自动构建和安装相关测试工具并执行测试，测试结果会在图形终端中显示。
