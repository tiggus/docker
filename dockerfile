# FROM Create a new build stage from a base image. AS names the stage
FROM mcr.microsoft.com/dotnet/sdk:8.0-jammy AS build
# Arg is a build time variable
ARG BUILD_CONFIGURATION=Release