#!/usr/bin/env fish

function do_func
  argparse -n do_func 'h/help' 'p/project=' -- $argv
  or return 1

  if set -lq _flag_help
    echo "gke-deployment-config.fish -p/--project <GOOGLE_CLOUD_PROJECT>"
    return
  end

  set -lq _flag_project
  or set -l _flag_project (gcloud config get-value project)
  
  sed "s/GOOGLE_CLOUD_PROJECT/$_flag_project/g" (pwd |awk -F '/gke-spring-hello-world' '{print $1}')/gke-spring-hello-world/spring/kubernetes/deployment.yml.template \
    > (pwd |awk -F '/gke-spring-hello-world' '{print $1}')/gke-spring-hello-world/spring/kubernetes/deployment.yml
end

do_func $argv
