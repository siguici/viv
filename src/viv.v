module viv

import veb
import siguici.vite { Vite }
import siguici.envig { Envig }

const port = 8082
const config = Envig.new()

pub struct Context {
	veb.Context
}

pub struct App {
	veb.StaticHandler
	veb.Middleware[Context]
pub:
	secret_key string
mut:
	vite   Vite
	config Envig
}

pub fn App.new() &App {
	mut app := &App{
		vite:   Vite.new()
		config: config
	}
	return app
}

pub fn (mut ctx Context) not_found() veb.Result {
	ctx.res.set_status(.not_found)
	return ctx.html('<h1>Page not found!</h1>')
}

pub fn (app App) before_request(mut ctx Context) {
	println('[veb] before_request: ${ctx.req.method} ${ctx.req.url}')
}

pub fn run_app[T, U](mut app T) ! {
	app.handle_static('public', true)!

	veb.run[T, U](mut app, port)
}
