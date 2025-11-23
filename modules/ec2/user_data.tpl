 #!/bin/bash
    set -euo pipefail

    GIT_REPO="${github_repo}"
    GIT_BRANCH="${github_branch}"
    DEVICE="${ebs_device_name}"
    MOUNT_POINT="${jenkins_mount_point}"

