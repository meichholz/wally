# Einbindung des Raspi als KuM-Viewer

## Anschluss: Telefon

Das führt zu einer IP wie 10.120.10.16/25 mit DHCP und der Domäne ads.mobilcom.de.

## Vorbereitung der Distro

Ausgangspunkt ist ein rohinstalliertes **Raspbian** auf Jessie-Basis. Alles andere ist Default.

* ``/etc/hostname`` wird auf `raspi` gesetzt.
* In ``/etc/hosts`` kommt ein Eintrag wie: @@127.0.1.1 raspi.bugslayer.de raspi@@
* ``/etc/init.d/hostname.sh`` sollte das auswerten. ``hostname -f`` sollte den FQDN zeigen.
* Eine vorbereitete Datei kann nach ``/root/.ssh/authorized_keys`` gepackt werden.
* Auf einer Workstation mag für "raspi" ein passender `/etc/host` vorbereitet werden, und der Known-Host ggf. bereinigt werden.
* Einige Pakete fehlen noch:
** apt-get update ; apt-get upgrade
** vim
** puppet-common


## Sicherheitsmaßnahmen

* Das Passwort für den PI-User sollte nun geändert werden.
* Der Autologin sollte abgeschaltet werden
* Bildschirmschonerei
* 

## Betüddelung durch Puppet

* giles.bugslayer.de versorgt als puppetmaster.
* Die Rolle ist `wallviewer`.
* "pi" bleibt Account
* FQDN ist `raspi.bugslayer.de`
