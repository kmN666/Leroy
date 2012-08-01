/* 
* sql\updates\characters\2012_06_07_00_characters_respawn.sql 
*/ 
ALTER TABLE `creature_respawn` ADD `mapId` SMALLINT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `respawnTime`;
ALTER TABLE `gameobject_respawn` ADD `mapId` SMALLINT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `respawnTime`;
 
 
