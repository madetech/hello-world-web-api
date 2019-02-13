FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 5000

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src

RUN mkdir HelloWorldWebApi
COPY HelloWorldWebApi/HelloWorldWebApi.csproj HelloWorldWebApi/
COPY HelloWorldWebApi.sln ./
RUN dotnet restore HelloWorldWebApi/HelloWorldWebApi.csproj

COPY . .
WORKDIR /src/HelloWorldWebApi
RUN dotnet build HelloWorldWebApi.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish HelloWorldWebApi.csproj -c Release -o /app

FROM base AS final
ENV ASPNETCORE_URLS=http://+:5000
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "HelloWorldWebApi.dll"]
