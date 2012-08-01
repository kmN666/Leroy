DELETE FROM `creature_template_addon` WHERE (`entry`=37122);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (37122, 0, 0, 0, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE (`entry`=37123);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (37123, 0, 0, 0, 0, 0, '');
DELETE FROM `creature_template_addon` WHERE (`entry`=37124);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (37124, 0, 0, 0, 0, 0, '');
DELETE FROM `creature_template_addon` WHERE (`entry`=37125);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (37125, 0, 0, 0, 0, 0, '');
DELETE FROM `creature_template_addon` WHERE (`entry`=37133);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (37133, 0, 0, 0, 0, 0, 71244);
DELETE FROM `creature_template_addon` WHERE (`entry`=37134);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (37134, 0, 0, 0, 0, 0, '');
DELETE FROM `creature_addon` WHERE (`guid`=83235);


-- Fix Marrowgar flame run speed
UPDATE `creature_template` SET `speed_walk` = 0.5, `speed_run` = 0.5 WHERE `entry` = 36672;

-- Fix NPC 36725, Bruth?ter der Nerub'ar spawn to bottom
DELETE FROM `creature` WHERE `id` = 36725;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(36725, 631, 15, 1, 30885, 0, -307.451, 2219.95, 42.0073, 5.95157, 86400, 0, 0, 315000, 3994, 0, 0, 0, 0),
(36725, 631, 15, 1, 30885, 0, -310.799, 2202.42, 42.0142, 0.034907, 86400, 0, 0, 315000, 3994, 0, 0, 0, 0),
(36725, 631, 15, 1, 30885, 0, -220.382, 2177.07, 37.9852, 0.855211, 86400, 0, 0, 315000, 3994, 0, 0, 0, 0),
(36725, 631, 15, 1, 30885, 0, -249.854, 2219.67, 42.5644, 5.95157, 86400, 0, 0, 315000, 3994, 0, 0, 0, 0),
(36725, 631, 15, 1, 30885, 0, -250.613, 2203.8, 42.5645, 0.034907, 86400, 0, 0, 315000, 3994, 0, 0, 0, 0),
(36725, 631, 15, 1, 0, 0, -212.81, 2202.31, 35.2336, 0.248573, 86400, 0, 0, 315000, 3994, 0, 0, 0, 0),
(36725, 631, 15, 1, 30885, 0, -216.486, 2245.4, 37.9852, 5.18363, 86400, 0, 0, 315000, 3994, 0, 0, 0, 0),
(36725, 631, 15, 1, 30885, 0, -211.29, 2219.42, 35.2336, 0.15708, 86400, 0, 0, 315000, 3994, 0, 0, 0, 0);

-- Fix boss immunities of first two bosses 10 normal
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853247 WHERE `entry` IN (36855, 36612);

-- Scriptname associations for trash
UPDATE `creature_template` SET `ScriptName` = 'npc_NerubarBroodkeeper' WHERE `entry` = 36725;
UPDATE `creature_template` SET `ScriptName` = 'npc_TheDamned' WHERE `entry` = 37011;
UPDATE `creature_template` SET `ScriptName` = 'npc_ServantoftheThrone' WHERE `entry` = 36724;
UPDATE `creature_template` SET `ScriptName` = 'npc_AncientSkeletalSoldier' WHERE `entry` = 37012;
UPDATE `creature_template` SET `ScriptName` = 'npc_DeathboundWard' WHERE `entry` = 37007;
UPDATE `creature_template` SET `ScriptName` = 'npc_DeathspeakerAttedant' WHERE `entry` = 36811;
UPDATE `creature_template` SET `ScriptName` = 'npc_DeathspeakerDisciple' WHERE `entry` = 36807;
UPDATE `creature_template` SET `ScriptName` = 'npc_DeathspeakerHighPriest' WHERE `entry` = 36829;
UPDATE `creature_template` SET `ScriptName` = 'npc_DeathspeakerServant' WHERE `entry` = 36805;
UPDATE `creature_template` SET `ScriptName` = 'npc_DeathspeakerZealot' WHERE `entry` = 36808;

-- Link respawns with bosses in first wing
DELETE FROM `linked_respawn` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `map` = 631);
DELETE FROM `linked_respawn` WHERE `linkedGuid` IN (SELECT `guid` FROM `creature` WHERE `map` = 631);
INSERT INTO `linked_respawn` (guid, linkedGuid, linkType)
SELECT `guid`, (SELECT `guid` FROM `creature` WHERE `id` = 36612 LIMIT 1), 0 FROM `creature` WHERE `id` IN (37011, 36724, 37007, 37012, 36725);
INSERT INTO `linked_respawn` (guid, linkedGuid, linkType)
SELECT `guid`, (SELECT `guid` FROM `creature` WHERE `id` = 36855 LIMIT 1), 0 FROM `creature` WHERE `id` IN (36829, 36811, 36808, 36807, 36805);


-- Fixes for Blood Prince Council / Rat des Blutes and nearby trash in instance / Instanz Icecrown Citadel / Eiskronenzitadelle / ICC
-- Make all trigger creatures invisible to players
UPDATE `creature_template` SET `modelid2` = 0 WHERE `entry` IN (38008, 30298, 38369, 38332, 38451, 38458, 38454, 38422, 38463);
UPDATE `creature_template` SET `modelid1` = 11686 WHERE `entry` IN (30298, 38463);
-- Set unattackable and unselectable flags if possible
UPDATE `creature_template` SET `unit_flags` = 33554434 WHERE `entry` IN (38008, 38332, 38451, 38458, 38422, 38463);
-- Set default immunities for bosses and attackable adds
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853247 WHERE `entry` IN (37970, 37972, 37973, 38454, 38369);
-- Trash AI and flags
UPDATE `creature_template` SET `flags_extra` = 0, `unit_flags` = 0, `type_flags` = 0, `AIName` = 'SmartAI' WHERE `entry` IN (37664, 37663, 37595, 37571, 37662, 37665, 37666);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (37664, 37663, 37595, 37571, 37662, 37665, 37666) AND `source_type` = 0;
INSERT INTO `smart_scripts` (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
-- 37664: Darkfallen Archmage <The San'layn> / Sinistrer Erzmagier <Die San'layn>
(37664, 0, 0, 0, 0, 0, 60, 10, 10000, 15000, 35000, 45000, 11, 70408, 0, 0, 0, 0, 0, 11, 0, 50, 0, 0, 0, 0, 0, 'Cast Amplify Magic (10) to ally target'),
(37664, 0, 1, 0, 0, 0, 60, 20, 10000, 15000, 35000, 45000, 11, 72336, 0, 0, 0, 0, 0, 11, 0, 50, 0, 0, 0, 0, 0, 'Cast Amplify Magic (25) to ally target'),
(37664, 0, 2, 0, 0, 0, 90, 10, 8000, 12000, 8000, 12000, 11, 70407, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Blast Wave (10) to self target'),
(37664, 0, 3, 0, 0, 0, 90, 20, 8000, 12000, 8000, 12000, 11, 71151, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Blast Wave (25) to self target'),
(37664, 0, 4, 0, 0, 0, 100, 10, 3000, 6000, 4000, 8000, 11, 70409, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Fireball (10) to random target'),
(37664, 0, 5, 0, 0, 0, 100, 20, 3000, 6000, 4000, 8000, 11, 71153, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Fireball (25) to random target'),
(37664, 0, 6, 0, 0, 0, 80, 30, 10000, 15000, 15000, 25000, 11, 70410, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Polymorph:Spider to random target'),
-- 37663: Darkfallen Noble <The San'layn> / Sinistrer Adeliger <Die San'layn>
(37663, 0, 0, 0, 0, 0, 100, 10, 5000, 10000, 4000, 8000, 11, 72960, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Shadow Bolt (10) to current target'),
(37663, 0, 1, 0, 0, 0, 100, 20, 5000, 10000, 4000, 8000, 11, 72961, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Shadow Bolt (25) to current target'),
(37663, 0, 2, 0, 0, 0, 100, 30, 5000, 10000, 10000, 20000, 11, 70645, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Chains of Shadow to random target'),
-- 37595: Darkfallen Blood Knight <The San'layn> / Sinistrer Blutritter <Die San'layn>
(37595, 0, 0, 0, 0, 0, 90, 30, 5000, 10000, 5000, 10000, 11, 70437, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Unholy Strike to current target'),
(37595, 0, 1, 0, 4, 0, 100, 30, 0, 0, 0, 0, 11, 71736, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Vampiric Aura on self target on aggro'),
-- 37571: Darkfallen Advisor <The San'layn> / Sinistrer Berater <Die San'layn>
(37571, 0, 0, 0, 0, 0, 100, 10, 5000, 10000, 4000, 8000, 11, 72057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Lich Slap (10) to current target'),
(37571, 0, 1, 0, 0, 0, 100, 20, 5000, 10000, 4000, 8000, 11, 72421, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Lich Slap (25) to current target'),
(37571, 0, 2, 0, 0, 0, 80, 30, 5000, 10000, 25000, 35000, 11, 72065, 0, 0, 0, 0, 0, 11, 0, 40, 0, 0, 0, 0, 0, 'Cast Shroud of Protection to ally target'),
(37571, 0, 3, 0, 0, 0, 80, 30, 5000, 10000, 25000, 35000, 11, 72066, 0, 0, 0, 0, 0, 11, 0, 40, 0, 0, 0, 0, 0, 'Cast Shroud of Spell Warding to ally target'),
-- 37662: Darkfallen Commander <The San'layn> / Sinistrer Kommandant <Die San'layn>
(37662, 0, 0, 0, 0, 0, 100, 10, 1000, 5000, 8000, 12000, 11, 70449, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Vampire Charge (10) to random target'),
(37662, 0, 1, 0, 0, 0, 100, 20, 1000, 5000, 8000, 12000, 11, 71155, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Vampire Charge (25) to random target'),
(37662, 0, 2, 0, 0, 0, 100, 30, 5000, 10000, 30000, 30000, 11, 70750, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Battle Shout to self target'),
-- 37665: Darkfallen Lieutenant <The San'layn> / Sinistrer Leutnant <Die San'layn>
(37665, 0, 0, 0, 0, 0, 100, 10, 5000, 10000, 2000, 6000, 11, 70435, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Rend Flesh (10) to random target'),
(37665, 0, 1, 0, 0, 0, 100, 20, 5000, 10000, 2000, 6000, 11, 71154, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Rend Flesh (25) to random target'),
-- 37666: Darkfallen Tactican <The San'layn> / Sinistrer Taktiker <Die San'layn>
(37666, 0, 0, 0, 0, 0, 90, 30, 5000, 10000, 5000, 10000, 11, 70437, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Unholy Strike to current target'),
(37666, 0, 1, 0, 0, 0, 100, 30, 3000, 8000, 10000, 15000, 11, 70432, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Blood Sap to random target');
-- Disable movement of some trashs, could attack during encounter
UPDATE `creature` SET `MovementType` = 0 WHERE `guid` IN (201501, 201001);
DELETE FROM `creature_addon` WHERE `guid` IN (201501, 201001);
DELETE FROM `waypoint_data` WHERE `id` IN (2015010, 2010010);
-- Empowering Blood Orb aura apply
UPDATE `gameobject_template` SET `ScriptName` = 'go_icc_blood_orb' WHERE `entry` = 201741;