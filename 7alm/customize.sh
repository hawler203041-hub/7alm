#!/system/bin/sh
SKIP=0
PATCH_SERVICE=0

MODDIR=${0%/*}

set_perm_recursive $MODPATH 0 0 0755 0644
set_perm $MODPATH/post-fs-data.sh 0 0 0755
set_perm $MODPATH/service.sh 0 0 0755
set_perm $MODPATH/customize.sh 0 0 0755

ui_print "*******************************"
ui_print "*   7alm - J7 (j7elte) Smoothness   *"
ui_print "*   For crDroid Android 12          *"
ui_print "*******************************"
ui_print " "
ui_print "Optimizations applied:"
ui_print "  - CPU governor tuning"
ui_print "  - Higher minimum CPU frequency"
ui_print "  - GPU frequency floor"
ui_print "  - IO scheduler (deadline/kyber)"
ui_print "  - Memory management tweaks"
ui_print "  - Touch responsiveness"
ui_print "  - Animation scale (0.5x)"
ui_print "  - Dalvik VM tuning"
ui_print "  - CPU boost / input responsiveness"
ui_print " "
ui_print "Installation complete."
ui_print "Reboot to apply."
