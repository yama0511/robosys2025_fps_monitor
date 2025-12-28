# SPDX-FileCopyrightText: 2025 Yamato Okada
# SPDX-License-Identifier: BSD-3-Clause

"""Launch fps_monitor nodes."""

from launch import LaunchDescription
from launch_ros.actions import Node


def generate_launch_description():
    """Generate launch description."""
    return LaunchDescription([
        Node(
            package='fps_monitor',
            executable='sensor_sim',
            name='sensor_sim'
        ),
        Node(
            package='fps_monitor',
            executable='fps_calc',
            name='fps_calc',
            output='screen'
        ),
        ])
