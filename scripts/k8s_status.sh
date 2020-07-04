#!/usr/bin/env bash

# Tmux status bar script to fetch information on k8s environments

get_status() {

    if !(hash kubectl) 2>/dev/null
    then
        status="kubectl not found!"
    else
        context=$(kubectl config current-context)
        context=${context##arn*/}
        context_info=$(kubectl config get-contexts --no-headers)
        namespace=$(echo "$context_info" | grep "*" | awk '{print $5}')

        if [ -z "$namespace" ]
        then
            namespace="default"
        fi
        if [ -z "$context" ]
        then
            context="N/A"
        fi
        status="#[fg=blue]⎈  ${context} / #[fg=default]${namespace}"
    fi
    echo "$status"
}

get_status
