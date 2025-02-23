---@class ShopItem
---@field id? number internal id number, do not set
---@field name? string item name as referenced in ox_inventory
---@field price number base price of the item
---@field defaultStock? integer the amount of items available in the shop by default
---@field category? string the category of the item in the shop (e.g. 'Snacks', 'Tools', 'Firearms', 'Ammunition', 'Drinks')
---@field license? string the license required to purchase the item
---@field jobs? table<string, number> map of group names to min grade required to access the shop
---@field metadata? table | string metadata for item

---@type table<string, table<string | number, ShopItem>>
local ITEMS = {
	normal = {
		water_bottle = { price = 3, defaultStock = 5000, category = 'Drinks' },
		tosti = { price = 5, defaultStock = 5000, category = 'Food' },
		kurkakola = { price = 5, defaultStock = 5000, category = 'Drinks' },
		twerks_candy = { price = 2, defaultStock = 5000, category = 'Snacks' },
		snikkel_candy = { price = 2, defaultStock = 5000, category = 'Snacks' },
		sandwich = { price = 5, defaultStock = 5000, category = 'Food' },
		beer = { price = 8, defaultStock = 5000, category = 'Drinks' },
		bandage = { price = 15, defaultStock = 5000, category = 'Other' },
		lighter = { price = 5, defaultStock = 5000, category = 'Other' },
		wallet = { price = 20, defaultStock = 1000, category = 'Other' },
		cigarette = { price = 1, defaultStock = 50000, category = 'Other' },
		cigarette_case = {price = 10, defaultStock = 5000, category = 'Other'},
		phone = { price = 50, defaultStock = 5000, category = 'Other' },
	},
	bar = {
		water_bottle = { price = 3, defaultStock = 5000 },
		beer = { price = 8, defaultStock = 5000 },
		whiskey = { price = 15, defaultStock = 5000 },
	},
	hardware = {
		{ name = 'screwdriverset', price = 20, defaultStock = 5000, category = 'Supplies' },
		{ name = 'binoculars', price = 20, defaultStock = 5000, category = 'Supplies' },
		{ name = 'repairkit', price = 100, defaultStock = 5000, category = 'Supplies' },
		{ name = 'lockpick', price = 75, defualtStock = 2000, category = 'Tools' },
		{ name = 'small_backpack', price = 30, defaultStock = 500, category = 'Supplies' },
		{ name = 'WEAPON_HAMMER', price = 120, defaultStock = 5000, category = 'Tools' },
		{ name = 'WEAPON_WRENCH', price = 120, defaultStock = 5000, category = 'Tools' },
		{ name = 'fertilizer', price = 40, defaultStock = 5000, category = 'Supplies' },
		{ name = 'watering_can', price = 10, defaultStock = 5000, category = 'Supplies' },
		{ name = 'cleaningkit', price = 40, defaultStock = 5000, category = 'Supplies' },
		--{ name = 'pickaxe', price = 50, defaultStock = 5000, category = 'Supplies' },
		{ name = 'metalsheers', price = 30, defaultStock = 5000, category = 'Tools'},
	},
	weapons = {
		{ name = 'WEAPON_KNIFE',      price = 300,   defaultStock = 2500,        category = 'Point Defense' },
		{ name = 'WEAPON_SWITCHBLADE',      price = 300,   defaultStock = 2500,        category = 'Point Defense' },
		{ name = 'WEAPON_BAT',        price = 150,   defaultStock = 2500,        category = 'Point Defense' },
		{ name = 'WEAPON_KNUCKLE',    price = 950,  defaultStock = 2500,        category = 'Point Defense' },
		{ name = 'WEAPON_PISTOL',     price = 2450, defaultStock = 5,          license = "weapon",        category = 'Firearms' },
		{ name = 'ammo-9',            price = 4,    defaultStock = 9500,          category = 'Ammunition' },
	},
	electronics = {
		{ name = 'phone', price = 50 },
	},
	mining = {
        {name = 'pickaxe', price = 50, defaultStock = 5000, category = 'Supplies'},
        {name = 'miningdrill', price = 500, defaultStock = 5000, category = 'Supplies'},
        {name = 'drillbit', price =  10, defaultStock = 5000, category = 'Supplies'},
	},
	police = {
		{ name = 'WEAPON_FLASHLIGHT',    price = 10, defaultStock = 200,         job = "police",        category = 'Weapons' },
		{ name = 'WEAPON_NIGHTSTICK',    price = 10, defaultStock = 200,         job = "police",        category = 'Weapons' },
		{ name = 'WEAPON_STUNGUN',    	 price = 10, defaultStock = 200,         job = "police",        category = 'Weapons' },
		{ name = 'at_flashlight',	     price = 10, defaultStock = 200,		 job = "police",		category = 'Weapons' },
		{ name = 'ifaks',    			 price = 20, defaultStock = 1500,        job = "police",        category = 'Supplies' },
		{ name = 'heavyarmour',    		 price = 30, defaultStock = 1500,        job = "police",        category = 'Supplies' },
		{ name = 'bandage',    			 price = 3, defaultStock = 1500,         job = "police",        category = 'Supplies' },
		{ name = 'empty_evidence_bag',   price = 0, defaultStock = 1500,         job = "police",        category = 'Supplies' },
		{ name = 'handcuffs', 			 price = 10, defaultStock = 1500,		 job = "police",		category = 'Supplies' },
		{ name = 'bodycam',				 price = 0,	defaultStock = 1500,		 job = "police",		category = 'Supplies' },
		{ name = 'spikestrip',				 price = 0,	defaultStock = 1500,		 job = "police",		category = 'Supplies' },
		{ name = 'megaphone',			 price = 150, defaultStock = 20,		 job = "police",		category = 'Supplies' },
		{ name = 'WEAPON_COMBATPISTOL',  price = 500, defaultStock = 200,          job = "police",        category = 'Weapons' },
		{ name = 'WEAPON_PUMPSHOTGUN_MK2',  price = 1000, defaultStock = 200,       job = "police",        category = 'Weapons' },
		{ name = 'ammo-shotgun', 		 price = 50, defaultStock = 9500,		 job = "police",		category = "Ammunition" },
		{ name = 'ammo-9',            	 price = 10, defaultStock = 9500,    	 job = "police",      	category = 'Ammunition' },
	},
	firefighter = {
		{ name = 'ifaks',    			 price = 20, defaultStock = 1500,        job = "firefighter",        category = 'Equipment' },
		{ name = 'bandage',    			 price = 3, defaultStock = 1500,         job = "firefighter",        category = 'Equipment' },
		{ name = 'megaphone',			 price = 150, defaultStock = 20,		 job = "firefighter",		category = 'Equipment' },
		{ name = 'watertank',			 price = 0, defaultStock = 5000,		 job = "firefighter",		category = 'Equipment' },
		{ name = 'WEAPON_FLASHLIGHT',    price = 0, defaultStock = 2000,         job = "firefighter",        category = 'Equipment' },
	},
	hunting = {
		{ name = 'WEAPON_MUSKET',    	 price = 200, defaultStock = 1500,               category = 'Hunting' },
		{ name = 'bandage',    			 price = 5, defaultStock = 1500,                 category = 'Supplies' },
		{ name = 'ammo-musket',			 price = 1, defaultStock = 20000,		 		category = 'Hunting' },

	},
	ems = {
		{ name = 'bandage',    	 		 price = 0, defaultStock = 1500,                category = 'Supplies' },
		{ name = 'ifaks',    			 price = 20, defaultStock = 1500,               category = 'Supplies' },
		{ name = 'WEAPON_FLASHLIGHT',	 price = 10, defaultStock = 20000,		 		category = 'Supplies' },
		{ name = 'firstaid',	 		 price = 0, defaultStock = 20000,		 		category = 'Supplies' },
		{ name = 'painkillers',	 		 price = 0, defaultStock = 20000,		 		category = 'Supplies' },
	},
	electronics = {
		{ name = 'keyboard',    	     price = 40, defaultStock = 1500,                category = 'Computer' },
		{ name = 'mouse',    			 price = 30, defaultStock = 1500,               category = 'Computer' },
		{ name = 'compcase',	 		 price = 60, defaultStock = 20000,		 		category = 'Computer' },
		{ name = 'powersupply',	 		 price = 70, defaultStock = 20000,		 		category = 'Computer' },
		{ name = 'cables',	 		 	 price = 20, defaultStock = 20000,		 		category = 'Computer' },
		{ name = 'it_toolkit',    	     price = 100, defaultStock = 1500,                category = 'Computer' },
		{ name = 'cpu',    			 	 price = 200, defaultStock = 1500,               category = 'Computer' },
		{ name = 'cpucooler',	 		 price = 70, defaultStock = 20000,		 		category = 'Computer' },
		{ name = 'motherboard',	 		 price = 210, defaultStock = 20000,		 		category = 'Computer' },
		{ name = 'memory',	 		 	 price = 140, defaultStock = 20000,		 		category = 'Computer' },
		{ name = 'graphiccard',	 		 price = 400, defaultStock = 20000,		 		category = 'Computer' },
		{ name = 'ssd',	 		 	 	 price = 130, defaultStock = 20000,		 		category = 'Computer' },
		{ name = 'phone',				 price = 40, defaultStock = 2000, 				category = 'Communications'},
	},
}

local newFormatItems = {}
for category, categoryItems in pairs(ITEMS) do
	local newCategoryItems = {}

	for item, data in pairs(categoryItems) do
		if not data.name then
			data.name = tostring(item)
		end

		newCategoryItems[#newCategoryItems + 1] = data
	end

	table.sort(newCategoryItems, function(a, b)
		return a.name < b.name
	end)

	newFormatItems[category] = newCategoryItems
end

return newFormatItems
