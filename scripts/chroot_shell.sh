#!/bin/bash
# Chroot shell an toàn để test/sửa build/squashfs thủ công.

step_chroot_shell() {
    ensure_work_tree
    info "Mount chroot..."
    mount_chroot

    info "Vào chroot. Gõ 'exit' để thoát."
    chroot "$WORK_DIR/squashfs" /bin/bash

    info "Unmount chroot..."
    umount_chroot
    ok "Đã thoát chroot."
}
