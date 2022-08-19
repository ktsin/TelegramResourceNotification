FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["TelegramResourceNotification/TelegramResourceNotification.csproj", "TelegramResourceNotification/"]
RUN dotnet restore "TelegramResourceNotification/TelegramResourceNotification.csproj"
COPY . .
WORKDIR "/src/TelegramResourceNotification"
RUN dotnet build "TelegramResourceNotification.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "TelegramResourceNotification.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/runtime:6.0
WORKDIR /app
EXPOSE 6000
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TelegramResourceNotification.dll"]
