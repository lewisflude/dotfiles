#!/bin/zsh

# Cache sudo credentials
sudo -v

# Default Configuration
config_file="$HOME/.startworkday.rc"
log_file="$HOME/Library/Logs/startworkday.log"
debug_mode=false  # Set to true to enable debug logs
project_directory=""

# Define ANSI escape codes for colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
RESET='\033[0m'

  # Define ASCII art
  ASCII_ART=$(cat << "EOF"
8""""8                            8   8  8
8      eeeee eeeee eeeee eeeee    8   8  8 eeeee eeeee  e   e  eeeee eeeee e    e
8eeeee   8   8   8 8   8   8      8e  8  8 8  88 8   8  8   8  8   8 8   8 8    8
    88   8e  8eee8 8eee8e  8e     88  8  8 8   8 8eee8e 8eee8e 8e  8 8eee8 8eeee8
e   88   88  88  8 88   8  88     88  8  8 8   8 88   8 88   8 88  8 88  8   88
8eee88   88  88  8 88   8  88     88ee8ee8 8eee8 88   8 88   8 88ee8 88  8   88

EOF
)

# Load configuration from file if available
if [[ -f "$config_file" ]]; then
  source "$config_file"
fi

# Install expect using brew if not already installed
if ! command -v expect &> /dev/null; then
  echo "Installing expect..."
  brew install expect
fi

if cd "$project_directory"; then
  echo "✅ Successfully changed directory to: $project_directory"
else
  echo "❌ Error: Failed to change directory to: $project_directory"
  exit 1
fi

cd "$project_directory" && echo "✅ Successfully changed directory to: $project_directory" || { echo "❌ Error: Failed to change directory to: $project_directory"; exit 1; }


# Wait for Docker to be fully ready
wait_for_docker() {
  timeout=60
  retries=0

  while [[ ! -S "/var/run/docker.sock" ]]; do
    if [[ $retries -ge $timeout ]]; then
      echo "❌ Error: Docker did not start within the timeout period."
      exit 1
    fi

    echo "⏳ Waiting for Docker to be fully ready..."
    sleep 1
    ((retries++))
  done
}

# Check dependencies
check_dependencies() {
  local dependencies=("docker" "make" "pnpm" "git")
  if [[ -n "$custom_dependencies" ]]; then
    dependencies+=("${custom_dependencies[@]}")
  fi

  for dependency in "${dependencies[@]}"; do
    command -v "$dependency" > /dev/null || { echo "❌ Error: $dependency is required but not found."; exit 1; }
  done
}

# Validate input
validate_input() {
  if [[ ! -w "$log_file" ]]; then
    echo "❌ Error: Log file '$log_file' is not writable."
    exit 1
  fi

  if [[ ! -d "$project_directory" ]]; then
    echo "❌ Error: Project directory '$project_directory' does not exist."
    exit 1
  fi
}

# Log command output with timeout
log_command() {
  local command=("$@")
  local log_prefix="[ $(date +"%Y-%m-%d %H:%M:%S") ] [ ${command[*]} ]"

  echo "$log_prefix Start" >> "$log_file"

  if [ "$debug_mode" = true ]; then
    eval "${command[@]}" | tee -a "$log_file" 2>&1
  else
    eval "${command[@]}" >> "$log_file" 2>&1
  fi

  local exit_code=$?
  echo "$log_prefix Exit Code: $exit_code" >> "$log_file"
  echo "$log_prefix End" >> "$log_file"

  if ((exit_code != 0)); then
    echo "⚠️ Warning: Command '${command[*]}' failed with exit code $exit_code."
  fi
}

# Execute commands with timeout
execute_commands_with_timeout() {
  local timeout_command="timeout $timeout_duration"

  for command in "$@"; do
    if [[ -z "$timeout_duration" ]]; then
      log_command "$command"
    else
      # Extract the command name from the full command string
      command_name=$(echo "$command" | awk '{print $1}')
      emoji=""

     case "$command_name" in
      "pnpm") emoji="📦" ;;
      "make") emoji="🔨" ;;
      "doppler") emoji="🌐" ;;
      "turbo") emoji="⚡️" ;;
      "git") emoji="🌱" ;;
      "npm") emoji="📚" ;;
      "docker") emoji="🐳" ;;
      "terraform") emoji="🏗️" ;;
      "ansible") emoji="🔧" ;;
      "kubectl") emoji="☸️" ;;
      "helm") emoji="⎈" ;;
      "aws") emoji="☁️" ;;
      "azure") emoji="🌤️" ;;
      "gcloud") emoji="☁️" ;;
      "ssh") emoji="🔒" ;;
      "scp") emoji="📤" ;;
      "rsync") emoji="🔄" ;;
      "curl") emoji="🌐" ;;
      "wget") emoji="🌐" ;;
      "ssh-keygen") emoji="🔑" ;;
      *) emoji="💻" ;;  # Default emoji for other commands
    esac

      # Log the command with the relevant emoji
      echo "${emoji} Running command: $command"

      expect_script="spawn -noecho $timeout_command $command; expect eof"
      log_command "expect -c '$expect_script' </dev/null"
    fi
  done
}

# Perform pre-flight checks
perform_preflight_checks() {
  # Example: Check network connectivity
  if ! ping -c 1 google.com &> /dev/null; then
    echo "❌ Error: No internet connectivity."
    exit 1
  fi
}

# Send a macOS notification
send_notification() {
  local title="$1"
  local message="$2"
  osascript -e "display notification \"$message\" with title \"$title\""
}

# Override debug_mode if the flag is provided as a command-line option
process_options() {
  while [[ $# -gt 0 ]]; do
    case $1 in
      -d|--debug)
        debug_mode=true
        ;;
      -l|--log)
        shift
        log_file=$1
        ;;
      -p|--project-dir)
        shift
        project_directory=$1
        ;;
      -t|--timeout)
        shift
        timeout_duration=$1
        ;;
      -h|--help)
        echo "Usage: startworkday [OPTIONS]"
        echo "Options:"
        echo "  -h, --help              Display this help message."
        echo "  -l, --log <file>        Specify a custom log file."
        echo "  -d, --debug             Enable debug mode."
        echo "  -p, --project-dir <dir> Specify the project directory."
        echo "  -b, --git-branch <branch> Specify the Git branch to work with."
        echo "  -t, --timeout <seconds> Specify the timeout period for waiting for the Docker daemon to start."
        exit 0
        ;;
      *)
        echo "❌ Error: Invalid option: $1"
        exit 1
        ;;
    esac
    shift
  done
}

# Process command-line options
process_options "$@"

# Define animated progress indicators
SPIN_CHARS="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
PULSE_CHARS="⠋⠙⠚⠞⠖⠦⠴⠲⠳⠓"

start_time=$(date +%s)

validate_input
check_dependencies
perform_preflight_checks

# Print ASCII art
echo -e "${GREEN}$ASCII_ART${RESET}"

# Add a notification after launching Docker
if $debug_mode; then
  echo -e "🔍 Debug: Docker has been ${GREEN}launched${RESET}."
else
  send_notification "Docker Launched" "Docker has been launched."
fi

if $debug_mode; then
  echo -e "🔍 Debug: Executing project command: ${YELLOW}${project_command[*]}${RESET}"
else
  echo -e "🚀 Starting project command..."
fi

wait_for_docker
echo -e "✅ Docker is fully ready!"

execute_commands_with_timeout "${custom_commands[@]}"
echo -e "✅ Custom commands executed."

code .
echo -e "✅ VS Code opened."

git rev-parse --abbrev-ref HEAD
echo -e "✅ Current Git branch displayed."

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo -e "✅ Execution time: ${execution_time} seconds"

send_notification "Workday started" "The startworkday script has completed successfully."

exit 0
