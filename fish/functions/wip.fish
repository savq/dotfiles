function wip --description 'Track work in progress with a stack. peek with $WIP_CURRENT'
    switch $argv[1]
        case push add
            if test (count $argv) -lt 2
                echo "Usage: $(status current-command) push <description>" >&2
                return 1
            end
            # Join everything after 'push' so quotes are optional
            set -l current (string join ' ' $argv[2..-1])
            set -Ua WIP_STACK "$current"
            set -U WIP_CURRENT "$current"

        case pop rm
            if test (count $WIP_STACK) -eq 0
                return 1
            end
            set -l popped $WIP_STACK[-1]
            set -e WIP_STACK[-1]
            if test (count $WIP_STACK) -gt 0
                set -U WIP_CURRENT $WIP_STACK[-1]
            else
                set -Ue WIP_CURRENT
            end

        case list ls ''
            if test (count $WIP_STACK) -eq 0
                return
            end
            for i in (seq (count $WIP_STACK) -1 1)
                echo "$i: $WIP_STACK[$i]"
            end

        case clear
            set -Ue WIP_STACK
            set -Ue WIP_CURRENT

        case '*'
            echo "Usage: $(status current-command) {push <desc>|pop|list|clear}" >&2
            return 1
    end
end
