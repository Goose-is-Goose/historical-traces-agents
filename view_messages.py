#!/usr/bin/env python3
"""
终端查看 OpenAgents 消息历史
"""
import json
from datetime import datetime

# 读取消息历史
with open('mods/openagents.mods.workspace.messaging/message_history.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# 处理两种格式：{"messages": [...]} 或 {event_id: event_data, ...}
if 'messages' in data:
    messages = data['messages']
else:
    # 字典格式，需要转换
    messages = list(data.values())

# 按频道分组
channels = {}
for msg in messages:
    payload = msg.get('payload', {})
    channel = payload.get('channel')
    if channel:
        if channel not in channels:
            channels[channel] = []
        channels[channel].append({
            'source': msg.get('source_id', '未知'),
            'text': payload.get('content', {}).get('text', ''),
            'timestamp': msg.get('timestamp', 0)
        })

# 显示消息
print("=" * 100)
print("📋 史迹寻踪 - AI历史剧本创作系统 | 消息历史")
print("=" * 100)

# 按照工作流顺序显示频道
channel_order = ['general', 'user-input', 'historical-research', 'script-planning', 'interactive-performance', 'script-output']

for channel_name in channel_order:
    if channel_name in channels and len(channels[channel_name]) > 0:
        print(f"\n{'='*100}")
        print(f"📢 #{channel_name} 频道")
        print(f"{'='*100}\n")

        for msg in channels[channel_name]:
            print(f"👤 发送者: {msg['source']}")
            print(f"📝 内容:")
            print(msg['text'])
            print(f"\n{'-'*100}\n")

print("\n" + "=" * 100)
print("✅ 查看完毕")
print("=" * 100)
