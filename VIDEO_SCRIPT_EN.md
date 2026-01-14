# Video Script - Historical Traces System Demo (English Version)

**Demo Theme:** The Last Supper
**Duration:** ~3 minutes
**Style:** Clear, professional, engaging

---

## 🎬 Video Script (English)

### Opening (15 seconds)

Hello everyone! Today I'm excited to show you **Historical Traces** - an innovative Multi-Agent system that transforms historical themes into professional scripts through AI collaboration.

In just a few minutes, you'll see how 5 specialized AI agents work together to create a complete, theater-ready script. Let's dive in with Leonardo da Vinci's famous scene: **The Last Supper**.

---

### Part 1: System Launch (20 seconds)

First, I've already started the system using our automated script. Opening the browser at localhost:8700, here's our workspace interface.

On the left, you can see 6 channels. The **general channel** is our main interface where we interact with the system. Behind the scenes, we have 5 specialized agents:

- **AgentG**: The Coordinator - our single point of contact
- **AgentA**: The Historian - collects historical research
- **AgentB**: The Script Planner - designs the story structure
- **AgentC**: The Interactive Performer - engages users in creative decisions
- **AgentD**: The Script Writer - produces the final professional script

---

### Part 2: Input & Historical Research (30 seconds)

Now, let me input our theme in the general channel: **"Theme: The Last Supper"**

Watch what happens... AgentG immediately responds: "Theme received, AgentA is collecting historical data..."

**AgentA, our historian**, springs into action. It's gathering:
- Leonardo da Vinci's context - painted 1495-1498 in Milan
- Biblical background - the night before Jesus' crucifixion
- Historical setting - Renaissance Italy
- The significance of this moment in Christian history
- Details about the 13 figures in the scene

And there we go! AgentA has published a comprehensive 1,200-word historical research package. You can see details about the Santa Maria delle Grazie monastery, the fresco technique, and the dramatic moment when Jesus announces "one of you will betray me."

---

### Part 3: Script Planning (25 seconds)

Now **AgentB, our script planner**, takes over.

Based on the historical research, it's designing a three-act structure:

- **Act 1: The Gathering** - Disciples arrive for Passover dinner, the sacred atmosphere
- **Act 2: The Revelation** - Jesus announces the betrayal, shock and confusion among disciples, Judas' internal conflict
- **Act 3: The Aftermath** - Establishment of the Eucharist, Jesus' farewell words, the group dispersing into the night

AgentB has also created character profiles for all 13 figures, mapped out the emotional arcs, and identified key dramatic moments. This outline is now ready for the interactive phase.

---

### Part 4: Interactive Performance (45 seconds)

Here's where it gets interesting - the **interactive phase** with AgentC!

AgentC splits the outline into 5 scenes and asks me - the user - to make creative decisions for each one.

**Scene 1 appears:**

*"The disciples gather in the upper room. Candlelight flickers on stone walls. Jesus sits at the center of the long table. The atmosphere is..."*

**Question:** How should we portray the initial mood?
- A) Celebratory and festive for Passover
- B) Unusually solemn and tense
- C) Warm and intimate among close friends
- D) Your own interpretation

I'll choose **B** - unusually solemn and tense, because Jesus already knows what's coming.

Watch what happens... AgentC receives my choice and immediately presents **Scene 2**:

*"As they eat, Jesus suddenly stops. His eyes sweep across each face. He speaks: 'One of you will betray me.' The room erupts in confusion..."*

**Question:** Which disciple's reaction should we focus on?
- A) Peter's shock and anger
- B) John's sorrow and questioning
- C) Judas' hidden guilt
- D) Your own choice

This time I'll choose **C** - let's focus on Judas' internal struggle.

This continues for 5 rounds total. Each choice shapes the final script. The system ensures strict "one question, one answer" flow - notice how AgentC **waits** for my response before continuing. This is achieved through our innovative **4-layer filtering mechanism** that prevents the agent from auto-advancing.

I'll quickly complete the remaining rounds...

---

### Part 5: Final Script Generation (25 seconds)

After the 5th interaction, **AgentD - our script writer** - finally speaks!

Throughout the entire process, AgentD has been silently collecting everything:
- The historical research from AgentA
- The three-act structure from AgentB
- All 5 of my creative decisions

Now it integrates all this information into a complete, professional script.

And here it is! A 2,600-word theater script including:
- Character list with detailed profiles
- Scene descriptions and stage directions
- Dialogue for all 13 characters
- Psychological descriptions and emotional cues
- Stage lighting and blocking notes

This is production-ready - you could hand this to a theater director today.

---

### Part 6: Technical Highlights (25 seconds)

So what makes this system special from a technical perspective?

**First: Strict Agent Specialization**
Each of the 5 agents has a clear role and only subscribes to necessary channels. This channel isolation reduces token consumption by over 50%.

**Second: State Machine Control**
AgentC implements a 4-layer filtering system:
- Layer 1: Content validation
- Layer 2: Source verification
- Layer 3: Marker detection
- Layer 4: State consistency check

This ensures AgentC never advances without user input - solving a common Multi-Agent challenge.

**Third: Silent Collection Pattern**
AgentD observes the entire process without interrupting, then delivers one high-quality final output. This is more efficient than constant back-and-forth.

**Fourth: Central Coordinator Architecture**
AgentG acts as a hub, managing all task distribution and result aggregation. Users only interact with one channel - simple and clean.

These innovations bring token usage from 500,000+ down to 200,000-300,000 per session.

---

### Closing (15 seconds)

So that's **Historical Traces** - a Multi-Agent system that makes history come alive through collaborative script creation.

**Use cases:**
- **Education**: Students experience history interactively
- **Creative Writing**: Rapid professional script generation
- **Cultural Industry**: Content for film, theater, and documentaries

The entire codebase is open-source on GitHub. Check out the link in the description!

Thanks for watching, and I hope you enjoyed seeing OpenAgents in action!

---

## 📝 Recording Tips

### Screen Layout
- **Left side:** Channel list (show all 6 channels)
- **Main area:** Message flow in #general channel
- **Optional:** Small terminal window showing agent processes

### Pacing
- Speak clearly at moderate speed
- Pause briefly after each agent completes
- Use cursor/highlighting to emphasize key messages

### Demonstrations to Show

**1. Agent Discovery (Quick)**
- Show terminal with 5 agent processes running
- `ps aux | grep "openagents agent"`

**2. Channel Communication**
- Click between channels to show isolation
- Show #historical-research has only AgentA's output
- Show #interactive-performance has AgentC's scenes

**3. 4-Layer Filtering in Action**
- Emphasize the **wait** between scenes
- Point out "AgentC is waiting for your reply" (if visible in logs)

**4. Final Script Quality**
- Scroll through the complete script
- Highlight professional formatting
- Show character list, act structure

### Time Management

If running over 3 minutes, you can:
- Speed up the middle 3 interactive rounds (show round 1, 2, then skip to 5)
- Reduce historical research explanation (just show the output)
- Use 1.2x speed for script scrolling

### Key Phrases to Emphasize

- "**5 specialized AI agents**"
- "**Centralized coordination** through AgentG"
- "**4-layer filtering mechanism**"
- "**Silent collection mode**"
- "**50% token reduction**"
- "**Production-ready output**"

---

## 🎯 Alternative Themes (If Last Supper doesn't work)

### Option 2: Washington Crossing the Delaware

**Input:** "Theme: Washington Crossing the Delaware"

**Why it works:**
- Famous historical moment (1776)
- High drama (surprise attack)
- Clear decision points for interaction
- International audience knows this event

**Expected Output:**
- Act 1: Planning the attack, soldiers' doubts
- Act 2: The dangerous river crossing
- Act 3: Victory at Trenton

### Option 3: Socrates' Trial

**Input:** "Theme: Socrates Trial"

**Why it works:**
- Philosophy + drama
- Dialogue-heavy (perfect for script format)
- Timeless themes (truth, justice, mortality)
- Great for showcasing character depth

**Expected Output:**
- Act 1: The accusations
- Act 2: Socrates' defense speech
- Act 3: The hemlock, final words

---

## 📊 Pre-Recording Checklist

- [ ] System is running (`./start_all.sh`)
- [ ] Browser at localhost:8700 is open
- [ ] Channels are visible on left side
- [ ] Previous messages cleared (or use fresh topic)
- [ ] Screen recording software ready (OBS/QuickTime)
- [ ] Microphone tested and sounds clear
- [ ] Desktop notifications disabled
- [ ] "Theme: The Last Supper" text ready to paste
- [ ] Prepared responses for 5 interactive rounds

---

## 🎬 Post-Recording

**Upload to YouTube:**
1. Title: "Historical Traces - Multi-Agent Script Creation System | OpenAgents Hackathon"
2. Description: Include GitHub link, OpenAgents mention
3. Tags: OpenAgents, Multi-Agent, AI, Script Writing, Education
4. Visibility: Public or Unlisted (both acceptable for hackathon)

**Get the link:**
- Copy the full YouTube URL
- Create `demo_video_link.txt` with the URL
- Add to PR submission

---

**Good luck with the recording!** 🎥✨

Remember: The judges want to see:
1. ✅ System actually working (not just slides)
2. ✅ Agent communication in action
3. ✅ Real-world value demonstrated
4. ✅ Technical innovation explained

You've got this! 🚀
