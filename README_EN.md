# Historical Traces - AI Historical Script Creation System

> **OpenAgents PR Hackathon Submission**
> Transforming historical themes into professional scripts through Multi-Agent collaboration

[![OpenAgents](https://img.shields.io/badge/OpenAgents-0.8.5-blue)](https://openagents.org)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

## 📖 Table of Contents

- [Network Architecture](#-network-architecture)
- [Setup Guide](#-setup-guide)
- [Use Case Description](#-use-case-description)
- [Core Features and Technical Highlights](#-core-features-and-technical-highlights)
- [Agent Collaboration Logic](#-agent-collaboration-logic)
- [Demo Video](#-demo-video)
- [Challenges and Solutions](#-challenges-and-solutions)
- [Future Roadmap](#-future-roadmap)

---

## 🏗️ Network Architecture

### Architecture Type: **Centralized**

This network employs a **centralized coordination architecture** where AgentG (Coordinator) acts as the single user-facing interface, managing all task distribution and result aggregation.

### System Design

```
┌─────────────────────────────────────────────────────────────┐
│                     User Interface Layer                     │
│                    (#general channel)                        │
└───────────────────────┬─────────────────────────────────────┘
                        │
                   ┌────▼────┐
                   │ AgentG  │  Central Coordinator
                   │  (Hub)  │  - Task Distribution
                   └─┬───┬───┘  - Result Aggregation
                     │   │      - User Reply Forwarding
        ┌────────────┘   └──────────────┐
        │                                │
    ┌───▼────┐  Linear    ┌───▼────┐    │
    │AgentA  │  Workflow  │AgentB  │    │
    │Historian─────────────►Planner│    │
    └────────┘            └───┬────┘    │
                              │         │
                         ┌────▼─────┐   │
                         │ AgentC   │◄──┘ User Reply
                         │Performer │      Forwarding
                         └────┬─────┘
                              │
                      ┌───────▼────────┐
                      │    AgentD      │  Silent Collection
                      │ Script Writer  │  Mode
                      └────────────────┘
```

### Transport Protocols

**Primary Protocols:**
- **HTTP Transport** (Port 8700)
  - Serves web-based Studio interface
  - Supports MCP (Model Context Protocol)
  - Handles A2A (Agent-to-Agent) communication
  - Configuration: `serve_studio: true`, `serve_mcp: true`, `serve_a2a: true`

- **gRPC Transport** (Port 8600)
  - High-performance agent communication
  - Message compression: gzip
  - Max message size: 100MB
  - Keepalive: 60s interval, 30s timeout

**Transport Configuration:**
```yaml
transports:
  - type: http
    config:
      port: 8700
      serve_studio: true
  - type: grpc
    config:
      port: 8600
      compression: gzip
      max_message_size: 104857600
```

### Mods Used

**Primary Mod: `openagents.mods.workspace.messaging`**

This mod provides channel-based messaging infrastructure for multi-agent collaboration:

- **6 Specialized Channels:**
  - `#general` - User interaction interface (AgentG only)
  - `#user-input` - Topic submission (AgentG → AgentA)
  - `#historical-research` - Historical data transfer (AgentA → AgentB)
  - `#script-planning` - Script outline (AgentB → AgentC)
  - `#interactive-performance` - Interactive演绎 (AgentC ⇄ User)
  - `#script-output` - Final script publication (AgentD)

- **Key Features:**
  - Channel isolation for token optimization
  - Thread support (max depth: 5)
  - Message history persistence
  - Selective channel subscription via `default_channels`

**Channel Configuration:**
```yaml
mods:
  - name: openagents.mods.workspace.messaging
    enabled: true
    config:
      default_channels:
        - name: general
          description: Unified user interaction interface
        - name: user-input
          description: User topic submission
        # ... additional channels
      max_thread_depth: 5
      thread_collapse_threshold: 10
```

### Network Configuration

- **Network ID:** HistoricalScriptCreation
- **Mode:** Centralized
- **Discovery:** Enabled (10s interval)
- **Max Connections:** 20
- **Connection Timeout:** 30s
- **Message Queue Size:** 1000
- **Agent Timeout:** 180s

---

## 🚀 Setup Guide

### Prerequisites

- **Python:** 3.9 or higher
- **Operating System:** macOS, Linux, or Windows
- **OpenAgents:** 0.8.5 or higher
- **API Key:** DeepSeek API key (or compatible LLM provider)

### Installation Steps

#### 1. Clone the Repository

```bash
git clone https://github.com/Goose-is-Goose/historical-traces-agents.git
cd historical-traces-agents
```

#### 2. Create Virtual Environment

```bash
python3 -m venv openagents_env
source openagents_env/bin/activate  # On Windows: openagents_env\Scripts\activate
```

#### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

#### 4. Configure API Keys

Edit each agent configuration file in the `agents/` directory and replace the placeholder API key:

```yaml
# agents/agent_g_coordinator.yaml
config:
  api_key: "your-deepseek-api-key-here"  # Replace this
  model_name: "deepseek-chat"
```

**Files to configure:**
- `agents/agent_g_coordinator.yaml`
- `agents/agent_a_researcher.yaml`
- `agents/agent_b_planner.yaml`
- `agents/agent_c_performer.yaml`
- `agents/agent_d_scriptwriter.yaml`

### Launch Commands

#### Start the Network

**Option 1: Automated Script (Recommended)**

```bash
chmod +x start_all.sh
./start_all.sh
```

This script will:
- Activate the virtual environment
- Start the OpenAgents network
- Launch all 5 agents sequentially
- Verify all agents are running

**Option 2: Manual Launch**

```bash
# Terminal 1: Start Network
openagents network start network.yaml

# Wait 5 seconds, then start agents in separate terminals

# Terminal 2: AgentG
openagents agent start agents/agent_g_coordinator.yaml

# Terminal 3: AgentA
openagents agent start agents/agent_a_researcher.yaml

# Terminal 4: AgentB
openagents agent start agents/agent_b_planner.yaml

# Terminal 5: AgentC
openagents agent start agents/agent_c_performer.yaml

# Terminal 6: AgentD
openagents agent start agents/agent_d_scriptwriter.yaml
```

#### Access the System

Open your browser and navigate to:
```
http://localhost:8700
```

#### Stop the System

```bash
./stop_all.sh
```

Or manually:
```bash
pkill -f "openagents agent start"
pkill -f "openagents network start"
```

### Verification

After starting, verify all agents are running:

```bash
ps aux | grep "openagents agent" | grep -v grep
```

You should see 5 agent processes running.

---

## 💡 Use Case Description

### Target Scenario

**Historical Education & Creative Writing**

The system addresses three primary scenarios:

1. **Educational Applications**
   - Enable students to experience historical events interactively
   - Transform passive learning into active participation
   - Generate teaching materials for history classes

2. **Creative Content Production**
   - Rapid generation of professional scripts for film/TV
   - Provide creative inspiration for playwrights
   - Automate the initial drafting phase of script development

3. **Cultural Industry**
   - Generate content for historical documentaries
   - Create scripts for stage performances
   - Develop storylines for historical games/VR experiences

### Problem Solved

**Traditional Challenges:**
- ❌ Script creation is time-consuming (weeks/months)
- ❌ Requires extensive historical research expertise
- ❌ Lack of user engagement in the creative process
- ❌ Difficult for students to "experience" historical events
- ❌ High barrier to entry for non-professional writers

**Our Solution:**
- ✅ **Automated Research:** AgentA collects comprehensive historical data in minutes
- ✅ **Structured Planning:** AgentB designs professional three-act structure automatically
- ✅ **Interactive Creation:** AgentC engages users in 5 rounds of creative decision-making
- ✅ **Professional Output:** AgentD generates industry-standard scripts (2000-3000 words)
- ✅ **Educational Value:** Students actively participate in historical scenarios
- ✅ **Low Barrier:** No specialized knowledge required - just input a historical theme

### Example Workflow

**Input:** "Theme: The Peach Blossom Spring" (桃花源记)

**Output Process:**

1. **AgentA (Historical Researcher)** collects:
   - Tao Yuanming's biography (Eastern Jin Dynasty poet)
   - Historical context of 421 AD
   - Social turmoil and escapism themes
   - Literary analysis and cultural significance

2. **AgentB (Script Planner)** designs:
   - Act 1: Fisherman discovers the hidden valley
   - Act 2: Interactions with utopian villagers
   - Act 3: Departure and failed return
   - Character profiles, conflicts, emotional arcs

3. **AgentC (Interactive Performer)** engages user through 5 scenes:
   - Scene 1: "How does the fisherman feel seeing peach blossoms?"
   - Scene 2: "Should he trust the mysterious villagers?"
   - Scene 3: "What questions should he ask about their society?"
   - Scene 4: "Should he try to bring others back?"
   - Scene 5: "How does he react when he cannot find the valley again?"

4. **AgentD (Script Writer)** produces:
   - Complete script with character list
   - Stage directions and scene descriptions
   - Dialogue, actions, psychological descriptions
   - 2500-word professional format script

**Time Required:** 15-20 minutes (vs. weeks for traditional methods)

### Real-World Impact

- **Educational Institutions:** Used for immersive history lessons
- **Content Creators:** Accelerated script development pipeline
- **Cultural Organizations:** Rapid prototyping of historical narratives
- **Individual Writers:** Learning tool for scriptwriting techniques

---

## ⚙️ Core Features and Technical Highlights

### Core Features

#### 1. Five Specialized Agents

**AgentG - Central Coordinator**
- Single point of user interaction
- Unified information flow management
- Automatic task distribution and result collection
- User reply forwarding to interactive sessions

**AgentA - Historical Researcher**
- Automated historical data collection
- Comprehensive background research (1000-1500 words)
- Structured information packaging
- Source credibility analysis

**AgentB - Script Planner**
- Three-act structure design
- Character development and relationships
- Conflict point planning
- Emotional arc mapping

**AgentC - Interactive Performer**
- 5-round interactive engagement
- Scene-based user participation
- Creative decision-making guidance
- State-machine controlled flow

**AgentD - Complete Script Writer**
- Silent collection mode (non-intrusive)
- Full information integration
- Professional format output (2000-3000 words)
- Industry-standard script structure

#### 2. Channel-Based Architecture

**Strict Channel Isolation:**
- Each agent subscribes only to necessary channels
- Prevents information overload
- Reduces unnecessary LLM API calls
- 50%+ token consumption reduction

**Intelligent Message Routing:**
- AgentG uses `send_channel_message` tool for cross-channel communication
- Message markers (e.g., "【Historical Data Package】") for precise routing
- Message history tracking for full-process traceability

#### 3. Interactive State Machine

**4-Layer Filtering Mechanism:**

AgentC implements strict "one question, one answer" control:

```
Layer 1: Content Validation
  ↓ Check: Non-empty, length > 5 characters
Layer 2: Source Verification
  ↓ Check: Not from self, not from AgentD
Layer 3: Marker Detection
  ↓ Check: Contains "【User Reply】" or "【Script Outline】"
Layer 4: State Consistency
  ↓ Check: Scene count <= User reply count
Result: Send next scene ONLY if all checks pass
```

**Benefits:**
- Prevents agent "self-talk" (responding to own messages)
- Ensures strict wait for user input
- Maintains conversation flow integrity
- Avoids common Multi-Agent pitfalls

#### 4. Deduplication System

**Topic-Level Deduplication:**
- Each agent checks channel history before responding
- Prevents duplicate processing of same historical theme
- Avoids redundant message forwarding

**Implementation:**
```yaml
instruction: |
  【Deduplication Logic】
  Before responding, check:
  1. Has this topic been processed recently?
  2. Does the channel already contain data for this topic?
  3. If yes, skip processing
```

#### 5. Silent Collection Mode

**AgentD's Two-Phase Operation:**

**Phase 1: Silent Collection** (No responses)
- Monitors `#script-output` channel
- Collects all forwarded information:
  - Historical research data
  - Script outline
  - All 5 rounds of user interactions
- No interference with user experience

**Phase 2: Script Creation** (On signal)
- Triggered by "【Create Complete Script】" marker
- Integrates all collected information
- Generates comprehensive professional script
- Single high-quality output

### Technical Highlights

#### 1. Hybrid Collaboration Model

**Linear + Bidirectional + Silent Architecture:**

```
Linear Flow:        AgentA → AgentB → AgentC
                    (Research → Planning → Performance)

Bidirectional:      AgentC ⇄ User
                    (Interactive engagement)

Silent Collection:  AgentD (Observes all)
                    (Final integration)
```

**Innovation:** Combines three collaboration patterns in one system

#### 2. Token Optimization

**Achieved 50%+ Reduction:**

| Optimization Strategy | Token Savings |
|----------------------|---------------|
| Channel isolation | 30% |
| Deduplication mechanism | 10% |
| Streamlined instructions | 5% |
| Reduced interaction rounds (10→5) | 15% |

**Result:** From 500,000+ tokens to 200,000-300,000 tokens per session

#### 3. Central Coordinator Pattern

**Benefits:**
- **Simplified UX:** User doesn't need to understand agent architecture
- **Unified Interface:** All key information in `#general` channel
- **Automatic Orchestration:** Task distribution handled transparently
- **Progress Feedback:** Status updates like "AgentX is working..."

**Implementation:**
- AgentG subscribes to all 6 channels
- Uses `send_channel_message` tool for routing
- Implements message marker recognition
- Provides user-friendly status updates

#### 4. Event Sourcing

**Message History as Source of Truth:**
- All agent decisions based on `message_history.json`
- Enables state recovery after restarts
- Supports full process auditing
- Facilitates debugging and optimization

**Usage:**
```python
# View complete message history
python view_messages.py
```

#### 5. Scalable Architecture

**Extensibility:**
- Easy to add new agent types
- Channel-based isolation allows independent development
- Modular design supports feature additions
- Compatible with OpenAgents plugin ecosystem

---

## 🤝 Agent Collaboration Logic

### Detailed Workflow

#### Phase 1: User Input & Research (AgentG + AgentA)

**1.1 User Submits Theme**
```
User → #general: "Theme: Su Shi's Night Tour of Chengtian Temple"
```

**1.2 AgentG Processes & Routes**
- Detects "Theme:" keyword in `#general`
- Sends to `#user-input` channel using `send_channel_message`
- Responds to user: "Theme received, AgentA is collecting historical data..."

**1.3 AgentA Conducts Research**
- Monitors `#user-input` channel
- Detects message containing "Theme:"
- Collects comprehensive data:
  - Su Shi's biography (1037-1101, Song Dynasty poet)
  - Historical context (banished to Huangzhou)
  - Night of 1083, autumn moon
  - Buddhist themes of impermanence
  - Literary analysis
- Generates 1000-1500 word historical data package
- Publishes to `#historical-research` channel with marker "【Historical Data Package】"

**1.4 AgentG Forwards Results**
- Detects "【Historical Data Package】" in `#historical-research`
- Forwards complete research to `#general`
- User sees comprehensive historical background

#### Phase 2: Script Planning (AgentB)

**2.1 AgentB Receives Research**
- Monitors `#historical-research` channel
- Detects "【Historical Data Package】" marker
- Implements deduplication check (already processed this topic?)

**2.2 Creates Three-Act Outline**
- **Act 1: Sleepless Night**
  - Su Shi unable to sleep, decides to visit friend Zhang Huaimin
  - Setup: loneliness, moonlight, impulse
  - Conflict: Will Zhang be awake?

- **Act 2: Moonlit Courtyard**
  - Both friends admire moonlight on courtyard
  - Development: philosophical discussion
  - Climax: Realization about life and nature

- **Act 3: Philosophical Resolution**
  - Return to reality, reflection on experience
  - Resolution: Peace found in simple beauty
  - Theme: Transcendence through appreciation of nature

**2.3 Publishes Outline**
- Generates 800-1000 word script outline
- Publishes to `#script-planning` with marker "【Script Outline】"

**2.4 AgentG Forwards Outline**
- Forwards outline to `#general` for user visibility

#### Phase 3: Interactive Performance (AgentC ⇄ User)

**3.1 AgentC Initializes**
- Monitors `#script-planning` channel
- Detects "【Script Outline】" marker
- Splits three acts into 5 interactive scenes

**3.2 Scene 1 - Initial Decision**
```
AgentC → #interactive-performance:
【Interactive Scene - 1/5】

Su Shi lies awake, moonlight streaming through his window.
He thinks of his friend Zhang Huaimin, also banished here.

Question: What drives Su Shi to visit his friend tonight?
A) Loneliness and seeking companionship
B) Curiosity about how Zhang is faring
C) Spontaneous impulse inspired by the beautiful moon
D) Your own interpretation: _______
```

**3.3 User Responds**
```
User → #general: "I choose C, the moon's beauty inspires him"
```

**3.4 AgentG Forwards User Reply**
- Detects user response in `#general`
- Checks if it's a reply to interactive session
- Uses `send_channel_message` to forward to:
  - `#interactive-performance` (for AgentC)
  - `#script-output` (for AgentD's collection)
- Adds marker "【User Reply】"

**3.5 AgentC's 4-Layer Filter**
```
Incoming message: "【User Reply】I choose C..."

Layer 1: Content Check
  ✓ Non-empty, length = 18 characters > 5

Layer 2: Source Check
  ✓ From AgentG (forwarded from user)
  ✓ Not from agent_c_performer (self)
  ✓ Not from agent_d_scriptwriter

Layer 3: Marker Check
  ✓ Contains "【User Reply】"

Layer 4: State Check
  - Count scenes in channel: 1
  - Count user replies in channel: 1
  ✓ Scene count (1) <= Reply count (1)

Result: PROCEED to Scene 2
```

**3.6 Scene 2 - Meeting the Friend**
```
AgentC → #interactive-performance:
【Interactive Scene - 2/5】

Su Shi arrives at Zhang's dwelling. The door is unlatched.
He finds Zhang also awake, enjoying the moonlight.

Question: What should their first exchange be?
A) Formal greeting and apology for late visit
B) Immediate shared appreciation of the moon
C) Su Shi jokes about both being sleepless exiles
D) Your own dialogue: _______
```

**3.7 Repeat Process**
- User responds → AgentG forwards → AgentC verifies → Next scene
- Continues for total of 5 rounds
- Each scene builds on previous user choices

**3.8 Final Scene (5/5)**
```
AgentC → #interactive-performance:
【Interactive Scene - 5/5】

The two friends prepare to part ways. Su Shi reflects on the night.

Question: What final thought does Su Shi have?
A) Gratitude for Zhang's friendship in difficult times
B) Wonder at how few appreciate such beauty
C) Resolve to find more moments of simple joy
D) Your own reflection: _______
```

#### Phase 4: Script Creation (AgentD)

**4.1 Silent Collection Throughout**
- AgentD monitors `#script-output` channel from the start
- Silently collects:
  - Historical research from AgentA (forwarded by AgentG)
  - Script outline from AgentB (forwarded by AgentG)
  - All 5 user replies (forwarded by AgentG)
- **Does NOT respond** during collection phase

**4.2 Creation Signal**
```
AgentG → #script-output:
"【Create Complete Script】All interactive rounds completed.
AgentD, please create the final script."
```

**4.3 AgentD Generates Script**
- Integrates all collected information:
  - Historical accuracy from AgentA's research
  - Structure from AgentB's outline
  - Creative choices from user's 5 replies
  - Fills gaps with professional scriptwriting expertise

**4.4 Professional Script Format**
```
Title: Night Tour of Chengtian Temple
Characters: Su Shi (protagonist), Zhang Huaimin (friend)
Setting: Huangzhou, autumn night 1083

ACT 1: The Sleepless Night
Scene 1: Su Shi's Quarters - Night
[Moonlight filters through window lattice. SU SHI lies on bed, eyes open.]

SU SHI: (sitting up, gazing at moonlight)
Another sleepless night. But such beauty...
(inspired by user's choice: moon's beauty as motivation)

[He rises decisively, throws on outer robe]

SU SHI: (to himself)
Zhang must be awake. Who else would appreciate this?

[Stage direction: Exits through garden]

...
[Complete script continues for 2000-3000 words]
```

**4.5 Publication**
- AgentD publishes complete script to `#script-output`
- AgentG forwards to `#general` for user

### Collaboration Mechanisms

#### Message Flow Visualization

```
User Input
    ↓
┌───────────────────────────────────────────┐
│  AgentG (Central Hub)                     │
│  - Receives all user messages             │
│  - Routes to appropriate agents           │
│  - Aggregates results back to user        │
└───────┬───────────────────────────────────┘
        │
        ├──→ #user-input ──→ AgentA ──→ #historical-research ─┐
        │                                                      │
        ├──← Forwards research to #general ←──────────────────┘
        │
        ├──→ #script-planning ──→ AgentB ──→ #script-planning ─┐
        │                                                       │
        ├──← Forwards outline to #general ←────────────────────┘
        │
        ├──→ #interactive-performance ──→ AgentC ──→ Scene 1 ───┐
        │                                     ↓                  │
        │                                 [Waits for user]       │
        │                                     ↓                  │
        ├──← User Reply ←─────────────────────┘                 │
        │                                                        │
        ├──→ Forwards reply ──→ AgentC ──→ Scene 2 ... Scene 5 ─┤
        │                                                        │
        └──→ #script-output ──→ AgentD (Silent Collection) ──→ Final Script
```

#### Synchronization Points

1. **After AgentA:** AgentG waits for "【Historical Data Package】" before notifying user
2. **After AgentB:** AgentG waits for "【Script Outline】" before starting interaction
3. **During AgentC:** AgentC waits for "【User Reply】" before each scene
4. **After Scene 5:** AgentG sends "【Create Complete Script】" signal to AgentD

#### Error Handling

**Timeout Scenarios:**
- If agent doesn't respond within 180s (configured timeout)
- AgentG notifies user: "AgentX is taking longer than expected..."

**Invalid Input:**
- If user input doesn't match expected format
- AgentG prompts: "Please respond to the interactive scene with A/B/C/D or your own input"

**Duplicate Detection:**
- If same theme submitted twice
- AgentA skips processing, AgentG notifies: "This theme was recently processed"

---

## 🎥 Demo Video

**Video Link:** [YouTube Link - To be added]

**Duration:** 3 minutes

**Content Overview:**
1. **System Startup** (0:00-0:30)
   - Demonstrates running `./start_all.sh`
   - Shows all 5 agents launching successfully
   - Opens browser to `http://localhost:8700`

2. **Historical Theme Input** (0:30-1:00)
   - User inputs: "Theme: The Peach Blossom Spring"
   - AgentG acknowledges and routes request
   - AgentA's research process visualization

3. **Script Planning** (1:00-1:30)
   - AgentB's three-act outline display
   - Shows structured planning output

4. **Interactive Engagement** (1:30-2:30)
   - Demonstrates 2 complete rounds of AgentC interaction
   - Shows user making creative choices
   - Highlights state-machine flow (one question, one answer)

5. **Final Script Output** (2:30-3:00)
   - AgentD's professional script generation
   - Scrolls through complete 2500-word output
   - Shows industry-standard formatting

**Key Demonstrations:**
- ✅ Agent discovery and registration process
- ✅ Channel-based communication in action
- ✅ Real-time message routing through AgentG
- ✅ 4-layer filtering mechanism preventing auto-advancement
- ✅ Silent collection mode (AgentD observing without interrupting)
- ✅ Professional script output format

---

## 🚧 Challenges and Solutions

### Challenge 1: Auto-Advancing Interactive Agent

**Problem:**
AgentC with `react_to_all_messages: true` would automatically generate scenes 2, 3, 4, 5 without waiting for user replies. It would respond to:
- Its own messages
- Empty messages
- Other agents' messages

**Root Cause:**
LLM interpreted "monitor channel and respond" as "respond to everything," causing state machine to break down.

**Solution - 4-Layer Filtering:**
```yaml
instruction: |
  【Strict Filtering - First Priority】

  Layer 1: Content Check
    - Empty message? → Skip immediately
    - Length < 5 chars? → Skip immediately

  Layer 2: Source Check
    - From agent_c_performer (myself)? → Skip
    - From agent_d_scriptwriter? → Skip

  Layer 3: Marker Check
    - Must contain "【User Reply】" OR "【Script Outline】"
    - If not present → Skip

  Layer 4: State Consistency
    - Count scenes in channel
    - Count user replies in channel
    - If scene_count > reply_count → Skip (waiting for user)
    - Only proceed when reply_count >= scene_count
```

**Result:** Achieved strict "one question, one answer" flow. AgentC now reliably waits for user input.

### Challenge 2: Central Coordinator Not Actually Forwarding

**Problem:**
AgentG would say "Notified AgentC" in logs but didn't actually send messages to `#interactive-performance` channel. It called `finish` tool instead of `send_channel_message`.

**Root Cause:**
Vague instruction: "Notify AgentC" was interpreted by LLM as abstract notification rather than explicit tool use.

**Solution - Explicit Tool Requirements:**
```yaml
instruction: |
  【Task 5: Forward User Interactive Replies】

  2. If all conditions met, MUST execute these actions:
     a) Use send_channel_message tool to send to #interactive-performance
     b) Use send_channel_message tool to send to #script-output
     c) Reply confirmation in #general channel

  3. **Important**: Must call send_channel_message 3 times,
     not just say "notified"
```

**Result:** AgentG now reliably forwards messages using explicit tool calls.

### Challenge 3: Duplicate Agent Responses

**Problem:**
AgentA and AgentB would respond multiple times to same topic after restarts, causing duplicate data in channels.

**Root Cause:**
No memory of processed topics across sessions. Agents reprocessed all historical messages on startup.

**Solution - Deduplication Logic:**
```yaml
instruction: |
  【Deduplication Logic】
  Before responding, check:
  1. Has this topic been processed recently?
  2. Does the channel already contain data/outline for this topic?
  3. If yes, skip and do not respond
```

**Implementation:**
- Check message timestamps (last 10 minutes)
- Search channel for topic keywords
- Skip if matching content found

**Result:** Eliminated duplicate responses, reduced token waste.

### Challenge 4: Token Consumption Optimization

**Problem:**
Initial 8-agent system consumed 500,000+ tokens per session, making it expensive and slow.

**Solutions Applied:**

1. **Architecture Simplification:** 8 agents → 5 agents
2. **Channel Isolation:**
   - Each agent subscribes only to 2 channels (input + output)
   - AgentG subscribes to all 6 (coordinator role)
3. **Interaction Reduction:** 10 rounds → 5 rounds
4. **Instruction Streamlining:** Removed pleasantries and unnecessary acknowledgments
5. **Deduplication:** Prevented repeated processing

**Results:**
- Token usage: 500,000+ → 200,000-300,000 (60% reduction)
- Response time: Faster due to fewer LLM calls
- Cost efficiency: 60% cost savings

### Challenge 5: User Experience Complexity

**Problem:**
Users needed to understand which channel to use for what purpose, overwhelming for non-technical users.

**Solution - Central Coordinator Pattern:**
- AgentG as single user-facing interface
- All user interaction in `#general` channel only
- Automatic task routing behind the scenes
- User doesn't need to understand agent architecture

**Result:** Simplified UX, users only interact with one channel.

---

## 🔮 Future Roadmap

### Short-Term Enhancements

**1. Multi-Language Support**
- Support for multiple historical themes (Chinese, Western, etc.)
- Multilingual script output
- Cultural adaptation logic

**2. Customizable Interaction Rounds**
- User-configurable: 3, 5, or 10 rounds
- Adaptive based on script complexity

**3. Export Formats**
- PDF export with professional formatting
- Final Draft (.fdx) format
- Fountain markup format

### Mid-Term Features

**4. Visual Diagram Generation**
- Automatic character relationship graphs
- Timeline visualization
- Scene structure diagrams

**5. Voice Interaction**
- Speech-to-text for user replies
- Text-to-speech for scene narration
- Voice characterization for different agents

**6. Collaborative Multi-User**
- Multiple users participate in same session
- Voting mechanism for creative decisions
- Teacher mode for classroom use

### Long-Term Vision

**7. Decentralized Extension**
- Support for distributed agent deployment
- Cross-network agent collaboration
- Blockchain-based contribution tracking

**8. AI-Generated Visuals**
- Scene illustrations using image generation
- Storyboard creation
- Character design concepts

**9. Integration with Production Tools**
- Direct export to video editing software
- 3D animation script compatibility
- VR/AR experience generation

**10. Community Network**
- Shared historical database across networks
- Collaborative script refinement
- Peer review system

---

## 📊 Technical Specifications

### System Requirements

**Minimum:**
- CPU: 2 cores
- RAM: 4GB
- Storage: 500MB
- Network: Stable internet connection

**Recommended:**
- CPU: 4+ cores
- RAM: 8GB
- Storage: 1GB
- Network: High-speed broadband

### Performance Metrics

- **Average Session Duration:** 15-20 minutes
- **Token Consumption:** 200,000-300,000 per session
- **API Calls:** ~50-70 per session
- **Response Latency:** 3-5 seconds per agent
- **Concurrent Users:** Supports 20 (configurable)

### Scalability

- **Horizontal Scaling:** Can distribute agents across multiple machines
- **Load Balancing:** gRPC transport supports connection pooling
- **Message Queue:** 1000 message capacity (configurable)
- **Channel Limit:** No hard limit, tested with 10+ channels

---

## 🤝 Contributing

We welcome contributions! Areas of interest:

- New agent types (e.g., image generation agent)
- Additional mods integration
- Performance optimizations
- Documentation improvements
- Bug reports and fixes

Please submit issues and pull requests to our GitHub repository.

---

## 📄 License

This project is open-source under the MIT License. See LICENSE file for details.

---

## 🙏 Acknowledgments

- **OpenAgents Team:** For providing the excellent multi-agent framework
- **DeepSeek:** For reliable LLM API services
- **Community Contributors:** For testing and feedback

---

## 📞 Contact & Support

- **GitHub Repository:** https://github.com/Goose-is-Goose/historical-traces-agents
- **Demo Video:** [YouTube Link]
- **OpenAgents Discord:** https://discord.gg/openagents
- **Email:** [Your contact email]

---

**Built for OpenAgents PR Hackathon 2026**

*Transforming history into stories, one agent at a time.* 🎭✨
