#!/system/bin/sh
MODDIR=${0%/*}

write_safe() {
    [ -e "$1" ] && echo "$2" > "$1" 2>/dev/null
}

until [ "$(getprop sys.boot_completed 2>/dev/null | tr -d '\r')" = "1" ]; do
    sleep 1
done

sleep 10

settings_cmd() {
    command settings "$@" 2>/dev/null
}

settings_cmd put global window_animation_scale 1.0
settings_cmd put global transition_animation_scale 1.0
settings_cmd put global animator_duration_scale 1.0

settings_cmd put global splash_screen_exit_on_move 1 2>/dev/null

write_safe /proc/sys/kernel/sched_rt_runtime_us "-1" 2>/dev/null
write_safe /proc/sys/kernel/sched_migration_cost_ns "5000000" 2>/dev/null
write_safe /proc/sys/kernel/sched_latency_ns "10000000" 2>/dev/null

write_safe /proc/sys/kernel/sched_rt_runtime_us "-1" 2>/dev/null

write_safe /sys/block/zram0/reset "1" 2>/dev/null

echo "7alm service tune applied" >> /dev/null
