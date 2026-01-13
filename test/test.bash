#!/bin/bash -xv
# SPDX-FileCopyrightText: 2025 Yamato Okada
# SPDX-License-Identifier: BSD-3-Clause

ng () {
      echo ${1}行目が違うよ
      res=1
}

res=0

# Pythonの出力を即座に表示させるおまじない（重要！）
export PYTHONUNBUFFERED=1

source /opt/ros/humble/setup.bash

colcon build --packages-select robosys2025_fps_monitor || ng "$LINENO"
source install/setup.bash

# ノードを起動（10秒後に強制終了）
timeout 10 ros2 launch robosys2025_fps_monitor fps_launch.py > /tmp/robosys2025_fps_monitor.log 2>&1 || true

# 【デバッグ用】ログの中身を画面に出す（これで何が記録されたかGitHubで見れるようになります）
cat /tmp/robosys2025_fps_monitor.log

# "FPS" という文字が含まれているかチェック
count=$(grep -c "FPS" /tmp/robosys2025_fps_monitor.log)
[ "$count" -ge 1 ] || ng "$LINENO"

[ "$res" = 0 ] && echo OK

exit $res
