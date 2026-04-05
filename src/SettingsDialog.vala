public class ProMan.SettingsDialog : Granite.Dialog {
    private Gtk.Switch dark_mode_switch;
    private Gtk.Switch auto_terminal_switch;
    private Gtk.Switch confirm_delete_switch;
    private Settings settings;
    
    public SettingsDialog (Gtk.Window parent) {
        Object (
            transient_for: parent,
            modal: true,
            title: "Settings",
            default_width: 450,
            default_height: 300
        );
    }
    
    construct {
        settings = Settings.get_default ();
        
        var content = new Gtk.Box (Gtk.Orientation.VERTICAL, 12) {
            margin_top = 12,
            margin_bottom = 12,
            margin_start = 12,
            margin_end = 12
        };
        
        // Dark Mode
        var dark_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
        var dark_label = new Gtk.Label ("Dark Mode") {
            halign = Gtk.Align.START,
            hexpand = true
        };
        dark_mode_switch = new Gtk.Switch ();
        dark_mode_switch.active = settings.dark_mode;
        dark_mode_switch.notify["active"].connect (() => {
            settings.dark_mode = dark_mode_switch.active;
            settings.save ();
        });
        dark_box.append (dark_label);
        dark_box.append (dark_mode_switch);
        
        // Auto Open Terminal
        var terminal_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
        var terminal_label = new Gtk.Label ("Auto-open terminal after launch") {
            halign = Gtk.Align.START,
            hexpand = true
        };
        auto_terminal_switch = new Gtk.Switch ();
        auto_terminal_switch.active = settings.auto_open_terminal;
        auto_terminal_switch.notify["active"].connect (() => {
            settings.auto_open_terminal = auto_terminal_switch.active;
            settings.save ();
        });
        terminal_box.append (terminal_label);
        terminal_box.append (auto_terminal_switch);
        
        // Confirm Delete
        var confirm_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
        var confirm_label = new Gtk.Label ("Confirm before deleting projects") {
            halign = Gtk.Align.START,
            hexpand = true
        };
        confirm_delete_switch = new Gtk.Switch ();
        confirm_delete_switch.active = settings.confirm_delete;
        confirm_delete_switch.notify["active"].connect (() => {
            settings.confirm_delete = confirm_delete_switch.active;
            settings.save ();
        });
        confirm_box.append (confirm_label);
        confirm_box.append (confirm_delete_switch);
        
        // Info label
        var info_label = new Gtk.Label ("Settings are saved automatically") {
            halign = Gtk.Align.CENTER,
            margin_top = 20
        };
        info_label.add_css_class ("dim-label");
        
        content.append (dark_box);
        content.append (terminal_box);
        content.append (confirm_box);
        content.append (info_label);
        
        // Close button
        var close_btn = new Gtk.Button.with_label ("Close");
        close_btn.add_css_class ("suggested-action");
        close_btn.clicked.connect (() => close ());
        
        var action_area = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6) {
            halign = Gtk.Align.END,
            margin_top = 12
        };
        action_area.append (close_btn);
        content.append (action_area);
        
        child = content;
    }
}
