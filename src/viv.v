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

pub fn run[A, X](port int) ! {
	mut params := AppParams{}
	mut app := A{
		secret_key: params.secret_key
		vite:       params.vite
		config:     params.config
	}

	run_app[A, X](mut app, port)!
}

pub fn run_app[A, X](mut app A, port int) ! {
	app.handle_static('public', true)!

	veb.run[A, X](mut app, port)
}
