FROM python:3.12-alpine

# App Path
ARG APP_PATH="/opt/app"

# Create Directory for App
RUN mkdir -p "${APP_PATH}"

# Change Directory
WORKDIR "${APP_PATH}"

# Copy Sources
COPY app/ "${APP_PATH}"

# Copy other Files
COPY README.md "${APP_PATH}"

# Install required Packages
RUN --mount=type=cache,mode=0777,target=/var/lib/pip,sharing=locked \
    pip install --cache-dir /var/lib/pip -r "${APP_PATH}/requirements.txt"

# Export Web Port
EXPOSE 5000

# Execute Script for Installation and Initialization of App
CMD ["python", "-u", "app.py"]

# Entrypoint does NOT work with python images
# You need Alpine/Debian/... or other "full-OS" images for that to work
#COPY docker-entrypoint.sh /opt/
#RUN chmod +x /opt/docker-entrypoint.sh
#ENTRYPOINT ["/opt/docker-entrypoint.sh"]
