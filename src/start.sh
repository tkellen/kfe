. ${BASE_PATH}src/lib/error.sh
. ${BASE_PATH}src/lib/findNodes.sh
. ${BASE_PATH}src/lib/template.sh
. ${BASE_PATH}src/render.sh

# Generate a one-shot script for bootstrapping a Kubernetes cluster. This
# calls out extensively to KWM itself.
start() {
  if [[ "$(which $SCRIPT_NAME 2> /dev/null)" != "$BASE_PATH$SCRIPT_NAME" ]]; then
    printf "\n"
    error "$(template usage install)"
    exit 1
  fi
  # give user something useful to go on if no valid nodes are found.
  # at least one for each role is needed.
  if [[ -z "$(findNodes etcd)$(findNodes controlplane)$(findNodes worker)" ]]; then
    error "$(template error start-no-nodes)"
    exit 1
  fi
  render start
  exit 0
}
