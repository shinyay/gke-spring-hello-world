#!/usr/bin/env fish

function do_func
  argparse -n do_func 'h/help' 's/source=' -- $argv
  or return 1

  if set -lq _flag_help
    echo "cloud-build.fish -s/--source <DOCKERFILE_DIRECTORY>"
    return
  end

  set -lq _flag_source
  or set -l _flag_source (pwd |awk -F '/gke-spring-hello-world' '{print $1}')/gke-spring-hello-world/spring

  gcloud builds submit --tag gcr.io/(gcloud config get-value project)/hello-gke $_flag_source
end

do_func $argv
