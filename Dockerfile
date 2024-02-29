# Base image with Android SDK and necessary dependencies
FROM openjdk:11-jdk

# Set environment variables
ENV ANDROID_COMPILE_SDK=30
ENV ANDROID_BUILD_TOOLS=30.0.3
ENV ANDROID_SDK_ROOT=/opt/android-sdk-linux
ENV ENV PATH=${PATH}:${ANDROID_SDK_ROOT}/cmdline-tools/bin:${ANDROID_SDK_ROOT}/platform-tools


# Install System Dependencies
RUN apt-get --quiet update --yes && \
    apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 && \
    apt-get install -y curl unzip bash

# Download and install Android SDK command-line tools
RUN mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools && \
    curl -o sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip && \
    unzip sdk.zip -d ${ANDROID_SDK_ROOT}/cmdline-tools && \
    rm sdk.zip

# Accept Android SDK licenses
RUN yes | ${ANDROID_SDK_ROOT}/cmdline-tools/bin/sdkmanager --licenses

# Install necessary Android SDK components
RUN ${ANDROID_SDK_ROOT}/cmdline-tools/bin/sdkmanager "platforms;android-30" "build-tools;30.0.3"    

# Copy the Android project files to the container
COPY . /app

# Set the working directory
WORKDIR /app

# Build the Android application
RUN ./gradlew clean assembleDebug
