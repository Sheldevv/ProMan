namespace ProMan {
    public class Project : Object {
        public string name { get; set; }
        public string path { get; set; }
        public int64 last_opened { get; set; }

        public Project (string name, string path) {
            this.name = name;
            this.path = path;
            this.last_opened = 0;
        }

        public Json.Object serialize () {
            var obj = new Json.Object ();
            obj.set_string_member ("name", name);
            obj.set_string_member ("path", path);
            obj.set_int_member ("last_opened", last_opened);
            return obj;
        }

        public static Project deserialize (Json.Object obj) {
            var p = new Project (
                obj.get_string_member ("name"),
                obj.get_string_member ("path")
            );
            p.last_opened = obj.get_int_member ("last_opened");
            return p;
        }
    }
}
