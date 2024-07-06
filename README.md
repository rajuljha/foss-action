<div align="center">
  <a href="https://fossology.github.io" target="_blank">
    <img src="logo.png" alt="Fossology Logo" style="max-width: 40%; height: auto; margin: 20px 0;" />
  </a>
</div>

[![Fossology-action](https://img.shields.io/badge/Fossology-action-red)](https://github.com/fossology/fossology/wiki/FOSSology-scanners-in-CI)
[![Slack Channel](https://img.shields.io/badge/slack-fossology-blue.svg?longCache=true&logo=slack)](https://join.slack.com/t/fossology/shared_invite/enQtNzI0OTEzMTk0MjYzLTYyZWQxNDc0N2JiZGU2YmI3YmI1NjE4NDVjOGYxMTVjNGY3Y2MzZmM1OGZmMWI5NTRjMzJlNjExZGU2N2I5NGY)
[![YouTube Channel](https://img.shields.io/badge/youtube-FOSSology-red.svg?&logo=youtube&link=https://www.youtube.com/channel/UCZGPJnQZVnEPQWxOuNamLpw)](https://www.youtube.com/channel/UCZGPJnQZVnEPQWxOuNamLpw)
# Test Fossology Scan

## Overview

The **Test Fossology Scan** GitHub Action allows you to run license and copyright scans using the Fossology scanner within your GitHub Actions workflows. This action is highly customizable and supports various scanning modes and configurations to fit your repository's compliance needs.

## Features

- Perform license and copyright scans
- Supports diff scans, repo scans, and differential scans
- Customizable scanner options
- Flexible configuration through input parameters

## Inputs

### User customizable inputs:
```yaml
scan-mode:
  description: "Specifies whether to perform diff scans, repo scans, or differential scans.
    Leave blank for diff scans."
  required: false
  default: ""
scanners:
  description: "Space-separated list of scanners to invoke."
  required: true
  default: "nomos ojo copyright keyword"
keyword_conf_file_path:
  description: "Path to custom keyword.conf file. (Use only with keyword scanner set to True)"
  required: false
  default: ""
allowlist_file_path:
  description: "Path to allowlist.json file."
  required: false
  default: ""
from_tag:
  description: "Starting tag to scan from. (Use only with differential mode)"
  required: false
  default: ""
to_tag:
  description: "Ending tag to scan to. (Use only with differential mode)"
  required: false
  default: ""
```

### Inputs used internally by the action:

```yaml
github_api_url:
  description: "Base URL of the GitHub API (default: \${{ github.api_url }})"
  required: false
  default: ${{ github.api_url }}
github_repository:
  description: "Repository name (default: \${{ github.repository }})"
  required: false
  default: ${{ github.repository }}
github_token:
  description: "GitHub Token (default: \${{ github.token }})"
  required: false
  default: ${{ github.token }}
github_pull_request:
  description: "GitHub PR number (default: \${{ github.event.number }})"
  required: false
  default: ${{ github.event.number }}
github_repo_url:
  description: "GitHub Repo URL (default: \${{ github.repositoryUrl }})"
  required: false
  default: ${{ github.repositoryUrl }}
github_repo_owner:
  description: "GitHub Repo Owner (default: \${{ github.repository_owner }})"
  required: false
  default: ${{ github.repository_owner }}
```

## Example Workflow
Below is an example of how to use the **Test Fossology Scan** GitHub Action in your workflows.

### Pull request scans
```yaml
name: License scan on PR

on: [pull_request]

jobs:
  compliance_check:
    runs-on: ubuntu-latest
    name: Perform license scan
    steps:
    - name: Checkout
      uses: actions/checkout@v2
    - name: License check
      id: compliance
      uses: GMishx/fossology-scan@v1
      with:
        scan-mode: 'diff'
        scanners: 'nomos ojo'
    - name: 'Upload report'
      uses: actions/upload-artifact@v2
      if: ${{ failure() }}
      with:
        name: Scan results
        path: results
```

### Tag scans 
```yaml
name: License scan on PR

on: [pull_request]

jobs:
  compliance_check:
    runs-on: ubuntu-latest
    name: Perform license scan
    steps:
    - name: Checkout
      uses: actions/checkout@v2
    - name: License check
      id: compliance
      uses: GMishx/fossology-scan@v1
      with:
        scan-mode: 'diff'
        scanners: 'nomos ojo'
    - name: 'Upload report'
      uses: actions/upload-artifact@v2
      if: ${{ failure() }}
      with:
        name: Scan results
        path: results
```