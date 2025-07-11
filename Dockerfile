FROM dart:stable AS dart-base

# Install Flutter SDK manually
RUN apt-get update && \
    apt-get install -y curl git unzip xz-utils zip libglu1-mesa && \
    git clone https://github.com/flutter/flutter.git /usr/local/flutter && \
    /usr/local/flutter/bin/flutter doctor

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Enable flutter web
RUN flutter config --enable-web

WORKDIR /app

COPY . .

RUN flutter pub get

CMD ["flutter", "run", "-d", "web-server", "--web-hostname=0.0.0.0", "--web-port=5000"]
