-- colorizer hexes and color names and stuff
-- norcalli/nvim-colorizer.lua is unmaintained; catgoose's fork is the
-- actively developed continuation and is a drop-in replacement
return {
  'catgoose/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup()
  end
}
