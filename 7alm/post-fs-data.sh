#!/system/bin/sh
MODDIR=${0%/*}

write_safe() {
    [ -e "$1" ] && echo "$2" > "$1" 2>/dev/null
}

MAX_CPU_FREQ=$(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq 2>/dev/null)
MIN_CPU_FREQ=$(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq 2>/dev/null)

if [ -n "$MAX_CPU_FREQ" ] && [ -n "$MIN_CPU_FREQ" ]; then
    NEW_MIN=$((MAX_CPU_FREQ * 30 / 100))
    if [ "$NEW_MIN" -lt "$MIN_CPU_FREQ" ]; then
        NEW_MIN=$MIN_CPU_FREQ
    fi

    for cpu_path in /sys/devices/system/cpu/cpu[0-7]/cpufreq; do
        if [ -f "$cpu_path/scaling_available_governors" ]; then
            if grep -q "schedutil" "$cpu_path/scaling_available_governors" 2>/dev/null; then
                write_safe "$cpu_path/scaling_governor" "schedutil"
            elif grep -q "interactive" "$cpu_path/scaling_available_governors" 2>/dev/null; then
                write_safe "$cpu_path/scaling_governor" "interactive"
            elif grep -q "ondemand" "$cpu_path/scaling_available_governors" 2>/dev/null; then
                write_safe "$cpu_path/scaling_governor" "ondemand"
            fi
        fi
        write_safe "$cpu_path/scaling_min_freq" "$NEW_MIN"
        write_safe "$cpu_path/scaling_max_freq" "$MAX_CPU_FREQ"
    done

    for su_dir in /sys/devices/system/cpu/cpufreq/schedutil /sys/devices/system/cpu/cpufreq/policy*/schedutil; do
        for d in $su_dir; do
            [ -d "$d" ] || continue
            write_safe "$d/up_rate_limit_us" "400"
            write_safe "$d/down_rate_limit_us" "200"
            write_safe "$d/iowait_boost_enable" "1"
        done
    done

    for int_dir in /sys/devices/system/cpu/cpufreq/interactive; do
        if [ -d "$int_dir" ]; then
            write_safe "$int_dir/boost" "1"
            write_safe "$int_dir/timer_rate" "40000"
            write_safe "$int_dir/go_hispeed_load" "90"
            write_safe "$int_dir/above_hispeed_delay" "20000"
            write_safe "$int_dir/target_loads" "80"
            write_safe "$int_dir/min_sample_time" "40000"
        fi
    done
fi

for gpu_path in /sys/class/kgsl/kgsl-3d0 /sys/devices/platform/1400000.mali; do
    if [ -d "$gpu_path" ]; then
        if [ -f "$gpu_path/devfreq/governor" ]; then
            if grep -q "simple_ondemand" "$gpu_path/devfreq/governor" 2>/dev/null; then
                write_safe "$gpu_path/devfreq/governor" "simple_ondemand"
            fi
        fi
        MAX_GPU=""
        if [ -f "$gpu_path/devfreq/max_freq" ]; then
            MAX_GPU=$(cat "$gpu_path/devfreq/max_freq" 2>/dev/null)
        fi
        if [ -n "$MAX_GPU" ]; then
            NEW_GPU_MIN=$((MAX_GPU * 50 / 100))
            write_safe "$gpu_path/devfreq/min_freq" "$NEW_GPU_MIN"
        fi
    fi
done

for q_path in /sys/block/mmcblk0/queue /sys/block/sda/queue; do
    if [ -f "$q_path/scheduler" ]; then
        if grep -q "deadline" "$q_path/scheduler" 2>/dev/null; then
            write_safe "$q_path/scheduler" "deadline"
        elif grep -q "mq-deadline" "$q_path/scheduler" 2>/dev/null; then
            write_safe "$q_path/scheduler" "mq-deadline"
        elif grep -q "kyber" "$q_path/scheduler" 2>/dev/null; then
            write_safe "$q_path/scheduler" "kyber"
        elif grep -q "noop" "$q_path/scheduler" 2>/dev/null; then
            write_safe "$q_path/scheduler" "noop"
        fi
    fi
    write_safe "$q_path/read_ahead_kb" "256"
    write_safe "$q_path/nr_requests" "128"
    write_safe "$q_path/rq_affinity" "1"
done

write_safe /proc/sys/vm/swappiness "20"
write_safe /proc/sys/vm/vfs_cache_pressure "100"
write_safe /proc/sys/vm/dirty_ratio "20"
write_safe /proc/sys/vm/dirty_background_ratio "10"
write_safe /proc/sys/vm/dirty_expire_centisecs "500"
write_safe /proc/sys/vm/dirty_writeback_centisecs "100"
write_safe /proc/sys/vm/page-cluster "3"
write_safe /proc/sys/vm/oom_kill_allocating_task "1"
write_safe /proc/sys/vm/compact_unevictable_allowed "1" 2>/dev/null

write_safe /sys/kernel/mm/ksm/run "0" 2>/dev/null

write_safe /sys/module/cpu_boost/parameters/sched_boost_on_input "1" 2>/dev/null
write_safe /sys/module/cpu_boost/parameters/input_boost_enabled "1" 2>/dev/null
write_safe /sys/module/cpu_boost/parameters/boost_timeout_ms "80" 2>/dev/null
write_safe /sys/module/cpu_boost/parameters/wake_boost_timeout_ms "80" 2>/dev/null
write_safe /sys/module/cpu_boost/parameters/input_boost_freq "0:1400000" 2>/dev/null

write_safe /sys/devices/system/cpu/cpufreq/default_boost "1" 2>/dev/null

echo "7alm boot tune applied" >> /dev/null
