# Migrate CI/CD to CircleCI

## Status

Accepted

## Context

The project previously used a different CI vendor (context not found in git or Glean — likely Travis CI or GitHub Actions, which was common for open-source Ruby gems at the time). PR #20 (commit `ef8de49`, 2022-02-13, "Migrate to circleci") migrated the pipeline to CircleCI.

## Decision

CircleCI was adopted as the CI/CD platform. The pipeline is defined in `.circleci/config.yml` and runs `bundle exec rake rspec_rubocop` across a matrix of Ruby versions. The Ruby version matrix has since been updated to cover 3.2, 3.3, and 3.4 (as of PR #32).

## Consequences

- CI configuration lives in `.circleci/config.yml` — not in `.github/workflows/`.
- The Ruby version matrix in `.circleci/config.yml` must be kept in sync when Ruby versions are added/dropped.
- CI alert notifications route to `#sdk-bots` Slack (configured in `catalog-info.yaml`).
- **Known gap:** PRs from forked repositories do not automatically trigger CI (tracked in DX-808). Maintainers must trigger runs manually for external contributor PRs.
