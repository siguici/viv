module viv

import veb
import siguici.vite { Vite }
import siguici.envig { Envig }

@[params]
pub struct AppParams {
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

pub fn new_app(params AppParams) &App {
	mut app := &App{
		secret_key: params.secret_key
		vite:       params.vite
		config:     params.config
	}
	return app
}

pub fn run[T, U](port int) ! {
	mut params := AppParams{}
	mut app := T{
		secret_key: params.secret_key
		vite:       params.vite
		config:     params.config
	}

	app.handle_static('public', true)!

	veb.run[T, U](mut app, port)
}
