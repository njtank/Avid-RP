This script allows players to tune their vehicles in FiveM using QBCore. Players can change their vehicle's tuning class based on job restrictions and vehicle categories.

Features
Tuning Classes: Vehicles can be tuned to different classes (D, C, B, A, S) with varying performance parameters.
Job Restrictions: Specific jobs have restrictions on which tuning classes they can access.
Category Restrictions: You can enable or disable vehicle category restrictions.


Installation
Place the qb-streettuner folder in your resources directory.
Add start qb-streettuner to your server.cfg.



Configuration
Config File
You can configure the tuning classes, job restrictions, and vehicle categories in the Config.lua file. Here’s a brief explanation of the main sections:

TuningClasses: Define the parameters for each tuning class.
AllowedJobs: Set the jobs that are allowed to tune specific classes.
VehicleCategories: Control which vehicle categories are enabled and their allowed classes.


qb-radialmenu Configuration
To add the vehicle tuning options to the qb-radialmenu, use the following configuration snippet in your radial menu setup:

qb-radialmenu, config.lua
{
    id = 'tuning',
    title = 'Vehicle Tuning',
    icon = 'wrench',
    items = {
        {
            id = 'classD',
            title = 'Class D',
            icon = 'car',
            type = 'client',
            event = 'vehicle:tuneClass',
            args = { class = 'D' },
            shouldClose = true
        },
        {
            id = 'classC',
            title = 'Class C',
            icon = 'car',
            type = 'client',
            event = 'vehicle:tuneClass',
            args = { class = 'C' },
            shouldClose = true
        },
        {
            id = 'classB',
            title = 'Class B',
            icon = 'car',
            type = 'client',
            event = 'vehicle:tuneClass',
            args = { class = 'B' },
            shouldClose = true
        },
        {
            id = 'classA',
            title = 'Class A',
            icon = 'car',
            type = 'client',
            event = 'vehicle:tuneClass',
            args = { class = 'A' },
            shouldClose = true
        },
        {
            id = 'classS',
            title = 'Class S',
            icon = 'car',
            type = 'client',
            event = 'vehicle:tuneClass',
            args = { class = 'S' },
            shouldClose = true
        }
    }
},

Usage
After installing and configuring the script, players can access vehicle tuning through the radial menu. Simply select the desired tuning class to apply the changes to their vehicle.

Support
If you encounter any issues or have questions, feel free to open an issue on the repository or contact the developer.

