FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

# Set the locale
ENV LANG en_GB.UTF-8

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY HelloWorldWebApi/HelloWorldWebApi.csproj HelloWorldWebApi/

RUN dotnet restore HelloWorldWebApi/HelloWorldWebApi.csproj
COPY . .
WORKDIR /src
RUN dotnet build HelloWorldWebApi/HelloWorldWebApi.csproj -c Release -o /app/release

FROM build AS publish
RUN dotnet publish HelloWorldWebApi/HelloWorldWebApi.csproj -c Release -o /app/release

FROM base AS final
WORKDIR /app
COPY --from=publish /app/release .
ENTRYPOINT ["dotnet", "HelloWorldWebApi.dll"]
