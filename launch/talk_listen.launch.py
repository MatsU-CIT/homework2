import launch
import launch_ros.actions


def generate_launch_description():

    weather_publisher = launch_ros.actions.Node(
        package='homework2',
        executable='weather',
        name='weather_publisher',
        output='screen'
    )

    return launch.LaunchDescription([
        weather_publisher
    ])
