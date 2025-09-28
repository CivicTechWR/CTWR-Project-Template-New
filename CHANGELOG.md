# Changelog

All notable changes to this project template will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed
- Fixed Jekyll Pages deployment workflow failing due to conflicting gem dependencies
  - Removed standalone `jekyll` gem that conflicted with `github-pages` gem
  - Now uses GitHub Pages compatible Jekyll version (3.9.5)
  - Resolves Ruby dependency conflicts in CI/CD pipeline

### Changed
- Updated `docs/Gemfile` to use only `github-pages` gem for Jekyll functionality
- Added explanatory comments in Gemfile for future maintainers

## [Previous Releases]
- See git history for previous changes