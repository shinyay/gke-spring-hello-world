#!/usr/bin/env fish

function do_func
  argparse -n do_func 'h/help' 'r/repository=' -- $argv
  or return 1

  if set -lq _flag_help
    echo "cloud-build-trigger.fish -r/--repository <CSR_REPO_NAME>"
    return
  end

  set -lq _flag_repository
  or set -l _flag_repository hello-gke

  gcloud beta builds triggers create \
    cloud-source-repositories \
    --description="Hello GKE" \
    --repo=$_flag_repository \
    --branch-pattern=".*" \
    --build-config=spring/script/cloudbuild.yaml
end

do_func $argv
