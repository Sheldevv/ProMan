public class ProMan.Settings : Object {
    private GLib.Settings settings;
    private static Settings? instance = null;
    
    public bool dark_mode { get; set; }
    public bool auto_open_terminal { get; set; }
    public bool confirm_delete { get; set; }
    
    public static Settings get_default () {
        if (instance == null) {
            instance = new Settings ();
        }
        return instance;
    }
    
    private Settings () {
        settings = new GLib.Settings (Config.APP_ID);
        
        // Bind properties
        settings.bind ("dark-mode", this, "dark_mode", SettingsBindFlags.DEFAULT);
        settings.bind ("auto-open-terminal", this, "auto_open_terminal", SettingsBindFlags.DEFAULT);
        settings.bind ("confirm-delete", this, "confirm_delete", SettingsBindFlags.DEFAULT);
        
        // Apply dark mode setting
        notify["dark-mode"].connect (() => {
            apply_dark_mode ();
        });
        
        apply_dark_mode ();
    }
    
    private void apply_dark_mode () {
        var gtk_settings = Gtk.Settings.get_default ();
        if (gtk_settings != null) {
            gtk_settings.gtk_application_prefer_dark_theme = dark_mode;
        }
    }
    
    public void save () {
        settings.set_boolean ("dark-mode", dark_mode);
        settings.set_boolean ("auto-open-terminal", auto_open_terminal);
        settings.set_boolean ("confirm-delete", confirm_delete);
        GLib.Settings.sync ();
    }
}
