EDITABLE = {}

---@return boolean
EDITABLE.CanOpenMDT = function()
    return not LocalPlayer.state.dead and not LocalPlayer.state.isHandcuffed
end