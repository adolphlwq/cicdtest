FROM python:2.7
MAINTAINER adolphlwq kenan3015@gmail.com

WORKDIR /opt/app
ADD . /opt/app
RUN pip install -r requirements.txt
EXPOSE 5000
CMD ["python", "hello.py"]
