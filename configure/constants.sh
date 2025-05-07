source libsetup.sh || exit 1

# All 
for path in $(lazysetup_constants_root)/*; do
    constant_key=$(basename "$path")
    constant_value=$(decrypt "$path")
    if [[ -z $constant_value ]]; then
        echo "Error: $path is empty or not a valid file."
        continue
    fi
    rc_append_line "$(lazysetup_root)"/.bashrc "export $constant_key=\"$constant_value\""
done
