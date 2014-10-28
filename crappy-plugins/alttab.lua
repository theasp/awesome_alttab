local lgi = require('lgi')

local plugin = {
   name = 'Familar Alt-Tab',
   description = 'Integrate familiar Alt-Tab functionality in Awesome WM',
   id = 'alttab',
   requires = {},
   provides = {"crappy.functions.global"},
   functions = {
      ["alttab.start"] = {
         class = "global",
         description = "Integrate familiar Alt-Tab functionality in Awesome WM",
      },
   },
   options = {
      {
         name = 'modifier',
         label = '_Modifier key name:',
         type = 'string'
      },
      {
         name = 'next',
         label = '_Next window key name:',
         type = 'string'
      },
      {
         name = 'prev',
         label = '_Previous window key name:',
         type = 'string'
      }
   },
   defaults = {
      modifier = "Alt_L",
      next = "Tab",
      prev = "ISO_Left_Tab"
   }
}

local log = lgi.log.domain(plugin.id)

function plugin.startup(awesomever, settings)
   alttab = require('alttab')

   plugin.functions["alttab.start"].func = function()
      alttab(1, settings.modifier, settings.next, settings.prev)
   end
end

return plugin
