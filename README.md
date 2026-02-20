# b2b_mdt

MDT police complet pour FiveM (inspiré tk_mdt), compatible ESX/QBCore (bridge à finaliser selon votre serveur).

## Arborescence
- `fxmanifest.lua`
- `config/config.lua` (bible de configuration, >3000 lignes)
- `client/client.lua`
- `server/server.lua`
- `nui/index.html`, `nui/style.css`, `nui/js/**` (frontend modulaire, >3000 lignes JS)
- `examples/*.json`
- `tests/*.js`
- `server/mysql_schema.sql`, `server/json_to_mysql.js`

## Installation rapide
1. Copier `b2b_mdt` dans `resources/[mdt]/b2b_mdt`.
2. Importer `server/mysql_schema.sql` si mode MySQL.
3. Ajouter `ensure b2b_mdt` dans `server.cfg`.
4. Configurer rôles/hotkeys dans `config/config.lua`.

## Endpoints / events
- `mdt:saveReport`
- `mdt:getPlayerFolder`
- `mdt:search`
- `mdt:linkVehicle`
- `mdt:linkWeapon`
- `mdt:exportPDF`
- Client receive: `mdt:notify`, `mdt:searchResult`, `mdt:playerFolder`, `mdt:vehicleLinked`, `mdt:weaponLinked`, `mdt:pdfReady`

## Tests
```bash
npm test
```

## Migration JSON -> MySQL
- Préparer schema SQL.
- Exécuter `node server/json_to_mysql.js`.
- Vérifier les index (`identifier`, `plate`, `serial`).

## VRM checklist
- Vérifier `Config.VRM.enabled = true`.
- Mapper les champs owner dans `Config.VRM.ownerIdentifierFields`.
- Tester lookup plaque + VIN + propriétaire.

## TODO prioritaire / QA
- Bridge permissions ESX/QBCore précis.
- Lock pessimiste distribué pour édition simultanée.
- Upload binaire réel via endpoint dédié.
- Génération PDF côté serveur Node worker.
- Tests charge multi-joueurs et pagination extrême.
