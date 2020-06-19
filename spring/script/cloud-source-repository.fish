#!/usr/bin/env fish

function do_func
  argparse -n do_func 'h/help' 'r/repository=' -- $argv
  or return 1

  if set -lq _flag_help
    echo "cloud-source-repository.fish -r/--repository <CSR_REPO_NAME>"
    return
  end

  set -lq _flag_repository
  or set -l _flag_repository hello-gke

  gcloud source repos create $_flag_repository
  git config credential.'https://source.developers.google.com'.helper gcloud.sh
  git remote add google https://source.developers.google.com/p/(gcloud config get-value project)/r/$_flag_repository
  git push google master
end

do_func $argv
