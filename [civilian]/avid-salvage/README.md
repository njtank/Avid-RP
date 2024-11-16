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

---
Let me know if you need any additional details or changes!