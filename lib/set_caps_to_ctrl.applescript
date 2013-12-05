tell application "System Preferences"
  activate
  reveal pane "Keyboard"
end tell

tell application "System Events" to tell process "System Preferences" to tell window "Keyboard"
  click button "Modifier Keys…" of tab group 1
  tell sheet 1
    -- if more than one keyboard is plugged in, an extra pop up button is shown
    if (name of every pop up button) contains "Select keyboard:" then
      set btn to pop up button "Select keyboard:"
      tell btn
        click
        set kbds to (every menu item of menu 1)
        key code 53 -- escape (to close pop up)

        repeat with kbd in kbds
          click btn
          click kbd
          my set_caps_lock_to_control()
        end repeat

      end tell
    else
      my set_caps_lock_to_control()
    end if

    click button "OK"
  end tell
end tell

quit application "System Preferences"

on set_caps_lock_to_control()
  tell application "System Events" to tell process "System Preferences" to tell window "Keyboard" to tell sheet 1
    tell pop up button "Caps Lock (⇪) Key:"
      click
      click menu item "⌃ Control" of menu 1
    end tell
  end tell
end set_caps_lock_to_control
