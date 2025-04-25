source libsetup.sh || exit 1

# All 
for path in $(lazysetup_constants_root)/*; do
    constant_key=$(basename "$path")
    constant_value=$(decrypt "$path")
    rc_append_line "$(lazysetup_root)"/.bashrc "export $constant_key=$constant_value"
done
