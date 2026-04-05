public class ProMan.ProjectManager : Object {
    private const string CONFIG_DIR = "online.sheldi.proman";
    private const string PROJECTS_FILE = "projects.json";

    private List<Project> projects;
    private string file_path;

    public signal void projects_changed ();

    public ProjectManager () {
        projects = new List<Project> ();
        string config_dir = Path.build_path (
            Path.DIR_SEPARATOR_S,
            Environment.get_user_config_dir (),
            CONFIG_DIR
        );
        file_path = Path.build_path (Path.DIR_SEPARATOR_S, config_dir, PROJECTS_FILE);
        load ();
    }

    private void load () {
        var file = File.new_for_path (file_path);
        if (!file.query_exists ()) return;

        try {
            var dis = new DataInputStream (file.read ());
            string json_str = "";
            string line;
            while ((line = dis.read_line (null)) != null) {
                json_str += line;
            }
            var parser = new Json.Parser ();
            parser.load_from_data (json_str);
            var root = parser.get_root ().get_array ();
            for (int i = 0; i < root.get_length (); i++) {
                var obj = root.get_object_element (i);
                projects.append (Project.deserialize (obj));
            }
            projects_changed ();
        } catch (Error e) {
            warning ("Failed to load projects: %s", e.message);
        }
    }

    public void save () {
        var array = new Json.Array ();
        foreach (var p in projects) {
            array.add_object_element (p.serialize ());
        }
        var root = new Json.Node (Json.NodeType.ARRAY);
        root.set_array (array);
        var generator = new Json.Generator ();
        generator.set_root (root);
        generator.set_pretty (true);

        try {
            string dir = Path.get_dirname (file_path);
            var dir_file = File.new_for_path (dir);
            if (!dir_file.query_exists ())
                dir_file.make_directory_with_parents ();

            var file = File.new_for_path (file_path);
            var os = file.replace (null, false, FileCreateFlags.NONE);
            generator.to_stream (os, null);
        } catch (Error e) {
            warning ("Failed to save projects: %s", e.message);
        }
    }

    public List<Project> get_projects () {
        var copy = new List<Project> ();
        foreach (var p in projects) {
            copy.append (p);
        }
        return copy;
    }

    public void add_project (Project project) {
        projects.append (project);
        save ();
        projects_changed ();
    }

    public void remove_project (Project project) {
        projects.remove (project);
        save ();
        projects_changed ();
    }

    public void update_project (Project old_project, Project new_project) {
        old_project.name = new_project.name;
        old_project.path = new_project.path;
        save ();
        projects_changed ();
    }

    public void touch_project (Project project) {
        project.last_opened = new DateTime.now_utc ().to_unix ();
        save ();
        projects_changed ();
    }
}
