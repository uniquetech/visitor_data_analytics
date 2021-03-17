FROM amazonlinux:2.0.20201218.1

# Setup Python
RUN amazon-linux-extras install epel -y
RUN yum install python37 python37-pip python3-devel -y
RUN python3 -m pip install --upgrade pip

# Copy files
WORKDIR application
COPY /app /application/app
COPY /requirements.txt /application

# Install dependencies
RUN python3 -m pip install -r requirements.txt

ENV PYTHONPATH "${PYTHONPATH}:/application/app"

WORKDIR /application/app

#CMD python3 application.py