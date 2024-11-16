![Avid_RP_No_Text-removebg-preview](https://github.com/user-attachments/assets/9030d8f6-b205-4581-8fd9-41bb7cfab649)

---

# avid-salvage

**avid-salvage** is a FiveM script for managing a salvage car task system, allowing players to interact with salvage zones in a scrapyard. The script integrates with **ox_inventory** for rewarding players with items and **ox_target** for creating interactive zones where players can perform tasks. Players can earn rewards like plastic, scrap metal, and rubber after completing tasks, and after a certain number of tasks, they can be paid $50 to their bank account.

## Features:
- **Interactive Salvage Zones**: Players can approach salvage zones (configured in the `config.lua`) to perform a task.
- **Animation**: Uses an animation (`mini@repair:fixing_a_ped`) while the player performs the scrap car task.
- **Item Rewards**: Rewards items such as plastic, scrap metal, and rubber after completing the task.
- **Progress Tracking**: Players must complete a specified number of tasks to receive a $50 cash reward.
- **Customizable Configurations**: Easily change the scrap yard location, task duration, items rewarded, and other settings in the config file.
- **Blip**: A customizable blip is shown on the map for the scrapyard location.

## Dependencies:
- [ox_inventory](https://github.com/overextended/ox_inventory) - for inventory management and item rewards.
- [ox_target](https://github.com/overextended/ox_target) - for creating interactive sphere zones in the scrap yard.
- [ox_lib](https://github.com/overextended/ox_lib) - optional, used for progress bar.

## Installation:

1. **Download or Clone the Resource:**
   Download the **avid-salvage** resource and place it into your **[resources]** folder.

2. **Configure the Resource:**
   - Edit the `config.lua` file to set up the scrap yard location, the blip settings, the task duration, the reward items, and other settings.  
   - Define the number of tasks a player must complete to receive a $50 reward.

3. **Add to `server.cfg`:**
   Add the following line to your `server.cfg` to ensure the resource is started when your server runs:
   ```txt
   start avid-salvage
   ```

## Config File (`config.lua`):
In the `config.lua`, you can adjust the following parameters:

- **Scrap Yard Location (`ScrapYardLocation`)**: Coordinates for the center of the scrap yard.
- **Blip Settings (`Blip`)**: Set the location, sprite, color, and size of the blip that appears on the map.
- **Task Duration (`TaskDuration`)**: Set the time in seconds for how long the scrap car task takes to complete.
- **Reward Items (`RewardItems`)**: Define the items players receive after completing a task. You can customize this list with items like `plastic`, `scrapmetal`, and `rubber`.
- **Number of Tasks Before Cash Payment (`TasksBeforeCash`)**: After a certain number of tasks, players will receive $50 in their bank account.

### Example of `config.lua`:

```lua
Config = {}

-- Scrap Yard Location (for the blip and sphere zones)
Config.ScrapYardLocation = vector3(200.0, -2000.0, 20.0) -- Example coordinates

-- Blip Configuration
Config.Blip = {
    coords = vector3(200.0, -2000.0, 20.0), -- Position of the blip
    sprite = 402,  -- Blip sprite ID (e.g., 402 is for a scrap yard)
    color = 5,     -- Blip color (e.g., 5 for green)
    scale = 0.8,   -- Blip size
    name = "Scrap Yard" -- Name that will show on the map
}

-- Task Duration (in seconds)
Config.TaskDuration = 24  -- Example: 24 seconds to scrap a car

-- Reward Items
Config.RewardItems = {
    "plastic",   -- Item 1
    "scrapmetal", -- Item 2
    "rubber"      -- Item 3
}

-- Item Amount Range
Config.MinRewardAmount = 1
Config.MaxRewardAmount = 4

-- Number of Tasks Before Cash Payment
Config.TasksBeforeCash = 5  -- After 5 tasks, $50 is paid to the player

-- Sphere Zone Configuration (for each car in the scrapyard)
Config.ScrapZones = {
    {coords = vector3(210.0, -2000.0, 20.0), radius = 3.0},
    {coords = vector3(220.0, -2000.0, 20.0), radius = 3.0},
    -- Add more zones here as needed
}
```

## Usage:

### Client-Side:
- **Interact with Salvage Zones**: Players can walk up to any of the defined salvage zones in the scrap yard. When they approach a zone, a notification will pop up to inform them that they can start the task.
- **Start Task**: Once the player activates the task, the animation will start, and a progress bar will appear. After the task is completed, the player will receive a random reward (plastic, scrap metal, or rubber).
- **Receive Payment**: After completing a specified number of tasks (5 by default), the player will receive $50 deposited into their bank account.

### Server-Side:
- **Task Completion**: The server will track how many tasks the player has completed, and once the player reaches the required number of tasks, they will be rewarded with $50.
- **Item Rewards**: The server will also add the rewarded item(s) to the player's inventory using **ox_inventory**.

## Notes:
- **Scrap Zones**: The script uses **ox_target** to create sphere zones around each car in the scrap yard. You can configure the zones in the `config.lua` file by specifying the coordinates and radius of each zone.
- **Animation**: The animation `mini@repair:fixing_a_ped` will play while the player performs the task, lasting the duration specified in `config.lua`.

## Troubleshooting:
- **No Items in Inventory**: If the player isn’t receiving items, ensure that **ox_inventory** is installed and properly configured. Make sure the item names in the config match the item names used in the inventory system.
- **Blip Not Showing**: Ensure that the coordinates for the blip and the map are correctly set. Check if the blip is properly configured in the `config.lua`.
- **Server Errors**: Double-check the server-side script to ensure the events are properly triggered and that the database or player task tracking system is working as expected.

## License:
This script is released under the [MIT License](https://opensource.org/licenses/MIT).

---

This README covers installation, configuration, usage, and troubleshooting. Let me know if you need any additional details or changes!