FROM mcr.microsoft.com/dotnet/sdk:8.0.403 as build
WORKDIR /app
COPY . .
RUN dotnet restore
RUN dotnet build -c Release --no-restore
RUN dotnet publish -c Release --no-restore --no-build -o publish

FROM mcr.microsoft.com/dotnet/aspnet:9.0.0 as runtime
WORKDIR /app
COPY --from=build /app/publish /app
CMD [ "dotnet", "CircleCIDemo.dll" ]