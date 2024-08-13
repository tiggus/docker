# FROM Create a new build stage from a base image. AS names the stage
FROM mcr.microsoft.com/dotnet/sdk:8.0@sha256:35792ea4ad1db051981f62b313f1be3b46b1f45cadbaa3c288cd0d3056eefb83 AS build-env
WORKDIR /build

# Copy everything
RUN pwd
RUN ls
COPY . ./
RUN ls -la

# Restore as distinct layers
RUN dotnet restore "./dotnet/DotNet.Docker.csproj"


# Build and publish a release
RUN dotnet publish "./dotnet/DotNet.Docker.csproj" -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0@sha256:6c4df091e4e531bb93bdbfe7e7f0998e7ced344f54426b7e874116a3dc3233ff
WORKDIR /build
COPY --from=build-env /build/out .
ENTRYPOINT ["dotnet", "DotNet.Docker.dll"]

