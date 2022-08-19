﻿FROM mcr.microsoft.com/dotnet/runtime:6.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["TelegramResourceNotification/TelegramResourceNotification.csproj", "TelegramResourceNotification/"]
RUN dotnet restore "TelegramResourceNotification/TelegramResourceNotification.csproj"
COPY . .
WORKDIR "/src/TelegramResourceNotification"
RUN dotnet build "TelegramResourceNotification.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "TelegramResourceNotification.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TelegramResourceNotification.dll"]
