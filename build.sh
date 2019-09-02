#!/bin/bash
#VSS_NUGET_EXTERNAL_FEED_ENDPOINTS="{'endpointCredentials': [{'endpoint':'https://pkgs.dev.azure.com/jasondel/_packaging/SlalomTracker/nuget/v3/index.json', 'password':'zdkrbk4vjy4pficjrgycqkwrjwdmjnpx5lisyqc7upo3pug7jwoa'}]}"
#docker build -t skiconsole -f Dockerfile --build-arg nuget=\"$VSS_NUGET_EXTERNAL_FEED_ENDPOINTS\" .

#
# This file used for DEBUG build
#
rm -rf ref
mkdir -p ref/ 
cp -r ../SlalomTracker/bin/Debug/* ./ref/
docker build -t skiconsole -f Dockerfile .
#
# Launch debug container
#
SKIBLOBS="DefaultEndpointsProtocol=https;AccountName=skivideostorage;AccountKey=74gV///fVtd/ZL+PzXZU6nsOVzIvt6XC59T9elFnY91vCVqmitlHxNA9QLbQsedTmnCzSR0BhtL0J8dwOVSWvA==;EndpointSuffix=core.windows.net"
docker run -it --rm -e SKIBLOBS=\"$SKIBLOBS\" --name ski-dbg skiconsole /bin/bash
