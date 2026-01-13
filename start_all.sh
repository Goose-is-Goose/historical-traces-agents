#!/bin/bash

echo "🚀 启动史迹寻踪 - AI历史剧本创作系统"
echo "========================================"

# 检查虚拟环境
if [ ! -d "../openagents_env" ]; then
    echo "❌ 错误：未找到虚拟环境 openagents_env"
    echo "请先运行: python3 -m venv openagents_env"
    exit 1
fi

# 激活虚拟环境
echo "📦 激活虚拟环境..."
source ../openagents_env/bin/activate

# 启动网络
echo "🌐 启动OpenAgents网络..."
openagents network start . > /tmp/network.log 2>&1 &
NETWORK_PID=$!
echo "   Network PID: $NETWORK_PID"

# 等待网络启动
echo "⏳ 等待网络启动（5秒）..."
sleep 5

# 启动所有Agents
echo "🤖 启动Agent G (协调员)..."
openagents agent start agents/agent_g_coordinator.yaml > /tmp/agent_g.log 2>&1 &

echo "🤖 启动Agent A (历史学家)..."
openagents agent start agents/agent_a_researcher.yaml > /tmp/agent_a.log 2>&1 &

echo "🤖 启动Agent B (剧本策划)..."
openagents agent start agents/agent_b_planner.yaml > /tmp/agent_b.log 2>&1 &

echo "🤖 启动Agent C (互动演绎)..."
openagents agent start agents/agent_c_performer.yaml > /tmp/agent_c.log 2>&1 &

echo "🤖 启动Agent D (剧本创作)..."
openagents agent start agents/agent_d_scriptwriter.yaml > /tmp/agent_d.log 2>&1 &

# 等待Agents启动
echo "⏳ 等待Agents启动（8秒）..."
sleep 8

# 检查状态
echo ""
echo "✅ 系统启动完成！"
echo "========================================"
echo "📊 运行状态："
AGENT_COUNT=$(ps aux | grep "agent.*yaml" | grep -v grep | wc -l)
echo "   运行中的Agents: $AGENT_COUNT/5"

if [ $AGENT_COUNT -eq 5 ]; then
    echo "   ✅ 所有Agents运行正常"
else
    echo "   ⚠️  部分Agents启动失败，请检查日志"
fi

echo ""
echo "🌐 访问地址："
echo "   http://localhost:8700"
echo ""
echo "📝 日志文件位置："
echo "   /tmp/network.log"
echo "   /tmp/agent_*.log"
echo ""
echo "🛑 停止系统："
echo "   ./stop_all.sh"
echo ""
echo "💡 使用方法："
echo "   1. 打开浏览器访问 http://localhost:8700"
echo "   2. 在#general频道输入：主题：苏轼夜游承天寺"
echo "   3. 等待AgentA收集历史资料"
echo "   4. 等待AgentB生成剧本大纲"
echo "   5. 参与AgentC的5轮互动演绎"
echo "   6. 获取AgentD创作的完整剧本"
echo "========================================"
