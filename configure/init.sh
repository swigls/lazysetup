source libsetup.sh || exit 1

mkdir -p "$(lazysetup_bin_dir)"
mkdir -p "$(lazysetup_config_home)"
mkdir -p "$(lazysetup_data_home)"
mkdir -p "$(lazysetup_state_home)"
mkdir -p "$(lazysetup_cache_home)"

rc_append_line ~/.bashrc 'export PATH="$HOME/.local/bin:$PATH"'
rc_append_line ~/.bashrc 'export COLORTERM=truecolor'
