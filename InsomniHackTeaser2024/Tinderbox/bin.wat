(module
  (type (;0;) (func (param i32) (result i32)))
  (type (;1;) (func))
  (type (;2;) (func (param i32 i32 i32) (result i32)))
  (type (;3;) (func (param i32 i64 i32) (result i64)))
  (type (;4;) (func (param i32 i32) (result i32)))
  (type (;5;) (func (param i32 i32 i32 i32) (result i32)))
  (type (;6;) (func (param i32 i64 i32 i32) (result i32)))
  (type (;7;) (func (param i32 i32 i32 i32 i32 i64 i64 i32 i32) (result i32)))
  (type (;8;) (func (param i32)))
  (type (;9;) (func (param i32 i32 i32 i32 i32) (result i32)))
  (type (;10;) (func (param i32 i32 i32)))
  (type (;11;) (func (param i32 i32 i32 i32 i32)))
  (type (;12;) (func (result i32)))
  (type (;13;) (func (param i32 i32 i32 i32 i64 i64 i32 i32) (result i32)))
  (type (;14;) (func (param i32 i32)))
  (type (;15;) (func (param f64 i32) (result f64)))
  (type (;16;) (func (param i32 i64)))
  (type (;17;) (func (param i32 i32 i32 i64) (result i64)))
  (type (;18;) (func (param f64 f64) (result f64)))
  (type (;19;) (func (param i32 i32 i32) (result f64)))
  (type (;20;) (func (param i32 i32 i32 i32 i32) (result f64)))
  (type (;21;) (func (param i32 i32) (result i64)))
  (type (;22;) (func (param i32 i64 i64 i64 i64)))
  (import "wasi_snapshot_preview1" "fd_close" (func $__imported_wasi_snapshot_preview1_fd_close (type 0)))
  (import "wasi_snapshot_preview1" "fd_fdstat_get" (func $__imported_wasi_snapshot_preview1_fd_fdstat_get (type 4)))
  (import "wasi_snapshot_preview1" "fd_fdstat_set_flags" (func $__imported_wasi_snapshot_preview1_fd_fdstat_set_flags (type 4)))
  (import "wasi_snapshot_preview1" "fd_prestat_get" (func $__imported_wasi_snapshot_preview1_fd_prestat_get (type 4)))
  (import "wasi_snapshot_preview1" "fd_prestat_dir_name" (func $__imported_wasi_snapshot_preview1_fd_prestat_dir_name (type 2)))
  (import "wasi_snapshot_preview1" "fd_read" (func $__imported_wasi_snapshot_preview1_fd_read (type 5)))
  (import "wasi_snapshot_preview1" "fd_seek" (func $__imported_wasi_snapshot_preview1_fd_seek (type 6)))
  (import "wasi_snapshot_preview1" "fd_write" (func $__imported_wasi_snapshot_preview1_fd_write (type 5)))
  (import "wasi_snapshot_preview1" "path_open" (func $__imported_wasi_snapshot_preview1_path_open (type 7)))
  (import "wasi_snapshot_preview1" "proc_exit" (func $__imported_wasi_snapshot_preview1_proc_exit (type 8)))
  (func $__wasm_call_ctors (type 1)
    call $__wasilibc_populate_preopens)
  (func $undefined_weak:__wasilibc_find_relpath_alloc (type 9) (param i32 i32 i32 i32 i32) (result i32)
    unreachable)
  (func $_start (type 1)
    (local i32)
    block  ;; label = @1
      block  ;; label = @2
        i32.const 0
        i32.load offset=4640
        br_if 0 (;@2;)
        i32.const 0
        i32.const 1
        i32.store offset=4640
        call $__wasm_call_ctors
        call $__original_main
        local.set 0
        call $__wasm_call_dtors
        local.get 0
        br_if 1 (;@1;)
        return
      end
      unreachable
      unreachable
    end
    local.get 0
    call $__wasi_proc_exit
    unreachable)
  (func $win (type 1)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 0
    i32.const 128
    local.set 1
    local.get 0
    local.get 1
    i32.sub
    local.set 2
    local.get 2
    global.set $__stack_pointer
    i32.const 1053
    local.set 3
    i32.const 1065
    local.set 4
    local.get 3
    local.get 4
    call $fopen
    local.set 5
    local.get 2
    local.get 5
    i32.store offset=124
    local.get 2
    i32.load offset=124
    local.set 6
    i32.const 0
    local.set 7
    local.get 6
    local.set 8
    local.get 7
    local.set 9
    local.get 8
    local.get 9
    i32.ne
    local.set 10
    i32.const 1
    local.set 11
    local.get 10
    local.get 11
    i32.and
    local.set 12
    block  ;; label = @1
      block  ;; label = @2
        local.get 12
        br_if 0 (;@2;)
        local.get 2
        i32.load offset=124
        local.set 13
        local.get 13
        call $fclose
        drop
        br 1 (;@1;)
      end
      i32.const 16
      local.set 14
      local.get 2
      local.get 14
      i32.add
      local.set 15
      local.get 15
      local.set 16
      local.get 2
      i32.load offset=124
      local.set 17
      i32.const 100
      local.set 18
      local.get 16
      local.get 18
      local.get 17
      call $fgets
      drop
      i32.const 16
      local.set 19
      local.get 2
      local.get 19
      i32.add
      local.set 20
      local.get 20
      local.set 21
      local.get 2
      local.get 21
      i32.store
      i32.const 1140
      local.set 22
      local.get 22
      local.get 2
      call $printf
      drop
      local.get 2
      i32.load offset=124
      local.set 23
      local.get 23
      call $fclose
      drop
    end
    i32.const 128
    local.set 24
    local.get 2
    local.get 24
    i32.add
    local.set 25
    local.get 25
    global.set $__stack_pointer
    return)
  (func $basic (type 1)
    (local i32 i32)
    i32.const 1324
    local.set 0
    i32.const 0
    local.set 1
    local.get 0
    local.get 1
    call $printf
    drop
    return)
  (func $diff (type 0) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 1
    i32.const 16
    local.set 2
    local.get 1
    local.get 2
    i32.sub
    local.set 3
    local.get 3
    local.get 0
    i32.store offset=12
    local.get 3
    i32.load offset=12
    local.set 4
    i32.const 37
    local.set 5
    local.get 5
    local.get 4
    i32.sub
    local.set 6
    local.get 6
    return)
  (func $setValues (type 10) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 3
    i32.const 16
    local.set 4
    local.get 3
    local.get 4
    i32.sub
    local.set 5
    local.get 5
    local.get 0
    i32.store offset=12
    local.get 5
    local.get 1
    i32.store offset=8
    local.get 5
    local.get 2
    i32.store8 offset=7
    local.get 5
    i32.load offset=8
    local.set 6
    i32.const 10
    local.set 7
    local.get 6
    local.set 8
    local.get 7
    local.set 9
    local.get 8
    local.get 9
    i32.lt_s
    local.set 10
    i32.const 1
    local.set 11
    local.get 10
    local.get 11
    i32.and
    local.set 12
    block  ;; label = @1
      local.get 12
      i32.eqz
      br_if 0 (;@1;)
      local.get 5
      i32.load8_u offset=7
      local.set 13
      local.get 5
      i32.load offset=12
      local.set 14
      local.get 5
      i32.load offset=8
      local.set 15
      local.get 14
      local.get 15
      i32.add
      local.set 16
      local.get 16
      local.get 13
      i32.store8
    end
    return)
  (func $get_name (type 8) (param i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 1
    i32.const 16
    local.set 2
    local.get 1
    local.get 2
    i32.sub
    local.set 3
    local.get 3
    global.set $__stack_pointer
    local.get 3
    local.get 0
    i32.store offset=12
    i32.const 1112
    local.set 4
    i32.const 0
    local.set 5
    local.get 4
    local.get 5
    call $printf
    drop
    i32.const 0
    local.set 6
    local.get 6
    i32.load offset=1560
    local.set 7
    local.get 7
    call $fflush
    drop
    local.get 3
    i32.load offset=12
    local.set 8
    local.get 3
    local.get 8
    i32.store
    i32.const 1062
    local.set 9
    local.get 9
    local.get 3
    call $scanf
    drop
    i32.const 16
    local.set 10
    local.get 3
    local.get 10
    i32.add
    local.set 11
    local.get 11
    global.set $__stack_pointer
    return)
  (func $print_menu (type 1)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    i32.const 1189
    local.set 0
    i32.const 0
    local.set 1
    local.get 0
    local.get 1
    call $printf
    drop
    i32.const 1505
    local.set 2
    i32.const 0
    local.set 3
    local.get 2
    local.get 3
    call $printf
    drop
    i32.const 1342
    local.set 4
    i32.const 0
    local.set 5
    local.get 4
    local.get 5
    call $printf
    drop
    i32.const 1536
    local.set 6
    i32.const 0
    local.set 7
    local.get 6
    local.get 7
    call $printf
    drop
    i32.const 0
    local.set 8
    local.get 8
    i32.load offset=1560
    local.set 9
    local.get 9
    call $fflush
    drop
    return)
  (func $fix_typo (type 10) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 3
    i32.const 32
    local.set 4
    local.get 3
    local.get 4
    i32.sub
    local.set 5
    local.get 5
    global.set $__stack_pointer
    local.get 5
    local.get 0
    i32.store offset=28
    local.get 5
    local.get 1
    i32.store offset=24
    local.get 5
    local.get 2
    i32.store offset=20
    i32.const 1221
    local.set 6
    i32.const 0
    local.set 7
    local.get 6
    local.get 7
    call $printf
    drop
    i32.const 0
    local.set 8
    local.get 8
    i32.load offset=1560
    local.set 9
    local.get 9
    call $fflush
    drop
    local.get 5
    i32.load offset=20
    local.set 10
    local.get 5
    local.get 10
    i32.store
    i32.const 1079
    local.set 11
    local.get 11
    local.get 5
    call $scanf
    local.set 12
    local.get 5
    local.get 12
    i32.store offset=16
    local.get 5
    i32.load offset=24
    local.set 13
    local.get 5
    i32.load offset=28
    local.set 14
    local.get 14
    i32.load
    local.set 15
    local.get 5
    i32.load offset=20
    local.set 16
    local.get 16
    i32.load
    local.set 17
    i32.const 24
    local.set 18
    local.get 17
    local.get 18
    i32.shl
    local.set 19
    local.get 19
    local.get 18
    i32.shr_s
    local.set 20
    local.get 13
    local.get 15
    local.get 20
    call $setValues
    i32.const 32
    local.set 21
    local.get 5
    local.get 21
    i32.add
    local.set 22
    local.get 22
    global.set $__stack_pointer
    return)
  (func $menu (type 11) (param i32 i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 5
    i32.const 80
    local.set 6
    local.get 5
    local.get 6
    i32.sub
    local.set 7
    local.get 7
    global.set $__stack_pointer
    local.get 7
    local.get 0
    i32.store offset=76
    local.get 7
    local.get 1
    i32.store offset=72
    local.get 7
    local.get 2
    i32.store offset=68
    local.get 7
    local.get 3
    i32.store offset=64
    local.get 7
    local.get 4
    i32.store offset=60
    local.get 7
    i32.load offset=68
    local.set 8
    block  ;; label = @1
      local.get 8
      i32.eqz
      br_if 0 (;@1;)
      call $print_menu
      i32.const 56
      local.set 9
      local.get 7
      local.get 9
      i32.add
      local.set 10
      local.get 7
      local.get 10
      i32.store offset=32
      i32.const 1075
      local.set 11
      i32.const 32
      local.set 12
      local.get 7
      local.get 12
      i32.add
      local.set 13
      local.get 11
      local.get 13
      call $scanf
      local.set 14
      local.get 7
      local.get 14
      i32.store offset=52
      local.get 7
      i32.load offset=56
      local.set 15
      i32.const -1
      local.set 16
      local.get 15
      local.get 16
      i32.add
      local.set 17
      i32.const 2
      local.set 18
      local.get 17
      local.get 18
      i32.gt_u
      drop
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 17
                br_table 0 (;@6;) 1 (;@5;) 2 (;@4;) 3 (;@3;)
              end
              local.get 7
              i32.load offset=68
              local.set 19
              i32.const 1
              local.set 20
              local.get 19
              local.set 21
              local.get 20
              local.set 22
              local.get 21
              local.get 22
              i32.gt_s
              local.set 23
              i32.const 1
              local.set 24
              local.get 23
              local.get 24
              i32.and
              local.set 25
              block  ;; label = @6
                local.get 25
                i32.eqz
                br_if 0 (;@6;)
                local.get 7
                i32.load offset=64
                local.set 26
                local.get 7
                i32.load offset=72
                local.set 27
                local.get 7
                i32.load offset=60
                local.set 28
                local.get 26
                local.get 27
                local.get 28
                call $fix_typo
                local.get 7
                i32.load offset=76
                local.set 29
                local.get 7
                i32.load offset=72
                local.set 30
                local.get 7
                i32.load offset=68
                local.set 31
                i32.const 1
                local.set 32
                local.get 31
                local.get 32
                i32.sub
                local.set 33
                local.get 7
                i32.load offset=64
                local.set 34
                local.get 7
                i32.load offset=60
                local.set 35
                local.get 29
                local.get 30
                local.get 33
                local.get 34
                local.get 35
                call $menu
              end
              br 3 (;@2;)
            end
            i32.const 1094
            local.set 36
            i32.const 0
            local.set 37
            local.get 36
            local.get 37
            call $printf
            drop
            i32.const 0
            local.set 38
            local.get 38
            i32.load offset=1560
            local.set 39
            local.get 39
            call $fflush
            drop
            i32.const 48
            local.set 40
            local.get 7
            local.get 40
            i32.add
            local.set 41
            local.get 7
            local.get 41
            i32.store
            i32.const 1075
            local.set 42
            local.get 42
            local.get 7
            call $scanf
            drop
            local.get 7
            i32.load offset=76
            local.set 43
            local.get 43
            i32.load offset=12
            local.set 44
            local.get 7
            i32.load offset=48
            local.set 45
            local.get 45
            local.get 44
            call_indirect (type 0)
            local.set 46
            local.get 7
            local.get 46
            i32.store offset=44
            local.get 7
            i32.load offset=44
            local.set 47
            local.get 7
            local.get 47
            i32.store offset=16
            i32.const 1165
            local.set 48
            i32.const 16
            local.set 49
            local.get 7
            local.get 49
            i32.add
            local.set 50
            local.get 48
            local.get 50
            call $printf
            drop
            br 2 (;@2;)
          end
          local.get 7
          i32.load offset=76
          local.set 51
          local.get 51
          i32.load offset=4
          local.set 52
          local.get 52
          call_indirect (type 1)
        end
        i32.const 1499
        local.set 53
        i32.const 0
        local.set 54
        local.get 53
        local.get 54
        call $printf
        drop
        i32.const 0
        local.set 55
        local.get 55
        i32.load offset=1560
        local.set 56
        local.get 56
        call $fflush
        drop
      end
    end
    i32.const 80
    local.set 57
    local.get 7
    local.get 57
    i32.add
    local.set 58
    local.get 58
    global.set $__stack_pointer
    return)
  (func $__original_main (type 12) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i64 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 0
    i32.const 64
    local.set 1
    local.get 0
    local.get 1
    i32.sub
    local.set 2
    local.get 2
    global.set $__stack_pointer
    i32.const 0
    local.set 3
    local.get 2
    local.get 3
    i32.store offset=60
    i32.const 0
    local.set 4
    local.get 2
    local.get 4
    i32.store offset=56
    i32.const 48
    local.set 5
    local.get 2
    local.get 5
    i32.add
    local.set 6
    i32.const 0
    local.set 7
    local.get 6
    local.get 7
    i32.store16
    i64.const 0
    local.set 8
    local.get 2
    local.get 8
    i64.store offset=40
    i32.const 40
    local.set 9
    local.get 2
    local.get 9
    i32.add
    local.set 10
    local.get 10
    local.set 11
    local.get 11
    call $get_name
    i32.const 3
    local.set 12
    local.get 2
    local.get 12
    i32.store offset=24
    i32.const 1
    local.set 13
    local.get 2
    local.get 13
    i32.store offset=28
    i32.const 2
    local.set 14
    local.get 2
    local.get 14
    i32.store offset=32
    i32.const 3
    local.set 15
    local.get 2
    local.get 15
    i32.store offset=36
    i32.const 40
    local.set 16
    local.get 2
    local.get 16
    i32.add
    local.set 17
    local.get 17
    local.set 18
    i32.const 24
    local.set 19
    local.get 2
    local.get 19
    i32.add
    local.set 20
    local.get 20
    local.set 21
    i32.const 2
    local.set 22
    i32.const 56
    local.set 23
    local.get 2
    local.get 23
    i32.add
    local.set 24
    local.get 24
    local.set 25
    i32.const 20
    local.set 26
    local.get 2
    local.get 26
    i32.add
    local.set 27
    local.get 27
    local.set 28
    local.get 21
    local.get 18
    local.get 22
    local.get 25
    local.get 28
    call $menu
    i32.const 40
    local.set 29
    local.get 2
    local.get 29
    i32.add
    local.set 30
    local.get 30
    local.set 31
    local.get 2
    i32.load offset=24
    local.set 32
    local.get 2
    local.get 32
    i32.store offset=4
    local.get 2
    local.get 31
    i32.store
    i32.const 1144
    local.set 33
    local.get 33
    local.get 2
    call $printf
    drop
    i32.const 0
    local.set 34
    local.get 34
    i32.load offset=1560
    local.set 35
    local.get 35
    call $fflush
    drop
    i32.const 0
    local.set 36
    i32.const 64
    local.set 37
    local.get 2
    local.get 37
    i32.add
    local.set 38
    local.get 38
    global.set $__stack_pointer
    local.get 36
    return)
  (func $__wasi_fd_close (type 0) (param i32) (result i32)
    local.get 0
    call $__imported_wasi_snapshot_preview1_fd_close
    i32.const 65535
    i32.and)
  (func $__wasi_fd_fdstat_get (type 4) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call $__imported_wasi_snapshot_preview1_fd_fdstat_get
    i32.const 65535
    i32.and)
  (func $__wasi_fd_fdstat_set_flags (type 4) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call $__imported_wasi_snapshot_preview1_fd_fdstat_set_flags
    i32.const 65535
    i32.and)
  (func $__wasi_fd_prestat_get (type 4) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call $__imported_wasi_snapshot_preview1_fd_prestat_get
    i32.const 65535
    i32.and)
  (func $__wasi_fd_prestat_dir_name (type 2) (param i32 i32 i32) (result i32)
    local.get 0
    local.get 1
    local.get 2
    call $__imported_wasi_snapshot_preview1_fd_prestat_dir_name
    i32.const 65535
    i32.and)
  (func $__wasi_fd_read (type 5) (param i32 i32 i32 i32) (result i32)
    local.get 0
    local.get 1
    local.get 2
    local.get 3
    call $__imported_wasi_snapshot_preview1_fd_read
    i32.const 65535
    i32.and)
  (func $__wasi_fd_seek (type 6) (param i32 i64 i32 i32) (result i32)
    local.get 0
    local.get 1
    local.get 2
    local.get 3
    call $__imported_wasi_snapshot_preview1_fd_seek
    i32.const 65535
    i32.and)
  (func $__wasi_fd_write (type 5) (param i32 i32 i32 i32) (result i32)
    local.get 0
    local.get 1
    local.get 2
    local.get 3
    call $__imported_wasi_snapshot_preview1_fd_write
    i32.const 65535
    i32.and)
  (func $__wasi_path_open (type 13) (param i32 i32 i32 i32 i64 i64 i32 i32) (result i32)
    local.get 0
    local.get 1
    local.get 2
    local.get 2
    call $strlen
    local.get 3
    local.get 4
    local.get 5
    local.get 6
    local.get 7
    call $__imported_wasi_snapshot_preview1_path_open
    i32.const 65535
    i32.and)
  (func $__wasi_proc_exit (type 8) (param i32)
    local.get 0
    call $__imported_wasi_snapshot_preview1_proc_exit
    unreachable)
  (func $_Exit (type 8) (param i32)
    local.get 0
    call $__wasi_proc_exit
    unreachable)
  (func $dummy (type 1))
  (func $__wasm_call_dtors (type 1)
    call $dummy
    call $__stdio_exit)
  (func $abort (type 1)
    unreachable
    unreachable)
  (func $sbrk (type 0) (param i32) (result i32)
    block  ;; label = @1
      local.get 0
      br_if 0 (;@1;)
      memory.size
      i32.const 16
      i32.shl
      return
    end
    block  ;; label = @1
      local.get 0
      i32.const 65535
      i32.and
      br_if 0 (;@1;)
      local.get 0
      i32.const -1
      i32.le_s
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 0
        i32.const 16
        i32.shr_u
        memory.grow
        local.tee 0
        i32.const -1
        i32.ne
        br_if 0 (;@2;)
        i32.const 0
        i32.const 48
        i32.store offset=4644
        i32.const -1
        return
      end
      local.get 0
      i32.const 16
      i32.shl
      return
    end
    call $abort
    unreachable)
  (func $malloc (type 0) (param i32) (result i32)
    local.get 0
    call $dlmalloc)
  (func $dlmalloc (type 0) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    block  ;; label = @1
      i32.const 0
      i32.load offset=4672
      local.tee 2
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          i32.const 0
          i32.load offset=5120
          local.tee 3
          i32.eqz
          br_if 0 (;@3;)
          i32.const 0
          i32.load offset=5124
          local.set 4
          br 1 (;@2;)
        end
        i32.const 0
        i64.const -1
        i64.store offset=5132 align=4
        i32.const 0
        i64.const 281474976776192
        i64.store offset=5124 align=4
        i32.const 0
        local.get 1
        i32.const 8
        i32.add
        i32.const -16
        i32.and
        i32.const 1431655768
        i32.xor
        local.tee 3
        i32.store offset=5120
        i32.const 0
        i32.const 0
        i32.store offset=5140
        i32.const 0
        i32.const 0
        i32.store offset=5092
        i32.const 65536
        local.set 4
      end
      i32.const 0
      local.set 2
      i32.const 131072
      i32.const 72816
      local.get 4
      i32.add
      i32.const -1
      i32.add
      i32.const 0
      local.get 4
      i32.sub
      i32.and
      i32.const 131072
      select
      i32.const 72816
      i32.sub
      local.tee 5
      i32.const 89
      i32.lt_u
      br_if 0 (;@1;)
      i32.const 0
      local.set 4
      i32.const 0
      local.get 5
      i32.store offset=5100
      i32.const 0
      i32.const 72816
      i32.store offset=5096
      i32.const 0
      i32.const 72816
      i32.store offset=4664
      i32.const 0
      local.get 3
      i32.store offset=4684
      i32.const 0
      i32.const -1
      i32.store offset=4680
      loop  ;; label = @2
        local.get 4
        i32.const 4708
        i32.add
        local.get 4
        i32.const 4696
        i32.add
        local.tee 3
        i32.store
        local.get 3
        local.get 4
        i32.const 4688
        i32.add
        local.tee 6
        i32.store
        local.get 4
        i32.const 4700
        i32.add
        local.get 6
        i32.store
        local.get 4
        i32.const 4716
        i32.add
        local.get 4
        i32.const 4704
        i32.add
        local.tee 6
        i32.store
        local.get 6
        local.get 3
        i32.store
        local.get 4
        i32.const 4724
        i32.add
        local.get 4
        i32.const 4712
        i32.add
        local.tee 3
        i32.store
        local.get 3
        local.get 6
        i32.store
        local.get 4
        i32.const 4720
        i32.add
        local.get 3
        i32.store
        local.get 4
        i32.const 32
        i32.add
        local.tee 4
        i32.const 256
        i32.ne
        br_if 0 (;@2;)
      end
      i32.const 72816
      i32.const -8
      i32.const 72816
      i32.sub
      i32.const 15
      i32.and
      i32.const 0
      i32.const 72816
      i32.const 8
      i32.add
      i32.const 15
      i32.and
      select
      local.tee 4
      i32.add
      local.tee 2
      i32.const 4
      i32.add
      local.get 5
      i32.const -56
      i32.add
      local.tee 3
      local.get 4
      i32.sub
      local.tee 4
      i32.const 1
      i32.or
      i32.store
      i32.const 0
      i32.const 0
      i32.load offset=5136
      i32.store offset=4676
      i32.const 0
      local.get 4
      i32.store offset=4660
      i32.const 0
      local.get 2
      i32.store offset=4672
      i32.const 72816
      local.get 3
      i32.add
      i32.const 56
      i32.store offset=4
    end
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            local.get 0
                            i32.const 236
                            i32.gt_u
                            br_if 0 (;@12;)
                            block  ;; label = @13
                              i32.const 0
                              i32.load offset=4648
                              local.tee 7
                              i32.const 16
                              local.get 0
                              i32.const 19
                              i32.add
                              i32.const -16
                              i32.and
                              local.get 0
                              i32.const 11
                              i32.lt_u
                              select
                              local.tee 5
                              i32.const 3
                              i32.shr_u
                              local.tee 3
                              i32.shr_u
                              local.tee 4
                              i32.const 3
                              i32.and
                              i32.eqz
                              br_if 0 (;@13;)
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 4
                                  i32.const 1
                                  i32.and
                                  local.get 3
                                  i32.or
                                  i32.const 1
                                  i32.xor
                                  local.tee 6
                                  i32.const 3
                                  i32.shl
                                  local.tee 3
                                  i32.const 4688
                                  i32.add
                                  local.tee 4
                                  local.get 3
                                  i32.const 4696
                                  i32.add
                                  i32.load
                                  local.tee 3
                                  i32.load offset=8
                                  local.tee 5
                                  i32.ne
                                  br_if 0 (;@15;)
                                  i32.const 0
                                  local.get 7
                                  i32.const -2
                                  local.get 6
                                  i32.rotl
                                  i32.and
                                  i32.store offset=4648
                                  br 1 (;@14;)
                                end
                                local.get 4
                                local.get 5
                                i32.store offset=8
                                local.get 5
                                local.get 4
                                i32.store offset=12
                              end
                              local.get 3
                              i32.const 8
                              i32.add
                              local.set 4
                              local.get 3
                              local.get 6
                              i32.const 3
                              i32.shl
                              local.tee 6
                              i32.const 3
                              i32.or
                              i32.store offset=4
                              local.get 3
                              local.get 6
                              i32.add
                              local.tee 3
                              local.get 3
                              i32.load offset=4
                              i32.const 1
                              i32.or
                              i32.store offset=4
                              br 12 (;@1;)
                            end
                            local.get 5
                            i32.const 0
                            i32.load offset=4656
                            local.tee 8
                            i32.le_u
                            br_if 1 (;@11;)
                            block  ;; label = @13
                              local.get 4
                              i32.eqz
                              br_if 0 (;@13;)
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 4
                                  local.get 3
                                  i32.shl
                                  i32.const 2
                                  local.get 3
                                  i32.shl
                                  local.tee 4
                                  i32.const 0
                                  local.get 4
                                  i32.sub
                                  i32.or
                                  i32.and
                                  local.tee 4
                                  i32.const 0
                                  local.get 4
                                  i32.sub
                                  i32.and
                                  i32.ctz
                                  local.tee 3
                                  i32.const 3
                                  i32.shl
                                  local.tee 4
                                  i32.const 4688
                                  i32.add
                                  local.tee 6
                                  local.get 4
                                  i32.const 4696
                                  i32.add
                                  i32.load
                                  local.tee 4
                                  i32.load offset=8
                                  local.tee 0
                                  i32.ne
                                  br_if 0 (;@15;)
                                  i32.const 0
                                  local.get 7
                                  i32.const -2
                                  local.get 3
                                  i32.rotl
                                  i32.and
                                  local.tee 7
                                  i32.store offset=4648
                                  br 1 (;@14;)
                                end
                                local.get 6
                                local.get 0
                                i32.store offset=8
                                local.get 0
                                local.get 6
                                i32.store offset=12
                              end
                              local.get 4
                              local.get 5
                              i32.const 3
                              i32.or
                              i32.store offset=4
                              local.get 4
                              local.get 3
                              i32.const 3
                              i32.shl
                              local.tee 3
                              i32.add
                              local.get 3
                              local.get 5
                              i32.sub
                              local.tee 6
                              i32.store
                              local.get 4
                              local.get 5
                              i32.add
                              local.tee 0
                              local.get 6
                              i32.const 1
                              i32.or
                              i32.store offset=4
                              block  ;; label = @14
                                local.get 8
                                i32.eqz
                                br_if 0 (;@14;)
                                local.get 8
                                i32.const -8
                                i32.and
                                i32.const 4688
                                i32.add
                                local.set 5
                                i32.const 0
                                i32.load offset=4668
                                local.set 3
                                block  ;; label = @15
                                  block  ;; label = @16
                                    local.get 7
                                    i32.const 1
                                    local.get 8
                                    i32.const 3
                                    i32.shr_u
                                    i32.shl
                                    local.tee 9
                                    i32.and
                                    br_if 0 (;@16;)
                                    i32.const 0
                                    local.get 7
                                    local.get 9
                                    i32.or
                                    i32.store offset=4648
                                    local.get 5
                                    local.set 9
                                    br 1 (;@15;)
                                  end
                                  local.get 5
                                  i32.load offset=8
                                  local.set 9
                                end
                                local.get 9
                                local.get 3
                                i32.store offset=12
                                local.get 5
                                local.get 3
                                i32.store offset=8
                                local.get 3
                                local.get 5
                                i32.store offset=12
                                local.get 3
                                local.get 9
                                i32.store offset=8
                              end
                              local.get 4
                              i32.const 8
                              i32.add
                              local.set 4
                              i32.const 0
                              local.get 0
                              i32.store offset=4668
                              i32.const 0
                              local.get 6
                              i32.store offset=4656
                              br 12 (;@1;)
                            end
                            i32.const 0
                            i32.load offset=4652
                            local.tee 10
                            i32.eqz
                            br_if 1 (;@11;)
                            local.get 10
                            i32.const 0
                            local.get 10
                            i32.sub
                            i32.and
                            i32.ctz
                            i32.const 2
                            i32.shl
                            i32.const 4952
                            i32.add
                            i32.load
                            local.tee 0
                            i32.load offset=4
                            i32.const -8
                            i32.and
                            local.get 5
                            i32.sub
                            local.set 3
                            local.get 0
                            local.set 6
                            block  ;; label = @13
                              loop  ;; label = @14
                                block  ;; label = @15
                                  local.get 6
                                  i32.load offset=16
                                  local.tee 4
                                  br_if 0 (;@15;)
                                  local.get 6
                                  i32.const 20
                                  i32.add
                                  i32.load
                                  local.tee 4
                                  i32.eqz
                                  br_if 2 (;@13;)
                                end
                                local.get 4
                                i32.load offset=4
                                i32.const -8
                                i32.and
                                local.get 5
                                i32.sub
                                local.tee 6
                                local.get 3
                                local.get 6
                                local.get 3
                                i32.lt_u
                                local.tee 6
                                select
                                local.set 3
                                local.get 4
                                local.get 0
                                local.get 6
                                select
                                local.set 0
                                local.get 4
                                local.set 6
                                br 0 (;@14;)
                              end
                            end
                            local.get 0
                            i32.load offset=24
                            local.set 11
                            block  ;; label = @13
                              local.get 0
                              i32.load offset=12
                              local.tee 9
                              local.get 0
                              i32.eq
                              br_if 0 (;@13;)
                              local.get 0
                              i32.load offset=8
                              local.tee 4
                              i32.const 0
                              i32.load offset=4664
                              i32.lt_u
                              drop
                              local.get 9
                              local.get 4
                              i32.store offset=8
                              local.get 4
                              local.get 9
                              i32.store offset=12
                              br 11 (;@2;)
                            end
                            block  ;; label = @13
                              local.get 0
                              i32.const 20
                              i32.add
                              local.tee 6
                              i32.load
                              local.tee 4
                              br_if 0 (;@13;)
                              local.get 0
                              i32.load offset=16
                              local.tee 4
                              i32.eqz
                              br_if 3 (;@10;)
                              local.get 0
                              i32.const 16
                              i32.add
                              local.set 6
                            end
                            loop  ;; label = @13
                              local.get 6
                              local.set 2
                              local.get 4
                              local.tee 9
                              i32.const 20
                              i32.add
                              local.tee 6
                              i32.load
                              local.tee 4
                              br_if 0 (;@13;)
                              local.get 9
                              i32.const 16
                              i32.add
                              local.set 6
                              local.get 9
                              i32.load offset=16
                              local.tee 4
                              br_if 0 (;@13;)
                            end
                            local.get 2
                            i32.const 0
                            i32.store
                            br 10 (;@2;)
                          end
                          i32.const -1
                          local.set 5
                          local.get 0
                          i32.const -65
                          i32.gt_u
                          br_if 0 (;@11;)
                          local.get 0
                          i32.const 19
                          i32.add
                          local.tee 4
                          i32.const -16
                          i32.and
                          local.set 5
                          i32.const 0
                          i32.load offset=4652
                          local.tee 10
                          i32.eqz
                          br_if 0 (;@11;)
                          i32.const 0
                          local.set 8
                          block  ;; label = @12
                            local.get 5
                            i32.const 256
                            i32.lt_u
                            br_if 0 (;@12;)
                            i32.const 31
                            local.set 8
                            local.get 5
                            i32.const 16777215
                            i32.gt_u
                            br_if 0 (;@12;)
                            local.get 5
                            i32.const 38
                            local.get 4
                            i32.const 8
                            i32.shr_u
                            i32.clz
                            local.tee 4
                            i32.sub
                            i32.shr_u
                            i32.const 1
                            i32.and
                            local.get 4
                            i32.const 1
                            i32.shl
                            i32.sub
                            i32.const 62
                            i32.add
                            local.set 8
                          end
                          i32.const 0
                          local.get 5
                          i32.sub
                          local.set 3
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 8
                                  i32.const 2
                                  i32.shl
                                  i32.const 4952
                                  i32.add
                                  i32.load
                                  local.tee 6
                                  br_if 0 (;@15;)
                                  i32.const 0
                                  local.set 4
                                  i32.const 0
                                  local.set 9
                                  br 1 (;@14;)
                                end
                                i32.const 0
                                local.set 4
                                local.get 5
                                i32.const 0
                                i32.const 25
                                local.get 8
                                i32.const 1
                                i32.shr_u
                                i32.sub
                                local.get 8
                                i32.const 31
                                i32.eq
                                select
                                i32.shl
                                local.set 0
                                i32.const 0
                                local.set 9
                                loop  ;; label = @15
                                  block  ;; label = @16
                                    local.get 6
                                    i32.load offset=4
                                    i32.const -8
                                    i32.and
                                    local.get 5
                                    i32.sub
                                    local.tee 7
                                    local.get 3
                                    i32.ge_u
                                    br_if 0 (;@16;)
                                    local.get 7
                                    local.set 3
                                    local.get 6
                                    local.set 9
                                    local.get 7
                                    br_if 0 (;@16;)
                                    i32.const 0
                                    local.set 3
                                    local.get 6
                                    local.set 9
                                    local.get 6
                                    local.set 4
                                    br 3 (;@13;)
                                  end
                                  local.get 4
                                  local.get 6
                                  i32.const 20
                                  i32.add
                                  i32.load
                                  local.tee 7
                                  local.get 7
                                  local.get 6
                                  local.get 0
                                  i32.const 29
                                  i32.shr_u
                                  i32.const 4
                                  i32.and
                                  i32.add
                                  i32.const 16
                                  i32.add
                                  i32.load
                                  local.tee 6
                                  i32.eq
                                  select
                                  local.get 4
                                  local.get 7
                                  select
                                  local.set 4
                                  local.get 0
                                  i32.const 1
                                  i32.shl
                                  local.set 0
                                  local.get 6
                                  br_if 0 (;@15;)
                                end
                              end
                              block  ;; label = @14
                                local.get 4
                                local.get 9
                                i32.or
                                br_if 0 (;@14;)
                                i32.const 0
                                local.set 9
                                i32.const 2
                                local.get 8
                                i32.shl
                                local.tee 4
                                i32.const 0
                                local.get 4
                                i32.sub
                                i32.or
                                local.get 10
                                i32.and
                                local.tee 4
                                i32.eqz
                                br_if 3 (;@11;)
                                local.get 4
                                i32.const 0
                                local.get 4
                                i32.sub
                                i32.and
                                i32.ctz
                                i32.const 2
                                i32.shl
                                i32.const 4952
                                i32.add
                                i32.load
                                local.set 4
                              end
                              local.get 4
                              i32.eqz
                              br_if 1 (;@12;)
                            end
                            loop  ;; label = @13
                              local.get 4
                              i32.load offset=4
                              i32.const -8
                              i32.and
                              local.get 5
                              i32.sub
                              local.tee 7
                              local.get 3
                              i32.lt_u
                              local.set 0
                              block  ;; label = @14
                                local.get 4
                                i32.load offset=16
                                local.tee 6
                                br_if 0 (;@14;)
                                local.get 4
                                i32.const 20
                                i32.add
                                i32.load
                                local.set 6
                              end
                              local.get 7
                              local.get 3
                              local.get 0
                              select
                              local.set 3
                              local.get 4
                              local.get 9
                              local.get 0
                              select
                              local.set 9
                              local.get 6
                              local.set 4
                              local.get 6
                              br_if 0 (;@13;)
                            end
                          end
                          local.get 9
                          i32.eqz
                          br_if 0 (;@11;)
                          local.get 3
                          i32.const 0
                          i32.load offset=4656
                          local.get 5
                          i32.sub
                          i32.ge_u
                          br_if 0 (;@11;)
                          local.get 9
                          i32.load offset=24
                          local.set 2
                          block  ;; label = @12
                            local.get 9
                            i32.load offset=12
                            local.tee 0
                            local.get 9
                            i32.eq
                            br_if 0 (;@12;)
                            local.get 9
                            i32.load offset=8
                            local.tee 4
                            i32.const 0
                            i32.load offset=4664
                            i32.lt_u
                            drop
                            local.get 0
                            local.get 4
                            i32.store offset=8
                            local.get 4
                            local.get 0
                            i32.store offset=12
                            br 9 (;@3;)
                          end
                          block  ;; label = @12
                            local.get 9
                            i32.const 20
                            i32.add
                            local.tee 6
                            i32.load
                            local.tee 4
                            br_if 0 (;@12;)
                            local.get 9
                            i32.load offset=16
                            local.tee 4
                            i32.eqz
                            br_if 3 (;@9;)
                            local.get 9
                            i32.const 16
                            i32.add
                            local.set 6
                          end
                          loop  ;; label = @12
                            local.get 6
                            local.set 7
                            local.get 4
                            local.tee 0
                            i32.const 20
                            i32.add
                            local.tee 6
                            i32.load
                            local.tee 4
                            br_if 0 (;@12;)
                            local.get 0
                            i32.const 16
                            i32.add
                            local.set 6
                            local.get 0
                            i32.load offset=16
                            local.tee 4
                            br_if 0 (;@12;)
                          end
                          local.get 7
                          i32.const 0
                          i32.store
                          br 8 (;@3;)
                        end
                        block  ;; label = @11
                          i32.const 0
                          i32.load offset=4656
                          local.tee 4
                          local.get 5
                          i32.lt_u
                          br_if 0 (;@11;)
                          i32.const 0
                          i32.load offset=4668
                          local.set 3
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 4
                              local.get 5
                              i32.sub
                              local.tee 6
                              i32.const 16
                              i32.lt_u
                              br_if 0 (;@13;)
                              local.get 3
                              local.get 5
                              i32.add
                              local.tee 0
                              local.get 6
                              i32.const 1
                              i32.or
                              i32.store offset=4
                              local.get 3
                              local.get 4
                              i32.add
                              local.get 6
                              i32.store
                              local.get 3
                              local.get 5
                              i32.const 3
                              i32.or
                              i32.store offset=4
                              br 1 (;@12;)
                            end
                            local.get 3
                            local.get 4
                            i32.const 3
                            i32.or
                            i32.store offset=4
                            local.get 3
                            local.get 4
                            i32.add
                            local.tee 4
                            local.get 4
                            i32.load offset=4
                            i32.const 1
                            i32.or
                            i32.store offset=4
                            i32.const 0
                            local.set 0
                            i32.const 0
                            local.set 6
                          end
                          i32.const 0
                          local.get 6
                          i32.store offset=4656
                          i32.const 0
                          local.get 0
                          i32.store offset=4668
                          local.get 3
                          i32.const 8
                          i32.add
                          local.set 4
                          br 10 (;@1;)
                        end
                        block  ;; label = @11
                          i32.const 0
                          i32.load offset=4660
                          local.tee 6
                          local.get 5
                          i32.le_u
                          br_if 0 (;@11;)
                          local.get 2
                          local.get 5
                          i32.add
                          local.tee 4
                          local.get 6
                          local.get 5
                          i32.sub
                          local.tee 3
                          i32.const 1
                          i32.or
                          i32.store offset=4
                          i32.const 0
                          local.get 4
                          i32.store offset=4672
                          i32.const 0
                          local.get 3
                          i32.store offset=4660
                          local.get 2
                          local.get 5
                          i32.const 3
                          i32.or
                          i32.store offset=4
                          local.get 2
                          i32.const 8
                          i32.add
                          local.set 4
                          br 10 (;@1;)
                        end
                        block  ;; label = @11
                          block  ;; label = @12
                            i32.const 0
                            i32.load offset=5120
                            i32.eqz
                            br_if 0 (;@12;)
                            i32.const 0
                            i32.load offset=5128
                            local.set 3
                            br 1 (;@11;)
                          end
                          i32.const 0
                          i64.const -1
                          i64.store offset=5132 align=4
                          i32.const 0
                          i64.const 281474976776192
                          i64.store offset=5124 align=4
                          i32.const 0
                          local.get 1
                          i32.const 12
                          i32.add
                          i32.const -16
                          i32.and
                          i32.const 1431655768
                          i32.xor
                          i32.store offset=5120
                          i32.const 0
                          i32.const 0
                          i32.store offset=5140
                          i32.const 0
                          i32.const 0
                          i32.store offset=5092
                          i32.const 65536
                          local.set 3
                        end
                        i32.const 0
                        local.set 4
                        block  ;; label = @11
                          local.get 3
                          local.get 5
                          i32.const 71
                          i32.add
                          local.tee 8
                          i32.add
                          local.tee 0
                          i32.const 0
                          local.get 3
                          i32.sub
                          local.tee 7
                          i32.and
                          local.tee 9
                          local.get 5
                          i32.gt_u
                          br_if 0 (;@11;)
                          i32.const 0
                          i32.const 48
                          i32.store offset=4644
                          br 10 (;@1;)
                        end
                        block  ;; label = @11
                          i32.const 0
                          i32.load offset=5088
                          local.tee 4
                          i32.eqz
                          br_if 0 (;@11;)
                          block  ;; label = @12
                            i32.const 0
                            i32.load offset=5080
                            local.tee 3
                            local.get 9
                            i32.add
                            local.tee 10
                            local.get 3
                            i32.le_u
                            br_if 0 (;@12;)
                            local.get 10
                            local.get 4
                            i32.le_u
                            br_if 1 (;@11;)
                          end
                          i32.const 0
                          local.set 4
                          i32.const 0
                          i32.const 48
                          i32.store offset=4644
                          br 10 (;@1;)
                        end
                        i32.const 0
                        i32.load8_u offset=5092
                        i32.const 4
                        i32.and
                        br_if 4 (;@6;)
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 2
                              i32.eqz
                              br_if 0 (;@13;)
                              i32.const 5096
                              local.set 4
                              loop  ;; label = @14
                                block  ;; label = @15
                                  local.get 4
                                  i32.load
                                  local.tee 3
                                  local.get 2
                                  i32.gt_u
                                  br_if 0 (;@15;)
                                  local.get 3
                                  local.get 4
                                  i32.load offset=4
                                  i32.add
                                  local.get 2
                                  i32.gt_u
                                  br_if 3 (;@12;)
                                end
                                local.get 4
                                i32.load offset=8
                                local.tee 4
                                br_if 0 (;@14;)
                              end
                            end
                            i32.const 0
                            call $sbrk
                            local.tee 0
                            i32.const -1
                            i32.eq
                            br_if 5 (;@7;)
                            local.get 9
                            local.set 7
                            block  ;; label = @13
                              i32.const 0
                              i32.load offset=5124
                              local.tee 4
                              i32.const -1
                              i32.add
                              local.tee 3
                              local.get 0
                              i32.and
                              i32.eqz
                              br_if 0 (;@13;)
                              local.get 9
                              local.get 0
                              i32.sub
                              local.get 3
                              local.get 0
                              i32.add
                              i32.const 0
                              local.get 4
                              i32.sub
                              i32.and
                              i32.add
                              local.set 7
                            end
                            local.get 7
                            local.get 5
                            i32.le_u
                            br_if 5 (;@7;)
                            local.get 7
                            i32.const 2147483646
                            i32.gt_u
                            br_if 5 (;@7;)
                            block  ;; label = @13
                              i32.const 0
                              i32.load offset=5088
                              local.tee 4
                              i32.eqz
                              br_if 0 (;@13;)
                              i32.const 0
                              i32.load offset=5080
                              local.tee 3
                              local.get 7
                              i32.add
                              local.tee 6
                              local.get 3
                              i32.le_u
                              br_if 6 (;@7;)
                              local.get 6
                              local.get 4
                              i32.gt_u
                              br_if 6 (;@7;)
                            end
                            local.get 7
                            call $sbrk
                            local.tee 4
                            local.get 0
                            i32.ne
                            br_if 1 (;@11;)
                            br 7 (;@5;)
                          end
                          local.get 0
                          local.get 6
                          i32.sub
                          local.get 7
                          i32.and
                          local.tee 7
                          i32.const 2147483646
                          i32.gt_u
                          br_if 4 (;@7;)
                          local.get 7
                          call $sbrk
                          local.tee 0
                          local.get 4
                          i32.load
                          local.get 4
                          i32.load offset=4
                          i32.add
                          i32.eq
                          br_if 3 (;@8;)
                          local.get 0
                          local.set 4
                        end
                        block  ;; label = @11
                          local.get 4
                          i32.const -1
                          i32.eq
                          br_if 0 (;@11;)
                          local.get 5
                          i32.const 72
                          i32.add
                          local.get 7
                          i32.le_u
                          br_if 0 (;@11;)
                          block  ;; label = @12
                            local.get 8
                            local.get 7
                            i32.sub
                            i32.const 0
                            i32.load offset=5128
                            local.tee 3
                            i32.add
                            i32.const 0
                            local.get 3
                            i32.sub
                            i32.and
                            local.tee 3
                            i32.const 2147483646
                            i32.le_u
                            br_if 0 (;@12;)
                            local.get 4
                            local.set 0
                            br 7 (;@5;)
                          end
                          block  ;; label = @12
                            local.get 3
                            call $sbrk
                            i32.const -1
                            i32.eq
                            br_if 0 (;@12;)
                            local.get 3
                            local.get 7
                            i32.add
                            local.set 7
                            local.get 4
                            local.set 0
                            br 7 (;@5;)
                          end
                          i32.const 0
                          local.get 7
                          i32.sub
                          call $sbrk
                          drop
                          br 4 (;@7;)
                        end
                        local.get 4
                        local.set 0
                        local.get 4
                        i32.const -1
                        i32.ne
                        br_if 5 (;@5;)
                        br 3 (;@7;)
                      end
                      i32.const 0
                      local.set 9
                      br 7 (;@2;)
                    end
                    i32.const 0
                    local.set 0
                    br 5 (;@3;)
                  end
                  local.get 0
                  i32.const -1
                  i32.ne
                  br_if 2 (;@5;)
                end
                i32.const 0
                i32.const 0
                i32.load offset=5092
                i32.const 4
                i32.or
                i32.store offset=5092
              end
              local.get 9
              i32.const 2147483646
              i32.gt_u
              br_if 1 (;@4;)
              local.get 9
              call $sbrk
              local.set 0
              i32.const 0
              call $sbrk
              local.set 4
              local.get 0
              i32.const -1
              i32.eq
              br_if 1 (;@4;)
              local.get 4
              i32.const -1
              i32.eq
              br_if 1 (;@4;)
              local.get 0
              local.get 4
              i32.ge_u
              br_if 1 (;@4;)
              local.get 4
              local.get 0
              i32.sub
              local.tee 7
              local.get 5
              i32.const 56
              i32.add
              i32.le_u
              br_if 1 (;@4;)
            end
            i32.const 0
            i32.const 0
            i32.load offset=5080
            local.get 7
            i32.add
            local.tee 4
            i32.store offset=5080
            block  ;; label = @5
              local.get 4
              i32.const 0
              i32.load offset=5084
              i32.le_u
              br_if 0 (;@5;)
              i32.const 0
              local.get 4
              i32.store offset=5084
            end
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    i32.const 0
                    i32.load offset=4672
                    local.tee 3
                    i32.eqz
                    br_if 0 (;@8;)
                    i32.const 5096
                    local.set 4
                    loop  ;; label = @9
                      local.get 0
                      local.get 4
                      i32.load
                      local.tee 6
                      local.get 4
                      i32.load offset=4
                      local.tee 9
                      i32.add
                      i32.eq
                      br_if 2 (;@7;)
                      local.get 4
                      i32.load offset=8
                      local.tee 4
                      br_if 0 (;@9;)
                      br 3 (;@6;)
                    end
                  end
                  block  ;; label = @8
                    block  ;; label = @9
                      i32.const 0
                      i32.load offset=4664
                      local.tee 4
                      i32.eqz
                      br_if 0 (;@9;)
                      local.get 0
                      local.get 4
                      i32.ge_u
                      br_if 1 (;@8;)
                    end
                    i32.const 0
                    local.get 0
                    i32.store offset=4664
                  end
                  i32.const 0
                  local.set 4
                  i32.const 0
                  local.get 7
                  i32.store offset=5100
                  i32.const 0
                  local.get 0
                  i32.store offset=5096
                  i32.const 0
                  i32.const -1
                  i32.store offset=4680
                  i32.const 0
                  i32.const 0
                  i32.load offset=5120
                  i32.store offset=4684
                  i32.const 0
                  i32.const 0
                  i32.store offset=5108
                  loop  ;; label = @8
                    local.get 4
                    i32.const 4708
                    i32.add
                    local.get 4
                    i32.const 4696
                    i32.add
                    local.tee 3
                    i32.store
                    local.get 3
                    local.get 4
                    i32.const 4688
                    i32.add
                    local.tee 6
                    i32.store
                    local.get 4
                    i32.const 4700
                    i32.add
                    local.get 6
                    i32.store
                    local.get 4
                    i32.const 4716
                    i32.add
                    local.get 4
                    i32.const 4704
                    i32.add
                    local.tee 6
                    i32.store
                    local.get 6
                    local.get 3
                    i32.store
                    local.get 4
                    i32.const 4724
                    i32.add
                    local.get 4
                    i32.const 4712
                    i32.add
                    local.tee 3
                    i32.store
                    local.get 3
                    local.get 6
                    i32.store
                    local.get 4
                    i32.const 4720
                    i32.add
                    local.get 3
                    i32.store
                    local.get 4
                    i32.const 32
                    i32.add
                    local.tee 4
                    i32.const 256
                    i32.ne
                    br_if 0 (;@8;)
                  end
                  local.get 0
                  i32.const -8
                  local.get 0
                  i32.sub
                  i32.const 15
                  i32.and
                  i32.const 0
                  local.get 0
                  i32.const 8
                  i32.add
                  i32.const 15
                  i32.and
                  select
                  local.tee 4
                  i32.add
                  local.tee 3
                  local.get 7
                  i32.const -56
                  i32.add
                  local.tee 6
                  local.get 4
                  i32.sub
                  local.tee 4
                  i32.const 1
                  i32.or
                  i32.store offset=4
                  i32.const 0
                  i32.const 0
                  i32.load offset=5136
                  i32.store offset=4676
                  i32.const 0
                  local.get 4
                  i32.store offset=4660
                  i32.const 0
                  local.get 3
                  i32.store offset=4672
                  local.get 0
                  local.get 6
                  i32.add
                  i32.const 56
                  i32.store offset=4
                  br 2 (;@5;)
                end
                local.get 4
                i32.load8_u offset=12
                i32.const 8
                i32.and
                br_if 0 (;@6;)
                local.get 3
                local.get 6
                i32.lt_u
                br_if 0 (;@6;)
                local.get 3
                local.get 0
                i32.ge_u
                br_if 0 (;@6;)
                local.get 3
                i32.const -8
                local.get 3
                i32.sub
                i32.const 15
                i32.and
                i32.const 0
                local.get 3
                i32.const 8
                i32.add
                i32.const 15
                i32.and
                select
                local.tee 6
                i32.add
                local.tee 0
                i32.const 0
                i32.load offset=4660
                local.get 7
                i32.add
                local.tee 2
                local.get 6
                i32.sub
                local.tee 6
                i32.const 1
                i32.or
                i32.store offset=4
                local.get 4
                local.get 9
                local.get 7
                i32.add
                i32.store offset=4
                i32.const 0
                i32.const 0
                i32.load offset=5136
                i32.store offset=4676
                i32.const 0
                local.get 6
                i32.store offset=4660
                i32.const 0
                local.get 0
                i32.store offset=4672
                local.get 3
                local.get 2
                i32.add
                i32.const 56
                i32.store offset=4
                br 1 (;@5;)
              end
              block  ;; label = @6
                local.get 0
                i32.const 0
                i32.load offset=4664
                local.tee 9
                i32.ge_u
                br_if 0 (;@6;)
                i32.const 0
                local.get 0
                i32.store offset=4664
                local.get 0
                local.set 9
              end
              local.get 0
              local.get 7
              i32.add
              local.set 6
              i32.const 5096
              local.set 4
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            loop  ;; label = @13
                              local.get 4
                              i32.load
                              local.get 6
                              i32.eq
                              br_if 1 (;@12;)
                              local.get 4
                              i32.load offset=8
                              local.tee 4
                              br_if 0 (;@13;)
                              br 2 (;@11;)
                            end
                          end
                          local.get 4
                          i32.load8_u offset=12
                          i32.const 8
                          i32.and
                          i32.eqz
                          br_if 1 (;@10;)
                        end
                        i32.const 5096
                        local.set 4
                        loop  ;; label = @11
                          block  ;; label = @12
                            local.get 4
                            i32.load
                            local.tee 6
                            local.get 3
                            i32.gt_u
                            br_if 0 (;@12;)
                            local.get 6
                            local.get 4
                            i32.load offset=4
                            i32.add
                            local.tee 6
                            local.get 3
                            i32.gt_u
                            br_if 3 (;@9;)
                          end
                          local.get 4
                          i32.load offset=8
                          local.set 4
                          br 0 (;@11;)
                        end
                      end
                      local.get 4
                      local.get 0
                      i32.store
                      local.get 4
                      local.get 4
                      i32.load offset=4
                      local.get 7
                      i32.add
                      i32.store offset=4
                      local.get 0
                      i32.const -8
                      local.get 0
                      i32.sub
                      i32.const 15
                      i32.and
                      i32.const 0
                      local.get 0
                      i32.const 8
                      i32.add
                      i32.const 15
                      i32.and
                      select
                      i32.add
                      local.tee 2
                      local.get 5
                      i32.const 3
                      i32.or
                      i32.store offset=4
                      local.get 6
                      i32.const -8
                      local.get 6
                      i32.sub
                      i32.const 15
                      i32.and
                      i32.const 0
                      local.get 6
                      i32.const 8
                      i32.add
                      i32.const 15
                      i32.and
                      select
                      i32.add
                      local.tee 7
                      local.get 2
                      local.get 5
                      i32.add
                      local.tee 5
                      i32.sub
                      local.set 4
                      block  ;; label = @10
                        local.get 7
                        local.get 3
                        i32.ne
                        br_if 0 (;@10;)
                        i32.const 0
                        local.get 5
                        i32.store offset=4672
                        i32.const 0
                        i32.const 0
                        i32.load offset=4660
                        local.get 4
                        i32.add
                        local.tee 4
                        i32.store offset=4660
                        local.get 5
                        local.get 4
                        i32.const 1
                        i32.or
                        i32.store offset=4
                        br 3 (;@7;)
                      end
                      block  ;; label = @10
                        local.get 7
                        i32.const 0
                        i32.load offset=4668
                        i32.ne
                        br_if 0 (;@10;)
                        i32.const 0
                        local.get 5
                        i32.store offset=4668
                        i32.const 0
                        i32.const 0
                        i32.load offset=4656
                        local.get 4
                        i32.add
                        local.tee 4
                        i32.store offset=4656
                        local.get 5
                        local.get 4
                        i32.const 1
                        i32.or
                        i32.store offset=4
                        local.get 5
                        local.get 4
                        i32.add
                        local.get 4
                        i32.store
                        br 3 (;@7;)
                      end
                      block  ;; label = @10
                        local.get 7
                        i32.load offset=4
                        local.tee 3
                        i32.const 3
                        i32.and
                        i32.const 1
                        i32.ne
                        br_if 0 (;@10;)
                        local.get 3
                        i32.const -8
                        i32.and
                        local.set 8
                        block  ;; label = @11
                          block  ;; label = @12
                            local.get 3
                            i32.const 255
                            i32.gt_u
                            br_if 0 (;@12;)
                            local.get 7
                            i32.load offset=8
                            local.tee 6
                            local.get 3
                            i32.const 3
                            i32.shr_u
                            local.tee 9
                            i32.const 3
                            i32.shl
                            i32.const 4688
                            i32.add
                            local.tee 0
                            i32.eq
                            drop
                            block  ;; label = @13
                              local.get 7
                              i32.load offset=12
                              local.tee 3
                              local.get 6
                              i32.ne
                              br_if 0 (;@13;)
                              i32.const 0
                              i32.const 0
                              i32.load offset=4648
                              i32.const -2
                              local.get 9
                              i32.rotl
                              i32.and
                              i32.store offset=4648
                              br 2 (;@11;)
                            end
                            local.get 3
                            local.get 0
                            i32.eq
                            drop
                            local.get 3
                            local.get 6
                            i32.store offset=8
                            local.get 6
                            local.get 3
                            i32.store offset=12
                            br 1 (;@11;)
                          end
                          local.get 7
                          i32.load offset=24
                          local.set 10
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 7
                              i32.load offset=12
                              local.tee 0
                              local.get 7
                              i32.eq
                              br_if 0 (;@13;)
                              local.get 7
                              i32.load offset=8
                              local.tee 3
                              local.get 9
                              i32.lt_u
                              drop
                              local.get 0
                              local.get 3
                              i32.store offset=8
                              local.get 3
                              local.get 0
                              i32.store offset=12
                              br 1 (;@12;)
                            end
                            block  ;; label = @13
                              local.get 7
                              i32.const 20
                              i32.add
                              local.tee 3
                              i32.load
                              local.tee 6
                              br_if 0 (;@13;)
                              local.get 7
                              i32.const 16
                              i32.add
                              local.tee 3
                              i32.load
                              local.tee 6
                              br_if 0 (;@13;)
                              i32.const 0
                              local.set 0
                              br 1 (;@12;)
                            end
                            loop  ;; label = @13
                              local.get 3
                              local.set 9
                              local.get 6
                              local.tee 0
                              i32.const 20
                              i32.add
                              local.tee 3
                              i32.load
                              local.tee 6
                              br_if 0 (;@13;)
                              local.get 0
                              i32.const 16
                              i32.add
                              local.set 3
                              local.get 0
                              i32.load offset=16
                              local.tee 6
                              br_if 0 (;@13;)
                            end
                            local.get 9
                            i32.const 0
                            i32.store
                          end
                          local.get 10
                          i32.eqz
                          br_if 0 (;@11;)
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 7
                              local.get 7
                              i32.load offset=28
                              local.tee 6
                              i32.const 2
                              i32.shl
                              i32.const 4952
                              i32.add
                              local.tee 3
                              i32.load
                              i32.ne
                              br_if 0 (;@13;)
                              local.get 3
                              local.get 0
                              i32.store
                              local.get 0
                              br_if 1 (;@12;)
                              i32.const 0
                              i32.const 0
                              i32.load offset=4652
                              i32.const -2
                              local.get 6
                              i32.rotl
                              i32.and
                              i32.store offset=4652
                              br 2 (;@11;)
                            end
                            local.get 10
                            i32.const 16
                            i32.const 20
                            local.get 10
                            i32.load offset=16
                            local.get 7
                            i32.eq
                            select
                            i32.add
                            local.get 0
                            i32.store
                            local.get 0
                            i32.eqz
                            br_if 1 (;@11;)
                          end
                          local.get 0
                          local.get 10
                          i32.store offset=24
                          block  ;; label = @12
                            local.get 7
                            i32.load offset=16
                            local.tee 3
                            i32.eqz
                            br_if 0 (;@12;)
                            local.get 0
                            local.get 3
                            i32.store offset=16
                            local.get 3
                            local.get 0
                            i32.store offset=24
                          end
                          local.get 7
                          i32.load offset=20
                          local.tee 3
                          i32.eqz
                          br_if 0 (;@11;)
                          local.get 0
                          i32.const 20
                          i32.add
                          local.get 3
                          i32.store
                          local.get 3
                          local.get 0
                          i32.store offset=24
                        end
                        local.get 8
                        local.get 4
                        i32.add
                        local.set 4
                        local.get 7
                        local.get 8
                        i32.add
                        local.tee 7
                        i32.load offset=4
                        local.set 3
                      end
                      local.get 7
                      local.get 3
                      i32.const -2
                      i32.and
                      i32.store offset=4
                      local.get 5
                      local.get 4
                      i32.add
                      local.get 4
                      i32.store
                      local.get 5
                      local.get 4
                      i32.const 1
                      i32.or
                      i32.store offset=4
                      block  ;; label = @10
                        local.get 4
                        i32.const 255
                        i32.gt_u
                        br_if 0 (;@10;)
                        local.get 4
                        i32.const -8
                        i32.and
                        i32.const 4688
                        i32.add
                        local.set 3
                        block  ;; label = @11
                          block  ;; label = @12
                            i32.const 0
                            i32.load offset=4648
                            local.tee 6
                            i32.const 1
                            local.get 4
                            i32.const 3
                            i32.shr_u
                            i32.shl
                            local.tee 4
                            i32.and
                            br_if 0 (;@12;)
                            i32.const 0
                            local.get 6
                            local.get 4
                            i32.or
                            i32.store offset=4648
                            local.get 3
                            local.set 4
                            br 1 (;@11;)
                          end
                          local.get 3
                          i32.load offset=8
                          local.set 4
                        end
                        local.get 4
                        local.get 5
                        i32.store offset=12
                        local.get 3
                        local.get 5
                        i32.store offset=8
                        local.get 5
                        local.get 3
                        i32.store offset=12
                        local.get 5
                        local.get 4
                        i32.store offset=8
                        br 3 (;@7;)
                      end
                      i32.const 31
                      local.set 3
                      block  ;; label = @10
                        local.get 4
                        i32.const 16777215
                        i32.gt_u
                        br_if 0 (;@10;)
                        local.get 4
                        i32.const 38
                        local.get 4
                        i32.const 8
                        i32.shr_u
                        i32.clz
                        local.tee 3
                        i32.sub
                        i32.shr_u
                        i32.const 1
                        i32.and
                        local.get 3
                        i32.const 1
                        i32.shl
                        i32.sub
                        i32.const 62
                        i32.add
                        local.set 3
                      end
                      local.get 5
                      local.get 3
                      i32.store offset=28
                      local.get 5
                      i64.const 0
                      i64.store offset=16 align=4
                      local.get 3
                      i32.const 2
                      i32.shl
                      i32.const 4952
                      i32.add
                      local.set 6
                      block  ;; label = @10
                        i32.const 0
                        i32.load offset=4652
                        local.tee 0
                        i32.const 1
                        local.get 3
                        i32.shl
                        local.tee 9
                        i32.and
                        br_if 0 (;@10;)
                        local.get 6
                        local.get 5
                        i32.store
                        i32.const 0
                        local.get 0
                        local.get 9
                        i32.or
                        i32.store offset=4652
                        local.get 5
                        local.get 6
                        i32.store offset=24
                        local.get 5
                        local.get 5
                        i32.store offset=8
                        local.get 5
                        local.get 5
                        i32.store offset=12
                        br 3 (;@7;)
                      end
                      local.get 4
                      i32.const 0
                      i32.const 25
                      local.get 3
                      i32.const 1
                      i32.shr_u
                      i32.sub
                      local.get 3
                      i32.const 31
                      i32.eq
                      select
                      i32.shl
                      local.set 3
                      local.get 6
                      i32.load
                      local.set 0
                      loop  ;; label = @10
                        local.get 0
                        local.tee 6
                        i32.load offset=4
                        i32.const -8
                        i32.and
                        local.get 4
                        i32.eq
                        br_if 2 (;@8;)
                        local.get 3
                        i32.const 29
                        i32.shr_u
                        local.set 0
                        local.get 3
                        i32.const 1
                        i32.shl
                        local.set 3
                        local.get 6
                        local.get 0
                        i32.const 4
                        i32.and
                        i32.add
                        i32.const 16
                        i32.add
                        local.tee 9
                        i32.load
                        local.tee 0
                        br_if 0 (;@10;)
                      end
                      local.get 9
                      local.get 5
                      i32.store
                      local.get 5
                      local.get 6
                      i32.store offset=24
                      local.get 5
                      local.get 5
                      i32.store offset=12
                      local.get 5
                      local.get 5
                      i32.store offset=8
                      br 2 (;@7;)
                    end
                    local.get 0
                    i32.const -8
                    local.get 0
                    i32.sub
                    i32.const 15
                    i32.and
                    i32.const 0
                    local.get 0
                    i32.const 8
                    i32.add
                    i32.const 15
                    i32.and
                    select
                    local.tee 4
                    i32.add
                    local.tee 2
                    local.get 7
                    i32.const -56
                    i32.add
                    local.tee 9
                    local.get 4
                    i32.sub
                    local.tee 4
                    i32.const 1
                    i32.or
                    i32.store offset=4
                    local.get 0
                    local.get 9
                    i32.add
                    i32.const 56
                    i32.store offset=4
                    local.get 3
                    local.get 6
                    i32.const 55
                    local.get 6
                    i32.sub
                    i32.const 15
                    i32.and
                    i32.const 0
                    local.get 6
                    i32.const -55
                    i32.add
                    i32.const 15
                    i32.and
                    select
                    i32.add
                    i32.const -63
                    i32.add
                    local.tee 9
                    local.get 9
                    local.get 3
                    i32.const 16
                    i32.add
                    i32.lt_u
                    select
                    local.tee 9
                    i32.const 35
                    i32.store offset=4
                    i32.const 0
                    i32.const 0
                    i32.load offset=5136
                    i32.store offset=4676
                    i32.const 0
                    local.get 4
                    i32.store offset=4660
                    i32.const 0
                    local.get 2
                    i32.store offset=4672
                    local.get 9
                    i32.const 16
                    i32.add
                    i32.const 0
                    i64.load offset=5104 align=4
                    i64.store align=4
                    local.get 9
                    i32.const 0
                    i64.load offset=5096 align=4
                    i64.store offset=8 align=4
                    i32.const 0
                    local.get 9
                    i32.const 8
                    i32.add
                    i32.store offset=5104
                    i32.const 0
                    local.get 7
                    i32.store offset=5100
                    i32.const 0
                    local.get 0
                    i32.store offset=5096
                    i32.const 0
                    i32.const 0
                    i32.store offset=5108
                    local.get 9
                    i32.const 36
                    i32.add
                    local.set 4
                    loop  ;; label = @9
                      local.get 4
                      i32.const 7
                      i32.store
                      local.get 4
                      i32.const 4
                      i32.add
                      local.tee 4
                      local.get 6
                      i32.lt_u
                      br_if 0 (;@9;)
                    end
                    local.get 9
                    local.get 3
                    i32.eq
                    br_if 3 (;@5;)
                    local.get 9
                    local.get 9
                    i32.load offset=4
                    i32.const -2
                    i32.and
                    i32.store offset=4
                    local.get 9
                    local.get 9
                    local.get 3
                    i32.sub
                    local.tee 0
                    i32.store
                    local.get 3
                    local.get 0
                    i32.const 1
                    i32.or
                    i32.store offset=4
                    block  ;; label = @9
                      local.get 0
                      i32.const 255
                      i32.gt_u
                      br_if 0 (;@9;)
                      local.get 0
                      i32.const -8
                      i32.and
                      i32.const 4688
                      i32.add
                      local.set 4
                      block  ;; label = @10
                        block  ;; label = @11
                          i32.const 0
                          i32.load offset=4648
                          local.tee 6
                          i32.const 1
                          local.get 0
                          i32.const 3
                          i32.shr_u
                          i32.shl
                          local.tee 0
                          i32.and
                          br_if 0 (;@11;)
                          i32.const 0
                          local.get 6
                          local.get 0
                          i32.or
                          i32.store offset=4648
                          local.get 4
                          local.set 6
                          br 1 (;@10;)
                        end
                        local.get 4
                        i32.load offset=8
                        local.set 6
                      end
                      local.get 6
                      local.get 3
                      i32.store offset=12
                      local.get 4
                      local.get 3
                      i32.store offset=8
                      local.get 3
                      local.get 4
                      i32.store offset=12
                      local.get 3
                      local.get 6
                      i32.store offset=8
                      br 4 (;@5;)
                    end
                    i32.const 31
                    local.set 4
                    block  ;; label = @9
                      local.get 0
                      i32.const 16777215
                      i32.gt_u
                      br_if 0 (;@9;)
                      local.get 0
                      i32.const 38
                      local.get 0
                      i32.const 8
                      i32.shr_u
                      i32.clz
                      local.tee 4
                      i32.sub
                      i32.shr_u
                      i32.const 1
                      i32.and
                      local.get 4
                      i32.const 1
                      i32.shl
                      i32.sub
                      i32.const 62
                      i32.add
                      local.set 4
                    end
                    local.get 3
                    local.get 4
                    i32.store offset=28
                    local.get 3
                    i64.const 0
                    i64.store offset=16 align=4
                    local.get 4
                    i32.const 2
                    i32.shl
                    i32.const 4952
                    i32.add
                    local.set 6
                    block  ;; label = @9
                      i32.const 0
                      i32.load offset=4652
                      local.tee 9
                      i32.const 1
                      local.get 4
                      i32.shl
                      local.tee 7
                      i32.and
                      br_if 0 (;@9;)
                      local.get 6
                      local.get 3
                      i32.store
                      i32.const 0
                      local.get 9
                      local.get 7
                      i32.or
                      i32.store offset=4652
                      local.get 3
                      local.get 6
                      i32.store offset=24
                      local.get 3
                      local.get 3
                      i32.store offset=8
                      local.get 3
                      local.get 3
                      i32.store offset=12
                      br 4 (;@5;)
                    end
                    local.get 0
                    i32.const 0
                    i32.const 25
                    local.get 4
                    i32.const 1
                    i32.shr_u
                    i32.sub
                    local.get 4
                    i32.const 31
                    i32.eq
                    select
                    i32.shl
                    local.set 4
                    local.get 6
                    i32.load
                    local.set 9
                    loop  ;; label = @9
                      local.get 9
                      local.tee 6
                      i32.load offset=4
                      i32.const -8
                      i32.and
                      local.get 0
                      i32.eq
                      br_if 3 (;@6;)
                      local.get 4
                      i32.const 29
                      i32.shr_u
                      local.set 9
                      local.get 4
                      i32.const 1
                      i32.shl
                      local.set 4
                      local.get 6
                      local.get 9
                      i32.const 4
                      i32.and
                      i32.add
                      i32.const 16
                      i32.add
                      local.tee 7
                      i32.load
                      local.tee 9
                      br_if 0 (;@9;)
                    end
                    local.get 7
                    local.get 3
                    i32.store
                    local.get 3
                    local.get 6
                    i32.store offset=24
                    local.get 3
                    local.get 3
                    i32.store offset=12
                    local.get 3
                    local.get 3
                    i32.store offset=8
                    br 3 (;@5;)
                  end
                  local.get 6
                  i32.load offset=8
                  local.tee 4
                  local.get 5
                  i32.store offset=12
                  local.get 6
                  local.get 5
                  i32.store offset=8
                  local.get 5
                  i32.const 0
                  i32.store offset=24
                  local.get 5
                  local.get 6
                  i32.store offset=12
                  local.get 5
                  local.get 4
                  i32.store offset=8
                end
                local.get 2
                i32.const 8
                i32.add
                local.set 4
                br 5 (;@1;)
              end
              local.get 6
              i32.load offset=8
              local.tee 4
              local.get 3
              i32.store offset=12
              local.get 6
              local.get 3
              i32.store offset=8
              local.get 3
              i32.const 0
              i32.store offset=24
              local.get 3
              local.get 6
              i32.store offset=12
              local.get 3
              local.get 4
              i32.store offset=8
            end
            i32.const 0
            i32.load offset=4660
            local.tee 4
            local.get 5
            i32.le_u
            br_if 0 (;@4;)
            i32.const 0
            i32.load offset=4672
            local.tee 3
            local.get 5
            i32.add
            local.tee 6
            local.get 4
            local.get 5
            i32.sub
            local.tee 4
            i32.const 1
            i32.or
            i32.store offset=4
            i32.const 0
            local.get 4
            i32.store offset=4660
            i32.const 0
            local.get 6
            i32.store offset=4672
            local.get 3
            local.get 5
            i32.const 3
            i32.or
            i32.store offset=4
            local.get 3
            i32.const 8
            i32.add
            local.set 4
            br 3 (;@1;)
          end
          i32.const 0
          local.set 4
          i32.const 0
          i32.const 48
          i32.store offset=4644
          br 2 (;@1;)
        end
        block  ;; label = @3
          local.get 2
          i32.eqz
          br_if 0 (;@3;)
          block  ;; label = @4
            block  ;; label = @5
              local.get 9
              local.get 9
              i32.load offset=28
              local.tee 6
              i32.const 2
              i32.shl
              i32.const 4952
              i32.add
              local.tee 4
              i32.load
              i32.ne
              br_if 0 (;@5;)
              local.get 4
              local.get 0
              i32.store
              local.get 0
              br_if 1 (;@4;)
              i32.const 0
              local.get 10
              i32.const -2
              local.get 6
              i32.rotl
              i32.and
              local.tee 10
              i32.store offset=4652
              br 2 (;@3;)
            end
            local.get 2
            i32.const 16
            i32.const 20
            local.get 2
            i32.load offset=16
            local.get 9
            i32.eq
            select
            i32.add
            local.get 0
            i32.store
            local.get 0
            i32.eqz
            br_if 1 (;@3;)
          end
          local.get 0
          local.get 2
          i32.store offset=24
          block  ;; label = @4
            local.get 9
            i32.load offset=16
            local.tee 4
            i32.eqz
            br_if 0 (;@4;)
            local.get 0
            local.get 4
            i32.store offset=16
            local.get 4
            local.get 0
            i32.store offset=24
          end
          local.get 9
          i32.const 20
          i32.add
          i32.load
          local.tee 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          i32.const 20
          i32.add
          local.get 4
          i32.store
          local.get 4
          local.get 0
          i32.store offset=24
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            i32.const 15
            i32.gt_u
            br_if 0 (;@4;)
            local.get 9
            local.get 3
            local.get 5
            i32.add
            local.tee 4
            i32.const 3
            i32.or
            i32.store offset=4
            local.get 9
            local.get 4
            i32.add
            local.tee 4
            local.get 4
            i32.load offset=4
            i32.const 1
            i32.or
            i32.store offset=4
            br 1 (;@3;)
          end
          local.get 9
          local.get 5
          i32.add
          local.tee 0
          local.get 3
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 9
          local.get 5
          i32.const 3
          i32.or
          i32.store offset=4
          local.get 0
          local.get 3
          i32.add
          local.get 3
          i32.store
          block  ;; label = @4
            local.get 3
            i32.const 255
            i32.gt_u
            br_if 0 (;@4;)
            local.get 3
            i32.const -8
            i32.and
            i32.const 4688
            i32.add
            local.set 4
            block  ;; label = @5
              block  ;; label = @6
                i32.const 0
                i32.load offset=4648
                local.tee 6
                i32.const 1
                local.get 3
                i32.const 3
                i32.shr_u
                i32.shl
                local.tee 3
                i32.and
                br_if 0 (;@6;)
                i32.const 0
                local.get 6
                local.get 3
                i32.or
                i32.store offset=4648
                local.get 4
                local.set 3
                br 1 (;@5;)
              end
              local.get 4
              i32.load offset=8
              local.set 3
            end
            local.get 3
            local.get 0
            i32.store offset=12
            local.get 4
            local.get 0
            i32.store offset=8
            local.get 0
            local.get 4
            i32.store offset=12
            local.get 0
            local.get 3
            i32.store offset=8
            br 1 (;@3;)
          end
          i32.const 31
          local.set 4
          block  ;; label = @4
            local.get 3
            i32.const 16777215
            i32.gt_u
            br_if 0 (;@4;)
            local.get 3
            i32.const 38
            local.get 3
            i32.const 8
            i32.shr_u
            i32.clz
            local.tee 4
            i32.sub
            i32.shr_u
            i32.const 1
            i32.and
            local.get 4
            i32.const 1
            i32.shl
            i32.sub
            i32.const 62
            i32.add
            local.set 4
          end
          local.get 0
          local.get 4
          i32.store offset=28
          local.get 0
          i64.const 0
          i64.store offset=16 align=4
          local.get 4
          i32.const 2
          i32.shl
          i32.const 4952
          i32.add
          local.set 6
          block  ;; label = @4
            local.get 10
            i32.const 1
            local.get 4
            i32.shl
            local.tee 5
            i32.and
            br_if 0 (;@4;)
            local.get 6
            local.get 0
            i32.store
            i32.const 0
            local.get 10
            local.get 5
            i32.or
            i32.store offset=4652
            local.get 0
            local.get 6
            i32.store offset=24
            local.get 0
            local.get 0
            i32.store offset=8
            local.get 0
            local.get 0
            i32.store offset=12
            br 1 (;@3;)
          end
          local.get 3
          i32.const 0
          i32.const 25
          local.get 4
          i32.const 1
          i32.shr_u
          i32.sub
          local.get 4
          i32.const 31
          i32.eq
          select
          i32.shl
          local.set 4
          local.get 6
          i32.load
          local.set 5
          block  ;; label = @4
            loop  ;; label = @5
              local.get 5
              local.tee 6
              i32.load offset=4
              i32.const -8
              i32.and
              local.get 3
              i32.eq
              br_if 1 (;@4;)
              local.get 4
              i32.const 29
              i32.shr_u
              local.set 5
              local.get 4
              i32.const 1
              i32.shl
              local.set 4
              local.get 6
              local.get 5
              i32.const 4
              i32.and
              i32.add
              i32.const 16
              i32.add
              local.tee 7
              i32.load
              local.tee 5
              br_if 0 (;@5;)
            end
            local.get 7
            local.get 0
            i32.store
            local.get 0
            local.get 6
            i32.store offset=24
            local.get 0
            local.get 0
            i32.store offset=12
            local.get 0
            local.get 0
            i32.store offset=8
            br 1 (;@3;)
          end
          local.get 6
          i32.load offset=8
          local.tee 4
          local.get 0
          i32.store offset=12
          local.get 6
          local.get 0
          i32.store offset=8
          local.get 0
          i32.const 0
          i32.store offset=24
          local.get 0
          local.get 6
          i32.store offset=12
          local.get 0
          local.get 4
          i32.store offset=8
        end
        local.get 9
        i32.const 8
        i32.add
        local.set 4
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 11
        i32.eqz
        br_if 0 (;@2;)
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            local.get 0
            i32.load offset=28
            local.tee 6
            i32.const 2
            i32.shl
            i32.const 4952
            i32.add
            local.tee 4
            i32.load
            i32.ne
            br_if 0 (;@4;)
            local.get 4
            local.get 9
            i32.store
            local.get 9
            br_if 1 (;@3;)
            i32.const 0
            local.get 10
            i32.const -2
            local.get 6
            i32.rotl
            i32.and
            i32.store offset=4652
            br 2 (;@2;)
          end
          local.get 11
          i32.const 16
          i32.const 20
          local.get 11
          i32.load offset=16
          local.get 0
          i32.eq
          select
          i32.add
          local.get 9
          i32.store
          local.get 9
          i32.eqz
          br_if 1 (;@2;)
        end
        local.get 9
        local.get 11
        i32.store offset=24
        block  ;; label = @3
          local.get 0
          i32.load offset=16
          local.tee 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 9
          local.get 4
          i32.store offset=16
          local.get 4
          local.get 9
          i32.store offset=24
        end
        local.get 0
        i32.const 20
        i32.add
        i32.load
        local.tee 4
        i32.eqz
        br_if 0 (;@2;)
        local.get 9
        i32.const 20
        i32.add
        local.get 4
        i32.store
        local.get 4
        local.get 9
        i32.store offset=24
      end
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.const 15
          i32.gt_u
          br_if 0 (;@3;)
          local.get 0
          local.get 3
          local.get 5
          i32.add
          local.tee 4
          i32.const 3
          i32.or
          i32.store offset=4
          local.get 0
          local.get 4
          i32.add
          local.tee 4
          local.get 4
          i32.load offset=4
          i32.const 1
          i32.or
          i32.store offset=4
          br 1 (;@2;)
        end
        local.get 0
        local.get 5
        i32.add
        local.tee 6
        local.get 3
        i32.const 1
        i32.or
        i32.store offset=4
        local.get 0
        local.get 5
        i32.const 3
        i32.or
        i32.store offset=4
        local.get 6
        local.get 3
        i32.add
        local.get 3
        i32.store
        block  ;; label = @3
          local.get 8
          i32.eqz
          br_if 0 (;@3;)
          local.get 8
          i32.const -8
          i32.and
          i32.const 4688
          i32.add
          local.set 5
          i32.const 0
          i32.load offset=4668
          local.set 4
          block  ;; label = @4
            block  ;; label = @5
              i32.const 1
              local.get 8
              i32.const 3
              i32.shr_u
              i32.shl
              local.tee 9
              local.get 7
              i32.and
              br_if 0 (;@5;)
              i32.const 0
              local.get 9
              local.get 7
              i32.or
              i32.store offset=4648
              local.get 5
              local.set 9
              br 1 (;@4;)
            end
            local.get 5
            i32.load offset=8
            local.set 9
          end
          local.get 9
          local.get 4
          i32.store offset=12
          local.get 5
          local.get 4
          i32.store offset=8
          local.get 4
          local.get 5
          i32.store offset=12
          local.get 4
          local.get 9
          i32.store offset=8
        end
        i32.const 0
        local.get 6
        i32.store offset=4668
        i32.const 0
        local.get 3
        i32.store offset=4656
      end
      local.get 0
      i32.const 8
      i32.add
      local.set 4
    end
    local.get 1
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 4)
  (func $free (type 8) (param i32)
    local.get 0
    call $dlfree)
  (func $dlfree (type 8) (param i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      local.get 0
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i32.const -8
      i32.add
      local.tee 1
      local.get 0
      i32.const -4
      i32.add
      i32.load
      local.tee 2
      i32.const -8
      i32.and
      local.tee 0
      i32.add
      local.set 3
      block  ;; label = @2
        local.get 2
        i32.const 1
        i32.and
        br_if 0 (;@2;)
        local.get 2
        i32.const 3
        i32.and
        i32.eqz
        br_if 1 (;@1;)
        local.get 1
        local.get 1
        i32.load
        local.tee 2
        i32.sub
        local.tee 1
        i32.const 0
        i32.load offset=4664
        local.tee 4
        i32.lt_u
        br_if 1 (;@1;)
        local.get 2
        local.get 0
        i32.add
        local.set 0
        block  ;; label = @3
          local.get 1
          i32.const 0
          i32.load offset=4668
          i32.eq
          br_if 0 (;@3;)
          block  ;; label = @4
            local.get 2
            i32.const 255
            i32.gt_u
            br_if 0 (;@4;)
            local.get 1
            i32.load offset=8
            local.tee 4
            local.get 2
            i32.const 3
            i32.shr_u
            local.tee 5
            i32.const 3
            i32.shl
            i32.const 4688
            i32.add
            local.tee 6
            i32.eq
            drop
            block  ;; label = @5
              local.get 1
              i32.load offset=12
              local.tee 2
              local.get 4
              i32.ne
              br_if 0 (;@5;)
              i32.const 0
              i32.const 0
              i32.load offset=4648
              i32.const -2
              local.get 5
              i32.rotl
              i32.and
              i32.store offset=4648
              br 3 (;@2;)
            end
            local.get 2
            local.get 6
            i32.eq
            drop
            local.get 2
            local.get 4
            i32.store offset=8
            local.get 4
            local.get 2
            i32.store offset=12
            br 2 (;@2;)
          end
          local.get 1
          i32.load offset=24
          local.set 7
          block  ;; label = @4
            block  ;; label = @5
              local.get 1
              i32.load offset=12
              local.tee 6
              local.get 1
              i32.eq
              br_if 0 (;@5;)
              local.get 1
              i32.load offset=8
              local.tee 2
              local.get 4
              i32.lt_u
              drop
              local.get 6
              local.get 2
              i32.store offset=8
              local.get 2
              local.get 6
              i32.store offset=12
              br 1 (;@4;)
            end
            block  ;; label = @5
              local.get 1
              i32.const 20
              i32.add
              local.tee 2
              i32.load
              local.tee 4
              br_if 0 (;@5;)
              local.get 1
              i32.const 16
              i32.add
              local.tee 2
              i32.load
              local.tee 4
              br_if 0 (;@5;)
              i32.const 0
              local.set 6
              br 1 (;@4;)
            end
            loop  ;; label = @5
              local.get 2
              local.set 5
              local.get 4
              local.tee 6
              i32.const 20
              i32.add
              local.tee 2
              i32.load
              local.tee 4
              br_if 0 (;@5;)
              local.get 6
              i32.const 16
              i32.add
              local.set 2
              local.get 6
              i32.load offset=16
              local.tee 4
              br_if 0 (;@5;)
            end
            local.get 5
            i32.const 0
            i32.store
          end
          local.get 7
          i32.eqz
          br_if 1 (;@2;)
          block  ;; label = @4
            block  ;; label = @5
              local.get 1
              local.get 1
              i32.load offset=28
              local.tee 4
              i32.const 2
              i32.shl
              i32.const 4952
              i32.add
              local.tee 2
              i32.load
              i32.ne
              br_if 0 (;@5;)
              local.get 2
              local.get 6
              i32.store
              local.get 6
              br_if 1 (;@4;)
              i32.const 0
              i32.const 0
              i32.load offset=4652
              i32.const -2
              local.get 4
              i32.rotl
              i32.and
              i32.store offset=4652
              br 3 (;@2;)
            end
            local.get 7
            i32.const 16
            i32.const 20
            local.get 7
            i32.load offset=16
            local.get 1
            i32.eq
            select
            i32.add
            local.get 6
            i32.store
            local.get 6
            i32.eqz
            br_if 2 (;@2;)
          end
          local.get 6
          local.get 7
          i32.store offset=24
          block  ;; label = @4
            local.get 1
            i32.load offset=16
            local.tee 2
            i32.eqz
            br_if 0 (;@4;)
            local.get 6
            local.get 2
            i32.store offset=16
            local.get 2
            local.get 6
            i32.store offset=24
          end
          local.get 1
          i32.load offset=20
          local.tee 2
          i32.eqz
          br_if 1 (;@2;)
          local.get 6
          i32.const 20
          i32.add
          local.get 2
          i32.store
          local.get 2
          local.get 6
          i32.store offset=24
          br 1 (;@2;)
        end
        local.get 3
        i32.load offset=4
        local.tee 2
        i32.const 3
        i32.and
        i32.const 3
        i32.ne
        br_if 0 (;@2;)
        local.get 3
        local.get 2
        i32.const -2
        i32.and
        i32.store offset=4
        i32.const 0
        local.get 0
        i32.store offset=4656
        local.get 1
        local.get 0
        i32.add
        local.get 0
        i32.store
        local.get 1
        local.get 0
        i32.const 1
        i32.or
        i32.store offset=4
        return
      end
      local.get 1
      local.get 3
      i32.ge_u
      br_if 0 (;@1;)
      local.get 3
      i32.load offset=4
      local.tee 2
      i32.const 1
      i32.and
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const 2
          i32.and
          br_if 0 (;@3;)
          block  ;; label = @4
            local.get 3
            i32.const 0
            i32.load offset=4672
            i32.ne
            br_if 0 (;@4;)
            i32.const 0
            local.get 1
            i32.store offset=4672
            i32.const 0
            i32.const 0
            i32.load offset=4660
            local.get 0
            i32.add
            local.tee 0
            i32.store offset=4660
            local.get 1
            local.get 0
            i32.const 1
            i32.or
            i32.store offset=4
            local.get 1
            i32.const 0
            i32.load offset=4668
            i32.ne
            br_if 3 (;@1;)
            i32.const 0
            i32.const 0
            i32.store offset=4656
            i32.const 0
            i32.const 0
            i32.store offset=4668
            return
          end
          block  ;; label = @4
            local.get 3
            i32.const 0
            i32.load offset=4668
            i32.ne
            br_if 0 (;@4;)
            i32.const 0
            local.get 1
            i32.store offset=4668
            i32.const 0
            i32.const 0
            i32.load offset=4656
            local.get 0
            i32.add
            local.tee 0
            i32.store offset=4656
            local.get 1
            local.get 0
            i32.const 1
            i32.or
            i32.store offset=4
            local.get 1
            local.get 0
            i32.add
            local.get 0
            i32.store
            return
          end
          local.get 2
          i32.const -8
          i32.and
          local.get 0
          i32.add
          local.set 0
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              i32.const 255
              i32.gt_u
              br_if 0 (;@5;)
              local.get 3
              i32.load offset=8
              local.tee 4
              local.get 2
              i32.const 3
              i32.shr_u
              local.tee 5
              i32.const 3
              i32.shl
              i32.const 4688
              i32.add
              local.tee 6
              i32.eq
              drop
              block  ;; label = @6
                local.get 3
                i32.load offset=12
                local.tee 2
                local.get 4
                i32.ne
                br_if 0 (;@6;)
                i32.const 0
                i32.const 0
                i32.load offset=4648
                i32.const -2
                local.get 5
                i32.rotl
                i32.and
                i32.store offset=4648
                br 2 (;@4;)
              end
              local.get 2
              local.get 6
              i32.eq
              drop
              local.get 2
              local.get 4
              i32.store offset=8
              local.get 4
              local.get 2
              i32.store offset=12
              br 1 (;@4;)
            end
            local.get 3
            i32.load offset=24
            local.set 7
            block  ;; label = @5
              block  ;; label = @6
                local.get 3
                i32.load offset=12
                local.tee 6
                local.get 3
                i32.eq
                br_if 0 (;@6;)
                local.get 3
                i32.load offset=8
                local.tee 2
                i32.const 0
                i32.load offset=4664
                i32.lt_u
                drop
                local.get 6
                local.get 2
                i32.store offset=8
                local.get 2
                local.get 6
                i32.store offset=12
                br 1 (;@5;)
              end
              block  ;; label = @6
                local.get 3
                i32.const 20
                i32.add
                local.tee 2
                i32.load
                local.tee 4
                br_if 0 (;@6;)
                local.get 3
                i32.const 16
                i32.add
                local.tee 2
                i32.load
                local.tee 4
                br_if 0 (;@6;)
                i32.const 0
                local.set 6
                br 1 (;@5;)
              end
              loop  ;; label = @6
                local.get 2
                local.set 5
                local.get 4
                local.tee 6
                i32.const 20
                i32.add
                local.tee 2
                i32.load
                local.tee 4
                br_if 0 (;@6;)
                local.get 6
                i32.const 16
                i32.add
                local.set 2
                local.get 6
                i32.load offset=16
                local.tee 4
                br_if 0 (;@6;)
              end
              local.get 5
              i32.const 0
              i32.store
            end
            local.get 7
            i32.eqz
            br_if 0 (;@4;)
            block  ;; label = @5
              block  ;; label = @6
                local.get 3
                local.get 3
                i32.load offset=28
                local.tee 4
                i32.const 2
                i32.shl
                i32.const 4952
                i32.add
                local.tee 2
                i32.load
                i32.ne
                br_if 0 (;@6;)
                local.get 2
                local.get 6
                i32.store
                local.get 6
                br_if 1 (;@5;)
                i32.const 0
                i32.const 0
                i32.load offset=4652
                i32.const -2
                local.get 4
                i32.rotl
                i32.and
                i32.store offset=4652
                br 2 (;@4;)
              end
              local.get 7
              i32.const 16
              i32.const 20
              local.get 7
              i32.load offset=16
              local.get 3
              i32.eq
              select
              i32.add
              local.get 6
              i32.store
              local.get 6
              i32.eqz
              br_if 1 (;@4;)
            end
            local.get 6
            local.get 7
            i32.store offset=24
            block  ;; label = @5
              local.get 3
              i32.load offset=16
              local.tee 2
              i32.eqz
              br_if 0 (;@5;)
              local.get 6
              local.get 2
              i32.store offset=16
              local.get 2
              local.get 6
              i32.store offset=24
            end
            local.get 3
            i32.load offset=20
            local.tee 2
            i32.eqz
            br_if 0 (;@4;)
            local.get 6
            i32.const 20
            i32.add
            local.get 2
            i32.store
            local.get 2
            local.get 6
            i32.store offset=24
          end
          local.get 1
          local.get 0
          i32.add
          local.get 0
          i32.store
          local.get 1
          local.get 0
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 1
          i32.const 0
          i32.load offset=4668
          i32.ne
          br_if 1 (;@2;)
          i32.const 0
          local.get 0
          i32.store offset=4656
          return
        end
        local.get 3
        local.get 2
        i32.const -2
        i32.and
        i32.store offset=4
        local.get 1
        local.get 0
        i32.add
        local.get 0
        i32.store
        local.get 1
        local.get 0
        i32.const 1
        i32.or
        i32.store offset=4
      end
      block  ;; label = @2
        local.get 0
        i32.const 255
        i32.gt_u
        br_if 0 (;@2;)
        local.get 0
        i32.const -8
        i32.and
        i32.const 4688
        i32.add
        local.set 2
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load offset=4648
            local.tee 4
            i32.const 1
            local.get 0
            i32.const 3
            i32.shr_u
            i32.shl
            local.tee 0
            i32.and
            br_if 0 (;@4;)
            i32.const 0
            local.get 4
            local.get 0
            i32.or
            i32.store offset=4648
            local.get 2
            local.set 0
            br 1 (;@3;)
          end
          local.get 2
          i32.load offset=8
          local.set 0
        end
        local.get 0
        local.get 1
        i32.store offset=12
        local.get 2
        local.get 1
        i32.store offset=8
        local.get 1
        local.get 2
        i32.store offset=12
        local.get 1
        local.get 0
        i32.store offset=8
        return
      end
      i32.const 31
      local.set 2
      block  ;; label = @2
        local.get 0
        i32.const 16777215
        i32.gt_u
        br_if 0 (;@2;)
        local.get 0
        i32.const 38
        local.get 0
        i32.const 8
        i32.shr_u
        i32.clz
        local.tee 2
        i32.sub
        i32.shr_u
        i32.const 1
        i32.and
        local.get 2
        i32.const 1
        i32.shl
        i32.sub
        i32.const 62
        i32.add
        local.set 2
      end
      local.get 1
      local.get 2
      i32.store offset=28
      local.get 1
      i64.const 0
      i64.store offset=16 align=4
      local.get 2
      i32.const 2
      i32.shl
      i32.const 4952
      i32.add
      local.set 4
      block  ;; label = @2
        block  ;; label = @3
          i32.const 0
          i32.load offset=4652
          local.tee 6
          i32.const 1
          local.get 2
          i32.shl
          local.tee 3
          i32.and
          br_if 0 (;@3;)
          local.get 4
          local.get 1
          i32.store
          i32.const 0
          local.get 6
          local.get 3
          i32.or
          i32.store offset=4652
          local.get 1
          local.get 4
          i32.store offset=24
          local.get 1
          local.get 1
          i32.store offset=8
          local.get 1
          local.get 1
          i32.store offset=12
          br 1 (;@2;)
        end
        local.get 0
        i32.const 0
        i32.const 25
        local.get 2
        i32.const 1
        i32.shr_u
        i32.sub
        local.get 2
        i32.const 31
        i32.eq
        select
        i32.shl
        local.set 2
        local.get 4
        i32.load
        local.set 6
        block  ;; label = @3
          loop  ;; label = @4
            local.get 6
            local.tee 4
            i32.load offset=4
            i32.const -8
            i32.and
            local.get 0
            i32.eq
            br_if 1 (;@3;)
            local.get 2
            i32.const 29
            i32.shr_u
            local.set 6
            local.get 2
            i32.const 1
            i32.shl
            local.set 2
            local.get 4
            local.get 6
            i32.const 4
            i32.and
            i32.add
            i32.const 16
            i32.add
            local.tee 3
            i32.load
            local.tee 6
            br_if 0 (;@4;)
          end
          local.get 3
          local.get 1
          i32.store
          local.get 1
          local.get 4
          i32.store offset=24
          local.get 1
          local.get 1
          i32.store offset=12
          local.get 1
          local.get 1
          i32.store offset=8
          br 1 (;@2;)
        end
        local.get 4
        i32.load offset=8
        local.tee 0
        local.get 1
        i32.store offset=12
        local.get 4
        local.get 1
        i32.store offset=8
        local.get 1
        i32.const 0
        i32.store offset=24
        local.get 1
        local.get 4
        i32.store offset=12
        local.get 1
        local.get 0
        i32.store offset=8
      end
      i32.const 0
      i32.const 0
      i32.load offset=4680
      i32.const -1
      i32.add
      local.tee 1
      i32.const -1
      local.get 1
      select
      i32.store offset=4680
    end)
  (func $calloc (type 4) (param i32 i32) (result i32)
    (local i32 i64)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        br_if 0 (;@2;)
        i32.const 0
        local.set 2
        br 1 (;@1;)
      end
      local.get 0
      i64.extend_i32_u
      local.get 1
      i64.extend_i32_u
      i64.mul
      local.tee 3
      i32.wrap_i64
      local.set 2
      local.get 1
      local.get 0
      i32.or
      i32.const 65536
      i32.lt_u
      br_if 0 (;@1;)
      i32.const -1
      local.get 2
      local.get 3
      i64.const 32
      i64.shr_u
      i32.wrap_i64
      i32.const 0
      i32.ne
      select
      local.set 2
    end
    block  ;; label = @1
      local.get 2
      call $dlmalloc
      local.tee 0
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i32.const -4
      i32.add
      i32.load8_u
      i32.const 3
      i32.and
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i32.const 0
      local.get 2
      call $memset
      drop
    end
    local.get 0)
  (func $realloc (type 4) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      local.get 0
      br_if 0 (;@1;)
      local.get 1
      call $dlmalloc
      return
    end
    block  ;; label = @1
      local.get 1
      i32.const -64
      i32.lt_u
      br_if 0 (;@1;)
      i32.const 0
      i32.const 48
      i32.store offset=4644
      i32.const 0
      return
    end
    i32.const 16
    local.get 1
    i32.const 19
    i32.add
    i32.const -16
    i32.and
    local.get 1
    i32.const 11
    i32.lt_u
    select
    local.set 2
    local.get 0
    i32.const -4
    i32.add
    local.tee 3
    i32.load
    local.tee 4
    i32.const -8
    i32.and
    local.set 5
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 4
          i32.const 3
          i32.and
          br_if 0 (;@3;)
          local.get 2
          i32.const 256
          i32.lt_u
          br_if 1 (;@2;)
          local.get 5
          local.get 2
          i32.const 4
          i32.or
          i32.lt_u
          br_if 1 (;@2;)
          local.get 5
          local.get 2
          i32.sub
          i32.const 0
          i32.load offset=5128
          i32.const 1
          i32.shl
          i32.le_u
          br_if 2 (;@1;)
          br 1 (;@2;)
        end
        local.get 0
        i32.const -8
        i32.add
        local.tee 6
        local.get 5
        i32.add
        local.set 7
        block  ;; label = @3
          local.get 5
          local.get 2
          i32.lt_u
          br_if 0 (;@3;)
          local.get 5
          local.get 2
          i32.sub
          local.tee 1
          i32.const 16
          i32.lt_u
          br_if 2 (;@1;)
          local.get 3
          local.get 2
          local.get 4
          i32.const 1
          i32.and
          i32.or
          i32.const 2
          i32.or
          i32.store
          local.get 6
          local.get 2
          i32.add
          local.tee 2
          local.get 1
          i32.const 3
          i32.or
          i32.store offset=4
          local.get 7
          local.get 7
          i32.load offset=4
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 2
          local.get 1
          call $dispose_chunk
          local.get 0
          return
        end
        block  ;; label = @3
          local.get 7
          i32.const 0
          i32.load offset=4672
          i32.ne
          br_if 0 (;@3;)
          i32.const 0
          i32.load offset=4660
          local.get 5
          i32.add
          local.tee 5
          local.get 2
          i32.le_u
          br_if 1 (;@2;)
          local.get 3
          local.get 2
          local.get 4
          i32.const 1
          i32.and
          i32.or
          i32.const 2
          i32.or
          i32.store
          i32.const 0
          local.get 6
          local.get 2
          i32.add
          local.tee 1
          i32.store offset=4672
          i32.const 0
          local.get 5
          local.get 2
          i32.sub
          local.tee 2
          i32.store offset=4660
          local.get 1
          local.get 2
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 0
          return
        end
        block  ;; label = @3
          local.get 7
          i32.const 0
          i32.load offset=4668
          i32.ne
          br_if 0 (;@3;)
          i32.const 0
          i32.load offset=4656
          local.get 5
          i32.add
          local.tee 5
          local.get 2
          i32.lt_u
          br_if 1 (;@2;)
          block  ;; label = @4
            block  ;; label = @5
              local.get 5
              local.get 2
              i32.sub
              local.tee 1
              i32.const 16
              i32.lt_u
              br_if 0 (;@5;)
              local.get 3
              local.get 2
              local.get 4
              i32.const 1
              i32.and
              i32.or
              i32.const 2
              i32.or
              i32.store
              local.get 6
              local.get 2
              i32.add
              local.tee 2
              local.get 1
              i32.const 1
              i32.or
              i32.store offset=4
              local.get 6
              local.get 5
              i32.add
              local.tee 5
              local.get 1
              i32.store
              local.get 5
              local.get 5
              i32.load offset=4
              i32.const -2
              i32.and
              i32.store offset=4
              br 1 (;@4;)
            end
            local.get 3
            local.get 4
            i32.const 1
            i32.and
            local.get 5
            i32.or
            i32.const 2
            i32.or
            i32.store
            local.get 6
            local.get 5
            i32.add
            local.tee 1
            local.get 1
            i32.load offset=4
            i32.const 1
            i32.or
            i32.store offset=4
            i32.const 0
            local.set 1
            i32.const 0
            local.set 2
          end
          i32.const 0
          local.get 2
          i32.store offset=4668
          i32.const 0
          local.get 1
          i32.store offset=4656
          local.get 0
          return
        end
        local.get 7
        i32.load offset=4
        local.tee 8
        i32.const 2
        i32.and
        br_if 0 (;@2;)
        local.get 8
        i32.const -8
        i32.and
        local.get 5
        i32.add
        local.tee 9
        local.get 2
        i32.lt_u
        br_if 0 (;@2;)
        local.get 9
        local.get 2
        i32.sub
        local.set 10
        block  ;; label = @3
          block  ;; label = @4
            local.get 8
            i32.const 255
            i32.gt_u
            br_if 0 (;@4;)
            local.get 7
            i32.load offset=8
            local.tee 1
            local.get 8
            i32.const 3
            i32.shr_u
            local.tee 11
            i32.const 3
            i32.shl
            i32.const 4688
            i32.add
            local.tee 8
            i32.eq
            drop
            block  ;; label = @5
              local.get 7
              i32.load offset=12
              local.tee 5
              local.get 1
              i32.ne
              br_if 0 (;@5;)
              i32.const 0
              i32.const 0
              i32.load offset=4648
              i32.const -2
              local.get 11
              i32.rotl
              i32.and
              i32.store offset=4648
              br 2 (;@3;)
            end
            local.get 5
            local.get 8
            i32.eq
            drop
            local.get 5
            local.get 1
            i32.store offset=8
            local.get 1
            local.get 5
            i32.store offset=12
            br 1 (;@3;)
          end
          local.get 7
          i32.load offset=24
          local.set 12
          block  ;; label = @4
            block  ;; label = @5
              local.get 7
              i32.load offset=12
              local.tee 8
              local.get 7
              i32.eq
              br_if 0 (;@5;)
              local.get 7
              i32.load offset=8
              local.tee 1
              i32.const 0
              i32.load offset=4664
              i32.lt_u
              drop
              local.get 8
              local.get 1
              i32.store offset=8
              local.get 1
              local.get 8
              i32.store offset=12
              br 1 (;@4;)
            end
            block  ;; label = @5
              local.get 7
              i32.const 20
              i32.add
              local.tee 1
              i32.load
              local.tee 5
              br_if 0 (;@5;)
              local.get 7
              i32.const 16
              i32.add
              local.tee 1
              i32.load
              local.tee 5
              br_if 0 (;@5;)
              i32.const 0
              local.set 8
              br 1 (;@4;)
            end
            loop  ;; label = @5
              local.get 1
              local.set 11
              local.get 5
              local.tee 8
              i32.const 20
              i32.add
              local.tee 1
              i32.load
              local.tee 5
              br_if 0 (;@5;)
              local.get 8
              i32.const 16
              i32.add
              local.set 1
              local.get 8
              i32.load offset=16
              local.tee 5
              br_if 0 (;@5;)
            end
            local.get 11
            i32.const 0
            i32.store
          end
          local.get 12
          i32.eqz
          br_if 0 (;@3;)
          block  ;; label = @4
            block  ;; label = @5
              local.get 7
              local.get 7
              i32.load offset=28
              local.tee 5
              i32.const 2
              i32.shl
              i32.const 4952
              i32.add
              local.tee 1
              i32.load
              i32.ne
              br_if 0 (;@5;)
              local.get 1
              local.get 8
              i32.store
              local.get 8
              br_if 1 (;@4;)
              i32.const 0
              i32.const 0
              i32.load offset=4652
              i32.const -2
              local.get 5
              i32.rotl
              i32.and
              i32.store offset=4652
              br 2 (;@3;)
            end
            local.get 12
            i32.const 16
            i32.const 20
            local.get 12
            i32.load offset=16
            local.get 7
            i32.eq
            select
            i32.add
            local.get 8
            i32.store
            local.get 8
            i32.eqz
            br_if 1 (;@3;)
          end
          local.get 8
          local.get 12
          i32.store offset=24
          block  ;; label = @4
            local.get 7
            i32.load offset=16
            local.tee 1
            i32.eqz
            br_if 0 (;@4;)
            local.get 8
            local.get 1
            i32.store offset=16
            local.get 1
            local.get 8
            i32.store offset=24
          end
          local.get 7
          i32.load offset=20
          local.tee 1
          i32.eqz
          br_if 0 (;@3;)
          local.get 8
          i32.const 20
          i32.add
          local.get 1
          i32.store
          local.get 1
          local.get 8
          i32.store offset=24
        end
        block  ;; label = @3
          local.get 10
          i32.const 15
          i32.gt_u
          br_if 0 (;@3;)
          local.get 3
          local.get 4
          i32.const 1
          i32.and
          local.get 9
          i32.or
          i32.const 2
          i32.or
          i32.store
          local.get 6
          local.get 9
          i32.add
          local.tee 1
          local.get 1
          i32.load offset=4
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 0
          return
        end
        local.get 3
        local.get 2
        local.get 4
        i32.const 1
        i32.and
        i32.or
        i32.const 2
        i32.or
        i32.store
        local.get 6
        local.get 2
        i32.add
        local.tee 1
        local.get 10
        i32.const 3
        i32.or
        i32.store offset=4
        local.get 6
        local.get 9
        i32.add
        local.tee 2
        local.get 2
        i32.load offset=4
        i32.const 1
        i32.or
        i32.store offset=4
        local.get 1
        local.get 10
        call $dispose_chunk
        local.get 0
        return
      end
      block  ;; label = @2
        local.get 1
        call $dlmalloc
        local.tee 2
        br_if 0 (;@2;)
        i32.const 0
        return
      end
      local.get 2
      local.get 0
      i32.const -4
      i32.const -8
      local.get 3
      i32.load
      local.tee 5
      i32.const 3
      i32.and
      select
      local.get 5
      i32.const -8
      i32.and
      i32.add
      local.tee 5
      local.get 1
      local.get 5
      local.get 1
      i32.lt_u
      select
      call $memcpy
      local.set 1
      local.get 0
      call $dlfree
      local.get 1
      local.set 0
    end
    local.get 0)
  (func $dispose_chunk (type 14) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32)
    local.get 0
    local.get 1
    i32.add
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load offset=4
        local.tee 3
        i32.const 1
        i32.and
        br_if 0 (;@2;)
        local.get 3
        i32.const 3
        i32.and
        i32.eqz
        br_if 1 (;@1;)
        local.get 0
        i32.load
        local.tee 3
        local.get 1
        i32.add
        local.set 1
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            local.get 3
            i32.sub
            local.tee 0
            i32.const 0
            i32.load offset=4668
            i32.eq
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 3
              i32.const 255
              i32.gt_u
              br_if 0 (;@5;)
              local.get 0
              i32.load offset=8
              local.tee 4
              local.get 3
              i32.const 3
              i32.shr_u
              local.tee 5
              i32.const 3
              i32.shl
              i32.const 4688
              i32.add
              local.tee 6
              i32.eq
              drop
              local.get 0
              i32.load offset=12
              local.tee 3
              local.get 4
              i32.ne
              br_if 2 (;@3;)
              i32.const 0
              i32.const 0
              i32.load offset=4648
              i32.const -2
              local.get 5
              i32.rotl
              i32.and
              i32.store offset=4648
              br 3 (;@2;)
            end
            local.get 0
            i32.load offset=24
            local.set 7
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.load offset=12
                local.tee 6
                local.get 0
                i32.eq
                br_if 0 (;@6;)
                local.get 0
                i32.load offset=8
                local.tee 3
                i32.const 0
                i32.load offset=4664
                i32.lt_u
                drop
                local.get 6
                local.get 3
                i32.store offset=8
                local.get 3
                local.get 6
                i32.store offset=12
                br 1 (;@5;)
              end
              block  ;; label = @6
                local.get 0
                i32.const 20
                i32.add
                local.tee 3
                i32.load
                local.tee 4
                br_if 0 (;@6;)
                local.get 0
                i32.const 16
                i32.add
                local.tee 3
                i32.load
                local.tee 4
                br_if 0 (;@6;)
                i32.const 0
                local.set 6
                br 1 (;@5;)
              end
              loop  ;; label = @6
                local.get 3
                local.set 5
                local.get 4
                local.tee 6
                i32.const 20
                i32.add
                local.tee 3
                i32.load
                local.tee 4
                br_if 0 (;@6;)
                local.get 6
                i32.const 16
                i32.add
                local.set 3
                local.get 6
                i32.load offset=16
                local.tee 4
                br_if 0 (;@6;)
              end
              local.get 5
              i32.const 0
              i32.store
            end
            local.get 7
            i32.eqz
            br_if 2 (;@2;)
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                local.get 0
                i32.load offset=28
                local.tee 4
                i32.const 2
                i32.shl
                i32.const 4952
                i32.add
                local.tee 3
                i32.load
                i32.ne
                br_if 0 (;@6;)
                local.get 3
                local.get 6
                i32.store
                local.get 6
                br_if 1 (;@5;)
                i32.const 0
                i32.const 0
                i32.load offset=4652
                i32.const -2
                local.get 4
                i32.rotl
                i32.and
                i32.store offset=4652
                br 4 (;@2;)
              end
              local.get 7
              i32.const 16
              i32.const 20
              local.get 7
              i32.load offset=16
              local.get 0
              i32.eq
              select
              i32.add
              local.get 6
              i32.store
              local.get 6
              i32.eqz
              br_if 3 (;@2;)
            end
            local.get 6
            local.get 7
            i32.store offset=24
            block  ;; label = @5
              local.get 0
              i32.load offset=16
              local.tee 3
              i32.eqz
              br_if 0 (;@5;)
              local.get 6
              local.get 3
              i32.store offset=16
              local.get 3
              local.get 6
              i32.store offset=24
            end
            local.get 0
            i32.load offset=20
            local.tee 3
            i32.eqz
            br_if 2 (;@2;)
            local.get 6
            i32.const 20
            i32.add
            local.get 3
            i32.store
            local.get 3
            local.get 6
            i32.store offset=24
            br 2 (;@2;)
          end
          local.get 2
          i32.load offset=4
          local.tee 3
          i32.const 3
          i32.and
          i32.const 3
          i32.ne
          br_if 1 (;@2;)
          local.get 2
          local.get 3
          i32.const -2
          i32.and
          i32.store offset=4
          i32.const 0
          local.get 1
          i32.store offset=4656
          local.get 2
          local.get 1
          i32.store
          local.get 0
          local.get 1
          i32.const 1
          i32.or
          i32.store offset=4
          return
        end
        local.get 3
        local.get 6
        i32.eq
        drop
        local.get 3
        local.get 4
        i32.store offset=8
        local.get 4
        local.get 3
        i32.store offset=12
      end
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.load offset=4
          local.tee 3
          i32.const 2
          i32.and
          br_if 0 (;@3;)
          block  ;; label = @4
            local.get 2
            i32.const 0
            i32.load offset=4672
            i32.ne
            br_if 0 (;@4;)
            i32.const 0
            local.get 0
            i32.store offset=4672
            i32.const 0
            i32.const 0
            i32.load offset=4660
            local.get 1
            i32.add
            local.tee 1
            i32.store offset=4660
            local.get 0
            local.get 1
            i32.const 1
            i32.or
            i32.store offset=4
            local.get 0
            i32.const 0
            i32.load offset=4668
            i32.ne
            br_if 3 (;@1;)
            i32.const 0
            i32.const 0
            i32.store offset=4656
            i32.const 0
            i32.const 0
            i32.store offset=4668
            return
          end
          block  ;; label = @4
            local.get 2
            i32.const 0
            i32.load offset=4668
            i32.ne
            br_if 0 (;@4;)
            i32.const 0
            local.get 0
            i32.store offset=4668
            i32.const 0
            i32.const 0
            i32.load offset=4656
            local.get 1
            i32.add
            local.tee 1
            i32.store offset=4656
            local.get 0
            local.get 1
            i32.const 1
            i32.or
            i32.store offset=4
            local.get 0
            local.get 1
            i32.add
            local.get 1
            i32.store
            return
          end
          local.get 3
          i32.const -8
          i32.and
          local.get 1
          i32.add
          local.set 1
          block  ;; label = @4
            block  ;; label = @5
              local.get 3
              i32.const 255
              i32.gt_u
              br_if 0 (;@5;)
              local.get 2
              i32.load offset=8
              local.tee 4
              local.get 3
              i32.const 3
              i32.shr_u
              local.tee 5
              i32.const 3
              i32.shl
              i32.const 4688
              i32.add
              local.tee 6
              i32.eq
              drop
              block  ;; label = @6
                local.get 2
                i32.load offset=12
                local.tee 3
                local.get 4
                i32.ne
                br_if 0 (;@6;)
                i32.const 0
                i32.const 0
                i32.load offset=4648
                i32.const -2
                local.get 5
                i32.rotl
                i32.and
                i32.store offset=4648
                br 2 (;@4;)
              end
              local.get 3
              local.get 6
              i32.eq
              drop
              local.get 3
              local.get 4
              i32.store offset=8
              local.get 4
              local.get 3
              i32.store offset=12
              br 1 (;@4;)
            end
            local.get 2
            i32.load offset=24
            local.set 7
            block  ;; label = @5
              block  ;; label = @6
                local.get 2
                i32.load offset=12
                local.tee 6
                local.get 2
                i32.eq
                br_if 0 (;@6;)
                local.get 2
                i32.load offset=8
                local.tee 3
                i32.const 0
                i32.load offset=4664
                i32.lt_u
                drop
                local.get 6
                local.get 3
                i32.store offset=8
                local.get 3
                local.get 6
                i32.store offset=12
                br 1 (;@5;)
              end
              block  ;; label = @6
                local.get 2
                i32.const 20
                i32.add
                local.tee 4
                i32.load
                local.tee 3
                br_if 0 (;@6;)
                local.get 2
                i32.const 16
                i32.add
                local.tee 4
                i32.load
                local.tee 3
                br_if 0 (;@6;)
                i32.const 0
                local.set 6
                br 1 (;@5;)
              end
              loop  ;; label = @6
                local.get 4
                local.set 5
                local.get 3
                local.tee 6
                i32.const 20
                i32.add
                local.tee 4
                i32.load
                local.tee 3
                br_if 0 (;@6;)
                local.get 6
                i32.const 16
                i32.add
                local.set 4
                local.get 6
                i32.load offset=16
                local.tee 3
                br_if 0 (;@6;)
              end
              local.get 5
              i32.const 0
              i32.store
            end
            local.get 7
            i32.eqz
            br_if 0 (;@4;)
            block  ;; label = @5
              block  ;; label = @6
                local.get 2
                local.get 2
                i32.load offset=28
                local.tee 4
                i32.const 2
                i32.shl
                i32.const 4952
                i32.add
                local.tee 3
                i32.load
                i32.ne
                br_if 0 (;@6;)
                local.get 3
                local.get 6
                i32.store
                local.get 6
                br_if 1 (;@5;)
                i32.const 0
                i32.const 0
                i32.load offset=4652
                i32.const -2
                local.get 4
                i32.rotl
                i32.and
                i32.store offset=4652
                br 2 (;@4;)
              end
              local.get 7
              i32.const 16
              i32.const 20
              local.get 7
              i32.load offset=16
              local.get 2
              i32.eq
              select
              i32.add
              local.get 6
              i32.store
              local.get 6
              i32.eqz
              br_if 1 (;@4;)
            end
            local.get 6
            local.get 7
            i32.store offset=24
            block  ;; label = @5
              local.get 2
              i32.load offset=16
              local.tee 3
              i32.eqz
              br_if 0 (;@5;)
              local.get 6
              local.get 3
              i32.store offset=16
              local.get 3
              local.get 6
              i32.store offset=24
            end
            local.get 2
            i32.load offset=20
            local.tee 3
            i32.eqz
            br_if 0 (;@4;)
            local.get 6
            i32.const 20
            i32.add
            local.get 3
            i32.store
            local.get 3
            local.get 6
            i32.store offset=24
          end
          local.get 0
          local.get 1
          i32.add
          local.get 1
          i32.store
          local.get 0
          local.get 1
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 0
          i32.const 0
          i32.load offset=4668
          i32.ne
          br_if 1 (;@2;)
          i32.const 0
          local.get 1
          i32.store offset=4656
          return
        end
        local.get 2
        local.get 3
        i32.const -2
        i32.and
        i32.store offset=4
        local.get 0
        local.get 1
        i32.add
        local.get 1
        i32.store
        local.get 0
        local.get 1
        i32.const 1
        i32.or
        i32.store offset=4
      end
      block  ;; label = @2
        local.get 1
        i32.const 255
        i32.gt_u
        br_if 0 (;@2;)
        local.get 1
        i32.const -8
        i32.and
        i32.const 4688
        i32.add
        local.set 3
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load offset=4648
            local.tee 4
            i32.const 1
            local.get 1
            i32.const 3
            i32.shr_u
            i32.shl
            local.tee 1
            i32.and
            br_if 0 (;@4;)
            i32.const 0
            local.get 4
            local.get 1
            i32.or
            i32.store offset=4648
            local.get 3
            local.set 1
            br 1 (;@3;)
          end
          local.get 3
          i32.load offset=8
          local.set 1
        end
        local.get 1
        local.get 0
        i32.store offset=12
        local.get 3
        local.get 0
        i32.store offset=8
        local.get 0
        local.get 3
        i32.store offset=12
        local.get 0
        local.get 1
        i32.store offset=8
        return
      end
      i32.const 31
      local.set 3
      block  ;; label = @2
        local.get 1
        i32.const 16777215
        i32.gt_u
        br_if 0 (;@2;)
        local.get 1
        i32.const 38
        local.get 1
        i32.const 8
        i32.shr_u
        i32.clz
        local.tee 3
        i32.sub
        i32.shr_u
        i32.const 1
        i32.and
        local.get 3
        i32.const 1
        i32.shl
        i32.sub
        i32.const 62
        i32.add
        local.set 3
      end
      local.get 0
      local.get 3
      i32.store offset=28
      local.get 0
      i64.const 0
      i64.store offset=16 align=4
      local.get 3
      i32.const 2
      i32.shl
      i32.const 4952
      i32.add
      local.set 4
      block  ;; label = @2
        i32.const 0
        i32.load offset=4652
        local.tee 6
        i32.const 1
        local.get 3
        i32.shl
        local.tee 2
        i32.and
        br_if 0 (;@2;)
        local.get 4
        local.get 0
        i32.store
        i32.const 0
        local.get 6
        local.get 2
        i32.or
        i32.store offset=4652
        local.get 0
        local.get 4
        i32.store offset=24
        local.get 0
        local.get 0
        i32.store offset=8
        local.get 0
        local.get 0
        i32.store offset=12
        return
      end
      local.get 1
      i32.const 0
      i32.const 25
      local.get 3
      i32.const 1
      i32.shr_u
      i32.sub
      local.get 3
      i32.const 31
      i32.eq
      select
      i32.shl
      local.set 3
      local.get 4
      i32.load
      local.set 6
      block  ;; label = @2
        loop  ;; label = @3
          local.get 6
          local.tee 4
          i32.load offset=4
          i32.const -8
          i32.and
          local.get 1
          i32.eq
          br_if 1 (;@2;)
          local.get 3
          i32.const 29
          i32.shr_u
          local.set 6
          local.get 3
          i32.const 1
          i32.shl
          local.set 3
          local.get 4
          local.get 6
          i32.const 4
          i32.and
          i32.add
          i32.const 16
          i32.add
          local.tee 2
          i32.load
          local.tee 6
          br_if 0 (;@3;)
        end
        local.get 2
        local.get 0
        i32.store
        local.get 0
        local.get 4
        i32.store offset=24
        local.get 0
        local.get 0
        i32.store offset=12
        local.get 0
        local.get 0
        i32.store offset=8
        return
      end
      local.get 4
      i32.load offset=8
      local.tee 1
      local.get 0
      i32.store offset=12
      local.get 4
      local.get 0
      i32.store offset=8
      local.get 0
      i32.const 0
      i32.store offset=24
      local.get 0
      local.get 4
      i32.store offset=12
      local.get 0
      local.get 1
      i32.store offset=8
    end)
  (func $dummy.1 (type 8) (param i32))
  (func $fclose (type 0) (param i32) (result i32)
    (local i32 i32 i32 i32 i32)
    local.get 0
    call $fflush
    local.set 1
    local.get 0
    local.get 0
    i32.load offset=12
    call_indirect (type 0)
    local.set 2
    block  ;; label = @1
      local.get 0
      i32.load8_u
      i32.const 1
      i32.and
      br_if 0 (;@1;)
      local.get 0
      call $dummy.1
      call $__ofl_lock
      local.set 3
      block  ;; label = @2
        local.get 0
        i32.load offset=48
        local.tee 4
        i32.eqz
        br_if 0 (;@2;)
        local.get 4
        local.get 0
        i32.load offset=52
        i32.store offset=52
      end
      block  ;; label = @2
        local.get 0
        i32.load offset=52
        local.tee 5
        i32.eqz
        br_if 0 (;@2;)
        local.get 5
        local.get 4
        i32.store offset=48
      end
      block  ;; label = @2
        local.get 3
        i32.load
        local.get 0
        i32.ne
        br_if 0 (;@2;)
        local.get 3
        local.get 5
        i32.store
      end
      call $__ofl_unlock
      local.get 0
      i32.load offset=80
      call $free
      local.get 0
      call $free
    end
    local.get 2
    local.get 1
    i32.or)
  (func $fflush (type 0) (param i32) (result i32)
    (local i32 i32 i32)
    block  ;; label = @1
      local.get 0
      br_if 0 (;@1;)
      i32.const 0
      local.set 1
      block  ;; label = @2
        i32.const 0
        i32.load offset=4384
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        i32.load offset=4384
        call $fflush
        local.set 1
      end
      block  ;; label = @2
        i32.const 0
        i32.load offset=4504
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        i32.load offset=4504
        call $fflush
        local.get 1
        i32.or
        local.set 1
      end
      block  ;; label = @2
        call $__ofl_lock
        i32.load
        local.tee 0
        i32.eqz
        br_if 0 (;@2;)
        loop  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.load offset=20
            local.get 0
            i32.load offset=24
            i32.eq
            br_if 0 (;@4;)
            local.get 0
            i32.const 0
            i32.const 0
            local.get 0
            i32.load offset=32
            call_indirect (type 2)
            drop
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.load offset=20
                br_if 0 (;@6;)
                i32.const -1
                local.set 2
                br 1 (;@5;)
              end
              block  ;; label = @6
                local.get 0
                i32.load offset=4
                local.tee 2
                local.get 0
                i32.load offset=8
                local.tee 3
                i32.eq
                br_if 0 (;@6;)
                local.get 0
                local.get 2
                local.get 3
                i32.sub
                i64.extend_i32_s
                i32.const 1
                local.get 0
                i32.load offset=36
                call_indirect (type 3)
                drop
              end
              i32.const 0
              local.set 2
              local.get 0
              i32.const 0
              i32.store offset=24
              local.get 0
              i64.const 0
              i64.store offset=16
              local.get 0
              i64.const 0
              i64.store offset=4 align=4
            end
            local.get 2
            local.get 1
            i32.or
            local.set 1
          end
          local.get 0
          i32.load offset=52
          local.tee 0
          br_if 0 (;@3;)
        end
      end
      call $__ofl_unlock
      local.get 1
      return
    end
    block  ;; label = @1
      local.get 0
      i32.load offset=20
      local.get 0
      i32.load offset=24
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      i32.const 0
      i32.const 0
      local.get 0
      i32.load offset=32
      call_indirect (type 2)
      drop
      local.get 0
      i32.load offset=20
      br_if 0 (;@1;)
      i32.const -1
      return
    end
    block  ;; label = @1
      local.get 0
      i32.load offset=4
      local.tee 1
      local.get 0
      i32.load offset=8
      local.tee 2
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      local.get 2
      i32.sub
      i64.extend_i32_s
      i32.const 1
      local.get 0
      i32.load offset=36
      call_indirect (type 3)
      drop
    end
    local.get 0
    i32.const 0
    i32.store offset=24
    local.get 0
    i64.const 0
    i64.store offset=16
    local.get 0
    i64.const 0
    i64.store offset=4 align=4
    i32.const 0)
  (func $__stdio_exit (type 1)
    (local i32 i32 i32)
    block  ;; label = @1
      call $__ofl_lock
      i32.load
      local.tee 0
      i32.eqz
      br_if 0 (;@1;)
      loop  ;; label = @2
        block  ;; label = @3
          local.get 0
          i32.load offset=20
          local.get 0
          i32.load offset=24
          i32.eq
          br_if 0 (;@3;)
          local.get 0
          i32.const 0
          i32.const 0
          local.get 0
          i32.load offset=32
          call_indirect (type 2)
          drop
        end
        block  ;; label = @3
          local.get 0
          i32.load offset=4
          local.tee 1
          local.get 0
          i32.load offset=8
          local.tee 2
          i32.eq
          br_if 0 (;@3;)
          local.get 0
          local.get 1
          local.get 2
          i32.sub
          i64.extend_i32_s
          i32.const 1
          local.get 0
          i32.load offset=36
          call_indirect (type 3)
          drop
        end
        local.get 0
        i32.load offset=52
        local.tee 0
        br_if 0 (;@2;)
      end
    end
    block  ;; label = @1
      i32.const 0
      i32.load offset=4624
      local.tee 0
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 0
        i32.load offset=20
        local.get 0
        i32.load offset=24
        i32.eq
        br_if 0 (;@2;)
        local.get 0
        i32.const 0
        i32.const 0
        local.get 0
        i32.load offset=32
        call_indirect (type 2)
        drop
      end
      local.get 0
      i32.load offset=4
      local.tee 1
      local.get 0
      i32.load offset=8
      local.tee 2
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      local.get 2
      i32.sub
      i64.extend_i32_s
      i32.const 1
      local.get 0
      i32.load offset=36
      call_indirect (type 3)
      drop
    end
    block  ;; label = @1
      i32.const 0
      i32.load offset=4384
      local.tee 0
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 0
        i32.load offset=20
        local.get 0
        i32.load offset=24
        i32.eq
        br_if 0 (;@2;)
        local.get 0
        i32.const 0
        i32.const 0
        local.get 0
        i32.load offset=32
        call_indirect (type 2)
        drop
      end
      local.get 0
      i32.load offset=4
      local.tee 1
      local.get 0
      i32.load offset=8
      local.tee 2
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      local.get 2
      i32.sub
      i64.extend_i32_s
      i32.const 1
      local.get 0
      i32.load offset=36
      call_indirect (type 3)
      drop
    end
    block  ;; label = @1
      i32.const 0
      i32.load offset=4504
      local.tee 0
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 0
        i32.load offset=20
        local.get 0
        i32.load offset=24
        i32.eq
        br_if 0 (;@2;)
        local.get 0
        i32.const 0
        i32.const 0
        local.get 0
        i32.load offset=32
        call_indirect (type 2)
        drop
      end
      local.get 0
      i32.load offset=4
      local.tee 1
      local.get 0
      i32.load offset=8
      local.tee 2
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      local.get 2
      i32.sub
      i64.extend_i32_s
      i32.const 1
      local.get 0
      i32.load offset=36
      call_indirect (type 3)
      drop
    end)
  (func $__toread (type 0) (param i32) (result i32)
    (local i32 i32)
    local.get 0
    local.get 0
    i32.load offset=60
    local.tee 1
    i32.const -1
    i32.add
    local.get 1
    i32.or
    i32.store offset=60
    block  ;; label = @1
      local.get 0
      i32.load offset=20
      local.get 0
      i32.load offset=24
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      i32.const 0
      i32.const 0
      local.get 0
      i32.load offset=32
      call_indirect (type 2)
      drop
    end
    local.get 0
    i32.const 0
    i32.store offset=24
    local.get 0
    i64.const 0
    i64.store offset=16
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 1
      i32.const 4
      i32.and
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      i32.const 32
      i32.or
      i32.store
      i32.const -1
      return
    end
    local.get 0
    local.get 0
    i32.load offset=40
    local.get 0
    i32.load offset=44
    i32.add
    local.tee 2
    i32.store offset=8
    local.get 0
    local.get 2
    i32.store offset=4
    local.get 1
    i32.const 27
    i32.shl
    i32.const 31
    i32.shr_s)
  (func $__uflow (type 0) (param i32) (result i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    i32.const -1
    local.set 2
    block  ;; label = @1
      local.get 0
      call $__toread
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      i32.const 15
      i32.add
      i32.const 1
      local.get 0
      i32.load offset=28
      call_indirect (type 2)
      i32.const 1
      i32.ne
      br_if 0 (;@1;)
      local.get 1
      i32.load8_u offset=15
      local.set 2
    end
    local.get 1
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 2)
  (func $fgets (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32)
    local.get 1
    i32.const -1
    i32.add
    local.set 3
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.const 2
          i32.lt_s
          br_if 0 (;@3;)
          local.get 0
          local.set 1
          block  ;; label = @4
            loop  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 2
                  i32.load offset=4
                  local.tee 4
                  local.get 2
                  i32.load offset=8
                  local.tee 5
                  i32.eq
                  br_if 0 (;@7;)
                  local.get 1
                  local.get 4
                  local.get 4
                  i32.const 10
                  local.get 5
                  local.get 4
                  i32.sub
                  local.tee 5
                  call $memchr
                  local.tee 6
                  local.get 4
                  i32.sub
                  i32.const 1
                  i32.add
                  local.get 5
                  local.get 6
                  select
                  local.tee 5
                  local.get 3
                  local.get 5
                  local.get 3
                  i32.lt_u
                  select
                  local.tee 5
                  call $memcpy
                  local.set 1
                  local.get 2
                  local.get 2
                  i32.load offset=4
                  local.get 5
                  i32.add
                  local.tee 4
                  i32.store offset=4
                  local.get 1
                  local.get 5
                  i32.add
                  local.set 1
                  local.get 6
                  br_if 3 (;@4;)
                  local.get 3
                  local.get 5
                  i32.sub
                  local.tee 3
                  i32.eqz
                  br_if 3 (;@4;)
                  local.get 4
                  local.get 2
                  i32.load offset=8
                  i32.eq
                  br_if 0 (;@7;)
                  local.get 2
                  local.get 4
                  i32.const 1
                  i32.add
                  i32.store offset=4
                  local.get 4
                  i32.load8_u
                  local.set 4
                  br 1 (;@6;)
                end
                local.get 2
                call $__uflow
                local.tee 4
                i32.const -1
                i32.gt_s
                br_if 0 (;@6;)
                i32.const 0
                local.set 4
                local.get 1
                local.get 0
                i32.eq
                br_if 5 (;@1;)
                local.get 2
                i32.load8_u
                i32.const 16
                i32.and
                i32.eqz
                br_if 5 (;@1;)
                br 2 (;@4;)
              end
              local.get 1
              local.get 4
              i32.store8
              local.get 1
              i32.const 1
              i32.add
              local.set 1
              local.get 4
              i32.const 255
              i32.and
              i32.const 10
              i32.eq
              br_if 1 (;@4;)
              local.get 3
              i32.const -1
              i32.add
              local.tee 3
              br_if 0 (;@5;)
            end
          end
          local.get 0
          br_if 1 (;@2;)
          i32.const 0
          return
        end
        local.get 2
        local.get 2
        i32.load offset=60
        local.tee 1
        i32.const -1
        i32.add
        local.get 1
        i32.or
        i32.store offset=60
        i32.const 0
        local.set 4
        local.get 0
        local.set 1
        local.get 3
        br_if 1 (;@1;)
      end
      local.get 1
      i32.const 0
      i32.store8
      local.get 0
      local.set 4
    end
    local.get 4)
  (func $__fmodeflags (type 0) (param i32) (result i32)
    (local i32 i32 i32)
    i32.const 335544320
    i32.const 67108864
    i32.const 268435456
    local.get 0
    i32.load8_u
    local.tee 1
    i32.const 114
    i32.eq
    local.tee 2
    select
    local.get 0
    i32.const 43
    call $strchr
    select
    local.tee 3
    i32.const 16384
    i32.or
    local.get 3
    local.get 0
    i32.const 120
    call $strchr
    select
    local.tee 0
    local.get 0
    i32.const 4096
    i32.or
    local.get 2
    select
    local.tee 0
    i32.const 32768
    i32.or
    local.get 0
    local.get 1
    i32.const 119
    i32.eq
    select
    local.get 1
    i32.const 97
    i32.eq
    i32.or)
  (func $internal_register_preopened_fd (type 4) (param i32 i32) (result i32)
    (local i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 2
        i32.add
        br_table 1 (;@1;) 1 (;@1;) 0 (;@2;)
      end
      local.get 1
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        i32.const 0
        i32.load offset=5144
        local.tee 2
        i32.const 0
        i32.load offset=5152
        i32.ne
        br_if 0 (;@2;)
        i32.const 0
        i32.load offset=5148
        local.set 3
        block  ;; label = @3
          i32.const 8
          local.get 2
          i32.const 1
          i32.shl
          i32.const 4
          local.get 2
          select
          local.tee 4
          call $calloc
          local.tee 5
          br_if 0 (;@3;)
          i32.const -1
          return
        end
        local.get 5
        local.get 3
        local.get 2
        i32.const 3
        i32.shl
        call $memcpy
        local.set 5
        i32.const 0
        local.get 4
        i32.store offset=5152
        i32.const 0
        local.get 5
        i32.store offset=5148
        local.get 3
        call $free
      end
      block  ;; label = @2
        loop  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 1
              local.tee 3
              i32.load8_u
              i32.const -46
              i32.add
              br_table 1 (;@4;) 0 (;@5;) 3 (;@2;)
            end
            local.get 3
            i32.const 1
            i32.add
            local.set 1
            br 1 (;@3;)
          end
          local.get 3
          i32.const 1
          i32.add
          local.set 1
          local.get 3
          i32.load8_u offset=1
          local.tee 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 4
          i32.const 47
          i32.ne
          br_if 1 (;@2;)
          local.get 3
          i32.const 2
          i32.add
          local.set 1
          br 0 (;@3;)
        end
      end
      block  ;; label = @2
        local.get 3
        call $strdup
        local.tee 3
        br_if 0 (;@2;)
        i32.const -1
        return
      end
      i32.const 0
      local.get 2
      i32.const 1
      i32.add
      i32.store offset=5144
      i32.const 0
      i32.load offset=5148
      local.get 2
      i32.const 3
      i32.shl
      i32.add
      local.tee 1
      local.get 0
      i32.store offset=4
      local.get 1
      local.get 3
      i32.store
      i32.const 0
      return
    end
    call $abort
    unreachable)
  (func $__wasilibc_find_relpath (type 5) (param i32 i32 i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 4
    global.set $__stack_pointer
    local.get 4
    local.get 3
    i32.store offset=12
    block  ;; label = @1
      block  ;; label = @2
        i32.const 0
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        local.get 1
        local.get 2
        local.get 4
        i32.const 12
        i32.add
        i32.const 0
        call $undefined_weak:__wasilibc_find_relpath_alloc
        local.set 3
        br 1 (;@1;)
      end
      local.get 0
      local.get 1
      local.get 2
      call $__wasilibc_find_abspath
      local.set 3
    end
    local.get 4
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 3)
  (func $__wasilibc_find_abspath (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    local.get 0
    i32.const -1
    i32.add
    local.set 3
    loop  ;; label = @1
      local.get 3
      i32.const 1
      i32.add
      local.tee 3
      i32.load8_u
      i32.const 47
      i32.eq
      br_if 0 (;@1;)
    end
    i32.const 0
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        i32.const 0
        i32.load offset=5144
        local.tee 5
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        i32.load offset=5148
        local.set 6
        i32.const -1
        local.set 7
        loop  ;; label = @3
          local.get 6
          local.get 5
          i32.const -1
          i32.add
          local.tee 5
          i32.const 3
          i32.shl
          i32.add
          local.tee 8
          i32.load
          local.tee 9
          call $strlen
          local.set 10
          block  ;; label = @4
            block  ;; label = @5
              local.get 7
              i32.const -1
              i32.eq
              br_if 0 (;@5;)
              local.get 10
              local.get 4
              i32.le_u
              br_if 1 (;@4;)
            end
            block  ;; label = @5
              block  ;; label = @6
                local.get 10
                br_if 0 (;@6;)
                local.get 3
                i32.load8_u
                i32.const 255
                i32.and
                i32.const 47
                i32.ne
                br_if 1 (;@5;)
              end
              local.get 3
              local.get 9
              local.get 10
              call $memcmp
              br_if 1 (;@4;)
              local.get 9
              i32.const -1
              i32.add
              local.set 11
              local.get 10
              local.set 12
              block  ;; label = @6
                loop  ;; label = @7
                  local.get 12
                  local.tee 0
                  i32.eqz
                  br_if 1 (;@6;)
                  local.get 0
                  i32.const -1
                  i32.add
                  local.set 12
                  local.get 11
                  local.get 0
                  i32.add
                  i32.load8_u
                  i32.const 47
                  i32.eq
                  br_if 0 (;@7;)
                end
              end
              local.get 3
              local.get 0
              i32.add
              i32.load8_u
              local.tee 0
              i32.const 47
              i32.eq
              br_if 0 (;@5;)
              local.get 0
              br_if 1 (;@4;)
            end
            local.get 1
            local.get 9
            i32.store
            local.get 8
            i32.load offset=4
            local.set 7
            local.get 10
            local.set 4
          end
          local.get 5
          br_if 0 (;@3;)
        end
        local.get 7
        i32.const -1
        i32.ne
        br_if 1 (;@1;)
      end
      i32.const 0
      i32.const 44
      i32.store offset=4644
      i32.const -1
      return
    end
    local.get 3
    local.get 4
    i32.add
    i32.const -1
    i32.add
    local.set 0
    loop  ;; label = @1
      local.get 0
      i32.const 1
      i32.add
      local.tee 0
      i32.load8_u
      local.tee 3
      i32.const 47
      i32.eq
      br_if 0 (;@1;)
    end
    local.get 2
    local.get 0
    i32.const 1131
    local.get 3
    select
    i32.store
    local.get 7)
  (func $__wasilibc_populate_preopens (type 1)
    (local i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 0
    global.set $__stack_pointer
    i32.const 3
    local.set 1
    block  ;; label = @1
      block  ;; label = @2
        loop  ;; label = @3
          block  ;; label = @4
            local.get 1
            local.get 0
            i32.const 8
            i32.add
            call $__wasi_fd_prestat_get
            local.tee 2
            i32.eqz
            br_if 0 (;@4;)
            local.get 2
            i32.const 8
            i32.ne
            br_if 2 (;@2;)
            local.get 0
            i32.const 16
            i32.add
            global.set $__stack_pointer
            return
          end
          block  ;; label = @4
            local.get 0
            i32.load8_u offset=8
            br_if 0 (;@4;)
            local.get 0
            i32.load offset=12
            local.tee 3
            i32.const 1
            i32.add
            call $malloc
            local.tee 2
            i32.eqz
            br_if 3 (;@1;)
            local.get 1
            local.get 2
            local.get 3
            call $__wasi_fd_prestat_dir_name
            br_if 2 (;@2;)
            local.get 2
            local.get 0
            i32.load offset=12
            i32.add
            i32.const 0
            i32.store8
            local.get 1
            local.get 2
            call $internal_register_preopened_fd
            br_if 3 (;@1;)
            local.get 2
            call $free
          end
          local.get 1
          i32.const 1
          i32.add
          local.set 1
          br 0 (;@3;)
        end
      end
      i32.const 71
      call $_Exit
      unreachable
    end
    i32.const 70
    call $_Exit
    unreachable)
  (func $__wasilibc_nocwd_openat_nomode (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i64 i64)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.const 503316480
            i32.and
            i32.const -33554432
            i32.add
            i32.const 25
            i32.shr_u
            local.tee 4
            i32.const 9
            i32.gt_u
            br_if 0 (;@4;)
            i32.const 1
            local.get 4
            i32.shl
            local.tee 4
            i32.const 642
            i32.and
            br_if 1 (;@3;)
            i64.const -4211012
            local.set 5
            local.get 4
            i32.const 9
            i32.and
            br_if 2 (;@2;)
          end
          i32.const 0
          i32.const 28
          i32.store offset=4644
          i32.const -1
          local.set 4
          br 2 (;@1;)
        end
        i64.const -4194626
        i64.const -4211012
        local.get 2
        i32.const 67108864
        i32.and
        select
        local.tee 5
        i64.const 4194625
        i64.or
        local.get 5
        local.get 2
        i32.const 268435456
        i32.and
        select
        local.set 5
      end
      block  ;; label = @2
        local.get 0
        local.get 3
        i32.const 8
        i32.add
        call $__wasi_fd_fdstat_get
        local.tee 4
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        local.get 4
        i32.store offset=4644
        i32.const -1
        local.set 4
        br 1 (;@1;)
      end
      i32.const -1
      local.set 4
      block  ;; label = @2
        local.get 0
        local.get 2
        i32.const -1
        i32.xor
        i32.const 24
        i32.shr_u
        i32.const 1
        i32.and
        local.get 1
        local.get 2
        i32.const 12
        i32.shr_u
        i32.const 4095
        i32.and
        local.get 3
        i64.load offset=24
        local.tee 6
        local.get 5
        i64.and
        local.get 6
        local.get 2
        i32.const 4095
        i32.and
        local.get 3
        i32.const 4
        i32.add
        call $__wasi_path_open
        local.tee 2
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        local.get 2
        i32.store offset=4644
        br 1 (;@1;)
      end
      local.get 3
      i32.load offset=4
      local.set 4
    end
    local.get 3
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 4)
  (func $close (type 0) (param i32) (result i32)
    block  ;; label = @1
      local.get 0
      call $__wasi_fd_close
      local.tee 0
      br_if 0 (;@1;)
      i32.const 0
      return
    end
    i32.const 0
    local.get 0
    i32.store offset=4644
    i32.const -1)
  (func $__wasilibc_open_nomode (type 4) (param i32 i32) (result i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        i32.const 0
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        local.get 2
        i32.const 12
        i32.add
        i32.const 5156
        i32.const 5160
        i32.const 1
        call $undefined_weak:__wasilibc_find_relpath_alloc
        local.set 3
        br 1 (;@1;)
      end
      local.get 0
      local.get 2
      i32.const 12
      i32.add
      i32.const 5156
      i32.const 5160
      i32.load
      call $__wasilibc_find_relpath
      local.set 3
    end
    i32.const -1
    local.set 0
    block  ;; label = @1
      block  ;; label = @2
        local.get 3
        i32.const -1
        i32.ne
        br_if 0 (;@2;)
        i32.const 0
        i32.const 44
        i32.store offset=4644
        br 1 (;@1;)
      end
      local.get 3
      i32.const 5156
      i32.load
      local.get 1
      call $__wasilibc_nocwd_openat_nomode
      local.set 0
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $fcntl (type 2) (param i32 i32 i32) (result i32)
    (local i32 i64 i64)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 1
                i32.const -1
                i32.add
                br_table 5 (;@1;) 0 (;@6;) 1 (;@5;) 2 (;@4;) 3 (;@3;)
              end
              i32.const 0
              local.set 1
              br 4 (;@1;)
            end
            block  ;; label = @5
              local.get 0
              local.get 3
              i32.const 8
              i32.add
              call $__wasi_fd_fdstat_get
              local.tee 1
              i32.eqz
              br_if 0 (;@5;)
              i32.const 0
              local.get 1
              i32.store offset=4644
              br 3 (;@2;)
            end
            local.get 3
            i64.load offset=16
            local.tee 4
            i64.const 64
            i64.and
            local.set 5
            local.get 3
            i32.load16_u offset=10
            local.set 1
            block  ;; label = @5
              local.get 4
              i64.const 16386
              i64.and
              i64.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 5
                i64.eqz
                br_if 0 (;@6;)
                local.get 1
                i32.const 335544320
                i32.or
                local.set 1
                br 5 (;@1;)
              end
              local.get 1
              i32.const 67108864
              i32.or
              local.set 1
              br 4 (;@1;)
            end
            block  ;; label = @5
              local.get 5
              i64.eqz
              br_if 0 (;@5;)
              local.get 1
              i32.const 268435456
              i32.or
              local.set 1
              br 4 (;@1;)
            end
            local.get 1
            i32.const 134217728
            i32.or
            local.set 1
            br 3 (;@1;)
          end
          local.get 3
          local.get 2
          i32.const 4
          i32.add
          i32.store offset=8
          block  ;; label = @4
            local.get 0
            local.get 2
            i32.load
            i32.const 4095
            i32.and
            call $__wasi_fd_fdstat_set_flags
            local.tee 1
            br_if 0 (;@4;)
            i32.const 0
            local.set 1
            br 3 (;@1;)
          end
          i32.const 0
          local.get 1
          i32.store offset=4644
          br 1 (;@2;)
        end
        i32.const 0
        i32.const 28
        i32.store offset=4644
      end
      i32.const -1
      local.set 1
    end
    local.get 3
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $__isatty (type 0) (param i32) (result i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        local.get 1
        i32.const 8
        i32.add
        call $__wasi_fd_fdstat_get
        local.tee 0
        br_if 0 (;@2;)
        i32.const 59
        local.set 0
        local.get 1
        i32.load8_u offset=8
        i32.const 2
        i32.ne
        br_if 0 (;@2;)
        local.get 1
        i32.load8_u offset=16
        i32.const 36
        i32.and
        br_if 0 (;@2;)
        i32.const 1
        local.set 2
        br 1 (;@1;)
      end
      i32.const 0
      local.set 2
      i32.const 0
      local.get 0
      i32.store offset=4644
    end
    local.get 1
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 2)
  (func $__lseek (type 3) (param i32 i64 i32) (result i64)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        local.get 1
        local.get 2
        i32.const 255
        i32.and
        local.get 3
        i32.const 8
        i32.add
        call $__wasi_fd_seek
        local.tee 2
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        i32.const 70
        local.get 2
        local.get 2
        i32.const 76
        i32.eq
        select
        i32.store offset=4644
        i64.const -1
        local.set 1
        br 1 (;@1;)
      end
      local.get 3
      i64.load offset=8
      local.set 1
    end
    local.get 3
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $__stdio_seek (type 3) (param i32 i64 i32) (result i64)
    local.get 0
    i32.load offset=56
    local.get 1
    local.get 2
    call $__lseek)
  (func $writev (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    i32.const -1
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const -1
        i32.gt_s
        br_if 0 (;@2;)
        i32.const 0
        i32.const 28
        i32.store offset=4644
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 0
        local.get 1
        local.get 2
        local.get 3
        i32.const 12
        i32.add
        call $__wasi_fd_write
        local.tee 2
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        local.get 2
        i32.store offset=4644
        i32.const -1
        local.set 4
        br 1 (;@1;)
      end
      local.get 3
      i32.load offset=12
      local.set 4
    end
    local.get 3
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 4)
  (func $__stdio_write (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 2
    i32.store offset=12
    local.get 3
    local.get 1
    i32.store offset=8
    local.get 3
    local.get 0
    i32.load offset=24
    local.tee 1
    i32.store
    local.get 3
    local.get 0
    i32.load offset=20
    local.get 1
    i32.sub
    local.tee 1
    i32.store offset=4
    i32.const 2
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        local.get 2
        i32.add
        local.tee 5
        local.get 0
        i32.load offset=56
        local.get 3
        i32.const 2
        call $writev
        local.tee 1
        i32.eq
        br_if 0 (;@2;)
        local.get 3
        local.set 6
        loop  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.const -1
            i32.gt_s
            br_if 0 (;@4;)
            i32.const 0
            local.set 1
            local.get 0
            i32.const 0
            i32.store offset=24
            local.get 0
            i64.const 0
            i64.store offset=16
            local.get 0
            local.get 0
            i32.load
            i32.const 32
            i32.or
            i32.store
            local.get 4
            i32.const 2
            i32.eq
            br_if 3 (;@1;)
            local.get 2
            local.get 6
            i32.load offset=4
            i32.sub
            local.set 1
            br 3 (;@1;)
          end
          local.get 6
          local.get 1
          local.get 6
          i32.load offset=4
          local.tee 7
          i32.gt_u
          local.tee 8
          i32.const 3
          i32.shl
          i32.add
          local.tee 9
          local.get 9
          i32.load
          local.get 1
          local.get 7
          i32.const 0
          local.get 8
          select
          i32.sub
          local.tee 7
          i32.add
          i32.store
          local.get 6
          i32.const 12
          i32.const 4
          local.get 8
          select
          i32.add
          local.tee 6
          local.get 6
          i32.load
          local.get 7
          i32.sub
          i32.store
          local.get 9
          local.set 6
          local.get 5
          local.get 1
          i32.sub
          local.tee 5
          local.get 0
          i32.load offset=56
          local.get 9
          local.get 4
          local.get 8
          i32.sub
          local.tee 4
          call $writev
          local.tee 1
          i32.ne
          br_if 0 (;@3;)
        end
      end
      local.get 0
      local.get 0
      i32.load offset=40
      local.tee 1
      i32.store offset=24
      local.get 0
      local.get 1
      i32.store offset=20
      local.get 0
      local.get 1
      local.get 0
      i32.load offset=44
      i32.add
      i32.store offset=16
      local.get 2
      local.set 1
    end
    local.get 3
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $readv (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    i32.const -1
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const -1
        i32.gt_s
        br_if 0 (;@2;)
        i32.const 0
        i32.const 28
        i32.store offset=4644
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 0
        local.get 1
        local.get 2
        local.get 3
        i32.const 12
        i32.add
        call $__wasi_fd_read
        local.tee 2
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        local.get 2
        i32.store offset=4644
        i32.const -1
        local.set 4
        br 1 (;@1;)
      end
      local.get 3
      i32.load offset=12
      local.set 4
    end
    local.get 3
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 4)
  (func $read (type 2) (param i32 i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 2
    i32.store offset=12
    local.get 3
    local.get 1
    i32.store offset=8
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        local.get 3
        i32.const 8
        i32.add
        i32.const 1
        local.get 3
        i32.const 4
        i32.add
        call $__wasi_fd_read
        local.tee 2
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        i32.const 8
        local.get 2
        local.get 2
        i32.const 76
        i32.eq
        select
        i32.store offset=4644
        i32.const -1
        local.set 2
        br 1 (;@1;)
      end
      local.get 3
      i32.load offset=4
      local.set 2
    end
    local.get 3
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 2)
  (func $__stdio_read (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 1
    i32.store
    local.get 3
    local.get 0
    i32.load offset=44
    local.tee 4
    i32.store offset=12
    local.get 3
    local.get 0
    i32.load offset=40
    local.tee 5
    i32.store offset=8
    local.get 3
    local.get 2
    local.get 4
    i32.const 0
    i32.ne
    i32.sub
    local.tee 6
    i32.store offset=4
    local.get 0
    i32.load offset=56
    local.set 7
    block  ;; label = @1
      block  ;; label = @2
        local.get 6
        i32.eqz
        br_if 0 (;@2;)
        local.get 7
        local.get 3
        i32.const 2
        call $readv
        local.set 4
        br 1 (;@1;)
      end
      local.get 7
      local.get 5
      local.get 4
      call $read
      local.set 4
    end
    i32.const 0
    local.set 6
    block  ;; label = @1
      block  ;; label = @2
        local.get 4
        i32.const 0
        i32.gt_s
        br_if 0 (;@2;)
        local.get 0
        local.get 0
        i32.load
        i32.const 32
        i32.const 16
        local.get 4
        select
        i32.or
        i32.store
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 4
        local.get 3
        i32.load offset=4
        local.tee 7
        i32.gt_u
        br_if 0 (;@2;)
        local.get 4
        local.set 6
        br 1 (;@1;)
      end
      local.get 0
      local.get 0
      i32.load offset=40
      local.tee 6
      i32.store offset=4
      local.get 0
      local.get 6
      local.get 4
      local.get 7
      i32.sub
      i32.add
      i32.store offset=8
      block  ;; label = @2
        local.get 0
        i32.load offset=44
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        local.get 6
        i32.const 1
        i32.add
        i32.store offset=4
        local.get 2
        local.get 1
        i32.add
        i32.const -1
        i32.add
        local.get 6
        i32.load8_u
        i32.store8
      end
      local.get 2
      local.set 6
    end
    local.get 3
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 6)
  (func $__stdio_close (type 0) (param i32) (result i32)
    local.get 0
    i32.load offset=56
    call $close)
  (func $__fdopen (type 4) (param i32 i32) (result i32)
    (local i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        i32.const 1082
        local.get 1
        i32.load8_s
        local.tee 3
        i32.const 4
        call $memchr
        br_if 0 (;@2;)
        i32.const 0
        local.set 4
        i32.const 0
        i32.const 28
        i32.store offset=4644
        br 1 (;@1;)
      end
      block  ;; label = @2
        i32.const 1144
        call $malloc
        local.tee 4
        br_if 0 (;@2;)
        i32.const 0
        local.set 4
        br 1 (;@1;)
      end
      i32.const 0
      local.set 5
      local.get 4
      i32.const 0
      i32.const 112
      call $memset
      local.set 4
      block  ;; label = @2
        local.get 1
        i32.const 43
        call $strchr
        br_if 0 (;@2;)
        local.get 4
        i32.const 8
        i32.const 4
        local.get 3
        i32.const 114
        i32.eq
        select
        local.tee 5
        i32.store
      end
      block  ;; label = @2
        local.get 1
        i32.const 101
        call $strchr
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        i32.const 1
        i32.store offset=16
        local.get 0
        i32.const 2
        local.get 2
        i32.const 16
        i32.add
        call $fcntl
        drop
        local.get 1
        i32.load8_u
        local.set 3
      end
      block  ;; label = @2
        local.get 3
        i32.const 255
        i32.and
        i32.const 97
        i32.ne
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 0
          i32.const 3
          i32.const 0
          call $fcntl
          local.tee 1
          i32.const 1
          i32.and
          br_if 0 (;@3;)
          local.get 2
          local.get 1
          i32.const 1
          i32.or
          i32.store
          local.get 0
          i32.const 4
          local.get 2
          call $fcntl
          drop
        end
        local.get 4
        local.get 5
        i32.const 128
        i32.or
        local.tee 5
        i32.store
      end
      local.get 4
      i32.const -1
      i32.store offset=64
      local.get 4
      i32.const 1024
      i32.store offset=44
      local.get 4
      local.get 0
      i32.store offset=56
      local.get 4
      local.get 4
      i32.const 120
      i32.add
      i32.store offset=40
      block  ;; label = @2
        local.get 5
        i32.const 8
        i32.and
        br_if 0 (;@2;)
        local.get 0
        call $__isatty
        i32.eqz
        br_if 0 (;@2;)
        local.get 4
        i32.const 10
        i32.store offset=64
      end
      local.get 4
      i32.const 4
      i32.store offset=36
      local.get 4
      i32.const 5
      i32.store offset=32
      local.get 4
      i32.const 6
      i32.store offset=28
      local.get 4
      i32.const 7
      i32.store offset=12
      local.get 4
      call $__ofl_add
      local.set 4
    end
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 4)
  (func $fopen (type 4) (param i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      i32.const 1082
      local.get 1
      i32.load8_s
      i32.const 4
      call $memchr
      br_if 0 (;@1;)
      i32.const 0
      i32.const 28
      i32.store offset=4644
      i32.const 0
      return
    end
    i32.const 0
    local.set 2
    block  ;; label = @1
      local.get 0
      local.get 1
      call $__fmodeflags
      call $__wasilibc_open_nomode
      local.tee 0
      i32.const 0
      i32.lt_s
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      call $__fdopen
      local.tee 2
      br_if 0 (;@1;)
      local.get 0
      call $close
      drop
      i32.const 0
      local.set 2
    end
    local.get 2)
  (func $__ofl_lock (type 12) (result i32)
    i32.const 5164)
  (func $__ofl_unlock (type 1))
  (func $__ofl_add (type 0) (param i32) (result i32)
    (local i32 i32)
    local.get 0
    call $__ofl_lock
    local.tee 1
    i32.load
    i32.store offset=52
    block  ;; label = @1
      local.get 1
      i32.load
      local.tee 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      local.get 0
      i32.store offset=48
    end
    local.get 1
    local.get 0
    i32.store
    call $__ofl_unlock
    local.get 0)
  (func $printf (type 4) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    local.get 1
    i32.store offset=12
    i32.const 4272
    local.get 0
    local.get 1
    call $vfprintf
    local.set 1
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $scanf (type 4) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    local.get 1
    i32.store offset=12
    local.get 0
    local.get 1
    call $vscanf
    local.set 1
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $__stdout_write (type 2) (param i32 i32 i32) (result i32)
    local.get 0
    i32.const 5
    i32.store offset=32
    block  ;; label = @1
      local.get 0
      i32.load8_u
      i32.const 64
      i32.and
      br_if 0 (;@1;)
      local.get 0
      i32.load offset=56
      call $__isatty
      br_if 0 (;@1;)
      local.get 0
      i32.const -1
      i32.store offset=64
    end
    local.get 0
    local.get 1
    local.get 2
    call $__stdio_write)
  (func $__towrite (type 0) (param i32) (result i32)
    (local i32)
    local.get 0
    local.get 0
    i32.load offset=60
    local.tee 1
    i32.const -1
    i32.add
    local.get 1
    i32.or
    i32.store offset=60
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 1
      i32.const 8
      i32.and
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      i32.const 32
      i32.or
      i32.store
      i32.const -1
      return
    end
    local.get 0
    i64.const 0
    i64.store offset=4 align=4
    local.get 0
    local.get 0
    i32.load offset=40
    local.tee 1
    i32.store offset=24
    local.get 0
    local.get 1
    i32.store offset=20
    local.get 0
    local.get 1
    local.get 0
    i32.load offset=44
    i32.add
    i32.store offset=16
    i32.const 0)
  (func $__fwritex (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.load offset=16
        local.tee 3
        br_if 0 (;@2;)
        i32.const 0
        local.set 4
        local.get 2
        call $__towrite
        br_if 1 (;@1;)
        local.get 2
        i32.load offset=16
        local.set 3
      end
      block  ;; label = @2
        local.get 3
        local.get 2
        i32.load offset=20
        local.tee 5
        i32.sub
        local.get 1
        i32.ge_u
        br_if 0 (;@2;)
        local.get 2
        local.get 0
        local.get 1
        local.get 2
        i32.load offset=32
        call_indirect (type 2)
        return
      end
      i32.const 0
      local.set 6
      block  ;; label = @2
        local.get 2
        i32.load offset=64
        i32.const 0
        i32.lt_s
        br_if 0 (;@2;)
        i32.const 0
        local.set 6
        local.get 0
        local.set 4
        i32.const 0
        local.set 3
        loop  ;; label = @3
          local.get 1
          local.get 3
          i32.eq
          br_if 1 (;@2;)
          local.get 3
          i32.const 1
          i32.add
          local.set 3
          local.get 4
          i32.const -1
          i32.add
          local.tee 4
          local.get 1
          i32.add
          local.tee 7
          i32.load8_u
          i32.const 10
          i32.ne
          br_if 0 (;@3;)
        end
        local.get 2
        local.get 0
        local.get 1
        local.get 3
        i32.sub
        i32.const 1
        i32.add
        local.tee 6
        local.get 2
        i32.load offset=32
        call_indirect (type 2)
        local.tee 4
        local.get 6
        i32.lt_u
        br_if 1 (;@1;)
        local.get 3
        i32.const -1
        i32.add
        local.set 1
        local.get 7
        i32.const 1
        i32.add
        local.set 0
        local.get 2
        i32.load offset=20
        local.set 5
      end
      local.get 5
      local.get 0
      local.get 1
      call $memcpy
      drop
      local.get 2
      local.get 2
      i32.load offset=20
      local.get 1
      i32.add
      i32.store offset=20
      local.get 6
      local.get 1
      i32.add
      local.set 4
    end
    local.get 4)
  (func $fwrite (type 5) (param i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    local.get 2
    local.get 1
    i32.mul
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        local.get 3
        i32.load offset=16
        local.tee 5
        br_if 0 (;@2;)
        i32.const 0
        local.set 6
        local.get 3
        call $__towrite
        br_if 1 (;@1;)
        local.get 3
        i32.load offset=16
        local.set 5
      end
      block  ;; label = @2
        local.get 5
        local.get 3
        i32.load offset=20
        local.tee 7
        i32.sub
        local.get 4
        i32.ge_u
        br_if 0 (;@2;)
        local.get 3
        local.get 0
        local.get 4
        local.get 3
        i32.load offset=32
        call_indirect (type 2)
        local.set 6
        br 1 (;@1;)
      end
      i32.const 0
      local.set 8
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.load offset=64
          i32.const 0
          i32.ge_s
          br_if 0 (;@3;)
          local.get 4
          local.set 5
          br 1 (;@2;)
        end
        local.get 0
        local.get 4
        i32.add
        local.set 6
        i32.const 0
        local.set 8
        i32.const 0
        local.set 5
        loop  ;; label = @3
          block  ;; label = @4
            local.get 4
            local.get 5
            i32.add
            br_if 0 (;@4;)
            local.get 4
            local.set 5
            br 2 (;@2;)
          end
          local.get 5
          i32.const -1
          i32.add
          local.tee 5
          local.get 6
          i32.add
          local.tee 9
          i32.load8_u
          i32.const 10
          i32.ne
          br_if 0 (;@3;)
        end
        local.get 3
        local.get 0
        local.get 4
        local.get 5
        i32.add
        i32.const 1
        i32.add
        local.tee 8
        local.get 3
        i32.load offset=32
        call_indirect (type 2)
        local.tee 6
        local.get 8
        i32.lt_u
        br_if 1 (;@1;)
        local.get 5
        i32.const -1
        i32.xor
        local.set 5
        local.get 9
        i32.const 1
        i32.add
        local.set 0
        local.get 3
        i32.load offset=20
        local.set 7
      end
      local.get 7
      local.get 0
      local.get 5
      call $memcpy
      drop
      local.get 3
      local.get 3
      i32.load offset=20
      local.get 5
      i32.add
      i32.store offset=20
      local.get 8
      local.get 5
      i32.add
      local.set 6
    end
    block  ;; label = @1
      local.get 6
      local.get 4
      i32.ne
      br_if 0 (;@1;)
      local.get 2
      i32.const 0
      local.get 1
      select
      return
    end
    local.get 6
    local.get 1
    i32.div_u)
  (func $dummy.2 (type 4) (param i32 i32) (result i32)
    local.get 0)
  (func $__lctrans (type 4) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call $dummy.2)
  (func $strerror (type 0) (param i32) (result i32)
    (local i32)
    block  ;; label = @1
      i32.const 0
      i32.load offset=6224
      local.tee 1
      br_if 0 (;@1;)
      i32.const 6200
      local.set 1
      i32.const 0
      i32.const 6200
      i32.store offset=6224
    end
    i32.const 0
    local.get 0
    local.get 0
    i32.const 76
    i32.gt_u
    select
    i32.const 1
    i32.shl
    i32.const 3120
    i32.add
    i32.load16_u
    i32.const 1564
    i32.add
    local.get 1
    i32.load offset=20
    call $__lctrans)
  (func $wcrtomb (type 2) (param i32 i32 i32) (result i32)
    (local i32)
    i32.const 1
    local.set 3
    block  ;; label = @1
      local.get 0
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 1
        i32.const 127
        i32.gt_u
        br_if 0 (;@2;)
        local.get 0
        local.get 1
        i32.store8
        i32.const 1
        return
      end
      block  ;; label = @2
        block  ;; label = @3
          i32.const 0
          i32.load offset=6200
          br_if 0 (;@3;)
          block  ;; label = @4
            local.get 1
            i32.const -128
            i32.and
            i32.const 57216
            i32.eq
            br_if 0 (;@4;)
            i32.const 0
            i32.const 25
            i32.store offset=4644
            br 2 (;@2;)
          end
          local.get 0
          local.get 1
          i32.store8
          i32.const 1
          return
        end
        block  ;; label = @3
          local.get 1
          i32.const 2047
          i32.gt_u
          br_if 0 (;@3;)
          local.get 0
          local.get 1
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=1
          local.get 0
          local.get 1
          i32.const 6
          i32.shr_u
          i32.const 192
          i32.or
          i32.store8
          i32.const 2
          return
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.const 55296
            i32.lt_u
            br_if 0 (;@4;)
            local.get 1
            i32.const -8192
            i32.and
            i32.const 57344
            i32.ne
            br_if 1 (;@3;)
          end
          local.get 0
          local.get 1
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=2
          local.get 0
          local.get 1
          i32.const 12
          i32.shr_u
          i32.const 224
          i32.or
          i32.store8
          local.get 0
          local.get 1
          i32.const 6
          i32.shr_u
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=1
          i32.const 3
          return
        end
        block  ;; label = @3
          local.get 1
          i32.const -65536
          i32.add
          i32.const 1048575
          i32.gt_u
          br_if 0 (;@3;)
          local.get 0
          local.get 1
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=3
          local.get 0
          local.get 1
          i32.const 18
          i32.shr_u
          i32.const 240
          i32.or
          i32.store8
          local.get 0
          local.get 1
          i32.const 6
          i32.shr_u
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=2
          local.get 0
          local.get 1
          i32.const 12
          i32.shr_u
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=1
          i32.const 4
          return
        end
        i32.const 0
        i32.const 25
        i32.store offset=4644
      end
      i32.const -1
      local.set 3
    end
    local.get 3)
  (func $wctomb (type 4) (param i32 i32) (result i32)
    block  ;; label = @1
      local.get 0
      br_if 0 (;@1;)
      i32.const 0
      return
    end
    local.get 0
    local.get 1
    i32.const 0
    call $wcrtomb)
  (func $frexp (type 15) (param f64 i32) (result f64)
    (local i64 i32)
    block  ;; label = @1
      local.get 0
      i64.reinterpret_f64
      local.tee 2
      i64.const 52
      i64.shr_u
      i32.wrap_i64
      i32.const 2047
      i32.and
      local.tee 3
      i32.const 2047
      i32.eq
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 3
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 0
          f64.const 0x0p+0 (;=0;)
          f64.ne
          br_if 0 (;@3;)
          local.get 1
          i32.const 0
          i32.store
          local.get 0
          return
        end
        local.get 0
        f64.const 0x1p+64 (;=1.84467e+19;)
        f64.mul
        local.get 1
        call $frexp
        local.set 0
        local.get 1
        local.get 1
        i32.load
        i32.const -64
        i32.add
        i32.store
        local.get 0
        return
      end
      local.get 1
      local.get 3
      i32.const -1022
      i32.add
      i32.store
      local.get 2
      i64.const -9218868437227405313
      i64.and
      i64.const 4602678819172646912
      i64.or
      f64.reinterpret_i64
      local.set 0
    end
    local.get 0)
  (func $fputs (type 4) (param i32 i32) (result i32)
    (local i32)
    local.get 0
    call $strlen
    local.set 2
    i32.const -1
    i32.const 0
    local.get 2
    local.get 0
    i32.const 1
    local.get 2
    local.get 1
    call $fwrite
    i32.ne
    select)
  (func $vfprintf (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 208
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 2
    i32.store offset=204
    local.get 3
    i32.const 160
    i32.add
    i32.const 32
    i32.add
    i64.const 0
    i64.store
    local.get 3
    i32.const 184
    i32.add
    i64.const 0
    i64.store
    local.get 3
    i32.const 176
    i32.add
    i64.const 0
    i64.store
    local.get 3
    i64.const 0
    i64.store offset=168
    local.get 3
    i64.const 0
    i64.store offset=160
    local.get 3
    local.get 2
    i32.store offset=200
    block  ;; label = @1
      block  ;; label = @2
        i32.const 0
        local.get 1
        local.get 3
        i32.const 200
        i32.add
        local.get 3
        i32.const 80
        i32.add
        local.get 3
        i32.const 160
        i32.add
        call $printf_core
        i32.const 0
        i32.ge_s
        br_if 0 (;@2;)
        i32.const -1
        local.set 0
        br 1 (;@1;)
      end
      local.get 0
      i32.load
      local.set 4
      block  ;; label = @2
        local.get 0
        i32.load offset=60
        i32.const 0
        i32.gt_s
        br_if 0 (;@2;)
        local.get 0
        local.get 4
        i32.const -33
        i32.and
        i32.store
      end
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.load offset=44
              br_if 0 (;@5;)
              local.get 0
              i32.const 80
              i32.store offset=44
              local.get 0
              i32.const 0
              i32.store offset=24
              local.get 0
              i64.const 0
              i64.store offset=16
              local.get 0
              i32.load offset=40
              local.set 5
              local.get 0
              local.get 3
              i32.store offset=40
              br 1 (;@4;)
            end
            i32.const 0
            local.set 5
            local.get 0
            i32.load offset=16
            br_if 1 (;@3;)
          end
          i32.const -1
          local.set 2
          local.get 0
          call $__towrite
          br_if 1 (;@2;)
        end
        local.get 0
        local.get 1
        local.get 3
        i32.const 200
        i32.add
        local.get 3
        i32.const 80
        i32.add
        local.get 3
        i32.const 160
        i32.add
        call $printf_core
        local.set 2
      end
      local.get 4
      i32.const 32
      i32.and
      local.set 1
      block  ;; label = @2
        local.get 5
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        i32.const 0
        i32.const 0
        local.get 0
        i32.load offset=32
        call_indirect (type 2)
        drop
        local.get 0
        i32.const 0
        i32.store offset=44
        local.get 0
        local.get 5
        i32.store offset=40
        local.get 0
        i32.const 0
        i32.store offset=24
        local.get 0
        i32.load offset=20
        local.set 5
        local.get 0
        i64.const 0
        i64.store offset=16
        local.get 2
        i32.const -1
        local.get 5
        select
        local.set 2
      end
      local.get 0
      local.get 0
      i32.load
      local.tee 5
      local.get 1
      i32.or
      i32.store
      i32.const -1
      local.get 2
      local.get 5
      i32.const 32
      i32.and
      select
      local.set 0
    end
    local.get 3
    i32.const 208
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $printf_core (type 9) (param i32 i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i64 i64 f64 i32 i32 i32 i32 i32 i32 i32 i32 f64)
    global.get $__stack_pointer
    i32.const 880
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    local.get 5
    i32.const 68
    i32.add
    i32.const 12
    i32.add
    local.set 6
    i32.const 0
    local.get 5
    i32.const 112
    i32.add
    i32.sub
    local.set 7
    local.get 5
    i32.const -3988
    i32.add
    local.set 8
    local.get 5
    i32.const 55
    i32.add
    local.set 9
    local.get 5
    i32.const 80
    i32.add
    i32.const -2
    i32.xor
    local.set 10
    local.get 5
    i32.const 68
    i32.add
    i32.const 11
    i32.add
    local.set 11
    local.get 5
    i32.const 80
    i32.add
    i32.const 8
    i32.or
    local.set 12
    local.get 5
    i32.const 80
    i32.add
    i32.const 9
    i32.or
    local.set 13
    i32.const -10
    local.get 5
    i32.const 68
    i32.add
    i32.sub
    local.set 14
    local.get 5
    i32.const 68
    i32.add
    i32.const 10
    i32.add
    local.set 15
    local.get 5
    i32.const 56
    i32.add
    local.set 16
    i32.const 0
    local.set 17
    i32.const 0
    local.set 18
    i32.const 0
    local.set 19
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          loop  ;; label = @4
            local.get 1
            local.set 20
            local.get 19
            local.get 18
            i32.const 2147483647
            i32.xor
            i32.gt_s
            br_if 1 (;@3;)
            local.get 19
            local.get 18
            i32.add
            local.set 18
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 20
                              i32.load8_u
                              local.tee 19
                              i32.eqz
                              br_if 0 (;@13;)
                              local.get 20
                              local.set 1
                              loop  ;; label = @14
                                block  ;; label = @15
                                  block  ;; label = @16
                                    block  ;; label = @17
                                      local.get 19
                                      i32.const 255
                                      i32.and
                                      local.tee 19
                                      i32.eqz
                                      br_if 0 (;@17;)
                                      local.get 19
                                      i32.const 37
                                      i32.ne
                                      br_if 2 (;@15;)
                                      local.get 1
                                      local.set 21
                                      local.get 1
                                      local.set 19
                                      loop  ;; label = @18
                                        block  ;; label = @19
                                          local.get 19
                                          i32.load8_u offset=1
                                          i32.const 37
                                          i32.eq
                                          br_if 0 (;@19;)
                                          local.get 19
                                          local.set 1
                                          br 3 (;@16;)
                                        end
                                        local.get 21
                                        i32.const 1
                                        i32.add
                                        local.set 21
                                        local.get 19
                                        i32.load8_u offset=2
                                        local.set 22
                                        local.get 19
                                        i32.const 2
                                        i32.add
                                        local.tee 1
                                        local.set 19
                                        local.get 22
                                        i32.const 37
                                        i32.eq
                                        br_if 0 (;@18;)
                                        br 2 (;@16;)
                                      end
                                    end
                                    local.get 1
                                    local.set 21
                                  end
                                  local.get 21
                                  local.get 20
                                  i32.sub
                                  local.tee 19
                                  local.get 18
                                  i32.const 2147483647
                                  i32.xor
                                  local.tee 21
                                  i32.gt_s
                                  br_if 12 (;@3;)
                                  block  ;; label = @16
                                    local.get 0
                                    i32.eqz
                                    br_if 0 (;@16;)
                                    local.get 0
                                    i32.load8_u
                                    i32.const 32
                                    i32.and
                                    br_if 0 (;@16;)
                                    local.get 20
                                    local.get 19
                                    local.get 0
                                    call $__fwritex
                                    drop
                                  end
                                  local.get 19
                                  br_if 11 (;@4;)
                                  local.get 1
                                  i32.const 1
                                  i32.add
                                  local.set 19
                                  i32.const -1
                                  local.set 23
                                  block  ;; label = @16
                                    local.get 1
                                    i32.load8_s offset=1
                                    local.tee 24
                                    i32.const -48
                                    i32.add
                                    local.tee 22
                                    i32.const 9
                                    i32.gt_u
                                    br_if 0 (;@16;)
                                    local.get 1
                                    i32.load8_u offset=2
                                    i32.const 36
                                    i32.ne
                                    br_if 0 (;@16;)
                                    local.get 1
                                    i32.const 3
                                    i32.add
                                    local.set 19
                                    local.get 1
                                    i32.load8_s offset=3
                                    local.set 24
                                    i32.const 1
                                    local.set 17
                                    local.get 22
                                    local.set 23
                                  end
                                  i32.const 0
                                  local.set 25
                                  block  ;; label = @16
                                    local.get 24
                                    i32.const -32
                                    i32.add
                                    local.tee 1
                                    i32.const 31
                                    i32.gt_u
                                    br_if 0 (;@16;)
                                    i32.const 1
                                    local.get 1
                                    i32.shl
                                    local.tee 1
                                    i32.const 75913
                                    i32.and
                                    i32.eqz
                                    br_if 0 (;@16;)
                                    local.get 19
                                    i32.const 1
                                    i32.add
                                    local.set 22
                                    i32.const 0
                                    local.set 25
                                    loop  ;; label = @17
                                      local.get 1
                                      local.get 25
                                      i32.or
                                      local.set 25
                                      local.get 22
                                      local.tee 19
                                      i32.load8_s
                                      local.tee 24
                                      i32.const -32
                                      i32.add
                                      local.tee 1
                                      i32.const 32
                                      i32.ge_u
                                      br_if 1 (;@16;)
                                      local.get 19
                                      i32.const 1
                                      i32.add
                                      local.set 22
                                      i32.const 1
                                      local.get 1
                                      i32.shl
                                      local.tee 1
                                      i32.const 75913
                                      i32.and
                                      br_if 0 (;@17;)
                                    end
                                  end
                                  block  ;; label = @16
                                    local.get 24
                                    i32.const 42
                                    i32.ne
                                    br_if 0 (;@16;)
                                    block  ;; label = @17
                                      block  ;; label = @18
                                        local.get 19
                                        i32.load8_s offset=1
                                        i32.const -48
                                        i32.add
                                        local.tee 1
                                        i32.const 9
                                        i32.gt_u
                                        br_if 0 (;@18;)
                                        local.get 19
                                        i32.load8_u offset=2
                                        i32.const 36
                                        i32.ne
                                        br_if 0 (;@18;)
                                        local.get 4
                                        local.get 1
                                        i32.const 2
                                        i32.shl
                                        i32.add
                                        i32.const 10
                                        i32.store
                                        local.get 19
                                        i32.const 3
                                        i32.add
                                        local.set 22
                                        local.get 19
                                        i32.load8_s offset=1
                                        i32.const 3
                                        i32.shl
                                        local.get 3
                                        i32.add
                                        i32.const -384
                                        i32.add
                                        i32.load
                                        local.set 26
                                        i32.const 1
                                        local.set 17
                                        br 1 (;@17;)
                                      end
                                      local.get 17
                                      br_if 6 (;@11;)
                                      local.get 19
                                      i32.const 1
                                      i32.add
                                      local.set 22
                                      block  ;; label = @18
                                        local.get 0
                                        br_if 0 (;@18;)
                                        i32.const 0
                                        local.set 17
                                        i32.const 0
                                        local.set 26
                                        br 6 (;@12;)
                                      end
                                      local.get 2
                                      local.get 2
                                      i32.load
                                      local.tee 1
                                      i32.const 4
                                      i32.add
                                      i32.store
                                      local.get 1
                                      i32.load
                                      local.set 26
                                      i32.const 0
                                      local.set 17
                                    end
                                    local.get 26
                                    i32.const -1
                                    i32.gt_s
                                    br_if 4 (;@12;)
                                    i32.const 0
                                    local.get 26
                                    i32.sub
                                    local.set 26
                                    local.get 25
                                    i32.const 8192
                                    i32.or
                                    local.set 25
                                    br 4 (;@12;)
                                  end
                                  i32.const 0
                                  local.set 26
                                  block  ;; label = @16
                                    local.get 24
                                    i32.const -48
                                    i32.add
                                    local.tee 1
                                    i32.const 9
                                    i32.le_u
                                    br_if 0 (;@16;)
                                    local.get 19
                                    local.set 22
                                    br 4 (;@12;)
                                  end
                                  i32.const 0
                                  local.set 26
                                  loop  ;; label = @16
                                    block  ;; label = @17
                                      local.get 26
                                      i32.const 214748364
                                      i32.gt_u
                                      br_if 0 (;@17;)
                                      i32.const -1
                                      local.get 26
                                      i32.const 10
                                      i32.mul
                                      local.tee 22
                                      local.get 1
                                      i32.add
                                      local.get 1
                                      local.get 22
                                      i32.const 2147483647
                                      i32.xor
                                      i32.gt_u
                                      select
                                      local.set 26
                                      local.get 19
                                      i32.load8_s offset=1
                                      local.set 1
                                      local.get 19
                                      i32.const 1
                                      i32.add
                                      local.tee 22
                                      local.set 19
                                      local.get 1
                                      i32.const -48
                                      i32.add
                                      local.tee 1
                                      i32.const 10
                                      i32.lt_u
                                      br_if 1 (;@16;)
                                      local.get 26
                                      i32.const 0
                                      i32.lt_s
                                      br_if 14 (;@3;)
                                      br 5 (;@12;)
                                    end
                                    local.get 19
                                    i32.load8_s offset=1
                                    local.set 1
                                    i32.const -1
                                    local.set 26
                                    local.get 19
                                    i32.const 1
                                    i32.add
                                    local.set 19
                                    local.get 1
                                    i32.const -48
                                    i32.add
                                    local.tee 1
                                    i32.const 10
                                    i32.lt_u
                                    br_if 0 (;@16;)
                                    br 13 (;@3;)
                                  end
                                end
                                local.get 1
                                i32.load8_u offset=1
                                local.set 19
                                local.get 1
                                i32.const 1
                                i32.add
                                local.set 1
                                br 0 (;@14;)
                              end
                            end
                            local.get 0
                            br_if 11 (;@1;)
                            block  ;; label = @13
                              local.get 17
                              br_if 0 (;@13;)
                              i32.const 0
                              local.set 18
                              br 12 (;@1;)
                            end
                            block  ;; label = @13
                              block  ;; label = @14
                                local.get 4
                                i32.load offset=4
                                local.tee 1
                                br_if 0 (;@14;)
                                i32.const 1
                                local.set 1
                                br 1 (;@13;)
                              end
                              local.get 3
                              i32.const 8
                              i32.add
                              local.get 1
                              local.get 2
                              call $pop_arg
                              block  ;; label = @14
                                local.get 4
                                i32.load offset=8
                                local.tee 1
                                br_if 0 (;@14;)
                                i32.const 2
                                local.set 1
                                br 1 (;@13;)
                              end
                              local.get 3
                              i32.const 16
                              i32.add
                              local.get 1
                              local.get 2
                              call $pop_arg
                              block  ;; label = @14
                                local.get 4
                                i32.load offset=12
                                local.tee 1
                                br_if 0 (;@14;)
                                i32.const 3
                                local.set 1
                                br 1 (;@13;)
                              end
                              local.get 3
                              i32.const 24
                              i32.add
                              local.get 1
                              local.get 2
                              call $pop_arg
                              block  ;; label = @14
                                local.get 4
                                i32.load offset=16
                                local.tee 1
                                br_if 0 (;@14;)
                                i32.const 4
                                local.set 1
                                br 1 (;@13;)
                              end
                              local.get 3
                              i32.const 32
                              i32.add
                              local.get 1
                              local.get 2
                              call $pop_arg
                              block  ;; label = @14
                                local.get 4
                                i32.load offset=20
                                local.tee 1
                                br_if 0 (;@14;)
                                i32.const 5
                                local.set 1
                                br 1 (;@13;)
                              end
                              local.get 3
                              i32.const 40
                              i32.add
                              local.get 1
                              local.get 2
                              call $pop_arg
                              block  ;; label = @14
                                local.get 4
                                i32.load offset=24
                                local.tee 1
                                br_if 0 (;@14;)
                                i32.const 6
                                local.set 1
                                br 1 (;@13;)
                              end
                              local.get 3
                              i32.const 48
                              i32.add
                              local.get 1
                              local.get 2
                              call $pop_arg
                              block  ;; label = @14
                                local.get 4
                                i32.load offset=28
                                local.tee 1
                                br_if 0 (;@14;)
                                i32.const 7
                                local.set 1
                                br 1 (;@13;)
                              end
                              local.get 3
                              i32.const 56
                              i32.add
                              local.get 1
                              local.get 2
                              call $pop_arg
                              block  ;; label = @14
                                local.get 4
                                i32.load offset=32
                                local.tee 1
                                br_if 0 (;@14;)
                                i32.const 8
                                local.set 1
                                br 1 (;@13;)
                              end
                              local.get 3
                              i32.const 64
                              i32.add
                              local.get 1
                              local.get 2
                              call $pop_arg
                              block  ;; label = @14
                                local.get 4
                                i32.load offset=36
                                local.tee 1
                                br_if 0 (;@14;)
                                i32.const 9
                                local.set 1
                                br 1 (;@13;)
                              end
                              local.get 3
                              i32.const 72
                              i32.add
                              local.get 1
                              local.get 2
                              call $pop_arg
                              i32.const 1
                              local.set 18
                              br 12 (;@1;)
                            end
                            local.get 1
                            i32.const 2
                            i32.shl
                            local.set 1
                            loop  ;; label = @13
                              local.get 4
                              local.get 1
                              i32.add
                              i32.load
                              br_if 2 (;@11;)
                              local.get 1
                              i32.const 4
                              i32.add
                              local.tee 1
                              i32.const 40
                              i32.ne
                              br_if 0 (;@13;)
                            end
                            i32.const 1
                            local.set 18
                            br 11 (;@1;)
                          end
                          i32.const 0
                          local.set 19
                          i32.const -1
                          local.set 24
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 22
                              i32.load8_u
                              i32.const 46
                              i32.eq
                              br_if 0 (;@13;)
                              local.get 22
                              local.set 1
                              i32.const 0
                              local.set 27
                              br 1 (;@12;)
                            end
                            block  ;; label = @13
                              local.get 22
                              i32.load8_s offset=1
                              local.tee 24
                              i32.const 42
                              i32.ne
                              br_if 0 (;@13;)
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 22
                                  i32.load8_s offset=2
                                  i32.const -48
                                  i32.add
                                  local.tee 1
                                  i32.const 9
                                  i32.gt_u
                                  br_if 0 (;@15;)
                                  local.get 22
                                  i32.load8_u offset=3
                                  i32.const 36
                                  i32.ne
                                  br_if 0 (;@15;)
                                  local.get 4
                                  local.get 1
                                  i32.const 2
                                  i32.shl
                                  i32.add
                                  i32.const 10
                                  i32.store
                                  local.get 22
                                  i32.const 4
                                  i32.add
                                  local.set 1
                                  local.get 22
                                  i32.load8_s offset=2
                                  i32.const 3
                                  i32.shl
                                  local.get 3
                                  i32.add
                                  i32.const -384
                                  i32.add
                                  i32.load
                                  local.set 24
                                  br 1 (;@14;)
                                end
                                local.get 17
                                br_if 3 (;@11;)
                                local.get 22
                                i32.const 2
                                i32.add
                                local.set 1
                                block  ;; label = @15
                                  local.get 0
                                  br_if 0 (;@15;)
                                  i32.const 0
                                  local.set 24
                                  br 1 (;@14;)
                                end
                                local.get 2
                                local.get 2
                                i32.load
                                local.tee 22
                                i32.const 4
                                i32.add
                                i32.store
                                local.get 22
                                i32.load
                                local.set 24
                              end
                              local.get 24
                              i32.const -1
                              i32.xor
                              i32.const 31
                              i32.shr_u
                              local.set 27
                              br 1 (;@12;)
                            end
                            local.get 22
                            i32.const 1
                            i32.add
                            local.set 1
                            block  ;; label = @13
                              local.get 24
                              i32.const -48
                              i32.add
                              local.tee 28
                              i32.const 9
                              i32.le_u
                              br_if 0 (;@13;)
                              i32.const 1
                              local.set 27
                              i32.const 0
                              local.set 24
                              br 1 (;@12;)
                            end
                            i32.const 0
                            local.set 29
                            local.get 1
                            local.set 22
                            loop  ;; label = @13
                              i32.const -1
                              local.set 24
                              block  ;; label = @14
                                local.get 29
                                i32.const 214748364
                                i32.gt_u
                                br_if 0 (;@14;)
                                i32.const -1
                                local.get 29
                                i32.const 10
                                i32.mul
                                local.tee 1
                                local.get 28
                                i32.add
                                local.get 28
                                local.get 1
                                i32.const 2147483647
                                i32.xor
                                i32.gt_u
                                select
                                local.set 24
                              end
                              i32.const 1
                              local.set 27
                              local.get 22
                              i32.load8_s offset=1
                              local.set 28
                              local.get 24
                              local.set 29
                              local.get 22
                              i32.const 1
                              i32.add
                              local.tee 1
                              local.set 22
                              local.get 28
                              i32.const -48
                              i32.add
                              local.tee 28
                              i32.const 10
                              i32.lt_u
                              br_if 0 (;@13;)
                            end
                          end
                          loop  ;; label = @12
                            local.get 19
                            local.set 22
                            local.get 1
                            i32.load8_s
                            local.tee 19
                            i32.const -123
                            i32.add
                            i32.const -58
                            i32.lt_u
                            br_if 1 (;@11;)
                            local.get 1
                            i32.const 1
                            i32.add
                            local.set 1
                            local.get 19
                            local.get 22
                            i32.const 58
                            i32.mul
                            i32.add
                            i32.const 3215
                            i32.add
                            i32.load8_u
                            local.tee 19
                            i32.const -1
                            i32.add
                            i32.const 8
                            i32.lt_u
                            br_if 0 (;@12;)
                          end
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                local.get 19
                                i32.const 27
                                i32.eq
                                br_if 0 (;@14;)
                                local.get 19
                                i32.eqz
                                br_if 3 (;@11;)
                                block  ;; label = @15
                                  local.get 23
                                  i32.const 0
                                  i32.lt_s
                                  br_if 0 (;@15;)
                                  local.get 4
                                  local.get 23
                                  i32.const 2
                                  i32.shl
                                  i32.add
                                  local.get 19
                                  i32.store
                                  local.get 5
                                  local.get 3
                                  local.get 23
                                  i32.const 3
                                  i32.shl
                                  i32.add
                                  i64.load
                                  i64.store offset=56
                                  br 2 (;@13;)
                                end
                                block  ;; label = @15
                                  local.get 0
                                  br_if 0 (;@15;)
                                  i32.const 0
                                  local.set 18
                                  br 14 (;@1;)
                                end
                                local.get 5
                                i32.const 56
                                i32.add
                                local.get 19
                                local.get 2
                                call $pop_arg
                                br 2 (;@12;)
                              end
                              local.get 23
                              i32.const -1
                              i32.gt_s
                              br_if 2 (;@11;)
                            end
                            i32.const 0
                            local.set 19
                            local.get 0
                            i32.eqz
                            br_if 8 (;@4;)
                          end
                          local.get 25
                          i32.const -65537
                          i32.and
                          local.tee 29
                          local.get 25
                          local.get 25
                          i32.const 8192
                          i32.and
                          select
                          local.set 30
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  block  ;; label = @16
                                    block  ;; label = @17
                                      block  ;; label = @18
                                        block  ;; label = @19
                                          block  ;; label = @20
                                            block  ;; label = @21
                                              block  ;; label = @22
                                                block  ;; label = @23
                                                  block  ;; label = @24
                                                    block  ;; label = @25
                                                      block  ;; label = @26
                                                        block  ;; label = @27
                                                          block  ;; label = @28
                                                            local.get 1
                                                            i32.const -1
                                                            i32.add
                                                            i32.load8_s
                                                            local.tee 19
                                                            i32.const -33
                                                            i32.and
                                                            local.get 19
                                                            local.get 19
                                                            i32.const 15
                                                            i32.and
                                                            i32.const 3
                                                            i32.eq
                                                            select
                                                            local.get 19
                                                            local.get 22
                                                            select
                                                            local.tee 31
                                                            i32.const -65
                                                            i32.add
                                                            br_table 16 (;@12;) 18 (;@10;) 13 (;@15;) 18 (;@10;) 16 (;@12;) 16 (;@12;) 16 (;@12;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 12 (;@16;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 3 (;@25;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 16 (;@12;) 18 (;@10;) 8 (;@20;) 5 (;@23;) 16 (;@12;) 16 (;@12;) 16 (;@12;) 18 (;@10;) 5 (;@23;) 18 (;@10;) 18 (;@10;) 18 (;@10;) 9 (;@19;) 1 (;@27;) 4 (;@24;) 2 (;@26;) 18 (;@10;) 18 (;@10;) 10 (;@18;) 18 (;@10;) 0 (;@28;) 18 (;@10;) 18 (;@10;) 3 (;@25;) 18 (;@10;)
                                                          end
                                                          i32.const 0
                                                          local.set 28
                                                          i32.const 1024
                                                          local.set 23
                                                          local.get 5
                                                          i64.load offset=56
                                                          local.set 32
                                                          br 5 (;@22;)
                                                        end
                                                        i32.const 0
                                                        local.set 19
                                                        block  ;; label = @27
                                                          block  ;; label = @28
                                                            block  ;; label = @29
                                                              block  ;; label = @30
                                                                block  ;; label = @31
                                                                  block  ;; label = @32
                                                                    block  ;; label = @33
                                                                      local.get 22
                                                                      i32.const 255
                                                                      i32.and
                                                                      br_table 0 (;@33;) 1 (;@32;) 2 (;@31;) 3 (;@30;) 4 (;@29;) 29 (;@4;) 5 (;@28;) 6 (;@27;) 29 (;@4;)
                                                                    end
                                                                    local.get 5
                                                                    i32.load offset=56
                                                                    local.get 18
                                                                    i32.store
                                                                    br 28 (;@4;)
                                                                  end
                                                                  local.get 5
                                                                  i32.load offset=56
                                                                  local.get 18
                                                                  i32.store
                                                                  br 27 (;@4;)
                                                                end
                                                                local.get 5
                                                                i32.load offset=56
                                                                local.get 18
                                                                i64.extend_i32_s
                                                                i64.store
                                                                br 26 (;@4;)
                                                              end
                                                              local.get 5
                                                              i32.load offset=56
                                                              local.get 18
                                                              i32.store16
                                                              br 25 (;@4;)
                                                            end
                                                            local.get 5
                                                            i32.load offset=56
                                                            local.get 18
                                                            i32.store8
                                                            br 24 (;@4;)
                                                          end
                                                          local.get 5
                                                          i32.load offset=56
                                                          local.get 18
                                                          i32.store
                                                          br 23 (;@4;)
                                                        end
                                                        local.get 5
                                                        i32.load offset=56
                                                        local.get 18
                                                        i64.extend_i32_s
                                                        i64.store
                                                        br 22 (;@4;)
                                                      end
                                                      local.get 24
                                                      i32.const 8
                                                      local.get 24
                                                      i32.const 8
                                                      i32.gt_u
                                                      select
                                                      local.set 24
                                                      local.get 30
                                                      i32.const 8
                                                      i32.or
                                                      local.set 30
                                                      i32.const 120
                                                      local.set 31
                                                    end
                                                    i32.const 0
                                                    local.set 28
                                                    i32.const 1024
                                                    local.set 23
                                                    block  ;; label = @25
                                                      local.get 5
                                                      i64.load offset=56
                                                      local.tee 32
                                                      i64.eqz
                                                      i32.eqz
                                                      br_if 0 (;@25;)
                                                      local.get 16
                                                      local.set 20
                                                      br 4 (;@21;)
                                                    end
                                                    local.get 31
                                                    i32.const 32
                                                    i32.and
                                                    local.set 22
                                                    local.get 16
                                                    local.set 20
                                                    loop  ;; label = @25
                                                      local.get 20
                                                      i32.const -1
                                                      i32.add
                                                      local.tee 20
                                                      local.get 32
                                                      i32.wrap_i64
                                                      i32.const 15
                                                      i32.and
                                                      i32.const 3744
                                                      i32.add
                                                      i32.load8_u
                                                      local.get 22
                                                      i32.or
                                                      i32.store8
                                                      local.get 32
                                                      i64.const 15
                                                      i64.gt_u
                                                      local.set 19
                                                      local.get 32
                                                      i64.const 4
                                                      i64.shr_u
                                                      local.set 32
                                                      local.get 19
                                                      br_if 0 (;@25;)
                                                    end
                                                    local.get 30
                                                    i32.const 8
                                                    i32.and
                                                    i32.eqz
                                                    br_if 3 (;@21;)
                                                    local.get 31
                                                    i32.const 4
                                                    i32.shr_s
                                                    i32.const 1024
                                                    i32.add
                                                    local.set 23
                                                    i32.const 2
                                                    local.set 28
                                                    br 3 (;@21;)
                                                  end
                                                  local.get 16
                                                  local.set 20
                                                  block  ;; label = @24
                                                    local.get 5
                                                    i64.load offset=56
                                                    local.tee 32
                                                    i64.eqz
                                                    br_if 0 (;@24;)
                                                    local.get 16
                                                    local.set 20
                                                    loop  ;; label = @25
                                                      local.get 20
                                                      i32.const -1
                                                      i32.add
                                                      local.tee 20
                                                      local.get 32
                                                      i32.wrap_i64
                                                      i32.const 7
                                                      i32.and
                                                      i32.const 48
                                                      i32.or
                                                      i32.store8
                                                      local.get 32
                                                      i64.const 7
                                                      i64.gt_u
                                                      local.set 19
                                                      local.get 32
                                                      i64.const 3
                                                      i64.shr_u
                                                      local.set 32
                                                      local.get 19
                                                      br_if 0 (;@25;)
                                                    end
                                                  end
                                                  i32.const 0
                                                  local.set 28
                                                  i32.const 1024
                                                  local.set 23
                                                  local.get 30
                                                  i32.const 8
                                                  i32.and
                                                  i32.eqz
                                                  br_if 2 (;@21;)
                                                  local.get 24
                                                  local.get 16
                                                  local.get 20
                                                  i32.sub
                                                  local.tee 19
                                                  i32.const 1
                                                  i32.add
                                                  local.get 24
                                                  local.get 19
                                                  i32.gt_s
                                                  select
                                                  local.set 24
                                                  br 2 (;@21;)
                                                end
                                                block  ;; label = @23
                                                  local.get 5
                                                  i64.load offset=56
                                                  local.tee 32
                                                  i64.const -1
                                                  i64.gt_s
                                                  br_if 0 (;@23;)
                                                  local.get 5
                                                  i64.const 0
                                                  local.get 32
                                                  i64.sub
                                                  local.tee 32
                                                  i64.store offset=56
                                                  i32.const 1
                                                  local.set 28
                                                  i32.const 1024
                                                  local.set 23
                                                  br 1 (;@22;)
                                                end
                                                block  ;; label = @23
                                                  local.get 30
                                                  i32.const 2048
                                                  i32.and
                                                  i32.eqz
                                                  br_if 0 (;@23;)
                                                  i32.const 1
                                                  local.set 28
                                                  i32.const 1025
                                                  local.set 23
                                                  br 1 (;@22;)
                                                end
                                                i32.const 1026
                                                i32.const 1024
                                                local.get 30
                                                i32.const 1
                                                i32.and
                                                local.tee 28
                                                select
                                                local.set 23
                                              end
                                              block  ;; label = @22
                                                block  ;; label = @23
                                                  local.get 32
                                                  i64.const 4294967296
                                                  i64.ge_u
                                                  br_if 0 (;@23;)
                                                  local.get 32
                                                  local.set 33
                                                  local.get 16
                                                  local.set 20
                                                  br 1 (;@22;)
                                                end
                                                local.get 16
                                                local.set 20
                                                loop  ;; label = @23
                                                  local.get 20
                                                  i32.const -1
                                                  i32.add
                                                  local.tee 20
                                                  local.get 32
                                                  local.get 32
                                                  i64.const 10
                                                  i64.div_u
                                                  local.tee 33
                                                  i64.const 10
                                                  i64.mul
                                                  i64.sub
                                                  i32.wrap_i64
                                                  i32.const 48
                                                  i32.or
                                                  i32.store8
                                                  local.get 32
                                                  i64.const 42949672959
                                                  i64.gt_u
                                                  local.set 19
                                                  local.get 33
                                                  local.set 32
                                                  local.get 19
                                                  br_if 0 (;@23;)
                                                end
                                              end
                                              local.get 33
                                              i32.wrap_i64
                                              local.tee 19
                                              i32.eqz
                                              br_if 0 (;@21;)
                                              loop  ;; label = @22
                                                local.get 20
                                                i32.const -1
                                                i32.add
                                                local.tee 20
                                                local.get 19
                                                local.get 19
                                                i32.const 10
                                                i32.div_u
                                                local.tee 22
                                                i32.const 10
                                                i32.mul
                                                i32.sub
                                                i32.const 48
                                                i32.or
                                                i32.store8
                                                local.get 19
                                                i32.const 9
                                                i32.gt_u
                                                local.set 25
                                                local.get 22
                                                local.set 19
                                                local.get 25
                                                br_if 0 (;@22;)
                                              end
                                            end
                                            block  ;; label = @21
                                              local.get 27
                                              i32.eqz
                                              br_if 0 (;@21;)
                                              local.get 24
                                              i32.const 0
                                              i32.lt_s
                                              br_if 18 (;@3;)
                                            end
                                            local.get 30
                                            i32.const -65537
                                            i32.and
                                            local.get 30
                                            local.get 27
                                            select
                                            local.set 29
                                            block  ;; label = @21
                                              local.get 5
                                              i64.load offset=56
                                              local.tee 32
                                              i64.const 0
                                              i64.ne
                                              br_if 0 (;@21;)
                                              i32.const 0
                                              local.set 25
                                              local.get 24
                                              br_if 0 (;@21;)
                                              local.get 16
                                              local.set 20
                                              local.get 16
                                              local.set 19
                                              br 12 (;@9;)
                                            end
                                            local.get 24
                                            local.get 16
                                            local.get 20
                                            i32.sub
                                            local.get 32
                                            i64.eqz
                                            i32.add
                                            local.tee 19
                                            local.get 24
                                            local.get 19
                                            i32.gt_s
                                            select
                                            local.set 25
                                            local.get 16
                                            local.set 19
                                            br 11 (;@9;)
                                          end
                                          local.get 5
                                          local.get 5
                                          i64.load offset=56
                                          i64.store8 offset=55
                                          i32.const 0
                                          local.set 28
                                          i32.const 1024
                                          local.set 23
                                          i32.const 1
                                          local.set 25
                                          local.get 9
                                          local.set 20
                                          local.get 16
                                          local.set 19
                                          br 10 (;@9;)
                                        end
                                        i32.const 4644
                                        i32.load
                                        call $strerror
                                        local.set 20
                                        br 1 (;@17;)
                                      end
                                      local.get 5
                                      i32.load offset=56
                                      local.tee 19
                                      i32.const 1133
                                      local.get 19
                                      select
                                      local.set 20
                                    end
                                    local.get 20
                                    local.get 20
                                    local.get 24
                                    i32.const 2147483647
                                    local.get 24
                                    i32.const 2147483647
                                    i32.lt_u
                                    select
                                    call $strnlen
                                    local.tee 25
                                    i32.add
                                    local.set 19
                                    i32.const 0
                                    local.set 28
                                    i32.const 1024
                                    local.set 23
                                    local.get 24
                                    i32.const -1
                                    i32.gt_s
                                    br_if 7 (;@9;)
                                    local.get 19
                                    i32.load8_u
                                    i32.eqz
                                    br_if 7 (;@9;)
                                    br 13 (;@3;)
                                  end
                                  local.get 5
                                  i32.load offset=56
                                  local.set 20
                                  local.get 24
                                  br_if 1 (;@14;)
                                  i32.const 0
                                  local.set 19
                                  br 2 (;@13;)
                                end
                                local.get 5
                                i32.const 0
                                i32.store offset=12
                                local.get 5
                                local.get 5
                                i64.load offset=56
                                i64.store32 offset=8
                                local.get 5
                                local.get 5
                                i32.const 8
                                i32.add
                                i32.store offset=56
                                local.get 5
                                i32.const 8
                                i32.add
                                local.set 20
                                i32.const -1
                                local.set 24
                              end
                              i32.const 0
                              local.set 19
                              local.get 20
                              local.set 21
                              block  ;; label = @14
                                loop  ;; label = @15
                                  local.get 21
                                  i32.load
                                  local.tee 22
                                  i32.eqz
                                  br_if 1 (;@14;)
                                  block  ;; label = @16
                                    local.get 5
                                    i32.const 4
                                    i32.add
                                    local.get 22
                                    call $wctomb
                                    local.tee 22
                                    i32.const 0
                                    i32.lt_s
                                    local.tee 25
                                    br_if 0 (;@16;)
                                    local.get 22
                                    local.get 24
                                    local.get 19
                                    i32.sub
                                    i32.gt_u
                                    br_if 0 (;@16;)
                                    local.get 21
                                    i32.const 4
                                    i32.add
                                    local.set 21
                                    local.get 24
                                    local.get 22
                                    local.get 19
                                    i32.add
                                    local.tee 19
                                    i32.gt_u
                                    br_if 1 (;@15;)
                                    br 2 (;@14;)
                                  end
                                end
                                local.get 25
                                br_if 12 (;@2;)
                              end
                              local.get 19
                              i32.const 0
                              i32.lt_s
                              br_if 10 (;@3;)
                            end
                            block  ;; label = @13
                              local.get 30
                              i32.const 73728
                              i32.and
                              local.tee 25
                              br_if 0 (;@13;)
                              local.get 26
                              local.get 19
                              i32.le_s
                              br_if 0 (;@13;)
                              local.get 5
                              i32.const 112
                              i32.add
                              i32.const 32
                              local.get 26
                              local.get 19
                              i32.sub
                              local.tee 21
                              i32.const 256
                              local.get 21
                              i32.const 256
                              i32.lt_u
                              local.tee 22
                              select
                              call $memset
                              drop
                              block  ;; label = @14
                                local.get 22
                                br_if 0 (;@14;)
                                loop  ;; label = @15
                                  block  ;; label = @16
                                    local.get 0
                                    i32.load8_u
                                    i32.const 32
                                    i32.and
                                    br_if 0 (;@16;)
                                    local.get 5
                                    i32.const 112
                                    i32.add
                                    i32.const 256
                                    local.get 0
                                    call $__fwritex
                                    drop
                                  end
                                  local.get 21
                                  i32.const -256
                                  i32.add
                                  local.tee 21
                                  i32.const 255
                                  i32.gt_u
                                  br_if 0 (;@15;)
                                end
                              end
                              local.get 0
                              i32.load8_u
                              i32.const 32
                              i32.and
                              br_if 0 (;@13;)
                              local.get 5
                              i32.const 112
                              i32.add
                              local.get 21
                              local.get 0
                              call $__fwritex
                              drop
                            end
                            block  ;; label = @13
                              local.get 19
                              i32.eqz
                              br_if 0 (;@13;)
                              i32.const 0
                              local.set 21
                              loop  ;; label = @14
                                local.get 20
                                i32.load
                                local.tee 22
                                i32.eqz
                                br_if 1 (;@13;)
                                local.get 5
                                i32.const 4
                                i32.add
                                local.get 22
                                call $wctomb
                                local.tee 22
                                local.get 21
                                i32.add
                                local.tee 21
                                local.get 19
                                i32.gt_u
                                br_if 1 (;@13;)
                                block  ;; label = @15
                                  local.get 0
                                  i32.load8_u
                                  i32.const 32
                                  i32.and
                                  br_if 0 (;@15;)
                                  local.get 5
                                  i32.const 4
                                  i32.add
                                  local.get 22
                                  local.get 0
                                  call $__fwritex
                                  drop
                                end
                                local.get 20
                                i32.const 4
                                i32.add
                                local.set 20
                                local.get 21
                                local.get 19
                                i32.lt_u
                                br_if 0 (;@14;)
                              end
                            end
                            block  ;; label = @13
                              local.get 25
                              i32.const 8192
                              i32.ne
                              br_if 0 (;@13;)
                              local.get 26
                              local.get 19
                              i32.le_s
                              br_if 0 (;@13;)
                              local.get 5
                              i32.const 112
                              i32.add
                              i32.const 32
                              local.get 26
                              local.get 19
                              i32.sub
                              local.tee 21
                              i32.const 256
                              local.get 21
                              i32.const 256
                              i32.lt_u
                              local.tee 22
                              select
                              call $memset
                              drop
                              block  ;; label = @14
                                local.get 22
                                br_if 0 (;@14;)
                                loop  ;; label = @15
                                  block  ;; label = @16
                                    local.get 0
                                    i32.load8_u
                                    i32.const 32
                                    i32.and
                                    br_if 0 (;@16;)
                                    local.get 5
                                    i32.const 112
                                    i32.add
                                    i32.const 256
                                    local.get 0
                                    call $__fwritex
                                    drop
                                  end
                                  local.get 21
                                  i32.const -256
                                  i32.add
                                  local.tee 21
                                  i32.const 255
                                  i32.gt_u
                                  br_if 0 (;@15;)
                                end
                              end
                              local.get 0
                              i32.load8_u
                              i32.const 32
                              i32.and
                              br_if 0 (;@13;)
                              local.get 5
                              i32.const 112
                              i32.add
                              local.get 21
                              local.get 0
                              call $__fwritex
                              drop
                            end
                            local.get 26
                            local.get 19
                            local.get 26
                            local.get 19
                            i32.gt_s
                            select
                            local.set 19
                            br 8 (;@4;)
                          end
                          block  ;; label = @12
                            local.get 27
                            i32.eqz
                            br_if 0 (;@12;)
                            local.get 24
                            i32.const 0
                            i32.lt_s
                            br_if 9 (;@3;)
                          end
                          local.get 5
                          f64.load offset=56
                          local.set 34
                          local.get 5
                          i32.const 0
                          i32.store offset=108
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 34
                              i64.reinterpret_f64
                              i64.const -1
                              i64.gt_s
                              br_if 0 (;@13;)
                              local.get 34
                              f64.neg
                              local.set 34
                              i32.const 1
                              local.set 35
                              i32.const 0
                              local.set 36
                              i32.const 1034
                              local.set 37
                              br 1 (;@12;)
                            end
                            block  ;; label = @13
                              local.get 30
                              i32.const 2048
                              i32.and
                              i32.eqz
                              br_if 0 (;@13;)
                              i32.const 1
                              local.set 35
                              i32.const 0
                              local.set 36
                              i32.const 1037
                              local.set 37
                              br 1 (;@12;)
                            end
                            i32.const 1040
                            i32.const 1035
                            local.get 30
                            i32.const 1
                            i32.and
                            local.tee 35
                            select
                            local.set 37
                            local.get 35
                            i32.eqz
                            local.set 36
                          end
                          block  ;; label = @12
                            local.get 34
                            f64.abs
                            f64.const inf (;=inf;)
                            f64.lt
                            br_if 0 (;@12;)
                            local.get 35
                            i32.const 3
                            i32.add
                            local.set 21
                            block  ;; label = @13
                              local.get 30
                              i32.const 8192
                              i32.and
                              br_if 0 (;@13;)
                              local.get 26
                              local.get 21
                              i32.le_s
                              br_if 0 (;@13;)
                              local.get 5
                              i32.const 624
                              i32.add
                              i32.const 32
                              local.get 26
                              local.get 21
                              i32.sub
                              local.tee 19
                              i32.const 256
                              local.get 19
                              i32.const 256
                              i32.lt_u
                              local.tee 22
                              select
                              call $memset
                              drop
                              block  ;; label = @14
                                local.get 22
                                br_if 0 (;@14;)
                                loop  ;; label = @15
                                  block  ;; label = @16
                                    local.get 0
                                    i32.load8_u
                                    i32.const 32
                                    i32.and
                                    br_if 0 (;@16;)
                                    local.get 5
                                    i32.const 624
                                    i32.add
                                    i32.const 256
                                    local.get 0
                                    call $__fwritex
                                    drop
                                  end
                                  local.get 19
                                  i32.const -256
                                  i32.add
                                  local.tee 19
                                  i32.const 255
                                  i32.gt_u
                                  br_if 0 (;@15;)
                                end
                              end
                              local.get 0
                              i32.load8_u
                              i32.const 32
                              i32.and
                              br_if 0 (;@13;)
                              local.get 5
                              i32.const 624
                              i32.add
                              local.get 19
                              local.get 0
                              call $__fwritex
                              drop
                            end
                            block  ;; label = @13
                              local.get 0
                              i32.load
                              local.tee 19
                              i32.const 32
                              i32.and
                              br_if 0 (;@13;)
                              local.get 37
                              local.get 35
                              local.get 0
                              call $__fwritex
                              drop
                              local.get 0
                              i32.load
                              local.set 19
                            end
                            block  ;; label = @13
                              local.get 19
                              i32.const 32
                              i32.and
                              br_if 0 (;@13;)
                              i32.const 1067
                              i32.const 1086
                              local.get 31
                              i32.const 32
                              i32.and
                              local.tee 19
                              select
                              i32.const 1071
                              i32.const 1090
                              local.get 19
                              select
                              local.get 34
                              local.get 34
                              f64.ne
                              select
                              i32.const 3
                              local.get 0
                              call $__fwritex
                              drop
                            end
                            block  ;; label = @13
                              local.get 30
                              i32.const 73728
                              i32.and
                              i32.const 8192
                              i32.ne
                              br_if 0 (;@13;)
                              local.get 26
                              local.get 21
                              i32.le_s
                              br_if 0 (;@13;)
                              local.get 5
                              i32.const 624
                              i32.add
                              i32.const 32
                              local.get 26
                              local.get 21
                              i32.sub
                              local.tee 19
                              i32.const 256
                              local.get 19
                              i32.const 256
                              i32.lt_u
                              local.tee 22
                              select
                              call $memset
                              drop
                              block  ;; label = @14
                                local.get 22
                                br_if 0 (;@14;)
                                loop  ;; label = @15
                                  block  ;; label = @16
                                    local.get 0
                                    i32.load8_u
                                    i32.const 32
                                    i32.and
                                    br_if 0 (;@16;)
                                    local.get 5
                                    i32.const 624
                                    i32.add
                                    i32.const 256
                                    local.get 0
                                    call $__fwritex
                                    drop
                                  end
                                  local.get 19
                                  i32.const -256
                                  i32.add
                                  local.tee 19
                                  i32.const 255
                                  i32.gt_u
                                  br_if 0 (;@15;)
                                end
                              end
                              local.get 0
                              i32.load8_u
                              i32.const 32
                              i32.and
                              br_if 0 (;@13;)
                              local.get 5
                              i32.const 624
                              i32.add
                              local.get 19
                              local.get 0
                              call $__fwritex
                              drop
                            end
                            local.get 21
                            local.get 26
                            local.get 21
                            local.get 26
                            i32.gt_s
                            select
                            local.set 19
                            br 8 (;@4;)
                          end
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                local.get 34
                                local.get 5
                                i32.const 108
                                i32.add
                                call $frexp
                                local.tee 34
                                local.get 34
                                f64.add
                                local.tee 34
                                f64.const 0x0p+0 (;=0;)
                                f64.eq
                                br_if 0 (;@14;)
                                local.get 5
                                local.get 5
                                i32.load offset=108
                                local.tee 19
                                i32.const -1
                                i32.add
                                i32.store offset=108
                                local.get 31
                                i32.const 32
                                i32.or
                                local.tee 38
                                i32.const 97
                                i32.ne
                                br_if 1 (;@13;)
                                br 8 (;@6;)
                              end
                              local.get 31
                              i32.const 32
                              i32.or
                              local.tee 38
                              i32.const 97
                              i32.eq
                              br_if 7 (;@6;)
                              i32.const 6
                              local.get 24
                              local.get 24
                              i32.const 0
                              i32.lt_s
                              select
                              local.set 27
                              local.get 5
                              i32.load offset=108
                              local.set 20
                              br 1 (;@12;)
                            end
                            local.get 5
                            local.get 19
                            i32.const -29
                            i32.add
                            local.tee 20
                            i32.store offset=108
                            i32.const 6
                            local.get 24
                            local.get 24
                            i32.const 0
                            i32.lt_s
                            select
                            local.set 27
                            local.get 34
                            f64.const 0x1p+28 (;=2.68435e+08;)
                            f64.mul
                            local.set 34
                          end
                          local.get 5
                          i32.const 112
                          i32.add
                          i32.const 0
                          i32.const 72
                          local.get 20
                          i32.const 0
                          i32.lt_s
                          local.tee 39
                          select
                          i32.const 2
                          i32.shl
                          local.tee 40
                          i32.add
                          local.tee 23
                          local.set 21
                          loop  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                local.get 34
                                f64.const 0x1p+32 (;=4.29497e+09;)
                                f64.lt
                                local.get 34
                                f64.const 0x0p+0 (;=0;)
                                f64.ge
                                i32.and
                                i32.eqz
                                br_if 0 (;@14;)
                                local.get 34
                                i32.trunc_f64_u
                                local.set 19
                                br 1 (;@13;)
                              end
                              i32.const 0
                              local.set 19
                            end
                            local.get 21
                            local.get 19
                            i32.store
                            local.get 21
                            i32.const 4
                            i32.add
                            local.set 21
                            local.get 34
                            local.get 19
                            f64.convert_i32_u
                            f64.sub
                            f64.const 0x1.dcd65p+29 (;=1e+09;)
                            f64.mul
                            local.tee 34
                            f64.const 0x0p+0 (;=0;)
                            f64.ne
                            br_if 0 (;@12;)
                          end
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 20
                              i32.const 1
                              i32.ge_s
                              br_if 0 (;@13;)
                              local.get 21
                              local.set 19
                              local.get 23
                              local.set 22
                              br 1 (;@12;)
                            end
                            local.get 23
                            local.set 22
                            loop  ;; label = @13
                              local.get 20
                              i32.const 29
                              local.get 20
                              i32.const 29
                              i32.lt_s
                              select
                              local.set 20
                              block  ;; label = @14
                                local.get 21
                                i32.const -4
                                i32.add
                                local.tee 19
                                local.get 22
                                i32.lt_u
                                br_if 0 (;@14;)
                                local.get 20
                                i64.extend_i32_u
                                local.set 33
                                i64.const 0
                                local.set 32
                                loop  ;; label = @15
                                  local.get 19
                                  local.get 19
                                  i64.load32_u
                                  local.get 33
                                  i64.shl
                                  local.get 32
                                  i64.const 4294967295
                                  i64.and
                                  i64.add
                                  local.tee 32
                                  local.get 32
                                  i64.const 1000000000
                                  i64.div_u
                                  local.tee 32
                                  i64.const 1000000000
                                  i64.mul
                                  i64.sub
                                  i64.store32
                                  local.get 19
                                  i32.const -4
                                  i32.add
                                  local.tee 19
                                  local.get 22
                                  i32.ge_u
                                  br_if 0 (;@15;)
                                end
                                local.get 32
                                i32.wrap_i64
                                local.tee 19
                                i32.eqz
                                br_if 0 (;@14;)
                                local.get 22
                                i32.const -4
                                i32.add
                                local.tee 22
                                local.get 19
                                i32.store
                              end
                              block  ;; label = @14
                                loop  ;; label = @15
                                  local.get 21
                                  local.tee 19
                                  local.get 22
                                  i32.le_u
                                  br_if 1 (;@14;)
                                  local.get 19
                                  i32.const -4
                                  i32.add
                                  local.tee 21
                                  i32.load
                                  i32.eqz
                                  br_if 0 (;@15;)
                                end
                              end
                              local.get 5
                              local.get 5
                              i32.load offset=108
                              local.get 20
                              i32.sub
                              local.tee 20
                              i32.store offset=108
                              local.get 19
                              local.set 21
                              local.get 20
                              i32.const 0
                              i32.gt_s
                              br_if 0 (;@13;)
                            end
                          end
                          block  ;; label = @12
                            local.get 20
                            i32.const -1
                            i32.gt_s
                            br_if 0 (;@12;)
                            local.get 27
                            i32.const 25
                            i32.add
                            i32.const 9
                            i32.div_u
                            i32.const 1
                            i32.add
                            local.set 41
                            loop  ;; label = @13
                              i32.const 0
                              local.get 20
                              i32.sub
                              local.tee 21
                              i32.const 9
                              local.get 21
                              i32.const 9
                              i32.lt_s
                              select
                              local.set 24
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 22
                                  local.get 19
                                  i32.lt_u
                                  br_if 0 (;@15;)
                                  local.get 22
                                  i32.load
                                  local.set 21
                                  br 1 (;@14;)
                                end
                                i32.const 1000000000
                                local.get 24
                                i32.shr_u
                                local.set 29
                                i32.const -1
                                local.get 24
                                i32.shl
                                i32.const -1
                                i32.xor
                                local.set 28
                                i32.const 0
                                local.set 20
                                local.get 22
                                local.set 21
                                loop  ;; label = @15
                                  local.get 21
                                  local.get 21
                                  i32.load
                                  local.tee 25
                                  local.get 24
                                  i32.shr_u
                                  local.get 20
                                  i32.add
                                  i32.store
                                  local.get 25
                                  local.get 28
                                  i32.and
                                  local.get 29
                                  i32.mul
                                  local.set 20
                                  local.get 21
                                  i32.const 4
                                  i32.add
                                  local.tee 21
                                  local.get 19
                                  i32.lt_u
                                  br_if 0 (;@15;)
                                end
                                local.get 22
                                i32.load
                                local.set 21
                                local.get 20
                                i32.eqz
                                br_if 0 (;@14;)
                                local.get 19
                                local.get 20
                                i32.store
                                local.get 19
                                i32.const 4
                                i32.add
                                local.set 19
                              end
                              local.get 5
                              local.get 5
                              i32.load offset=108
                              local.get 24
                              i32.add
                              local.tee 20
                              i32.store offset=108
                              local.get 23
                              local.get 22
                              local.get 21
                              i32.eqz
                              i32.const 2
                              i32.shl
                              i32.add
                              local.tee 22
                              local.get 38
                              i32.const 102
                              i32.eq
                              select
                              local.tee 21
                              local.get 41
                              i32.const 2
                              i32.shl
                              i32.add
                              local.get 19
                              local.get 19
                              local.get 21
                              i32.sub
                              i32.const 2
                              i32.shr_s
                              local.get 41
                              i32.gt_s
                              select
                              local.set 19
                              local.get 20
                              i32.const 0
                              i32.lt_s
                              br_if 0 (;@13;)
                            end
                          end
                          i32.const 0
                          local.set 25
                          block  ;; label = @12
                            local.get 22
                            local.get 19
                            i32.ge_u
                            br_if 0 (;@12;)
                            local.get 23
                            local.get 22
                            i32.sub
                            i32.const 2
                            i32.shr_s
                            i32.const 9
                            i32.mul
                            local.set 25
                            local.get 22
                            i32.load
                            local.tee 20
                            i32.const 10
                            i32.lt_u
                            br_if 0 (;@12;)
                            i32.const 10
                            local.set 21
                            loop  ;; label = @13
                              local.get 25
                              i32.const 1
                              i32.add
                              local.set 25
                              local.get 20
                              local.get 21
                              i32.const 10
                              i32.mul
                              local.tee 21
                              i32.ge_u
                              br_if 0 (;@13;)
                            end
                          end
                          block  ;; label = @12
                            local.get 27
                            i32.const 0
                            local.get 25
                            local.get 38
                            i32.const 102
                            i32.eq
                            select
                            i32.sub
                            local.get 27
                            i32.const 0
                            i32.ne
                            local.get 38
                            i32.const 103
                            i32.eq
                            local.tee 28
                            i32.and
                            i32.sub
                            local.tee 21
                            local.get 19
                            local.get 23
                            i32.sub
                            i32.const 2
                            i32.shr_s
                            i32.const 9
                            i32.mul
                            i32.const -9
                            i32.add
                            i32.ge_s
                            br_if 0 (;@12;)
                            local.get 21
                            i32.const 9216
                            i32.add
                            local.tee 20
                            i32.const 9
                            i32.div_s
                            local.tee 24
                            i32.const 2
                            i32.shl
                            local.tee 42
                            local.get 5
                            i32.const 112
                            i32.add
                            i32.const 1
                            i32.const 73
                            local.get 39
                            select
                            i32.const 2
                            i32.shl
                            local.tee 39
                            i32.add
                            i32.add
                            i32.const -4096
                            i32.add
                            local.set 29
                            i32.const 10
                            local.set 21
                            block  ;; label = @13
                              local.get 20
                              local.get 24
                              i32.const 9
                              i32.mul
                              i32.sub
                              local.tee 24
                              i32.const 7
                              i32.gt_s
                              br_if 0 (;@13;)
                              i32.const 8
                              local.get 24
                              i32.sub
                              local.tee 41
                              i32.const 7
                              i32.and
                              local.set 20
                              i32.const 10
                              local.set 21
                              block  ;; label = @14
                                local.get 24
                                i32.const -1
                                i32.add
                                i32.const 7
                                i32.lt_u
                                br_if 0 (;@14;)
                                local.get 41
                                i32.const -8
                                i32.and
                                local.set 24
                                i32.const 10
                                local.set 21
                                loop  ;; label = @15
                                  local.get 21
                                  i32.const 100000000
                                  i32.mul
                                  local.set 21
                                  local.get 24
                                  i32.const -8
                                  i32.add
                                  local.tee 24
                                  br_if 0 (;@15;)
                                end
                              end
                              local.get 20
                              i32.eqz
                              br_if 0 (;@13;)
                              loop  ;; label = @14
                                local.get 21
                                i32.const 10
                                i32.mul
                                local.set 21
                                local.get 20
                                i32.const -1
                                i32.add
                                local.tee 20
                                br_if 0 (;@14;)
                              end
                            end
                            local.get 29
                            i32.const 4
                            i32.add
                            local.set 41
                            block  ;; label = @13
                              block  ;; label = @14
                                local.get 29
                                i32.load
                                local.tee 20
                                local.get 20
                                local.get 21
                                i32.div_u
                                local.tee 38
                                local.get 21
                                i32.mul
                                i32.sub
                                local.tee 24
                                br_if 0 (;@14;)
                                local.get 41
                                local.get 19
                                i32.eq
                                br_if 1 (;@13;)
                              end
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 38
                                  i32.const 1
                                  i32.and
                                  br_if 0 (;@15;)
                                  f64.const 0x1p+53 (;=9.0072e+15;)
                                  local.set 34
                                  local.get 21
                                  i32.const 1000000000
                                  i32.ne
                                  br_if 1 (;@14;)
                                  local.get 29
                                  local.get 22
                                  i32.le_u
                                  br_if 1 (;@14;)
                                  local.get 29
                                  i32.const -4
                                  i32.add
                                  i32.load8_u
                                  i32.const 1
                                  i32.and
                                  i32.eqz
                                  br_if 1 (;@14;)
                                end
                                f64.const 0x1.0000000000001p+53 (;=9.0072e+15;)
                                local.set 34
                              end
                              f64.const 0x1p-1 (;=0.5;)
                              f64.const 0x1p+0 (;=1;)
                              f64.const 0x1.8p+0 (;=1.5;)
                              local.get 41
                              local.get 19
                              i32.eq
                              select
                              f64.const 0x1.8p+0 (;=1.5;)
                              local.get 24
                              local.get 21
                              i32.const 1
                              i32.shr_u
                              local.tee 41
                              i32.eq
                              select
                              local.get 24
                              local.get 41
                              i32.lt_u
                              select
                              local.set 43
                              block  ;; label = @14
                                local.get 36
                                br_if 0 (;@14;)
                                local.get 37
                                i32.load8_u
                                i32.const 45
                                i32.ne
                                br_if 0 (;@14;)
                                local.get 43
                                f64.neg
                                local.set 43
                                local.get 34
                                f64.neg
                                local.set 34
                              end
                              local.get 29
                              local.get 20
                              local.get 24
                              i32.sub
                              local.tee 20
                              i32.store
                              local.get 34
                              local.get 43
                              f64.add
                              local.get 34
                              f64.eq
                              br_if 0 (;@13;)
                              local.get 29
                              local.get 20
                              local.get 21
                              i32.add
                              local.tee 21
                              i32.store
                              block  ;; label = @14
                                local.get 21
                                i32.const 1000000000
                                i32.lt_u
                                br_if 0 (;@14;)
                                local.get 8
                                local.get 39
                                local.get 42
                                i32.add
                                i32.add
                                local.set 21
                                loop  ;; label = @15
                                  local.get 21
                                  i32.const 4
                                  i32.add
                                  i32.const 0
                                  i32.store
                                  block  ;; label = @16
                                    local.get 21
                                    local.get 22
                                    i32.ge_u
                                    br_if 0 (;@16;)
                                    local.get 22
                                    i32.const -4
                                    i32.add
                                    local.tee 22
                                    i32.const 0
                                    i32.store
                                  end
                                  local.get 21
                                  local.get 21
                                  i32.load
                                  i32.const 1
                                  i32.add
                                  local.tee 20
                                  i32.store
                                  local.get 21
                                  i32.const -4
                                  i32.add
                                  local.set 21
                                  local.get 20
                                  i32.const 999999999
                                  i32.gt_u
                                  br_if 0 (;@15;)
                                end
                                local.get 21
                                i32.const 4
                                i32.add
                                local.set 29
                              end
                              local.get 23
                              local.get 22
                              i32.sub
                              i32.const 2
                              i32.shr_s
                              i32.const 9
                              i32.mul
                              local.set 25
                              local.get 22
                              i32.load
                              local.tee 20
                              i32.const 10
                              i32.lt_u
                              br_if 0 (;@13;)
                              i32.const 10
                              local.set 21
                              loop  ;; label = @14
                                local.get 25
                                i32.const 1
                                i32.add
                                local.set 25
                                local.get 20
                                local.get 21
                                i32.const 10
                                i32.mul
                                local.tee 21
                                i32.ge_u
                                br_if 0 (;@14;)
                              end
                            end
                            local.get 29
                            i32.const 4
                            i32.add
                            local.tee 21
                            local.get 19
                            local.get 19
                            local.get 21
                            i32.gt_u
                            select
                            local.set 19
                          end
                          local.get 7
                          local.get 19
                          i32.add
                          local.get 40
                          i32.sub
                          local.set 21
                          block  ;; label = @12
                            loop  ;; label = @13
                              local.get 21
                              local.set 20
                              local.get 19
                              local.tee 29
                              local.get 22
                              i32.le_u
                              local.tee 24
                              br_if 1 (;@12;)
                              local.get 20
                              i32.const -4
                              i32.add
                              local.set 21
                              local.get 29
                              i32.const -4
                              i32.add
                              local.tee 19
                              i32.load
                              i32.eqz
                              br_if 0 (;@13;)
                            end
                          end
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 28
                              br_if 0 (;@13;)
                              local.get 30
                              i32.const 8
                              i32.and
                              local.set 41
                              br 1 (;@12;)
                            end
                            local.get 25
                            i32.const -1
                            i32.xor
                            i32.const -1
                            local.get 27
                            i32.const 1
                            local.get 27
                            select
                            local.tee 19
                            local.get 25
                            i32.gt_s
                            local.get 25
                            i32.const -5
                            i32.gt_s
                            i32.and
                            local.tee 21
                            select
                            local.get 19
                            i32.add
                            local.set 27
                            i32.const -1
                            i32.const -2
                            local.get 21
                            select
                            local.get 31
                            i32.add
                            local.set 31
                            local.get 30
                            i32.const 8
                            i32.and
                            local.tee 41
                            br_if 0 (;@12;)
                            i32.const -9
                            local.set 19
                            block  ;; label = @13
                              local.get 24
                              br_if 0 (;@13;)
                              local.get 29
                              i32.const -4
                              i32.add
                              i32.load
                              local.tee 24
                              i32.eqz
                              br_if 0 (;@13;)
                              i32.const 0
                              local.set 19
                              local.get 24
                              i32.const 10
                              i32.rem_u
                              br_if 0 (;@13;)
                              i32.const 10
                              local.set 21
                              i32.const 0
                              local.set 19
                              loop  ;; label = @14
                                local.get 19
                                i32.const -1
                                i32.add
                                local.set 19
                                local.get 24
                                local.get 21
                                i32.const 10
                                i32.mul
                                local.tee 21
                                i32.rem_u
                                i32.eqz
                                br_if 0 (;@14;)
                              end
                            end
                            local.get 20
                            i32.const 2
                            i32.shr_s
                            i32.const 9
                            i32.mul
                            i32.const -9
                            i32.add
                            local.set 21
                            block  ;; label = @13
                              local.get 31
                              i32.const -33
                              i32.and
                              i32.const 70
                              i32.ne
                              br_if 0 (;@13;)
                              i32.const 0
                              local.set 41
                              local.get 27
                              local.get 21
                              local.get 19
                              i32.add
                              local.tee 19
                              i32.const 0
                              local.get 19
                              i32.const 0
                              i32.gt_s
                              select
                              local.tee 19
                              local.get 27
                              local.get 19
                              i32.lt_s
                              select
                              local.set 27
                              br 1 (;@12;)
                            end
                            i32.const 0
                            local.set 41
                            local.get 27
                            local.get 21
                            local.get 25
                            i32.add
                            local.get 19
                            i32.add
                            local.tee 19
                            i32.const 0
                            local.get 19
                            i32.const 0
                            i32.gt_s
                            select
                            local.tee 19
                            local.get 27
                            local.get 19
                            i32.lt_s
                            select
                            local.set 27
                          end
                          local.get 27
                          i32.const 2147483645
                          i32.const 2147483646
                          local.get 27
                          local.get 41
                          i32.or
                          local.tee 36
                          select
                          i32.gt_s
                          br_if 8 (;@3;)
                          local.get 27
                          local.get 36
                          i32.const 0
                          i32.ne
                          i32.add
                          i32.const 1
                          i32.add
                          local.set 38
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 31
                              i32.const -33
                              i32.and
                              i32.const 70
                              i32.ne
                              local.tee 39
                              br_if 0 (;@13;)
                              local.get 25
                              local.get 38
                              i32.const 2147483647
                              i32.xor
                              i32.gt_s
                              br_if 10 (;@3;)
                              local.get 25
                              i32.const 0
                              local.get 25
                              i32.const 0
                              i32.gt_s
                              select
                              local.set 19
                              br 1 (;@12;)
                            end
                            block  ;; label = @13
                              block  ;; label = @14
                                local.get 25
                                br_if 0 (;@14;)
                                local.get 6
                                local.set 20
                                local.get 6
                                local.set 21
                                br 1 (;@13;)
                              end
                              local.get 25
                              local.get 25
                              i32.const 31
                              i32.shr_s
                              local.tee 19
                              i32.xor
                              local.get 19
                              i32.sub
                              local.set 19
                              local.get 6
                              local.set 20
                              local.get 6
                              local.set 21
                              loop  ;; label = @14
                                local.get 21
                                i32.const -1
                                i32.add
                                local.tee 21
                                local.get 19
                                local.get 19
                                i32.const 10
                                i32.div_u
                                local.tee 24
                                i32.const 10
                                i32.mul
                                i32.sub
                                i32.const 48
                                i32.or
                                i32.store8
                                local.get 20
                                i32.const -1
                                i32.add
                                local.set 20
                                local.get 19
                                i32.const 9
                                i32.gt_u
                                local.set 28
                                local.get 24
                                local.set 19
                                local.get 28
                                br_if 0 (;@14;)
                              end
                            end
                            block  ;; label = @13
                              local.get 6
                              local.get 20
                              i32.sub
                              i32.const 1
                              i32.gt_s
                              br_if 0 (;@13;)
                              local.get 21
                              local.get 15
                              local.get 20
                              i32.sub
                              i32.add
                              local.tee 21
                              i32.const 48
                              local.get 14
                              local.get 20
                              i32.add
                              call $memset
                              drop
                            end
                            local.get 21
                            i32.const -2
                            i32.add
                            local.tee 40
                            local.get 31
                            i32.store8
                            local.get 21
                            i32.const -1
                            i32.add
                            i32.const 45
                            i32.const 43
                            local.get 25
                            i32.const 0
                            i32.lt_s
                            select
                            i32.store8
                            local.get 6
                            local.get 40
                            i32.sub
                            local.tee 19
                            local.get 38
                            i32.const 2147483647
                            i32.xor
                            i32.gt_s
                            br_if 9 (;@3;)
                          end
                          local.get 19
                          local.get 38
                          i32.add
                          local.tee 19
                          local.get 35
                          i32.const 2147483647
                          i32.xor
                          i32.gt_s
                          br_if 8 (;@3;)
                          local.get 19
                          local.get 35
                          i32.add
                          local.set 28
                          block  ;; label = @12
                            local.get 30
                            i32.const 73728
                            i32.and
                            local.tee 30
                            br_if 0 (;@12;)
                            local.get 26
                            local.get 28
                            i32.le_s
                            br_if 0 (;@12;)
                            local.get 5
                            i32.const 624
                            i32.add
                            i32.const 32
                            local.get 26
                            local.get 28
                            i32.sub
                            local.tee 19
                            i32.const 256
                            local.get 19
                            i32.const 256
                            i32.lt_u
                            local.tee 21
                            select
                            call $memset
                            drop
                            block  ;; label = @13
                              local.get 21
                              br_if 0 (;@13;)
                              loop  ;; label = @14
                                block  ;; label = @15
                                  local.get 0
                                  i32.load8_u
                                  i32.const 32
                                  i32.and
                                  br_if 0 (;@15;)
                                  local.get 5
                                  i32.const 624
                                  i32.add
                                  i32.const 256
                                  local.get 0
                                  call $__fwritex
                                  drop
                                end
                                local.get 19
                                i32.const -256
                                i32.add
                                local.tee 19
                                i32.const 255
                                i32.gt_u
                                br_if 0 (;@14;)
                              end
                            end
                            local.get 0
                            i32.load8_u
                            i32.const 32
                            i32.and
                            br_if 0 (;@12;)
                            local.get 5
                            i32.const 624
                            i32.add
                            local.get 19
                            local.get 0
                            call $__fwritex
                            drop
                          end
                          block  ;; label = @12
                            local.get 0
                            i32.load8_u
                            i32.const 32
                            i32.and
                            br_if 0 (;@12;)
                            local.get 37
                            local.get 35
                            local.get 0
                            call $__fwritex
                            drop
                          end
                          block  ;; label = @12
                            local.get 30
                            i32.const 65536
                            i32.ne
                            br_if 0 (;@12;)
                            local.get 26
                            local.get 28
                            i32.le_s
                            br_if 0 (;@12;)
                            local.get 5
                            i32.const 624
                            i32.add
                            i32.const 48
                            local.get 26
                            local.get 28
                            i32.sub
                            local.tee 19
                            i32.const 256
                            local.get 19
                            i32.const 256
                            i32.lt_u
                            local.tee 21
                            select
                            call $memset
                            drop
                            block  ;; label = @13
                              local.get 21
                              br_if 0 (;@13;)
                              loop  ;; label = @14
                                block  ;; label = @15
                                  local.get 0
                                  i32.load8_u
                                  i32.const 32
                                  i32.and
                                  br_if 0 (;@15;)
                                  local.get 5
                                  i32.const 624
                                  i32.add
                                  i32.const 256
                                  local.get 0
                                  call $__fwritex
                                  drop
                                end
                                local.get 19
                                i32.const -256
                                i32.add
                                local.tee 19
                                i32.const 255
                                i32.gt_u
                                br_if 0 (;@14;)
                              end
                            end
                            local.get 0
                            i32.load8_u
                            i32.const 32
                            i32.and
                            br_if 0 (;@12;)
                            local.get 5
                            i32.const 624
                            i32.add
                            local.get 19
                            local.get 0
                            call $__fwritex
                            drop
                          end
                          local.get 39
                          br_if 3 (;@8;)
                          local.get 23
                          local.get 22
                          local.get 22
                          local.get 23
                          i32.gt_u
                          select
                          local.tee 25
                          local.set 24
                          loop  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  block  ;; label = @16
                                    local.get 24
                                    i32.load
                                    local.tee 19
                                    i32.eqz
                                    br_if 0 (;@16;)
                                    i32.const 8
                                    local.set 21
                                    loop  ;; label = @17
                                      local.get 5
                                      i32.const 80
                                      i32.add
                                      local.get 21
                                      i32.add
                                      local.get 19
                                      local.get 19
                                      i32.const 10
                                      i32.div_u
                                      local.tee 22
                                      i32.const 10
                                      i32.mul
                                      i32.sub
                                      i32.const 48
                                      i32.or
                                      i32.store8
                                      local.get 21
                                      i32.const -1
                                      i32.add
                                      local.set 21
                                      local.get 19
                                      i32.const 9
                                      i32.gt_u
                                      local.set 20
                                      local.get 22
                                      local.set 19
                                      local.get 20
                                      br_if 0 (;@17;)
                                    end
                                    local.get 21
                                    i32.const 1
                                    i32.add
                                    local.tee 22
                                    local.get 5
                                    i32.const 80
                                    i32.add
                                    i32.add
                                    local.set 19
                                    block  ;; label = @17
                                      local.get 24
                                      local.get 25
                                      i32.eq
                                      br_if 0 (;@17;)
                                      local.get 21
                                      i32.const 2
                                      i32.add
                                      i32.const 2
                                      i32.lt_s
                                      br_if 4 (;@13;)
                                      br 3 (;@14;)
                                    end
                                    local.get 21
                                    i32.const 8
                                    i32.ne
                                    br_if 3 (;@13;)
                                    br 1 (;@15;)
                                  end
                                  i32.const 9
                                  local.set 22
                                  local.get 24
                                  local.get 25
                                  i32.ne
                                  br_if 1 (;@14;)
                                end
                                local.get 5
                                i32.const 48
                                i32.store8 offset=88
                                local.get 12
                                local.set 19
                                br 1 (;@13;)
                              end
                              local.get 5
                              i32.const 80
                              i32.add
                              local.get 22
                              local.get 5
                              i32.const 80
                              i32.add
                              i32.add
                              local.tee 21
                              i32.const -1
                              i32.add
                              local.tee 19
                              local.get 5
                              i32.const 80
                              i32.add
                              local.get 19
                              i32.lt_u
                              select
                              local.tee 19
                              i32.const 48
                              local.get 21
                              local.get 19
                              i32.sub
                              call $memset
                              drop
                            end
                            block  ;; label = @13
                              local.get 0
                              i32.load8_u
                              i32.const 32
                              i32.and
                              br_if 0 (;@13;)
                              local.get 19
                              local.get 13
                              local.get 19
                              i32.sub
                              local.get 0
                              call $__fwritex
                              drop
                            end
                            local.get 24
                            i32.const 4
                            i32.add
                            local.tee 24
                            local.get 23
                            i32.le_u
                            br_if 0 (;@12;)
                          end
                          block  ;; label = @12
                            local.get 36
                            i32.eqz
                            br_if 0 (;@12;)
                            local.get 0
                            i32.load8_u
                            i32.const 32
                            i32.and
                            br_if 0 (;@12;)
                            i32.const 1131
                            i32.const 1
                            local.get 0
                            call $__fwritex
                            drop
                          end
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 24
                              local.get 29
                              i32.lt_u
                              br_if 0 (;@13;)
                              local.get 27
                              local.set 19
                              br 1 (;@12;)
                            end
                            block  ;; label = @13
                              local.get 27
                              i32.const 1
                              i32.ge_s
                              br_if 0 (;@13;)
                              local.get 27
                              local.set 19
                              br 1 (;@12;)
                            end
                            loop  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  block  ;; label = @16
                                    local.get 24
                                    i32.load
                                    local.tee 19
                                    br_if 0 (;@16;)
                                    local.get 13
                                    local.set 21
                                    local.get 13
                                    local.set 22
                                    br 1 (;@15;)
                                  end
                                  local.get 13
                                  local.set 22
                                  local.get 13
                                  local.set 21
                                  loop  ;; label = @16
                                    local.get 21
                                    i32.const -1
                                    i32.add
                                    local.tee 21
                                    local.get 19
                                    local.get 19
                                    i32.const 10
                                    i32.div_u
                                    local.tee 20
                                    i32.const 10
                                    i32.mul
                                    i32.sub
                                    i32.const 48
                                    i32.or
                                    i32.store8
                                    local.get 22
                                    i32.const -1
                                    i32.add
                                    local.set 22
                                    local.get 19
                                    i32.const 9
                                    i32.gt_u
                                    local.set 25
                                    local.get 20
                                    local.set 19
                                    local.get 25
                                    br_if 0 (;@16;)
                                  end
                                  local.get 21
                                  local.get 5
                                  i32.const 80
                                  i32.add
                                  i32.le_u
                                  br_if 1 (;@14;)
                                end
                                local.get 21
                                local.get 5
                                i32.const 80
                                i32.add
                                i32.add
                                local.get 22
                                i32.sub
                                local.tee 21
                                i32.const 48
                                local.get 22
                                local.get 5
                                i32.const 80
                                i32.add
                                i32.sub
                                call $memset
                                drop
                              end
                              block  ;; label = @14
                                local.get 0
                                i32.load8_u
                                i32.const 32
                                i32.and
                                br_if 0 (;@14;)
                                local.get 21
                                local.get 27
                                i32.const 9
                                local.get 27
                                i32.const 9
                                i32.lt_s
                                select
                                local.get 0
                                call $__fwritex
                                drop
                              end
                              local.get 27
                              i32.const -9
                              i32.add
                              local.set 19
                              local.get 24
                              i32.const 4
                              i32.add
                              local.tee 24
                              local.get 29
                              i32.ge_u
                              br_if 1 (;@12;)
                              local.get 27
                              i32.const 9
                              i32.gt_s
                              local.set 21
                              local.get 19
                              local.set 27
                              local.get 21
                              br_if 0 (;@13;)
                            end
                          end
                          local.get 0
                          i32.const 48
                          local.get 19
                          i32.const 9
                          i32.add
                          i32.const 9
                          i32.const 0
                          call $pad
                          br 4 (;@7;)
                        end
                        i32.const 4644
                        i32.const 28
                        i32.store
                        br 8 (;@2;)
                      end
                      i32.const 0
                      local.set 28
                      i32.const 1024
                      local.set 23
                      local.get 16
                      local.set 19
                      local.get 30
                      local.set 29
                      local.get 24
                      local.set 25
                    end
                    local.get 25
                    local.get 19
                    local.get 20
                    i32.sub
                    local.tee 24
                    local.get 25
                    local.get 24
                    i32.gt_s
                    select
                    local.tee 27
                    local.get 28
                    i32.const 2147483647
                    i32.xor
                    i32.gt_s
                    br_if 5 (;@3;)
                    local.get 26
                    local.get 28
                    local.get 27
                    i32.add
                    local.tee 22
                    local.get 26
                    local.get 22
                    i32.gt_s
                    select
                    local.tee 19
                    local.get 21
                    i32.gt_s
                    br_if 5 (;@3;)
                    block  ;; label = @9
                      local.get 29
                      i32.const 73728
                      i32.and
                      local.tee 29
                      br_if 0 (;@9;)
                      local.get 22
                      local.get 26
                      i32.ge_s
                      br_if 0 (;@9;)
                      local.get 5
                      i32.const 112
                      i32.add
                      i32.const 32
                      local.get 19
                      local.get 22
                      i32.sub
                      local.tee 21
                      i32.const 256
                      local.get 21
                      i32.const 256
                      i32.lt_u
                      local.tee 30
                      select
                      call $memset
                      drop
                      block  ;; label = @10
                        local.get 30
                        br_if 0 (;@10;)
                        loop  ;; label = @11
                          block  ;; label = @12
                            local.get 0
                            i32.load8_u
                            i32.const 32
                            i32.and
                            br_if 0 (;@12;)
                            local.get 5
                            i32.const 112
                            i32.add
                            i32.const 256
                            local.get 0
                            call $__fwritex
                            drop
                          end
                          local.get 21
                          i32.const -256
                          i32.add
                          local.tee 21
                          i32.const 255
                          i32.gt_u
                          br_if 0 (;@11;)
                        end
                      end
                      local.get 0
                      i32.load8_u
                      i32.const 32
                      i32.and
                      br_if 0 (;@9;)
                      local.get 5
                      i32.const 112
                      i32.add
                      local.get 21
                      local.get 0
                      call $__fwritex
                      drop
                    end
                    block  ;; label = @9
                      local.get 0
                      i32.load8_u
                      i32.const 32
                      i32.and
                      br_if 0 (;@9;)
                      local.get 23
                      local.get 28
                      local.get 0
                      call $__fwritex
                      drop
                    end
                    block  ;; label = @9
                      local.get 29
                      i32.const 65536
                      i32.ne
                      br_if 0 (;@9;)
                      local.get 22
                      local.get 26
                      i32.ge_s
                      br_if 0 (;@9;)
                      local.get 5
                      i32.const 112
                      i32.add
                      i32.const 48
                      local.get 19
                      local.get 22
                      i32.sub
                      local.tee 21
                      i32.const 256
                      local.get 21
                      i32.const 256
                      i32.lt_u
                      local.tee 28
                      select
                      call $memset
                      drop
                      block  ;; label = @10
                        local.get 28
                        br_if 0 (;@10;)
                        loop  ;; label = @11
                          block  ;; label = @12
                            local.get 0
                            i32.load8_u
                            i32.const 32
                            i32.and
                            br_if 0 (;@12;)
                            local.get 5
                            i32.const 112
                            i32.add
                            i32.const 256
                            local.get 0
                            call $__fwritex
                            drop
                          end
                          local.get 21
                          i32.const -256
                          i32.add
                          local.tee 21
                          i32.const 255
                          i32.gt_u
                          br_if 0 (;@11;)
                        end
                      end
                      local.get 0
                      i32.load8_u
                      i32.const 32
                      i32.and
                      br_if 0 (;@9;)
                      local.get 5
                      i32.const 112
                      i32.add
                      local.get 21
                      local.get 0
                      call $__fwritex
                      drop
                    end
                    block  ;; label = @9
                      local.get 24
                      local.get 25
                      i32.ge_s
                      br_if 0 (;@9;)
                      local.get 5
                      i32.const 112
                      i32.add
                      i32.const 48
                      local.get 27
                      local.get 24
                      i32.sub
                      local.tee 21
                      i32.const 256
                      local.get 21
                      i32.const 256
                      i32.lt_u
                      local.tee 25
                      select
                      call $memset
                      drop
                      block  ;; label = @10
                        local.get 25
                        br_if 0 (;@10;)
                        loop  ;; label = @11
                          block  ;; label = @12
                            local.get 0
                            i32.load8_u
                            i32.const 32
                            i32.and
                            br_if 0 (;@12;)
                            local.get 5
                            i32.const 112
                            i32.add
                            i32.const 256
                            local.get 0
                            call $__fwritex
                            drop
                          end
                          local.get 21
                          i32.const -256
                          i32.add
                          local.tee 21
                          i32.const 255
                          i32.gt_u
                          br_if 0 (;@11;)
                        end
                      end
                      local.get 0
                      i32.load8_u
                      i32.const 32
                      i32.and
                      br_if 0 (;@9;)
                      local.get 5
                      i32.const 112
                      i32.add
                      local.get 21
                      local.get 0
                      call $__fwritex
                      drop
                    end
                    block  ;; label = @9
                      local.get 0
                      i32.load8_u
                      i32.const 32
                      i32.and
                      br_if 0 (;@9;)
                      local.get 20
                      local.get 24
                      local.get 0
                      call $__fwritex
                      drop
                    end
                    local.get 29
                    i32.const 8192
                    i32.ne
                    br_if 4 (;@4;)
                    local.get 22
                    local.get 26
                    i32.ge_s
                    br_if 4 (;@4;)
                    local.get 5
                    i32.const 112
                    i32.add
                    i32.const 32
                    local.get 19
                    local.get 22
                    i32.sub
                    local.tee 21
                    i32.const 256
                    local.get 21
                    i32.const 256
                    i32.lt_u
                    local.tee 22
                    select
                    call $memset
                    drop
                    block  ;; label = @9
                      local.get 22
                      br_if 0 (;@9;)
                      loop  ;; label = @10
                        block  ;; label = @11
                          local.get 0
                          i32.load8_u
                          i32.const 32
                          i32.and
                          br_if 0 (;@11;)
                          local.get 5
                          i32.const 112
                          i32.add
                          i32.const 256
                          local.get 0
                          call $__fwritex
                          drop
                        end
                        local.get 21
                        i32.const -256
                        i32.add
                        local.tee 21
                        i32.const 255
                        i32.gt_u
                        br_if 0 (;@10;)
                      end
                    end
                    local.get 0
                    i32.load8_u
                    i32.const 32
                    i32.and
                    br_if 4 (;@4;)
                    local.get 5
                    i32.const 112
                    i32.add
                    local.get 21
                    local.get 0
                    call $__fwritex
                    drop
                    br 4 (;@4;)
                  end
                  block  ;; label = @8
                    local.get 27
                    i32.const 0
                    i32.lt_s
                    br_if 0 (;@8;)
                    local.get 29
                    local.get 22
                    i32.const 4
                    i32.add
                    local.get 29
                    local.get 22
                    i32.gt_u
                    select
                    local.set 29
                    local.get 22
                    local.set 24
                    loop  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 24
                          i32.load
                          local.tee 19
                          i32.eqz
                          br_if 0 (;@11;)
                          i32.const 0
                          local.set 21
                          loop  ;; label = @12
                            local.get 5
                            i32.const 80
                            i32.add
                            local.get 21
                            i32.add
                            i32.const 8
                            i32.add
                            local.get 19
                            local.get 19
                            i32.const 10
                            i32.div_u
                            local.tee 20
                            i32.const 10
                            i32.mul
                            i32.sub
                            i32.const 48
                            i32.or
                            i32.store8
                            local.get 21
                            i32.const -1
                            i32.add
                            local.set 21
                            local.get 19
                            i32.const 9
                            i32.gt_u
                            local.set 25
                            local.get 20
                            local.set 19
                            local.get 25
                            br_if 0 (;@12;)
                          end
                          local.get 21
                          i32.eqz
                          br_if 0 (;@11;)
                          local.get 5
                          i32.const 80
                          i32.add
                          local.get 21
                          i32.add
                          i32.const 9
                          i32.add
                          local.set 19
                          br 1 (;@10;)
                        end
                        local.get 5
                        i32.const 48
                        i32.store8 offset=88
                        local.get 12
                        local.set 19
                      end
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 24
                          local.get 22
                          i32.eq
                          br_if 0 (;@11;)
                          local.get 19
                          local.get 5
                          i32.const 80
                          i32.add
                          i32.le_u
                          br_if 1 (;@10;)
                          local.get 5
                          i32.const 80
                          i32.add
                          i32.const 48
                          local.get 19
                          local.get 5
                          i32.const 80
                          i32.add
                          i32.sub
                          call $memset
                          drop
                          local.get 5
                          i32.const 80
                          i32.add
                          local.set 19
                          br 1 (;@10;)
                        end
                        block  ;; label = @11
                          local.get 0
                          i32.load8_u
                          i32.const 32
                          i32.and
                          br_if 0 (;@11;)
                          local.get 19
                          i32.const 1
                          local.get 0
                          call $__fwritex
                          drop
                        end
                        local.get 19
                        i32.const 1
                        i32.add
                        local.set 19
                        block  ;; label = @11
                          local.get 41
                          br_if 0 (;@11;)
                          local.get 27
                          i32.const 1
                          i32.lt_s
                          br_if 1 (;@10;)
                        end
                        local.get 0
                        i32.load8_u
                        i32.const 32
                        i32.and
                        br_if 0 (;@10;)
                        i32.const 1131
                        i32.const 1
                        local.get 0
                        call $__fwritex
                        drop
                      end
                      local.get 13
                      local.get 19
                      i32.sub
                      local.set 21
                      block  ;; label = @10
                        local.get 0
                        i32.load8_u
                        i32.const 32
                        i32.and
                        br_if 0 (;@10;)
                        local.get 19
                        local.get 27
                        local.get 21
                        local.get 27
                        local.get 21
                        i32.lt_s
                        select
                        local.get 0
                        call $__fwritex
                        drop
                      end
                      local.get 27
                      local.get 21
                      i32.sub
                      local.set 27
                      local.get 24
                      i32.const 4
                      i32.add
                      local.tee 24
                      local.get 29
                      i32.ge_u
                      br_if 1 (;@8;)
                      local.get 27
                      i32.const -1
                      i32.gt_s
                      br_if 0 (;@9;)
                    end
                  end
                  local.get 0
                  i32.const 48
                  local.get 27
                  i32.const 18
                  i32.add
                  i32.const 18
                  i32.const 0
                  call $pad
                  local.get 0
                  i32.load8_u
                  i32.const 32
                  i32.and
                  br_if 0 (;@7;)
                  local.get 40
                  local.get 6
                  local.get 40
                  i32.sub
                  local.get 0
                  call $__fwritex
                  drop
                end
                local.get 30
                i32.const 8192
                i32.ne
                br_if 1 (;@5;)
                local.get 26
                local.get 28
                i32.le_s
                br_if 1 (;@5;)
                local.get 5
                i32.const 624
                i32.add
                i32.const 32
                local.get 26
                local.get 28
                i32.sub
                local.tee 19
                i32.const 256
                local.get 19
                i32.const 256
                i32.lt_u
                local.tee 21
                select
                call $memset
                drop
                block  ;; label = @7
                  local.get 21
                  br_if 0 (;@7;)
                  loop  ;; label = @8
                    block  ;; label = @9
                      local.get 0
                      i32.load8_u
                      i32.const 32
                      i32.and
                      br_if 0 (;@9;)
                      local.get 5
                      i32.const 624
                      i32.add
                      i32.const 256
                      local.get 0
                      call $__fwritex
                      drop
                    end
                    local.get 19
                    i32.const -256
                    i32.add
                    local.tee 19
                    i32.const 255
                    i32.gt_u
                    br_if 0 (;@8;)
                  end
                end
                local.get 0
                i32.load8_u
                i32.const 32
                i32.and
                br_if 1 (;@5;)
                local.get 5
                i32.const 624
                i32.add
                local.get 19
                local.get 0
                call $__fwritex
                drop
                br 1 (;@5;)
              end
              local.get 37
              local.get 31
              i32.const 26
              i32.shl
              i32.const 31
              i32.shr_s
              i32.const 9
              i32.and
              i32.add
              local.set 23
              block  ;; label = @6
                local.get 24
                i32.const 11
                i32.gt_u
                br_if 0 (;@6;)
                block  ;; label = @7
                  block  ;; label = @8
                    i32.const 12
                    local.get 24
                    i32.sub
                    local.tee 19
                    i32.const 7
                    i32.and
                    local.tee 21
                    br_if 0 (;@8;)
                    f64.const 0x1p+4 (;=16;)
                    local.set 43
                    br 1 (;@7;)
                  end
                  local.get 24
                  i32.const -12
                  i32.add
                  local.set 19
                  f64.const 0x1p+4 (;=16;)
                  local.set 43
                  loop  ;; label = @8
                    local.get 19
                    i32.const 1
                    i32.add
                    local.set 19
                    local.get 43
                    f64.const 0x1p+4 (;=16;)
                    f64.mul
                    local.set 43
                    local.get 21
                    i32.const -1
                    i32.add
                    local.tee 21
                    br_if 0 (;@8;)
                  end
                  i32.const 0
                  local.get 19
                  i32.sub
                  local.set 19
                end
                block  ;; label = @7
                  local.get 24
                  i32.const -5
                  i32.add
                  i32.const 7
                  i32.lt_u
                  br_if 0 (;@7;)
                  loop  ;; label = @8
                    local.get 43
                    f64.const 0x1p+4 (;=16;)
                    f64.mul
                    f64.const 0x1p+4 (;=16;)
                    f64.mul
                    f64.const 0x1p+4 (;=16;)
                    f64.mul
                    f64.const 0x1p+4 (;=16;)
                    f64.mul
                    f64.const 0x1p+4 (;=16;)
                    f64.mul
                    f64.const 0x1p+4 (;=16;)
                    f64.mul
                    f64.const 0x1p+4 (;=16;)
                    f64.mul
                    f64.const 0x1p+4 (;=16;)
                    f64.mul
                    local.set 43
                    local.get 19
                    i32.const -8
                    i32.add
                    local.tee 19
                    br_if 0 (;@8;)
                  end
                end
                block  ;; label = @7
                  local.get 23
                  i32.load8_u
                  i32.const 45
                  i32.ne
                  br_if 0 (;@7;)
                  local.get 43
                  local.get 34
                  f64.neg
                  local.get 43
                  f64.sub
                  f64.add
                  f64.neg
                  local.set 34
                  br 1 (;@6;)
                end
                local.get 34
                local.get 43
                f64.add
                local.get 43
                f64.sub
                local.set 34
              end
              block  ;; label = @6
                block  ;; label = @7
                  local.get 5
                  i32.load offset=108
                  local.tee 25
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 25
                  local.get 25
                  i32.const 31
                  i32.shr_s
                  local.tee 19
                  i32.xor
                  local.get 19
                  i32.sub
                  local.set 19
                  i32.const 0
                  local.set 21
                  loop  ;; label = @8
                    local.get 5
                    i32.const 68
                    i32.add
                    local.get 21
                    i32.add
                    i32.const 11
                    i32.add
                    local.get 19
                    local.get 19
                    i32.const 10
                    i32.div_u
                    local.tee 22
                    i32.const 10
                    i32.mul
                    i32.sub
                    i32.const 48
                    i32.or
                    i32.store8
                    local.get 21
                    i32.const -1
                    i32.add
                    local.set 21
                    local.get 19
                    i32.const 9
                    i32.gt_u
                    local.set 20
                    local.get 22
                    local.set 19
                    local.get 20
                    br_if 0 (;@8;)
                  end
                  local.get 21
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 5
                  i32.const 68
                  i32.add
                  local.get 21
                  i32.add
                  i32.const 12
                  i32.add
                  local.set 19
                  br 1 (;@6;)
                end
                local.get 5
                i32.const 48
                i32.store8 offset=79
                local.get 11
                local.set 19
              end
              local.get 35
              i32.const 2
              i32.or
              local.set 27
              local.get 31
              i32.const 32
              i32.and
              local.set 22
              local.get 19
              i32.const -2
              i32.add
              local.tee 29
              local.get 31
              i32.const 15
              i32.add
              i32.store8
              local.get 19
              i32.const -1
              i32.add
              i32.const 45
              i32.const 43
              local.get 25
              i32.const 0
              i32.lt_s
              select
              i32.store8
              local.get 30
              i32.const 8
              i32.and
              local.set 20
              local.get 5
              i32.const 80
              i32.add
              local.set 21
              loop  ;; label = @6
                local.get 21
                local.set 19
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 34
                    f64.abs
                    f64.const 0x1p+31 (;=2.14748e+09;)
                    f64.lt
                    i32.eqz
                    br_if 0 (;@8;)
                    local.get 34
                    i32.trunc_f64_s
                    local.set 21
                    br 1 (;@7;)
                  end
                  i32.const -2147483648
                  local.set 21
                end
                local.get 19
                local.get 21
                i32.const 3744
                i32.add
                i32.load8_u
                local.get 22
                i32.or
                i32.store8
                local.get 34
                local.get 21
                f64.convert_i32_s
                f64.sub
                f64.const 0x1p+4 (;=16;)
                f64.mul
                local.set 34
                block  ;; label = @7
                  local.get 19
                  i32.const 1
                  i32.add
                  local.tee 21
                  local.get 5
                  i32.const 80
                  i32.add
                  i32.sub
                  i32.const 1
                  i32.ne
                  br_if 0 (;@7;)
                  block  ;; label = @8
                    local.get 20
                    br_if 0 (;@8;)
                    local.get 24
                    i32.const 0
                    i32.gt_s
                    br_if 0 (;@8;)
                    local.get 34
                    f64.const 0x0p+0 (;=0;)
                    f64.eq
                    br_if 1 (;@7;)
                  end
                  local.get 19
                  i32.const 46
                  i32.store8 offset=1
                  local.get 19
                  i32.const 2
                  i32.add
                  local.set 21
                end
                local.get 34
                f64.const 0x0p+0 (;=0;)
                f64.ne
                br_if 0 (;@6;)
              end
              i32.const 2147483645
              local.get 6
              local.get 29
              i32.sub
              local.tee 25
              local.get 27
              i32.add
              local.tee 19
              i32.sub
              local.get 24
              i32.lt_s
              br_if 2 (;@3;)
              local.get 24
              i32.const 2
              i32.add
              local.get 21
              local.get 5
              i32.const 80
              i32.add
              i32.sub
              local.tee 22
              local.get 10
              local.get 21
              i32.add
              local.get 24
              i32.lt_s
              select
              local.get 22
              local.get 24
              select
              local.tee 20
              local.get 19
              i32.add
              local.set 28
              block  ;; label = @6
                local.get 30
                i32.const 73728
                i32.and
                local.tee 21
                br_if 0 (;@6;)
                local.get 26
                local.get 28
                i32.le_s
                br_if 0 (;@6;)
                local.get 5
                i32.const 624
                i32.add
                i32.const 32
                local.get 26
                local.get 28
                i32.sub
                local.tee 19
                i32.const 256
                local.get 19
                i32.const 256
                i32.lt_u
                local.tee 24
                select
                call $memset
                drop
                block  ;; label = @7
                  local.get 24
                  br_if 0 (;@7;)
                  loop  ;; label = @8
                    block  ;; label = @9
                      local.get 0
                      i32.load8_u
                      i32.const 32
                      i32.and
                      br_if 0 (;@9;)
                      local.get 5
                      i32.const 624
                      i32.add
                      i32.const 256
                      local.get 0
                      call $__fwritex
                      drop
                    end
                    local.get 19
                    i32.const -256
                    i32.add
                    local.tee 19
                    i32.const 255
                    i32.gt_u
                    br_if 0 (;@8;)
                  end
                end
                local.get 0
                i32.load8_u
                i32.const 32
                i32.and
                br_if 0 (;@6;)
                local.get 5
                i32.const 624
                i32.add
                local.get 19
                local.get 0
                call $__fwritex
                drop
              end
              block  ;; label = @6
                local.get 0
                i32.load8_u
                i32.const 32
                i32.and
                br_if 0 (;@6;)
                local.get 23
                local.get 27
                local.get 0
                call $__fwritex
                drop
              end
              block  ;; label = @6
                local.get 21
                i32.const 65536
                i32.ne
                br_if 0 (;@6;)
                local.get 26
                local.get 28
                i32.le_s
                br_if 0 (;@6;)
                local.get 5
                i32.const 624
                i32.add
                i32.const 48
                local.get 26
                local.get 28
                i32.sub
                local.tee 19
                i32.const 256
                local.get 19
                i32.const 256
                i32.lt_u
                local.tee 24
                select
                call $memset
                drop
                block  ;; label = @7
                  local.get 24
                  br_if 0 (;@7;)
                  loop  ;; label = @8
                    block  ;; label = @9
                      local.get 0
                      i32.load8_u
                      i32.const 32
                      i32.and
                      br_if 0 (;@9;)
                      local.get 5
                      i32.const 624
                      i32.add
                      i32.const 256
                      local.get 0
                      call $__fwritex
                      drop
                    end
                    local.get 19
                    i32.const -256
                    i32.add
                    local.tee 19
                    i32.const 255
                    i32.gt_u
                    br_if 0 (;@8;)
                  end
                end
                local.get 0
                i32.load8_u
                i32.const 32
                i32.and
                br_if 0 (;@6;)
                local.get 5
                i32.const 624
                i32.add
                local.get 19
                local.get 0
                call $__fwritex
                drop
              end
              block  ;; label = @6
                local.get 0
                i32.load8_u
                i32.const 32
                i32.and
                br_if 0 (;@6;)
                local.get 5
                i32.const 80
                i32.add
                local.get 22
                local.get 0
                call $__fwritex
                drop
              end
              block  ;; label = @6
                local.get 20
                local.get 22
                i32.sub
                local.tee 19
                i32.const 1
                i32.lt_s
                br_if 0 (;@6;)
                local.get 5
                i32.const 624
                i32.add
                i32.const 48
                local.get 19
                i32.const 256
                local.get 19
                i32.const 256
                i32.lt_u
                local.tee 22
                select
                call $memset
                drop
                block  ;; label = @7
                  local.get 22
                  br_if 0 (;@7;)
                  loop  ;; label = @8
                    block  ;; label = @9
                      local.get 0
                      i32.load8_u
                      i32.const 32
                      i32.and
                      br_if 0 (;@9;)
                      local.get 5
                      i32.const 624
                      i32.add
                      i32.const 256
                      local.get 0
                      call $__fwritex
                      drop
                    end
                    local.get 19
                    i32.const -256
                    i32.add
                    local.tee 19
                    i32.const 255
                    i32.gt_u
                    br_if 0 (;@8;)
                  end
                end
                local.get 0
                i32.load8_u
                i32.const 32
                i32.and
                br_if 0 (;@6;)
                local.get 5
                i32.const 624
                i32.add
                local.get 19
                local.get 0
                call $__fwritex
                drop
              end
              block  ;; label = @6
                local.get 0
                i32.load8_u
                i32.const 32
                i32.and
                br_if 0 (;@6;)
                local.get 29
                local.get 25
                local.get 0
                call $__fwritex
                drop
              end
              local.get 21
              i32.const 8192
              i32.ne
              br_if 0 (;@5;)
              local.get 26
              local.get 28
              i32.le_s
              br_if 0 (;@5;)
              local.get 5
              i32.const 624
              i32.add
              i32.const 32
              local.get 26
              local.get 28
              i32.sub
              local.tee 19
              i32.const 256
              local.get 19
              i32.const 256
              i32.lt_u
              local.tee 21
              select
              call $memset
              drop
              block  ;; label = @6
                local.get 21
                br_if 0 (;@6;)
                loop  ;; label = @7
                  block  ;; label = @8
                    local.get 0
                    i32.load8_u
                    i32.const 32
                    i32.and
                    br_if 0 (;@8;)
                    local.get 5
                    i32.const 624
                    i32.add
                    i32.const 256
                    local.get 0
                    call $__fwritex
                    drop
                  end
                  local.get 19
                  i32.const -256
                  i32.add
                  local.tee 19
                  i32.const 255
                  i32.gt_u
                  br_if 0 (;@7;)
                end
              end
              local.get 0
              i32.load8_u
              i32.const 32
              i32.and
              br_if 0 (;@5;)
              local.get 5
              i32.const 624
              i32.add
              local.get 19
              local.get 0
              call $__fwritex
              drop
            end
            local.get 28
            local.get 26
            local.get 28
            local.get 26
            i32.gt_s
            select
            local.tee 19
            i32.const 0
            i32.ge_s
            br_if 0 (;@4;)
          end
        end
        i32.const 4644
        i32.const 61
        i32.store
      end
      i32.const -1
      local.set 18
    end
    local.get 5
    i32.const 880
    i32.add
    global.set $__stack_pointer
    local.get 18)
  (func $pop_arg (type 10) (param i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  block  ;; label = @16
                                    block  ;; label = @17
                                      block  ;; label = @18
                                        block  ;; label = @19
                                          local.get 1
                                          i32.const -9
                                          i32.add
                                          br_table 17 (;@2;) 0 (;@19;) 1 (;@18;) 4 (;@15;) 2 (;@17;) 3 (;@16;) 5 (;@14;) 6 (;@13;) 7 (;@12;) 8 (;@11;) 9 (;@10;) 10 (;@9;) 11 (;@8;) 12 (;@7;) 13 (;@6;) 14 (;@5;) 15 (;@4;) 16 (;@3;) 18 (;@1;)
                                        end
                                        local.get 2
                                        local.get 2
                                        i32.load
                                        local.tee 1
                                        i32.const 4
                                        i32.add
                                        i32.store
                                        local.get 0
                                        local.get 1
                                        i64.load32_s
                                        i64.store
                                        return
                                      end
                                      local.get 2
                                      local.get 2
                                      i32.load
                                      local.tee 1
                                      i32.const 4
                                      i32.add
                                      i32.store
                                      local.get 0
                                      local.get 1
                                      i64.load32_u
                                      i64.store
                                      return
                                    end
                                    local.get 2
                                    local.get 2
                                    i32.load
                                    local.tee 1
                                    i32.const 4
                                    i32.add
                                    i32.store
                                    local.get 0
                                    local.get 1
                                    i64.load32_s
                                    i64.store
                                    return
                                  end
                                  local.get 2
                                  local.get 2
                                  i32.load
                                  local.tee 1
                                  i32.const 4
                                  i32.add
                                  i32.store
                                  local.get 0
                                  local.get 1
                                  i64.load32_u
                                  i64.store
                                  return
                                end
                                local.get 2
                                local.get 2
                                i32.load
                                i32.const 7
                                i32.add
                                i32.const -8
                                i32.and
                                local.tee 1
                                i32.const 8
                                i32.add
                                i32.store
                                local.get 0
                                local.get 1
                                i64.load
                                i64.store
                                return
                              end
                              local.get 2
                              local.get 2
                              i32.load
                              local.tee 1
                              i32.const 4
                              i32.add
                              i32.store
                              local.get 0
                              local.get 1
                              i64.load16_s
                              i64.store
                              return
                            end
                            local.get 2
                            local.get 2
                            i32.load
                            local.tee 1
                            i32.const 4
                            i32.add
                            i32.store
                            local.get 0
                            local.get 1
                            i64.load16_u
                            i64.store
                            return
                          end
                          local.get 2
                          local.get 2
                          i32.load
                          local.tee 1
                          i32.const 4
                          i32.add
                          i32.store
                          local.get 0
                          local.get 1
                          i64.load8_s
                          i64.store
                          return
                        end
                        local.get 2
                        local.get 2
                        i32.load
                        local.tee 1
                        i32.const 4
                        i32.add
                        i32.store
                        local.get 0
                        local.get 1
                        i64.load8_u
                        i64.store
                        return
                      end
                      local.get 2
                      local.get 2
                      i32.load
                      i32.const 7
                      i32.add
                      i32.const -8
                      i32.and
                      local.tee 1
                      i32.const 8
                      i32.add
                      i32.store
                      local.get 0
                      local.get 1
                      i64.load
                      i64.store
                      return
                    end
                    local.get 2
                    local.get 2
                    i32.load
                    local.tee 1
                    i32.const 4
                    i32.add
                    i32.store
                    local.get 0
                    local.get 1
                    i64.load32_u
                    i64.store
                    return
                  end
                  local.get 2
                  local.get 2
                  i32.load
                  i32.const 7
                  i32.add
                  i32.const -8
                  i32.and
                  local.tee 1
                  i32.const 8
                  i32.add
                  i32.store
                  local.get 0
                  local.get 1
                  i64.load
                  i64.store
                  return
                end
                local.get 2
                local.get 2
                i32.load
                i32.const 7
                i32.add
                i32.const -8
                i32.and
                local.tee 1
                i32.const 8
                i32.add
                i32.store
                local.get 0
                local.get 1
                i64.load
                i64.store
                return
              end
              local.get 2
              local.get 2
              i32.load
              local.tee 1
              i32.const 4
              i32.add
              i32.store
              local.get 0
              local.get 1
              i64.load32_s
              i64.store
              return
            end
            local.get 2
            local.get 2
            i32.load
            local.tee 1
            i32.const 4
            i32.add
            i32.store
            local.get 0
            local.get 1
            i64.load32_u
            i64.store
            return
          end
          local.get 2
          local.get 2
          i32.load
          i32.const 7
          i32.add
          i32.const -8
          i32.and
          local.tee 1
          i32.const 8
          i32.add
          i32.store
          local.get 0
          local.get 1
          f64.load
          f64.store
          return
        end
        call $long_double_not_supported
        unreachable
      end
      local.get 2
      local.get 2
      i32.load
      local.tee 1
      i32.const 4
      i32.add
      i32.store
      local.get 0
      local.get 1
      i32.load
      i32.store
    end)
  (func $pad (type 11) (param i32 i32 i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 256
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    block  ;; label = @1
      local.get 2
      local.get 3
      i32.le_s
      br_if 0 (;@1;)
      local.get 4
      i32.const 73728
      i32.and
      br_if 0 (;@1;)
      local.get 5
      local.get 1
      local.get 2
      local.get 3
      i32.sub
      local.tee 3
      i32.const 256
      local.get 3
      i32.const 256
      i32.lt_u
      local.tee 4
      select
      call $memset
      local.set 2
      block  ;; label = @2
        local.get 4
        br_if 0 (;@2;)
        loop  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.load8_u
            i32.const 32
            i32.and
            br_if 0 (;@4;)
            local.get 2
            i32.const 256
            local.get 0
            call $__fwritex
            drop
          end
          local.get 3
          i32.const -256
          i32.add
          local.tee 3
          i32.const 255
          i32.gt_u
          br_if 0 (;@3;)
        end
      end
      local.get 0
      i32.load8_u
      i32.const 32
      i32.and
      br_if 0 (;@1;)
      local.get 2
      local.get 3
      local.get 0
      call $__fwritex
      drop
    end
    local.get 5
    i32.const 256
    i32.add
    global.set $__stack_pointer)
  (func $long_double_not_supported (type 1)
    i32.const 1368
    i32.const 4392
    call $fputs
    drop
    call $abort
    unreachable)
  (func $__shlim (type 16) (param i32 i64)
    (local i32 i32)
    local.get 0
    local.get 1
    i64.store offset=88
    local.get 0
    local.get 0
    i32.load offset=40
    local.get 0
    i32.load offset=4
    local.tee 2
    i32.sub
    i64.extend_i32_s
    i64.store offset=96
    local.get 0
    i32.load offset=8
    local.set 3
    block  ;; label = @1
      local.get 1
      i64.eqz
      br_if 0 (;@1;)
      local.get 3
      local.get 2
      i32.sub
      i64.extend_i32_s
      local.get 1
      i64.le_s
      br_if 0 (;@1;)
      local.get 2
      local.get 1
      i32.wrap_i64
      i32.add
      local.set 3
    end
    local.get 0
    local.get 3
    i32.store offset=84)
  (func $__shgetc (type 0) (param i32) (result i32)
    (local i32 i32 i64 i64 i32)
    local.get 0
    i64.load offset=96
    local.get 0
    i32.load offset=4
    local.tee 1
    local.get 0
    i32.load offset=40
    local.tee 2
    i32.sub
    i64.extend_i32_s
    i64.add
    local.set 3
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          i64.load offset=88
          local.tee 4
          i64.eqz
          br_if 0 (;@3;)
          local.get 3
          local.get 4
          i64.ge_s
          br_if 1 (;@2;)
        end
        local.get 0
        call $__uflow
        local.tee 2
        i32.const -1
        i32.gt_s
        br_if 1 (;@1;)
        local.get 0
        i32.load offset=4
        local.set 1
        local.get 0
        i32.load offset=40
        local.set 2
      end
      local.get 0
      i64.const -1
      i64.store offset=88
      local.get 0
      local.get 1
      i32.store offset=84
      local.get 0
      local.get 3
      local.get 2
      local.get 1
      i32.sub
      i64.extend_i32_s
      i64.add
      i64.store offset=96
      i32.const -1
      return
    end
    local.get 3
    i64.const 1
    i64.add
    local.set 3
    local.get 0
    i32.load offset=4
    local.set 1
    local.get 0
    i32.load offset=8
    local.set 5
    block  ;; label = @1
      local.get 0
      i64.load offset=88
      local.tee 4
      i64.const 0
      i64.eq
      br_if 0 (;@1;)
      local.get 4
      local.get 3
      i64.sub
      local.tee 4
      local.get 5
      local.get 1
      i32.sub
      i64.extend_i32_s
      i64.ge_s
      br_if 0 (;@1;)
      local.get 1
      local.get 4
      i32.wrap_i64
      i32.add
      local.set 5
    end
    local.get 0
    local.get 5
    i32.store offset=84
    local.get 0
    local.get 3
    local.get 0
    i32.load offset=40
    local.tee 5
    local.get 1
    i32.sub
    i64.extend_i32_s
    i64.add
    i64.store offset=96
    block  ;; label = @1
      local.get 1
      local.get 5
      i32.gt_u
      br_if 0 (;@1;)
      local.get 1
      i32.const -1
      i32.add
      local.get 2
      i32.store8
    end
    local.get 2)
  (func $__intscan (type 17) (param i32 i32 i32 i64) (result i64)
    (local i32 i32 i32 i64 i64 i64 i32 i64 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 4
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 1
                i32.const 36
                i32.gt_u
                br_if 0 (;@6;)
                local.get 1
                i32.const 1
                i32.eq
                br_if 0 (;@6;)
                block  ;; label = @7
                  block  ;; label = @8
                    loop  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 0
                          i32.load offset=4
                          local.tee 5
                          local.get 0
                          i32.load offset=84
                          i32.eq
                          br_if 0 (;@11;)
                          local.get 0
                          local.get 5
                          i32.const 1
                          i32.add
                          i32.store offset=4
                          local.get 5
                          i32.load8_u
                          local.set 5
                          br 1 (;@10;)
                        end
                        local.get 0
                        call $__shgetc
                        local.set 5
                      end
                      local.get 5
                      i32.const -9
                      i32.add
                      i32.const 5
                      i32.lt_u
                      br_if 0 (;@9;)
                      block  ;; label = @10
                        local.get 5
                        i32.const -32
                        i32.add
                        br_table 1 (;@9;) 2 (;@8;) 2 (;@8;) 2 (;@8;) 2 (;@8;) 2 (;@8;) 2 (;@8;) 2 (;@8;) 2 (;@8;) 2 (;@8;) 2 (;@8;) 0 (;@10;) 2 (;@8;) 0 (;@10;) 2 (;@8;)
                      end
                    end
                    i32.const -1
                    i32.const 0
                    local.get 5
                    i32.const 45
                    i32.eq
                    select
                    local.set 6
                    block  ;; label = @9
                      local.get 0
                      i32.load offset=4
                      local.tee 5
                      local.get 0
                      i32.load offset=84
                      i32.eq
                      br_if 0 (;@9;)
                      local.get 0
                      local.get 5
                      i32.const 1
                      i32.add
                      i32.store offset=4
                      local.get 5
                      i32.load8_u
                      local.set 5
                      br 2 (;@7;)
                    end
                    local.get 0
                    call $__shgetc
                    local.set 5
                    br 1 (;@7;)
                  end
                  i32.const 0
                  local.set 6
                end
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 1
                    i32.const 0
                    i32.ne
                    local.get 1
                    i32.const 16
                    i32.ne
                    i32.and
                    br_if 0 (;@8;)
                    local.get 5
                    i32.const 48
                    i32.ne
                    br_if 0 (;@8;)
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 0
                        i32.load offset=4
                        local.tee 5
                        local.get 0
                        i32.load offset=84
                        i32.eq
                        br_if 0 (;@10;)
                        local.get 0
                        local.get 5
                        i32.const 1
                        i32.add
                        i32.store offset=4
                        local.get 5
                        i32.load8_u
                        local.set 5
                        br 1 (;@9;)
                      end
                      local.get 0
                      call $__shgetc
                      local.set 5
                    end
                    block  ;; label = @9
                      local.get 5
                      i32.const -33
                      i32.and
                      i32.const 88
                      i32.ne
                      br_if 0 (;@9;)
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 0
                          i32.load offset=4
                          local.tee 5
                          local.get 0
                          i32.load offset=84
                          i32.eq
                          br_if 0 (;@11;)
                          local.get 0
                          local.get 5
                          i32.const 1
                          i32.add
                          i32.store offset=4
                          local.get 5
                          i32.load8_u
                          local.set 5
                          br 1 (;@10;)
                        end
                        local.get 0
                        call $__shgetc
                        local.set 5
                      end
                      i32.const 16
                      local.set 1
                      local.get 5
                      i32.const 3761
                      i32.add
                      i32.load8_u
                      i32.const 16
                      i32.lt_u
                      br_if 5 (;@4;)
                      i64.const 0
                      local.set 3
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 0
                          i64.load offset=88
                          i64.const 0
                          i64.lt_s
                          br_if 0 (;@11;)
                          local.get 0
                          local.get 0
                          i32.load offset=4
                          local.tee 5
                          i32.const -1
                          i32.add
                          i32.store offset=4
                          local.get 2
                          i32.eqz
                          br_if 1 (;@10;)
                          local.get 0
                          local.get 5
                          i32.const -2
                          i32.add
                          i32.store offset=4
                          br 10 (;@1;)
                        end
                        local.get 2
                        br_if 9 (;@1;)
                      end
                      i64.const 0
                      local.set 3
                      local.get 0
                      i64.const 0
                      call $__shlim
                      br 8 (;@1;)
                    end
                    local.get 1
                    br_if 1 (;@7;)
                    i32.const 8
                    local.set 1
                    br 4 (;@4;)
                  end
                  local.get 1
                  i32.const 10
                  local.get 1
                  select
                  local.tee 1
                  local.get 5
                  i32.const 3761
                  i32.add
                  i32.load8_u
                  i32.gt_u
                  br_if 0 (;@7;)
                  i64.const 0
                  local.set 3
                  block  ;; label = @8
                    local.get 0
                    i64.load offset=88
                    i64.const 0
                    i64.lt_s
                    br_if 0 (;@8;)
                    local.get 0
                    local.get 0
                    i32.load offset=4
                    i32.const -1
                    i32.add
                    i32.store offset=4
                  end
                  local.get 0
                  i64.const 0
                  call $__shlim
                  i32.const 0
                  i32.const 28
                  i32.store offset=4644
                  br 6 (;@1;)
                end
                local.get 1
                i32.const 10
                i32.ne
                br_if 2 (;@4;)
                i64.const 0
                local.set 7
                block  ;; label = @7
                  local.get 5
                  i32.const -48
                  i32.add
                  local.tee 2
                  i32.const 9
                  i32.gt_u
                  br_if 0 (;@7;)
                  i32.const 0
                  local.set 1
                  loop  ;; label = @8
                    local.get 1
                    i32.const 10
                    i32.mul
                    local.set 1
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 0
                        i32.load offset=4
                        local.tee 5
                        local.get 0
                        i32.load offset=84
                        i32.eq
                        br_if 0 (;@10;)
                        local.get 0
                        local.get 5
                        i32.const 1
                        i32.add
                        i32.store offset=4
                        local.get 5
                        i32.load8_u
                        local.set 5
                        br 1 (;@9;)
                      end
                      local.get 0
                      call $__shgetc
                      local.set 5
                    end
                    local.get 1
                    local.get 2
                    i32.add
                    local.set 1
                    block  ;; label = @9
                      local.get 5
                      i32.const -48
                      i32.add
                      local.tee 2
                      i32.const 9
                      i32.gt_u
                      br_if 0 (;@9;)
                      local.get 1
                      i32.const 429496729
                      i32.lt_u
                      br_if 1 (;@8;)
                    end
                  end
                  local.get 1
                  i64.extend_i32_u
                  local.set 7
                end
                local.get 2
                i32.const 9
                i32.gt_u
                br_if 1 (;@5;)
                local.get 7
                i64.const 10
                i64.mul
                local.set 8
                local.get 2
                i64.extend_i32_u
                local.set 9
                loop  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 0
                      i32.load offset=4
                      local.tee 5
                      local.get 0
                      i32.load offset=84
                      i32.eq
                      br_if 0 (;@9;)
                      local.get 0
                      local.get 5
                      i32.const 1
                      i32.add
                      i32.store offset=4
                      local.get 5
                      i32.load8_u
                      local.set 5
                      br 1 (;@8;)
                    end
                    local.get 0
                    call $__shgetc
                    local.set 5
                  end
                  local.get 8
                  local.get 9
                  i64.add
                  local.set 7
                  local.get 5
                  i32.const -48
                  i32.add
                  local.tee 2
                  i32.const 9
                  i32.gt_u
                  br_if 2 (;@5;)
                  local.get 7
                  i64.const 1844674407370955162
                  i64.ge_u
                  br_if 2 (;@5;)
                  local.get 7
                  i64.const 10
                  i64.mul
                  local.tee 8
                  local.get 2
                  i64.extend_i32_u
                  local.tee 9
                  i64.const -1
                  i64.xor
                  i64.le_u
                  br_if 0 (;@7;)
                end
                i32.const 10
                local.set 1
                br 3 (;@3;)
              end
              i32.const 0
              i32.const 28
              i32.store offset=4644
              i64.const 0
              local.set 3
              br 4 (;@1;)
            end
            i32.const 10
            local.set 1
            local.get 2
            i32.const 9
            i32.le_u
            br_if 1 (;@3;)
            br 2 (;@2;)
          end
          block  ;; label = @4
            local.get 1
            local.get 1
            i32.const -1
            i32.add
            i32.and
            i32.eqz
            br_if 0 (;@4;)
            i64.const 0
            local.set 7
            block  ;; label = @5
              local.get 1
              local.get 5
              i32.const 3761
              i32.add
              i32.load8_u
              local.tee 10
              i32.le_u
              br_if 0 (;@5;)
              i32.const 0
              local.set 2
              loop  ;; label = @6
                local.get 2
                local.get 1
                i32.mul
                local.set 2
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 0
                    i32.load offset=4
                    local.tee 5
                    local.get 0
                    i32.load offset=84
                    i32.eq
                    br_if 0 (;@8;)
                    local.get 0
                    local.get 5
                    i32.const 1
                    i32.add
                    i32.store offset=4
                    local.get 5
                    i32.load8_u
                    local.set 5
                    br 1 (;@7;)
                  end
                  local.get 0
                  call $__shgetc
                  local.set 5
                end
                local.get 10
                local.get 2
                i32.add
                local.set 2
                block  ;; label = @7
                  local.get 1
                  local.get 5
                  i32.const 3761
                  i32.add
                  i32.load8_u
                  local.tee 10
                  i32.le_u
                  br_if 0 (;@7;)
                  local.get 2
                  i32.const 119304647
                  i32.lt_u
                  br_if 1 (;@6;)
                end
              end
              local.get 2
              i64.extend_i32_u
              local.set 7
            end
            local.get 1
            local.get 10
            i32.le_u
            br_if 1 (;@3;)
            local.get 1
            i64.extend_i32_u
            local.set 8
            loop  ;; label = @5
              local.get 7
              local.get 8
              i64.mul
              local.tee 9
              local.get 10
              i64.extend_i32_u
              i64.const 255
              i64.and
              local.tee 11
              i64.const -1
              i64.xor
              i64.gt_u
              br_if 2 (;@3;)
              block  ;; label = @6
                block  ;; label = @7
                  local.get 0
                  i32.load offset=4
                  local.tee 5
                  local.get 0
                  i32.load offset=84
                  i32.eq
                  br_if 0 (;@7;)
                  local.get 0
                  local.get 5
                  i32.const 1
                  i32.add
                  i32.store offset=4
                  local.get 5
                  i32.load8_u
                  local.set 5
                  br 1 (;@6;)
                end
                local.get 0
                call $__shgetc
                local.set 5
              end
              local.get 9
              local.get 11
              i64.add
              local.set 7
              local.get 1
              local.get 5
              i32.const 3761
              i32.add
              i32.load8_u
              local.tee 10
              i32.le_u
              br_if 2 (;@3;)
              local.get 4
              local.get 8
              i64.const 0
              local.get 7
              i64.const 0
              call $__multi3
              local.get 4
              i64.load offset=8
              i64.const 0
              i64.ne
              br_if 2 (;@3;)
              br 0 (;@5;)
            end
          end
          local.get 1
          i32.const 23
          i32.mul
          i32.const 5
          i32.shr_u
          i32.const 7
          i32.and
          i32.const 4017
          i32.add
          i32.load8_s
          local.set 12
          i64.const 0
          local.set 7
          block  ;; label = @4
            local.get 1
            local.get 5
            i32.const 3761
            i32.add
            i32.load8_u
            local.tee 2
            i32.le_u
            br_if 0 (;@4;)
            i32.const 0
            local.set 10
            loop  ;; label = @5
              local.get 10
              local.get 12
              i32.shl
              local.set 10
              block  ;; label = @6
                block  ;; label = @7
                  local.get 0
                  i32.load offset=4
                  local.tee 5
                  local.get 0
                  i32.load offset=84
                  i32.eq
                  br_if 0 (;@7;)
                  local.get 0
                  local.get 5
                  i32.const 1
                  i32.add
                  i32.store offset=4
                  local.get 5
                  i32.load8_u
                  local.set 5
                  br 1 (;@6;)
                end
                local.get 0
                call $__shgetc
                local.set 5
              end
              local.get 2
              local.get 10
              i32.or
              local.set 10
              block  ;; label = @6
                local.get 1
                local.get 5
                i32.const 3761
                i32.add
                i32.load8_u
                local.tee 2
                i32.le_u
                br_if 0 (;@6;)
                local.get 10
                i32.const 134217728
                i32.lt_u
                br_if 1 (;@5;)
              end
            end
            local.get 10
            i64.extend_i32_u
            local.set 7
          end
          local.get 1
          local.get 2
          i32.le_u
          br_if 0 (;@3;)
          i64.const -1
          local.get 12
          i64.extend_i32_u
          local.tee 9
          i64.shr_u
          local.tee 11
          local.get 7
          i64.lt_u
          br_if 0 (;@3;)
          loop  ;; label = @4
            local.get 7
            local.get 9
            i64.shl
            local.set 7
            local.get 2
            i64.extend_i32_u
            i64.const 255
            i64.and
            local.set 8
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.load offset=4
                local.tee 5
                local.get 0
                i32.load offset=84
                i32.eq
                br_if 0 (;@6;)
                local.get 0
                local.get 5
                i32.const 1
                i32.add
                i32.store offset=4
                local.get 5
                i32.load8_u
                local.set 5
                br 1 (;@5;)
              end
              local.get 0
              call $__shgetc
              local.set 5
            end
            local.get 7
            local.get 8
            i64.or
            local.set 7
            local.get 1
            local.get 5
            i32.const 3761
            i32.add
            i32.load8_u
            local.tee 2
            i32.le_u
            br_if 1 (;@3;)
            local.get 7
            local.get 11
            i64.le_u
            br_if 0 (;@4;)
          end
        end
        local.get 1
        local.get 5
        i32.const 3761
        i32.add
        i32.load8_u
        i32.le_u
        br_if 0 (;@2;)
        loop  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.load offset=4
              local.tee 5
              local.get 0
              i32.load offset=84
              i32.eq
              br_if 0 (;@5;)
              local.get 0
              local.get 5
              i32.const 1
              i32.add
              i32.store offset=4
              local.get 5
              i32.load8_u
              local.set 5
              br 1 (;@4;)
            end
            local.get 0
            call $__shgetc
            local.set 5
          end
          local.get 1
          local.get 5
          i32.const 3761
          i32.add
          i32.load8_u
          i32.gt_u
          br_if 0 (;@3;)
        end
        i32.const 0
        i32.const 68
        i32.store offset=4644
        local.get 6
        i32.const 0
        local.get 3
        i64.const 1
        i64.and
        i64.eqz
        select
        local.set 6
        local.get 3
        local.set 7
      end
      block  ;; label = @2
        local.get 0
        i64.load offset=88
        i64.const 0
        i64.lt_s
        br_if 0 (;@2;)
        local.get 0
        local.get 0
        i32.load offset=4
        i32.const -1
        i32.add
        i32.store offset=4
      end
      block  ;; label = @2
        local.get 7
        local.get 3
        i64.lt_u
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 3
          i32.wrap_i64
          i32.const 1
          i32.and
          br_if 0 (;@3;)
          local.get 6
          br_if 0 (;@3;)
          i32.const 0
          i32.const 68
          i32.store offset=4644
          local.get 3
          i64.const -1
          i64.add
          local.set 3
          br 2 (;@1;)
        end
        local.get 7
        local.get 3
        i64.le_u
        br_if 0 (;@2;)
        i32.const 0
        i32.const 68
        i32.store offset=4644
        br 1 (;@1;)
      end
      local.get 7
      local.get 6
      i64.extend_i32_s
      local.tee 3
      i64.xor
      local.get 3
      i64.sub
      local.set 3
    end
    local.get 4
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 3)
  (func $scalbn (type 15) (param f64 i32) (result f64)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.const 1024
        i32.lt_s
        br_if 0 (;@2;)
        local.get 0
        f64.const 0x1p+1023 (;=8.98847e+307;)
        f64.mul
        local.set 0
        block  ;; label = @3
          local.get 1
          i32.const 2047
          i32.ge_u
          br_if 0 (;@3;)
          local.get 1
          i32.const -1023
          i32.add
          local.set 1
          br 2 (;@1;)
        end
        local.get 0
        f64.const 0x1p+1023 (;=8.98847e+307;)
        f64.mul
        local.set 0
        local.get 1
        i32.const 3069
        local.get 1
        i32.const 3069
        i32.lt_s
        select
        i32.const -2046
        i32.add
        local.set 1
        br 1 (;@1;)
      end
      local.get 1
      i32.const -1023
      i32.gt_s
      br_if 0 (;@1;)
      local.get 0
      f64.const 0x1p-969 (;=2.00417e-292;)
      f64.mul
      local.set 0
      block  ;; label = @2
        local.get 1
        i32.const -1992
        i32.le_u
        br_if 0 (;@2;)
        local.get 1
        i32.const 969
        i32.add
        local.set 1
        br 1 (;@1;)
      end
      local.get 0
      f64.const 0x1p-969 (;=2.00417e-292;)
      f64.mul
      local.set 0
      local.get 1
      i32.const -2960
      local.get 1
      i32.const -2960
      i32.gt_s
      select
      i32.const 1938
      i32.add
      local.set 1
    end
    local.get 0
    local.get 1
    i32.const 1023
    i32.add
    i64.extend_i32_u
    i64.const 52
    i64.shl
    f64.reinterpret_i64
    f64.mul)
  (func $fmod (type 18) (param f64 f64) (result f64)
    (local i64 i64 i64 i32 i64 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        local.get 1
        f64.ne
        br_if 0 (;@2;)
        local.get 1
        i64.reinterpret_f64
        local.tee 2
        i64.const 1
        i64.shl
        local.tee 3
        i64.eqz
        br_if 0 (;@2;)
        local.get 0
        i64.reinterpret_f64
        local.tee 4
        i64.const 52
        i64.shr_u
        i32.wrap_i64
        i32.const 2047
        i32.and
        local.tee 5
        i32.const 2047
        i32.ne
        br_if 1 (;@1;)
      end
      local.get 0
      local.get 1
      f64.mul
      local.tee 1
      local.get 1
      f64.div
      return
    end
    block  ;; label = @1
      local.get 4
      i64.const 1
      i64.shl
      local.tee 6
      local.get 3
      i64.gt_u
      br_if 0 (;@1;)
      local.get 0
      f64.const 0x0p+0 (;=0;)
      f64.mul
      local.get 0
      local.get 6
      local.get 3
      i64.eq
      select
      return
    end
    local.get 2
    i64.const 52
    i64.shr_u
    i32.wrap_i64
    i32.const 2047
    i32.and
    local.set 7
    block  ;; label = @1
      block  ;; label = @2
        local.get 5
        br_if 0 (;@2;)
        i32.const 0
        local.set 5
        block  ;; label = @3
          local.get 4
          i64.const 12
          i64.shl
          local.tee 3
          i64.const 0
          i64.lt_s
          br_if 0 (;@3;)
          loop  ;; label = @4
            local.get 5
            i32.const -1
            i32.add
            local.set 5
            local.get 3
            i64.const 1
            i64.shl
            local.tee 3
            i64.const -1
            i64.gt_s
            br_if 0 (;@4;)
          end
        end
        local.get 4
        i32.const 1
        local.get 5
        i32.sub
        i64.extend_i32_u
        i64.shl
        local.set 3
        br 1 (;@1;)
      end
      local.get 4
      i64.const 4503599627370495
      i64.and
      i64.const 4503599627370496
      i64.or
      local.set 3
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 7
        br_if 0 (;@2;)
        i32.const 0
        local.set 7
        block  ;; label = @3
          local.get 2
          i64.const 12
          i64.shl
          local.tee 6
          i64.const 0
          i64.lt_s
          br_if 0 (;@3;)
          loop  ;; label = @4
            local.get 7
            i32.const -1
            i32.add
            local.set 7
            local.get 6
            i64.const 1
            i64.shl
            local.tee 6
            i64.const -1
            i64.gt_s
            br_if 0 (;@4;)
          end
        end
        local.get 2
        i32.const 1
        local.get 7
        i32.sub
        i64.extend_i32_u
        i64.shl
        local.set 2
        br 1 (;@1;)
      end
      local.get 2
      i64.const 4503599627370495
      i64.and
      i64.const 4503599627370496
      i64.or
      local.set 2
    end
    block  ;; label = @1
      local.get 5
      local.get 7
      i32.le_s
      br_if 0 (;@1;)
      loop  ;; label = @2
        block  ;; label = @3
          local.get 3
          local.get 2
          i64.sub
          local.tee 6
          i64.const 0
          i64.lt_s
          br_if 0 (;@3;)
          local.get 6
          local.set 3
          local.get 6
          i64.const 0
          i64.ne
          br_if 0 (;@3;)
          local.get 0
          f64.const 0x0p+0 (;=0;)
          f64.mul
          return
        end
        local.get 3
        i64.const 1
        i64.shl
        local.set 3
        local.get 5
        i32.const -1
        i32.add
        local.tee 5
        local.get 7
        i32.gt_s
        br_if 0 (;@2;)
      end
      local.get 7
      local.set 5
    end
    block  ;; label = @1
      local.get 3
      local.get 2
      i64.sub
      local.tee 6
      i64.const 0
      i64.lt_s
      br_if 0 (;@1;)
      local.get 6
      local.set 3
      local.get 6
      i64.const 0
      i64.ne
      br_if 0 (;@1;)
      local.get 0
      f64.const 0x0p+0 (;=0;)
      f64.mul
      return
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 3
        i64.const 4503599627370495
        i64.le_u
        br_if 0 (;@2;)
        local.get 3
        local.set 6
        br 1 (;@1;)
      end
      loop  ;; label = @2
        local.get 5
        i32.const -1
        i32.add
        local.set 5
        local.get 3
        i64.const 2251799813685248
        i64.lt_u
        local.set 7
        local.get 3
        i64.const 1
        i64.shl
        local.tee 6
        local.set 3
        local.get 7
        br_if 0 (;@2;)
      end
    end
    local.get 4
    i64.const -9223372036854775808
    i64.and
    local.set 3
    block  ;; label = @1
      block  ;; label = @2
        local.get 5
        i32.const 1
        i32.lt_s
        br_if 0 (;@2;)
        local.get 6
        i64.const -4503599627370496
        i64.add
        local.get 5
        i64.extend_i32_u
        i64.const 52
        i64.shl
        i64.or
        local.set 6
        br 1 (;@1;)
      end
      local.get 6
      i32.const 1
      local.get 5
      i32.sub
      i64.extend_i32_u
      i64.shr_u
      local.set 6
    end
    local.get 6
    local.get 3
    i64.or
    f64.reinterpret_i64)
  (func $__floatscan (type 19) (param i32 i32 i32) (result f64)
    (local i32 i32 i32 i32 f64 i32 i32 i32 i32 i64 i32 i32 i32 i32 i32 i32 i64 i32 i32 i64 f64 f64 f64)
    global.get $__stack_pointer
    i32.const 512
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    i32.const -149
    local.set 4
    i32.const 24
    local.set 5
    i32.const 0
    local.set 6
    f64.const 0x0p+0 (;=0;)
    local.set 7
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          br_table 1 (;@2;) 0 (;@3;) 0 (;@3;) 2 (;@1;)
        end
        i32.const -1074
        local.set 4
        i32.const 53
        local.set 5
        i32.const 1
        local.set 6
      end
      local.get 0
      i32.const 4
      i32.add
      local.set 8
      block  ;; label = @2
        block  ;; label = @3
          loop  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.load offset=4
                local.tee 1
                local.get 0
                i32.load offset=84
                i32.eq
                br_if 0 (;@6;)
                local.get 8
                local.get 1
                i32.const 1
                i32.add
                i32.store
                local.get 1
                i32.load8_u
                local.set 1
                br 1 (;@5;)
              end
              local.get 0
              call $__shgetc
              local.set 1
            end
            local.get 1
            i32.const -9
            i32.add
            i32.const 5
            i32.lt_u
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 1
              i32.const -32
              i32.add
              br_table 1 (;@4;) 2 (;@3;) 2 (;@3;) 2 (;@3;) 2 (;@3;) 2 (;@3;) 2 (;@3;) 2 (;@3;) 2 (;@3;) 2 (;@3;) 2 (;@3;) 0 (;@5;) 2 (;@3;) 0 (;@5;) 2 (;@3;)
            end
          end
          i32.const -1
          i32.const 1
          local.get 1
          i32.const 45
          i32.eq
          select
          local.set 9
          block  ;; label = @4
            local.get 0
            i32.load offset=4
            local.tee 1
            local.get 0
            i32.load offset=84
            i32.eq
            br_if 0 (;@4;)
            local.get 8
            local.get 1
            i32.const 1
            i32.add
            i32.store
            local.get 1
            i32.load8_u
            local.set 1
            br 2 (;@2;)
          end
          local.get 0
          call $__shgetc
          local.set 1
          br 1 (;@2;)
        end
        i32.const 1
        local.set 9
      end
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.const -33
            i32.and
            local.tee 10
            i32.const 73
            i32.ne
            br_if 0 (;@4;)
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.load offset=4
                local.tee 1
                local.get 0
                i32.load offset=84
                i32.eq
                br_if 0 (;@6;)
                local.get 8
                local.get 1
                i32.const 1
                i32.add
                i32.store
                local.get 1
                i32.load8_u
                local.set 1
                br 1 (;@5;)
              end
              local.get 0
              call $__shgetc
              local.set 1
            end
            local.get 1
            i32.const -33
            i32.and
            i32.const 78
            i32.ne
            br_if 1 (;@3;)
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.load offset=4
                local.tee 1
                local.get 0
                i32.load offset=84
                i32.eq
                br_if 0 (;@6;)
                local.get 8
                local.get 1
                i32.const 1
                i32.add
                i32.store
                local.get 1
                i32.load8_u
                local.set 1
                br 1 (;@5;)
              end
              local.get 0
              call $__shgetc
              local.set 1
            end
            local.get 1
            i32.const -33
            i32.and
            i32.const 70
            i32.ne
            br_if 1 (;@3;)
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.load offset=4
                local.tee 1
                local.get 0
                i32.load offset=84
                i32.eq
                br_if 0 (;@6;)
                local.get 8
                local.get 1
                i32.const 1
                i32.add
                i32.store
                local.get 1
                i32.load8_u
                local.set 10
                br 1 (;@5;)
              end
              local.get 0
              call $__shgetc
              local.set 10
            end
            i32.const 3
            local.set 1
            block  ;; label = @5
              block  ;; label = @6
                local.get 10
                i32.const -33
                i32.and
                local.tee 10
                i32.const 73
                i32.ne
                br_if 0 (;@6;)
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 0
                    i32.load offset=4
                    local.tee 1
                    local.get 0
                    i32.load offset=84
                    i32.eq
                    br_if 0 (;@8;)
                    local.get 8
                    local.get 1
                    i32.const 1
                    i32.add
                    i32.store
                    local.get 1
                    i32.load8_u
                    local.set 11
                    br 1 (;@7;)
                  end
                  local.get 0
                  call $__shgetc
                  local.set 11
                end
                i32.const 4
                local.set 1
                block  ;; label = @7
                  local.get 11
                  i32.const -33
                  i32.and
                  i32.const 78
                  i32.ne
                  br_if 0 (;@7;)
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 0
                      i32.load offset=4
                      local.tee 1
                      local.get 0
                      i32.load offset=84
                      i32.eq
                      br_if 0 (;@9;)
                      local.get 8
                      local.get 1
                      i32.const 1
                      i32.add
                      i32.store
                      local.get 1
                      i32.load8_u
                      local.set 11
                      br 1 (;@8;)
                    end
                    local.get 0
                    call $__shgetc
                    local.set 11
                  end
                  i32.const 5
                  local.set 1
                  local.get 11
                  i32.const -33
                  i32.and
                  i32.const 73
                  i32.ne
                  br_if 0 (;@7;)
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 0
                      i32.load offset=4
                      local.tee 1
                      local.get 0
                      i32.load offset=84
                      i32.eq
                      br_if 0 (;@9;)
                      local.get 8
                      local.get 1
                      i32.const 1
                      i32.add
                      i32.store
                      local.get 1
                      i32.load8_u
                      local.set 11
                      br 1 (;@8;)
                    end
                    local.get 0
                    call $__shgetc
                    local.set 11
                  end
                  i32.const 6
                  local.set 1
                  local.get 11
                  i32.const -33
                  i32.and
                  i32.const 84
                  i32.ne
                  br_if 0 (;@7;)
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 0
                      i32.load offset=4
                      local.tee 1
                      local.get 0
                      i32.load offset=84
                      i32.eq
                      br_if 0 (;@9;)
                      local.get 8
                      local.get 1
                      i32.const 1
                      i32.add
                      i32.store
                      local.get 1
                      i32.load8_u
                      local.set 11
                      br 1 (;@8;)
                    end
                    local.get 0
                    call $__shgetc
                    local.set 11
                  end
                  i32.const 7
                  local.set 1
                  local.get 11
                  i32.const -33
                  i32.and
                  i32.const 89
                  i32.eq
                  br_if 2 (;@5;)
                end
                local.get 2
                i32.eqz
                br_if 3 (;@3;)
              end
              block  ;; label = @6
                local.get 0
                i64.load offset=88
                local.tee 12
                i64.const 0
                i64.lt_s
                br_if 0 (;@6;)
                local.get 8
                local.get 8
                i32.load
                i32.const -1
                i32.add
                i32.store
              end
              local.get 2
              i32.eqz
              br_if 0 (;@5;)
              local.get 10
              i32.const 73
              i32.ne
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 12
                i64.const 0
                i64.lt_s
                br_if 0 (;@6;)
                local.get 8
                local.get 8
                i32.load
                i32.const -1
                i32.add
                i32.store
              end
              local.get 1
              i32.const -5
              i32.add
              i32.const -5
              i32.gt_u
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 12
                i64.const 0
                i64.lt_s
                br_if 0 (;@6;)
                local.get 8
                local.get 8
                i32.load
                i32.const -1
                i32.add
                i32.store
              end
              local.get 1
              i32.const -6
              i32.add
              i32.const -5
              i32.gt_u
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 12
                i64.const 0
                i64.lt_s
                br_if 0 (;@6;)
                local.get 8
                local.get 8
                i32.load
                i32.const -1
                i32.add
                i32.store
              end
              local.get 1
              i32.const -7
              i32.add
              i32.const -5
              i32.gt_u
              br_if 0 (;@5;)
              local.get 12
              i64.const 0
              i64.lt_s
              br_if 0 (;@5;)
              local.get 8
              local.get 8
              i32.load
              i32.const -1
              i32.add
              i32.store
            end
            local.get 9
            f32.convert_i32_s
            f32.const inf (;=inf;)
            f32.mul
            f64.promote_f32
            local.set 7
            br 3 (;@1;)
          end
          local.get 10
          i32.const 78
          i32.ne
          br_if 1 (;@2;)
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.load offset=4
              local.tee 1
              local.get 0
              i32.load offset=84
              i32.eq
              br_if 0 (;@5;)
              local.get 8
              local.get 1
              i32.const 1
              i32.add
              i32.store
              local.get 1
              i32.load8_u
              local.set 1
              br 1 (;@4;)
            end
            local.get 0
            call $__shgetc
            local.set 1
          end
          local.get 1
          i32.const -33
          i32.and
          i32.const 65
          i32.ne
          br_if 0 (;@3;)
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.load offset=4
              local.tee 1
              local.get 0
              i32.load offset=84
              i32.eq
              br_if 0 (;@5;)
              local.get 8
              local.get 1
              i32.const 1
              i32.add
              i32.store
              local.get 1
              i32.load8_u
              local.set 1
              br 1 (;@4;)
            end
            local.get 0
            call $__shgetc
            local.set 1
          end
          local.get 1
          i32.const -33
          i32.and
          i32.const 78
          i32.ne
          br_if 0 (;@3;)
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.load offset=4
              local.tee 1
              local.get 0
              i32.load offset=84
              i32.eq
              br_if 0 (;@5;)
              local.get 8
              local.get 1
              i32.const 1
              i32.add
              i32.store
              local.get 1
              i32.load8_u
              local.set 1
              br 1 (;@4;)
            end
            local.get 0
            call $__shgetc
            local.set 1
          end
          block  ;; label = @4
            block  ;; label = @5
              local.get 1
              i32.const 40
              i32.ne
              br_if 0 (;@5;)
              i32.const 1
              local.set 11
              i32.const 1
              local.set 10
              br 1 (;@4;)
            end
            f64.const nan (;=nan;)
            local.set 7
            local.get 0
            i64.load offset=88
            i64.const 0
            i64.lt_s
            br_if 3 (;@1;)
            local.get 8
            local.get 8
            i32.load
            i32.const -1
            i32.add
            i32.store
            br 3 (;@1;)
          end
          loop  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.load offset=4
                local.tee 1
                local.get 0
                i32.load offset=84
                i32.eq
                br_if 0 (;@6;)
                local.get 8
                local.get 1
                i32.const 1
                i32.add
                i32.store
                local.get 1
                i32.load8_u
                local.set 1
                br 1 (;@5;)
              end
              local.get 0
              call $__shgetc
              local.set 1
            end
            local.get 1
            i32.const -65
            i32.add
            local.set 13
            block  ;; label = @5
              block  ;; label = @6
                local.get 1
                i32.const -48
                i32.add
                i32.const 10
                i32.lt_u
                br_if 0 (;@6;)
                local.get 13
                i32.const 26
                i32.lt_u
                br_if 0 (;@6;)
                local.get 1
                i32.const -97
                i32.add
                local.set 13
                local.get 1
                i32.const 95
                i32.eq
                br_if 0 (;@6;)
                local.get 13
                i32.const 26
                i32.ge_u
                br_if 1 (;@5;)
              end
              local.get 11
              i32.const 1
              i32.add
              local.set 11
              local.get 10
              i32.const 1
              i32.add
              local.set 10
              br 1 (;@4;)
            end
          end
          block  ;; label = @4
            local.get 1
            i32.const 41
            i32.ne
            br_if 0 (;@4;)
            f64.const nan (;=nan;)
            local.set 7
            br 3 (;@1;)
          end
          block  ;; label = @4
            local.get 0
            i64.load offset=88
            local.tee 12
            i64.const 0
            i64.lt_s
            br_if 0 (;@4;)
            local.get 8
            local.get 8
            i32.load
            i32.const -1
            i32.add
            i32.store
          end
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 10
                br_if 0 (;@6;)
                f64.const nan (;=nan;)
                local.set 7
                br 5 (;@1;)
              end
              local.get 10
              i32.const -1
              i32.add
              local.set 13
              block  ;; label = @6
                local.get 10
                i32.const 3
                i32.and
                i32.eqz
                br_if 0 (;@6;)
                local.get 11
                i32.const 3
                i32.and
                local.set 1
                i32.const 0
                local.set 0
                loop  ;; label = @7
                  block  ;; label = @8
                    local.get 12
                    i64.const 0
                    i64.lt_s
                    br_if 0 (;@8;)
                    local.get 8
                    local.get 8
                    i32.load
                    i32.const -1
                    i32.add
                    i32.store
                  end
                  local.get 1
                  local.get 0
                  i32.const 1
                  i32.add
                  local.tee 0
                  i32.ne
                  br_if 0 (;@7;)
                end
                local.get 10
                local.get 0
                i32.sub
                local.set 10
              end
              local.get 13
              i32.const 3
              i32.ge_u
              br_if 1 (;@4;)
              f64.const nan (;=nan;)
              local.set 7
              br 4 (;@1;)
            end
            i32.const 0
            i32.const 28
            i32.store offset=4644
            local.get 0
            i64.const 0
            call $__shlim
            br 3 (;@1;)
          end
          local.get 12
          i64.const 0
          i64.lt_s
          local.set 0
          loop  ;; label = @4
            block  ;; label = @5
              local.get 0
              br_if 0 (;@5;)
              local.get 8
              local.get 8
              i32.load
              i32.const -3
              i32.add
              i32.store
            end
            local.get 10
            i32.const -4
            i32.add
            local.set 10
            block  ;; label = @5
              local.get 0
              br_if 0 (;@5;)
              local.get 8
              local.get 8
              i32.load
              i32.const -1
              i32.add
              i32.store
            end
            local.get 10
            br_if 0 (;@4;)
          end
          f64.const nan (;=nan;)
          local.set 7
          br 2 (;@1;)
        end
        block  ;; label = @3
          local.get 0
          i64.load offset=88
          i64.const 0
          i64.lt_s
          br_if 0 (;@3;)
          local.get 8
          local.get 8
          i32.load
          i32.const -1
          i32.add
          i32.store
        end
        i32.const 0
        i32.const 28
        i32.store offset=4644
        local.get 0
        i64.const 0
        call $__shlim
        br 1 (;@1;)
      end
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 1
                i32.const 48
                i32.ne
                br_if 0 (;@6;)
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 0
                    i32.load offset=4
                    local.tee 1
                    local.get 0
                    i32.load offset=84
                    i32.eq
                    br_if 0 (;@8;)
                    local.get 8
                    local.get 1
                    i32.const 1
                    i32.add
                    i32.store
                    local.get 1
                    i32.load8_u
                    local.set 1
                    br 1 (;@7;)
                  end
                  local.get 0
                  call $__shgetc
                  local.set 1
                end
                block  ;; label = @7
                  local.get 1
                  i32.const -33
                  i32.and
                  i32.const 88
                  i32.ne
                  br_if 0 (;@7;)
                  local.get 0
                  local.get 5
                  local.get 4
                  local.get 9
                  local.get 2
                  call $hexfloat
                  local.set 7
                  br 6 (;@1;)
                end
                local.get 0
                i32.load offset=4
                local.set 1
                block  ;; label = @7
                  local.get 0
                  i64.load offset=88
                  i64.const 0
                  i64.lt_s
                  br_if 0 (;@7;)
                  local.get 8
                  local.get 1
                  i32.const -1
                  i32.add
                  local.tee 1
                  i32.store
                end
                i32.const 0
                local.get 4
                i32.sub
                local.set 14
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 1
                    local.get 0
                    i32.load offset=84
                    i32.eq
                    br_if 0 (;@8;)
                    local.get 8
                    local.get 1
                    i32.const 1
                    i32.add
                    i32.store
                    local.get 1
                    i32.load8_u
                    local.set 1
                    br 1 (;@7;)
                  end
                  local.get 0
                  call $__shgetc
                  local.set 1
                end
                local.get 14
                local.get 5
                i32.sub
                local.set 15
                loop  ;; label = @7
                  block  ;; label = @8
                    local.get 1
                    i32.const 48
                    i32.eq
                    br_if 0 (;@8;)
                    local.get 1
                    i32.const 46
                    i32.ne
                    br_if 4 (;@4;)
                    i32.const 1
                    local.set 16
                    br 3 (;@5;)
                  end
                  block  ;; label = @8
                    local.get 0
                    i32.load offset=4
                    local.tee 1
                    local.get 0
                    i32.load offset=84
                    i32.eq
                    br_if 0 (;@8;)
                    local.get 8
                    local.get 1
                    i32.const 1
                    i32.add
                    i32.store
                    local.get 1
                    i32.load8_u
                    local.set 1
                    br 1 (;@7;)
                  end
                  local.get 0
                  call $__shgetc
                  local.set 1
                  br 0 (;@7;)
                end
              end
              i32.const 0
              local.set 16
              i32.const 0
              local.get 4
              i32.sub
              local.tee 14
              local.get 5
              i32.sub
              local.set 15
              i64.const 0
              local.set 12
              i32.const 0
              local.set 17
              local.get 1
              i32.const 46
              i32.ne
              br_if 3 (;@2;)
            end
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.load offset=4
                local.tee 1
                local.get 0
                i32.load offset=84
                i32.eq
                br_if 0 (;@6;)
                local.get 8
                local.get 1
                i32.const 1
                i32.add
                i32.store
                local.get 1
                i32.load8_u
                local.set 1
                br 1 (;@5;)
              end
              local.get 0
              call $__shgetc
              local.set 1
            end
            block  ;; label = @5
              local.get 1
              i32.const 48
              i32.eq
              br_if 0 (;@5;)
              i32.const 1
              local.set 17
              br 2 (;@3;)
            end
            i64.const 0
            local.set 12
            loop  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 0
                  i32.load offset=4
                  local.tee 1
                  local.get 0
                  i32.load offset=84
                  i32.eq
                  br_if 0 (;@7;)
                  local.get 8
                  local.get 1
                  i32.const 1
                  i32.add
                  i32.store
                  local.get 1
                  i32.load8_u
                  local.set 1
                  br 1 (;@6;)
                end
                local.get 0
                call $__shgetc
                local.set 1
              end
              local.get 12
              i64.const -1
              i64.add
              local.set 12
              local.get 1
              i32.const 48
              i32.eq
              br_if 0 (;@5;)
            end
            i32.const 1
            local.set 16
            i32.const 1
            local.set 17
            br 2 (;@2;)
          end
          i32.const 0
          local.set 17
          i32.const 1
          local.set 16
        end
        i64.const 0
        local.set 12
      end
      i32.const 0
      local.set 18
      local.get 3
      i32.const 0
      i32.store
      local.get 1
      i32.const -48
      i32.add
      local.set 11
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 1
                  i32.const 46
                  i32.eq
                  local.tee 10
                  br_if 0 (;@7;)
                  i64.const 0
                  local.set 19
                  local.get 11
                  i32.const 9
                  i32.le_u
                  br_if 0 (;@7;)
                  i32.const 0
                  local.set 13
                  i32.const 0
                  local.set 20
                  br 1 (;@6;)
                end
                i64.const 0
                local.set 19
                i32.const 0
                local.set 20
                i32.const 0
                local.set 13
                i32.const 0
                local.set 18
                loop  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 10
                      i32.const 1
                      i32.and
                      i32.eqz
                      br_if 0 (;@9;)
                      block  ;; label = @10
                        local.get 17
                        br_if 0 (;@10;)
                        local.get 19
                        local.set 12
                        i32.const 1
                        local.set 17
                        br 2 (;@8;)
                      end
                      local.get 16
                      i32.eqz
                      local.set 10
                      br 4 (;@5;)
                    end
                    local.get 19
                    i64.const 1
                    i64.add
                    local.set 19
                    block  ;; label = @9
                      local.get 13
                      i32.const 124
                      i32.gt_s
                      br_if 0 (;@9;)
                      local.get 1
                      i32.const 48
                      i32.eq
                      local.set 16
                      local.get 19
                      i32.wrap_i64
                      local.set 21
                      local.get 3
                      local.get 13
                      i32.const 2
                      i32.shl
                      i32.add
                      local.set 10
                      block  ;; label = @10
                        local.get 20
                        i32.eqz
                        br_if 0 (;@10;)
                        local.get 1
                        local.get 10
                        i32.load
                        i32.const 10
                        i32.mul
                        i32.add
                        i32.const -48
                        i32.add
                        local.set 11
                      end
                      local.get 18
                      local.get 21
                      local.get 16
                      select
                      local.set 18
                      local.get 10
                      local.get 11
                      i32.store
                      i32.const 1
                      local.set 16
                      i32.const 0
                      local.get 20
                      i32.const 1
                      i32.add
                      local.tee 1
                      local.get 1
                      i32.const 9
                      i32.eq
                      local.tee 1
                      select
                      local.set 20
                      local.get 13
                      local.get 1
                      i32.add
                      local.set 13
                      br 1 (;@8;)
                    end
                    local.get 1
                    i32.const 48
                    i32.eq
                    br_if 0 (;@8;)
                    local.get 3
                    local.get 3
                    i32.load offset=496
                    i32.const 1
                    i32.or
                    i32.store offset=496
                    i32.const 1116
                    local.set 18
                  end
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 0
                      i32.load offset=4
                      local.tee 1
                      local.get 0
                      i32.load offset=84
                      i32.eq
                      br_if 0 (;@9;)
                      local.get 8
                      local.get 1
                      i32.const 1
                      i32.add
                      i32.store
                      local.get 1
                      i32.load8_u
                      local.set 1
                      br 1 (;@8;)
                    end
                    local.get 0
                    call $__shgetc
                    local.set 1
                  end
                  local.get 1
                  i32.const -48
                  i32.add
                  local.set 11
                  local.get 1
                  i32.const 46
                  i32.eq
                  local.tee 10
                  br_if 0 (;@7;)
                  local.get 11
                  i32.const 10
                  i32.lt_u
                  br_if 0 (;@7;)
                end
              end
              local.get 12
              local.get 19
              local.get 17
              select
              local.set 12
              block  ;; label = @6
                local.get 16
                i32.eqz
                br_if 0 (;@6;)
                local.get 1
                i32.const -33
                i32.and
                i32.const 69
                i32.ne
                br_if 0 (;@6;)
                block  ;; label = @7
                  local.get 0
                  local.get 2
                  call $scanexp
                  local.tee 22
                  i64.const -9223372036854775808
                  i64.ne
                  br_if 0 (;@7;)
                  local.get 2
                  i32.eqz
                  br_if 4 (;@3;)
                  i64.const 0
                  local.set 22
                  local.get 0
                  i64.load offset=88
                  i64.const 0
                  i64.lt_s
                  br_if 0 (;@7;)
                  local.get 8
                  local.get 8
                  i32.load
                  i32.const -1
                  i32.add
                  i32.store
                end
                local.get 22
                local.get 12
                i64.add
                local.set 12
                br 4 (;@2;)
              end
              local.get 16
              i32.eqz
              local.set 10
              local.get 1
              i32.const 0
              i32.lt_s
              br_if 1 (;@4;)
            end
            local.get 0
            i64.load offset=88
            i64.const 0
            i64.lt_s
            br_if 0 (;@4;)
            local.get 8
            local.get 8
            i32.load
            i32.const -1
            i32.add
            i32.store
          end
          local.get 10
          i32.eqz
          br_if 1 (;@2;)
          i32.const 0
          i32.const 28
          i32.store offset=4644
          local.get 0
          i64.const 0
          call $__shlim
          f64.const 0x0p+0 (;=0;)
          local.set 7
          br 2 (;@1;)
        end
        local.get 0
        i64.const 0
        call $__shlim
        f64.const 0x0p+0 (;=0;)
        local.set 7
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 3
        i32.load
        local.tee 0
        br_if 0 (;@2;)
        local.get 9
        f64.convert_i32_s
        f64.const 0x0p+0 (;=0;)
        f64.mul
        local.set 7
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 19
        i64.const 9
        i64.gt_s
        br_if 0 (;@2;)
        local.get 12
        local.get 19
        i64.ne
        br_if 0 (;@2;)
        local.get 6
        local.get 0
        local.get 5
        i32.shr_u
        i32.eqz
        i32.or
        i32.const 1
        i32.ne
        br_if 0 (;@2;)
        local.get 9
        f64.convert_i32_s
        local.get 0
        f64.convert_i32_u
        f64.mul
        local.set 7
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 12
        local.get 14
        i32.const 1
        i32.shr_u
        i64.extend_i32_u
        i64.le_s
        br_if 0 (;@2;)
        i32.const 0
        i32.const 68
        i32.store offset=4644
        local.get 9
        f64.convert_i32_s
        f64.const 0x1.fffffffffffffp+1023 (;=1.79769e+308;)
        f64.mul
        f64.const 0x1.fffffffffffffp+1023 (;=1.79769e+308;)
        f64.mul
        local.set 7
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 12
        local.get 4
        i32.const -106
        i32.add
        i64.extend_i32_s
        i64.ge_s
        br_if 0 (;@2;)
        i32.const 0
        i32.const 68
        i32.store offset=4644
        local.get 9
        f64.convert_i32_s
        f64.const 0x1p-1022 (;=2.22507e-308;)
        f64.mul
        f64.const 0x1p-1022 (;=2.22507e-308;)
        f64.mul
        local.set 7
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 20
        i32.eqz
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 20
          i32.const 8
          i32.gt_s
          br_if 0 (;@3;)
          local.get 3
          local.get 13
          i32.const 2
          i32.shl
          i32.add
          local.tee 10
          i32.load
          local.set 0
          block  ;; label = @4
            block  ;; label = @5
              i32.const 1
              local.get 20
              i32.sub
              i32.const 7
              i32.and
              local.tee 8
              br_if 0 (;@5;)
              local.get 20
              local.set 1
              br 1 (;@4;)
            end
            local.get 20
            local.set 1
            loop  ;; label = @5
              local.get 1
              i32.const 1
              i32.add
              local.set 1
              local.get 0
              i32.const 10
              i32.mul
              local.set 0
              local.get 8
              i32.const -1
              i32.add
              local.tee 8
              br_if 0 (;@5;)
            end
          end
          block  ;; label = @4
            local.get 20
            i32.const -2
            i32.add
            i32.const 7
            i32.lt_u
            br_if 0 (;@4;)
            local.get 1
            i32.const -9
            i32.add
            local.set 1
            loop  ;; label = @5
              local.get 0
              i32.const 100000000
              i32.mul
              local.set 0
              local.get 1
              i32.const 8
              i32.add
              local.tee 1
              br_if 0 (;@5;)
            end
          end
          local.get 10
          local.get 0
          i32.store
        end
        local.get 13
        i32.const 1
        i32.add
        local.set 13
      end
      local.get 12
      i32.wrap_i64
      local.set 17
      block  ;; label = @2
        local.get 18
        i32.const 9
        i32.ge_s
        br_if 0 (;@2;)
        local.get 18
        local.get 17
        i32.gt_s
        br_if 0 (;@2;)
        local.get 17
        i32.const 17
        i32.gt_s
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 17
          i32.const 9
          i32.ne
          br_if 0 (;@3;)
          local.get 9
          f64.convert_i32_s
          local.get 3
          i32.load
          f64.convert_i32_u
          f64.mul
          local.set 7
          br 2 (;@1;)
        end
        block  ;; label = @3
          local.get 17
          i32.const 8
          i32.gt_s
          br_if 0 (;@3;)
          local.get 9
          f64.convert_i32_s
          local.get 3
          i32.load
          f64.convert_i32_u
          f64.mul
          i32.const 8
          local.get 17
          i32.sub
          i32.const 2
          i32.shl
          i32.const 4032
          i32.add
          i32.load
          f64.convert_i32_s
          f64.div
          local.set 7
          br 2 (;@1;)
        end
        local.get 3
        i32.load
        local.set 0
        block  ;; label = @3
          local.get 5
          local.get 17
          i32.const -3
          i32.mul
          i32.add
          i32.const 27
          i32.add
          local.tee 1
          i32.const 30
          i32.gt_s
          br_if 0 (;@3;)
          local.get 0
          local.get 1
          i32.shr_u
          br_if 1 (;@2;)
        end
        local.get 9
        f64.convert_i32_s
        local.get 0
        f64.convert_i32_u
        f64.mul
        local.get 17
        i32.const 2
        i32.shl
        i32.const 3992
        i32.add
        i32.load
        f64.convert_i32_s
        f64.mul
        local.set 7
        br 1 (;@1;)
      end
      local.get 13
      i32.const 1
      i32.add
      local.set 1
      local.get 13
      i32.const 2
      i32.shl
      local.get 3
      i32.add
      i32.const 4
      i32.add
      local.set 0
      loop  ;; label = @2
        local.get 1
        i32.const -1
        i32.add
        local.set 1
        local.get 0
        i32.const -8
        i32.add
        local.set 8
        local.get 0
        i32.const -4
        i32.add
        local.tee 11
        local.set 0
        local.get 8
        i32.load
        i32.eqz
        br_if 0 (;@2;)
      end
      i32.const 0
      local.set 2
      block  ;; label = @2
        block  ;; label = @3
          local.get 17
          i32.const 9
          i32.rem_s
          local.tee 0
          br_if 0 (;@3;)
          i32.const 0
          local.set 8
          br 1 (;@2;)
        end
        i32.const 0
        local.set 8
        local.get 0
        i32.const 9
        i32.add
        local.get 0
        local.get 17
        i32.const 0
        i32.lt_s
        select
        local.set 21
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            br_if 0 (;@4;)
            i32.const 0
            local.set 1
            br 1 (;@3;)
          end
          i32.const 1000000000
          i32.const 8
          local.get 21
          i32.sub
          i32.const 2
          i32.shl
          i32.const 4032
          i32.add
          i32.load
          local.tee 6
          i32.div_s
          local.set 16
          i32.const 0
          local.set 13
          local.get 3
          local.set 0
          i32.const 0
          local.set 10
          i32.const 0
          local.set 8
          loop  ;; label = @4
            local.get 0
            local.get 0
            i32.load
            local.tee 20
            local.get 6
            i32.div_u
            local.tee 18
            local.get 13
            i32.add
            local.tee 13
            i32.store
            local.get 8
            i32.const 1
            i32.add
            i32.const 127
            i32.and
            local.get 8
            local.get 10
            local.get 8
            i32.eq
            local.get 13
            i32.eqz
            i32.and
            local.tee 13
            select
            local.set 8
            local.get 17
            i32.const -9
            i32.add
            local.get 17
            local.get 13
            select
            local.set 17
            local.get 0
            i32.const 4
            i32.add
            local.set 0
            local.get 20
            local.get 18
            local.get 6
            i32.mul
            i32.sub
            local.get 16
            i32.mul
            local.set 13
            local.get 1
            local.get 10
            i32.const 1
            i32.add
            local.tee 10
            i32.ne
            br_if 0 (;@4;)
          end
          local.get 13
          i32.eqz
          br_if 0 (;@3;)
          local.get 11
          local.get 13
          i32.store
          local.get 1
          i32.const 1
          i32.add
          local.set 1
        end
        local.get 17
        local.get 21
        i32.sub
        i32.const 9
        i32.add
        local.set 17
      end
      loop  ;; label = @2
        local.get 3
        local.get 8
        i32.const 2
        i32.shl
        i32.add
        local.set 6
        block  ;; label = @3
          loop  ;; label = @4
            block  ;; label = @5
              local.get 17
              i32.const 18
              i32.lt_s
              br_if 0 (;@5;)
              local.get 17
              i32.const 18
              i32.ne
              br_if 2 (;@3;)
              local.get 6
              i32.load
              i32.const 9007198
              i32.gt_u
              br_if 2 (;@3;)
            end
            local.get 1
            i32.const 127
            i32.add
            local.set 13
            i32.const 0
            local.set 10
            local.get 1
            local.set 11
            loop  ;; label = @5
              local.get 11
              local.set 1
              block  ;; label = @6
                block  ;; label = @7
                  local.get 3
                  local.get 13
                  i32.const 127
                  i32.and
                  local.tee 0
                  i32.const 2
                  i32.shl
                  i32.add
                  local.tee 11
                  i64.load32_u
                  i64.const 29
                  i64.shl
                  local.get 10
                  i64.extend_i32_u
                  i64.add
                  local.tee 12
                  i64.const 1000000001
                  i64.ge_u
                  br_if 0 (;@7;)
                  i32.const 0
                  local.set 10
                  br 1 (;@6;)
                end
                local.get 12
                local.get 12
                i64.const 1000000000
                i64.div_u
                local.tee 19
                i64.const 1000000000
                i64.mul
                i64.sub
                local.set 12
                local.get 19
                i32.wrap_i64
                local.set 10
              end
              local.get 11
              local.get 12
              i32.wrap_i64
              local.tee 13
              i32.store
              local.get 1
              local.get 1
              local.get 1
              local.get 0
              local.get 13
              select
              local.get 0
              local.get 8
              i32.eq
              select
              local.get 0
              local.get 1
              i32.const -1
              i32.add
              i32.const 127
              i32.and
              i32.ne
              select
              local.set 11
              local.get 0
              i32.const -1
              i32.add
              local.set 13
              local.get 0
              local.get 8
              i32.ne
              br_if 0 (;@5;)
            end
            local.get 2
            i32.const -29
            i32.add
            local.set 2
            local.get 10
            i32.eqz
            br_if 0 (;@4;)
          end
          block  ;; label = @4
            local.get 8
            i32.const -1
            i32.add
            i32.const 127
            i32.and
            local.tee 8
            local.get 11
            i32.ne
            br_if 0 (;@4;)
            local.get 3
            local.get 11
            i32.const 126
            i32.add
            i32.const 127
            i32.and
            i32.const 2
            i32.shl
            i32.add
            local.tee 0
            local.get 0
            i32.load
            local.get 3
            local.get 11
            i32.const -1
            i32.add
            i32.const 127
            i32.and
            local.tee 1
            i32.const 2
            i32.shl
            i32.add
            i32.load
            i32.or
            i32.store
          end
          local.get 17
          i32.const 9
          i32.add
          local.set 17
          local.get 3
          local.get 8
          i32.const 2
          i32.shl
          i32.add
          local.get 10
          i32.store
          br 1 (;@2;)
        end
      end
      block  ;; label = @2
        loop  ;; label = @3
          local.get 3
          local.get 1
          i32.const 127
          i32.and
          i32.const 2
          i32.shl
          i32.add
          local.set 21
          local.get 3
          local.get 1
          i32.const -1
          i32.add
          i32.const 127
          i32.and
          i32.const 2
          i32.shl
          i32.add
          local.set 18
          local.get 3
          local.get 1
          i32.const 1
          i32.add
          i32.const 127
          i32.and
          local.tee 16
          i32.const 2
          i32.shl
          i32.add
          local.set 14
          block  ;; label = @4
            loop  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 8
                  i32.const 127
                  i32.and
                  local.tee 0
                  local.get 1
                  i32.eq
                  br_if 0 (;@7;)
                  block  ;; label = @8
                    local.get 3
                    local.get 0
                    i32.const 2
                    i32.shl
                    i32.add
                    i32.load
                    local.tee 0
                    i32.const 9007199
                    i32.lt_u
                    br_if 0 (;@8;)
                    local.get 0
                    i32.const 9007199
                    i32.ne
                    br_if 2 (;@6;)
                    local.get 8
                    i32.const 1
                    i32.add
                    i32.const 127
                    i32.and
                    local.tee 10
                    local.get 1
                    i32.eq
                    br_if 0 (;@8;)
                    local.get 3
                    local.get 10
                    i32.const 2
                    i32.shl
                    i32.add
                    i32.load
                    i32.const 254740991
                    i32.gt_u
                    br_if 2 (;@6;)
                    local.get 17
                    i32.const 18
                    i32.ne
                    br_if 2 (;@6;)
                    i32.const 9007199
                    local.set 0
                    local.get 1
                    local.set 10
                    br 6 (;@2;)
                  end
                  local.get 17
                  i32.const 18
                  i32.ne
                  br_if 1 (;@6;)
                  local.get 1
                  local.set 10
                  br 5 (;@2;)
                end
                local.get 17
                i32.const 18
                i32.eq
                br_if 2 (;@4;)
              end
              i32.const 9
              i32.const 1
              local.get 17
              i32.const 27
              i32.gt_s
              select
              local.set 13
              block  ;; label = @6
                block  ;; label = @7
                  local.get 8
                  local.get 1
                  i32.eq
                  br_if 0 (;@7;)
                  local.get 13
                  local.get 2
                  i32.add
                  local.set 2
                  i32.const 1000000000
                  local.get 13
                  i32.shr_u
                  local.set 6
                  i32.const -1
                  local.get 13
                  i32.shl
                  i32.const -1
                  i32.xor
                  local.set 20
                  i32.const 0
                  local.set 10
                  local.get 8
                  local.set 0
                  loop  ;; label = @8
                    local.get 3
                    local.get 0
                    i32.const 2
                    i32.shl
                    i32.add
                    local.tee 11
                    local.get 11
                    i32.load
                    local.tee 11
                    local.get 13
                    i32.shr_u
                    local.get 10
                    i32.add
                    local.tee 10
                    i32.store
                    local.get 8
                    i32.const 1
                    i32.add
                    i32.const 127
                    i32.and
                    local.get 8
                    local.get 0
                    local.get 8
                    i32.eq
                    local.get 10
                    i32.eqz
                    i32.and
                    local.tee 10
                    select
                    local.set 8
                    local.get 17
                    i32.const -9
                    i32.add
                    local.get 17
                    local.get 10
                    select
                    local.set 17
                    local.get 11
                    local.get 20
                    i32.and
                    local.get 6
                    i32.mul
                    local.set 10
                    local.get 0
                    i32.const 1
                    i32.add
                    i32.const 127
                    i32.and
                    local.tee 0
                    local.get 1
                    i32.ne
                    br_if 0 (;@8;)
                  end
                  local.get 10
                  i32.eqz
                  br_if 2 (;@5;)
                  local.get 16
                  local.get 8
                  i32.eq
                  br_if 1 (;@6;)
                  local.get 3
                  local.get 1
                  i32.const 2
                  i32.shl
                  i32.add
                  local.get 10
                  i32.store
                  local.get 16
                  local.set 1
                  br 4 (;@3;)
                end
                i32.const 9
                i32.const 1
                local.get 17
                i32.const 27
                i32.gt_s
                select
                local.set 10
                local.get 13
                local.get 2
                i32.add
                local.set 2
                local.get 1
                i32.const 128
                i32.lt_u
                local.set 8
                local.get 17
                i32.const 18
                i32.eq
                local.set 11
                local.get 16
                local.get 1
                i32.eq
                local.set 13
                loop  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 8
                      i32.eqz
                      br_if 0 (;@9;)
                      local.get 11
                      i32.eqz
                      br_if 1 (;@8;)
                      local.get 1
                      local.set 8
                      br 5 (;@4;)
                    end
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 21
                        i32.load
                        local.tee 0
                        i32.const 9007199
                        i32.lt_u
                        br_if 0 (;@10;)
                        local.get 0
                        i32.const 9007199
                        i32.ne
                        br_if 2 (;@8;)
                        local.get 13
                        br_if 0 (;@10;)
                        local.get 14
                        i32.load
                        i32.const 254740991
                        i32.gt_u
                        br_if 2 (;@8;)
                        local.get 11
                        i32.eqz
                        br_if 2 (;@8;)
                        i32.const 9007199
                        local.set 0
                        br 1 (;@9;)
                      end
                      local.get 11
                      i32.eqz
                      br_if 1 (;@8;)
                    end
                    local.get 1
                    local.set 8
                    local.get 1
                    local.set 10
                    br 6 (;@2;)
                  end
                  local.get 2
                  local.get 10
                  i32.add
                  local.set 2
                  br 0 (;@7;)
                end
              end
              local.get 18
              local.get 18
              i32.load
              i32.const 1
              i32.or
              i32.store
              br 0 (;@5;)
            end
          end
        end
        local.get 1
        i32.const 1
        i32.add
        i32.const 127
        i32.and
        local.tee 10
        i32.const 2
        i32.shl
        local.get 3
        i32.add
        i32.const -4
        i32.add
        i32.const 0
        i32.store
        local.get 3
        local.get 1
        i32.const 2
        i32.shl
        i32.add
        i32.load
        local.set 0
      end
      local.get 0
      f64.convert_i32_u
      local.set 7
      block  ;; label = @2
        local.get 8
        i32.const 1
        i32.add
        i32.const 127
        i32.and
        local.tee 0
        local.get 10
        i32.ne
        br_if 0 (;@2;)
        local.get 8
        i32.const 2
        i32.add
        i32.const 127
        i32.and
        local.tee 10
        i32.const 2
        i32.shl
        local.get 3
        i32.add
        i32.const -4
        i32.add
        i32.const 0
        i32.store
      end
      local.get 7
      f64.const 0x1.dcd65p+29 (;=1e+09;)
      f64.mul
      local.get 3
      local.get 0
      i32.const 2
      i32.shl
      i32.add
      i32.load
      f64.convert_i32_u
      f64.add
      local.get 9
      f64.convert_i32_s
      local.tee 23
      f64.mul
      local.set 24
      f64.const 0x0p+0 (;=0;)
      local.set 7
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const 53
          i32.add
          local.tee 11
          local.get 4
          i32.sub
          local.tee 0
          i32.const 0
          local.get 0
          i32.const 0
          i32.gt_s
          select
          local.get 5
          local.get 0
          local.get 5
          i32.lt_s
          local.tee 13
          select
          local.tee 1
          i32.const 52
          i32.le_u
          br_if 0 (;@3;)
          f64.const 0x0p+0 (;=0;)
          local.set 25
          br 1 (;@2;)
        end
        f64.const 0x1p+0 (;=1;)
        i32.const 105
        local.get 1
        i32.sub
        call $scalbn
        local.get 24
        f64.copysign
        local.tee 25
        local.get 24
        local.get 24
        f64.const 0x1p+0 (;=1;)
        i32.const 53
        local.get 1
        i32.sub
        call $scalbn
        call $fmod
        local.tee 7
        f64.sub
        f64.add
        local.set 24
      end
      block  ;; label = @2
        local.get 8
        i32.const 2
        i32.add
        i32.const 127
        i32.and
        local.tee 17
        local.get 10
        i32.eq
        br_if 0 (;@2;)
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            local.get 17
            i32.const 2
            i32.shl
            i32.add
            i32.load
            local.tee 17
            i32.const 499999999
            i32.gt_u
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 17
              br_if 0 (;@5;)
              local.get 8
              i32.const 3
              i32.add
              i32.const 127
              i32.and
              local.get 10
              i32.eq
              br_if 2 (;@3;)
            end
            local.get 23
            f64.const 0x1p-2 (;=0.25;)
            f64.mul
            local.get 7
            f64.add
            local.set 7
            br 1 (;@3;)
          end
          block  ;; label = @4
            local.get 17
            i32.const 500000000
            i32.eq
            br_if 0 (;@4;)
            local.get 23
            f64.const 0x1.8p-1 (;=0.75;)
            f64.mul
            local.get 7
            f64.add
            local.set 7
            br 1 (;@3;)
          end
          block  ;; label = @4
            local.get 8
            i32.const 3
            i32.add
            i32.const 127
            i32.and
            local.get 10
            i32.ne
            br_if 0 (;@4;)
            local.get 23
            f64.const 0x1p-1 (;=0.5;)
            f64.mul
            local.get 7
            f64.add
            local.set 7
            br 1 (;@3;)
          end
          local.get 23
          f64.const 0x1.8p-1 (;=0.75;)
          f64.mul
          local.get 7
          f64.add
          local.set 7
        end
        local.get 7
        local.get 7
        local.get 7
        f64.const 0x1p+0 (;=1;)
        f64.add
        local.get 7
        f64.const 0x1p+0 (;=1;)
        call $fmod
        f64.const 0x0p+0 (;=0;)
        f64.ne
        select
        local.get 1
        i32.const 51
        i32.gt_u
        select
        local.set 7
      end
      local.get 24
      local.get 7
      f64.add
      local.get 25
      f64.sub
      local.set 24
      block  ;; label = @2
        local.get 11
        i32.const 2147483647
        i32.and
        local.get 15
        i32.const -2
        i32.add
        i32.le_s
        br_if 0 (;@2;)
        local.get 24
        f64.const 0x1p-1 (;=0.5;)
        f64.mul
        local.get 24
        local.get 24
        f64.abs
        f64.const 0x1p+53 (;=9.0072e+15;)
        f64.ge
        local.tee 8
        select
        local.set 24
        block  ;; label = @3
          local.get 2
          local.get 8
          i32.add
          local.tee 2
          i32.const 50
          i32.add
          local.get 15
          i32.gt_s
          br_if 0 (;@3;)
          local.get 13
          local.get 1
          local.get 0
          i32.ne
          i32.and
          local.get 13
          local.get 8
          select
          local.get 7
          f64.const 0x0p+0 (;=0;)
          f64.ne
          i32.and
          i32.eqz
          br_if 1 (;@2;)
        end
        i32.const 0
        i32.const 68
        i32.store offset=4644
      end
      local.get 24
      local.get 2
      call $scalbn
      local.set 7
    end
    local.get 3
    i32.const 512
    i32.add
    global.set $__stack_pointer
    local.get 7)
  (func $hexfloat (type 20) (param i32 i32 i32 i32 i32) (result f64)
    (local i32 i64 i32 i32 i32 i64 f64 f64 i32 i32 i32 i64 i64 f64)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load offset=4
        local.tee 5
        local.get 0
        i32.load offset=84
        i32.eq
        br_if 0 (;@2;)
        local.get 0
        local.get 5
        i32.const 1
        i32.add
        i32.store offset=4
        local.get 5
        i32.load8_u
        local.set 5
        br 1 (;@1;)
      end
      local.get 0
      call $__shgetc
      local.set 5
    end
    i64.const 0
    local.set 6
    i32.const 0
    local.set 7
    i32.const 0
    local.set 8
    i32.const 0
    local.set 9
    i64.const 0
    local.set 10
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 5
          i32.const -46
          i32.add
          br_table 1 (;@2;) 2 (;@1;) 0 (;@3;) 2 (;@1;)
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.load offset=4
            local.tee 5
            local.get 0
            i32.load offset=84
            i32.eq
            br_if 0 (;@4;)
            local.get 0
            local.get 5
            i32.const 1
            i32.add
            i32.store offset=4
            local.get 5
            i32.load8_u
            local.set 5
            br 1 (;@3;)
          end
          local.get 0
          call $__shgetc
          local.set 5
        end
        block  ;; label = @3
          loop  ;; label = @4
            block  ;; label = @5
              local.get 5
              i32.const 48
              i32.eq
              br_if 0 (;@5;)
              local.get 5
              i32.const 46
              i32.ne
              br_if 2 (;@3;)
              i32.const 1
              local.set 7
              br 3 (;@2;)
            end
            block  ;; label = @5
              local.get 0
              i32.load offset=4
              local.tee 5
              local.get 0
              i32.load offset=84
              i32.eq
              br_if 0 (;@5;)
              local.get 0
              local.get 5
              i32.const 1
              i32.add
              i32.store offset=4
              local.get 5
              i32.load8_u
              local.set 5
              br 1 (;@4;)
            end
            local.get 0
            call $__shgetc
            local.set 5
            br 0 (;@4;)
          end
        end
        i32.const 1
        local.set 9
        i32.const 0
        local.set 8
        i64.const 0
        local.set 10
        br 1 (;@1;)
      end
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          i32.load offset=4
          local.tee 5
          local.get 0
          i32.load offset=84
          i32.eq
          br_if 0 (;@3;)
          local.get 0
          local.get 5
          i32.const 1
          i32.add
          i32.store offset=4
          local.get 5
          i32.load8_u
          local.set 5
          br 1 (;@2;)
        end
        local.get 0
        call $__shgetc
        local.set 5
      end
      i32.const 1
      local.set 8
      local.get 7
      local.set 9
      i64.const 0
      local.set 10
      local.get 5
      i32.const 48
      i32.ne
      br_if 0 (;@1;)
      i64.const 0
      local.set 10
      loop  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.load offset=4
            local.tee 5
            local.get 0
            i32.load offset=84
            i32.eq
            br_if 0 (;@4;)
            local.get 0
            local.get 5
            i32.const 1
            i32.add
            i32.store offset=4
            local.get 5
            i32.load8_u
            local.set 5
            br 1 (;@3;)
          end
          local.get 0
          call $__shgetc
          local.set 5
        end
        local.get 10
        i64.const -1
        i64.add
        local.set 10
        local.get 5
        i32.const 48
        i32.eq
        br_if 0 (;@2;)
      end
      i32.const 1
      local.set 8
      i32.const 1
      local.set 9
    end
    f64.const 0x1p+0 (;=1;)
    local.set 11
    f64.const 0x0p+0 (;=0;)
    local.set 12
    i32.const 0
    local.set 13
    i32.const 0
    local.set 14
    block  ;; label = @1
      loop  ;; label = @2
        local.get 5
        i32.const 32
        i32.or
        local.set 7
        block  ;; label = @3
          block  ;; label = @4
            local.get 5
            i32.const -48
            i32.add
            local.tee 15
            i32.const 10
            i32.lt_u
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 7
              i32.const -97
              i32.add
              i32.const 6
              i32.lt_u
              br_if 0 (;@5;)
              local.get 5
              i32.const 46
              i32.ne
              br_if 4 (;@1;)
            end
            local.get 5
            i32.const 46
            i32.ne
            br_if 0 (;@4;)
            local.get 8
            br_if 3 (;@1;)
            i32.const 1
            local.set 8
            local.get 6
            local.set 10
            br 1 (;@3;)
          end
          local.get 7
          i32.const -87
          i32.add
          local.get 15
          local.get 5
          i32.const 57
          i32.gt_s
          select
          local.set 5
          block  ;; label = @4
            block  ;; label = @5
              local.get 6
              i64.const 7
              i64.gt_s
              br_if 0 (;@5;)
              local.get 5
              local.get 13
              i32.const 4
              i32.shl
              i32.add
              local.set 13
              br 1 (;@4;)
            end
            block  ;; label = @5
              local.get 6
              i64.const 13
              i64.gt_u
              br_if 0 (;@5;)
              local.get 5
              f64.convert_i32_s
              local.get 11
              f64.const 0x1p-4 (;=0.0625;)
              f64.mul
              local.tee 11
              f64.mul
              local.get 12
              f64.add
              local.set 12
              br 1 (;@4;)
            end
            local.get 12
            local.get 11
            f64.const 0x1p-1 (;=0.5;)
            f64.mul
            local.get 12
            f64.add
            local.get 5
            i32.eqz
            local.get 14
            i32.const 0
            i32.ne
            i32.or
            local.tee 5
            select
            local.set 12
            local.get 14
            i32.const 1
            local.get 5
            select
            local.set 14
          end
          local.get 6
          i64.const 1
          i64.add
          local.set 6
          i32.const 1
          local.set 9
        end
        block  ;; label = @3
          local.get 0
          i32.load offset=4
          local.tee 5
          local.get 0
          i32.load offset=84
          i32.eq
          br_if 0 (;@3;)
          local.get 0
          local.get 5
          i32.const 1
          i32.add
          i32.store offset=4
          local.get 5
          i32.load8_u
          local.set 5
          br 1 (;@2;)
        end
        local.get 0
        call $__shgetc
        local.set 5
        br 0 (;@2;)
      end
    end
    block  ;; label = @1
      local.get 9
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i64.load offset=88
            i64.const 0
            i64.lt_s
            br_if 0 (;@4;)
            local.get 0
            local.get 0
            i32.load offset=4
            local.tee 5
            i32.const -1
            i32.add
            i32.store offset=4
            local.get 4
            i32.eqz
            br_if 1 (;@3;)
            local.get 0
            local.get 5
            i32.const -2
            i32.add
            i32.store offset=4
            local.get 8
            i32.eqz
            br_if 2 (;@2;)
            local.get 0
            local.get 5
            i32.const -3
            i32.add
            i32.store offset=4
            br 2 (;@2;)
          end
          local.get 4
          br_if 1 (;@2;)
        end
        local.get 0
        i64.const 0
        call $__shlim
      end
      local.get 3
      f64.convert_i32_s
      f64.const 0x0p+0 (;=0;)
      f64.mul
      return
    end
    block  ;; label = @1
      local.get 6
      i64.const 7
      i64.gt_s
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          i64.const 0
          local.get 6
          i64.sub
          i64.const 7
          i64.and
          local.tee 16
          i64.eqz
          i32.eqz
          br_if 0 (;@3;)
          local.get 6
          local.set 17
          br 1 (;@2;)
        end
        local.get 6
        local.set 17
        loop  ;; label = @3
          local.get 17
          i64.const 1
          i64.add
          local.set 17
          local.get 13
          i32.const 4
          i32.shl
          local.set 13
          local.get 16
          i64.const -1
          i64.add
          local.tee 16
          i64.const 0
          i64.ne
          br_if 0 (;@3;)
        end
      end
      local.get 6
      i64.const -1
      i64.add
      i64.const 7
      i64.lt_u
      br_if 0 (;@1;)
      local.get 17
      i64.const -8
      i64.add
      local.set 17
      loop  ;; label = @2
        local.get 17
        i64.const 8
        i64.add
        local.tee 17
        i64.const 0
        i64.ne
        br_if 0 (;@2;)
      end
      i32.const 0
      local.set 13
    end
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 5
            i32.const -33
            i32.and
            i32.const 80
            i32.ne
            br_if 0 (;@4;)
            local.get 0
            local.get 4
            call $scanexp
            local.tee 17
            i64.const -9223372036854775808
            i64.ne
            br_if 3 (;@1;)
            block  ;; label = @5
              local.get 4
              i32.eqz
              br_if 0 (;@5;)
              local.get 0
              i64.load offset=88
              i64.const -1
              i64.gt_s
              br_if 2 (;@3;)
              br 3 (;@2;)
            end
            local.get 0
            i64.const 0
            call $__shlim
            f64.const 0x0p+0 (;=0;)
            return
          end
          i64.const 0
          local.set 17
          local.get 0
          i64.load offset=88
          i64.const 0
          i64.lt_s
          br_if 2 (;@1;)
        end
        local.get 0
        local.get 0
        i32.load offset=4
        i32.const -1
        i32.add
        i32.store offset=4
      end
      i64.const 0
      local.set 17
    end
    block  ;; label = @1
      local.get 13
      br_if 0 (;@1;)
      local.get 3
      f64.convert_i32_s
      f64.const 0x0p+0 (;=0;)
      f64.mul
      return
    end
    block  ;; label = @1
      local.get 10
      local.get 6
      local.get 8
      select
      i64.const 2
      i64.shl
      local.get 17
      i64.add
      i64.const -32
      i64.add
      local.tee 6
      i32.const 0
      local.get 2
      i32.sub
      i64.extend_i32_u
      i64.le_s
      br_if 0 (;@1;)
      i32.const 0
      i32.const 68
      i32.store offset=4644
      local.get 3
      f64.convert_i32_s
      f64.const 0x1.fffffffffffffp+1023 (;=1.79769e+308;)
      f64.mul
      f64.const 0x1.fffffffffffffp+1023 (;=1.79769e+308;)
      f64.mul
      return
    end
    block  ;; label = @1
      local.get 6
      local.get 2
      i32.const -106
      i32.add
      i64.extend_i32_s
      i64.lt_s
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 13
        i32.const 0
        i32.lt_s
        br_if 0 (;@2;)
        loop  ;; label = @3
          local.get 12
          local.get 12
          f64.const -0x1p+0 (;=-1;)
          f64.add
          local.get 12
          local.get 12
          f64.const 0x1p-1 (;=0.5;)
          f64.ge
          local.tee 5
          select
          f64.add
          local.set 12
          local.get 6
          i64.const -1
          i64.add
          local.set 6
          local.get 5
          local.get 13
          i32.const 1
          i32.shl
          i32.or
          local.tee 13
          i32.const -1
          i32.gt_s
          br_if 0 (;@3;)
        end
      end
      block  ;; label = @2
        block  ;; label = @3
          local.get 6
          local.get 2
          i64.extend_i32_s
          i64.sub
          i64.const 32
          i64.add
          local.tee 10
          i32.wrap_i64
          local.tee 5
          i32.const 0
          local.get 5
          i32.const 0
          i32.gt_s
          select
          local.get 1
          local.get 10
          local.get 1
          i64.extend_i32_u
          i64.lt_s
          select
          local.tee 5
          i32.const 53
          i32.lt_s
          br_if 0 (;@3;)
          local.get 3
          f64.convert_i32_s
          local.set 11
          f64.const 0x0p+0 (;=0;)
          local.set 18
          br 1 (;@2;)
        end
        f64.const 0x1p+0 (;=1;)
        i32.const 84
        local.get 5
        i32.sub
        call $scalbn
        local.get 3
        f64.convert_i32_s
        local.tee 11
        f64.copysign
        local.set 18
      end
      block  ;; label = @2
        local.get 11
        f64.const 0x0p+0 (;=0;)
        local.get 12
        local.get 5
        i32.const 32
        i32.lt_s
        local.get 12
        f64.const 0x0p+0 (;=0;)
        f64.ne
        i32.and
        local.get 13
        i32.const 1
        i32.and
        i32.eqz
        i32.and
        local.tee 5
        select
        f64.mul
        local.get 11
        local.get 13
        local.get 5
        i32.add
        f64.convert_i32_u
        f64.mul
        local.get 18
        f64.add
        f64.add
        local.get 18
        f64.sub
        local.tee 12
        f64.const 0x0p+0 (;=0;)
        f64.ne
        br_if 0 (;@2;)
        i32.const 0
        i32.const 68
        i32.store offset=4644
      end
      local.get 12
      local.get 6
      i32.wrap_i64
      call $scalbn
      return
    end
    i32.const 0
    i32.const 68
    i32.store offset=4644
    local.get 3
    f64.convert_i32_s
    f64.const 0x1p-1022 (;=2.22507e-308;)
    f64.mul
    f64.const 0x1p-1022 (;=2.22507e-308;)
    f64.mul)
  (func $scanexp (type 21) (param i32 i32) (result i64)
    (local i32 i32 i32 i32 i64)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load offset=4
        local.tee 2
        local.get 0
        i32.load offset=84
        i32.eq
        br_if 0 (;@2;)
        local.get 0
        local.get 2
        i32.const 1
        i32.add
        i32.store offset=4
        local.get 2
        i32.load8_u
        local.set 3
        br 1 (;@1;)
      end
      local.get 0
      call $__shgetc
      local.set 3
    end
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 3
              i32.const -43
              i32.add
              br_table 0 (;@5;) 1 (;@4;) 0 (;@5;) 1 (;@4;)
            end
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.load offset=4
                local.tee 2
                local.get 0
                i32.load offset=84
                i32.eq
                br_if 0 (;@6;)
                local.get 0
                local.get 2
                i32.const 1
                i32.add
                i32.store offset=4
                local.get 2
                i32.load8_u
                local.set 2
                br 1 (;@5;)
              end
              local.get 0
              call $__shgetc
              local.set 2
            end
            local.get 3
            i32.const 45
            i32.eq
            local.set 4
            local.get 2
            i32.const -58
            i32.add
            local.set 5
            local.get 1
            i32.eqz
            br_if 1 (;@3;)
            local.get 5
            i32.const -11
            i32.gt_u
            br_if 1 (;@3;)
            local.get 0
            i64.load offset=88
            i64.const 0
            i64.lt_s
            br_if 2 (;@2;)
            local.get 0
            local.get 0
            i32.load offset=4
            i32.const -1
            i32.add
            i32.store offset=4
            br 2 (;@2;)
          end
          local.get 3
          i32.const -58
          i32.add
          local.set 5
          i32.const 0
          local.set 4
          local.get 3
          local.set 2
        end
        local.get 5
        i32.const -10
        i32.lt_u
        br_if 0 (;@2;)
        i64.const 0
        local.set 6
        block  ;; label = @3
          local.get 2
          i32.const -48
          i32.add
          local.tee 5
          i32.const 9
          i32.gt_u
          br_if 0 (;@3;)
          i32.const 0
          local.set 3
          loop  ;; label = @4
            local.get 2
            local.get 3
            i32.const 10
            i32.mul
            i32.add
            local.set 3
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.load offset=4
                local.tee 2
                local.get 0
                i32.load offset=84
                i32.eq
                br_if 0 (;@6;)
                local.get 0
                local.get 2
                i32.const 1
                i32.add
                i32.store offset=4
                local.get 2
                i32.load8_u
                local.set 2
                br 1 (;@5;)
              end
              local.get 0
              call $__shgetc
              local.set 2
            end
            local.get 3
            i32.const -48
            i32.add
            local.set 3
            block  ;; label = @5
              local.get 2
              i32.const -48
              i32.add
              local.tee 5
              i32.const 9
              i32.gt_u
              br_if 0 (;@5;)
              local.get 3
              i32.const 214748364
              i32.lt_s
              br_if 1 (;@4;)
            end
          end
          local.get 3
          i64.extend_i32_s
          local.set 6
        end
        block  ;; label = @3
          local.get 5
          i32.const 9
          i32.gt_u
          br_if 0 (;@3;)
          loop  ;; label = @4
            local.get 2
            i64.extend_i32_u
            local.get 6
            i64.const 10
            i64.mul
            i64.add
            local.set 6
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.load offset=4
                local.tee 2
                local.get 0
                i32.load offset=84
                i32.eq
                br_if 0 (;@6;)
                local.get 0
                local.get 2
                i32.const 1
                i32.add
                i32.store offset=4
                local.get 2
                i32.load8_u
                local.set 2
                br 1 (;@5;)
              end
              local.get 0
              call $__shgetc
              local.set 2
            end
            local.get 6
            i64.const -48
            i64.add
            local.set 6
            local.get 2
            i32.const -48
            i32.add
            local.tee 5
            i32.const 9
            i32.gt_u
            br_if 1 (;@3;)
            local.get 6
            i64.const 92233720368547758
            i64.lt_s
            br_if 0 (;@4;)
          end
        end
        block  ;; label = @3
          local.get 5
          i32.const 9
          i32.gt_u
          br_if 0 (;@3;)
          loop  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.load offset=4
                local.tee 2
                local.get 0
                i32.load offset=84
                i32.eq
                br_if 0 (;@6;)
                local.get 0
                local.get 2
                i32.const 1
                i32.add
                i32.store offset=4
                local.get 2
                i32.load8_u
                local.set 2
                br 1 (;@5;)
              end
              local.get 0
              call $__shgetc
              local.set 2
            end
            local.get 2
            i32.const -48
            i32.add
            i32.const 10
            i32.lt_u
            br_if 0 (;@4;)
          end
        end
        block  ;; label = @3
          local.get 0
          i64.load offset=88
          i64.const 0
          i64.lt_s
          br_if 0 (;@3;)
          local.get 0
          local.get 0
          i32.load offset=4
          i32.const -1
          i32.add
          i32.store offset=4
        end
        i64.const 0
        local.get 6
        i64.sub
        local.get 6
        local.get 4
        select
        local.set 6
        br 1 (;@1;)
      end
      i64.const -9223372036854775808
      local.set 6
      local.get 0
      i64.load offset=88
      i64.const 0
      i64.lt_s
      br_if 0 (;@1;)
      local.get 0
      local.get 0
      i32.load offset=4
      i32.const -1
      i32.add
      i32.store offset=4
      i64.const -9223372036854775808
      return
    end
    local.get 6)
  (func $mbrtowc (type 5) (param i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32)
    local.get 3
    i32.const 7272
    local.get 3
    select
    local.tee 4
    i32.load
    local.set 3
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            br_if 0 (;@4;)
            local.get 3
            br_if 1 (;@3;)
            i32.const 0
            return
          end
          i32.const -2
          local.set 5
          local.get 2
          i32.eqz
          br_if 1 (;@2;)
          block  ;; label = @4
            block  ;; label = @5
              local.get 3
              i32.eqz
              br_if 0 (;@5;)
              local.get 2
              local.set 6
              br 1 (;@4;)
            end
            block  ;; label = @5
              local.get 1
              i32.load8_u
              local.tee 5
              i32.extend8_s
              local.tee 3
              i32.const 0
              i32.lt_s
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 0
                i32.eqz
                br_if 0 (;@6;)
                local.get 0
                local.get 5
                i32.store
              end
              local.get 3
              i32.const 0
              i32.ne
              return
            end
            block  ;; label = @5
              i32.const 0
              i32.load offset=6200
              br_if 0 (;@5;)
              i32.const 1
              local.set 5
              local.get 0
              i32.eqz
              br_if 3 (;@2;)
              local.get 0
              local.get 3
              i32.const 57343
              i32.and
              i32.store
              i32.const 1
              return
            end
            local.get 5
            i32.const -194
            i32.add
            local.tee 3
            i32.const 50
            i32.gt_u
            br_if 1 (;@3;)
            local.get 3
            i32.const 2
            i32.shl
            i32.const 4064
            i32.add
            i32.load
            local.set 3
            local.get 2
            i32.const -1
            i32.add
            local.tee 6
            i32.eqz
            br_if 3 (;@1;)
            local.get 1
            i32.const 1
            i32.add
            local.set 1
          end
          local.get 1
          i32.load8_u
          local.tee 5
          i32.const 3
          i32.shr_u
          local.tee 7
          i32.const -16
          i32.add
          local.get 3
          i32.const 26
          i32.shr_s
          local.get 7
          i32.add
          i32.or
          i32.const 7
          i32.gt_u
          br_if 0 (;@3;)
          local.get 1
          i32.const 1
          i32.add
          local.set 7
          local.get 6
          i32.const -1
          i32.add
          local.set 1
          loop  ;; label = @4
            block  ;; label = @5
              local.get 5
              i32.const 255
              i32.and
              i32.const -128
              i32.add
              local.get 3
              i32.const 6
              i32.shl
              i32.or
              local.tee 3
              i32.const 0
              i32.lt_s
              br_if 0 (;@5;)
              local.get 4
              i32.const 0
              i32.store
              block  ;; label = @6
                local.get 0
                i32.eqz
                br_if 0 (;@6;)
                local.get 0
                local.get 3
                i32.store
              end
              local.get 2
              local.get 1
              i32.sub
              return
            end
            local.get 1
            i32.eqz
            br_if 3 (;@1;)
            local.get 1
            i32.const -1
            i32.add
            local.set 1
            local.get 7
            i32.load8_u
            local.set 5
            local.get 7
            i32.const 1
            i32.add
            local.set 7
            local.get 5
            i32.const 192
            i32.and
            i32.const 128
            i32.eq
            br_if 0 (;@4;)
          end
        end
        local.get 4
        i32.const 0
        i32.store
        i32.const 0
        i32.const 25
        i32.store offset=4644
        i32.const -1
        local.set 5
      end
      local.get 5
      return
    end
    local.get 4
    local.get 3
    i32.store
    i32.const -2)
  (func $mbsinit (type 0) (param i32) (result i32)
    block  ;; label = @1
      local.get 0
      br_if 0 (;@1;)
      i32.const 1
      return
    end
    local.get 0
    i32.load
    i32.eqz)
  (func $vfscanf (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i64 i32 i32 i32 i32 i32 i32 i32 i64 f64 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 304
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.load offset=4
            br_if 0 (;@4;)
            local.get 0
            call $__toread
            drop
            local.get 0
            i32.load offset=4
            br_if 0 (;@4;)
            i32.const 0
            local.set 4
            br 1 (;@3;)
          end
          block  ;; label = @4
            local.get 1
            i32.load8_u
            local.tee 5
            br_if 0 (;@4;)
            i32.const 0
            local.set 6
            br 3 (;@1;)
          end
          local.get 3
          i32.const 16
          i32.add
          i32.const 1
          i32.or
          local.set 7
          local.get 3
          i32.const 16
          i32.add
          i32.const 10
          i32.or
          local.set 8
          i64.const 0
          local.set 9
          i32.const 0
          local.set 6
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  loop  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 5
                          i32.const 255
                          i32.and
                          local.tee 5
                          i32.const 32
                          i32.eq
                          br_if 0 (;@11;)
                          local.get 5
                          i32.const -14
                          i32.add
                          i32.const -5
                          i32.lt_u
                          br_if 1 (;@10;)
                        end
                        local.get 1
                        i32.const 1
                        i32.add
                        local.set 5
                        loop  ;; label = @11
                          local.get 5
                          i32.load8_u
                          local.tee 1
                          i32.const -14
                          i32.add
                          local.set 10
                          local.get 5
                          i32.const 1
                          i32.add
                          local.tee 11
                          local.set 5
                          local.get 1
                          i32.const 32
                          i32.eq
                          br_if 0 (;@11;)
                          local.get 11
                          local.set 5
                          local.get 10
                          i32.const -6
                          i32.gt_u
                          br_if 0 (;@11;)
                        end
                        local.get 0
                        i64.const 0
                        call $__shlim
                        local.get 11
                        i32.const -2
                        i32.add
                        local.set 10
                        loop  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 0
                              i32.load offset=4
                              local.tee 5
                              local.get 0
                              i32.load offset=84
                              i32.eq
                              br_if 0 (;@13;)
                              local.get 0
                              local.get 5
                              i32.const 1
                              i32.add
                              i32.store offset=4
                              local.get 5
                              i32.load8_u
                              local.set 5
                              br 1 (;@12;)
                            end
                            local.get 0
                            call $__shgetc
                            local.set 5
                          end
                          local.get 5
                          i32.const -9
                          i32.add
                          i32.const 5
                          i32.lt_u
                          br_if 0 (;@11;)
                          local.get 5
                          i32.const 32
                          i32.eq
                          br_if 0 (;@11;)
                        end
                        local.get 0
                        i32.load offset=4
                        local.set 5
                        block  ;; label = @11
                          local.get 0
                          i64.load offset=88
                          i64.const 0
                          i64.lt_s
                          br_if 0 (;@11;)
                          local.get 0
                          local.get 5
                          i32.const -1
                          i32.add
                          local.tee 5
                          i32.store offset=4
                        end
                        local.get 0
                        i64.load offset=96
                        local.get 9
                        i64.add
                        local.get 5
                        local.get 0
                        i32.load offset=40
                        i32.sub
                        i64.extend_i32_s
                        i64.add
                        local.set 9
                        br 1 (;@9;)
                      end
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 5
                              i32.const 37
                              i32.ne
                              br_if 0 (;@13;)
                              local.get 1
                              i32.load8_u offset=1
                              local.tee 5
                              i32.const -37
                              i32.add
                              br_table 0 (;@13;) 2 (;@11;) 2 (;@11;) 2 (;@11;) 2 (;@11;) 1 (;@12;) 2 (;@11;)
                            end
                            local.get 0
                            i64.const 0
                            call $__shlim
                            block  ;; label = @13
                              block  ;; label = @14
                                local.get 1
                                i32.load8_u
                                i32.const 37
                                i32.ne
                                br_if 0 (;@14;)
                                loop  ;; label = @15
                                  block  ;; label = @16
                                    block  ;; label = @17
                                      local.get 0
                                      i32.load offset=4
                                      local.tee 5
                                      local.get 0
                                      i32.load offset=84
                                      i32.eq
                                      br_if 0 (;@17;)
                                      local.get 0
                                      local.get 5
                                      i32.const 1
                                      i32.add
                                      i32.store offset=4
                                      local.get 5
                                      i32.load8_u
                                      local.set 5
                                      br 1 (;@16;)
                                    end
                                    local.get 0
                                    call $__shgetc
                                    local.set 5
                                  end
                                  local.get 5
                                  i32.const -9
                                  i32.add
                                  i32.const 5
                                  i32.lt_u
                                  br_if 0 (;@15;)
                                  local.get 5
                                  i32.const 32
                                  i32.eq
                                  br_if 0 (;@15;)
                                end
                                local.get 1
                                i32.const 1
                                i32.add
                                local.set 1
                                br 1 (;@13;)
                              end
                              block  ;; label = @14
                                local.get 0
                                i32.load offset=4
                                local.tee 5
                                local.get 0
                                i32.load offset=84
                                i32.eq
                                br_if 0 (;@14;)
                                local.get 0
                                local.get 5
                                i32.const 1
                                i32.add
                                i32.store offset=4
                                local.get 5
                                i32.load8_u
                                local.set 5
                                br 1 (;@13;)
                              end
                              local.get 0
                              call $__shgetc
                              local.set 5
                            end
                            block  ;; label = @13
                              local.get 5
                              local.get 1
                              i32.load8_u
                              i32.eq
                              br_if 0 (;@13;)
                              block  ;; label = @14
                                local.get 0
                                i64.load offset=88
                                i64.const 0
                                i64.lt_s
                                br_if 0 (;@14;)
                                local.get 0
                                local.get 0
                                i32.load offset=4
                                i32.const -1
                                i32.add
                                i32.store offset=4
                              end
                              local.get 5
                              i32.const -1
                              i32.gt_s
                              br_if 12 (;@1;)
                              i32.const 0
                              local.set 4
                              local.get 6
                              i32.eqz
                              br_if 10 (;@3;)
                              br 12 (;@1;)
                            end
                            local.get 0
                            i64.load offset=96
                            local.get 9
                            i64.add
                            local.get 0
                            i32.load offset=4
                            local.get 0
                            i32.load offset=40
                            i32.sub
                            i64.extend_i32_s
                            i64.add
                            local.set 9
                            local.get 1
                            local.set 10
                            br 3 (;@9;)
                          end
                          local.get 1
                          i32.const 2
                          i32.add
                          local.set 1
                          i32.const 0
                          local.set 12
                          br 1 (;@10;)
                        end
                        block  ;; label = @11
                          local.get 5
                          i32.const -48
                          i32.add
                          local.tee 5
                          i32.const 9
                          i32.gt_u
                          br_if 0 (;@11;)
                          local.get 1
                          i32.load8_u offset=2
                          i32.const 36
                          i32.ne
                          br_if 0 (;@11;)
                          local.get 3
                          local.get 2
                          i32.store offset=300
                          local.get 3
                          local.get 2
                          local.get 5
                          i32.const 2
                          i32.shl
                          i32.const -4
                          i32.add
                          i32.const 0
                          local.get 5
                          i32.const 1
                          i32.gt_u
                          select
                          i32.add
                          local.tee 5
                          i32.const 4
                          i32.add
                          i32.store offset=296
                          local.get 5
                          i32.load
                          local.set 12
                          local.get 1
                          i32.const 3
                          i32.add
                          local.set 1
                          br 1 (;@10;)
                        end
                        local.get 1
                        i32.const 1
                        i32.add
                        local.set 1
                        local.get 2
                        i32.load
                        local.set 12
                        local.get 2
                        i32.const 4
                        i32.add
                        local.set 2
                      end
                      i32.const 0
                      local.set 4
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 1
                          i32.load8_u
                          local.tee 5
                          i32.const -48
                          i32.add
                          i32.const 9
                          i32.le_u
                          br_if 0 (;@11;)
                          local.get 1
                          local.set 10
                          i32.const 0
                          local.set 11
                          br 1 (;@10;)
                        end
                        i32.const 0
                        local.set 11
                        loop  ;; label = @11
                          local.get 5
                          local.get 11
                          i32.const 10
                          i32.mul
                          i32.add
                          i32.const -48
                          i32.add
                          local.set 11
                          local.get 1
                          i32.load8_u offset=1
                          local.set 5
                          local.get 1
                          i32.const 1
                          i32.add
                          local.tee 10
                          local.set 1
                          local.get 5
                          i32.const -48
                          i32.add
                          i32.const 10
                          i32.lt_u
                          br_if 0 (;@11;)
                        end
                      end
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 5
                          i32.const 109
                          i32.eq
                          br_if 0 (;@11;)
                          local.get 10
                          local.set 13
                          br 1 (;@10;)
                        end
                        local.get 10
                        i32.const 1
                        i32.add
                        local.set 13
                        i32.const 0
                        local.set 14
                        local.get 12
                        i32.const 0
                        i32.ne
                        local.set 4
                        local.get 10
                        i32.load8_u offset=1
                        local.set 5
                        i32.const 0
                        local.set 15
                      end
                      local.get 13
                      i32.const 1
                      i32.add
                      local.set 10
                      i32.const 3
                      local.set 1
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 5
                                  i32.const 255
                                  i32.and
                                  i32.const -65
                                  i32.add
                                  br_table 4 (;@11;) 11 (;@4;) 4 (;@11;) 11 (;@4;) 4 (;@11;) 4 (;@11;) 4 (;@11;) 11 (;@4;) 11 (;@4;) 11 (;@4;) 11 (;@4;) 3 (;@12;) 11 (;@4;) 11 (;@4;) 11 (;@4;) 11 (;@4;) 11 (;@4;) 11 (;@4;) 4 (;@11;) 11 (;@4;) 11 (;@4;) 11 (;@4;) 11 (;@4;) 4 (;@11;) 11 (;@4;) 11 (;@4;) 4 (;@11;) 11 (;@4;) 11 (;@4;) 11 (;@4;) 11 (;@4;) 11 (;@4;) 4 (;@11;) 11 (;@4;) 4 (;@11;) 4 (;@11;) 4 (;@11;) 4 (;@11;) 4 (;@11;) 0 (;@15;) 4 (;@11;) 5 (;@10;) 11 (;@4;) 1 (;@14;) 11 (;@4;) 4 (;@11;) 4 (;@11;) 4 (;@11;) 11 (;@4;) 11 (;@4;) 4 (;@11;) 2 (;@13;) 4 (;@11;) 11 (;@4;) 11 (;@4;) 4 (;@11;) 11 (;@4;) 2 (;@13;) 11 (;@4;)
                                end
                                local.get 13
                                i32.const 2
                                i32.add
                                local.get 10
                                local.get 13
                                i32.load8_u offset=1
                                i32.const 104
                                i32.eq
                                local.tee 5
                                select
                                local.set 10
                                i32.const -2
                                i32.const -1
                                local.get 5
                                select
                                local.set 1
                                br 4 (;@10;)
                              end
                              local.get 13
                              i32.const 2
                              i32.add
                              local.get 10
                              local.get 13
                              i32.load8_u offset=1
                              i32.const 108
                              i32.eq
                              local.tee 5
                              select
                              local.set 10
                              i32.const 3
                              i32.const 1
                              local.get 5
                              select
                              local.set 1
                              br 3 (;@10;)
                            end
                            i32.const 1
                            local.set 1
                            br 2 (;@10;)
                          end
                          i32.const 2
                          local.set 1
                          br 1 (;@10;)
                        end
                        i32.const 0
                        local.set 1
                        local.get 13
                        local.set 10
                      end
                      i32.const 1
                      local.get 1
                      local.get 10
                      i32.load8_u
                      local.tee 5
                      i32.const 47
                      i32.and
                      i32.const 3
                      i32.eq
                      local.tee 13
                      select
                      local.set 16
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 5
                              i32.const 32
                              i32.or
                              local.get 5
                              local.get 13
                              select
                              local.tee 13
                              i32.const -91
                              i32.add
                              br_table 3 (;@10;) 2 (;@11;) 2 (;@11;) 2 (;@11;) 2 (;@11;) 2 (;@11;) 2 (;@11;) 2 (;@11;) 0 (;@13;) 2 (;@11;) 2 (;@11;) 2 (;@11;) 2 (;@11;) 2 (;@11;) 2 (;@11;) 2 (;@11;) 2 (;@11;) 2 (;@11;) 2 (;@11;) 1 (;@12;) 2 (;@11;)
                            end
                            local.get 11
                            i32.const 1
                            local.get 11
                            i32.const 1
                            i32.gt_s
                            select
                            local.set 11
                            br 2 (;@10;)
                          end
                          local.get 12
                          i32.eqz
                          br_if 2 (;@9;)
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 16
                                  i32.const 2
                                  i32.add
                                  br_table 0 (;@15;) 1 (;@14;) 2 (;@13;) 2 (;@13;) 6 (;@9;) 3 (;@12;) 6 (;@9;)
                                end
                                local.get 12
                                local.get 9
                                i64.store8
                                br 5 (;@9;)
                              end
                              local.get 12
                              local.get 9
                              i64.store16
                              br 4 (;@9;)
                            end
                            local.get 12
                            local.get 9
                            i64.store32
                            br 3 (;@9;)
                          end
                          local.get 12
                          local.get 9
                          i64.store
                          br 2 (;@9;)
                        end
                        local.get 0
                        i64.const 0
                        call $__shlim
                        loop  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 0
                              i32.load offset=4
                              local.tee 5
                              local.get 0
                              i32.load offset=84
                              i32.eq
                              br_if 0 (;@13;)
                              local.get 0
                              local.get 5
                              i32.const 1
                              i32.add
                              i32.store offset=4
                              local.get 5
                              i32.load8_u
                              local.set 5
                              br 1 (;@12;)
                            end
                            local.get 0
                            call $__shgetc
                            local.set 5
                          end
                          local.get 5
                          i32.const -9
                          i32.add
                          i32.const 5
                          i32.lt_u
                          br_if 0 (;@11;)
                          local.get 5
                          i32.const 32
                          i32.eq
                          br_if 0 (;@11;)
                        end
                        local.get 0
                        i32.load offset=4
                        local.set 5
                        block  ;; label = @11
                          local.get 0
                          i64.load offset=88
                          i64.const 0
                          i64.lt_s
                          br_if 0 (;@11;)
                          local.get 0
                          local.get 5
                          i32.const -1
                          i32.add
                          local.tee 5
                          i32.store offset=4
                        end
                        local.get 0
                        i64.load offset=96
                        local.get 9
                        i64.add
                        local.get 5
                        local.get 0
                        i32.load offset=40
                        i32.sub
                        i64.extend_i32_s
                        i64.add
                        local.set 9
                      end
                      local.get 0
                      local.get 11
                      i64.extend_i32_s
                      local.tee 17
                      call $__shlim
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 0
                          i32.load offset=4
                          local.tee 5
                          local.get 0
                          i32.load offset=84
                          i32.eq
                          br_if 0 (;@11;)
                          local.get 0
                          local.get 5
                          i32.const 1
                          i32.add
                          i32.store offset=4
                          br 1 (;@10;)
                        end
                        local.get 0
                        call $__shgetc
                        i32.const 0
                        i32.lt_s
                        br_if 6 (;@4;)
                      end
                      block  ;; label = @10
                        local.get 0
                        i64.load offset=88
                        i64.const 0
                        i64.lt_s
                        br_if 0 (;@10;)
                        local.get 0
                        local.get 0
                        i32.load offset=4
                        i32.const -1
                        i32.add
                        i32.store offset=4
                      end
                      i32.const 16
                      local.set 5
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  block  ;; label = @16
                                    block  ;; label = @17
                                      block  ;; label = @18
                                        block  ;; label = @19
                                          local.get 13
                                          i32.const -65
                                          i32.add
                                          br_table 5 (;@14;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 5 (;@14;) 5 (;@14;) 5 (;@14;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 4 (;@15;) 9 (;@10;) 9 (;@10;) 0 (;@19;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 5 (;@14;) 9 (;@10;) 0 (;@19;) 2 (;@17;) 5 (;@14;) 5 (;@14;) 5 (;@14;) 9 (;@10;) 3 (;@16;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 9 (;@10;) 1 (;@18;) 4 (;@15;) 9 (;@10;) 9 (;@10;) 0 (;@19;) 9 (;@10;) 2 (;@17;) 9 (;@10;) 9 (;@10;) 4 (;@15;) 9 (;@10;)
                                        end
                                        block  ;; label = @19
                                          block  ;; label = @20
                                            local.get 13
                                            i32.const -99
                                            i32.add
                                            br_table 0 (;@20;) 1 (;@19;) 1 (;@19;) 1 (;@19;) 1 (;@19;) 1 (;@19;) 1 (;@19;) 1 (;@19;) 1 (;@19;) 1 (;@19;) 1 (;@19;) 1 (;@19;) 1 (;@19;) 1 (;@19;) 1 (;@19;) 1 (;@19;) 0 (;@20;) 1 (;@19;)
                                          end
                                          local.get 3
                                          i32.const 16
                                          i32.add
                                          i32.const 255
                                          i32.const 257
                                          call $memset
                                          drop
                                          local.get 3
                                          i32.const 0
                                          i32.store8 offset=16
                                          local.get 13
                                          i32.const 115
                                          i32.ne
                                          br_if 8 (;@11;)
                                          local.get 8
                                          i32.const 0
                                          i32.store align=2
                                          local.get 8
                                          i32.const 4
                                          i32.add
                                          i32.const 0
                                          i32.store8
                                          local.get 3
                                          i32.const 0
                                          i32.store8 offset=49
                                          br 8 (;@11;)
                                        end
                                        local.get 3
                                        i32.const 16
                                        i32.add
                                        local.get 10
                                        i32.load8_u offset=1
                                        i32.const 94
                                        i32.eq
                                        local.tee 1
                                        i32.const 257
                                        call $memset
                                        drop
                                        local.get 3
                                        i32.const 0
                                        i32.store8 offset=16
                                        local.get 10
                                        i32.const 2
                                        i32.add
                                        local.get 10
                                        i32.const 1
                                        i32.add
                                        local.get 1
                                        select
                                        local.set 5
                                        block  ;; label = @19
                                          block  ;; label = @20
                                            block  ;; label = @21
                                              local.get 10
                                              i32.const 2
                                              i32.const 1
                                              local.get 1
                                              select
                                              i32.add
                                              i32.load8_u
                                              local.tee 10
                                              i32.const 45
                                              i32.eq
                                              br_if 0 (;@21;)
                                              local.get 10
                                              i32.const 93
                                              i32.eq
                                              br_if 1 (;@20;)
                                              local.get 1
                                              i32.const 1
                                              i32.xor
                                              local.set 10
                                              br 8 (;@13;)
                                            end
                                            local.get 3
                                            local.get 1
                                            i32.const 1
                                            i32.xor
                                            local.tee 10
                                            i32.store8 offset=62
                                            br 1 (;@19;)
                                          end
                                          local.get 3
                                          local.get 1
                                          i32.const 1
                                          i32.xor
                                          local.tee 10
                                          i32.store8 offset=110
                                        end
                                        i32.const 0
                                        local.set 1
                                        br 6 (;@12;)
                                      end
                                      i32.const 8
                                      local.set 5
                                      br 2 (;@15;)
                                    end
                                    i32.const 10
                                    local.set 5
                                    br 1 (;@15;)
                                  end
                                  i32.const 0
                                  local.set 5
                                end
                                local.get 0
                                local.get 5
                                i32.const 0
                                i64.const -1
                                call $__intscan
                                local.set 17
                                local.get 0
                                i64.load offset=96
                                i64.const 0
                                local.get 0
                                i32.load offset=4
                                local.get 0
                                i32.load offset=40
                                i32.sub
                                i64.extend_i32_s
                                i64.sub
                                i64.eq
                                br_if 12 (;@2;)
                                block  ;; label = @15
                                  local.get 13
                                  i32.const 112
                                  i32.ne
                                  br_if 0 (;@15;)
                                  local.get 12
                                  i32.eqz
                                  br_if 0 (;@15;)
                                  local.get 12
                                  local.get 17
                                  i64.store32
                                  br 5 (;@10;)
                                end
                                local.get 12
                                i32.eqz
                                br_if 4 (;@10;)
                                block  ;; label = @15
                                  block  ;; label = @16
                                    block  ;; label = @17
                                      block  ;; label = @18
                                        local.get 16
                                        i32.const 2
                                        i32.add
                                        br_table 0 (;@18;) 1 (;@17;) 2 (;@16;) 2 (;@16;) 8 (;@10;) 3 (;@15;) 8 (;@10;)
                                      end
                                      local.get 12
                                      local.get 17
                                      i64.store8
                                      br 7 (;@10;)
                                    end
                                    local.get 12
                                    local.get 17
                                    i64.store16
                                    br 6 (;@10;)
                                  end
                                  local.get 12
                                  local.get 17
                                  i64.store32
                                  br 5 (;@10;)
                                end
                                local.get 12
                                local.get 17
                                i64.store
                                br 4 (;@10;)
                              end
                              local.get 0
                              local.get 16
                              i32.const 0
                              call $__floatscan
                              local.set 18
                              local.get 0
                              i64.load offset=96
                              i64.const 0
                              local.get 0
                              i32.load offset=4
                              local.get 0
                              i32.load offset=40
                              i32.sub
                              i64.extend_i32_s
                              i64.sub
                              i64.eq
                              br_if 11 (;@2;)
                              local.get 12
                              i32.eqz
                              br_if 3 (;@10;)
                              block  ;; label = @14
                                block  ;; label = @15
                                  block  ;; label = @16
                                    local.get 16
                                    br_table 0 (;@16;) 1 (;@15;) 2 (;@14;) 6 (;@10;)
                                  end
                                  local.get 12
                                  local.get 18
                                  f32.demote_f64
                                  f32.store
                                  br 5 (;@10;)
                                end
                                local.get 12
                                local.get 18
                                f64.store
                                br 4 (;@10;)
                              end
                              call $long_double_not_supported.1
                              unreachable
                            end
                            i32.const 1
                            local.set 1
                          end
                          loop  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                local.get 1
                                br_table 0 (;@14;) 1 (;@13;) 1 (;@13;)
                              end
                              local.get 5
                              i32.const 1
                              i32.add
                              local.set 5
                              i32.const 1
                              local.set 1
                              br 1 (;@12;)
                            end
                            block  ;; label = @13
                              block  ;; label = @14
                                local.get 5
                                i32.load8_u
                                local.tee 1
                                i32.const 45
                                i32.eq
                                br_if 0 (;@14;)
                                local.get 1
                                i32.eqz
                                br_if 10 (;@4;)
                                local.get 1
                                i32.const 93
                                i32.ne
                                br_if 1 (;@13;)
                                local.get 5
                                local.set 10
                                br 3 (;@11;)
                              end
                              i32.const 45
                              local.set 1
                              local.get 5
                              i32.load8_u offset=1
                              local.tee 19
                              i32.eqz
                              br_if 0 (;@13;)
                              local.get 19
                              i32.const 93
                              i32.eq
                              br_if 0 (;@13;)
                              local.get 5
                              i32.const 1
                              i32.add
                              local.set 20
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 5
                                  i32.const -1
                                  i32.add
                                  i32.load8_u
                                  local.tee 5
                                  local.get 19
                                  i32.lt_u
                                  br_if 0 (;@15;)
                                  local.get 19
                                  local.set 1
                                  br 1 (;@14;)
                                end
                                loop  ;; label = @15
                                  local.get 7
                                  local.get 5
                                  i32.add
                                  local.get 10
                                  i32.store8
                                  local.get 5
                                  i32.const 1
                                  i32.add
                                  local.tee 5
                                  local.get 20
                                  i32.load8_u
                                  local.tee 1
                                  i32.lt_u
                                  br_if 0 (;@15;)
                                end
                              end
                              local.get 20
                              local.set 5
                            end
                            local.get 1
                            local.get 3
                            i32.const 16
                            i32.add
                            i32.add
                            i32.const 1
                            i32.add
                            local.get 10
                            i32.store8
                            i32.const 0
                            local.set 1
                            br 0 (;@12;)
                          end
                        end
                        i32.const 31
                        local.get 11
                        i32.const 1
                        i32.add
                        local.get 13
                        i32.const 99
                        i32.ne
                        local.tee 19
                        select
                        local.set 20
                        block  ;; label = @11
                          block  ;; label = @12
                            local.get 16
                            i32.const 1
                            i32.ne
                            br_if 0 (;@12;)
                            local.get 12
                            local.set 1
                            block  ;; label = @13
                              local.get 4
                              i32.eqz
                              br_if 0 (;@13;)
                              local.get 20
                              i32.const 2
                              i32.shl
                              call $malloc
                              local.tee 1
                              i32.eqz
                              br_if 8 (;@5;)
                            end
                            local.get 3
                            i64.const 0
                            i64.store offset=288
                            i32.const 0
                            local.set 5
                            block  ;; label = @13
                              loop  ;; label = @14
                                local.get 1
                                local.set 11
                                loop  ;; label = @15
                                  block  ;; label = @16
                                    block  ;; label = @17
                                      local.get 0
                                      i32.load offset=4
                                      local.tee 1
                                      local.get 0
                                      i32.load offset=84
                                      i32.eq
                                      br_if 0 (;@17;)
                                      local.get 0
                                      local.get 1
                                      i32.const 1
                                      i32.add
                                      i32.store offset=4
                                      local.get 1
                                      i32.load8_u
                                      local.set 1
                                      br 1 (;@16;)
                                    end
                                    local.get 0
                                    call $__shgetc
                                    local.set 1
                                  end
                                  local.get 1
                                  local.get 3
                                  i32.const 16
                                  i32.add
                                  i32.add
                                  i32.const 1
                                  i32.add
                                  i32.load8_u
                                  i32.eqz
                                  br_if 2 (;@13;)
                                  local.get 3
                                  local.get 1
                                  i32.store8 offset=11
                                  local.get 3
                                  i32.const 12
                                  i32.add
                                  local.get 3
                                  i32.const 11
                                  i32.add
                                  i32.const 1
                                  local.get 3
                                  i32.const 288
                                  i32.add
                                  call $mbrtowc
                                  local.tee 1
                                  i32.const -2
                                  i32.eq
                                  br_if 0 (;@15;)
                                  local.get 1
                                  i32.const -1
                                  i32.eq
                                  br_if 8 (;@7;)
                                  block  ;; label = @16
                                    local.get 11
                                    i32.eqz
                                    br_if 0 (;@16;)
                                    local.get 11
                                    local.get 5
                                    i32.const 2
                                    i32.shl
                                    i32.add
                                    local.get 3
                                    i32.load offset=12
                                    i32.store
                                    local.get 5
                                    i32.const 1
                                    i32.add
                                    local.set 5
                                  end
                                  local.get 4
                                  i32.eqz
                                  br_if 0 (;@15;)
                                  local.get 5
                                  local.get 20
                                  i32.ne
                                  br_if 0 (;@15;)
                                end
                                local.get 11
                                local.get 20
                                i32.const 1
                                i32.shl
                                i32.const 1
                                i32.or
                                local.tee 20
                                i32.const 2
                                i32.shl
                                call $realloc
                                local.tee 1
                                br_if 0 (;@14;)
                              end
                              i32.const 0
                              local.set 14
                              local.get 11
                              local.set 15
                              i32.const 1
                              local.set 4
                              br 9 (;@4;)
                            end
                            i32.const 0
                            local.set 14
                            local.get 11
                            local.set 15
                            local.get 3
                            i32.const 288
                            i32.add
                            call $mbsinit
                            br_if 1 (;@11;)
                            br 6 (;@6;)
                          end
                          block  ;; label = @12
                            local.get 4
                            i32.eqz
                            br_if 0 (;@12;)
                            local.get 20
                            call $malloc
                            local.tee 1
                            i32.eqz
                            br_if 7 (;@5;)
                            i32.const 0
                            local.set 5
                            loop  ;; label = @13
                              local.get 1
                              local.set 11
                              loop  ;; label = @14
                                block  ;; label = @15
                                  block  ;; label = @16
                                    local.get 0
                                    i32.load offset=4
                                    local.tee 1
                                    local.get 0
                                    i32.load offset=84
                                    i32.eq
                                    br_if 0 (;@16;)
                                    local.get 0
                                    local.get 1
                                    i32.const 1
                                    i32.add
                                    i32.store offset=4
                                    local.get 1
                                    i32.load8_u
                                    local.set 1
                                    br 1 (;@15;)
                                  end
                                  local.get 0
                                  call $__shgetc
                                  local.set 1
                                end
                                block  ;; label = @15
                                  local.get 1
                                  local.get 3
                                  i32.const 16
                                  i32.add
                                  i32.add
                                  i32.const 1
                                  i32.add
                                  i32.load8_u
                                  br_if 0 (;@15;)
                                  i32.const 0
                                  local.set 15
                                  local.get 11
                                  local.set 14
                                  br 4 (;@11;)
                                end
                                local.get 11
                                local.get 5
                                i32.add
                                local.get 1
                                i32.store8
                                local.get 20
                                local.get 5
                                i32.const 1
                                i32.add
                                local.tee 5
                                i32.ne
                                br_if 0 (;@14;)
                              end
                              local.get 11
                              local.get 20
                              i32.const 1
                              i32.shl
                              i32.const 1
                              i32.or
                              local.tee 20
                              call $realloc
                              local.tee 1
                              br_if 0 (;@13;)
                            end
                            i32.const 0
                            local.set 15
                            local.get 11
                            local.set 14
                            i32.const 1
                            local.set 4
                            br 8 (;@4;)
                          end
                          block  ;; label = @12
                            local.get 12
                            i32.eqz
                            br_if 0 (;@12;)
                            i32.const 0
                            local.set 5
                            loop  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 0
                                  i32.load offset=4
                                  local.tee 1
                                  local.get 0
                                  i32.load offset=84
                                  i32.eq
                                  br_if 0 (;@15;)
                                  local.get 0
                                  local.get 1
                                  i32.const 1
                                  i32.add
                                  i32.store offset=4
                                  local.get 1
                                  i32.load8_u
                                  local.set 1
                                  br 1 (;@14;)
                                end
                                local.get 0
                                call $__shgetc
                                local.set 1
                              end
                              block  ;; label = @14
                                local.get 1
                                local.get 3
                                i32.const 16
                                i32.add
                                i32.add
                                i32.const 1
                                i32.add
                                i32.load8_u
                                br_if 0 (;@14;)
                                i32.const 0
                                local.set 15
                                local.get 12
                                local.set 11
                                local.get 12
                                local.set 14
                                br 3 (;@11;)
                              end
                              local.get 12
                              local.get 5
                              i32.add
                              local.get 1
                              i32.store8
                              local.get 5
                              i32.const 1
                              i32.add
                              local.set 5
                              br 0 (;@13;)
                            end
                          end
                          loop  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                local.get 0
                                i32.load offset=4
                                local.tee 5
                                local.get 0
                                i32.load offset=84
                                i32.eq
                                br_if 0 (;@14;)
                                local.get 0
                                local.get 5
                                i32.const 1
                                i32.add
                                i32.store offset=4
                                local.get 5
                                i32.load8_u
                                local.set 5
                                br 1 (;@13;)
                              end
                              local.get 0
                              call $__shgetc
                              local.set 5
                            end
                            local.get 5
                            local.get 3
                            i32.const 16
                            i32.add
                            i32.add
                            i32.const 1
                            i32.add
                            i32.load8_u
                            br_if 0 (;@12;)
                          end
                          i32.const 0
                          local.set 11
                          i32.const 0
                          local.set 14
                          i32.const 0
                          local.set 15
                          i32.const 0
                          local.set 5
                        end
                        local.get 0
                        i32.load offset=4
                        local.set 1
                        block  ;; label = @11
                          local.get 0
                          i64.load offset=88
                          i64.const 0
                          i64.lt_s
                          br_if 0 (;@11;)
                          local.get 0
                          local.get 1
                          i32.const -1
                          i32.add
                          local.tee 1
                          i32.store offset=4
                        end
                        local.get 0
                        i64.load offset=96
                        local.get 1
                        local.get 0
                        i32.load offset=40
                        i32.sub
                        i64.extend_i32_s
                        i64.add
                        local.tee 21
                        i64.eqz
                        br_if 8 (;@2;)
                        local.get 19
                        local.get 21
                        local.get 17
                        i64.eq
                        i32.or
                        i32.eqz
                        br_if 8 (;@2;)
                        block  ;; label = @11
                          local.get 4
                          i32.eqz
                          br_if 0 (;@11;)
                          local.get 12
                          local.get 11
                          i32.store
                        end
                        local.get 13
                        i32.const 99
                        i32.eq
                        br_if 0 (;@10;)
                        block  ;; label = @11
                          local.get 15
                          i32.eqz
                          br_if 0 (;@11;)
                          local.get 15
                          local.get 5
                          i32.const 2
                          i32.shl
                          i32.add
                          i32.const 0
                          i32.store
                        end
                        block  ;; label = @11
                          local.get 14
                          br_if 0 (;@11;)
                          i32.const 0
                          local.set 14
                          br 1 (;@10;)
                        end
                        local.get 14
                        local.get 5
                        i32.add
                        i32.const 0
                        i32.store8
                      end
                      local.get 0
                      i64.load offset=96
                      local.get 9
                      i64.add
                      local.get 0
                      i32.load offset=4
                      local.get 0
                      i32.load offset=40
                      i32.sub
                      i64.extend_i32_s
                      i64.add
                      local.set 9
                      local.get 6
                      local.get 12
                      i32.const 0
                      i32.ne
                      i32.add
                      local.set 6
                    end
                    local.get 10
                    i32.const 1
                    i32.add
                    local.set 1
                    local.get 10
                    i32.load8_u offset=1
                    local.tee 5
                    br_if 0 (;@8;)
                    br 7 (;@1;)
                  end
                end
                i32.const 0
                local.set 14
              end
              local.get 11
              local.set 15
              br 1 (;@4;)
            end
            i32.const 1
            local.set 4
            i32.const 0
            local.set 14
            i32.const 0
            local.set 15
          end
          local.get 6
          br_if 1 (;@2;)
        end
        i32.const -1
        local.set 6
      end
      local.get 4
      i32.eqz
      br_if 0 (;@1;)
      local.get 14
      call $free
      local.get 15
      call $free
    end
    local.get 3
    i32.const 304
    i32.add
    global.set $__stack_pointer
    local.get 6)
  (func $long_double_not_supported.1 (type 1)
    i32.const 1368
    i32.const 4392
    call $fputs
    drop
    call $abort
    unreachable)
  (func $vscanf (type 4) (param i32 i32) (result i32)
    i32.const 4512
    local.get 0
    local.get 1
    call $vfscanf)
  (func $memchr (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32)
    local.get 2
    i32.const 0
    i32.ne
    local.set 3
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.const 3
            i32.and
            i32.eqz
            br_if 0 (;@4;)
            local.get 2
            i32.eqz
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 0
              i32.load8_u
              local.get 1
              i32.const 255
              i32.and
              i32.ne
              br_if 0 (;@5;)
              local.get 0
              local.set 4
              local.get 2
              local.set 5
              br 3 (;@2;)
            end
            local.get 2
            i32.const -1
            i32.add
            local.tee 5
            i32.const 0
            i32.ne
            local.set 3
            local.get 0
            i32.const 1
            i32.add
            local.tee 4
            i32.const 3
            i32.and
            i32.eqz
            br_if 1 (;@3;)
            local.get 5
            i32.eqz
            br_if 1 (;@3;)
            local.get 4
            i32.load8_u
            local.get 1
            i32.const 255
            i32.and
            i32.eq
            br_if 2 (;@2;)
            local.get 2
            i32.const -2
            i32.add
            local.tee 5
            i32.const 0
            i32.ne
            local.set 3
            local.get 0
            i32.const 2
            i32.add
            local.tee 4
            i32.const 3
            i32.and
            i32.eqz
            br_if 1 (;@3;)
            local.get 5
            i32.eqz
            br_if 1 (;@3;)
            local.get 4
            i32.load8_u
            local.get 1
            i32.const 255
            i32.and
            i32.eq
            br_if 2 (;@2;)
            local.get 2
            i32.const -3
            i32.add
            local.tee 5
            i32.const 0
            i32.ne
            local.set 3
            local.get 0
            i32.const 3
            i32.add
            local.tee 4
            i32.const 3
            i32.and
            i32.eqz
            br_if 1 (;@3;)
            local.get 5
            i32.eqz
            br_if 1 (;@3;)
            local.get 4
            i32.load8_u
            local.get 1
            i32.const 255
            i32.and
            i32.eq
            br_if 2 (;@2;)
            local.get 0
            i32.const 4
            i32.add
            local.set 4
            local.get 2
            i32.const -4
            i32.add
            local.tee 5
            i32.const 0
            i32.ne
            local.set 3
            br 1 (;@3;)
          end
          local.get 2
          local.set 5
          local.get 0
          local.set 4
        end
        local.get 3
        i32.eqz
        br_if 1 (;@1;)
        block  ;; label = @3
          local.get 4
          i32.load8_u
          local.get 1
          i32.const 255
          i32.and
          i32.eq
          br_if 0 (;@3;)
          local.get 5
          i32.const 4
          i32.lt_u
          br_if 0 (;@3;)
          local.get 1
          i32.const 255
          i32.and
          i32.const 16843009
          i32.mul
          local.set 0
          loop  ;; label = @4
            local.get 4
            i32.load
            local.get 0
            i32.xor
            local.tee 2
            i32.const -1
            i32.xor
            local.get 2
            i32.const -16843009
            i32.add
            i32.and
            i32.const -2139062144
            i32.and
            br_if 2 (;@2;)
            local.get 4
            i32.const 4
            i32.add
            local.set 4
            local.get 5
            i32.const -4
            i32.add
            local.tee 5
            i32.const 3
            i32.gt_u
            br_if 0 (;@4;)
          end
        end
        local.get 5
        i32.eqz
        br_if 1 (;@1;)
      end
      local.get 1
      i32.const 255
      i32.and
      local.set 2
      loop  ;; label = @2
        block  ;; label = @3
          local.get 4
          i32.load8_u
          local.get 2
          i32.ne
          br_if 0 (;@3;)
          local.get 4
          return
        end
        local.get 4
        i32.const 1
        i32.add
        local.set 4
        local.get 5
        i32.const -1
        i32.add
        local.tee 5
        br_if 0 (;@2;)
      end
    end
    i32.const 0)
  (func $memcmp (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32)
    i32.const 0
    local.set 3
    block  ;; label = @1
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        loop  ;; label = @3
          local.get 0
          i32.load8_u
          local.tee 4
          local.get 1
          i32.load8_u
          local.tee 5
          i32.ne
          br_if 1 (;@2;)
          local.get 1
          i32.const 1
          i32.add
          local.set 1
          local.get 0
          i32.const 1
          i32.add
          local.set 0
          local.get 2
          i32.const -1
          i32.add
          local.tee 2
          br_if 0 (;@3;)
          br 2 (;@1;)
        end
      end
      local.get 4
      local.get 5
      i32.sub
      local.set 3
    end
    local.get 3)
  (func $memcpy (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const 32
          i32.gt_u
          br_if 0 (;@3;)
          local.get 1
          i32.const 3
          i32.and
          i32.eqz
          br_if 1 (;@2;)
          local.get 2
          i32.eqz
          br_if 1 (;@2;)
          local.get 0
          local.get 1
          i32.load8_u
          i32.store8
          local.get 2
          i32.const -1
          i32.add
          local.set 3
          local.get 0
          i32.const 1
          i32.add
          local.set 4
          local.get 1
          i32.const 1
          i32.add
          local.tee 5
          i32.const 3
          i32.and
          i32.eqz
          br_if 2 (;@1;)
          local.get 3
          i32.eqz
          br_if 2 (;@1;)
          local.get 0
          local.get 1
          i32.load8_u offset=1
          i32.store8 offset=1
          local.get 2
          i32.const -2
          i32.add
          local.set 3
          local.get 0
          i32.const 2
          i32.add
          local.set 4
          local.get 1
          i32.const 2
          i32.add
          local.tee 5
          i32.const 3
          i32.and
          i32.eqz
          br_if 2 (;@1;)
          local.get 3
          i32.eqz
          br_if 2 (;@1;)
          local.get 0
          local.get 1
          i32.load8_u offset=2
          i32.store8 offset=2
          local.get 2
          i32.const -3
          i32.add
          local.set 3
          local.get 0
          i32.const 3
          i32.add
          local.set 4
          local.get 1
          i32.const 3
          i32.add
          local.tee 5
          i32.const 3
          i32.and
          i32.eqz
          br_if 2 (;@1;)
          local.get 3
          i32.eqz
          br_if 2 (;@1;)
          local.get 0
          local.get 1
          i32.load8_u offset=3
          i32.store8 offset=3
          local.get 2
          i32.const -4
          i32.add
          local.set 3
          local.get 0
          i32.const 4
          i32.add
          local.set 4
          local.get 1
          i32.const 4
          i32.add
          local.set 5
          br 2 (;@1;)
        end
        local.get 0
        local.get 1
        local.get 2
        memory.copy
        local.get 0
        return
      end
      local.get 2
      local.set 3
      local.get 0
      local.set 4
      local.get 1
      local.set 5
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 4
        i32.const 3
        i32.and
        local.tee 2
        br_if 0 (;@2;)
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            i32.const 16
            i32.ge_u
            br_if 0 (;@4;)
            local.get 3
            local.set 2
            br 1 (;@3;)
          end
          block  ;; label = @4
            local.get 3
            i32.const -16
            i32.add
            local.tee 2
            i32.const 16
            i32.and
            br_if 0 (;@4;)
            local.get 4
            local.get 5
            i64.load align=4
            i64.store align=4
            local.get 4
            local.get 5
            i64.load offset=8 align=4
            i64.store offset=8 align=4
            local.get 4
            i32.const 16
            i32.add
            local.set 4
            local.get 5
            i32.const 16
            i32.add
            local.set 5
            local.get 2
            local.set 3
          end
          local.get 2
          i32.const 16
          i32.lt_u
          br_if 0 (;@3;)
          local.get 3
          local.set 2
          loop  ;; label = @4
            local.get 4
            local.get 5
            i64.load align=4
            i64.store align=4
            local.get 4
            local.get 5
            i64.load offset=8 align=4
            i64.store offset=8 align=4
            local.get 4
            local.get 5
            i64.load offset=16 align=4
            i64.store offset=16 align=4
            local.get 4
            local.get 5
            i64.load offset=24 align=4
            i64.store offset=24 align=4
            local.get 4
            i32.const 32
            i32.add
            local.set 4
            local.get 5
            i32.const 32
            i32.add
            local.set 5
            local.get 2
            i32.const -32
            i32.add
            local.tee 2
            i32.const 15
            i32.gt_u
            br_if 0 (;@4;)
          end
        end
        block  ;; label = @3
          local.get 2
          i32.const 8
          i32.lt_u
          br_if 0 (;@3;)
          local.get 4
          local.get 5
          i64.load align=4
          i64.store align=4
          local.get 5
          i32.const 8
          i32.add
          local.set 5
          local.get 4
          i32.const 8
          i32.add
          local.set 4
        end
        block  ;; label = @3
          local.get 2
          i32.const 4
          i32.and
          i32.eqz
          br_if 0 (;@3;)
          local.get 4
          local.get 5
          i32.load
          i32.store
          local.get 5
          i32.const 4
          i32.add
          local.set 5
          local.get 4
          i32.const 4
          i32.add
          local.set 4
        end
        block  ;; label = @3
          local.get 2
          i32.const 2
          i32.and
          i32.eqz
          br_if 0 (;@3;)
          local.get 4
          local.get 5
          i32.load16_u align=1
          i32.store16 align=1
          local.get 4
          i32.const 2
          i32.add
          local.set 4
          local.get 5
          i32.const 2
          i32.add
          local.set 5
        end
        local.get 2
        i32.const 1
        i32.and
        i32.eqz
        br_if 1 (;@1;)
        local.get 4
        local.get 5
        i32.load8_u
        i32.store8
        local.get 0
        return
      end
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 3
                i32.const 32
                i32.lt_u
                br_if 0 (;@6;)
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 2
                    i32.const -1
                    i32.add
                    br_table 3 (;@5;) 0 (;@8;) 1 (;@7;) 7 (;@1;)
                  end
                  local.get 4
                  local.get 5
                  i32.load
                  i32.store16 align=1
                  local.get 4
                  local.get 5
                  i32.const 2
                  i32.add
                  i32.load align=2
                  i32.store offset=2
                  local.get 4
                  local.get 5
                  i32.const 6
                  i32.add
                  i64.load align=2
                  i64.store offset=6 align=4
                  local.get 4
                  i32.const 18
                  i32.add
                  local.set 2
                  local.get 5
                  i32.const 18
                  i32.add
                  local.set 1
                  i32.const 14
                  local.set 6
                  local.get 5
                  i32.const 14
                  i32.add
                  i32.load align=2
                  local.set 5
                  i32.const 14
                  local.set 3
                  br 3 (;@4;)
                end
                local.get 4
                local.get 5
                i32.load
                i32.store8
                local.get 4
                local.get 5
                i32.const 1
                i32.add
                i32.load align=1
                i32.store offset=1
                local.get 4
                local.get 5
                i32.const 5
                i32.add
                i64.load align=1
                i64.store offset=5 align=4
                local.get 4
                i32.const 17
                i32.add
                local.set 2
                local.get 5
                i32.const 17
                i32.add
                local.set 1
                i32.const 13
                local.set 6
                local.get 5
                i32.const 13
                i32.add
                i32.load align=1
                local.set 5
                i32.const 15
                local.set 3
                br 2 (;@4;)
              end
              block  ;; label = @6
                block  ;; label = @7
                  local.get 3
                  i32.const 16
                  i32.ge_u
                  br_if 0 (;@7;)
                  local.get 4
                  local.set 2
                  local.get 5
                  local.set 1
                  br 1 (;@6;)
                end
                local.get 4
                local.get 5
                i32.load8_u
                i32.store8
                local.get 4
                local.get 5
                i32.load offset=1 align=1
                i32.store offset=1 align=1
                local.get 4
                local.get 5
                i64.load offset=5 align=1
                i64.store offset=5 align=1
                local.get 4
                local.get 5
                i32.load16_u offset=13 align=1
                i32.store16 offset=13 align=1
                local.get 4
                local.get 5
                i32.load8_u offset=15
                i32.store8 offset=15
                local.get 4
                i32.const 16
                i32.add
                local.set 2
                local.get 5
                i32.const 16
                i32.add
                local.set 1
              end
              local.get 3
              i32.const 8
              i32.and
              br_if 2 (;@3;)
              br 3 (;@2;)
            end
            local.get 4
            local.get 5
            i32.load
            local.tee 2
            i32.store8
            local.get 4
            local.get 2
            i32.const 16
            i32.shr_u
            i32.store8 offset=2
            local.get 4
            local.get 2
            i32.const 8
            i32.shr_u
            i32.store8 offset=1
            local.get 4
            local.get 5
            i32.const 3
            i32.add
            i32.load align=1
            i32.store offset=3
            local.get 4
            local.get 5
            i32.const 7
            i32.add
            i64.load align=1
            i64.store offset=7 align=4
            local.get 4
            i32.const 19
            i32.add
            local.set 2
            local.get 5
            i32.const 19
            i32.add
            local.set 1
            i32.const 15
            local.set 6
            local.get 5
            i32.const 15
            i32.add
            i32.load align=1
            local.set 5
            i32.const 13
            local.set 3
          end
          local.get 4
          local.get 6
          i32.add
          local.get 5
          i32.store
        end
        local.get 2
        local.get 1
        i64.load align=1
        i64.store align=1
        local.get 2
        i32.const 8
        i32.add
        local.set 2
        local.get 1
        i32.const 8
        i32.add
        local.set 1
      end
      block  ;; label = @2
        local.get 3
        i32.const 4
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        local.get 1
        i32.load align=1
        i32.store align=1
        local.get 2
        i32.const 4
        i32.add
        local.set 2
        local.get 1
        i32.const 4
        i32.add
        local.set 1
      end
      block  ;; label = @2
        local.get 3
        i32.const 2
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        local.get 1
        i32.load16_u align=1
        i32.store16 align=1
        local.get 2
        i32.const 2
        i32.add
        local.set 2
        local.get 1
        i32.const 2
        i32.add
        local.set 1
      end
      local.get 3
      i32.const 1
      i32.and
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      local.get 1
      i32.load8_u
      i32.store8
    end
    local.get 0)
  (func $memset (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i64)
    block  ;; label = @1
      local.get 2
      i32.const 33
      i32.lt_u
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      local.get 2
      memory.fill
      local.get 0
      return
    end
    block  ;; label = @1
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      i32.store8
      local.get 2
      local.get 0
      i32.add
      local.tee 3
      i32.const -1
      i32.add
      local.get 1
      i32.store8
      local.get 2
      i32.const 3
      i32.lt_u
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      i32.store8 offset=2
      local.get 0
      local.get 1
      i32.store8 offset=1
      local.get 3
      i32.const -3
      i32.add
      local.get 1
      i32.store8
      local.get 3
      i32.const -2
      i32.add
      local.get 1
      i32.store8
      local.get 2
      i32.const 7
      i32.lt_u
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      i32.store8 offset=3
      local.get 3
      i32.const -4
      i32.add
      local.get 1
      i32.store8
      local.get 2
      i32.const 9
      i32.lt_u
      br_if 0 (;@1;)
      local.get 0
      i32.const 0
      local.get 0
      i32.sub
      i32.const 3
      i32.and
      local.tee 4
      i32.add
      local.tee 5
      local.get 1
      i32.const 255
      i32.and
      i32.const 16843009
      i32.mul
      local.tee 3
      i32.store
      local.get 5
      local.get 2
      local.get 4
      i32.sub
      i32.const -4
      i32.and
      local.tee 1
      i32.add
      local.tee 2
      i32.const -4
      i32.add
      local.get 3
      i32.store
      local.get 1
      i32.const 9
      i32.lt_u
      br_if 0 (;@1;)
      local.get 5
      local.get 3
      i32.store offset=8
      local.get 5
      local.get 3
      i32.store offset=4
      local.get 2
      i32.const -8
      i32.add
      local.get 3
      i32.store
      local.get 2
      i32.const -12
      i32.add
      local.get 3
      i32.store
      local.get 1
      i32.const 25
      i32.lt_u
      br_if 0 (;@1;)
      local.get 5
      local.get 3
      i32.store offset=24
      local.get 5
      local.get 3
      i32.store offset=20
      local.get 5
      local.get 3
      i32.store offset=16
      local.get 5
      local.get 3
      i32.store offset=12
      local.get 2
      i32.const -16
      i32.add
      local.get 3
      i32.store
      local.get 2
      i32.const -20
      i32.add
      local.get 3
      i32.store
      local.get 2
      i32.const -24
      i32.add
      local.get 3
      i32.store
      local.get 2
      i32.const -28
      i32.add
      local.get 3
      i32.store
      local.get 1
      local.get 5
      i32.const 4
      i32.and
      i32.const 24
      i32.or
      local.tee 2
      i32.sub
      local.tee 1
      i32.const 32
      i32.lt_u
      br_if 0 (;@1;)
      local.get 3
      i64.extend_i32_u
      i64.const 4294967297
      i64.mul
      local.set 6
      local.get 5
      local.get 2
      i32.add
      local.set 2
      loop  ;; label = @2
        local.get 2
        local.get 6
        i64.store offset=24
        local.get 2
        local.get 6
        i64.store offset=16
        local.get 2
        local.get 6
        i64.store offset=8
        local.get 2
        local.get 6
        i64.store
        local.get 2
        i32.const 32
        i32.add
        local.set 2
        local.get 1
        i32.const -32
        i32.add
        local.tee 1
        i32.const 31
        i32.gt_u
        br_if 0 (;@2;)
      end
    end
    local.get 0)
  (func $strchr (type 4) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call $__strchrnul
    local.tee 0
    i32.const 0
    local.get 0
    i32.load8_u
    local.get 1
    i32.const 255
    i32.and
    i32.eq
    select)
  (func $__strchrnul (type 4) (param i32 i32) (result i32)
    (local i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.const 255
            i32.and
            local.tee 2
            i32.eqz
            br_if 0 (;@4;)
            local.get 0
            i32.const 3
            i32.and
            i32.eqz
            br_if 2 (;@2;)
            block  ;; label = @5
              local.get 0
              i32.load8_u
              local.tee 3
              br_if 0 (;@5;)
              local.get 0
              return
            end
            local.get 3
            local.get 1
            i32.const 255
            i32.and
            i32.ne
            br_if 1 (;@3;)
            local.get 0
            return
          end
          local.get 0
          local.get 0
          call $strlen
          i32.add
          return
        end
        block  ;; label = @3
          local.get 0
          i32.const 1
          i32.add
          local.tee 3
          i32.const 3
          i32.and
          br_if 0 (;@3;)
          local.get 3
          local.set 0
          br 1 (;@2;)
        end
        local.get 3
        i32.load8_u
        local.tee 4
        i32.eqz
        br_if 1 (;@1;)
        local.get 4
        local.get 1
        i32.const 255
        i32.and
        i32.eq
        br_if 1 (;@1;)
        block  ;; label = @3
          local.get 0
          i32.const 2
          i32.add
          local.tee 3
          i32.const 3
          i32.and
          br_if 0 (;@3;)
          local.get 3
          local.set 0
          br 1 (;@2;)
        end
        local.get 3
        i32.load8_u
        local.tee 4
        i32.eqz
        br_if 1 (;@1;)
        local.get 4
        local.get 1
        i32.const 255
        i32.and
        i32.eq
        br_if 1 (;@1;)
        block  ;; label = @3
          local.get 0
          i32.const 3
          i32.add
          local.tee 3
          i32.const 3
          i32.and
          br_if 0 (;@3;)
          local.get 3
          local.set 0
          br 1 (;@2;)
        end
        local.get 3
        i32.load8_u
        local.tee 4
        i32.eqz
        br_if 1 (;@1;)
        local.get 4
        local.get 1
        i32.const 255
        i32.and
        i32.eq
        br_if 1 (;@1;)
        local.get 0
        i32.const 4
        i32.add
        local.set 0
      end
      block  ;; label = @2
        local.get 0
        i32.load
        local.tee 3
        i32.const -1
        i32.xor
        local.get 3
        i32.const -16843009
        i32.add
        i32.and
        i32.const -2139062144
        i32.and
        br_if 0 (;@2;)
        local.get 2
        i32.const 16843009
        i32.mul
        local.set 2
        loop  ;; label = @3
          local.get 3
          local.get 2
          i32.xor
          local.tee 3
          i32.const -1
          i32.xor
          local.get 3
          i32.const -16843009
          i32.add
          i32.and
          i32.const -2139062144
          i32.and
          br_if 1 (;@2;)
          local.get 0
          i32.const 4
          i32.add
          local.tee 0
          i32.load
          local.tee 3
          i32.const -1
          i32.xor
          local.get 3
          i32.const -16843009
          i32.add
          i32.and
          i32.const -2139062144
          i32.and
          i32.eqz
          br_if 0 (;@3;)
        end
      end
      local.get 0
      i32.const -1
      i32.add
      local.set 3
      loop  ;; label = @2
        local.get 3
        i32.const 1
        i32.add
        local.tee 3
        i32.load8_u
        local.tee 0
        i32.eqz
        br_if 1 (;@1;)
        local.get 0
        local.get 1
        i32.const 255
        i32.and
        i32.ne
        br_if 0 (;@2;)
      end
    end
    local.get 3)
  (func $strdup (type 0) (param i32) (result i32)
    (local i32 i32)
    block  ;; label = @1
      local.get 0
      call $strlen
      i32.const 1
      i32.add
      local.tee 1
      call $malloc
      local.tee 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      local.get 0
      local.get 1
      call $memcpy
      drop
    end
    local.get 2)
  (func $strlen (type 0) (param i32) (result i32)
    (local i32 i32)
    local.get 0
    local.set 1
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 3
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        local.set 1
        local.get 0
        i32.load8_u
        i32.eqz
        br_if 1 (;@1;)
        local.get 0
        i32.const 1
        i32.add
        local.tee 1
        i32.const 3
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        i32.load8_u
        i32.eqz
        br_if 1 (;@1;)
        local.get 0
        i32.const 2
        i32.add
        local.tee 1
        i32.const 3
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        i32.load8_u
        i32.eqz
        br_if 1 (;@1;)
        local.get 0
        i32.const 3
        i32.add
        local.tee 1
        i32.const 3
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        i32.load8_u
        i32.eqz
        br_if 1 (;@1;)
        local.get 0
        i32.const 4
        i32.add
        local.set 1
      end
      local.get 1
      i32.const -5
      i32.add
      local.set 1
      loop  ;; label = @2
        local.get 1
        i32.const 5
        i32.add
        local.set 2
        local.get 1
        i32.const 4
        i32.add
        local.set 1
        local.get 2
        i32.load
        local.tee 2
        i32.const -1
        i32.xor
        local.get 2
        i32.const -16843009
        i32.add
        i32.and
        i32.const -2139062144
        i32.and
        i32.eqz
        br_if 0 (;@2;)
      end
      loop  ;; label = @2
        local.get 1
        i32.const 1
        i32.add
        local.tee 1
        i32.load8_u
        br_if 0 (;@2;)
      end
    end
    local.get 1
    local.get 0
    i32.sub)
  (func $strnlen (type 4) (param i32 i32) (result i32)
    (local i32)
    local.get 0
    i32.const 0
    local.get 1
    call $memchr
    local.tee 2
    local.get 0
    i32.sub
    local.get 1
    local.get 2
    select)
  (func $__multi3 (type 22) (param i32 i64 i64 i64 i64)
    (local i64)
    local.get 0
    local.get 4
    local.get 1
    i64.mul
    local.get 2
    local.get 3
    i64.mul
    i64.add
    local.get 3
    i64.const 32
    i64.shr_u
    local.tee 2
    local.get 1
    i64.const 32
    i64.shr_u
    local.tee 4
    i64.mul
    i64.add
    local.get 3
    i64.const 4294967295
    i64.and
    local.tee 3
    local.get 1
    i64.const 4294967295
    i64.and
    local.tee 1
    i64.mul
    local.tee 5
    i64.const 32
    i64.shr_u
    local.get 3
    local.get 4
    i64.mul
    i64.add
    local.tee 3
    i64.const 32
    i64.shr_u
    i64.add
    local.get 3
    i64.const 4294967295
    i64.and
    local.get 2
    local.get 1
    i64.mul
    i64.add
    local.tee 1
    i64.const 32
    i64.shr_u
    i64.add
    i64.store offset=8
    local.get 0
    local.get 1
    i64.const 32
    i64.shl
    local.get 5
    i64.const 4294967295
    i64.and
    i64.or
    i64.store)
  (table (;0;) 9 9 funcref)
  (memory (;0;) 2)
  (global $__stack_pointer (mut i32) (i32.const 72816))
  (export "memory" (memory 0))
  (export "_start" (func $_start))
  (elem (;0;) (i32.const 1) func $basic $win $diff $__stdio_seek $__stdio_write $__stdio_read $__stdio_close $__stdout_write)
  (data $.rodata (i32.const 1024) "-+   0X0x\00-0X+0X 0X-0x+0x 0x\00flag.txt\00%s\00r\00nan\00inf\00%4d\00%d\00rwa\00NAN\00INF\00Give me a number:\00Tell me your name:\00.\00(null)\00%s\0a\00\0a %10s - %d is gone\0a\00Here is the result: %d\0a\00Hello, what do you want to do?\0a\00Sorry, due to a technical limitation, I can only fix your first letter. What value do you want there?\0a\00Sorry not today.\0a\002 - Do some math for me.\0a\00Support for formatting long double values is currently disabled.\0aTo enable it, add -lc-printscan-long-double to the link command.\0a\00Bye!\0a\001 - I made a typo in my name!\0a\003 - Tell me a joke!\0a\00\00\00\00\b0\10\00\00Success\00Illegal byte sequence\00Domain error\00Result not representable\00Not a tty\00Permission denied\00Operation not permitted\00No such file or directory\00No such process\00File exists\00Value too large for data type\00No space left on device\00Out of memory\00Resource busy\00Interrupted system call\00Resource temporarily unavailable\00Invalid seek\00Cross-device link\00Read-only file system\00Directory not empty\00Connection reset by peer\00Operation timed out\00Connection refused\00Host is unreachable\00Address in use\00Broken pipe\00I/O error\00No such device or address\00No such device\00Not a directory\00Is a directory\00Text file busy\00Exec format error\00Invalid argument\00Argument list too long\00Symbolic link loop\00Filename too long\00Too many open files in system\00No file descriptors available\00Bad file descriptor\00No child process\00Bad address\00File too large\00Too many links\00No locks available\00Resource deadlock would occur\00State not recoverable\00Previous owner died\00Operation canceled\00Function not implemented\00No message of desired type\00Identifier removed\00Link has been severed\00Protocol error\00Bad message\00Not a socket\00Destination address required\00Message too large\00Protocol wrong type for socket\00Protocol not available\00Protocol not supported\00Not supported\00Address family not supported by protocol\00Address not available\00Network is down\00Network unreachable\00Connection reset by network\00Connection aborted\00No buffer space available\00Socket is connected\00Socket not connected\00Operation already in progress\00Operation in progress\00Stale file handle\00Quota exceeded\00Multihop attempted\00Capabilities insufficient\00\00\00\00\00\00\00u\02N\00\d6\01\e2\04\b9\04\18\01\8e\05\ed\02\16\04\f2\00\97\03\01\038\05\af\01\82\01O\03/\04\1e\00\d4\05\a2\00\12\03\1e\03\c2\01\de\03\08\00\ac\05\00\01d\02\f1\01e\054\02\8c\02\cf\02-\03L\04\e3\05\9f\02\f8\04\1c\05\08\05\b1\02K\05\15\02x\00R\02<\03\f1\03\e4\00\c3\03}\04\cc\00\aa\03y\05$\02n\01m\03\22\04\ab\04D\00\fb\01\ae\00\83\03`\00\e5\01\07\04\94\04^\04+\00X\019\01\92\00\c2\05\9b\01C\02F\01\f6\05\00\00\00\00\00\00\19\00\0a\00\19\19\19\00\00\00\00\05\00\00\00\00\00\00\09\00\00\00\00\0b\00\00\00\00\00\00\00\00\19\00\11\0a\19\19\19\03\0a\07\00\01\1b\09\0b\18\00\00\09\06\0b\00\00\0b\00\06\19\00\00\00\19\19\19\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\0e\00\00\00\00\00\00\00\00\19\00\0a\0d\19\19\19\00\0d\00\00\02\00\09\0e\00\00\00\09\00\0e\00\00\0e\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\0c\00\00\00\00\00\00\00\00\00\00\00\13\00\00\00\00\13\00\00\00\00\09\0c\00\00\00\00\00\0c\00\00\0c\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\10\00\00\00\00\00\00\00\00\00\00\00\0f\00\00\00\04\0f\00\00\00\00\09\10\00\00\00\00\00\10\00\00\10\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\12\00\00\00\00\00\00\00\00\00\00\00\11\00\00\00\00\11\00\00\00\00\09\12\00\00\00\00\00\12\00\00\12\00\00\1a\00\00\00\1a\1a\1a\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\1a\00\00\00\1a\1a\1a\00\00\00\00\00\00\09\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\14\00\00\00\00\00\00\00\00\00\00\00\17\00\00\00\00\17\00\00\00\00\09\14\00\00\00\00\00\14\00\00\14\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\16\00\00\00\00\00\00\00\00\00\00\00\15\00\00\00\00\15\00\00\00\00\09\16\00\00\00\00\00\16\00\00\16\00\000123456789ABCDEF\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\00\01\02\03\04\05\06\07\08\09\ff\ff\ff\ff\ff\ff\ff\0a\0b\0c\0d\0e\0f\10\11\12\13\14\15\16\17\18\19\1a\1b\1c\1d\1e\1f !\22#\ff\ff\ff\ff\ff\ff\0a\0b\0c\0d\0e\0f\10\11\12\13\14\15\16\17\18\19\1a\1b\1c\1d\1e\1f !\22#\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\ff\00\01\02\04\07\03\06\05\00\00\00\00\00\00\00\0a\00\00\00d\00\00\00\e8\03\00\00\10'\00\00\a0\86\01\00@B\0f\00\80\96\98\00\00\e1\f5\05\02\00\00\c0\03\00\00\c0\04\00\00\c0\05\00\00\c0\06\00\00\c0\07\00\00\c0\08\00\00\c0\09\00\00\c0\0a\00\00\c0\0b\00\00\c0\0c\00\00\c0\0d\00\00\c0\0e\00\00\c0\0f\00\00\c0\10\00\00\c0\11\00\00\c0\12\00\00\c0\13\00\00\c0\14\00\00\c0\15\00\00\c0\16\00\00\c0\17\00\00\c0\18\00\00\c0\19\00\00\c0\1a\00\00\c0\1b\00\00\c0\1c\00\00\c0\1d\00\00\c0\1e\00\00\c0\1f\00\00\c0\00\00\00\b3\01\00\00\c3\02\00\00\c3\03\00\00\c3\04\00\00\c3\05\00\00\c3\06\00\00\c3\07\00\00\c3\08\00\00\c3\09\00\00\c3\0a\00\00\c3\0b\00\00\c3\0c\00\00\c3\0d\00\00\d3\0e\00\00\c3\0f\00\00\c3\00\00\0c\bb\01\00\0c\c3\02\00\0c\c3\03\00\0c\c3\04\00\0c\db")
  (data $.data (i32.const 4272) "\05\00\00\00\00\00\00\00\00\00\00\00\07\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\08\00\00\00\04\00\00\008\14\00\00\00\04\00\00\00\00\00\00\00\00\00\00\01\00\00\00\00\00\00\00\0a\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\b0\10\00\00\00\00\00\00\05\00\00\00\00\00\00\00\00\00\00\00\07\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\05\00\00\00\04\00\00\00\5c\18\00\00\00\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\00\00\00\00\ff\ff\ff\ff\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00(\11\00\00\00\00\00\00\09\00\00\00\00\00\00\00\00\00\00\00\07\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\06\00\00\00\00\00\00\00\04\00\00\00h\18\00\00\00\04\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\a0\11\00\00"))
