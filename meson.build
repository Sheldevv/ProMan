project('online.sheldi.proman', 'vala', version: '0.1.0')

app_id = 'online.sheldi.proman'
version = meson.project_version()

# Dependencies - look for granite-7 explicitly
gtk4_dep = dependency('gtk4')
granite_dep = dependency('granite-7', version: '>=7.0.0')
json_glib_dep = dependency('json-glib-1.0')
gee_dep = dependency('gee-0.8')
gio_dep = dependency('gio-2.0')

deps = [gtk4_dep, granite_dep, json_glib_dep, gee_dep, gio_dep]

subdir('src')
subdir('data')
subdir('po')
