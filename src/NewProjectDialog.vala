public class ProMan.NewProjectDialog : Granite.Dialog {
    private Gtk.Entry name_entry;
    private Gtk.Button choose_button;
    private Gtk.Label path_label;
    private string selected_path = "";

    public Project? project { get; private set; }

    public NewProjectDialog (Gtk.Window parent) {
        Object (
            transient_for: parent,
            modal: true,
            title: "Add Project",
            default_width: 400
        );
    }

    construct {
        name_entry = new Gtk.Entry ();
        name_entry.placeholder_text = "Project Name";

        choose_button = new Gtk.Button.with_label ("Choose Folder");
        path_label = new Gtk.Label (null) {
            halign = Gtk.Align.START,
            ellipsize = Pango.EllipsizeMode.MIDDLE
        };
        path_label.add_css_class ("dim-label");
        path_label.label = "No folder selected";

        choose_button.clicked.connect (() => {
            var file_dialog = new Gtk.FileDialog ();
            file_dialog.select_folder.begin (this, null, (obj, res) => {
                try {
                    var file = file_dialog.select_folder.end (res);
                    if (file != null) {
                        selected_path = file.get_path ();
                        path_label.label = selected_path;
                    }
                } catch (Error e) {
                    warning ("Failed to select folder: %s", e.message);
                }
            });
        });

        var content = new Gtk.Box (Gtk.Orientation.VERTICAL, 12) {
            margin_top = 12,
            margin_bottom = 12,
            margin_start = 12,
            margin_end = 12
        };
        content.append (name_entry);
        
        var path_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
        path_box.append (choose_button);
        path_box.append (path_label);
        content.append (path_box);

        var cancel_btn = new Gtk.Button.with_label ("Cancel");
        var add_btn = new Gtk.Button.with_label ("Add");
        add_btn.add_css_class ("suggested-action");

        cancel_btn.clicked.connect (() => close ());
        add_btn.clicked.connect (on_add_clicked);

        var action_area = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6) {
            halign = Gtk.Align.END,
            margin_top = 12
        };
        action_area.append (cancel_btn);
        action_area.append (add_btn);

        content.append (action_area);
        child = content;
    }

    public void set_initial_values (string name, string path) {
        name_entry.set_text (name);
        selected_path = path;
        path_label.label = path;
    }

    private void on_add_clicked () {
        string name = name_entry.get_text ().strip ();
        string path = selected_path;
        if (name == "" || path == "") {
            var dialog = new Granite.MessageDialog.with_image_from_icon_name (
                "Missing information",
                "Please provide both a name and a folder.",
                "dialog-warning"
            );
            dialog.transient_for = this;
            dialog.add_button ("OK", Gtk.ResponseType.OK);
            dialog.present ();
            return;
        }
        project = new Project (name, path);
        close ();
    }
}
