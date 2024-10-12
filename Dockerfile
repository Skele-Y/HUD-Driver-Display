FROM skelec/driver-displays-x-compile:latest
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get install zip
RUN mkdir /opt/atlassian /opt/atlassian/pipelines /opt/atlassian/pipelines/agent /opt/atlassian/pipelines/agent/build

WORKDIR /opt/atlassian/pipelines/agent/build

COPY ../. .
RUN /app/ARMqtinstall/bin/qt-cmake -B ddPiBuild .
RUN cd ddPiBuild && cmake --build . --parallel $(nproc) && cmake --install .

RUN zip driver-displays.zip driver-displays config/config.json config/gradient.png config/SensorBus.dbc config/TractiveBus.dbc

ENTRYPOINT ["bash"]