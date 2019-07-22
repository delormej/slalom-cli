FROM microsoft/dotnet:2.1-sdk AS build
ENV VSS_NUGET_EXTERNAL_FEED_ENDPOINTS="{'endpointCredentials': [{'endpoint':'https://pkgs.dev.azure.com/jasondel/_packaging/SlalomTracker/nuget/v3/index.json', 'password':'zdkrbk4vjy4pficjrgycqkwrjwdmjnpx5lisyqc7upo3pug7jwoa'}]}"

# Install Video Processing Libraries in FFMPEG
#RUN apt update && \
#    apt install ffmpeg -y

COPY ./ /ski
WORKDIR /ski/
RUN dotnet restore -s https://pkgs.dev.azure.com/jasondel/_packaging/SlalomTracker/nuget/v3/index.json

# Build and publish skiconsole, ensure that the metadata extractor (gpmfdemo) has execute permissions
# Set to build a self-contained linux binary (no dotnet required).
# use -r linux-musl-x64 to target alpine
# if using alpine, we need to recompile gpmfdemo
RUN dotnet publish /ski/SkiConsole/SkiConsole.csproj --self-contained true -r linux-x64 -o /ski/bin && \
    chmod +x gpmfdemo

# Alpline looks like smallest, but gpmfdemo needs to be rebuilt for it
#apk add build-base


#FROM debian AS runtime
#ENV SKIBLOBS=${ski_blobs_connection}
# Opt out of globalization: https://github.com/dotnet/core/blob/master/Documentation/self-contained-linux-apps.md
#ENV CORECLR_GLOBAL_INVARIANT=1
# Install Video Processing Libraries 
#RUN apt-get update && \
#    apt-get install ffmpeg -y
#WORKDIR /ski
#COPY --from=build /ski/bin .
