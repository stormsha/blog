from werobot import WeRoBot
from blog.settings import APP_ID, APP_SECRET, APP_TOKEN
robot = WeRoBot(enable_session=False,
                token=APP_TOKEN,
                APP_ID=APP_ID,
                APP_SECRET=APP_SECRET)


@robot.handler
def hello(message):
    return 'Hello world'
