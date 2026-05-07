#!/bin/bash
docker build --no-cache -t localhost:5000/hlds-cs1.6 /hp/hlds
docker push localhost:5000/hlds-cs1.6

