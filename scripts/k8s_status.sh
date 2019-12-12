#!/usr/bin/env bash

# Tmux status bar script to fetch information on k8s environments

get_status() {

    if !(hash kubectl) 2>/dev/null
    then
        status="kubectl not found!"
    else
        context=$(kubectl config current-context)
        context_info=$(kubectl config get-contexts --no-headers)
        namespace=$(echo "$context_info" | grep "*" | awk '{print $5}')

        if [ -z "$namespace" -o -z "$context" -o -z "$context_info" ]
        then
            context="N/A"
            namespace="default"
        fi
        status="⎈  ${context}:${namespace}"
    fi
    echo "$status"
}

get_status
