FROM mcr.microsoft.com/dotnet/sdk:3.1 AS builder
WORKDIR /app

# Copy source into container
COPY . .

# Publish into executable
RUN dotnet publish \
        --configuration Release \
        --output output \
        CloudRunDemo.csproj

# Build the final runtime image
FROM mcr.microsoft.com/dotnet/aspnet:3.1
WORKDIR /app

ENV ASPNETCORE_URLS=http://*:3000
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false

COPY --from=builder /app/output .

ENTRYPOINT ["dotnet", "CloudRunDemo.dll"]