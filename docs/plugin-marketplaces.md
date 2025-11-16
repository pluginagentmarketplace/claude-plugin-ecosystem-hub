# Plugin Marketplaces - Complete Guide

## Overview

Plugin marketplaces are centralized repositories where developers share and users discover Claude Code extensions. This guide covers everything you need to know about using and creating marketplaces.

## Types of Marketplaces

### 1. Web-Based Marketplaces

**Characteristics:**
- Browser-based discovery and installation
- User ratings and reviews
- Search and filter capabilities
- No technical knowledge required

**Examples:**
- [ClaudeCodePlugins.io](https://claudecodeplugins.io/) - 229+ plugins
- [ClaudePluginHub](https://www.claudepluginhub.com/) - Auto-discovery
- [Claude Marketplaces](https://claudemarketplaces.com/) - Premium tools

**Best For:** Non-technical users, quick discovery, one-click installs

### 2. GitHub-Based Marketplaces

**Characteristics:**
- Version control integration
- Open source collaboration
- Pull request workflow
- Full customization control

**Examples:**
- [claude-code-plugins-plus](https://github.com/jeremylongshore/claude-code-plugins-plus)
- [wshobson/agents](https://github.com/wshobson/agents)
- [ClaudeKit](https://github.com/zpaper-com/ClaudeKit)

**Best For:** Developers, teams, custom workflows

### 3. Enterprise Marketplaces

**Characteristics:**
- Curated and vetted plugins
- SLA and support
- Security compliance
- Private hosting options

**Examples:**
- AWS Marketplace Claude offerings
- Enterprise MCP solutions
- Custom internal marketplaces

**Best For:** Organizations, regulated industries, high-security needs

## How to Use Marketplaces

### Adding a Marketplace

```bash
# Add GitHub-based marketplace
/plugin marketplace add username/repository

# List added marketplaces
/plugin marketplace list

# Remove a marketplace
/plugin marketplace remove username/repository
```

### Browsing and Installing

```bash
# Browse all plugins from all marketplaces
/plugin

# Search for specific functionality
/plugin search "git"

# View plugin details
/plugin info plugin-name

# Install a plugin
/plugin install plugin-name

# Update all plugins
/plugin update

# Remove a plugin
/plugin remove plugin-name
```

## Creating Your Own Marketplace

### Repository Structure

```
your-marketplace/
├── README.md           # Marketplace description
├── plugins.json        # Plugin registry
├── plugins/
│   ├── plugin1/
│   │   ├── manifest.json
│   │   ├── index.js
│   │   └── README.md
│   └── plugin2/
│       ├── manifest.json
│       ├── index.js
│       └── README.md
└── scripts/
    └── validate.js     # Validation script
```

### Plugin Registry Format

```json
{
  "version": "1.0.0",
  "plugins": [
    {
      "name": "git-helper",
      "version": "2.1.0",
      "description": "Git workflow automation",
      "author": "YourName",
      "tags": ["git", "vcs", "automation"],
      "path": "./plugins/git-helper",
      "homepage": "https://github.com/yourname/git-helper",
      "requirements": {
        "claudeCode": ">=1.0.0",
        "node": ">=18.0.0"
      }
    }
  ]
}
```

### Publishing Your Marketplace

1. **Create GitHub Repository**
   ```bash
   git init your-marketplace
   cd your-marketplace
   ```

2. **Add Plugin Structure**
   ```bash
   mkdir -p plugins
   touch plugins.json README.md
   ```

3. **Validate Plugins**
   ```bash
   npm run validate
   ```

4. **Push to GitHub**
   ```bash
   git add .
   git commit -m "Initial marketplace setup"
   git push origin main
   ```

5. **Share with Community**
   - Add to this directory
   - Post in forums
   - Create documentation

## Best Practices

### For Users

1. **Security First**
   - Review code before installing
   - Check plugin permissions
   - Verify author reputation
   - Use official sources when possible

2. **Stay Updated**
   - Regular update checks
   - Read changelogs
   - Test in development first

3. **Provide Feedback**
   - Rate and review plugins
   - Report issues
   - Suggest improvements

### For Developers

1. **Quality Standards**
   - Comprehensive testing
   - Clear documentation
   - Semantic versioning
   - Regular updates

2. **User Experience**
   - Simple installation
   - Good error messages
   - Configuration examples
   - Video tutorials

3. **Community Engagement**
   - Respond to issues
   - Accept contributions
   - Share roadmap
   - Build community

## Marketplace Features Comparison

| Feature | Web-Based | GitHub | Enterprise |
|---------|-----------|--------|------------|
| **Ease of Use** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| **Plugin Count** | High | Medium | Curated |
| **Quality Control** | Variable | Community | High |
| **Cost** | Free | Free | Paid |
| **Support** | Community | Community | Professional |
| **Customization** | Limited | Full | Configurable |
| **Security** | Basic | Good | Enterprise |
| **Updates** | Manual/Auto | Git-based | Managed |

## Troubleshooting

### Common Issues

**"Marketplace not found"**
- Verify repository exists
- Check spelling and case
- Ensure public repository

**"Plugin installation failed"**
- Check compatibility
- Verify dependencies
- Review error logs

**"Updates not working"**
- Pull latest changes
- Clear cache
- Reinstall plugin

## Advanced Topics

### Marketplace Automation

```yaml
# GitHub Action for auto-validation
name: Validate Plugins
on:
  push:
    paths:
      - 'plugins/**'
      - 'plugins.json'

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm run validate
```

### Private Marketplaces

For internal company use:
1. Use private GitHub repos
2. Configure access tokens
3. Set up authentication
4. Document for team

### Marketplace Analytics

Track usage with:
- GitHub traffic insights
- Custom telemetry
- User surveys
- Community feedback

## Resources

- [Official Plugin Documentation](https://docs.claude.com/en/docs/claude-code/plugins)
- [Marketplace Template](https://github.com/halans/cc-marketplace-boilerplate)
- [Community Forum](https://github.com/umitkacar/claude-plugin-ecosystem-hub/discussions)

---

*Next: Learn about [MCP Servers](./mcp-servers.md) →*