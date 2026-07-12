# GTA IV Auto-Cutoff Watcher

Scripts to automatically stop a GTA IV session after a set amount of time and lock the game from reopening, until manually unlocked.

## Files
- `gta_watcher.bat` — background loop that detects the game process, waits N minutes, then force-kills and renames the .exe.
- `gta_watcher.vbs` — silent wrapper so the watcher runs with no visible console window.
- `gta_unlock.bat` — restores the game's original .exe name so you can play again.

## Setup on a new PC

1. **Find your game's real process name.**
   Launch GTA IV, open Task Manager (`Ctrl+Shift+Esc`) → Details tab, and note the exact process name and folder (right-click → Open file location).

2. **Edit the settings** at the top of `gta_watcher.bat`:
   ```
   set EXENAME=GTAIV.exe        <- exact process name from step 1
   set GAMEPATH=C:\Path\To\GTAIV  <- folder from step 1
   set LOCKEDNAME=GTAIV_locked.exe
   set MINUTES=40                <- how long before it cuts off
   ```

3. **Edit the path** inside `gta_watcher.vbs` to match wherever you put `gta_watcher.bat` on this PC, e.g.:
   ```
   WshShell.Run "C:\Scripts\gta_watcher.bat", 0, False
   ```

4. **Edit the same GAMEPATH/EXENAME/LOCKEDNAME** at the top of `gta_unlock.bat` so it can restore the file later.

5. **Put the folder somewhere permanent**, e.g. `C:\Scripts\`.

6. **Add to Windows Startup:**
   - Press `Win + R`, type `shell:startup`, Enter.
   - Right-click → New → Shortcut → point it at `gta_watcher.vbs`.
   - Now it runs silently and automatically every time you log in.

7. **Test it** with `MINUTES=1` first to confirm it actually detects, kills, and renames correctly. Then set it back to your real value (e.g. 40).

## To play again after it locks
Run `gta_unlock.bat`. It renames the .exe back so the game can launch normally.

## Notes
- If your Ankergames build uses a separate launcher .exe in front of the real game .exe, you may need to add a second kill/rename block for that process too.
- This only works while the watcher is running in the background (i.e. after you've logged into Windows at least once with the startup shortcut in place).
