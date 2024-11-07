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
		--redwoodpack = { price = 15, defaultStock = 5000, category = 'Other' },
		phone = { price = 50, defaultStock = 5000, category = 'Other' },
	},
	bar = {
		water_bottle = { price = 3, defaultStock = 5000 },
		beer = { price = 8, defaultStock = 5000 },
		whiskey = { price = 15, defaultStock = 5000 },
	},
	hardware = {
		{ name = 'lockpick', price = 20, defaultStock = 5000, category = 'Tools' },
		{ name = 'binoculars', price = 20, defaultStock = 5000, category = 'Tools' },
		{ name = 'repairkit', price = 100, defaultStock = 5000, category = 'Tools' },
		{ name = 'WEAPON_HAMMER', price = 120, defaultStock = 5000, category = 'Tools' },
		{ name = 'WEAPON_WRENCH', price = 120, defaultStock = 5000, category = 'Tools' },
		--{ name = 'fertilizer', price = 40, defaultStock = 5000, category = 'Supplies' },
		--{ name = 'watering_can', price = 10, defaultStock = 5000, category = 'Supplies' },
		{ name = 'cleaningkit', price = 40, defaultStock = 5000, category = 'Supplies' },
		--{ name = 'pickaxe', price = 50, defaultStock = 5000, category = 'Supplies' },
	},
	weapons = {
		{ name = 'WEAPON_KNIFE',      price = 300,   defaultStock = 2500,        category = 'Point Defense' },
		{ name = 'WEAPON_SWITCHBLADE',      price = 300,   defaultStock = 2500,        category = 'Point Defense' },
		{ name = 'WEAPON_BAT',        price = 150,   defaultStock = 2500,        category = 'Point Defense' },
		{ name = 'WEAPON_KNUCKLE',    price = 950,  defaultStock = 2500,        category = 'Point Defense' },
		{ name = 'WEAPON_PISTOL',     price = 2450, defaultStock = 5,          license = "weapon",        category = 'Firearms' },
		{ name = 'ammo-9',            price = 4,    defaultStock = 9500,       license = "weapon",        category = 'Ammunition' },
	},
	electronics = {
		{ name = 'phone', price = 50 },
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
