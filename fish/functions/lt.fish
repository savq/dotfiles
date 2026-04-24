# vibecoded
function lt --description "Check grammar and style using LanguageTool API"
    # validate arguments
    if test (count $argv) -lt 1
        echo "Usage: languagetool <file> [language]" >&2
        echo "  file      Path to the file to check" >&2
        echo "  language  BCP 47 language code (default: en-US)" >&2
        return 1
    end

    set input_file $argv[1]
    if not test -f "$input_file"
        echo "Error: file not found: $input_file" >&2
        return 1
    end

    set language (test (count $argv) -gt 1; and echo $argv[2]; or echo "en-US")

    # # Check dependencies
    # for cmd in curl jq pandoc
    #     if not command -q $cmd
    #         echo "Error: '$cmd' is not installed or not in PATH." >&2
    #         return 1
    #     end
    # end

    # Convert to plain text via pandoc
    set plain_text (pandoc --to plain --wrap=none "$input_file" 2>/dev/null)
    if test $status -ne 0
        echo "Error(pandoc): Failed to convert '$input_file'." >&2
        return 1
    else if test -z "$plain_text"
        echo "Error(pandoc): Produced empty output for '$input_file'." >&2
        return 1
    end

    # POST to LanguageTool API
    set lt_url "http://localhost:8081/v2/check"

    set response (curl --silent --show-error \
        --request POST \
        --data-urlencode "text=$plain_text" \
        --data-urlencode "language=$language" \
        "$lt_url" 2>&1)

    if test $status -ne 0
        echo "Error: curl request to LanguageTool failed:" >&2
        echo $response >&2
        return 1
    end

    # Verify we got valid JSON back
    if not echo $response | jq empty 2>/dev/null
        echo "Error: LanguageTool returned invalid JSON:" >&2
        echo $response >&2
        return 1
    end

    # Check for zero matches
    set match_count (echo $response | jq '.matches | length')

    if test "$match_count" -eq 0
        echo "✓ No issues found in '$input_file' ($language)."
        return 0
    end

    # Extract and display results via jq
    echo "Found $match_count issue(s) in '$input_file' ($language):"
    echo ""

    echo $response | jq -r '
        .matches[] |
        [
            "───────────────────────────────────────────",
            "Rule     : \(.rule.id) [\(.rule.category.name)]",
            "Message  : \(.message)",
            "Context  : \(.context.text)",
            "Offset   : character \(.offset), length \(.length)",
            if (.replacements | length) > 0 then
                "Suggest  : \( [.replacements[:5][].value] | join(" | ") )"
            else
                "Suggest  : (no suggestions)"
            end
        ] | join("\n")
    '

    echo "───────────────────────────────────────────"
end
