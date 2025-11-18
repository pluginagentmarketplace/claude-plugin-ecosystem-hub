# Getting Started with Claude Plugin Ecosystem

## 🚀 Quick Start Guide

Welcome to the Claude Plugin Ecosystem! This guide will help you get started with Claude Code extensions in under 5 minutes.

## Prerequisites

Before you begin, ensure you have:
- Claude Code or Claude Desktop installed
- Git (for GitHub-based marketplaces)
- Node.js 18+ (for MCP servers)
- Active internet connection

## Step 1: Choose Your Path

### 🎯 I Want to Use Plugins
Start with web-based marketplaces for the easiest experience:
1. Visit [ClaudeCodePlugins.io](https://claudecodeplugins.io/)
2. Browse available plugins
3. Click "Install" on any plugin
4. Follow the installation prompts

### 💻 I Want to Develop Plugins
Set up your development environment:
1. Create a `.claude` directory in your project
2. Add plugin configuration files
3. Test locally before publishing

### 🏢 I Want Enterprise Features
Consider premium solutions:
1. Evaluate [MCP Market](https://mcpmarket.com/)
2. Contact vendors for enterprise licensing
3. Review security requirements

## Step 2: Install Your First Extension

### Option A: Web Marketplace (Easiest)
```bash
# No command needed - use web interface
# Visit any marketplace and click Install
```

### Option B: GitHub Marketplace
```bash
# Add a GitHub-based marketplace
/plugin marketplace add jeremylongshore/claude-code-plugins-plus

# Browse available plugins
/plugin

# Install a specific plugin
/plugin install plugin-name
```

### Option C: MCP Server
```json
// Add to Claude Desktop config
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_your_token"
      }
    }
  }
}
```

## Step 3: Verify Installation

### For Plugins
```bash
# List installed plugins
/plugin list

# Test a plugin command
/your-plugin-command
```

### For MCP Servers
1. Restart Claude Desktop
2. Check Developer Console for connection status
3. Test MCP server functionality

## Common First Extensions

### Recommended for Beginners
1. **Git Helper** - Simplify git operations
2. **Code Reviewer** - Automated code review
3. **Test Generator** - Create tests automatically

### Popular MCP Servers
1. **GitHub MCP** - GitHub integration
2. **Google Drive MCP** - File access
3. **PostgreSQL MCP** - Database queries

## Troubleshooting First Installation

### Plugin Not Working?
- Check marketplace is added: `/plugin marketplace list`
- Verify plugin installed: `/plugin list`
- Restart Claude Code

### MCP Connection Failed?
- Use absolute paths in config
- Check API tokens are valid
- Review server logs

## Next Steps

✅ **Installed your first extension?** Great! Now explore:
- [Plugin Marketplaces Guide](./plugin-marketplaces.md)
- [MCP Servers Deep Dive](./mcp-servers.md)
- [Create Your Own Plugin](./first-plugin.md)

## Getting Help

- **Quick Help**: Type `/help` in Claude Code
- **Documentation**: Read our [detailed guides](./index.md)
- **Community**: Ask questions via GitHub Issues or Discussions on the repository

---

*Ready to explore more? Check out our [complete marketplace directory](../README.md#-plugin-marketplaces)!*