
minicom_dir="/etc"
log_dir="/tmp"

# this needs to be set for shell pattern below to work
shopt -s extglob

for file in $(command ls $minicom_dir/minirc.!(dfl) 2>/dev/null); do

  device=${file##*.}

  alias mini-$device="mini -p $device -d $log_dir"

done

unset minicom_dir log_dir file device
