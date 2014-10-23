local plugin = {}

local misc = require('crappy.misc')
local pluginManager = require("crappy.pluginManager")

plugin.name = 'Familar Alt-Tab'
plugin.description = 'Integrate familiar Alt-Tab functionality in Awesome WM'
plugin.id = 'alttab'
plugin.requires = {}
plugin.provides = {"crappy.functions.global"}
plugin.functions = {
   ["alttab.start"] = {
      class = "global",
      description = "Integrate familiar Alt-Tab functionality in Awesome WM",
   },
}

function plugin.settingsDefault(settings)
   if settings.modifier == nil then
      settings.modifier = "Alt_L"
   end

   if settings.next == nil then
      settings.next = "Tab"
   end

   if settings.prev == nil then
      settings.prev = "ISO_Left_Tab"
   end

   return settings
end

function plugin.startup(awesomever, settings)
   local alttab = require('alttab')

   plugin.settingsDefault(settings)

   plugin.functions["alttab"].func = function()
      alttab(1, settings.modifier, settings.next, settings.prev)
   end
end

function plugin.buildUi(window, settings, log)
   local lgi = require 'lgi'
   local Gtk = lgi.require('Gtk')

   plugin.settingsDefault(settings)

   local modifierEntry = Gtk.Entry {
      hexpand = true,
   }

   modifierEntry:set_text(settings.modifier)

   function modifierEntry:on_changed()
      settings.modifier = modifierEntry:get_text()
   end

   local nextEntry = Gtk.Entry {
      hexpand = true,
   }

   nextEntry:set_text(settings.next)

   function nextEntry:on_changed()
      settings.next = nextEntry:get_text()
   end

   local prevEntry = Gtk.Entry {
      hexpand = true,
   }

   prevEntry:set_text(settings.prev)

   function prevEntry:on_changed()
      settings.prev = prevEntry:get_text()
   end

   local row = -1;
   local function nextRow()
      row = row + 1
      return row
   end

   return Gtk.Grid {
      row_spacing = 6,
      column_spacing = 6,
      margin = 6,
      expand = true,

      {
         left_attach = 0, top_attach = nextRow(),
         Gtk.Label {
            label = '_Modifier key name:',
            use_underline = true,
            mnemonic_widget = modifierEntry
         },
      },
      {
         left_attach = 1, top_attach = row,
         modifierEntry
      },
      {
         left_attach = 0, top_attach = nextRow(),
         Gtk.Label {
            label = '_Next window key name:',
            use_underline = true,
            mnemonic_widget = nextEntry
         },
      },
      {
         left_attach = 1, top_attach = row,
         nextEntry
      },
      {
         left_attach = 0, top_attach = nextRow(),
         Gtk.Label {
            label = '_Previous window key name:',
            use_underline = true,
            mnemonic_widget = prevEntry
         },
      },
      {
         left_attach = 1, top_attach = row,
         prevEntry
      },
   }
end

return plugin
