config_data = configuration_data()
config_data.set('APP_ID', app_id)
config_data.set('VERSION', version)
config_data.set('DATADIR', join_paths(get_option('prefix'), get_option('datadir')))

config_vala = configure_file(
    input: 'Config.vala.in',
    output: 'Config.vala',
    configuration: config_data
)

sources = [
    config_vala,
    'Application.vala',
    'MainWindow.vala',
    'Project.vala',
    'ProjectManager.vala',
    'ProjectRow.vala',
    'NewProjectDialog.vala',
    'Settings.vala',
    'SettingsDialog.vala',
    'Utils.vala'
]

executable(
    app_id,
    sources,
    dependencies: deps,
    install: true
)
