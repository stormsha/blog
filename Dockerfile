FROM python:3.6

WORKDIR /opt/
ADD ./requirements.txt .
ADD ./sources.list /etc/apt/sources.list
RUN apt update \
    && pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

ADD . .

ENTRYPOINT ["/bin/bash", "/opt/docker-entrypoint.sh"]
