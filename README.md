# Test Fossology Scan

## Overview

The **Test Fossology Scan** GitHub Action allows you to run license and copyright scans using the Fossology scanner within your GitHub Actions workflows. This action is highly customizable and supports various scanning modes and configurations to fit your repository's compliance needs.

## Features

- Perform license and copyright scans
- Supports diff scans, repo scans, and differential scans
- Customizable scanner options
- Flexible configuration through input parameters

## Inputs

- **scan-mode**: Specifies whether to perform diff scans, repo scans, or differential scans. (default: "")
- **scanners**: Space-separated list of scanners to invoke (default: "nomos ojo copyright keyword")
- **github_api_url**: Base URL of the GitHub API (default: `${{ github.api_url }}`)
- **github_repository**: Repository name (default: `${{ github.repository }}`)
- **github_token**: GitHub Token (default: `${{ github.token }}`)
- **github_pull_request**: GitHub PR number (default: `${{ github.event.number }}`)
- **github_repo_url**: GitHub Repo URL (default: `${{ github.repositoryUrl }}`)
- **github_repo_owner**: GitHub Repo Owner (default: `${{ github.repository_owner }}`)
- **keyword_conf_file_path**: Path to custom keyword.conf file (default: "")
- **allowlist_file_path**: Path to allowlist.json file (default: "")
- **from_tag**: Starting tag to scan from (default: "")
- **to_tag**: Ending tag to scan to (default: "")
- **base_ref**: Target branch (default: `${{ github.base_ref }}`)
- **head_ref**: Source branch (default: `${{ github.head_ref }}`)

## Usage

Below is an example of how to use the **Test Fossology Scan** GitHub Action in your workflow.

### Example Workflow

```yaml
name: License and Copyright Scan

on: [pull_request, push]

jobs:
  compliance_check:
    runs-on: ubuntu-latest
    name: Perform Fossology Scan
    steps:
    - name: Checkout Code
      uses: actions/checkout@v2

    - name: Setup QEMU
      uses: docker/setup-qemu-action@v3.1.0

    - name: Run Fossology Scan
      uses: ./.github/actions/test-fossology-scan
      with:
        scan-mode: 'repo'
        scanners: 'nomos ojo'
        keyword_conf_file_path: './config/keyword.conf'
        allowlist_file_path: './config/allowlist.json'
        from_tag: 'v1.0.0'
        to_tag: 'v1.1.0'
