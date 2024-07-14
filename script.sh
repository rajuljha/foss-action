# Prepare docker run command with arguments
docker_cmd="docker run --rm --name fossologyscanner -w /opt/repo -v ${PWD}:/opt/repo \
    -e GITHUB_TOKEN=${{ github.token }} \
    -e GITHUB_PULL_REQUEST=${{ github.event.number }} \
    -e GITHUB_REPOSITORY=${{ github.repository }} \
    -e GITHUB_API=${{ github.api_url }} \
    -e GITHUB_REPO_URL=${{ github.repositoryUrl }} \
    -e GITHUB_REPO_OWNER=${{ github.repository_owner }} \
    -e GITHUB_ACTIONS"
if [ "${{ inputs.keyword_conf_file_path }}" != "" ]; then
docker_cmd+=" -v ${{ github.workspace }}/${{ inputs.keyword_conf_file_path }}:/bin/${{ inputs.keyword_conf_file_path }}"
fi
if [ "${{ inputs.allowlist_file_path }}" != "" ]; then
docker_cmd+=" -v ${{ github.workspace }}/${{ inputs.allowlist_file_path }}:/bin/${{ inputs.allowlist_file_path }}"
fi
docker_cmd+=" rjknightmare/fo-ci-test:ln /bin/fossologyscanner"
docker_cmd+=" ${{ inputs.scanners }}"
docker_cmd+=" ${{ inputs.scan_mode }}"
# Add additional conditions
if [ "${{ inputs.scan_mode }}" == "differential" ]; then
docker_cmd+=" --tags ${{ inputs.from_tag }} ${{ inputs.to_tag }}"
fi
if [ "${{ inputs.keyword_conf_file_path }}" != "" ]; then
docker_cmd+=" --keyword-conf ${{ inputs.keyword_conf_file_path }}"
fi
if [ "${{ inputs.allowlist_file_path }}" != "" ]; then
docker_cmd+=" --allowlist-path ${{ inputs.allowlist_file_path }}"
fi
if [ "${{ inputs.report_format }}" != "" ]; then
docker_cmd+=" --report ${{ inputs.report_format }}"
fi
# Run the command
echo $docker_cmd
eval $docker_cmd