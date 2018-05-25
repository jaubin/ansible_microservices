#!/bin/bash

java -jar "$(dirname $0)/target/spring-cloud-consul-spring-boot.jar" --spring.config.location="$(dirname $0)/config/application.properties"
