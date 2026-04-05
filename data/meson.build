i18n = import('i18n')

desktop_conf = configuration_data()
desktop_conf.set('APP_ID', app_id)

desktop_file = configure_file(
    input: 'online.sheldi.proman.desktop.in',
    output: 'online.sheldi.proman.desktop',
    configuration: desktop_conf,
    install: true,
    install_dir: join_paths(get_option('datadir'), 'applications')
)

appstream_file = configure_file(
    input: 'online.sheldi.proman.metainfo.xml.in',
    output: 'online.sheldi.proman.metainfo.xml',
    configuration: desktop_conf,
    install: true,
    install_dir: join_paths(get_option('datadir'), 'metainfo')
)

# Install GSettings schema
install_data(
    'online.sheldi.proman.gschema.xml',
    install_dir: join_paths(get_option('datadir'), 'glib-2.0/schemas')
)

# Install icons in multiple sizes
install_data(
    'icons/16.svg',
    install_dir: join_paths(get_option('datadir'), 'icons/hicolor/16x16/apps'),
    rename: 'online.sheldi.proman.svg'
)

install_data(
    'icons/24.svg',
    install_dir: join_paths(get_option('datadir'), 'icons/hicolor/24x24/apps'),
    rename: 'online.sheldi.proman.svg'
)

install_data(
    'icons/32.svg',
    install_dir: join_paths(get_option('datadir'), 'icons/hicolor/32x32/apps'),
    rename: 'online.sheldi.proman.svg'
)

install_data(
    'icons/48.svg',
    install_dir: join_paths(get_option('datadir'), 'icons/hicolor/48x48/apps'),
    rename: 'online.sheldi.proman.svg'
)

install_data(
    'icons/64.svg',
    install_dir: join_paths(get_option('datadir'), 'icons/hicolor/64x64/apps'),
    rename: 'online.sheldi.proman.svg'
)

install_data(
    'icons/128.svg',
    install_dir: join_paths(get_option('datadir'), 'icons/hicolor/128x128/apps'),
    rename: 'online.sheldi.proman.svg'
)

# Also install scalable version
install_data(
    'icons/online.sheldi.proman.svg',
    install_dir: join_paths(get_option('datadir'), 'icons/hicolor/scalable/apps')
)
