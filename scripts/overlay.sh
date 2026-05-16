#!/bin/bash
# Fast path: chỉ copy overlay vào rootfs đang làm việc.

step_overlay() {
    ensure_work_tree

    if [ -d "$SCRIPT_DIR/config/includes.chroot" ]; then
        info "Copy overlay files..."
        shopt -s nullglob dotglob
        local overlay_files=("$SCRIPT_DIR/config/includes.chroot"/*)
        if [ ${#overlay_files[@]} -eq 0 ]; then
            warn "Overlay rỗng: config/includes.chroot"
        else
            cp -a "${overlay_files[@]}" "$WORK_DIR/squashfs/"
            ok "Copy overlay xong."
        fi
        shopt -u nullglob dotglob
    else
        warn "Không tìm thấy config/includes.chroot, bỏ qua overlay."
    fi
}
