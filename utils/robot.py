import logging
from werobot import WeRoBot
from blog.settings import APP_ID, APP_SECRET, APP_TOKEN
logger = logging.getLogger(__name__)
robot = WeRoBot(enable_session=False,
                token=APP_TOKEN,
                APP_ID=APP_ID,
                APP_SECRET=APP_SECRET)


@robot.handler
def hello(message):
    logger.info(message)
    return 'Hello world'
