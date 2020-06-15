#!/usr/bin/env fish

function do_func
  argparse -n do_func 'h/help' 't/target=' -- $argv
  or return 1

  if set -lq _flag_help
    echo "gke-loadbalancer-access.fish -t/--target <TARGET_ENDPOINT_IP>"
    return
  end

  set -lq _flag_target
  or set -l _flag_target (kubectl get service hello-gke-loadbalancer -o json | jq .status.loadBalancer.ingress[0].ip -r )

  curl $_flag_target
end

do_func $argv
