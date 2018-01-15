FROM circleci/android:api-23-node8-alpha

USER circleci

# Install Android sdk tools
RUN sdkmanager \
  "build-tools;23.0.2" \
  "platforms;android-23" \
  "platforms;android-19" \
  "platforms;android-17" \
  "add-ons;addon-google_apis-google-17" \
  "add-ons;addon-google_apis-google-19" \
  "add-ons;addon-google_apis-google-23" \
  "system-images;android-19;google_apis;armeabi-v7a"

# Create Android AVD
RUN echo 'no' | avdmanager create avd \
  --force \
  --name api19 \
  --tag google_apis \
  --abi armeabi-v7a \
  -k 'system-images;android-19;google_apis;armeabi-v7a'

# Set up node 7.4.0
RUN sudo npm install n -g
RUN sudo n 7.4.0
RUN sudo ln -sf /usr/local/bin/node /usr/bin/node
RUN sudo apt-get purge -y nodejs

# Export JAVA_BIN
ENV PATH $PATH:$JAVA_HOME/bin

# Install Appium 1.5.3
RUN sudo npm install -g appium@1.5.3 \
  appium-doctor
RUN appium-doctor --android
