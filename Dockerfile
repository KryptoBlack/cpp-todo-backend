FROM ubuntu:20.04

# Setting up builder environment
ENV ROOT_DIR=/usr/builder
ENV APPLICATION_DIR=${ROOT_DIR}/application
ENV CROW_SOURCE_URL="https://github.com/CrowCpp/Crow.git"
ENV SQLPP_SOURCE_URL="https://github.com/rbock/sqlpp11.git"

# Installing source
WORKDIR ${ROOT_DIR}
COPY . .

# Setting Timezone for lib tzdata
# https://grigorkh.medium.com/fix-tzdata-hangs-docker-image-build-cdb52cc3360d
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Installing dependencies
RUN apt-get update 
RUN apt-get install -y g++ libboost-all-dev cmake git \
  build-essential libtcmalloc-minimal4 && ln -s /usr/lib/libtcmalloc_minimal.so.4 /usr/lib/libtcmalloc_minimal.so

# Setup Crow
RUN git clone ${CROW_SOURCE_URL}
RUN cd Crow && mkdir build && cd build && pwd
RUN cmake ./Crow -DCROW_BUILD_EXAMPLES=OFF -DCROW_BUILD_TESTS=OFF
RUN make install

# Setup SQLPP
RUN git clone ${SQLPP_SOURCE_URL}
RUN cmake ./sqlpp11 -B build -DBUILD_SQLITE3_CONNECTOR=ON -DDEPENDENCY_CHECK=OFF -DBUILD_TESTING=OFF
RUN cmake --build build --target install

WORKDIR ${APPLICATION_DIR}

ENTRYPOINT [ "sh", "entrypoint.sh" ]