module viv

import veb { RunParams }
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

pub fn make_app[A]() A {
	mut params := AppParams{}
	mut app := A{
		secret_key: params.secret_key
		vite:       params.vite
		config:     params.config
	}

	return app
}

fn handle_app[A](mut app A) ! {
	$if A is veb.StaticHandler {
		app.handle_static('public', true)!
	}
}

pub fn run[A, X](port int) ! {
	mut app := make_app[A]()

	run_app[A, X](mut app, port)!
}

@[direct_array_access; manualfree]
pub fn run_at[A, X](params RunParams) ! {
	mut app := make_app[A]()

	run_app_at[A, X](mut app, params)!
}

pub fn run_app[A, X](mut app A, port int) ! {
	handle_app[A](mut app)!

	veb.run[A, X](mut app, port)
}

@[direct_array_access; manualfree]
pub fn run_app_at[A, X](mut app A, params RunParams) ! {
	handle_app[A](mut app)!

	veb.run_at[A, X](mut app, params)
}
