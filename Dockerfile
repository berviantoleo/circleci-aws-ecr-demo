FROM mcr.microsoft.com/dotnet/sdk:8.0.402 as build
WORKDIR /app
COPY . .
RUN dotnet restore
RUN dotnet build -c Release --no-restore
RUN dotnet publish -c Release --no-restore --no-build -o publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0.8 as runtime
WORKDIR /app
COPY --from=build /app/publish /app
CMD [ "dotnet", "CircleCIDemo.dll" ]