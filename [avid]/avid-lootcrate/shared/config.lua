Config = {
        framework = "qb", -- qb/esx (ESX Untested, added in theoretical support but did not test.)
        inventory = "ox", -- ps, qb, ox, qs
        Debug = false, -- verbose console logging

        Rewards = {
        ['lb_lootcrate'] = { --Civilian Base Loot Crate
            [1] = {
                item = 'weapon_crowbar', --Item name in your inventory. Can be any item.
                image = 'img/weapon_crowbar.png', --Image location of item. This can also be changed to a remote image, ex 'https://i.imgur.com/aCTLp4L.png'
                weight = 20 --Weighted chance of item dropping. Higher the number, higher the chance. 70/100 == high chance, common. 5/100 == low chance, rare. Duh.
            },        
            [2] = {
                item = 'weapon_grenade',
                image = 'img/weapon_grenade.png',
                weight = 5
            },
            [3] = {
                item = 'weapon_dagger',
                image = 'img/weapon_dagger.png',
                weight = 10
            },        
            [4] = {
                item = 'weapon_hominglauncher',
                image = 'img/weapon_hominglauncher.png',
                weight = 1
            },
            [5] = {
                item = 'weapon_railgun',
                image = 'img/weapon_railgun.png', 
                weight = 1 
            },        
            [6] = {
                item = 'weapon_rpg',
                image = 'img/weapon_rpg.png',
                weight = 5
            }
        },
        ['green_lootcrate'] = { --Civilian Medium Loot Crate
            [1] = {
                item = 'weapon_crowbar', --Item name in your inventory. Can be any item.
                image = 'img/weapon_crowbar.png', --Image location of item. This can also be changed to a remote image, ex 'https://i.imgur.com/aCTLp4L.png'
                weight = 20 --Weighted chance of item dropping. Higher the number, higher the chance. 70/100 == high chance, common. 5/100 == low chance, rare. Duh.
            },        
            [2] = {
                item = 'weapon_grenade',
                image = 'img/weapon_grenade.png',
                weight = 5
            },
            [3] = {
                item = 'weapon_dagger',
                image = 'img/weapon_dagger.png',
                weight = 10
            },        
            [4] = {
                item = 'weapon_hominglauncher',
                image = 'img/weapon_hominglauncher.png',
                weight = 1
            },
            [5] = {
                item = 'weapon_railgun',
                image = 'img/weapon_railgun.png', 
                weight = 1 
            },        
            [6] = {
                item = 'weapon_rpg',
                image = 'img/weapon_rpg.png',
                weight = 5
            }
        },
        ['orange_lootcrate'] = { --Civilian Rare Loot Crate
            [1] = {
                item = 'weapon_crowbar', --Item name in your inventory. Can be any item.
                image = 'img/weapon_crowbar.png', --Image location of item. This can also be changed to a remote image, ex 'https://i.imgur.com/aCTLp4L.png'
                weight = 20 --Weighted chance of item dropping. Higher the number, higher the chance. 70/100 == high chance, common. 5/100 == low chance, rare. Duh.
            },        
            [2] = {
                item = 'weapon_grenade',
                image = 'img/weapon_grenade.png',
                weight = 5
            },
            [3] = {
                item = 'weapon_dagger',
                image = 'img/weapon_dagger.png',
                weight = 10
            },        
            [4] = {
                item = 'weapon_hominglauncher',
                image = 'img/weapon_hominglauncher.png',
                weight = 1
            },
            [5] = {
                item = 'weapon_railgun',
                image = 'img/weapon_railgun.png', 
                weight = 1 
            },        
            [6] = {
                item = 'weapon_rpg',
                image = 'img/weapon_rpg.png',
                weight = 5
            }
        },
        ['purple_lootcrate'] = { --Criminal Base Loot Crate
            [1] = {
                item = 'weapon_crowbar', --Item name in your inventory. Can be any item.
                image = 'img/weapon_crowbar.png', --Image location of item. This can also be changed to a remote image, ex 'https://i.imgur.com/aCTLp4L.png'
                weight = 20 --Weighted chance of item dropping. Higher the number, higher the chance. 70/100 == high chance, common. 5/100 == low chance, rare. Duh.
            },        
            [2] = {
                item = 'weapon_grenade',
                image = 'img/weapon_grenade.png',
                weight = 5
            },
            [3] = {
                item = 'weapon_dagger',
                image = 'img/weapon_dagger.png',
                weight = 10
            },        
            [4] = {
                item = 'weapon_hominglauncher',
                image = 'img/weapon_hominglauncher.png',
                weight = 1
            },
            [5] = {
                item = 'weapon_railgun',
                image = 'img/weapon_railgun.png', 
                weight = 1 
            },        
            [6] = {
                item = 'weapon_rpg',
                image = 'img/weapon_rpg.png',
                weight = 5
            }
        },
        ['red_lootcrate'] = { --Criminal Medium Loot Crate
            [1] = {
                item = 'weapon_crowbar', --Item name in your inventory. Can be any item.
                image = 'img/weapon_crowbar.png', --Image location of item. This can also be changed to a remote image, ex 'https://i.imgur.com/aCTLp4L.png'
                weight = 20 --Weighted chance of item dropping. Higher the number, higher the chance. 70/100 == high chance, common. 5/100 == low chance, rare. Duh.
            },        
            [2] = {
                item = 'weapon_grenade',
                image = 'img/weapon_grenade.png',
                weight = 5
            },
            [3] = {
                item = 'weapon_dagger',
                image = 'img/weapon_dagger.png',
                weight = 10
            },        
            [4] = {
                item = 'weapon_hominglauncher',
                image = 'img/weapon_hominglauncher.png',
                weight = 1
            },
            [5] = {
                item = 'weapon_railgun',
                image = 'img/weapon_railgun.png', 
                weight = 1 
            },        
            [6] = {
                item = 'weapon_rpg',
                image = 'img/weapon_rpg.png',
                weight = 5
            }
        },
        ['blue_lootcrate'] = { --Criminal Rare Loot Crate
            [1] = {
                item = 'weapon_crowbar', --Item name in your inventory. Can be any item.
                image = 'img/weapon_crowbar.png', --Image location of item. This can also be changed to a remote image, ex 'https://i.imgur.com/aCTLp4L.png'
                weight = 20 --Weighted chance of item dropping. Higher the number, higher the chance. 70/100 == high chance, common. 5/100 == low chance, rare. Duh.
            },        
            [2] = {
                item = 'weapon_grenade',
                image = 'img/weapon_grenade.png',
                weight = 5
            },
            [3] = {
                item = 'weapon_dagger',
                image = 'img/weapon_dagger.png',
                weight = 10
            },        
            [4] = {
                item = 'weapon_hominglauncher',
                image = 'img/weapon_hominglauncher.png',
                weight = 1
            },
            [5] = {
                item = 'weapon_railgun',
                image = 'img/weapon_railgun.png', 
                weight = 1 
            },        
            [6] = {
                item = 'weapon_rpg',
                image = 'img/weapon_rpg.png',
                weight = 5
            }
        },
        ['white_lootcrate'] = { --Heist Low Loot Crate
            [1] = {
                item = 'weapon_crowbar', --Item name in your inventory. Can be any item.
                image = 'img/weapon_crowbar.png', --Image location of item. This can also be changed to a remote image, ex 'https://i.imgur.com/aCTLp4L.png'
                weight = 20 --Weighted chance of item dropping. Higher the number, higher the chance. 70/100 == high chance, common. 5/100 == low chance, rare. Duh.
            },        
            [2] = {
                item = 'weapon_grenade',
                image = 'img/weapon_grenade.png',
                weight = 5
            },
            [3] = {
                item = 'weapon_dagger',
                image = 'img/weapon_dagger.png',
                weight = 10
            },        
            [4] = {
                item = 'weapon_hominglauncher',
                image = 'img/weapon_hominglauncher.png',
                weight = 1
            },
            [5] = {
                item = 'weapon_railgun',
                image = 'img/weapon_railgun.png', 
                weight = 1 
            },        
            [6] = {
                item = 'weapon_rpg',
                image = 'img/weapon_rpg.png',
                weight = 5
            }
        },
        ['black_lootcrate'] = { --Heist High Loot Crate
            [1] = {
                item = 'weapon_crowbar', --Item name in your inventory. Can be any item.
                image = 'img/weapon_crowbar.png', --Image location of item. This can also be changed to a remote image, ex 'https://i.imgur.com/aCTLp4L.png'
                weight = 20 --Weighted chance of item dropping. Higher the number, higher the chance. 70/100 == high chance, common. 5/100 == low chance, rare. Duh.
            },        
            [2] = {
                item = 'weapon_grenade',
                image = 'img/weapon_grenade.png',
                weight = 5
            },
            [3] = {
                item = 'weapon_dagger',
                image = 'img/weapon_dagger.png',
                weight = 10
            },        
            [4] = {
                item = 'weapon_hominglauncher',
                image = 'img/weapon_hominglauncher.png',
                weight = 1
            },
            [5] = {
                item = 'weapon_railgun',
                image = 'img/weapon_railgun.png', 
                weight = 1 
            },        
            [6] = {
                item = 'weapon_rpg',
                image = 'img/weapon_rpg.png',
                weight = 5
            }
        },
    }
}