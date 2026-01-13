#!/bin/bash

echo "🛑 停止史迹寻踪 - AI历史剧本创作系统"
echo "========================================"

# 停止所有Agents
echo "🤖 停止所有Agents..."
pkill -f "openagents agent start"
AGENT_COUNT=$(ps aux | grep "agent.*yaml" | grep -v grep | wc -l)
if [ $AGENT_COUNT -eq 0 ]; then
    echo "   ✅ 所有Agents已停止"
else
    echo "   ⚠️  仍有 $AGENT_COUNT 个Agents运行中，强制停止..."
    pkill -9 -f "openagents agent start"
fi

# 停止网络
echo "🌐 停止OpenAgents网络..."
pkill -f "openagents network start"
NETWORK_COUNT=$(ps aux | grep "openagents network" | grep -v grep | wc -l)
if [ $NETWORK_COUNT -eq 0 ]; then
    echo "   ✅ 网络已停止"
else
    echo "   ⚠️  网络仍在运行，强制停止..."
    pkill -9 -f "openagents network start"
fi

# 清理临时文件（可选）
echo ""
echo "🧹 清理临时文件..."
if [ -f "/tmp/network.log" ]; then
    rm /tmp/network.log
    echo "   ✅ 已删除 /tmp/network.log"
fi

if ls /tmp/agent_*.log 1> /dev/null 2>&1; then
    rm /tmp/agent_*.log
    echo "   ✅ 已删除 /tmp/agent_*.log"
fi

echo ""
echo "✅ 系统已完全停止！"
echo "========================================"
echo ""
echo "💡 重新启动系统："
echo "   ./start_all.sh"
echo ""
