import launch
import launch.actions
import launch.substitutions
import launch_ros.actions


def generate_launch_description():

    talker = launch_ros.actions.Node(
        package='homework2',
        executable='weather',
        )
    listener = launch_ros.actions.Node(
        package='homework2',
        executable='weather',
        output='screen'
        )

    return launch.LaunchDescription([weather, weather])
