# Getting Started with CivicTechWR Project Template

Welcome to the CivicTechWR Project Template! This guide will help you navigate the template and get your civic tech project up and running quickly.

## ⚡ TL;DR: Launch in 30 Minutes

1. Verify prerequisites with `./scripts/setup.sh --check` (Git, Node, gh scopes).
2. Run `./scripts/setup.sh` to install dependencies and drop starter files.
3. Kick off a GitHub Project with DVF fields via `./scripts/setup-project.sh`.
4. Apply baseline security settings using `./scripts/setup-security.sh`.
5. In **Settings → Pages**, select **GitHub Actions** so docs deploy automatically.
6. Customize `README.md`, the DVF scorecard, and the wiki starter pages.

> Ready for the full context? Keep reading for detailed guidance, tips, and 12-week planning support.

## 🎯 Template Overview

This template provides everything you need for a successful CivicTechWR project:

- **DVF Framework Integration** - Built-in assessment tools for project evaluation
- **12-Week Project Lifecycle** - Structured timeline from idea to Demo Day
- **Comprehensive Documentation** - 9+ guides covering all aspects of civic tech development
- **GitHub Integration** - Issue templates, project management, and automated workflows
- **Security & Accessibility** - Best practices for inclusive, secure civic technology

## 🚀 Quick Start (5 Minutes)

### 1. Use This Template

1. Click "Use this template" on GitHub
2. Name your repository (e.g., `waterloo-transit-tracker`)
3. Clone your new repository locally

### 2. Initial Setup

```bash
# Clone your repository
git clone [your-repo-url]
cd [project-name]

# Set up development environment
./scripts/setup.sh

# Set up GitHub Project with DVF tracking
./scripts/setup-project.sh

# Configure repository security
./scripts/setup-security.sh
```

> ℹ️ Before running `./scripts/setup-project.sh`, install the GitHub CLI and grant it the `project` scope (`gh auth refresh -s project --hostname github.com`). See [Project Management](docs/PROJECT_MANAGEMENT.md#prerequisites) for the full checklist.

### 3. Start Your Project Planning

1. Fill out the [Project Pitch](docs/PROJECT_PITCH.md) (Week 1)
2. Complete your [DVF Assessment](docs/DVF_SCORECARD.md) (Week 1-3)
3. Update the README.md with your project details

## 📊 Understanding the DVF Framework

The DVF (Desirability-Viability-Feasibility) Framework helps evaluate civic tech projects across four lenses:

- **Community Partner** (5 points) - Will partners participate and bring value to CTWR?
- **Talent & Team** (5 points) - Is the team sized, skilled, diverse, and committed?
- **Technically Exciting** (5 points) - Is there genuine maker energy here?
- **Civic Exciting** (5 points) - Is the public-interest story strong with visible impact?

**Your DVF Score determines project support level:**

- **17-20**: Full CTWR support with regular check-ins and Demo Day slot
- **13-16**: Worth exploring with targeted coaching
- **8-12**: Significant risks - proceed with willing team and de-risk plan
- **4-7**: Not supported at this time

> 📚 Want deeper context? Read our blog post on [Iterating on IDEO's DVF Framework for CivicTech](https://civictechwr.github.io/blog/Iterating-on-IDEO's-DVF-Framework-(for-CivicTech)/) to learn how CTWR adapted the model for volunteer civic projects.

## 📅 12-Week Project Timeline

### Weeks 1-3: Problem Validation & DVF Scoring

- [ ] Complete [Project Pitch](docs/PROJECT_PITCH.md)
- [ ] Conduct [User Research](docs/USER_RESEARCH.md)
- [ ] Score your project using [DVF Scorecard](docs/DVF_SCORECARD.md)
- [ ] Get community feedback at CTWR meetings

### Weeks 4-6: Research & Prototyping

- [ ] Validate problem with user interviews
- [ ] Create technical design document
- [ ] Build basic prototype or mockups
- [ ] Establish community partnerships

### Weeks 7-9: Core Development

- [ ] Implement core features
- [ ] Follow [Security Guide](docs/SECURITY_GUIDE.md) best practices
- [ ] Ensure [Accessibility compliance](docs/ACCESSIBILITY_GUIDE.md)
- [ ] Regular testing with users

### Weeks 10-11: Testing & Refinement

- [ ] User testing and feedback collection
- [ ] Performance and security testing
- [ ] Documentation completion
- [ ] Prepare for Demo Day

### Week 12: Demo Day

- [ ] Present using [Demo Prep Guide](docs/DEMO_PREP.md)
- [ ] Share impact using [Impact Tracking](docs/IMPACT_TRACKING.md)
- [ ] Celebrate with the community!

## 📚 Essential Documentation Guide

**Start with these documents in order:**

1. **[Project Pitch](docs/PROJECT_PITCH.md)** - 3-minute pitch format for your idea
2. **[DVF Scorecard](docs/DVF_SCORECARD.md)** - Complete assessment framework
3. **[User Research](docs/USER_RESEARCH.md)** - Interview guides and persona templates
4. **[Technical Design](docs/TECHNICAL_DESIGN.md)** - Architecture decisions and tech stack
5. **[Contributing Guidelines](docs/CONTRIBUTING.md)** - How others can get involved

**Refer to these as needed:**

- **[Security Guide](docs/SECURITY_GUIDE.md)** - Essential if handling user data
- **[Accessibility Guide](docs/ACCESSIBILITY_GUIDE.md)** - Required for public-facing tools
- **[Project Management](docs/PROJECT_MANAGEMENT.md)** - GitHub Projects setup and tracking
- **[Demo Prep](docs/DEMO_PREP.md)** - Prepare for Demo Day presentation
- **[Impact Tracking](docs/IMPACT_TRACKING.md)** - Measure and communicate project success

## 🛠️ Development Workflow

### GitHub Integration

This template includes:

- **6 Issue Templates** - Feature requests, bug reports, user research, partnerships, accessibility, general tasks
- **Pull Request Template** - Standardized PR format with security and accessibility checks
- **GitHub Project Setup** - Automated project creation with DVF tracking fields
- **CI/CD Workflows** - Template validation and maintenance automation

### Using GitHub Issues

Create issues using the provided templates:

```bash
# Or use GitHub CLI
gh issue create --template feature_request
gh issue create --template user_research
gh issue create --template community_partnership
```

### Wiki Setup

Use the wiki templates to document your project:

1. Copy files from `wiki-template/` to your GitHub Wiki
2. Customize with your project details
3. Keep DVF scorecard and team information updated

### GitHub Pages Setup

Create a public website for your project:

1. **Quick Setup**: Follow the [GitHub Pages Guide](docs/GITHUB_PAGES.md)
2. **Choose Your Approach**: Jekyll site, documentation, or live demo
3. **Sample Template**: Use the provided Jekyll site in `/docs` folder
4. **Automated Deployment**: Workflow already configured for easy updates

## 🔒 Security & Privacy Essentials

**If your project handles any user data, start here:**

1. **Read [Security Quick Start](docs/SECURITY_GUIDE.md#quick-start-security-in-5-minutes)**
2. **Set up environment variables** for secrets (never commit passwords!)
3. **Enable HTTPS** for any web applications
4. **Review data collection** - collect only what's necessary
5. **Plan for incidents** - how will you respond to security issues?

**For public-facing tools:**

- Review [Accessibility Guide](docs/ACCESSIBILITY_GUIDE.md) for WCAG 2.1 compliance
- Test with screen readers and keyboard navigation
- Ensure color contrast meets standards

## 🤝 Community Integration

### CTWR Meetings

- **Weekly Wednesday meetings** - Share progress and get feedback
- **Monthly Demo Nights** - Show your work to the community
- **Season Demo Day** - Final presentation of your project

### Getting Help

- **GitHub Discussions** - Ask questions about the template
- **CTWR Slack** - Connect with other project teams
- **Community Partners** - Leverage local government and nonprofit connections

### Contributing Back

- **Share learnings** - Document what worked and what didn't
- **Improve the template** - Submit PRs for better docs or examples
- **Mentor other teams** - Help newcomers navigate their first civic tech project

## ❓ Common Questions

### "This seems like a lot - where do I really start?"

1. **Week 1**: Fill out the Project Pitch template (30 minutes)
2. **Week 1-2**: Complete DVF assessment (1-2 hours)
3. **Week 2-3**: Get feedback at CTWR meeting
4. **Week 3+**: Start with Technical Design if DVF score is 13+

### "My project doesn't need all this documentation"

Start with the essentials:

- Project Pitch (required for CTWR)
- DVF Scorecard (required for CTWR)
- Technical Design (if building software)
- Security Guide (if handling user data)
- GitHub Pages setup (if you need a public website)

### "How do I know if my project is civic tech?"

Civic tech projects:

- **Serve the public interest** - Address community problems
- **Engage community members** - Include affected people in the process
- **Build public capacity** - Make civic processes more accessible
- **Create public value** - Benefits extend beyond individual users

### "What if I'm not technical?"

- **Start with user research** - Technical solutions come after understanding problems
- **Partner with developers** - Use the Contributing guide to recruit technical help
- **Focus on design and process** - Many civic tech projects need more design than code
- **Use low-code tools** - Sometimes the best solution is a well-designed form or workflow

## 🎯 Success Metrics

**Your project is succeeding when:**

- [ ] **Community engagement** - Partners are actively participating
- [ ] **User feedback** - People affected by the problem are involved in testing
- [ ] **Technical progress** - You're building something that works
- [ ] **Civic impact** - The solution addresses a real community need
- [ ] **Team learning** - Everyone is gaining new skills and insights
- [ ] **CTWR value** - Your project strengthens the civic tech community

## 📞 Getting Support

### Template Issues

- **GitHub Issues** - Report problems with the template itself
- **Discussions** - Ask questions about using the template

### Project Support

- **CTWR Meetings** - Weekly community support and feedback
- **Mentorship** - Connect with experienced civic tech practitioners
- **Partner Organizations** - Leverage CTWR's network of community partners

### Emergency Situations

- **Security incidents** - Follow the [Security Policy](SECURITY.md)
- **Accessibility barriers** - Get help making your project inclusive
- **Team conflicts** - CTWR leadership can provide mediation

---

**🚀 Ready to start? Begin with the [Project Pitch](docs/PROJECT_PITCH.md) and [DVF Scorecard](docs/DVF_SCORECARD.md)!**

**🤝 Questions? Join us at the next CTWR Wednesday meeting or start a GitHub Discussion.**

---

*This getting started guide is part of the CivicTechWR Project Template - built for civic technologists by civic technologists.*
