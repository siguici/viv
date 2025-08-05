module viv

import veb
import siguici.vite { Vite }
import siguici.envig { Envig }

pub struct App {
	veb.StaticHandler
pub:
	secret_key string
mut:
	vite   Vite  = Vite.new()
	config Envig = Envig.new()
}

pub fn new_app() &App {
	mut app := &App{
		vite:   Vite.new()
		config: Envig.new()
	}
	return app
}

pub fn run[T, U](mut app T, port int) ! {
	app.handle_static('public', true)!

	veb.run[T, U](mut app, port)
}
