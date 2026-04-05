public class ProMan.ProjectRow : Gtk.ListBoxRow {
    public Project project { get; private set; }
    private Gtk.Label name_label;
    private Gtk.Label path_label;

    public signal void open_file_manager ();
    public signal void open_terminal ();
    public signal void edit ();
    public signal void delete ();

    public ProjectRow (Project project) {
        this.project = project;
        var grid = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12) {
            margin_top = 6,
            margin_bottom = 6,
            margin_start = 12,
            margin_end = 12
        };

        var info_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 4);
        name_label = new Gtk.Label (project.name) {
            halign = Gtk.Align.START,
            xalign = 0
        };
        name_label.add_css_class ("heading");
        path_label = new Gtk.Label (project.path) {
            halign = Gtk.Align.START,
            xalign = 0,
            tooltip_text = project.path
        };
        path_label.add_css_class ("dim-label");
        info_box.append (name_label);
        info_box.append (path_label);

        var button_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6) {
            halign = Gtk.Align.END,
            hexpand = true
        };

        var fm_btn = new Gtk.Button.from_icon_name ("folder-open-symbolic");
        fm_btn.tooltip_text = "Open in File Manager";
        fm_btn.clicked.connect (() => open_file_manager ());

        var term_btn = new Gtk.Button.from_icon_name ("utilities-terminal-symbolic");
        term_btn.tooltip_text = "Open in Terminal";
        term_btn.clicked.connect (() => open_terminal ());

        var edit_btn = new Gtk.Button.from_icon_name ("edit-symbolic");
        edit_btn.tooltip_text = "Edit Project";
        edit_btn.clicked.connect (() => edit ());

        var del_btn = new Gtk.Button.from_icon_name ("user-trash-symbolic");
        del_btn.add_css_class ("destructive-action");
        del_btn.tooltip_text = "Delete Project";
        del_btn.clicked.connect (() => delete ());

        button_box.append (fm_btn);
        button_box.append (term_btn);
        button_box.append (edit_btn);
        button_box.append (del_btn);

        grid.append (info_box);
        grid.append (button_box);
        child = grid;
    }

    public void update_from_project () {
        name_label.label = project.name;
        path_label.label = project.path;
    }
}
