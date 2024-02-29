# Base image with Android SDK and necessary dependencies
FROM openjdk:11-jdk

# Set environment variables
ENV ANDROID_COMPILE_SDK=30
ENV ANDROID_BUILD_TOOLS=30.0.3
ENV ANDROID_SDK_ROOT=/opt
ENV ENV PATH=${PATH}:${ANDROID_SDK_ROOT}/cmdline-tools/bin:${ANDROID_SDK_ROOT}/platform-tools


# Install System Dependencies
RUN apt-get --quiet update --yes && \
    apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 && \
    apt-get install -y curl unzip bash

# Download and install Android SDK command-line tools
RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip && \
    unzip android-sdk.zip -d ${ANDROID_SDK_ROOT}


