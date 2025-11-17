#!/bin/bash
# Custom Plugin Frontend - Setup Script
# This script runs when the plugin is first loaded by Claude Code

set -e

PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-.}"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "🚀 Initializing Custom Plugin Frontend..."
echo "   Version: 1.0.0"
echo "   Time: $TIMESTAMP"
echo ""

# Check if required directories exist
echo "✓ Checking plugin structure..."
[ -d "$PLUGIN_ROOT/.claude-plugin" ] && echo "  ✓ Plugin manifest found"
[ -d "$PLUGIN_ROOT/agents" ] && echo "  ✓ Agents directory found (7 agents)"
[ -d "$PLUGIN_ROOT/skills" ] && echo "  ✓ Skills directory found (28 skills)"
[ -d "$PLUGIN_ROOT/commands" ] && echo "  ✓ Commands directory found (7 commands)"
[ -d "$PLUGIN_ROOT/docs" ] && echo "  ✓ Documentation found"

echo ""
echo "📚 Available Agents:"
echo "   1. Fundamentals - Web basics, HTML, CSS, JavaScript, Git"
echo "   2. Build Tools - NPM, Webpack, Vite, code splitting"
echo "   3. Frameworks - React, Vue, Angular, Svelte"
echo "   4. State Management - Redux, Context API, Zustand"
echo "   5. Testing - Jest, Vitest, Cypress, Playwright"
echo "   6. Performance - Web Vitals, optimization, DevTools"
echo "   7. Advanced Topics - PWAs, Security, SSR, TypeScript"

echo ""
echo "🎯 Quick Start:"
echo "   /fundamentals     - Start with web basics"
echo "   /frameworks       - Master a framework"
echo "   /advanced-topics  - Enterprise patterns"

echo ""
echo "✅ Plugin initialized successfully!"
echo ""
