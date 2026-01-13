# 史迹寻踪 - AI历史剧本创作系统

## 1. 项目概述

**项目名称：** 史迹寻踪 (Historical Traces)  
**Network ID：** HistoricalScriptCreation

### 项目简介

史迹寻踪是一个基于OpenAgents框架的多智能体协作系统，通过5个专业AI Agent的协同工作，将用户输入的历史主题转化为完整的专业剧本。系统不仅生成剧本大纲，还提供5轮互动式历史场景体验，最终输出符合真实剧本格式的完整作品。

### 目标用户/使用场景

- **教育工作者**：用于历史教学，让学生通过互动体验历史场景
- **编剧创作者**：快速生成历史题材剧本大纲和完整剧本
- **历史爱好者**：深度体验和了解历史事件
- **文化创意产业**：用于影视、舞台剧等文化产品的创意开发

---

## 2. 技术架构

### 使用的OpenAgents版本与相关技术栈

- **OpenAgents版本：** 0.8.5
- **Python版本：** 3.10+
- **LLM模型：** DeepSeek Chat (deepseek-chat)
- **通信协议：** gRPC (内部通信)、HTTP (Studio界面)
- **数据存储：** SQLite (network.db)、JSON (消息历史)
- **Mod驱动：** openagents.mods.workspace.messaging

### Agent Network设计思路

本系统采用**线性工作流 + 双向互动**的架构设计，核心设计理念：
1. **严格的频道隔离**：每个Agent只订阅必要的频道
2. **中央协调模式**：AgentG作为唯一与用户交互的Agent
3. **静默收集机制**：AgentD全程静默收集互动数据
4. **状态驱动互动**：AgentC采用严格的状态机

### 系统流程图

```
用户(#general) → AgentG(协调员) → AgentA(历史学家) → AgentB(剧本策划)
                      ↓                                      ↓
                    转发所有结果                        剧本大纲
                    到#general                              ↓
                      ↑                              AgentC(互动演绎) ⇄ 用户(5轮)
                      |                                      ↓
                    完整剧本                           互动完成信号
                      ↑                                      ↓
                  AgentD(剧本创作) ←────── AgentG(触发创作信号)
```

---

## 3. 智能体设计

### AgentG - 协调员 (agent_g_coordinator)
- **职责**：中央协调者，唯一与用户直接交互
- **订阅频道**：general, user-input, historical-research, script-planning, interactive-performance, script-output
- **主要功能**：转发主题、转发所有结果、双向转发互动消息、触发剧本创作

### AgentA - 历史资料收集员 (agent_a_researcher)
- **职责**：收集和整理历史背景资料
- **订阅频道**：user-input, historical-research
- **输出内容**：时代背景、关键人物、核心事件、文化特色

### AgentB - 剧本策划师 (agent_b_planner)
- **职责**：将历史资料转化为戏剧大纲
- **订阅频道**：historical-research, script-planning
- **输出内容**：3幕剧本大纲 + 角色设定

### AgentC - 互动演绎师 (agent_c_performer)
- **职责**：提供5轮互动式历史场景体验
- **订阅频道**：script-planning, interactive-performance
- **关键特性**：严格等待用户回复，4层过滤检查防止自动推进

### AgentD - 完整剧本创作师 (agent_d_scriptwriter)
- **职责**：创作符合真实剧本格式的完整作品
- **订阅频道**：script-output
- **输出内容**：2000-3000字专业剧本（含场景、对白、动作、神态、心理）

---

## 4. 协作场景与创新点

### 协作场景描述
完整的历史主题到专业剧本的全流程创作，包含：资料收集 → 剧本策划 → 互动演绎(5轮) → 完整剧本输出

### 创新性体现
1. **任务分配创新**：渐进式内容生成、静默收集机制、中央协调模式
2. **决策机制创新**：严格的状态机、去重机制、智能等待
3. **异常处理创新**：消息来源检查、内容过滤、频道隔离

---

## 5. 实际应用价值

### 解决的问题
1. 历史教育痛点：通过互动演绎让学生身临其境
2. 编剧创作效率：自动生成完整剧本框架
3. 文化内容生产：快速生成多样化的历史剧本创意
4. 知识传播方式：互动式体验更符合现代人的学习习惯

### 可扩展性
- 近期：增加剧本类型、多语言支持、多媒体输出
- 长期：AgentE审核、AgentF优化、教育平台集成、影视产业应用

---

## 6. 开发、发布与使用说明

### 环境依赖
```bash
Python 3.10+
OpenAgents 0.8.5
```

### 安装与运行步骤

**1. 创建虚拟环境**
```bash
python3 -m venv openagents_env
source openagents_env/bin/activate
```

**2. 安装OpenAgents**
```bash
pip install openagents==0.8.5
```

**3. 配置API密钥**
编辑`agents/*.yaml`文件，替换API密钥：
```yaml
config:
  api_key: "your-deepseek-api-key"
```

**4. 启动网络**
```bash
cd my_network
openagents network start .
```

**5. 启动Agents**
```bash
openagents agent start agents/agent_g_coordinator.yaml
openagents agent start agents/agent_a_researcher.yaml
openagents agent start agents/agent_b_planner.yaml
openagents agent start agents/agent_c_performer.yaml
openagents agent start agents/agent_d_scriptwriter.yaml
```

**6. 访问界面**
打开浏览器访问：http://localhost:8700

**7. 开始使用**
在#general频道输入：`主题：苏轼夜游承天寺`

---

## 7. 团队与分工

**个人项目**  
开发者：Yasmine  
工作内容：系统架构设计、Agent开发、调试优化、项目文档编写

---

## 8. 遇到的挑战与解决方案

### 挑战1：AgentC自动连续生成多段场景
**解决方案**：实施4层严格过滤机制（内容检查、来源检查、标记检查、状态检查）

### 挑战2：AgentG没有真正转发用户回复
**解决方案**：明确要求AgentG必须调用send_channel_message工具

### 挑战3：Agent重复响应和重复转发
**解决方案**：为所有Agent添加去重检查逻辑

### 挑战4：系统token消耗过大
**解决方案**：简化Agent数量(8→5)、优化互动轮数(10→5)、严格的频道隔离

---

## 9. 未来展望

- **短期**：完善现有功能、增加配置选项、提升用户体验
- **中期**：扩展Agent数量、多模态支持、数据积累
- **长期**：教育平台化、影视产业应用、知识图谱、社区建设

---

## 10. 附录

### 项目结构
```
my_network/
├── agents/                          # Agent配置文件
│   ├── agent_a_researcher.yaml
│   ├── agent_b_planner.yaml
│   ├── agent_c_performer.yaml
│   ├── agent_d_scriptwriter.yaml
│   └── agent_g_coordinator.yaml
├── mods/                            # 模块数据
├── network.yaml                     # 网络配置文件
├── view_messages.py                 # 消息查看工具
└── README.md                        # 本文档
```

### 快速命令参考
```bash
# 启动网络
openagents network start .

# 查看消息历史
python3 view_messages.py

# 停止所有进程
ps aux | grep openagents | grep -v grep | awk '{print $2}' | xargs kill
```

---

**最后更新时间：** 2026年1月13日  
**OpenAgents版本：** 0.8.5  
**项目状态：** 已完成Hackathon提交版本
