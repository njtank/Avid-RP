return {
    ['testburger'] = {
        label = 'Test Burger',
        weight = 220,
        degrade = 60,
        client = {
            image = 'burger_chicken.png',
            status = { hunger = 200000 },
            anim = 'eating',
            prop = 'burger',
            usetime = 2500,
            export = 'ox_inventory_examples.testburger'
        },
        server = {
            export = 'ox_inventory_examples.testburger',
            test = 'what an amazingly delicious burger, amirite?'
        },
        buttons = {
            {
                label = 'Lick it',
                action = function(slot)
                    print('You licked the burger')
                end
            },
            {
                label = 'Squeeze it',
                action = function(slot)
                    print('You squeezed the burger :(')
                end
            },
            {
                label = 'What do you call a vegan burger?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('A misteak.')
                end
            },
            {
                label = 'What do frogs like to eat with their hamburgers?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('French flies.')
                end
            },
            {
                label = 'Why were the burger and fries running?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('Because they\'re fast food.')
                end
            }
        },
        consume = 0.3
    },

    ['bandage'] = {
        label = 'Bandage',
        weight = 115,
        client = {
            anim = { dict = 'anim@mp_player_intuppersalsa_roll', clip = 'idle_a', flag = 49 },
            --prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
            disable = { move = false, car = false, combat = true },
            usetime = 2500,
        }
    },

    ['burger'] = {
        label = 'Burger',
        weight = 220,
        client = {
            status = { hunger = 200000 },
            anim = 'eating',
            prop = 'burger',
            usetime = 2500,
            notification = 'You ate a delicious burger'
        },
    },

    ['sprunk'] = {
        label = 'Sprunk',
        weight = 350,
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
            notification = 'You quenched your thirst with a sprunk'
        }
    },

    ['parachute'] = {
        label = 'Parachute',
        weight = 8000,
        stack = false,
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 1500
        }
    },

    ['garbage'] = {
        label = 'Garbage',
    },

    ['paperbag'] = {
        label = 'Paper Bag',
        weight = 1,
        stack = false,
        close = false,
        consume = 0
    },

    ['panties'] = {
        label = 'Knickers',
        weight = 10,
        consume = 0,
        client = {
            status = { thirst = -100000, stress = -25000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
            usetime = 2500,
        }
    },

    ['lockpick'] = {
        label = 'Lockpick',
        weight = 160,
        client = {
            event = 'lockpick:use',
        }
    },

    ['phone'] = {
        label = 'Phone',
        weight = 190,
        stack = false,
        consume = 0,
        client = {
            add = function(total)
                if total > 0 then
                    pcall(function() return exports.npwd:setPhoneDisabled(false) end)
                end
            end,

            remove = function(total)
                if total < 1 then
                    pcall(function() return exports.npwd:setPhoneDisabled(true) end)
                end
            end
        }
    },

    ['water'] = {
        label = 'Water',
        weight = 500,
        client = {
            image = "water.png",
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
            usetime = 2500,
            cancel = true,
            notification = 'You drank some refreshing water'
        }
    },

    ['armour'] = {
        label = 'Standard Armor Vest',
        weight = 3000,
        stack = false,
        client = {
            image = "armour.png",
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 3500
        }
    },

    ['heavyarmour'] = {
        label = 'Heavy Armor Vest',
        weight = 3000,
        stack = false,
        client = {
            image = "armour.png",
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 4500
        }
    },

    ['clothing'] = {
        label = 'Clothing',
        consume = 0,
    },

    ['money'] = {
        label = 'Money',
    },

    ['black_money'] = {
        label = 'Dirty Money',
    },

    ['id_card'] = {
        label = 'Identification Card',
    },

    ['driver_license'] = {
        label = 'Drivers License',
        client = {
            image = "card_id.png",
        }
    },

    ['weaponlicense'] = {
        label = 'Weapon License',
    },

    ['lawyerpass'] = {
        label = 'Lawyer Pass',
    },

    ['radio'] = {
        label = 'Radio',
        weight = 1000,
        stack = false,
        allowArmed = true
    },

    ['advancedlockpick'] = {
        label = 'Advanced Lockpick',
        weight = 500,
        stack = false,
        consume = 0.1,
        client = {
            image = "lockpick_red.png",
        }
    },

    ['screwdriverset'] = {
        label = 'Screwdriver Set',
        weight = 500,
        stack = false,
        client = {
            image = "screwdriverset_grey.png",
        }
    },

    ['electronickit'] = {
        label = 'Electronic Kit',
        weight = 500,
        client = {
            image = "electronickit.png",
        }
    },

    ['cleaningkit'] = {
        label = 'Cleaning Kit',
        weight = 500,
        client = {
            image = "cleaningkit.png",
        }
    },

    ['repairkit'] = {
        label = 'Repair Kit',
        weight = 2500,
        client = {
            image = "repairkit.png",
        }
    },

    ['advancedrepairkit'] = {
        label = 'Advanced Repair Kit',
        weight = 4000,
        client = {
            image = "advancedkit.png",
        }
    },

    ['diamond_ring'] = {
        label = 'Diamond Ring',
        weight = 1500,
    },

    ['rolex'] = {
        label = 'Golden Watch',
        weight = 1500,
    },

    ['goldbar'] = {
        label = 'Gold Bar',
        weight = 1500,
    },

    ['goldchain'] = {
        label = 'Golden Chain',
        weight = 1500,
        stack = true,
    },

    ['crack_baggy'] = {
        label = 'Crack Baggy',
        weight = 100,
    },

    ['cokebaggy'] = {
        label = 'Bag of Coke',
        weight = 100,
    },

    ['coke_brick'] = {
        label = 'Coke Brick',
        weight = 2000,
    },

    ['coke_small_brick'] = {
        label = 'Coke Package',
        weight = 1000,
    },

    ['xtcbaggy'] = {
        label = 'Bag of Ecstasy',
        weight = 100,
    },

    ['meth'] = {
        label = 'Methamphetamine',
        weight = 100,
        client = {
            image = "meth.png",
        }
    },

    ['acetone'] = {
		label = 'Acetone',
		weight = 200,
		stack = true,
		close = false,
		description = "It is a colourless, highly volatile and flammable liquid with a characteristic pungent odour.",
        client = {
            image = "acetone.png",
        }
	},
    	['lithium'] = {
		label = 'Lithium',
		weight = 100,
		stack = true,
		close = false,
        client = {
            image = "lithium.png",
        }
	},
    	['meth_equipment'] = {
		label = 'Portable meth_equipment',
		weight = 5000,
		stack = true,
		close = false,
		description = "A portable Meth Lab.",
        client = {
            image = "meth_equipment.png",
        }
	},

    ['meth_brick'] = {
        label = 'Brick of Methamphetamine',
        weight = 600,
        stack = false,
        client = {
            image = "meth_brick.png",
        }
    },

    ['oxy'] = {
        label = 'Oxycodone',
        weight = 100,
        client = {
            image = "oxy.png",
        }
    },

    ['joint'] = {
        label = 'Joint',
        weight = 200,
    },

    ['rolling_paper'] = {
        label = 'Rolling Paper',
        weight = 0,
    },

    ['empty_weed_bag'] = {
        label = 'Empty Weed Bag',
        weight = 0,
    },

    ['firstaid'] = {
        label = 'First Aid',
        weight = 2500,
    },

    ['ifaks'] = {
        label = 'Individual First Aid Kit',
        weight = 2500,
        client = {
            image = "ifak.png",
        }
    },

    ['painkillers'] = {
        label = 'Painkillers',
        weight = 400,
        client = {
            image = "painkillers.png",
        }
    },

    ['firework1'] = {
        label = '2Brothers',
        weight = 1000,
    },

    ['firework2'] = {
        label = 'Poppelers',
        weight = 1000,
    },

    ['firework3'] = {
        label = 'WipeOut',
        weight = 1000,
    },

    ['firework4'] = {
        label = 'Weeping Willow',
        weight = 1000,
    },
    ['rubber'] = {
        label = 'Rubber',
        weight = 5,
        client = {
            image = "rubber.png",
        }
    },

    ['metalscrap'] = {
        label = 'Metal Scrap',
        weight = 5,
        client = {
            image = "metalscrap.png",
        }
    },

    ['electronics'] = {
        label = 'Electronics',
        weight = 5,
        client = {
            image = "electronics.png",
        }
    },

    ['iron'] = {
        label = 'Iron',
        weight = 5,
        client = {
            image = "iron.png",
        }
    },

    ['copper'] = {
        label = 'Copper',
        weight = 5,
        client = {
            image = "copper.png",
        }
    },

    ['aluminium'] = {
        label = 'Aluminium',
        weight = 5,
        client = {
            image = "aluminium.png",
        }
    },
    ['plastic'] = {
        label = 'Plastic',
        weight = 5,
        client = {
            image = "plastic.png",
        }
    },

    ['glass'] = {
        label = 'Glass',
        weight = 100,
        client = {
            image = "glass.png",
        }
    },

    ['leather'] = {
        label = 'Leather',
        weight = 5,
        client = {
            image = "leather.png",
        }
    },

    ['dirty_cloth'] = {
        label = 'Dirty Cloth',
        weight = 5,
        client = {
            image = "dirty_cloth.png",
        }
    },

    ['gatecrack'] = {
        label = 'Gatecrack',
        weight = 1000,
    },

    ['cryptostick'] = {
        label = 'Crypto Stick',
        weight = 100,
        client = {
            image = "cryptostick.png",
        }
    },

    ['trojan_usb'] = {
        label = 'Trojan USB',
        weight = 100,
        client = {
            image = "hacking_device.png",
        }
    },

    ['toaster'] = {
        label = 'Toaster',
        weight = 5000,
    },

    ['small_tv'] = {
        label = 'Small TV',
        weight = 100,
    },

    ['security_card_01'] = {
        label = 'Security Card A',
        weight = 100,
    },

    ['security_card_02'] = {
        label = 'Security Card B',
        weight = 100,
    },

    ['drill'] = {
        label = 'Drill',
        weight = 5000,
    },

    ['thermite'] = {
        label = 'Thermite',
        weight = 1000,
        client = {
            image = "thermite.png",
        }
    },

    ['diving_gear'] = {
        label = 'Diving Gear',
        weight = 30000,
    },

    ['diving_fill'] = {
        label = 'Diving Tube',
        weight = 3000,
    },

    ['antipatharia_coral'] = {
        label = 'Antipatharia',
        weight = 1000,
    },

    ['dendrogyra_coral'] = {
        label = 'Dendrogyra',
        weight = 1000,
    },

    ['jerry_can'] = {
        label = 'Jerrycan',
        weight = 3000,
    },

    ['nitrous'] = {
        label = 'Nitrous',
        weight = 1000,
    },

    ['wine'] = {
        label = 'Wine',
        weight = 500,
    },

    ['grape'] = {
        label = 'Grape',
        weight = 10,
    },

    ['grapejuice'] = {
        label = 'Grape Juice',
        weight = 200,
    },

    ['coffee'] = {
        label = 'Coffee',
        weight = 200,
    },

    ['vodka'] = {
        label = 'Vodka',
        weight = 500,
    },

    ['whiskey'] = {
        label = 'Whiskey',
        weight = 200,
        client = {
            image = "whiskey_richards.png",
        }
    },

    ['beer'] = {
        label = 'Beer',
        weight = 200,
        client = {
            image = "beer.png",
        }
    },

    ['sandwich'] = {
        label = 'Ham Sandwich',
        weight = 200,
        client = {
            image = "sandwich_ham.png",
        }
    },

    ['walking_stick'] = {
        label = 'Walking Stick',
        weight = 1000,
    },

    ['lighter'] = {
        label = 'Lighter',
        weight = 200,
        client = {
            image = "lighter2.png",
        }
    },

    ['binoculars'] = {
        label = 'Binoculars',
        weight = 800,
        client = {
            image = "binoculars.png",
        }
    },

    ['stickynote'] = {
        label = 'Sticky Note',
        weight = 0,
    },

    ['empty_evidence_bag'] = {
        label = 'Empty Evidence Bag',
        weight = 200,
        client = {
            image = "empty_evidence.png",
        },
    },

    ['filled_evidence_bag'] = {
        label = "Evidence Bag",
        weight = 200,
        stack = false,
        close = false,
        description = "A filled evidence bag to see who committed the crime >:(",
        client = {
            image = "evidence.png",
        },
        buttons = {
            {
                label = "Copy Info",
                action = function(slot)
                    local PlayerData = exports.qbx_core:GetPlayerData()
                    local item = PlayerData.items[slot]
                    if not item or not item.metadata or not item.metadata.description then
                        return
                    end

                    local info = item.metadata.description
                    local patterns = {
                        { keyword = "Serial", pattern = "Serial #: (%w+)" },
                        { keyword = "Fingerprint", pattern = "Fingerprint ID: (%w+)" },
                        { keyword = "DNA", pattern = "DNA ID: (%w+)" }
                    }

                    local result = nil
                    for _, entry in ipairs(patterns) do
                        if string.find(info, entry.keyword) then
                            result = string.match(info, entry.pattern)
                            break
                        end
                    end

                    if result then
                        lib.notify({ title = 'Information Copied!', type = 'success', description = 'Information copied to clipboard' })
                        lib.setClipboard(result)
                    else
                        lib.notify({ title = 'No data found!', type = 'error', description = 'There is no data to copy' })
                    end
                end
            }
        }
    },

    ['harness'] = {
        label = 'Harness',
        weight = 200,
    },

    ['handcuffs'] = {
        label = 'Handcuffs',
        weight = 200,
    },

    ['aluminumoxide'] = {
        label = "Aluminium Powder",
        weight = 10,
        stack = true,
        close = false,
        description = "Some powder to mix with",
        client = {
            image = "aluminumoxide.png",
        }
    },

    ['iphone'] = {
        label = "iPhone",
        weight = 1000,
        stack = true,
        close = true,
        description = "Very expensive phone",
        client = {
            image = "iphone.png",
        }
    },

    ['markedbills'] = {
        label = "Marked Money",
        weight = 1000,
        stack = false,
        close = true,
        description = "Money?",
        client = {
            image = "markedbills.png",
        }
    },

    ['aluminum'] = {
        label = "Aluminium",
        weight = 100,
        stack = true,
        close = false,
        description = "Nice piece of metal that you can probably use for something",
        client = {
            image = "aluminum.png",
        }
    },

    ['microwave'] = {
        label = "Microwave",
        weight = 46000,
        stack = false,
        close = true,
        description = "Microwave",
        client = {
            image = "placeholder.png",
        }
    },

    ['pinger'] = {
        label = "Pinger",
        weight = 1000,
        stack = true,
        close = true,
        description = "With a pinger and your phone you can send out your location",
        client = {
            image = "pinger.png",
        }
    },

    ['diamond'] = {
        label = "Diamond",
        weight = 1000,
        stack = true,
        close = true,
        description = "A diamond seems like the jackpot to me!",
        client = {
            image = "diamond.png",
        }
    },

    ['casinochips'] = {
        label = "Casino Chips",
        weight = 0,
        stack = true,
        close = false,
        description = "Chips For Casino Gambling",
        client = {
            image = "casinochips.png",
        }
    },

    ['ironoxide'] = {
        label = "Iron Powder",
        weight = 100,
        stack = true,
        close = false,
        description = "Some powder to mix with.",
        client = {
            image = "ironoxide.png",
        }
    },

    ['kurkakola'] = {
        label = "Cola",
        weight = 500,
        stack = true,
        close = true,
        description = "For all the thirsty out there",
        client = {
            image = "cola.png",
        }
    },

    ['radioscanner'] = {
        label = "Radio Scanner",
        weight = 1000,
        stack = true,
        close = true,
        description = "With this you can get some police alerts. Not 100% effective however",
        client = {
            image = "radioscanner.png",
        }
    },

    ['twerks_candy'] = {
        label = "Twerks",
        weight = 100,
        stack = true,
        close = true,
        description = "Some delicious candy :O",
        client = {
            image = "twerks_candy.png",
        }
    },

    ['mastercard'] = {
        label = "Master Card",
        weight = 0,
        stack = false,
        close = false,
        description = "MasterCard can be used via ATM",
        client = {
            image = "mastercard.png",
        }
    },

    ['visa'] = {
        label = "Visa Card",
        weight = 0,
        stack = false,
        close = false,
        description = "Visa can be used via ATM",
        client = {
            image = "visa.png",
        }
    },

    ['tosti'] = {
        label = "Grilled Cheese Sandwich",
        weight = 200,
        stack = true,
        close = true,
        description = "Nice to eat",
        client = {
            image = "sandwich_grilledcheese.png",
        }
    },

    ['snikkel_candy'] = {
        label = "Snikkel",
        weight = 100,
        stack = true,
        close = true,
        description = "Some delicious candy :O",
        client = {
            image = "snikkel_candy.png",
        }
    },

    ['certificate'] = {
        label = "Certificate",
        weight = 0,
        stack = true,
        close = true,
        description = "Certificate that proves you own certain stuff",
        client = {
            image = "certificate.png",
        }
    },

    ['printerdocument'] = {
        label = "Document",
        weight = 500,
        stack = false,
        close = true,
        description = "A nice document",
        client = {
            image = "printerdocument.png",
        }
    },

    ['labkey'] = {
        label = "Key",
        weight = 500,
        stack = false,
        close = true,
        description = "Key for a lock...?",
        client = {
            image = "labkey.png",
        }
    },

    ['laptop'] = {
        label = "Laptop",
        weight = 4000,
        stack = true,
        close = true,
        description = "Expensive laptop",
        client = {
            image = "laptop.png",
        }
    },

    ['moneybag'] = {
        label = "Money Bag",
        weight = 0,
        stack = false,
        close = true,
        description = "A bag with cash",
        client = {
            image = "moneybag.png",
        }
    },

    ['samsungphone'] = {
        label = "Samsung S10",
        weight = 1000,
        stack = true,
        close = true,
        description = "Very expensive phone",
        client = {
            image = "samsungphone.png",
        }
    },

    ['tablet'] = {
        label = "Tablet",
        weight = 2000,
        stack = true,
        close = true,
        description = "Expensive tablet",
        client = {
            image = "tablet.png",
        }
    },

    ['police_stormram'] = {
        label = "Stormram",
        weight = 18000,
        stack = true,
        close = true,
        description = "A nice tool to break into doors",
        client = {
            image = "police_stormram.png",
        }
    },

    ['walkstick'] = {
        label = "Walking Stick",
        weight = 1000,
        stack = true,
        close = true,
        description = "Walking stick for ya'll grannies out there.. HAHA",
        client = {
            image = "walkstick.png",
        }
    },

    ['10kgoldchain'] = {
        label = "10k Gold Chain",
        weight = 2000,
        stack = true,
        close = true,
        description = "10 carat golden chain",
        client = {
            image = "10kgoldchain.png",
        }
    },

-- Avid-RP

['folded_cash'] = {
    label = 'Folded Cash',
    client = {
        image = "folded_cash.png",
    }
},
['rolled_cash'] = {
    label = 'Rolled Cash',
    client = {
        image = "rolled_cash.png",
    }
},
['artkeys'] = {
    label = 'Art Keys',
    description = "Faded words of : La Fuente Blanca on the back.",
    client = {
        image = "key2.png",
    }
},



    ['heavyarmor'] = {
        label = "Heavy Armor",
        weight = 5000,
        stack = true,
        close = true,
        description = "Some protection won't hurt... right?",
        client = {
            image = "armor.png",
        }
    },

    ['water_bottle'] = {
        label = "Bottle of Water",
        weight = 500,
        stack = true,
        close = true,
        description = "For all the thirsty out there",
        client = {
            image = "bottle.png",
        }
    },

    ['armor'] = {
        label = "Armor",
        weight = 5000,
        stack = true,
        close = true,
        description = "Some protection won't hurt... right?",
        client = {
            image = "armor.png",
        }
    },
['racing_gps'] = {
        label = "Racing GPS",
        weight = 500,
        stack = false,
        close = true,
        description = "",
        client = {
            image = "racing_gps.png",
        }
    },
['outfitbag'] = {
		label = 'Outfitbag',
		consume = 0,
		weight = 100,
        description = "Outfits on the go!",
		client = {
            image = "polbag.png",
			export = 'krs_outfitbag.outfitbag',
		}
	},
['backpack'] = {
		label = 'Backpack',
		weight = 220,
		stack = false,
		consume = 0,
		client = {
            image = "backpack.png",
			export = 'avid-backpack.openBackpack'
		}
	},
['parcel'] = {
		label = "Parcel",
		weight = 350,
		stack = false,
		close = true,
		consume = 0,
		description = "Small package filled with something.",
		client = {
			image = "parcel.png",
		},
		server = {
			export = 'avid-parceltheft.useParcel'
		}
	},
['small_explosive'] = {
        label = "Small Explosive Bomb",
        weight = 500,
        stack = false,
        close = true,
        description = "",
        client = {
            image = "small_explosive.png",
        }
    },
    ['broken_handcuffs'] = { label = "Broken handcuffs", weight = 100, stack = true, close = true, description = "It's broken, maybe you can repair it?", client = {image = "broken_handcuffs.png",}},
    ['cuffkeys'] = { label = "Cuff Keys", weight = 75, stack = true, close = true, description = "Set them free !", client = {image = "cuffkeys.png",}},
    ['ziptie'] = { label = "Ziptie", weight = 50, stack = true, close = true, description = "Comes in handy when people misbehave. Maybe it can be used for something else?", client = {image = "ziptie.png",}},
    ['flush_cutter'] = { label = "Flush Cutter", weight = 50, stack = true, close = true, description = "Comes in handy when you want to cut zipties..", client = {image = "flush_cutter.png",}},
    ['bolt_cutter'] = { label = "Bolt Cutter", weight = 50, stack = true, close = true, description = "Wanna cut some metal items ?", client = {image = "bolt_cutter.png",}},
    ['leo_gps'] = { label = "LEO GPS", weight = 200, stack = true, close = true, description = "Show your gps location to others", client = {image = "leo-gps.png",}},
    ['alcoholtester'] = { label = "Alcohol Tester", weight = 400, stack = false, close = true, description = "For testing purposes..", client = {image = "alcoholtester.png",}},

['spikestrip'] = {
        label = 'Spikestrip',
        weight = 25,
        stack = false,  -- Set to `true` if the item should stack in the inventory
        close = true,
        description = 'A spikestrip',
        client = {
            image = 'spikestrip.png',
            use = function(slot)
                TriggerEvent('avid-spikes:client:usespikestrip', slot)
            end
        },
    },

    -- Avid Weed add ons
['weed_lemonhaze_seed'] = {
    label = 'Lemonhaze Weed Seed',
    weight = 5,
    stack = true,
    close = true,
    client = {
        image = 'weed_seed.png',
        },
    },

['weed_bluedream_seed'] = {
        label = 'Blue Dream Weed Seed',
        weight = 5,
        stack = true,
        close = true,
        client = {
            image = 'weed_seed.png',
            },
        },

['weed_sourdiesel_seed'] = {
        label = 'Sour Diesel Weed Seed',
        weight = 5,
        stack = true,
        close = true,
        client = {
                image = 'weed_seed.png',
                },
        },

['weed_pinappleexpress_seed'] = {
        label = 'Pineapple Express Weed Seed',
        weight = 5,
        stack = true,
        close = true,
        client = {
                    image = 'weed_seed.png',
            },
        },     
        
['weed_whitewidow_seed'] = {
        label = 'White Widow Weed Seed',
        weight = 5,
        stack = true,
        close = true,
        client = {
        image = 'weed_seed.png',
            },
        }, 

['weed_lemonhaze'] = {
    label = 'Lemonhaze Bud',
    weight = 5,
    stack = true,
    close = true,
    client = {
        image = 'weed_bud.png',
    },
},

['weed_bluedream'] = {
    label = 'Blue Dream Bud',
    weight = 5,
    stack = true, 
    close = true, 
    client = {
        image = 'weed_bud.png',
    },
},

['weed_sourdiesel'] = {
    label = 'Sour Diesel Bud',
    weight = 5,
    stack = true, 
    close = true,
    client = {
        image = 'weed_bud.png',
    },
},

['weed_pinappleexpress'] = {
    label = 'Pineapple Express Bud',
    weight = 5,
    stack = true, 
    close = true, 
    client = {
        image = 'weed_bud.png',
    },
},

['weed_whitewidow'] = {
    label = 'White Widow Bud',
    weight = 5, 
    stack = true,
    close = true, 
    client = {
        image = 'weed_bud.png',
    },
},

['lemonhaze_joint'] = {
    label = 'Lemon Haze Joint',
    weight = 5, 
    stack = true, 
    close = true, 
    client = {
        image = 'lemonhaze.png',
    },
},

['bluedream_joint'] = {
    label = 'Blue Dream Joint',
    weight = 5, 
    stack = true, 
    close = true, 
    client = {
        image = 'bluedream.png',
    },
},

['sourdiesel_joint'] = {
    label = 'Sour Diesel Joint',
    weight = 5,
    stack = true, 
    close = true,
    client = {
        image = 'sourdiesel.png',
    },
},

['pineappleexpress_joint'] = {
    label = 'Pineapple Express Joint',
    weight = 5, 
    stack = true, 
    close = true, 
    client = {
        image = 'pineappleexpres.png',
    },
},

['whitewidow_joint'] = {
    label = 'White Widow Joint',
    weight = 5,
    stack = true, 
    close = true, 
    client = {
        image = 'whitewidow.png',
    },
},


    ['weed_brick'] = {
        label = "Weed Brick",
        weight = 1000,
        stack = true,
        close = true,
        description = "1KG Weed Brick to sell to large customers.",
        client = {
            image = "weed_brick.png",
        }
    },

    ['weed_og-kush_seed'] = {
        label = "OGKush Seed",
        weight = 0,
        stack = true,
        close = true,
        description = "A weed seed of OG Kush",
        client = {
            image = "weed_seed.png",
        }
    },

    ['weed_purple-haze_seed'] = {
        label = "Purple Haze Seed",
        weight = 0,
        stack = true,
        close = true,
        description = "A weed seed of Purple Haze",
        client = {
            image = "weed_seed.png",
        }
    },

    ['weed_skunk'] = {
        label = "Skunk 2g",
        weight = 200,
        stack = true,
        close = false,
        description = "A weed bag with 2g Skunk",
        client = {
            image = "weed_baggy.png",
        }
    },

    ['weed_ak47'] = {
        label = "AK47 2g",
        weight = 200,
        stack = true,
        close = false,
        description = "A weed bag with 2g AK47",
        client = {
            image = "weed_baggy.png",
        }
    },

    ['weed_amnesia'] = {
        label = "Amnesia 2g",
        weight = 200,
        stack = true,
        close = false,
        description = "A weed bag with 2g Amnesia",
        client = {
            image = "weed_baggy.png",
        }
    },

    ['weed_og-kush'] = {
        label = "OGKush 2g",
        weight = 200,
        stack = true,
        close = false,
        description = "A weed bag with 2g OG Kush",
        client = {
            image = "weed_baggy.png",
        }
    },

    ['weed_skunk_seed'] = {
        label = "Skunk Seed",
        weight = 0,
        stack = true,
        close = true,
        description = "A weed seed of Skunk",
        client = {
            image = "weed_seed.png",
        }
    },

    ['weed_white-widow_seed'] = {
        label = "White Widow Seed",
        weight = 0,
        stack = true,
        close = false,
        description = "A weed seed of White Widow",
        client = {
            image = "weed_seed.png",
        }
    },

    ['weed_amnesia_seed'] = {
        label = "Amnesia Seed",
        weight = 0,
        stack = true,
        close = true,
        description = "A weed seed of Amnesia",
        client = {
            image = "weed_seed.png",
        }
    },

    ['weed_ak47_seed'] = {
        label = "AK47 Seed",
        weight = 0,
        stack = true,
        close = true,
        description = "A weed seed of AK47",
        client = {
            image = "weed_seed.png",
        }
    },

    ['weed_nutrition'] = {
        label = "Plant Fertilizer",
        weight = 2000,
        stack = true,
        close = true,
        description = "Plant nutrition",
        client = {
            image = "weed_nutrition.png",
        }
    },

    ['weed_white-widow'] = {
        label = "White Widow 2g",
        weight = 200,
        stack = true,
        close = false,
        description = "A weed bag with 2g White Widow",
        client = {
            image = "weed_baggy.png",
        }
    },

    ['weed_purple-haze'] = {
        label = "Purple Haze 2g",
        weight = 200,
        stack = true,
        close = false,
        description = "A weed bag with 2g Purple Haze",
        client = {
            image = "weed_baggy.png",
        }
    },

['c4'] = {
        label = 'C4 Explosive',
        description = 'A powerful explosive, handle with caution.',
        weight = 1200,  -- weight in grams (adjust as needed)
        stack = true,
        close = true,
    },

-- Spray Items
['spraycan'] = {
    label = 'Spray Can',
    weight = 1000,
    stack = false,  -- `unique = true` implies no stacking
    close = true,   -- `shouldClose = true`
    description = 'Spray Can',
    client = {
        image = 'spraycan.png',
    },
    useable = true, -- Allows the item to be used
},

['sprayremover'] = {
    label = 'Spray Remover',
    weight = 100,
    stack = false,  -- `unique = true` implies no stacking
    close = true,   -- `shouldClose = true`
    description = 'Spray Remover',
    client = {
        image = 'sprayremover.png',
    },
    useable = true, -- Allows the item to be used
},
   
-- Avid-mining
['jackhammer'] = {
    label = 'Jack Hammer',
    weight = 10000,
    stack = false,
    close = true,
},
['pickaxe'] = {
    label = 'Pickaxe',
    weight = 2500,
    stack = false,
    close = true,
},
['shovel'] = {
    label = 'Shovel',
    weight = 1500,
    stack = false,
    close = true,
},

['full_bucket'] = {
    label = 'Full Bucket',
    weight = 1000,
    stack = true,
    close = false,
},
['empty_bucket'] = {
    label = 'Empty Bucket',
    weight =  500,
    stack = true,
    close = false,
},
['gem_rock'] = {
    label = 'Gem Rock',
    weight = 1,
    stack = true,
    close = false,
},
['ruby'] = {
    label = 'Ruby',
    weight = 0.1,
    stack = true,
    close = false,
},
['sapphire'] = {
    label = 'Sapphire',
    weight = 0.1,
    stack = true,
    close = false,
},
['emerald'] = {
    label = 'Emerald',
    weight = 0.1,
    stack = true,
    close = false,
},

--Pickle x Avid Crafting
-- Workbenches
['crafting_table'] = {
    label = 'Crafting Table',
    weight = 1,
    stack = true,
    description = '',
    client = {
        image = 'crafting_table.png',
    },
},

['drug_table'] = {
    label = 'Drug Table',
    weight = 1,
    stack = true,
    description = '',
    client = {
        image = 'drug_table.png',
    },
},

-- Blueprints
['blueprint_pistol'] = {
    label = 'Blueprint Pistol',
    weight = 1,
    stack = true,
    description = '',
    client = {
        image = 'pistol_blueprint.png',
    },
},

['blueprint_sns'] = {
    label = 'Blueprint SNS Pistol',
    weight = 1,
    stack = true,
    description = '',
    client = {
        image = 'sns_blueprint.png',
    },
},

['blueprint_ceramic'] = {
    label = 'Blueprint Ceramic Pistol',
    weight = 1,
    stack = true,
    description = '',
    client = {
        image = 'ceramic_blueprint.png',
    },
},

['armor_blueprint'] = {
    label = 'Heavy Armor Blueprint',
    weight = 1,
    stack = true,
    description = '',
    client = {
        image = 'armor_blueprint.png',
    },
},

['blueprint_smallexplosive'] = {
    label = 'Small Explosive Blueprint',
    weight = 1,
    stack = true,
    description = '',
    client = {
        image = 'smallexplosives_blueprint.png',
    },
},

['blueprint_c4'] = {
    label = 'C4 Explosive Blueprint',
    weight = 1,
    stack = true,
    description = '',
    client = {
        image = 'c4_blueprint.png',
    },
},

['blueprint_drill'] = {
    label = 'Large Drill Blueprint',
    weight = 1,
    stack = true,
    description = '',
    client = {
        image = 'drill_blueprint.png',
    },
},

-- Pistol Parts
['pistol_upper'] = {
    label = 'Pistol Upper',
    description = 'The upper receiver of a pistol, part of the firing mechanism.',
    weight = 500,
    stack = true,
    close = true,
    client = {
        image = 'p_upper.png',
    },
},

['pistol_lower'] = {
    label = 'Pistol Lower',
    description = 'The lower receiver of a pistol, connects the grip and magazine.',
    weight = 400,
    stack = true,
    close = true,
    client = {
        image = 'p_lower.png',
    },
},

['pistol_slide'] = {
    label = 'Pistol Slide',
    description = 'The slide of the pistol, essential for chambering rounds.',
    weight = 350,
    stack = true,
    close = true,
    client = {
        image = 'p_slide.png',
    },
},

['pistol_barrel'] = {
    label = 'Pistol Barrel',
    description = 'The barrel of the pistol, directs the projectile when fired.',
    weight = 300,
    stack = true,
    close = true,
    client = {
        image = 'p_barrel.png',
    },
},

['pistol_frame'] = {
    label = 'Pistol Frame',
    description = 'The frame of the pistol, holds the parts together.',
    weight = 600,
    stack = true,
    close = true,
    client = {
        image = 'p_frame.png',
    },
},

['pistol_trigger'] = {
    label = 'Pistol Trigger',
    description = 'The trigger of the pistol, initiates the firing sequence.',
    weight = 50,
    stack = true,
    close = true,
    client = {
        image = 'p_trigger.png',
    },
},


--origen_illegal
['packaged_weed'] = {
    label = '',
    weight = 100,
    stack = true,
    close = true,
},
['instant_camera'] = {
    label = 'Instant camera',
    weight = 0,
    stack = true,
    close = true,
},
['graffiti'] = {
    label = 'Graffiti',
    weight = 100,
    stack = true,
    close = true,
},
['graffiti_cleaner'] = {
    label = 'Graffiti cleaner',
    weight = 100,
    stack = true,
    close = true,
},
['mapterritories'] = {
    label = 'Territory map',
    weight = 100,
    stack = true,
    close = true,
},
['photo'] = {
    label = 'Photo',
    weight = 100,
    stack = false,
    close = true,
},
['ilegal_cad'] = {
    label = 'Tablet',
    weight = 100,
    stack = false,
    close = true,
},

-- avid-mining 
    ["lithium_ore"] = {
        label = "Lithium Ore",
        weight = 1000,
        stack = true,
        close = true,
        description = "Lithium Ore",
        client = {
            image = "lithium_ore.png",
        }
    },
      ["silverore"] = {
        label = "Silver Ore",
        weight = 1000,
        stack = true,
        close = true,
        description = "Silver Ore",
        client = {
            image = "silverore.png",
        }
    },
    ["copperore"] = {
        label = "Copper Ore",
        weight = 1000,
        stack = true,
        close = true,
        description = "Copper, a base ore.",
        client = {
            image = "copperore.png",
        }
    },
    ["goldore"] = {
        label = "Gold Ore",
        weight = 1000,
        stack = true,
        close = true,
        description = "Gold Ore",
        client = {
            image = "goldore.png",
        }
    },
    ["aluminumore"] = {
        label = "Aluminium Ore",
        weight = 100,
        stack = true,
        close = false,
        description = "Aluminum Ore",
        client = {
            image = "aluminumore.png",
        }
    },
    ["coal"] = {
        label = "Coal",
        weight = 1000,
        stack = true,
        close = true,
        description = "Coal",
        client = {
            image = "coal.png",
        }
    },
    ["ironore"] = {
        label = "Iron Ore",
        weight = 1000,
        stack = true,
        close = true,
        description = "Iron, a base ore.",
        client = {
            image = "ironore.png",
        }
    },
    ["uncut_emerald"] = {
        label = "Uncut Emerald",
        weight = 100,
        stack = true,
        close = true,
        description = "A rough Emerald",
        client = {
            image = "uncut_emerald.png",
        }
    },
    ["uncut_ruby"] = {
        label = "Uncut Ruby",
        weight = 100,
        stack = true,
        close = true,
        description = "A rough Ruby",
        client = {
            image = "uncut_ruby.png",
        }
    },
    ["uncut_diamond"] = {
        label = "Uncut Diamond",
        weight = 100,
        stack = true,
        close = true,
        description = "A rough Diamond",
        client = {
            image = "uncut_diamond.png",
        }
    },
    ["uncut_sapphire"] = {
        label = "Uncut Sapphire",
        weight = 100,
        stack = true,
        close = true,
        description = "A rough Sapphire",
        client = {
            image = "uncut_sapphire.png",
        }
    },
    ["goldingot"] = {
        label = "Gold Ingot",
        weight = 1000,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "goldingot.png",
        }
    },
    ["silveringot"] = {
        label = "Silver Ingot",
        weight = 1000,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "silveringot.png",
        }
    },
    ["copper"] = {
        label = "Copper",
        weight = 100,
        stack = true,
        close = false,
        description = "Nice piece of metal that you can probably use for something",
        client = {
            image = "copper.png",
        }
    },
    ["iron"] = {
        label = "Iron",
        weight = 100,
        stack = true,
        close = false,
        description = "Handy piece of metal that you can probably use for something",
        client = {
            image = "iron.png",
        }
    },
    ["steel"] = {
        label = "Steel",
        weight = 100,
        stack = true,
        close = false,
        description = "Nice piece of metal that you can probably use for something",
        client = {
            image = "steel.png",
        }
    },
    ["aluminum"] = {
        label = "Aluminium",
        weight = 100,
        stack = true,
        close = false,
        description = "Nice piece of metal that you can probably use for something",
        client = {
            image = "aluminum.png",
        }
    },
    ["glass"] = {
        label = "Glass",
        weight = 100,
        stack = true,
        close = false,
        description = "It is very fragile, watch out",
        client = {
            image = "glass.png",
        }
    },
    ["bottle"] = {
        label = "Empty Bottle",
        weight = 10,
        stack = true,
        close = true,
        description = "A glass bottle",
        client = {
            image = "bottle.png",
        }
    },
    ["can"] = {
        label = "Empty Can",
        weight = 10,
        stack = true,
        close = true,
        description = "An empty can, good for recycling",
        client = {
            image = "can.png",
        }
    },
    ["emerald"] = {
        label = "Emerald",
        weight = 100,
        stack = true,
        close = true,
        description = "An Emerald that shimmers",
        client = {
            image = "emerald.png",
        }
    },
    ["ruby"] = {
        label = "Ruby",
        weight = 100,
        stack = true,
        close = true,
        description = "A Ruby that shimmers",
        client = {
            image = "ruby.png",
        }
    },
    ["diamond"] = {
        label = "Diamond",
        weight = 100,
        stack = true,
        close = true,
        description = "A Diamond that shimmers",
        client = {
            image = "diamond.png",
        }
    },
    ["sapphire"] = {
        label = "Sapphire",
        weight = 100,
        stack = true,
        close = true,
        description = "A Sapphire that shimmers",
        client = {
            image = "sapphire.png",
        }
    },
    ["gold_ring"] = {
        label = "Gold Ring",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "gold_ring.png",
        }
    },
    ["diamond_ring"] = {
        label = "Diamond Ring",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "diamond_ring.png",
        }
    },
    ["ruby_ring"] = {
        label = "Ruby Ring",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "ruby_ring.png",
        }
    },
    ["sapphire_ring"] = {
        label = "Sapphire Ring",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "sapphire_ring.png",
        }
    },
    ["emerald_ring"] = {
        label = "Emerald Ring",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "emerald_ring.png",
        }
    },
    ["silver_ring"] = {
        label = "Silver Ring",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "silver_ring.png",
        }
    },
    ["diamond_ring_silver"] = {
        label = "Diamond Ring Silver",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "diamond_ring_silver.png",
        }
    },
    ["ruby_ring_silver"] = {
        label = "Ruby Ring Silver",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "ruby_ring_silver.png",
        }
    },
    ["sapphire_ring_silver"] = {
        label = "Sapphire Ring Silver",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "sapphire_ring_silver.png",
        }
    },
    ["emerald_ring_silver"] = {
        label = "Emerald Ring Silver",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "emerald_ring_silver.png",
        }
    },
    ["goldchain"] = {
        label = "Golden Chain",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "goldchain.png",
        }
    },
    ["pickaxe"] = {
        label = "Pickaxe",
        weight = 1000,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "pickaxe.png",
        }
    },
    ["miningdrill"] = {
        label = "Mining Drill",
        weight = 1000,
        stack = true,
        close = true,
        description = "",
        consume = 0.05,
        client = {
            image = "miningdrill.png",
        }
    },
    ["mininglaser"] = {
        label = "Mining Laser",
        weight = 900,
        stack = true,
        close = true,
        description = "",
        consume = 0.1,
        client = {
            image = "mininglaser.png",
        }
    },
    ["drillbit"] = {
        label = "Drill Bit",
        weight = 10,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "drillbit.png",
        }
    },
    ["diamond_necklace"] = {
        label = "Diamond Necklace",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "diamond_necklace.png",
        }
    },
    ["ruby_necklace"] = {
        label = "Ruby Necklace",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "ruby_necklace.png",
        }
    },
    ["sapphire_necklace"] = {
        label = "Sapphire Necklace",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "sapphire_necklace.png",
        }
    },
    ["emerald_necklace"] = {
        label = "Emerald Necklace",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "emerald_necklace.png",
        }
    },
    ["silverchain"] = {
        label = "Silver Chain",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "silverchain.png",
        }
    },
    ["diamond_necklace_silver"] = {
        label = "Diamond Necklace Silver",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "diamond_necklace_silver.png",
        }
    },
    ["ruby_necklace_silver"] = {
        label = "Ruby Necklace Silver",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "ruby_necklace_silver.png",
        }
    },
    ["sapphire_necklace_silver"] = {
        label = "Sapphire Necklace Silver",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "sapphire_necklace_silver.png",
        }
    },
    ["emerald_necklace_silver"] = {
        label = "Emerald Necklace Silver",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "emerald_necklace_silver.png",
        }
    },
    ["goldearring"] = {
        label = "Golden Earrings",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "gold_earring.png",
        }
    },
    ["diamond_earring"] = {
        label = "Diamond Earrings",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "diamond_earring.png",
        }
    },
    ["ruby_earring"] = {
        label = "Ruby Earrings",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "ruby_earring.png",
        }
    },
    ["sapphire_earring"] = {
        label = "Sapphire Earrings",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "sapphire_earring.png",
        }
    },
    ["emerald_earring"] = {
        label = "Emerald Earrings",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "emerald_earring.png",
        }
    },
    ["silverearring"] = {
        label = "Silver Earrings",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "silver_earring.png",
        }
    },
    ["diamond_earring_silver"] = {
        label = "Diamond Earrings Silver",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "diamond_earring_silver.png",
        }
    },
    ["ruby_earring_silver"] = {
        label = "Ruby Earrings Silver",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "ruby_earring_silver.png",
        }
    },
    ["sapphire_earring_silver"] = {
        label = "Sapphire Earrings Silver",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "sapphire_earring_silver.png",
        }
    },
    ["emerald_earring_silver"] = {
        label = "Emerald Earrings Silver",
        weight = 200,
        stack = true,
        close = true,
        description = "",
        client = {
            image = "emerald_earring_silver.png",
        }
    },

    ["head_bag"] = {
        label = "Head Bag",
        weight = 20,
        stack = false,
        close = true,
        description = "",
        client = {
            image = "head_bag.png",
        }
    },

---- RENEWED-VEHICLEKEYS----
['vehiclekey'] = {
	label = 'Vehicle Key'
},

['keyring'] = {
	label = 'Key Ring',
	weight = 1,
	stack = false,
	close = false,
	consume = 0
},

-- Heist Key and Key Cards -- 
['artkey'] = {
    label = 'Art Key',
    weight = 20,
    stack = false, 
    close = false,
    consume = 1.0,
    client = {
        image = "artkey.png",
    }
},

}