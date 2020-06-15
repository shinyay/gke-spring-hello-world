#!/usr/bin/env fish

function do_func
  argparse -n do_func 'h/help' 'a/account=' -- $argv
  or return 1

  if set -lq _flag_help
    echo "cloud-build-additional-gke-role.fish -s/--account <SERVICE_ACCOUNT>"
    return
  end

  set -lq _flag_account
  or set -l _flag_account (gcloud projects get-iam-policy (gcloud config get-value project)| grep cloudbuild.gserviceaccount.com | uniq | cut -d ':' -f 2)

# roles/container.admin - Provides access to full management of clusters and their Kubernetes API objects
# roles/container.clusterAdmin - Provides access to management of clusters
# roles/container.clusterViewer - Read-only access to Kubernetes Clusters
# roles/container.developer - Provides access to Kubernetes API objects inside clusters
# roles/container.hostServiceAgentUser - Allows the Kubernetes Engine service account in the host project to configure shared network resources for cluster management
# roles/container.viewer - Provides read-only access to GKE resources
  gcloud projects add-iam-policy-binding (gcloud config get-value project) --member serviceAccount:$_flag_account --role roles/container.admin
  gcloud projects add-iam-policy-binding (gcloud config get-value project) --member serviceAccount:$_flag_account --role roles/source.writer

end

do_func $argv
