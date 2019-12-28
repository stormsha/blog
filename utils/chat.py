import werobot

robot = werobot.WeRoBot(token='wxa019dc749dfbb148')


@robot.handler
def echo(message):
    return 'Hello World!'


robot.config['HOST'] = '0.0.0.0'
robot.config['PORT'] = 8082
robot.run()
