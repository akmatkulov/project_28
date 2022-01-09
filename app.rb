#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
	@db = SQLite3::Database.new 'leprosorium.db'
	@db.results_as_hash = true
end

# before вызывается каждый раз при перезагрузке
# любой страницы
before do
	# инициализация БД
	init_db
end

# configure вызывается каждый раз при конфигурации приложения
# когда изменился код программы И перезагрузилась страница
configure do
	# инициализация БД
	init_db
	# создает таблицу в БД если таблицы не существует
	@db.execute 'CREATE TABLE IF NOT EXISTS Posts
							(
								id INTEGER PRIMARY KEY AUTOINCREMENT,
								created_date DATE,
								content TEXT
								)'
end

get '/' do
	erb "Hello!"
end

# обработчик get - запроса /new
# (браузер получает странцу с сервера)
get '/new' do
  erb :new
end

# обработчик post - запроса /new
# (браузер отправляет данные на сервер)
post '/new' do
	content = params[:content]

	erb "You typed: #{content}"

end
