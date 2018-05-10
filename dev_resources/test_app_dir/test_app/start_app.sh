#!/bin/bash

java -jar target/spring-cloud-consul-1.0.0-SNAPSHOT-spring-boot.jar --spring.config.location="$(dirname $0)/config/application.properties"
