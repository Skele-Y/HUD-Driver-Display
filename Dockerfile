FROM skelec/driver-displays-x-compile:testing
ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir /opt/atlassian /opt/atlassian/pipelines /opt/atlassian/pipelines/agent /opt/atlassian/pipelines/agent/build
RUN ls /usr/local/lib && ls /usr/local/include
WORKDIR /opt/atlassian/pipelines/agent/build
COPY ../. .
RUN /app/ARMqtinstall/bin/qt-cmake -B ddPiBuild .
RUN cd ddPiBuild && cmake --build . --parallel $(nproc) && cmake --install .