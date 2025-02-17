FROM mcr.microsoft.com/dotnet/sdk:9.0.102 as build
WORKDIR /app
COPY . .
RUN dotnet restore
RUN dotnet build -c Release --no-restore
RUN dotnet publish -c Release --no-restore --no-build -o publish

FROM mcr.microsoft.com/dotnet/aspnet:9.0.2 as runtime
WORKDIR /app
COPY --from=build /app/publish /app
CMD [ "dotnet", "CircleCIDemo.dll" ]