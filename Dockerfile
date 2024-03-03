FROM python:3.12-alpine
RUN mkdir /opt/app
WORKDIR /opt/app
COPY requirements.txt requirements.txt
#RUN apk add rrdtool

# Change Shell
#RUN chsh -s /bin/bash root
RUN export SHELL="/bin/bash"
RUN ln -sf /bin/bash /bin/sh

# set ENV to execute startup scripts
ENV ENV /etc/profile

# Create venv
RUN python3 -m venv venv

# Set PATH Variable to include venv
ENV PATH="/opt/app/venv/bin:$PATH"

# Activate venv
#RUN source venv/bin/activate

# Install required Packages
RUN pip install -r requirements.txt

# Export Web Port
EXPOSE 5000

# Copy and Execute Script for Installation and Initialization of App
#COPY . .
COPY app/* .
COPY README.md .
CMD ["python", "-u", "app.py"]

# Entrypoint does NOT work with python images
# You need Alpine/Debian/... or other "full-OS" images for that to work
#COPY docker-entrypoint.sh /opt/
#RUN chmod +x /opt/docker-entrypoint.sh
#ENTRYPOINT ["/opt/docker-entrypoint.sh"]
