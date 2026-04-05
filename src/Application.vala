public class ProMan.Application : Gtk.Application {
    public Application () {
        Object (
            application_id: Config.APP_ID,
            flags: ApplicationFlags.DEFAULT_FLAGS
        );
    }

    protected override void activate () {
        var win = new ProMan.MainWindow (this);
        win.present ();
    }

    public static int main (string[] args) {
        var app = new ProMan.Application ();
        return app.run (args);
    }
}
