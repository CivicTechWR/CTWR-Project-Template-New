# Project Management Guide for CivicTechWR

This guide explains how to use GitHub Projects for managing your CTWR civic tech project throughout the 12-week season.

## Overview

Each CTWR project uses a GitHub Project with DVF-integrated tracking to manage tasks, monitor progress, and ensure community accountability throughout the season.

## Getting Started

### Automatic Setup (Recommended)

Run the setup script to create a configured project:

```bash
# From your project repository
./scripts/setup-project.sh
```

#### Prerequisites

1. Install the [GitHub CLI (`gh`)](https://cli.github.com/) on your workstation.
2. Authenticate with your CivicTechWR credentials: `gh auth login`.
3. Grant the CLI the **project** scope (required for Projects v2 APIs):
   ```bash
   gh auth refresh -s project --hostname github.com
   gh auth status
   ```
   Confirm the output includes `scopes: ... project ...`.
4. Ensure you have permission to create Projects inside the `CivicTechWR` organization (contact the org admins if you see a permissions error).
5. (Optional) Export `CTWR_PROJECT_OWNER=YourOrg` if you want to create the project in a different GitHub organization.

> 🔁 **Dry-run/testing:** set `CTWR_SKIP_SCOPE_CHECK=1` before running the script to bypass scope validation in CI smoke tests.

#### Example: Cyber Shield Initiative

```text
Enter project name (e.g., 'Accessible Transit App'): Cyber Shield Initiative
Enter CTWR season (e.g., 'Season 6'): Season 7
Create this project? (y/n): y
```

The script provisions project number `123` (example), adds DVF fields, and links it to your repository so your new cybersecurity education program can track Week 1–12 milestones immediately.

This creates a GitHub Project with:

- ✅ DVF tracking fields (Community Partner, Talent & Team, Technically Exciting, Civic Exciting)
- ✅ Season workflow tracking (Week 1-12, Project phases)
- ✅ Integration with your repository
- ✅ Standard CTWR project structure

### Manual Setup

If you prefer manual setup or need to customize:

1. **Create Project**: Go to <https://github.com/orgs/CivicTechWR/projects>
2. **Click "New Project"** → Choose "Board" or "Table" view
3. **Add Custom Fields** (see Field Configuration section below)
4. **Link to Repository**: Project Settings → Link Repository

## Project Structure

### Core Views

**📋 Table View** - Comprehensive task and DVF tracking

- All tasks with DVF scores, assignees, and timeline
- Sortable by priority, week, or DVF score
- Best for detailed project management

**📋 Board View** - Kanban workflow by status

- Columns: Backlog → In Progress → Review → Done
- Drag and drop for status updates
- Best for daily/weekly standups

**📊 DVF Dashboard** - Assessment tracking

- Filter by DVF scores and project phase
- Track scoring improvements over time
- Best for mid-season reviews and reporting

### Custom Fields Configuration

The template includes these DVF-specific fields:

| Field Name | Type | Options | Purpose |
|------------|------|---------|---------|
| **DVF Community Partner** | Single Select | 1-5 scale | Partner engagement tracking |
| **DVF Talent Team** | Single Select | 1-5 scale | Team capacity and commitment |
| **DVF Technically Exciting** | Single Select | 1-5 scale | Innovation and learning value |
| **DVF Civic Exciting** | Single Select | 1-5 scale | Community impact potential |
| **DVF Total Score** | Number | 0-20 | Calculated total DVF score |
| **Season Week** | Single Select | Week 1-12 | Timeline tracking |
| **Project Phase** | Single Select | Pitch → Demo Day | Season workflow stage |

## Workflow Integration

### Week 1-3: Project Initialization

**Tasks to create:**

- [ ] Complete initial DVF assessment
- [ ] Set up project repository
- [ ] Create user research plan
- [ ] Define success metrics
- [ ] Identify community partners

**DVF Tracking:**

- Complete initial DVF scorecard
- Set baseline scores in project fields
- Document assumptions and goals

### Week 4-6: Development Sprint

**Tasks to create:**

- [ ] User interviews and research
- [ ] Technical architecture decisions
- [ ] MVP feature development
- [ ] Mid-season DVF review

**DVF Tracking:**

- Update DVF scores based on learnings
- Adjust project scope if needed
- Document partner feedback

### Week 7-9: Core Development

**Tasks to create:**

- [ ] Feature implementation
- [ ] User testing sessions
- [ ] Accessibility compliance
- [ ] Security review

**DVF Tracking:**

- Monitor technical progress
- Validate community impact
- Track team engagement

### Week 10-11: Demo Preparation

**Tasks to create:**

- [ ] Demo Day presentation prep
- [ ] Impact metrics collection
- [ ] User story documentation
- [ ] Final DVF assessment

**DVF Tracking:**

- Final DVF scoring
- Impact measurement
- Sustainability planning

### Week 12: Demo Day

**Tasks to create:**

- [ ] Final presentation delivery
- [ ] Project handoff documentation
- [ ] Community impact report
- [ ] Next steps planning

## Task Management Best Practices

### Creating Effective Issues

**Use the CTWR issue template** which includes:

- DVF impact assessment
- Community benefit description
- Acceptance criteria
- Accessibility considerations

**Example Good Issue:**

```markdown
## Summary
Implement keyboard navigation for service directory

## DVF Impact
- Civic Exciting: +1 (improves accessibility)
- Technically Exciting: +0 (standard feature)

## User Story
As a screen reader user, I want to navigate the service directory with keyboard only so that I can access city services independently.

## Acceptance Criteria
- [ ] All interactive elements are keyboard accessible
- [ ] Focus indicators are visible
- [ ] Screen reader announces navigation
- [ ] Tested with NVDA and VoiceOver
```

### Linking Issues to Projects

**Automatic linking** (if repository is linked):

- New issues automatically appear in project
- Status updates sync between issue and project

**Manual linking**:

1. Go to issue page
2. Click "Projects" in sidebar
3. Select your CTWR project
4. Set appropriate fields (DVF scores, week, phase)

### Status Management

**Standard Status Flow:**

1. **Backlog** - Identified but not started
2. **In Progress** - Actively being worked on
3. **Review** - Complete but needs validation
4. **Done** - Completed and validated

**Special Statuses:**

- **Blocked** - Waiting on external dependencies
- **On Hold** - Paused pending decisions
- **Won't Do** - Decided not to implement

## DVF Integration

### Scoring Guidelines

**Community Partner (1-5):**

- 1: No clear partner engagement
- 3: Regular partner check-ins scheduled
- 5: Active partner participation with decision-making authority

**Talent & Team (1-5):**

- 1: Solo project or unclear commitment
- 3: 2-3 people with regular availability
- 5: Diverse team with weekly commitment and complementary skills

**Technically Exciting (1-5):**

- 1: No significant technical component
- 3: Solid technology choices with some learning
- 5: Innovative technology with high learning value

**Civic Exciting (1-5):**

- 1: Limited public benefit
- 3: Clear community value with decent story
- 5: Compelling civic impact with measurable outcomes

### When to Update DVF Scores

**Week 3**: Initial assessment after pitch and breakout
**Week 6**: Mid-season review based on learnings
**Week 9**: Pre-demo assessment with user feedback
**Week 12**: Final assessment for project completion

### Using DVF Data

**For Project Decisions:**

- Scores ≤12: Focus on de-risking specific areas
- Scores 13-16: Continue with targeted coaching
- Scores 17-20: Leverage momentum for maximum impact

**For Community Reporting:**

- Track DVF improvement over time
- Identify successful patterns for future projects
- Demonstrate community value to sponsors

## Automation and Workflows

### GitHub Actions Integration

The template includes automated workflows:

**DVF Score Updates:**

- Automatically calculate total DVF scores
- Notify team when scores change significantly
- Generate weekly DVF reports

**Season Progression:**

- Auto-update week numbers based on season start
- Reminder notifications for key milestones
- Demo Day preparation checklist automation

### Project Templates

**Quick Start Templates:**

- Web application project
- Data analysis project
- Mobile app project
- Community engagement project

Each template includes:

- Pre-configured issue templates
- Standard task breakdowns
- DVF scoring guidelines
- Timeline templates

## Reporting and Analytics

### Weekly Standups

Use project views to facilitate team meetings:

**Agenda Template:**

1. **DVF Check** (5 min) - Review current scores
2. **Progress Review** (10 min) - What's done/in progress
3. **Blockers** (5 min) - What needs help
4. **Week Ahead** (5 min) - Priorities and commitments

### Mid-Season Review (Week 6)

**Review Process:**

1. Export project data to CSV
2. Compare current vs. initial DVF scores
3. Identify trends and patterns
4. Adjust project scope if needed
5. Update team commitments

### Demo Day Preparation

**Metrics to Track:**

- Total issues completed
- DVF score progression
- Community engagement metrics
- Team participation data
- User feedback collection

## Integration with CTWR Tools

### Community Project Board

Your project can be linked to the main CTWR community board:

- <https://github.com/orgs/CivicTechWR/projects/10>

**Benefits:**

- Visibility to CTWR leadership
- Cross-project collaboration opportunities
- Community resource sharing
- Sponsor showcase inclusion

### Documentation Links

Connect your project management to documentation:

- Link issues to specific docs sections
- Track documentation completeness
- Ensure accessibility guide compliance
- Monitor contribution guidelines adherence

## Troubleshooting

### Common Issues

**Project not linked to repository:**

```bash
gh project link [PROJECT_NUMBER] --owner CivicTechWR --repo [REPO_NAME]
```

**Missing DVF fields:**

```bash
# Re-run the setup script or add manually
./scripts/setup-project.sh
```

**DVF scores not calculating:**

- Check that all four DVF fields are filled
- Verify field names match exactly
- Refresh project view

### Getting Help

**CTWR Community Support:**

- Weekly meetings: Ask about project management
- Slack/Discord: #project-help channel
- Documentation: This guide and DVF scorecard

**GitHub Support:**

- GitHub Projects documentation
- GitHub CLI reference
- GitHub Actions for automation

## Advanced Features

### Custom Automations

**DVF Score Alerts:**

```yaml
# .github/workflows/dvf-alert.yml
# Notify team when DVF scores drop below threshold
```

**Progress Reports:**

```yaml
# .github/workflows/weekly-report.yml
# Generate weekly progress reports for community
```

### Multi-Project Coordination

For complex projects spanning multiple repositories:

- Use organization-level projects
- Link multiple repositories
- Coordinate with other CTWR projects
- Share resources and learnings

### Data Export and Analysis

**Export Options:**

- CSV for spreadsheet analysis
- JSON for custom reporting
- GitHub API for automated insights

**Analysis Ideas:**

- DVF score correlation with project success
- Team engagement patterns
- Community impact measurement
- Season-over-season improvements

---

**Remember**: Project management serves the community. Use these tools to ensure your civic tech project delivers real value to Waterloo Region while maintaining transparency and accountability to the CTWR community.

**Questions?** Reach out in community channels or reference the template repository examples.
