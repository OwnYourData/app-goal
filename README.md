# <img src="https://github.com/OwnYourData/app-goal/raw/master/www/app_logo.png" width="92"> Tägliches Ziel

Peter Thiel’s Strategie: Setze dir täglich genau ein Ziel und prüfe ob du es erreichst. Mit dieser App bekommst du jeden Morgen ein Mail zugesandt, das du mit deinem Ziel für diesen Tag beantwortest. Gleichzeitig siehst du, welche Ziele du dir die letzten 3 Tage gesetzt hast und du kannst prüfen, wie erfolgreich zu mit deinen Vorhaben bist.

Mehr Infos, Screenshots und Demo: https://www.ownyourdata.eu/apps/taegliches-ziel/

### Dein Datentresor
Die Tägliches Ziel-App wird in einem sicheren Datentresor installiert. Üblicherweise musst du deine Daten an die Betreiber von Webservices und Apps weitergeben, um diese nutzen zu können. OwnYourData dreht den Spieß jedoch um: Du behältst all deine Daten und du verwahrst sie in deinem eigenen Datentresor. Apps (Datensammlung, Algorithmen und Visualisierung) holst du zu dir, in den Datentresor hinein.

Mehr Infos und Demo: https://www.ownyourdata.eu  
Hintergrund-Infos für Entwickler: https://www.ownyourdata.eu/developer/

&nbsp;    

## Installation

Du kannst entscheiden wo du deinen Datentresor einrichten und deine Apps installieren möchtest: auf deinem persönlichen OwnYourData-Server, auf einem anderen Cloud-Dienst deiner Wahl, auf deinem eigenen Computer oder auf einem Raspberry Pi bei dir daheim.

### Installation am OwnYourData-Server

Diese Installation ist am einfachsten: Fordere deinen Datentresor an: https://www.ownyourdata.eu, öffne den Datentresor und klicke im *OwnYourData App Store* bei Tägliches Ziel auf "Install".

### Installation bei Cloud Diensten

Verschiedene Cloud Dienste bieten das Hosting von [Docker](https://www.docker.com) Containern an, z.B. https://sloppy.io oder https://elastx.se. Die Tägliches Ziel-App steht als Docker-Image unter dem Namen `oydeu/app-goal` auf Dockerhub hier zur Verfügung: https://hub.docker.com/r/oydeu/app-goal/.    
Starte den Container und verbinde dich im Konfigurations-Dialog mit deinem Datentresor.

### Installation am eigenen Computer/Laptop

Um die Tägliches Ziel-App am eigenen Computer auszuführen, musst du zuerst [eine aktuelle Version von Docker installieren](https://www.docker.com/community-edition#/download). Starte dann die Tägliches Ziel-App mit folgendem Befehl:  
`docker run -p 3838:3838 oydeu/app-goal`  
Du kannst dann auf die App mit deinem Browser unter folgender Adresse zugreifen:  
`http://192.168.99.100:3838`  
  
*Anmerkungen:*  
* wenn du mehrere Apps verwendest, musst du unterschiedliche Ports verwenden  
  `docker run -p 1234:3838 oydeu/app-goal` und `http://192.168.99.100:1234`
* Docker vergibt die IP-Adresse auf deinem Computer unter der du auf die Container zugreifen kannst. Verwende folgenden Befehl, um die tatsächliche IP-Adresse festzustellen: `docker-machine ip`  
* in diesem Blog-Artikel wird ausführlich die Installation einer App am eigenen PC beschrieben: [Ein Container voller Daten](https://www.ownyourdata.eu/2016/09/26/ein-container-voller-daten/)

### Installation am Raspberry Pi

Die Tägliches Ziel-App steht auch für die Architektur armhf zur Verfügung. Die Installation erfolgt dann wie am Computer/Laptop jedoch unter Verwendung des Docker Image `oydeu/app-goal_armhf`.  
  
*Anmerkungen:*  
* Tägliches Ziel-App auf Dockerhub: https://hub.docker.com/r/oydeu/app-goal_armhf/  
* zur einfachen Installation von Docker am Raspberry empfehlen wir die SD-Card Images von Hypriot: http://blog.hypriot.com/downloads/
* Befehl zum Start des Containers am Raspberry: `docker run -p 3838:3838 oydeu/app-goal_armhf`

&nbsp;    

## Datenstruktur

Die folgenden Listen werden von der Tägliches Ziel-App verwendet:

* tägliches Ziel    
    - `date`: Datum im Format YYYY-MM-DD    
    - `value`: Beschreibung des Ziel des Tages    
* Scheduler, Scheduler Verlauf und Scheduler Status  - siehe [service-scheduler](https://github.com/OwnYourData/service-scheduler)  
* Info - Informationen zum Datentresor

&nbsp;    

## Verbessere die Tägliches Ziel-App

Bitte melde Fehler oder Vorschläge für neue Features / UX-Verbesserungen im [GitHub Issue-Tracker](https://github.com/OwnYourData/app-goal/issues) und halte dich dabei an die [Contributor Guidelines](https://github.com/twbs/ratchet/blob/master/CONTRIBUTING.md).

Wenn du selbst an der App mitentwickeln möchtest, folge diesen Schritten:

1. Fork it!
2. erstelle einen Feature Branch: `git checkout -b my-new-feature`
3. Commit deine Änderungen: `git commit -am 'Add some feature'`
4. Push in den Branch: `git push origin my-new-feature`
5. Sende einen Pull Request

&nbsp;    

## Lizenz

[MIT Lizenz 2017 - OwnYourData.eu](https://raw.githubusercontent.com/OwnYourData/app-goal/master/LICENSE)
