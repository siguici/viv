module viv

import veb
import siguici.vite { Vite }
import siguici.envig { Envig }

@[params]
pub struct AppConfig {
pub mut:
	secret_key string
	vite       Vite  = Vite.new()
	config     Envig = Envig.new()
}

pub struct App {
	veb.StaticHandler
pub:
	secret_key string
mut:
	vite   Vite
	config Envig
}

pub fn App.new() &App {
	return new_app()
}

pub fn new_app(config AppConfig) &App {
	mut app := &App{
		secret_key: config.secret_key
		vite:       config.vite
		config:     config.config
	}
	return app
}

pub fn run[T, U](port int) ! {
	mut app := T.new()

	app.handle_static('public', true)!

	veb.run[T, U](mut app, port)
}
