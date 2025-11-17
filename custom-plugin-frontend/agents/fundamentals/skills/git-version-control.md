# Skill: Git & Version Control

**Level:** Foundation
**Duration:** 1 week
**Agent:** Fundamentals
**Prerequisites:** None

## Overview
Master Git, the industry-standard version control system. Essential for collaboration, code history, and professional development.

## Learning Objectives

- Initialize and manage repositories
- Create branches and manage workflow
- Commit effectively with meaningful messages
- Collaborate using pull requests
- Resolve merge conflicts
- Work with GitHub and remote repositories

## Key Topics

### Git Basics
- Initializing repositories
- Staging and committing
- Viewing history and changes
- .gitignore configuration
- Git workflow concepts

### Branching Strategy
- Creating branches
- Branch naming conventions
- Switching and merging
- Rebasing vs merging
- Feature branches and hotfixes

### Remote Repositories
- Adding remotes
- Pushing and pulling
- Tracking branches
- Forking and cloning
- Pull requests and code review

### Collaboration
- Commit message best practices
- Meaningful commits vs squashing
- Code review process
- Conflict resolution
- Contribution workflow

## Practical Exercises

### Exercise 1: Repository Initialization
```bash
git init
git add README.md
git commit -m "Initial commit"
git remote add origin https://github.com/user/repo.git
git branch -M main
git push -u origin main
```

### Exercise 2: Feature Branch Workflow
```bash
git checkout -b feature/user-authentication
# Make changes
git add .
git commit -m "Add user authentication feature"
git push origin feature/user-authentication
# Create pull request on GitHub
```

### Exercise 3: Conflict Resolution
```bash
# When conflicts occur
git diff  # View conflicts
# Edit conflicting files
git add conflicted-file.js
git commit -m "Resolve merge conflict"
```

### Exercise 4: Meaningful Commits
```bash
# Good commit practices
git commit -m "Add user email validation

- Implement email format validation
- Add unit tests for validation
- Update user model"
```

## Real-World Projects

### Project 1: Personal GitHub Profile
- Create repositories
- README documentation
- Meaningful commit history

### Project 2: Collaborative Project
- Feature branches
- Pull requests
- Code review process

## Assessment Criteria

- ✅ Proper repository structure
- ✅ Meaningful commit messages
- ✅ Clean branch history
- ✅ Conflict resolution skills
- ✅ Collaboration best practices

## Resources

- [Git Official Documentation](https://git-scm.com/doc)
- [GitHub Guides](https://guides.github.com/)
- [Git Flight Rules](https://github.com/k88hudson/git-flight-rules)
- [Conventional Commits](https://www.conventionalcommits.org/)

## Next Skills

- Advanced Git workflows
- CI/CD integration
- GitHub Actions

---
**Status:** Active | **Version:** 1.0.0
