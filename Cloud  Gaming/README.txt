**Střední průmyslová škola elektrotechnická, Praha 2, Ječná 30**
**Školní rok 2022/2023**
---
Jméno a příjimeni: Leonid Charikov
Třída: C4c
---

## Úvod
- Problém jsem se rozhodl řešit v MSSQL Server, jako návrhové prostředí jsem 
využil Oracle DataModeler, pro své téma služby, jsem vybral cloud game, kde uživatel se může připojit na své
ůčty z různých platforem a hrát hry, podle členství bude pak bude záležet povolený čas hraní, kvalita obrázků a cena.
- Jako cloud gaming jsem vybral Geforce NOW od firmy Nvidia. 
- Analýza se nachází v .../src/Analýza.doc

weby - https://www.pocket-lint.com/games/news/nvidia/131715-what-is-nvidia-geforce-now-and-what-are-the-differences-on-shield-tv-pc-and-mac
     - https://play.geforcenow.com

__________________________________________________________________________________________________________

## E-R model
- konceptuální model databáze se nachází v /img/... .png, 

__________________________________________________________________________________________________________

## Entitní integrita
- Každá entita obsahuje uměle vytvořený primární klíč, označený jako `ID`


__________________________________________________________________________________________________________

## Doménová integrita
** uzivatel
- jmeno - libovolné znaky, maximálně však 20 znaků, not null
- prijmeni - libovolné znaky, maximálně však 20 znaků, not null
- nickname - libovolné znaky, maximálně však 50 znaků, not null
- email - libovolné znaky, maximálně však 50 znaků,not null,musí obsahovat znak '@'
- FK - id_conn - navazovani na tabulku pripojeni
     - id_member - navazovani na tabulku clenstvi

** clenstvi
-Nazev - libovolné znaky, maximálně však 20 znaků, not null
-Dovoleny_cas -int, not null
- Cena - int, not null
-Kvalita_obrazku - libovolné znaky, maximálně však 20 znaků, not null

** pocitac
-CPU - libovolné znaky, maximálně však 20 znaků, not null
-GPU - libovolné znaky, maximálně však 20 znaků, not null
-RAM - libovolné znaky, maximálně však 20 znaků, not null
-Memory_Bus - libovolné znaky, maximálně však 20 znaků, not null
-Bandwitch - libovolné znaky, maximálně však 20 znaků, not null

**pripojeni
- FK - id_platform
     - id_uzivatel

**platforma
- nazev - libovolné znaky, maximálně však 20 znaků
- nickname - libovolné znaky, maximálně však 50 znaků
- heslo - libovolné znaky, maximálně však 50 znaků

**hra
-Nazev - varchar(50) not null
-Zanr - varchar(50) not null
-Vyvojar - varchar(50) not null
-Vydavatel - varchar(50) not null
-Datum_vydani - date not null
-Pocet_hracu - varchar(20) not null
-Verze - varchar(20) not null

**sesion
-start_time date not null
-end_time date not null
-device varchar(50) not null
-wifi_speed varchar(50) not null
-id_pc int FK
-id_hra int FK
-id_uzivatel int FK

__________________________________________________________________________________________________________

## Referenční integrita
** Návrh obsahuje několik cizích klíčů, které jsou uvedeny níže
- 'id_pc'
- 'id_hra'
- 'id_uzivatel'
- 'id_platform'
- 'id_member'

__________________________________________________________________________________________________________

## Indexy 
- Databáze má pro každou entitu pouze indexy vytvořené pro primární klíče, 
další indexy: index HRAC ktery vypysuje ID, Nickname , Email, id_member
              index Proces ktery vypysuje ID ,id_uzivatel, id_pc, id_hra, start_time, device
__________________________________________________________________________________________________________

## Pohledy
- Návrh obsahuje pohledy - VIEW Member 
                         - VIEW VypisSesion

__________________________________________________________________________________________________________

## Triggery
- Databáze obsahuje triggery - delbackup_trigger který zálohuje hned jestli se smaže hodnota v tabůlce hra (Nejde ho vytvořit z důvodu toho že nemám prává na servru)
                             - newbackup_trigger který zálohuje hned jestli se vytvoří nová hodnota v tabůlce hra
__________________________________________________________________________________________________________

## Uložené procedury a funkce
- Databáze obsahuje procedury VyberHry a funkce najde hry podle napsaného žánrů(@Zanr) a počtu hráčů(@Pocet_hracu).

- Databáze obsahuje procedury ZanrHer a funkce najde hry podle napsaného žánrů(@Zanr).

- Databáze obsahuje procedury Zaznam a funkce menší zápis kdy session začal, nickname hráče a jakou hru hraje.

__________________________________________________________________________________________________________

## Přístupové údaje do databáze
- Z důvodu z toho že nemám práva pro vytváření užívatel a rolí k nim. Příkazy se nachází ve scriptu
- role - db_datareader - login Ema s heslem '78478'
       - db_datawriter - login Kris s heslem '97497'
       - db_accessadim - login John s heslem '12345'
       - db_owner - login Leo s heslem '489789'
__________________________________________________________________________________________________________

## Import struktury databáze a dat od zadavatele
Z důvodu že nemám prává na servru generoval jsem script který se nachází v /sql/structure.sql


__________________________________________________________________________________________________________

## Klientská aplikace
- Databáze neobsahuje klientskou aplikaci

__________________________________________________________________________________________________________
## Požadavky na spuštění
- MSSQL Server, rok vydání 2014 a prává na připojení na server 193.85.203.188 
- připojení k internetu alespoň 2Mb/s 


