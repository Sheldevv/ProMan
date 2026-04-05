namespace ProMan.Utils {
    public void open_in_file_manager (string path) {
        try {
            // Use xdg-open directly with proper quoting
            string[] argv = { "xdg-open", path };
            Process.spawn_async ("/", argv, null, SpawnFlags.SEARCH_PATH, null, null);
        } catch (Error e) {
            warning ("Failed to open file manager: %s", e.message);
        }
    }

    public void open_in_terminal (string path) {
        string[] argv = {};
        
        // Check for common terminals
        string[] terminals = {
            "io.elementary.terminal",
            "gnome-terminal",
            "xfce4-terminal",
            "kitty",
            "alacritty",
            "tilix",
            "terminator"
        };
        
        string terminal = "";
        foreach (string term in terminals) {
            var term_path = GLib.Environment.find_program_in_path (term);
            if (term_path != null) {
                terminal = term;
                break;
            }
        }
        
        if (terminal == "") {
            warning ("No terminal found");
            return;
        }
        
        if (terminal == "io.elementary.terminal") {
            argv = { "io.elementary.terminal", "-w", path };
        } else if (terminal == "gnome-terminal") {
            argv = { "gnome-terminal", "--working-directory", path };
        } else if (terminal == "xfce4-terminal") {
            argv = { "xfce4-terminal", "--working-directory", path };
        } else {
            argv = { terminal, "--working-directory", path };
        }
        
        try {
            Process.spawn_async ("/", argv, null, SpawnFlags.SEARCH_PATH, null, null);
        } catch (Error e) {
            warning ("Failed to open terminal: %s", e.message);
        }
    }
}
