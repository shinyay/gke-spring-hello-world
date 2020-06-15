#!/usr/bin/env fish

function do_func
  argparse -n do_func 'h/help' 'c/cluster=' -- $argv
  or return 1

  if set -lq _flag_help
    echo "gke-cluster-create.fish -c/--cluster <DOCKERFILE_DIRECTORY>"
    return
  end

  set -lq _flag_cluster
  or set -l _flag_cluster hello-gke-cluster

  gcloud builds submit --tag gcr.io/(gcloud config get-value project)/hello-gke $_flag_cluster
  gcloud container clusters create $_flag_cluster \
    --num-nodes 1 \
    --scopes cloud-platform \
    --enable-stackdriver-kubernetes \
    --enable-ip-alias \
    --zone us-central1-c
  gcloud container clusters get-credentials $_flag_cluster \
    --zone us-central1-c
end

do_func $argv
