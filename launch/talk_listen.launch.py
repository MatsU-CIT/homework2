# SPDX-FileCopyrightText: 2025 Yusuke Matsumoto s23c1134bg@s.chibakoudai.jp
# SPDX-License-Identifier: BSD-3-Clause
import launch
import launch.actions
import launch.substitutions
import launch_ros.actions


def generate_launch_description():

    weather = launch_ros.actions.Node(
        package='homework2',
        executable='weather',
        output='screen',
    )

    listener = launch_ros.actions.Node(
        package='homework2',
        executable='listener',
        output='screen',
    )

    return launch.LaunchDescription([weather, listener])
