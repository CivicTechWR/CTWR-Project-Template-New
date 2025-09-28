# Changelog

All notable changes to the CivicTechWR Project Template will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.3] - 2025-09-28

### Fixed
- Fixed Create Release workflow changelog extraction and branch protection issues
- Workflow now completes successfully with proper informational status updates
- Resolved all remaining YAML syntax and workflow execution problems

## [1.0.2] - 2025-09-28

### Fixed
- Fixed Create Release workflow to handle branch protection properly
- Workflow now completes successfully without trying to push to protected branch

## [1.0.1] - 2025-09-28

### Fixed
- Fixed all workflow failures and YAML syntax errors
- Resolved Create Release workflow issues with GitHub CLI
- Enhanced CI validation with comprehensive checks
- Completed linting fixes across all file types

### Added
- Semantic versioning support with package.json
- Release automation workflow for GitHub Releases
- Version tracking for template maintenance

## [1.0.0] - 2025-09-28

### Added
- Comprehensive CivicTechWR project template with DVF framework integration
- 12-week project lifecycle documentation and templates
- GitHub Pages integration with Jekyll documentation site
- Security best practices and repository configuration
- Project management templates (pitch, technical design, user research)
- Demo Day preparation guides and impact tracking
- Accessibility guidelines and community engagement templates
- GitHub automation workflows (validation, maintenance, security)

### Fixed
- Jekyll Pages deployment workflow dependency conflicts
  - Removed standalone `jekyll` gem conflicting with `github-pages` gem
  - Added proper repository configuration for GitHub Pages
  - Ensures reliable documentation site builds and deployments

### Security
- Comprehensive security documentation and guides
- Repository security configuration with automated monitoring
- Best practices for civic tech data protection and privacy

---

## Template Usage

**For Project Teams:**
- Use tagged releases (e.g., `v1.0.0`) for stable project starts
- Check release notes for new features and migration guides
- Follow DVF framework scoring for project assessment

**For Template Maintainers:**
- Follow semantic versioning for all changes
- Update CHANGELOG.md before each release
- Use GitHub Releases for distribution and communication
