public class ProMan.MainWindow : Gtk.ApplicationWindow {
    private ProjectManager manager;
    private Gtk.ListBox listbox;
    private Gtk.Label placeholder;
    private Gtk.Stack stack;
    private Settings settings;

    public MainWindow (Gtk.Application app) {
        Object (
            application: app,
            title: "Project Manager",
            default_width: 700,
            default_height: 500
        );
    }

    construct {
        settings = Settings.get_default ();
        manager = new ProjectManager ();
        manager.projects_changed.connect (refresh_list);

        var header = new Gtk.HeaderBar () {
            show_title_buttons = true
        };
        
        var add_btn = new Gtk.Button.from_icon_name ("list-add-symbolic");
        add_btn.tooltip_text = "Add Project";
        add_btn.clicked.connect (on_add_clicked);
        header.pack_end (add_btn);
        
        var settings_btn = new Gtk.Button.from_icon_name ("preferences-system-symbolic");
        settings_btn.tooltip_text = "Settings";
        settings_btn.clicked.connect (() => {
            var dialog = new SettingsDialog (this);
            dialog.present ();
        });
        header.pack_end (settings_btn);
        
        set_titlebar (header);

        listbox = new Gtk.ListBox () {
            selection_mode = Gtk.SelectionMode.NONE,
            valign = Gtk.Align.START,
            vexpand = true
        };
        listbox.add_css_class ("boxed-list");

        placeholder = new Gtk.Label ("No projects added yet.\nClick + to add your first project.") {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER,
            justify = Gtk.Justification.CENTER,
            wrap = true
        };
        placeholder.add_css_class ("dim-label");

        var scrolled = new Gtk.ScrolledWindow () {
            child = listbox,
            vexpand = true
        };

        stack = new Gtk.Stack ();
        stack.add_named (scrolled, "list");
        stack.add_named (placeholder, "placeholder");
        stack.set_visible_child_name ("placeholder");

        child = stack;

        refresh_list ();
    }

    private void refresh_list () {
        // Clear existing rows
        Gtk.Widget? child = listbox.get_first_child ();
        while (child != null) {
            var next = child.get_next_sibling ();
            listbox.remove (child);
            child = next;
        }

        var projects = manager.get_projects ();
        if (projects.is_empty ()) {
            stack.set_visible_child_name ("placeholder");
            return;
        }
        stack.set_visible_child_name ("list");

        // Sort projects by last opened (most recent first)
        projects.sort ((a, b) => {
            if (b.last_opened > a.last_opened) return 1;
            if (b.last_opened < a.last_opened) return -1;
            return 0;
        });

        foreach (var project in projects) {
            var row = new ProjectRow (project);
            row.open_file_manager.connect (() => {
                Utils.open_in_file_manager (project.path);
                manager.touch_project (project);
                refresh_list ();
            });
            row.open_terminal.connect (() => {
                Utils.open_in_terminal (project.path);
                manager.touch_project (project);
                refresh_list ();
            });
            row.edit.connect (() => show_edit_dialog (project));
            row.delete.connect (() => {
                if (settings.confirm_delete) {
                    confirm_delete (project);
                } else {
                    manager.remove_project (project);
                }
            });
            listbox.append (row);
        }
    }

    private void on_add_clicked () {
        var dialog = new NewProjectDialog (this);
        dialog.present ();
        dialog.response.connect ((response) => {
            if (dialog.project != null) {
                manager.add_project (dialog.project);
            }
            dialog.destroy ();
        });
    }

    private void show_edit_dialog (Project old_project) {
        var dialog = new NewProjectDialog (this);
        dialog.title = "Edit Project";
        dialog.set_initial_values (old_project.name, old_project.path);
        dialog.present ();
        dialog.response.connect ((response) => {
            if (dialog.project != null) {
                manager.update_project (old_project, dialog.project);
            }
            dialog.destroy ();
        });
    }

    private void confirm_delete (Project project) {
        var dialog = new Granite.MessageDialog.with_image_from_icon_name (
            "Delete Project?",
            "Are you sure you want to remove '%s' from the list?".printf (project.name),
            "dialog-warning"
        );
        dialog.transient_for = this;
        dialog.add_button ("Cancel", Gtk.ResponseType.CANCEL);
        dialog.add_button ("Delete", Gtk.ResponseType.OK);
        
        dialog.response.connect ((response) => {
            if (response == Gtk.ResponseType.OK) {
                manager.remove_project (project);
            }
            dialog.destroy ();
        });
        dialog.present ();
    }
}
