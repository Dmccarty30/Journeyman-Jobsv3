---
description: 
---

# Agentic Deep-Dive Codebase Search Workflow

This is a gentle yet powerful workflow for exploring any codebase in your anti-gravity IDE (VS Code-based or similar).  
It layers fast keyword hits → regex/ripgrep precision → semantic and structural analysis → agentic AI follow-ups.  
The goal: orient quickly, discover relationships, spot patterns, and get light refactor ideas without ever feeling overwhelmed.

Use this as a system prompt for your agent, or run the steps manually/sequentially.

## Core Principles
- Start **gentle**: fuzzy, broad, fast hits to build intuition.
- Go **deep**: structural, semantic, call-graph aware.
- Finish **agentic**: let AI group findings, summarize, and suggest safe next steps.
- Always exclude noise: `node_modules`, `dist`, `build`, `.git`, `venv`, etc.

## Step-by-Step Workflow

### 1. Parse the Query
Take the user's search concept (e.g., "anti-gravity logic", "authentication flow", "payment integration").  
If it's vague, ask for clarification:  
"What exactly are we hunting—function names, patterns, callers, or something else?"

### 2. Gentle Entry – Quick Keyword & Fuzzy Search
- Open the Search panel (`Ctrl+Shift+F` / `Cmd+Shift+F`).
- Use case-insensitive, fuzzy-friendly terms:  
  Examples: `anti.?gravity|antigrav|levitate|float|zero.?g`
- Toggle regex mode if needed.
- Include relevant extensions: `**/*.{ts,tsx,js,jsx,py,rb,go}`
- Exclude junk paths.
- Show results immediately—focus on top 10-20 hits.

**Why this first?** It gives instant context without drowning you in noise.

### 3. Speed & Precision – Ripgrep Layer
Run ripgrep for blazing-fast, filtered scans (VS Code uses it under the hood, but terminal gives more control):

```bash
rg "your-query-here" \
  --glob "**/*.{ts,js,py,etc}" \
  --glob "!node_modules/**" \
  --glob "!dist/**" \
  --context 5 \
  --stats