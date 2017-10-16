####################
###   by jpark   ###
####################

from os.path import join, dirname
from app import app
from tornado.ioloop import IOLoop
from tornado.wsgi import WSGIContainer
import tornado.web
# from tornado.web import FallbackHandler, RequestHandler, Application, StaticFileHandler
from tornado.options import define, options, parse_command_line

define("port", default=5000, help="run on the given port", type=int)

import logging
logging.basicConfig(filename='./{0}.log'.format(app.config["DATABASE_NAME"]), level=logging.DEBUG)
tr = WSGIContainer(app)

class Application(tornado.web.Application):
    def __init__(self):
        handlers = [
            (r"/www/(.*)", tornado.web.StaticFileHandler, {'path': 'www/'}),
            (r"/(.*)", tornado.web.FallbackHandler, dict(fallback=tr))
        ]
        settings = {
            "debug":app.config["DEBUG"]
        }
        tornado.web.Application.__init__(self, handlers, **settings)


if __name__ == "__main__":
    options.parse_command_line()
    print("="*50)
    print("initializing program with port : ", options.port)
    print("="*50)
    application = Application()
    application.listen(options.port, address="0.0.0.0")
    IOLoop.instance().start()
