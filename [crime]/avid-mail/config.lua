Config = {}
Config.Maxdistance = 1.4

Config.Animations = {
    Breakin = {
        dict = 'melee@large_wpn@streamed_core',
        clip = 'ground_attack_on_spot'
    },
    MailOpen = {
        dict = 'clothingtie',
        clip = 'try_tie_neutral_b',
        prop = 'prop_cash_envelope_01'
    }
}

Config.Hammer = {
    failMultiplier = 2, --multiplier for failed decay on the hammer
    decay = {1, 3}, -- min,max amount of durability to remove the hammer
    item = 'weapon_hammer',
    label = 'Hammer'
}


Config.Reward = {
    am = {1, 5}, -- min, max amount of an item to give
    mailRewardChance = 25, -- chance the usable item "mail" gives a reward such as a creditcard
    multiReward = true
}

Config.Mailboxes = {
    `prop_postbox_ss_01a`,
    `prop_postbox_01a`,
    `prop_letterbox_01`,
    `prop_letterbox_02`,
    `prop_letterbox_03`,
    `prop_letterbox_04`
}



Config.Locales = {
    ['noweapon'] = 'You need something to break it open..',
    ['new_equip'] = 'This isn\'t a mail opener..',
    ['robbed'] = 'The mailbox already seems broken..',
    ['breaking'] = 'Breaking..',
    ['initrob'] = 'Break Into..',
    ['mail'] = 'Opening mail..',
    ['durability'] = 'Hammer\'s durability seems too low..'

}