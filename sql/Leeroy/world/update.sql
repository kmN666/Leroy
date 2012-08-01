set names utf8;

-- Version Database
TRUNCATE `version`;
INSERT INTO `version` VALUES (NULL, NULL,"LeeroyDB v150", 604);

-- Fall Of The Lich King Video
SET @MEMORIAL := 202443;

UPDATE gameobject_template SET AIName = 'SmartGameObjectAI' WHERE entry = @MEMORIAL;


DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@MEMORIAL);
INSERT INTO `smart_scripts` VALUES
(@MEMORIAL,1,0,1,62,0,100,0,11431,0,0,0,68,16,0,0,0,0,0,7,0,0,0,0,0,0,0,'Memorial - On gossip select - startmovie'),
(@MEMORIAL,1,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Memorial - On gossip select - Close gossip');

-- Scripts/Bronjahm: Implement Achievement Script for Soul Power by jacob
DELETE FROM achievement_criteria_data WHERE criteria_id = 12752;
INSERT INTO achievement_criteria_data (criteria_id, type, value1, value2, ScriptName) VALUES	
(12752, 12, 1, 0, ''),
(12752, 11, 0, 0, 'achievement_soul_power');

-- Fix quest 3792
UPDATE `quest_template` SET `PrevQuestId`=3791 WHERE `id`=3792; 


-- World/AchievementScripts: Implement Vehicular Gnomeslaughter and Fix Didn't stand a chance.
DELETE FROM achievement_criteria_data WHERE criteria_id IN (7704, 7705);
INSERT INTO achievement_criteria_data (criteria_id, type, value1, value2, ScriptName) VALUES
(7704, 6, 4197, 0, ''),
(7704, 11, 0, 0, 'achievement_wg_vehicular_gnomeslaughter'),
(7705, 6, 4197, 0, ''), 
(7705, 11, 0, 0, 'achievement_wg_vehicular_gnomeslaughter');


-- Ruby sanctum
UPDATE `instance_template` SET `Script`='instance_ruby_sanctum' WHERE `map`=724;
-- Halion
UPDATE `creature_template` SET `ScriptName`='boss_halion_real', `AIName` ='' WHERE `entry`=39863;
UPDATE `creature_template` SET `ScriptName`='boss_halion_twilight', `AIName` ='' WHERE `entry`=40142;
UPDATE `creature_template` SET `ScriptName`='mob_halion_meteor', `AIName` ='' WHERE `entry` = 40029;
UPDATE `creature_template` SET `ScriptName`='mob_halion_flame', `AIName` ='' WHERE `entry` IN (40041);
UPDATE `creature_template` SET `ScriptName`='mob_halion_control', `AIName` ='' WHERE `entry` IN (40146);
UPDATE `creature_template` SET `ScriptName`='mob_halion_orb', `AIName` ='' WHERE `entry` IN (40083,40100);
UPDATE `creature_template` SET `ScriptName`='mob_orb_rotation_focus', `AIName` ='' WHERE `entry` = 40091;
UPDATE `creature_template` SET `ScriptName`='mob_orb_carrier', `AIName` ='' WHERE `entry` = 40081;
UPDATE `creature_template` SET `ScriptName`='mob_fiery_combustion', `AIName` ='' WHERE `entry` = 40001;
UPDATE `creature_template` SET `ScriptName`='mob_soul_consumption', `AIName` ='' WHERE `entry` = 40135;
UPDATE `creature_template` SET `ScriptName`='', `AIName` ='' WHERE `entry` IN (40143, 40144, 40145);

-- spell_halion_fiery_combustion 74562
DELETE FROM `spell_script_names` WHERE `spell_id`=74562 AND `ScriptName`='spell_halion_fiery_combustion';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (74562,'spell_halion_fiery_combustion');

-- spell_halion_soul_consumption 74792
DELETE FROM `spell_script_names` WHERE `spell_id`=74792 AND `ScriptName`='spell_halion_soul_consumption';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (74792,'spell_halion_soul_consumption');


UPDATE `gameobject_template` SET `data10` = 74807, `faction` = '0', `ScriptName` = 'go_halion_portal_twilight' WHERE `gameobject_template`.`entry` IN (202794,202795);
UPDATE `gameobject_template` SET `faction` = '0', `ScriptName` = 'go_halion_portal_real' WHERE `gameobject_template`.`entry` IN (202796);

-- Baltharus
UPDATE `creature_template` SET `ScriptName`='boss_baltharus', `AIName` ='', `dmg_multiplier` = 80  WHERE `entry`=39751;
UPDATE `creature_template` SET `ScriptName`='mob_baltharus_clone', `AIName` ='', `dmg_multiplier` = 80  WHERE `entry`=39899;

-- zarithrian
UPDATE `creature_template` SET `ScriptName`='boss_zarithrian', `AIName` ='' WHERE `entry`=39746;
UPDATE `creature` SET `position_x` = '3008.552734',`position_y` = '530.471680',`position_z` = '89.195290',`orientation` = '6.16' WHERE `id` = 39746;
UPDATE `creature_template` SET `ScriptName`='mob_flamecaller_ruby', `AIName` ='' WHERE `entry`=39814;

-- Saviana Ragefire
UPDATE `creature_template` SET `ScriptName`='boss_ragefire', `AIName` ='' WHERE `entry`=39747;
DELETE FROM `conditions` WHERE `SourceEntry`=74455;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
(13,1,74455,0,31,3,39747,0,0, '', 'Ragefire - Conflagration');

-- Xerestrasza
UPDATE `creature_template` SET `ScriptName`='mob_xerestrasza', `AIName` ='' WHERE `entry`=40429;

-- fix Halion spawn
DELETE FROM `creature` WHERE `id` = 39863;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(39863, 724, 15, 1, 0, 0, 3144.93, 527.233, 72.8887, 0.110395, 300, 0, 0, 11156000, 0, 0, 0, 0, 0);


-- sound / text
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1666406 AND -1666000;

-- xerestrasza
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES
('-1666000','Help! I am trapped within this tree! I require aid!','Спасите! Я под этим деревом. Мне нужна помощь!','17490','6','0','0','SAY_XERESTRASZA_YELL_1'),
('-1666001','Thank you! I could have not held out for much longer. A terrible thing has happened here.','Спасибо! Без вас я бы долго не продержалась... Здесь произошли страшные события...','17491','0','0','0','SAY_XERESTRASZA_YELL_2'),
('-1666002','We believed that the Sanctum was well fortified, but we were not prepareted for the nature of this assault.','Святилище считалось неприступным, но до сих пор оно не подвергалось такому штурму...','17492','0','0','0','SAY_XERESTRASZA_SAY_1'),
('-1666003','The Black Dragonkin materialized from thin air, and set upon us before we could react.','Черные драконы явились из ниоткуда. Мы даже не успели понять что происходит...','17493','0','0','0','SAY_XERESTRASZA_SAY_2'),
('-1666004','We did not stand a chance. As my brethren perished around me, I managed to retreat hear and bar the entrance.','Силы были неравны, мои братья гибли один за другим. А я спряталась здесь и запечатала вход.','17494','0','0','0','SAY_XERESTRASZA_SAY_3'),
('-1666005','They slaughtered us with cold efficiency, but the true focus of their interest seemed to be the eggs kept here in the sanctum.','Нас убивали с расчетливой жестокостью, но основной целью врага была кладка яиц в святилище.','17495','0','0','0','SAY_XERESTRASZA_SAY_4'),
('-1666006','The commander of the forces on the ground here is a cruel brute named Zarithrian. But I fear there are greater powers at work.',' Атакой руководил кровожадный Заритриан, но, боюсь, тут замешано и более могущественное зло.','17496','0','0','0','SAY_XERESTRASZA_SAY_5'),
('-1666007','In their initial assault I caught a glimpse of their true leader, a fearsome full-grown Twilight Dragon.','В самом начале я ощутила присутствие их настоящего лидера - огромного сумеречного дракона.','17497','0','0','0','SAY_XERESTRASZA_SAY_6'),
('-1666008','I know not the extent of their plans heroes, but I know this: they cannot be allowed to succeed!','Герои, мне не ведомо чего добиваются эти захватчики. Одно я знаю точно - их нужно остановить!','17498','0','0','0','SAY_XERESTRASZA_SAY_7'),

-- Halion
('-1666100','Meddlesome insects, you\'re too late! The Ruby Sanctum is lost.','Назойливая мошкара! Вы опоздали. Рубиновое святилище пало!','17499','6','0','0','SAY_HALION_SPAWN'),
('-1666101','Your world teeters on the brink of annihilation. You will all bear witness to the coming of a new age of destruction!','Этот мир вот-вот соскользнет в бездну. Вам выпала честь узреть начало эры РАЗРУШЕНИЯ!','17500','6','0','0','SAY_HALION_AGGRO'),
('-1666102','Another hero falls.','Сколько еще таких героев?','17501','6','0','0','SAY_HALION_SLAY_1'),
('-1666103','Ha Ha Ha!','','17502','6','0','0','SAY_HALION_SLAY_2'),
('-1666104','Relish this victory mortals, for it will be your last. This world will burn with the Master\'s return!','Это ваша последняя победа. Насладитесь сполна ее вкусом. Ибо когда вернется мой господин, этот мир сгинет в огне!','17503','6','0','0','SAY_HALION_DEATH'),
('-1666105','Not good enough!','Надоело!','17504','6','0','0','SAY_HALION_BERSERK'),
('-1666106','The heavens burn!','Небеса в огне!','17505','6','0','0','SAY_HALION_SPECIAL_1'),
('-1666107','Beware the shadow!','','17506','6','0','0','SAY_HALION_SPECIAL_2'),
('-1666108','You will find only suffering within the realm of Twilight. Enter if you dare.','Вы найдете только тьму в мире Сумерек. Входите, если посмеете.','17507','6','0','0','SAY_HALION_PHASE_2'),
('-1666109','I am the light AND the darkness! Cower mortals before the Herald of Deathwing!','Я есть свет и я есть тьма! Трепещите, ничтожные, перед посланником Смертокрыла!','17508','6','0','0','SAY_HALION_PHASE_3'),
('-1666110','<need translate>','Во вращающихся сферах пульсирует темная энергия!','0','3','0','0',''),
('-1666111','<need translate>','Ваши союзники протолкнули Халиона дальше в физический мир!','0','3','0','0',''),
('-1666112','<need translate>','Ваши союзники протолкнули Халиона дальше в реальный мир!','0','3','0','0',''),
('-1666113','<need translate>','Находясь в покое в одном из миров, Халион восстанавливает жизненные силы.','0','3','0','0',''),

-- Zarthrian
('-1666200','Alexstrasza has chosen capable allies. A pity that I must end you!','Алекстраза выбрала достойных союзников... Жаль, что придется ПРИКОНЧИТЬ ВАС!','17512','6','0','0','SAY_ZARITHRIAN_AGGRO'),
('-1666201','You thought you stood a chance?','Глупо было и надеяться!','17513','6','0','0','SAY_ZARITHRIAN_SLAY_1'),
('-1666202','It\'s for the best.','Все только к лучшему!','17514','6','0','0','SAY_ZARITHRIAN_SLAY_2'),
('-1666203','Halion! I\'m...aah!','ХАЛИОН! Я...','17515','6','0','0','SAY_ZARITHRIAN_DEATH'),
('-1666204','Turn them to ash, minions!','Слуги! Обратите их в пепел!','17516','6','0','0','SAY_ZARITHRIAN_SPECIAL_1'),

-- baltharus
('-1666300','Ah, the entertainment has arrived...','А-а-а, цирк приехал.','17520','6','0','0','SAY_BALTHARUS_AGGRO'),
('-1666301','Baltharus leaves no survivors!','Балтар не оставляет живых!','17521','6','0','0','SAY_BALTHARUS_SLAY_1'),
('-1666302','This world has enough heroes!','В мире хватает героев и без тебя...','17522','6','0','0','SAY_BALTHARUS_SLAY_2'),
('-1666303','I...didn\'t see that coming...','Как… это могло произойти?..','17523','1','0','0','SAY_BALTHARUS_DEATH'),
('-1666304','Twice the pain and half the fun!','Вдвое сильнее страдание.','17524','6','0','0','SAY_BALTHARUS_SPECIAL_1'),
('-1666305','Your power wanes, ancient one! Soon, you will join your friends!','Твоя сила на исходе, Древнейшая! Скоро ты присоединишься к своим друзьям!','17525','6','0','0','SAY_BALTHARUS_YELL'),

-- saviana
('-1666400','You will suffer for this intrusion...','Ваш-ш-ши муки с-cтанут платой за это вторжение!','17528','6','0','0','SAY_SAVIANA_AGGRO'),
('-1666401','As it should be!','Так и должно быть!','17529','6','0','0','SAY_SAVIANA_SLAY_1'),
('-1666402','Halion will be pleased...','Халион будет доволен!','17530','6','0','0','SAY_SAVIANA_SLAY_2'),
('-1666403','<screaming>','О...','17531','6','0','0','SAY_SAVIANA_DEATH'),
('-1666404','Burn in the master\'s flame!','Горите в огне хозяина!','17532','6','0','0','SAY_SAVIANA_SPECIAL_1'),
('-1666405','<need translate>','|3-3(%s) впадает в исступление!','0','3','0','0','');


-- Anub'arak, fix of incorrect YTDB flag
UPDATE `creature_template` SET `unit_flags` = 32832 WHERE `entry`IN (34564,34566,35615,35616);

-- Fix expected cooldown for Sacred Shield
DELETE FROM `spell_script_names` WHERE `spell_id` = 58597;
INSERT INTO `spell_script_names` VALUES
(58597, 'spell_pal_sacred_shield');


-- Fix quest #12231  #12247
UPDATE creature_template SET ScriptName='npc_orsonn_and_kodian' WHERE entry IN (27274, 27275);

-- Scripts/StormwindCity: Implement Varian Wrynn script
UPDATE creature_template SET dmg_multiplier = 50, ScriptName = 'npc_varian_wrynn' WHERE entry = 29611;
-- Fix quest 12092 - 12096
UPDATE creature_template SET ScriptName = "npc_woodlands_walker" WHERE entry = 26421;

-- Scripts Malygos
-- Commiter: Denis aka jacob
-- Scripting ELRON , jacob
-- Copyright (c) Jacob 2012
UPDATE `creature_template`
    SET `ScriptName` = 'npc_scion_of_eternity'
    WHERE `entry` = 30249;
	
-- Disable Malygos vMaps LoS Check
DELETE FROM `disables` WHERE `sourceType` = 6 AND `entry` = 616;
INSERT INTO `disables` (sourceType, entry, flags, params_0, params_1, comment) VALUES
(6, 616, 4, '', '', 'Disable Malygos vMaps LoS Check');

-- Fix quest 10427 
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (20610, 20777) AND `source_type` = 0;	
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2077700, 2061000) AND `source_type` = 9;
INSERT INTO `smart_scripts` (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(20610, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Aggro - Say text 0'),	
(20610, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 8000, 11000, 11, 32019, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - In Combat - Cast Gore'),	
(20610, 0, 2, 0, 2, 0, 100, 1, 0, 20, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - At 20% HP - Say Text 1'),
(20610, 0, 3, 4, 8, 0, 100, 0, 35771, 0, 0, 0, 33, 20982, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Spellhit - Give Killcredit'),
(20610, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - Despawn'),
(20777, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 8000, 11000, 11, 32023, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - In Combat - Cast Hoof Stomp'),
(20777, 0, 1, 0, 2, 0, 100, 1, 0, 20, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - At 20% HP - Say Text 0'),
(20777, 0, 2, 3, 8, 0, 100, 0, 35771, 0, 0, 0, 33, 20982, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Spellhit - Give Killcredit'),
(20777, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - Despawn');

-- Arena watcher
DELETE FROM `trinity_string` WHERE `entry` BETWEEN '11610' AND '11615';
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc8`) VALUES
('11610', 'Player %s forbided you to watch his arena match.', 'Игрок %s не желает чтобы Вы были зрителем его боя на арене.'),
('11611', 'Player %s is not a member of arena match.', 'Игрок %s не на арене.'),
('11612', 'You should not be a member of arena or battleground match.', 'Вы не можете стать зрителем, находясь на поле боя или арене.'),
('11613', 'You already have a spectator state.', 'Вы уже являетесь зрителем.'),
('11614', 'Arena spectators system disabled.', 'Система зрителей на арене отключена.'),
('11615', 'You cannot use chat while you are a spectator.', 'Находясь в режиме зрителя, вы не можете пользоваться чатом.');

DELETE FROM `command` WHERE `name` = 'spectate player';
INSERT INTO `command` VALUES ('spectate player', '0', 'Syntax: .spectate player $player\r\n\r\nMakes you a spectator of arena match with $player');

-- Trial of the Champion

-- ScriptName
UPDATE `creature_template` SET `AIName`='PassiveAI' WHERE `entry` IN (35332,35330,35328,35327,35331,35329,35325,35314,35326,35323);
UPDATE `instance_template` SET `script`='instance_trial_of_the_champion' WHERE `map`=650;
UPDATE `creature_template` SET `ScriptName`='generic_vehicleAI_toc5' WHERE `entry` IN (33299, 35637,35633,35768,34658,35636,35638,35635,35640,35641,35634,33298,33416,33297,33414,33301,33408,33300,33409,33418);
UPDATE `creature_template` SET `ScriptName`='boss_warrior_toc5' WHERE `entry` IN (34705,35572);
UPDATE `creature_template` SET `ScriptName`='boss_mage_toc5' WHERE `entry` IN (34702,35569);
UPDATE `creature_template` SET `ScriptName`='boss_shaman_toc5' WHERE `entry` IN (35571,34701);
UPDATE `creature_template` SET `ScriptName`='boss_hunter_toc5' WHERE `entry` IN (35570,34657);
UPDATE `creature_template` SET `ScriptName`='boss_rouge_toc5' WHERE `entry` IN (35617,34703);
UPDATE `creature_template` SET `ScriptName`='npc_announcer_toc5' WHERE `entry`IN (35004,35005);
UPDATE `creature_template` SET `ScriptName`='npc_risen_ghoul' WHERE `entry` IN (35545,35564);
UPDATE `creature_template` SET `ScriptName`='boss_black_knight' WHERE `entry`=35451;
UPDATE `creature_template` SET `ScriptName`='boss_eadric' WHERE `entry`=35119;
UPDATE `creature_template` SET `ScriptName`='boss_paletress' WHERE `entry`=34928;
UPDATE `creature_template` SET `ScriptName`='npc_memory' WHERE `entry` IN (35052,35041,35033,35046,35043,35047,35044,35039,35034,35049,35030,34942,35050,35042,35045,35037,35031,35038,35029,35048,35032,35028,35040,35036,35051);
UPDATE `creature_template` SET `ScriptName`='npc_argent_soldier'  WHERE `entry` IN (35309,35305,35307);
UPDATE `creature_template` SET `ScriptName`='npc_black_knight_skeletal_gryphon' WHERE `entry`=35491;

-- Open Entrance Door
UPDATE `gameobject` SET `state` = 0 WHERE `guid` = 1804;

-- Mounts
DELETE FROM `vehicle_template_accessory` WHERE `entry` in (35491,33299,33418,33409,33300,33408,33301,33414,33297,33416,33298);
INSERT INTO `vehicle_template_accessory` (`entry`,`accessory_entry`,`seat_id`,`minion`,`description`) VALUES
(35491,35451,0,0, 'Black Knight'),
(33299,35323,0,1, 'Darkspear Raptor'),
(33418,35326,0,1, 'Silvermoon Hawkstrider'),
(33409,35314,0,1, 'Orgrimmar Wolf'),
(33300,35325,0,1, 'Thunder Bluff Kodo'),
(33408,35329,0,1, 'Ironforge Ram'),
(33301,35331,0,1, 'Gnomeregan Mechanostrider'),
(33414,35327,0,1, 'Forsaken Warhorse'),
(33297,35328,0,1, 'Stormwind Steed'),
(33416,35330,0,1, 'Exodar Elekk'),
(33298,35332,0,1, 'Darnassian Nightsaber');

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` in (33299,33418,33409,33300,33408,33301,33414,33297,33416,33298);
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(33299, 68503, 1, 0),
(33418, 68503, 1, 0),
(33409, 68503, 1, 0),
(33300, 68503, 1, 0),
(33408, 68503, 1, 0),
(33301, 68503, 1, 0),
(33414, 68503, 1, 0),
(33297, 68503, 1, 0),
(33416, 68503, 1, 0),
(33298, 68503, 1, 0);

DELETE FROM `vehicle_template_accessory` WHERE `entry` in (33318,33319,33316,33317,33217,33324,33322,33320,33323,33321);
INSERT INTO `vehicle_template_accessory` (`entry`,`accessory_entry`,`minion`,`description`) VALUES
('33318', '35330', '1', 'Exodar Elekk'),
('33319', '35332', '1', 'Darnassian Nightsaber'),
('33316', '35329', '1', 'Ironforge Ram'),
('33317', '35331', '1', 'Gnomeregan Mechanostrider'),
('33217', '35328', '1', 'Stormwind Steed'),
('33324', '35327', '1', 'Forsaken Warhorse'),
('33322', '35325', '1', 'Thunder Bluff Kodo'),
('33320', '35314', '1', 'Orgrimmar Wolf'),
('33323', '35326', '1', 'Silvermoon Hawkstrider'),
('33321', '35323', '1', 'Darkspear Raptor');

UPDATE `creature_template` SET `minlevel` = 80,`maxlevel` = 80 WHERE `entry` in (33298,33416,33297,33301,33408,35640,33299,33300,35634,33418,35638,33409,33414,33299,35635,35641);
UPDATE `creature_template` SET `faction_A` = 14,`faction_H` = 14 WHERE `entry` in (33318, 33319, 33316, 33317, 33217, 33324, 33322, 33320, 33323, 33321, 33298,33416,33297,33301,33408,35545,33299,35564,35590,35119,34928,35309,35305,33414,35307,35325,33300,35327,35326,33418,35638,35314,33409,33299,35635,35640,35641,35634,35633,35636,35768,35637,34658);
UPDATE `creature_template` SET `Health_mod` = 10,`mindmg` = 20000,`maxdmg` = 30000 WHERE `entry` in (33298,33416,33297,33301,33408,33409,33418,33300,33414,33299,33298,33416,33297,33301,33408,35640,35638,35634,35635,35641,35633,35636,35768,35637,34658);
UPDATE `creature_template` SET `speed_run` = 2,`Health_mod` = 40,`mindmg` = 10000,`maxdmg` = 20000,`spell1` =68505,`spell2` =62575,`spell3` =68282,`spell4` =66482 WHERE `entry` in (35644,36558, 36559, 36557);
UPDATE `creature` SET `spawntimesecs` = 86400 WHERE `id` in (35644,36558, 36559, 36557);
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35 WHERE `entry` in (35644,36558, 36559, 36557);
-- VehicleId
UPDATE `creature_template` SET `VehicleId`=486 WHERE `entry` in (36558, 35644, 36559, 36557);
-- faction for Vehicle
UPDATE `creature_template` SET `faction_A`=35,`faction_H`=35 WHERE `entry` in (36558, 35644, 36559, 36557);
UPDATE `creature` SET `id` = 35644 WHERE `id` = 36557;
UPDATE `creature` SET `id` = 36558 WHERE `id` = 36559;

-- Texts
DELETE FROM `script_texts` WHERE `entry` <= -1999926 and `entry` >= -1999956;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(0,-1999926, 'Coming out of the gate Grand Champions other faction.  ' ,0,0,0,1, '' ),
(0,-1999927, 'Good work! You can get your award from Crusader\'s Coliseum chest!.  ' ,0,1,0,1, '' ),
(0,-1999928, 'You spoiled my grand entrance. Rat.' ,16256,1,0,5, '' ),
(0,-1999929, 'Did you honestly think an agent if the Lich King would be bested on the field of your pathetic little tournament?' ,16257,1,0,5, '' ),
(0,-1999930, 'I have come to finish my task ' ,16258,1,0,5, '' ),
(0,-1999931, 'This farce ends here!' ,16259,1,0,5, '' ),
(0,-1999932, '[Zombie]Brains.... .... ....' ,0,1,0,5, '' ),
(0,-1999933, 'My roting flash was just getting in the way!' ,16262,1,0,5, '' ),
(0,-1999934, 'I have no need for bones to best you!' ,16263,1,0,5, '' ),
(0,-1999935, 'No! I must not fail...again...' ,16264,1,0,5, '' ),
(0,-1999936, 'What\'s that. up near the rafters ?' ,0,1,0,5, '' ),
(0,-1999937, 'Please change your weapon! Next battle will be start now!' ,0,3,0,5, '' ),
(0,-1999939, 'Excellent work!' ,0,1,0,1, '' ),
(0,-1999940, 'Coming out of the gate Crusader\'s Coliseum Champion.' ,0,0,0,1, '' ),
(0,-1999941, 'Excellent work! You are win Argent champion!' ,0,3,0,0, '' ),
(0,-1999942, 'The Sunreavers are proud to present their representatives in this trial by combat.' ,0,0,0,1, '' ),
(0,-1999943, 'Welcome, champions. Today, before the eyes of your leeders and peers, you will prove youselves worthy combatants.' ,0,0,0,1, '' ),
(0,-1999944, 'Fight well, Horde! Lok\'tar Ogar!' ,0,1,0,5, '' ),
(0,-1999945, 'Finally, a fight worth watching.' ,0,1,0,5, '' ),
(0,-1999946, 'I did not come here to watch animals tear at each other senselessly, Tirion' ,0,1,0,5, '' ),
(0,-1999947, 'You will first be facing three of the Grand Champions of the Tournament! These fierce contenders have beaten out all others to reach the pinnacle of skill in the joust.' ,0,1,0,5, '' ),
(0,-1999948, 'Will tought! You next challenge comes from the Crusade\'s own ranks. You will be tested against their consederable prowess.' ,0,1,0,5, '' ),
(0,-1999949, 'You may begin!' ,0,0,0,5, '' ),
(0,-1999950, 'Well, then. Let us begin.' ,0,1,0,5, '' ),
(0,-1999951, 'Take this time to consider your past deeds.' ,16248,1,0,5, '' ),
(0,-1999952, 'What is the meaning of this?' ,0,1,0,5, '' ),
(0,-1999953, 'No...I\'m still too young' ,0,1,0,5, '' ),
(0,-1999954, 'Excellent work! You are win Argent champion!' ,0,3,0,0, '' );

-- Griphon of black Knight
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES
(35491, 0, 0, 0, 0, 0, 29842, 0, 0, 0, 'Black Knight\'s Skeletal Gryphon', '', '', 0, 80, 80, 2, 35, 35, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 33554432, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 1048576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 486, 0, 0, '', 0, 4, 15, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 0, 0, 0, 'npc_black_knight_skeletal_gryphon');
DELETE FROM `script_waypoint` WHERE `entry`=35491;
INSERT INTO `script_waypoint` VALUES
(35491,1,781.513062, 657.989624, 466.821472,0,''),
(35491,2,759.004639, 665.142029, 462.540771,0,''),
(35491,3,732.936646, 657.163879, 452.678284,0,''),
(35491,4,717.490967, 646.008545, 440.136902,0,''),
(35491,5,707.570129, 628.978455, 431.128632,0,''),
(35491,6,705.164063, 603.628418, 422.956635,0,''),
(35491,7,716.350891, 588.489746, 420.801666,0,''),
(35491,8,741.702881, 580.167725, 420.523010,0,''),
(35491,9,761.634033, 586.382690, 422.206207,0,''),
(35491,10,775.982666, 601.991943, 423.606079,0,''),
(35491,11,769.051025, 624.686157, 420.035126,0,''),
(35491,12,756.582214, 631.692322, 412.529785,0,''),
(35491,13,744.841,634.505,411.575,0,'');
-- Griphon of black Knight before battle start
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES
(35492, 0, 0, 0, 0, 0, 29842, 0, 0, 0, 'Black Knight\'s Skeletal Gryphon', '', '', 0, 80, 80, 2, 35, 35, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 33554432, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 1048576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 486, 0, 0, '', 0, 3, 15, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 0, 0, 0, 'npc_gr');
DELETE FROM `script_waypoint` WHERE `entry`=35492;
INSERT INTO `script_waypoint` VALUES
(35492,1,741.067078, 634.471558, 411.569366,0,''),
(35492,2,735.726196, 639.247498, 414.725555,0,''),
(35492,3,730.187256, 653.250977, 418.913269,0,''),
(35492,4,734.517700, 666.071350, 426.259247,0,''),
(35492,5,739.638489, 675.339417, 438.226776,0,''),
(35492,6,741.833740, 698.797302, 456.986328,0,''),
(35492,7,734.647339, 711.084778, 467.165314,0,''),
(35492,8,715.388489, 723.820862, 470.333588,0,''),
(35492,9,687.178711, 730.140503, 470.569336,0,'');
-- Announcer for start event
DELETE FROM `creature_template` WHERE `entry` in (35591,35592);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES
(35591, 0, 0, 0, 0, 0, 29894, 0, 0, 0, 'Jaeren Sunsworn', '', '', 0, 75, 75, 2, 14, 14, 0, 1, 1, 0, 0, 0, 0, 0, 1, 2000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'npc_anstart'),
(35592, 0, 0, 0, 0, 0, 29893, 0, 0, 0, 'Arelas Brightstar', '', '', 0, 75, 75, 2, 14, 14, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'npc_anstart');
-- Spawn Announcer in normal/heroic mode
DELETE FROM `creature` WHERE `id` in (35004, 35005);
DELETE FROM `creature` WHERE `guid` in (180100, 180101);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES
(180100, 35591, 650, 3, 64, 0, 0, 746.626, 618.54, 411.09, 4.63158, 86400, 0, 0, 10635, 0, 0),
(180101, 35592, 650, 3, 128, 0, 0, 746.626, 618.54, 411.09, 4.63158, 86400, 0, 0, 10635, 0, 0);
-- Addons
REPLACE INTO `creature_template_addon` VALUES
-- Argent
(35309, 0, 0, 0, 1, 0, '63501'),
(35310, 0, 0, 0, 1, 0, '63501'),
(35305, 0, 0, 0, 1, 0, '63501'),
(35306, 0, 0, 0, 1, 0, '63501'),
(35307, 0, 0, 0, 1, 0, '63501'),
(35308, 0, 0, 0, 1, 0, '63501'),
(35119, 0, 0, 0, 1, 0, '63501'),
(35518, 0, 0, 0, 1, 0, '63501'),
(34928, 0, 0, 0, 1, 0, '63501'),
(35517, 0, 0, 0, 1, 0, '63501'),
-- Faction_champ
(35323, 0, 0, 0, 1, 0, '63399 62852 64723'),
(35570, 0, 0, 0, 1, 0, '63399 62852 64723'),
(36091, 0, 0, 0, 1, 0, '63399 62852 64723'),
(35326, 0, 0, 0, 1, 0, '63403 62852 64723'),
(35569, 0, 0, 0, 1, 0, '63403 62852 64723'),
(36085, 0, 0, 0, 1, 0, '63403 62852 64723'),
(35314, 0, 0, 0, 1, 0, '63433 62852 64723'),
(35572, 0, 0, 0, 1, 0, '63433 62852 64723'),
(36089, 0, 0, 0, 1, 0, '63433 62852 64723'),
(35325, 0, 0, 0, 1, 0, '63436 62852 64723'),
(35571, 0, 0, 0, 1, 0, '63436 62852 64723'),
(36090, 0, 0, 0, 1, 0, '63436 62852 64723'),
(35329, 0, 0, 0, 1, 0, '63427 62852 64723'),
(34703, 0, 0, 0, 1, 0, '63427 62852 64723'),
(36087, 0, 0, 0, 1, 0, '63427 62852 64723'),
(35331, 0, 0, 0, 1, 0, '63396 62852 64723'),
(34702, 0, 0, 0, 1, 0, '63396 62852 64723'),
(36082, 0, 0, 0, 1, 0, '63396 62852 64723'),
(35327, 0, 0, 0, 1, 0, '63430 62852 64723'),
(35617, 0, 0, 0, 1, 0, '63430 62852 64723'),
(36084, 0, 0, 0, 1, 0, '63430 62852 64723'),
(35328, 0, 0, 0, 1, 0, '62594 62852 64723'),
(34705, 0, 0, 0, 1, 0, '62594 62852 64723'),
(36088, 0, 0, 0, 1, 0, '62594 62852 64723'),
(35330, 0, 0, 0, 1, 0, '63423 62852 64723'),
(34701, 0, 0, 0, 1, 0, '63423 62852 64723'),
(36083, 0, 0, 0, 1, 0, '63423 62852 64723'),
(35332, 0, 0, 0, 1, 0, '63406 62852 64723'),
(36086, 0, 0, 0, 1, 0, '63406 62852 64723'),
(34657, 0, 0, 0, 1, 0, '63406 62852 64723');
-- Immunes (crash fix xD )
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|1073741823 WHERE `entry` IN
(35309,35310, -- Argent Lightwielder
35305,35306, -- Argent Monk
35307,35308); -- Argent Priestess


-- Fix spell 61669
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_hun_pet_aspect_of_the_beast';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(61669, 'spell_hun_pet_aspect_of_the_beast');

-- Fix apexis buffs
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_gen_apexis_buff';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(40623, 'spell_gen_apexis_buff'),	
(40625, 'spell_gen_apexis_buff'),
(40626, 'spell_gen_apexis_buff');

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_gen_apexis_swiftness';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(40624, 'spell_gen_apexis_swiftness'),
(40627, 'spell_gen_apexis_swiftness'),
(40628, 'spell_gen_apexis_swiftness');

-- Fix quest 26598
UPDATE creature_loot_template SET ChanceOrQuestChance = ABS(ChanceOrQuestChance) WHERE item = 2799;

-- Fix quest 25286, 25500
DELETE FROM creature_involvedrelation WHERE quest IN (25500, 25286);
INSERT INTO creature_involvedrelation (id, quest) VALUES
(39675, 25500),
(39675, 25286);

-- Fix quest 12924, 12966
UPDATE `quest_template` SET `PrevQuestId`=-12924 WHERE `Id`=12966;


-- Rogue T10 4p bonus
DELETE FROM spell_proc_event WHERE entry = 70803;
INSERT INTO `spell_proc_event` VALUES('70803', '0', '8', '4063232', '8', '0', '0', '0', '0', '0', '0');

-- Fix quest 12032
UPDATE `quest_template` SET `SpecialFlags`=0, `RequiredNpcOrGo1`=26648, `RequiredNpcOrGoCount1`=1 WHERE `Id`=12032 LIMIT 1;

-- Fix quest 10506
DELETE FROM event_scripts WHERE id = 13584;
INSERT INTO event_scripts(`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(13584,0,8,21176,0,0,0,0,0,0);


-- Halls of ref..
delete from `gameobject` where `map` = 668;
delete from `creature` where `map` = 668;

DELETE FROM `conditions` WHERE `SourceEntry` IN (69431,69708,69784,70194,70224,70225,70464);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 69784, 0, 0, 31, 0, 3, 37014, 0, 0, 0, '', NULL),
(13, 3, 69708, 0, 0, 31, 0, 3, 36954, 0, 0, 0, '', NULL),
(13, 1, 70464, 0, 1, 31, 0, 3, 37496, 0, 0, 0, '', NULL),
(13, 1, 70464, 0, 2, 31, 0, 3, 37497, 0, 0, 0, '', NULL),
(13, 1, 70464, 0, 3, 31, 0, 3, 37498, 0, 0, 0, '', NULL),
(13, 1, 70464, 0, 0, 31, 0, 3, 36881, 0, 0, 0, '', NULL),
(13, 3, 69708, 0, 1, 31, 0, 3, 37226, 0, 0, 0, '', NULL),
(13, 3, 70194, 0, 0, 31, 0, 3, 37226, 0, 0, 0, '', NULL),
(13, 1, 70224, 0, 0, 31, 0, 3, 37014, 0, 0, 0, '', NULL),
(13, 1, 70225, 0, 0, 31, 0, 3, 37014, 0, 0, 0, '', NULL),
(13, 1, 69431, 0, 1, 31, 0, 3, 37497, 0, 0, 0, '', NULL),
(13, 1, 69431, 0, 0, 31, 0, 3, 37496, 0, 0, 0, '', NULL),
(13, 1, 69431, 0, 4, 31, 0, 3, 37588, 0, 0, 0, '', NULL),
(13, 1, 69431, 0, 2, 31, 0, 3, 37584, 0, 0, 0, '', NULL),
(13, 1, 69431, 0, 3, 31, 0, 3, 37587, 0, 0, 0, '', NULL);

insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5314.98','2013.36','717.077','0.909173','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5311.79','1997.99','717.652','4.97445','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5300.16','2005.76','719.293','3.21137','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5300.33','2009.9','713.591','2.77885','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5315.18','2013.65','715.128','0.90371','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37704','668','3','1','17612','0','5309.26','2006.39','718.047','3.97935','86400','0','0','12600','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('14881','668','3','1','1160','0','5337.6','2012.14','707.695','3.52509','86400','0','0','8','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5302.93','1998.54','718.959','3.98555','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5310.47','2016.02','712.831','1.46876','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37779','668','3','1','30687','0','5232.69','1931.52','707.778','0.820305','86400','0','0','75600','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5307.8','2003.13','709.424','0.715585','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('14881','668','3','1','2536','0','5268.91','1969.17','707.696','0.321519','86400','0','0','8','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5320.61','2009.12','715.901','0.267618','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5310.23','1998.1','716.838','4.82407','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5303.75','1999.49','715.482','4.01671','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5315.09','2013.38','721.067','0.886024','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37226','668','3','1','30721','0','5362.46','2062.69','707.778','3.94444','86400','0','0','27890000','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5300.25','2003.97','714.337','3.39532','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5304.45','2014.65','712.542','2.13851','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('14881','668','3','1','1160','0','5386.99','2080.5','707.695','4.67797','86400','0','0','8','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5319','2002.85','715.96','5.92525','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5310.21','1996.31','716.042','4.77527','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5312.31','2016.24','711.687','1.37907','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37223','668','3','1','28213','0','5236.67','1929.91','707.778','0.837758','86400','0','0','6972500','85160','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5312.98','2013.87','721.169','1.10885','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5316.66','2013.38','711.619','0.982927','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37906','668','3','1','11686','0','5312.64','2013.21','711.998','1.76884','86400','0','0','42','0','0','0','0','0');
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('37704','668','3','1','17612','0','5309.14','2006.21','715.783','3.9619','86400','0','0','12600','0','0','0','0','0');

insert into `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values('202302','668','3','1','5309.36','2006.55','709.341','-2.33874','0','0','0','1','6000','100','1');
insert into `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values('197342','668','3','1','5520.77','2229.04','733.04','0.810935','0','0','-0.370856','0.928691','6000','100','0');
insert into `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values('197343','668','3','1','5582.81','2230.62','733.04','-0.75986','0','0','-0.370856','0.928691','6000','100','0');
insert into `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values('202236','668','3','1','5309.34','2006.52','709.316','-0.75986','0','0','-0.370856','0.928691','6000','100','1');
insert into `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values('201747','668','3','1','5231.04','1923.79','707.044','0.810935','0','0','-0.370856','0.928691','6000','100','1');
insert into `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values('201756','668','3','1','5231.04','1923.79','707.044','0.810935','0','0','-0.370856','0.928691','6000','100','1');
insert into `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values('201976','668','3','1','5264.61','1959.44','707.724','0.810935','0','0','-0.370856','0.928691','6000','100','0');
insert into `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values('197341','668','3','1','5358.96','2058.75','707.724','0.810935','0','0','-0.370856','0.928691','6000','100','1');
insert into `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values('190236','668','3','1','4926.09','1554.96','163.292','-2.26562','0','0','0.999999','-0.001655','6000','100','1');
insert into `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values('201596','668','3','1','5275.91','1693.72','786.151','4.05956','0','0','0.896503','-0.443037','25','0','0');


-- Halls of Reflection
-- Creature Templates 
UPDATE `creature_template` SET `speed_walk`='1.5', `speed_run`='2.0' WHERE `entry` in (36954, 37226);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_jaina_and_sylvana_HRintro' WHERE `entry` in (37221, 37223);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='boss_falric' WHERE `entry`=38112;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='boss_marwyn' WHERE `entry`=38113;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_lich_king_hr' WHERE `entry`=36954;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='boss_lich_king_hor' WHERE `entry`=37226;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_jaina_and_sylvana_HRextro' WHERE `entry` in (36955, 37554);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_raging_gnoul' WHERE `entry`=36940;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_risen_witch_doctor' WHERE `entry`=36941;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_abon' WHERE `entry`=37069;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_ghostly_priest' WHERE `entry`=38175;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_phantom_mage' WHERE `entry`=38172;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_phantom_hallucination' WHERE `entry`=38567;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_shadowy_mercenary' WHERE `entry`=38177;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_spectral_footman' WHERE `entry`=38173;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_ghostly_priest' WHERE `entry`=38176;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_frostworn_general' WHERE `entry`=36723;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_tortured_rifleman' WHERE `entry`=38176;

UPDATE `creature_template` SET `scale`='0.8', `equipment_id`='1221' WHERE `entry` in (37221, 36955);
UPDATE `creature_template` SET `equipment_id`='1290' WHERE `entry` in (37223, 37554);
UPDATE `creature_template` SET `equipment_id`='0' WHERE `entry`=36954;
UPDATE `creature_template` SET `scale`='1' WHERE `entry`=37223;
UPDATE `creature_template` SET `scale`='0.8' WHERE `entry` in (36658, 37225, 37223, 37226, 37554);
UPDATE `creature_template` SET `unit_flags`='768', `type_flags`='268435564' WHERE `entry` in (38177, 38176, 38173, 38172, 38567, 38175);
UPDATE `creature_template` set `scale`='1' where `entry` in (37223);
UPDATE `instance_template` SET `script` = 'instance_hall_of_reflection' WHERE map=668;
UPDATE `gameobject_template` SET `faction`='1375' WHERE `entry` in (197341, 202302, 201385, 201596);
UPDATE `creature` SET `phaseMask` = 128 WHERE `id` = 36993; 
UPDATE `creature` SET `phaseMask` = 64 WHERE `id` = 36990; 
UPDATE `instance_template` SET `script` = 'instance_halls_of_reflection' WHERE map=668;
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1594540 AND -1594430;
INSERT INTO `script_texts` (`entry`,`content_default`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(-1594473, '<need translate>', 'Глупая девчонка! Тот кого ты ищещь давно убит! Теперь он лишь призрак, слабый отзвук в моем сознании!', 17229,1,0,0, '67234'),
(-1594474, '<need translate>', 'Я не повторю прежней ошибки, Сильвана. На этот раз тебе не спастись. Ты не оправдала моего доверия и теперь тебя ждет только забвение!', 17228,1,0,0, '67234'),
-- SCENE - Hall Of Reflection (Extro) - PreEscape
(-1594477, 'Your allies have arrived, Jaina, just as you promised. You will all become powerful agents of the Scourge.', 'Твои союзники прибыли, Джайна! Как ты и обещала... Ха-ха-ха-ха... Все вы станете могучими солдатами Плети...', 17212,1,0,0, '67234'),
(-1594478, 'I will not make the same mistake again, Sylvanas. This time there will be no escape. You will all serve me in death!', 'Я не повторю прежней ошибки, Сильвана! На этот раз тебе не спастись. Вы все будите служить мне после смерти...', 17213,1,0,0, '67234'),
(-1594479, 'He is too powerful, we must leave this place at once! My magic will hold him in place for only a short time! Come quickly, heroes!', 'Он слишком силен. Мы должны выбраться от сюда как можно скорее. Моя магия задержит его ненадолго, быстрее герои...', 16644,0,0,1, '67234'),
(-1594480, 'He\'s too powerful! Heroes, quickly, come to me! We must leave this place immediately! I will do what I can do hold him in place while we flee.', 'Он слишком силен. Герои скорее, за мной. Мы должны выбраться отсюда немедленно. Я постараюсь его задержать, пока мы будем убегать.', 17058,0,0,1, '67234'),
-- SCENE - Hall Of Reflection (Extro) - Escape
(-1594481, 'Death\'s cold embrace awaits.', 'Смерть распростерла ледяные обьятия!', 17221,1,0,0, '67234'),
(-1594482, 'Rise minions, do not left them us!', 'Восстаньте прислужники, не дайте им сбежать!', 17216,1,0,0, '67234'),
(-1594483, 'Minions sees them. Bring their corpses back to me!', 'Схватите их! Принесите мне их тела!', 17222,1,0,0, '67234'),
(-1594484, 'No...', 'Надежды нет!', 17214,1,0,0, '67234'),
(-1594485, 'All is lost!', 'Смирись с судьбой.', 17215,1,0,0, '67234'),
(-1594486, 'There is no escape!', 'Бежать некуда!', 17217,1,0,0, '67234'),
(-1594487, 'I will destroy this barrier. You must hold the undead back!', 'Я разрушу эту преграду, а вы удерживайте нежить на расстоянии!', 16607,1,0,0, '67234'),
(-1594488, 'No wall can hold the Banshee Queen! Keep the undead at bay, heroes! I will tear this barrier down!', 'Никакие стены не удержат Королеву Баньши. Держите нежить на расстоянии, я сокрушу эту преграду.', 17029,1,0,0, '67234'),
(-1594489, 'Another ice wall! Keep the undead from interrupting my incantation so that I may bring this wall down!', 'Опять ледяная стена... Я разобью ее, только не дайте нежити прервать мои заклинания...', 16608,1,0,0, '67234'),
(-1594490, 'Another barrier? Stand strong, champions! I will bring the wall down!', 'Еще одна преграда. Держитесь герои! Я разрушу эту стену!', 17030,1,0,0, '67234'),
(-1594491, 'Succumb to the chill of the grave.', 'Покоритесь Леденящей смерти!', 17218,1,0,0, '67234'),
(-1594492, 'Another dead end.', 'Вы в ловушке!', 17219,1,0,0, '67234'),
(-1594493, 'How long can you fight it?', 'Как долго вы сможете сопротивляться?', 17220,1,0,0, '67234'),
(-1594494, '<need translate>', 'Он с нами играет. Я  покажу ему что бывает когда лед встречается со огнем!', 16609,0,0,0, '67234'),
(-1594495, 'Your barriers can\'t hold us back much longer, monster. I will shatter them all!', 'Твои преграды больше не задержат нас, чудовище. Я смету их с пути!', 16610,1,0,0, '67234'),
(-1594496, 'I grow tired of these games, Arthas! Your walls can\'t stop me!', 'Я устала от этих игр Артас. Твои стены не остановят меня!', 17031,1,0,0, '67234'),
(-1594497, 'You won\'t impede our escape, fiend. Keep the undead off me while I bring this barrier down!', 'Ты не помешаешь нам уйти, монстр. Сдерживайте нежить, а я уничтожу эту преграду.', 17032,1,0,0, '67234'),
(-1594498, 'There\'s an opening up ahead. GO NOW!', 'Я вижу выход, скорее!', 16645,1,0,0, '67234'),
(-1594499, 'We\'re almost there... Don\'t give up!', 'Мы почти выбрались, не сдавайтесь!', 16646,1,0,0, '67234'),
(-1594500, 'There\'s an opening up ahead. GO NOW!', 'Я вижу выход, скорее!', 17059,1,0,0, '67234'),
(-1594501, 'We\'re almost there! Don\'t give up!', 'Мы почти выбрались, не сдавайтесь!', 17060,1,0,0, '67234'),
(-1594502, 'It... It\'s a dead end. We have no choice but to fight. Steel yourself heroes, for this is our last stand!', 'Больше некуда бежать. Теперь нам придется сражаться. Это наша последняя битва!', 16647,1,0,0, '67234'),
(-1594503, 'BLASTED DEAD END! So this is how it ends. Prepare yourselves, heroes, for today we make our final stand!', 'Проклятый тупик, значит все закончится здесь. Готовьтесь герои, это наша последняя битва.', 17061,1,0,0, '67234'),
(-1594504, 'Nowhere to run! You\'re mine now...', 'Ха-ха-ха... Бежать некуда. Теперь вы мои!', 17223,1,0,0, '67234'),
(-1594505, 'Soldiers of Lordaeron, rise to meet your master\'s call!', 'Солдаты Лордерона, восстаньте по зову Господина!', 16714,1,0,0, '67234'),
(-1594506, 'The master surveyed his kingdom and found it... lacking. His judgement was swift and without mercy. Death to all!', 'Господин осмотрел свое королевство и признал его негодным! Его суд был быстрым и суровым - предать всех смерти!', 16738,1,0,0, '67234'),
-- FrostWorn General
(-1594519, 'You are not worthy to face the Lich King!', 'Вы недостойны предстать перед Королем - Личом!', 16921,1,0,0, '67234'),
(-1594520, 'Master, I have failed...', 'Господин... Я подвел вас...', 16922,1,0,0, '67234');

-- Waipoints to escort event on Halls of reflection

DELETE FROM script_waypoint WHERE entry IN (36955,37226,37554);
INSERT INTO script_waypoint VALUES
-- Jaina

   (36955, 0, 5587.682,2228.586,733.011, 0, 'WP1'),
   (36955, 1, 5600.715,2209.058,731.618, 0, 'WP2'),
   (36955, 2, 5606.417,2193.029,731.129, 0, 'WP3'),
   (36955, 3, 5598.562,2167.806,730.918, 0, 'WP4 - Summon IceWall 01'), 
   (36955, 4, 5556.436,2099.827,731.827, 0, 'WP5 - Spell Channel'),
   (36955, 5, 5543.498,2071.234,731.702, 0, 'WP6'),
   (36955, 6, 5528.969,2036.121,731.407, 0, 'WP7'),
   (36955, 7, 5512.045,1996.702,735.122, 0, 'WP8'),
   (36955, 8, 5504.490,1988.789,735.886, 0, 'WP9 - Spell Channel'),
   (36955, 9, 5489.645,1966.389,737.653, 0, 'WP10'),
   (36955, 10, 5475.517,1943.176,741.146, 0, 'WP11'),
   (36955, 11, 5466.930,1926.049,743.536, 0, 'WP12'),
   (36955, 12, 5445.157,1894.955,748.757, 0, 'WP13 - Spell Channel'),
   (36955, 13, 5425.907,1869.708,753.237, 0, 'WP14'),
   (36955, 14, 5405.118,1833.937,757.486, 0, 'WP15'),
   (36955, 15, 5370.324,1799.375,761.007, 0, 'WP16'),
   (36955, 16, 5335.422,1766.951,767.635, 0, 'WP17 - Spell Channel'),
   (36955, 17, 5311.438,1739.390,774.165, 0, 'WP18'),
   (36955, 18, 5283.589,1703.755,784.176, 0, 'WP19'),
   (36955, 19, 5260.400,1677.775,784.301, 3000, 'WP20'),
   (36955, 20, 5262.439,1680.410,784.294, 0, 'WP21'),
   (36955, 21, 5260.400,1677.775,784.301, 0, 'WP22'),

-- Sylvana

   (37554, 0, 5587.682,2228.586,733.011, 0, 'WP1'),
   (37554, 1, 5600.715,2209.058,731.618, 0, 'WP2'),
   (37554, 2, 5606.417,2193.029,731.129, 0, 'WP3'),
   (37554, 3, 5598.562,2167.806,730.918, 0, 'WP4 - Summon IceWall 01'), 
   (37554, 4, 5556.436,2099.827,731.827, 0, 'WP5 - Spell Channel'),
   (37554, 5, 5543.498,2071.234,731.702, 0, 'WP6'),
   (37554, 6, 5528.969,2036.121,731.407, 0, 'WP7'),
   (37554, 7, 5512.045,1996.702,735.122, 0, 'WP8'),
   (37554, 8, 5504.490,1988.789,735.886, 0, 'WP9 - Spell Channel'),
   (37554, 9, 5489.645,1966.389,737.653, 0, 'WP10'),
   (37554, 10, 5475.517,1943.176,741.146, 0, 'WP11'),
   (37554, 11, 5466.930,1926.049,743.536, 0, 'WP12'),
   (37554, 12, 5445.157,1894.955,748.757, 0, 'WP13 - Spell Channel'),
   (37554, 13, 5425.907,1869.708,753.237, 0, 'WP14'),
   (37554, 14, 5405.118,1833.937,757.486, 0, 'WP15'),
   (37554, 15, 5370.324,1799.375,761.007, 0, 'WP16'),
   (37554, 16, 5335.422,1766.951,767.635, 0, 'WP17 - Spell Channel'),
   (37554, 17, 5311.438,1739.390,774.165, 0, 'WP18'),
   (37554, 18, 5283.589,1703.755,784.176, 0, 'WP19'),
   (37554, 19, 5260.400,1677.775,784.301, 3000, 'WP20'),
   (37554, 20, 5262.439,1680.410,784.294, 0, 'WP21'),
   (37554, 21, 5260.400,1677.775,784.301, 0, 'WP22'),

-- Lich King

   (37226, 0, 5577.187,2236.003,733.012, 0, 'WP1'),
   (37226, 1, 5587.682,2228.586,733.011, 0, 'WP2'),
   (37226, 2, 5600.715,2209.058,731.618, 0, 'WP3'),
   (37226, 3, 5606.417,2193.029,731.129, 0, 'WP4'),
   (37226, 4, 5598.562,2167.806,730.918, 0, 'WP5'), 
   (37226, 5, 5559.218,2106.802,731.229, 0, 'WP6'),
   (37226, 6, 5543.498,2071.234,731.702, 0, 'WP7'),
   (37226, 7, 5528.969,2036.121,731.407, 0, 'WP8'),
   (37226, 8, 5512.045,1996.702,735.122, 0, 'WP9'),
   (37226, 9, 5504.490,1988.789,735.886, 0, 'WP10'),
   (37226, 10, 5489.645,1966.389,737.653, 0, 'WP10'),
   (37226, 11, 5475.517,1943.176,741.146, 0, 'WP11'),
   (37226, 12, 5466.930,1926.049,743.536, 0, 'WP12'),
   (37226, 13, 5445.157,1894.955,748.757, 0, 'WP13'),
   (37226, 14, 5425.907,1869.708,753.237, 0, 'WP14'),
   (37226, 15, 5405.118,1833.937,757.486, 0, 'WP15'),
   (37226, 16, 5370.324,1799.375,761.007, 0, 'WP16'),
   (37226, 17, 5335.422,1766.951,767.635, 0, 'WP17'),
   (37226, 18, 5311.438,1739.390,774.165, 0, 'WP18'),
   (37226, 19, 5283.589,1703.755,784.176, 0, 'WP19'),
   (37226, 20, 5278.694,1697.912,785.692, 0, 'WP20'),
   (37226, 21, 5283.589,1703.755,784.176, 0, 'WP19');
   
-- Fixed Halls of Reflection
DELETE FROM `gameobject_template` WHERE `entry` = 500001;
INSERT INTO `gameobject_template` VALUES ('500001', '0', '9214', 'Ice Wall', '', '', '', '1375', '0', '2.5', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '1'); 
DELETE FROM `creature` WHERE `id` IN (38112,37223,37221,36723,36955,37158,38113,37554,37226) AND `map` = 668;
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`)
VALUES 
('38112', '668', '3', '1', '0', '0', '5276.81', '2037.45', '709.32', '5.58779', '604800', '0', '0', '377468', '0', '0', '0', '0', '0'),
('37223', '668', '3', '64', '0', '0', '5266.78', '1953.42', '707.697', '0.740877', '7200', '0', '0', '6972500', '85160', '0', '0', '0', '0'),
('37221', '668', '3', '128', '0', '0', '5266.78', '1953.42', '707.697', '0.740877', '7200', '0', '0', '5040000', '881400', '0', '0', '0', '0'),
('36723', '668', '3', '1', '0', '0', '5413.84', '2116.44', '707.695', '3.88117', '7200', '0', '0', '315000', '0', '0', '0', '0', '0'),
('36955', '668', '3', '128', '0', '0', '5547.27', '2256.95', '733.011', '0.835987', '7200', '0', '0', '252000', '881400', '0', '0', '0', '0'),
('37158', '668', '3', '99', '0', '0', '5304.5', '2001.35', '709.341', '4.15073', '7200', '0', '0', '214200', '0', '0', '0', '0', '0'),
('38113', '668', '3', '1', '0', '0', '5341.72', '1975.74', '709.32', '2.40694', '604800', '0', '0', '539240', '0', '0', '0', '0', '0'),
('37554', '668', '3', '64', '0', '0', '5547.27', '2256.95', '733.011', '0.835987', '7200', '0', '0', '252000', '881400', '0', '0', '0', '0'),
('37226', '668', '3', '1', '0', '0', '5551.29', '2261.33', '733.012', '4.0452', '604800', '0', '0', '27890000', '0', '0', '0', '0', '0');
DELETE FROM `gameobject` WHERE `id` IN (202302,202236,201596,500001,196391,196392,202396,201885,197341,201976,197342,197343,201385,202212,201710,202337,202336,202079) AND `map`=668;
INSERT INTO `gameobject` (`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`)
VALUES 
('202302', '668', '3', '1', '5309.51', '2006.64', '709.341', '5.50041', '0', '0', '0.381473', '-0.92438', '604800', '100', '1'),
('202236', '668', '3', '1', '5309.51', '2006.64', '709.341', '5.53575', '0', '0', '0.365077', '-0.930977', '604800', '100', '1'),
('201596', '668', '3', '1', '5275.28', '1694.23', '786.147', '0.981225', '0', '0', '0.471166', '0.882044', '25', '0', '1'),
('500001', '668', '3', '1', '5323.61', '1755.85', '770.305', '0.784186', '0', '0', '0.382124', '0.924111', '604800', '100', '1'),
('196391', '668', '3', '1', '5232.31', '1925.57', '707.695', '0.815481', '0', '0', '0.396536', '0.918019', '300', '0', '1'),
('196392', '668', '3', '1', '5232.31', '1925.57', '707.695', '0.815481', '0', '0', '0.396536', '0.918019', '300', '0', '1'),
('202396', '668', '3', '1', '5434.27', '1881.12', '751.303', '0.923328', '0', '0', '0.445439', '0.895312', '604800', '100', '1'),
('201885', '668', '3', '1', '5494.3', '1978.27', '736.689', '1.0885', '0', '0', '0.517777', '0.855516', '604800', '100', '1'),
('197341', '668', '3', '1', '5359.24', '2058.35', '707.695', '3.96022', '0', '0', '0.917394', '-0.397981', '300', '100', '1'),
('201976', '668', '3', '1', '5264.6', '1959.55', '707.695', '0.736951', '0', '0', '0.360194', '0.932877', '300', '100', '0'),
('197342', '668', '3', '1', '5520.72', '2228.89', '733.011', '0.778581', '0', '0', '0.379532', '0.925179', '300', '100', '1'),
('197343', '668', '3', '1', '5582.96', '2230.59', '733.011', '5.49098', '0', '0', '0.385827', '-0.922571', '300', '100', '1'),
('201385', '668', '3', '1', '5540.39', '2086.48', '731.066', '1.00057', '0', '0', '0.479677', '0.877445', '604800', '100', '1'),
('202212', '668', '1', '65535', '5241.05', '1663.44', '784.295', '0.54', '0', '0', '0', '0', '-604800', '100', '1'),
('201710', '668', '1', '65535', '5241.05', '1663.44', '784.295', '0.54', '0', '0', '0', '0', '-604800', '100', '1'),
('202337', '668', '2', '65535', '5241.05', '1663.44', '784.295', '0.54', '0', '0', '0', '0', '-604800', '100', '1'),
('202336', '668', '2', '65535', '5241.05', '1663.44', '784.295', '0.54', '0', '0', '0', '0', '-604800', '100', '1'),
('202079', '668', '3', '1', '5250.96', '1639.36', '784.302', '0', '0', '0', '0', '0', '-604800', '100', '1');


-- russian

DELETE FROM script_texts WHERE `npc_entry` = 36612;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(36612,-1631000,'This is the beginning AND the end, mortals. None may enter the master''s sanctum!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Смертные, ваш путь закончится так и не начавшись! Никто не смеет входить  в Обитель Господина!',16950,1,0,0,'SAY_ENTER_ZONE'),
(36612,-1631001,'The Scourge will wash over this world as a swarm of death and destruction!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Плеть накроет этот мир волной смерти и разрушения!',16941,1,0,0,'SAY_AGGRO'),
(36612,-1631002,'BONE STORM!',NULL,NULL, NULL,NULL,NULL,NULL,NULL,'ВИХРЬ КОСТЕЙ!',16946,1,0,0,'SAY_BONE_STORM'),
(36612,-1631003,'Bound by bone!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Костяная хватка!',16947,1,0,0, 'SAY_BONESPIKE_1'),
(36612,-1631004,'Stick Around!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Постой-ка тут!',16948,1,0,0,'SAY_BONESPIKE_2'),
(36612,-1631005,'The only escape is death!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Единственный выход - это СМЕРТЬ!',16949,1,0,0,'SAY_BONESPIKE_3'),
(36612,-1631006,'More bones for the offering!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Кости, для жертвоприношений!',16942,1,0,0,'SAY_KILL_1'),
(36612,-1631007,'Languish in damnation!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Сгинь в вечных муках!',16943,1,0,0,'SAY_KILL_2'),
(36612,-1631008,'I see... only darkness...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Я вижу... лишь тьму',16944,1,0,0,'SAY_DEATH'),
(36612,-1631009,'THE MASTER''S RAGE COURSES THROUGH ME!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Во мне бушует ярость господина!',16945,1,0,0,'SAY_BERSERK'),
(36612,-1631010,'Lord Marrowgar creates a whirling storm of bone!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Лорд Ребрад распадается, и его кости начинают вращаться',0,3,0,0,'SAY_BONE_STORM_EMOTE');


DELETE FROM `script_texts` WHERE `entry` BETWEEN -1631028 AND -1631011;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(36855,-1631011, 'You have found your way here, because you are among the few gifted with true vision in a world cursed with blindness.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17272,1,0,0, 'SAY_INTRO_1'),
(36855,-1631012, 'You can see through the fog that hangs over this world like a shroud, and grasp where true power lies.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17273,1,0,0, 'SAY_INTRO_2'),
(36855,-1631013, 'Fix your eyes upon your crude hands: the sinew, the soft meat, the dark blood coursing within.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16878,1,0,0, 'SAY_INTRO_3'),
(36855,-1631014, 'It is a weakness; a crippling flaw.... A joke played by the Creators upon their own creations.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17268,1,0,0, 'SAY_INTRO_4'),
(36855,-1631015, 'The sooner you come to accept your condition as a defect, the sooner you will find yourselves in a position to transcend it.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17269,1,0,0, 'SAY_INTRO_5'),
(36855,-1631016, 'Through our Master, all things are possible. His power is without limit, and his will unbending.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17270,1,0,0, 'SAY_INTRO_6'),
(36855,-1631017, 'Those who oppose him will be destroyed utterly, and those who serve -- who serve wholly, unquestioningly, with utter devotion of mind and soul -- elevated to heights beyond your ken.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17271,1,0,0, 'SAY_INTRO_7'),
(36855,-1631018, 'What is this disturbance?! You dare trespass upon this hallowed ground? This shall be your final resting place.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16868,1,0,0, 'SAY_AGGRO'),
(36855,-1631019, 'Enough! I see I must take matters into my own hands!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16877,1,0,0, 'SAY_PHASE_2'),
(36855,-1631020, 'Lady Deathwhisper''s Mana Barrier shimmers and fades away!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0, 'SAY_PHASE_2_EMOTE'),
(36855,-1631021, 'You are weak, powerless to resist my will!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16876,1,0,0, 'SAY_DOMINATE_MIND'),
(36855,-1631022, 'Take this blessing and show these intruders a taste of our master''s power.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16873,1,0,0, 'SAY_DARK_EMPOWERMENT'),
(36855,-1631023, 'I release you from the curse of flesh!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16874,1,0,0, 'SAY_DARK_TRANSFORMATION'),
(36855,-1631024, 'Arise and exult in your pure form!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16875,1,0,0, 'SAY_ANIMATE_DEAD'),
(36855,-1631025, 'Do you yet grasp of the futility of your actions?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16869,1,0,0, 'SAY_KILL_1'),
(36855,-1631026, 'Embrace the darkness... Darkness eternal!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16870,1,0,0, 'SAY_KILL_2'),
(36855,-1631027, 'This charade has gone on long enough.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16872,1,0,0, 'SAY_BERSERK'),
(36855,-1631028, 'All part of the masters plan! Your end is... inevitable!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16871,1,0,0, 'SAY_DEATH');


INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(0,-1665919,'Thank the spirits for you, brothers and sisters. The Skybreaker has already left. Quickly now, to Orgrim''s Hammer! If you leave soon, you may be able to catch them.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,''),
(0,-1665920,'This should be helpin''ya!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,''),
(0,-1665921,'Aka''Magosh, brave warriors. The alliance is in great number here.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665922,'Captain Saurfang will be pleased to see you aboard Orgrim''s Hammer. Make haste, we will secure the area until you are ready for take-off.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665923,'A screeching cry pierces the air above!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665924,'A Spire Frostwyrm lands just before Orgrim''s Hammer.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665925,'Rise up, sons and daughters of the Horde! Today we battle a hated enemy of the Horde! LOK''TAR OGAR! Kor''kron, take us out!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665926,'What is that?! Something approaching in the distance!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665927,'ALLIANCE GUNSHIP! ALL HANDS ON DECK!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665928,'Move yer jalopy or we''ll blow it out of the sky, orc! The Horde''s got no business here!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665929,'You will know our business soon! KOR''KRON, ANNIHILATE THEM!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665930,'Marines, Sergeants, attack!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665931,'You DARE board my ship? Your death will come swiftly.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665932,'Riflemen, shoot faster!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665933,'Mortar team, reload!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665934,'We''re taking hull damage, get a sorcerer out here to shut down those cannons!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665935,'The Alliance falter. Onward to the Lich King!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665936,'Damage control! Put those fires out! You haven''t seen the last of the Horde!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665937,'Thank goodness you arrived when you did, heroes. Orgrim''s Hammer has already left. Quickly now, to The Skybreaker! If you leave soon, you may be able to catch them.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665938,'This ought to help!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665939,'Skybreaker Sorcerer summons a Skybreaker Battle Standard.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665940,'You have my thanks. We were outnumbered until you arrived.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665941,'Captain Muradin is waiting aboard The Skybreaker. We''ll secure the area until you are ready for take off.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665942,'Skybreaker infantry, hold position!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665943,'A screeching cry pierces the air above!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665944,'A Spire Frostwyrm lands just before The Skybreaker. ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665945,'Fire up the engines! We got a meetin with destiny, lads!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665946,'Hold on to yer hats!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665947,'What in the world is that? Grab me spyglass, crewman!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665948,'By me own beard! HORDE SAILIN IN FAST N HOT!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665949,'EVASIVE ACTION! MAN THE GUNS!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665950,'Cowardly dogs! Ye blindsighted us!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665951,'This is not your battle, dwarf. Back down or we will be forced to destroy your ship.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665952,'Not me battle? I dunnae who ye? think ye are, mister, but I got a score to settle with Arthas and yer not gettin in me way! FIRE ALL GUNS! FIRE! FIRE!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665953,'Reavers, Sergeants, attack!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665954,'What''s this then?! Ye won''t be takin this son o Ironforge''s vessel without a fight!.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665955,'Axethrowers, hurl faster!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665956,'Rocketeers, reload!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665957,'We''re taking hull damage, get a battle-mage out here to shut down those cannons!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665958,'Don''t say I didn''t warn ya, scoundrels! Onward, brothers and sisters!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1665959,'Captain Bartlett, get us out of here! We''re taken too much damage to stay afloat!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'');


DELETE FROM `script_texts` WHERE `entry` BETWEEN -1631077 AND -1631029;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(37200,-1631029, 'Let''s get a move on then! Move ou...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16974,1,0,0, 'SAY_INTRO_ALLIANCE_1'),
(37813,-1631030, 'For every Horde soldier that you killed -- for every Alliance dog that fell, the Lich King''s armies grew. Even now the val''kyr work to raise your fallen as Scourge.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16701,1,0,0, 'SAY_INTRO_ALLIANCE_2'),
(37813,-1631031, 'Things are about to get much worse. Come, taste the power that the Lich King has bestowed upon me!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16702,1,0,0, 'SAY_INTRO_ALLIANCE_3'),
(37200,-1631032, 'A lone orc against the might of the Alliance???',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16970,1,0,0, 'SAY_INTRO_ALLIANCE_4'),
(37200,-1631033, 'Charge!!!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16971,1,0,0, 'SAY_INTRO_ALLIANCE_5'),
(37813,-1631034, 'Dwarves...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16703,1,0,0, 'SAY_INTRO_ALLIANCE_6'),
(37813,-1631035, 'Deathbringer Saurfang immobilizes Muradin and his guards.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_INTRO_ALLIANCE_7'),
(37187,-1631036, 'Kor''kron, move out! Champions, watch your backs. The Scourge have been...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17103,1,0,22, 'SAY_INTRO_HORDE_1'),
(37813,-1631037, 'Join me, father. Join me and we will crush this world in the name of the Scourge -- for the glory of the Lich King!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16704,1,0,0, 'SAY_INTRO_HORDE_2'),
(37187,-1631038, 'My boy died at the Wrath Gate. I am here only to collect his body.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17097,0,0,397, 'SAY_INTRO_HORDE_3'),
(37813,-1631039, 'Stubborn and old. What chance do you have? I am stronger, and more powerful than you ever were.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16705,1,0,5, 'SAY_INTRO_HORDE_4'),
(37187,-1631040, 'We named him Dranosh. It means "Heart of Draenor" in orcish. I would not let the warlocks take him. My boy would be safe, hidden away by the elders of Garadar.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17098,0,0,1, 'SAY_INTRO_HORDE_5'),
(37187,-1631041, 'I made a promise to his mother before she died; that I would cross the Dark Portal alone - whether I lived or died, my son would be safe. Untainted...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17099,0,0,1, 'SAY_INTRO_HORDE_6'),
(37187,-1631042, 'Today, I fulfill that promise.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17100,0,0,397, 'SAY_INTRO_HORDE_7'),
(37187,-1631043, 'High Overlord Saurfang charges!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17104,2,0,53, 'SAY_INTRO_HORDE_8'),
(37813,-1631044, 'Pathetic old orc. Come then heroes. Come and face the might of the Scourge!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16706,1,0,15, 'SAY_INTRO_HORDE_9'),
(37813,-1631045, 'BY THE MIGHT OF THE LICH KING!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16694,1,0,0, 'SAY_AGGRO'),
(37813,-1631046, 'The ground runs red with your blood!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16699,1,0,0, 'SAY_MARK_OF_THE_FALLEN_CHAMPION'),
(37813,-1631047, 'Feast, my minions!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16700,1,0,0, 'SAY_BLOOD_BEASTS'),
(37813,-1631048, 'You are nothing!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16695,1,0,0, 'SAY_KILL_1'),
(37813,-1631049, 'Your soul will find no redemption here!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16696,1,0,0, 'SAY_KILL_2'),
(37813,-1631050, 'Deathbringer Saurfang goes into frenzy!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0, 'SAY_FRENZY'),
(37813,-1631051, 'I have become...DEATH!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16698,1,0,0, 'SAY_BERSERK'),
(37813,-1631052, 'I... Am... Released.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16697,1,0,0, 'SAY_DEATH'),
(37200,-1631053, 'Muradin Bronzebeard gasps for air.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16975,2,0,0, 'SAY_OUTRO_ALLIANCE_1'),
(37200,-1631054, 'That was Saurfang''s boy - the Horde commander at the Wrath Gate. Such a tragic end...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16976,0,0,0, 'SAY_OUTRO_ALLIANCE_2'),
(37200,-1631055, 'What in the... There, in the distance!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16977,0,0,0, 'SAY_OUTRO_ALLIANCE_3'),
(    0,-1631056, 'A Horde Zeppelin flies up to the rise.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_OUTRO_ALLIANCE_4'),
(37200,-1631057, 'Soldiers, fall in! Looks like the Horde are comin'' to take another shot!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16978,1,0,0, 'SAY_OUTRO_ALLIANCE_5'),
(    0,-1631058, 'The Zeppelin docks, and High Overlord Saurfang hops out, confronting the Alliance soldiers and Muradin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_OUTRO_ALLIANCE_6'),
(37200,-1631059, 'Don''t force me hand, orc. We can''t let ye pass.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16972,0,0,0, 'SAY_OUTRO_ALLIANCE_7'),
(37187,-1631060, 'Behind you lies the body of my only son. Nothing will keep me from him.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17094,0,0,0, 'SAY_OUTRO_ALLIANCE_8'),
(37200,-1631061, 'I... I can''t do it. Get back on yer ship and we''ll spare yer life.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16973,0,0,0, 'SAY_OUTRO_ALLIANCE_9'),
(    0,-1631062, 'A mage portal from Stormwind appears between the two and Varian Wrynn and Jaina Proudmoore emerge.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_OUTRO_ALLIANCE_10'),
(37879,-1631063, 'Stand down, Muradin. Let a grieving father pass.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16690,0,0,0, 'SAY_OUTRO_ALLIANCE_11'),
(37187,-1631064, 'High Overlord Saurfang walks over to his son and kneels before his son''s body.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_OUTRO_ALLIANCE_12'),
(37187,-1631065, '[Orcish] No''ku kil zil''nok ha tar.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17096,0,0,0, 'SAY_OUTRO_ALLIANCE_13'),
(37187,-1631066, 'Higher Overlord Saurfang picks up the body of his son and walks over towards Varian',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_OUTRO_ALLIANCE_14'),
(37187,-1631067, 'I will not forget this... kindness. I thank you, Highness',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17095,0,0,0, 'SAY_OUTRO_ALLIANCE_15'),
(37879,-1631068, 'I... I was not at the Wrath Gate, but the soldiers who survived told me much of what happened. Your son fought with honor. He died a hero''s death. He deserves a hero''s burial.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16691,0,0,0, 'SAY_OUTRO_ALLIANCE_16'),
(37188,-1631069, 'Lady Jaina Proudmoore cries.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16651,2,0,18, 'SAY_OUTRO_ALLIANCE_17'),
(37879,-1631070, 'Jaina? Why are you crying?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16692,0,0,0, 'SAY_OUTRO_ALLIANCE_18'),
(37188,-1631071, 'It was nothing, your majesty. Just... I''m proud of my king.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16652,0,0,0, 'SAY_OUTRO_ALLIANCE_19'),
(37879,-1631072, 'Bah! Muradin, secure the deck and prepare our soldiers for an assault on the upper citadel. I''ll send out another regiment from Stormwind.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16693,0,0,0, 'SAY_OUTRO_ALLIANCE_20'),
(37200,-1631073, 'Right away, yer majesty!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16979,0,0,0, 'SAY_OUTRO_ALLIANCE_21'),
(37187,-1631074, 'High Overlord Saurfang coughs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17105,2,0,0, 'SAY_OUTRO_HORDE_1'),
(37187,-1631075, 'High Overlord Saurfang weeps over the corpse of his son.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17106,2,0,15, 'SAY_OUTRO_HORDE_2'),
(37187,-1631076, 'You will have a proper ceremony in Nagrand next to the pyres of your mother and ancestors.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17101,0,0,0, 'SAY_OUTRO_HORDE_3'),
(37187,-1631077, 'Honor, young heroes... no matter how dire the battle... Never forsake it!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17102,0,0,0, 'SAY_OUTRO_HORDE_4');

# 5
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1631090 AND -1631078;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(36626,-1631078, 'NOOOO! You kill Stinky! You pay!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16907,1,0,0, 'SAY_STINKY_DEAD'),
(36626,-1631079, 'Fun time!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16901,1,0,0, 'SAY_AGGRO'),
(36678,-1631080, 'Just an ordinary gas cloud. But watch out, because that''s no ordinary gas cloud!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17119,1,0,432, 'SAY_GASEOUS_BLIGHT'),
(36626,-1631081, 'Festergut farts.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16911,2,0,0, 'EMOTE_GAS_SPORE'),
(36626,-1631082, 'Festergut releases Gas Spores!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0, 'EMOTE_WARN_GAS_SPORE'),
(36626,-1631083, 'Gyah! Uhhh, I not feel so good...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16906,1,0,0, 'SAY_PUNGENT_BLIGHT'),
(36626,-1631084, 'Festergut begins to cast |cFFFF7F00Pungent Blight!|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0, 'EMOTE_WARN_PUNGENT_BLIGHT'),
(36626,-1631085, 'Festergut vomits.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'EMOTE_PUNGENT_BLIGHT'),
(36626,-1631086, 'Daddy, I did it!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16902,1,0,0, 'SAY_KILL_1'),
(36626,-1631087, 'Dead, dead, dead!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16903,1,0,0, 'SAY_KILL_2'),
(36626,-1631088, 'Fun time over!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16905,1,0,0, 'SAY_BERSERK'),
(36626,-1631089, 'Da ... Ddy...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16904,1,0,0, 'SAY_DEATH'),
(36678,-1631090, 'Oh, Festergut. You were always my favorite. Next to Rotface. The good news is you left behind so much gas, I can practically taste it!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17124,1,0,0, 'SAY_FESTERGUT_DEATH');

DELETE FROM `script_texts` WHERE `entry` BETWEEN -1631103 AND -1631091;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(36678,-1631091,'Great news, everyone! The slime is flowing again!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17126,1,0,1,'SAY_ROTFACE_OOZE_FLOOD1'),
(36678,-1631092,'Good news, everyone! I''ve fixed the poison slime pipes!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17123,1,0,1,'SAY_ROTFACE_OOZE_FLOOD2'),
(36678,-1631093,'Terrible news, everyone, Rotface is dead! But great news everyone, he left behind plenty of ooze for me to use! Whaa...? I''m a poet, and I didn''t know it? Astounding!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17146,1,0,0,'SAY_ROTFACE_DEATH'),
(36627,-1631094,'What? Precious? Noooooooooo!!!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16993,1,0,0,'SAY_PRECIOUS_DIES'),
(36627,-1631095,'WEEEEEE!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16986,1,0,0,'SAY_AGGRO'),
(36627,-1631096,'%s begins to cast Slime Spray!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0,'EMOTE_SLIME_SPRAY'),
(36627,-1631097,'Icky sticky.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16991,1,0,0,'SAY_SLIME_SPRAY'),
(36627,-1631098,'|TInterface\Icons\spell_shadow_unstableaffliction_2.blp:16|t%s begins to cast |cFFFF0000Unstable Ooze Explosion!|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0,'EMOTE_UNSTABLE_EXPLOSION'),
(36627,-1631099,'I think I made an angry poo-poo. It gonna blow!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16992,1,0,0,'SAY_UNSTABLE_EXPLOSION'),
(36627,-1631100,'Daddy make toys out of you!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16988,1,0,0,'SAY_KILL_1'),
(36627,-1631101,'I brokes-ded it...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16987,1,0,0,'SAY_KILL_2'),
(36627,-1631102,'Sleepy Time!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16990,1,0,0,'SAY_BERSERK'),
(36627,-1631103,'Bad news daddy...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16989,1,0,0,'SAY_DEATH');


DELETE FROM `script_texts` WHERE `entry` BETWEEN -1631114 AND -1631104;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(36678,-1631104,'Good news, everyone! I think I perfected a plague that will destroy all life on Azeroth!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17114,1,0,0,'SAY_AGGRO'),
(36678,-1631105,'%s begins to cast Unstable Experiment!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0,'EMOTE_UNSTABLE_EXPERIMENT'),
(36678,-1631106,'Two oozes, one room! So many delightful possibilities...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17122,1,0,0,'SAY_PHASE_TRANSITION_HEROIC'),
(36678,-1631107,'Hmm. I don''t feel a thing. Whaa...? Where''d those come from?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17120,1,0,15,'SAY_TRANSFORM_1'),
(36678,-1631108,'Tastes like... Cherry! Oh! Excuse me!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17121,1,0,15,'SAY_TRANSFORM_2'),
(36678,-1631109,'|TInterface\Icons\inv_misc_herb_evergreenmoss.blp:16|t%s cast |cFF00FF00Malleable Goo!|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0,'EMOTE_MALLEABLE_GOO'),
(36678,-1631110,'%s cast |cFFFF7F00Choking Gas Bomb!|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0,'EMOTE_CHOKING_GAS_BOMB'),
(36678,-1631111,'Hmm... Interesting...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17115,1,0,0,'SAY_KILL_1'),
(36678,-1631112,'That was unexpected!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17116,1,0,0,'SAY_KILL_2'),
(36678,-1631113,'Great news, everyone!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17118,1,0,0,'SAY_BERSERK'),
(36678,-1631114,'Bad news, everyone! I don''t think I''m going to make it.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17117,1,0,0,'SAY_DEATH');


DELETE FROM `script_texts` WHERE `entry` BETWEEN -1631139 AND -1631115;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(38004,-1631115,'Foolish mortals. You thought us defeated so easily? The San''layn are the Lich King''s immortal soldiers! Now you shall face their might combined!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16795,1,0,1,'SAY_INTRO_1'),
(38004,-1631116,'Rise up, brothers, and destroy our enemies.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16796,1,0,0,'SAY_INTRO_2'),
(37972,-1631117,'Such wondrous power! The Darkfallen Orb has made me INVINCIBLE!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16727,1,0,0,'SAY_KELESETH_INVOCATION'),
(37972,-1631118,'Invocation of Blood jumps to Prince Keleseth!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0,'EMOTE_KELESETH_INVOCATION'),
(37972,-1631119,'Blood will flow!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16728,1,0,0,'SAY_KELESETH_SPECIAL'),
(37972,-1631120,'Were you ever a threat?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16723,1,0,0,'SAY_KELESETH_KILL_1'),
(37972,-1631121,'Truth is found in death.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16724,1,0,0,'SAY_KELESETH_KILL_2'),
(37972,-1631122,'%s cackles maniacally!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16726,2,0,0,'EMOTE_KELESETH_BERSERK'),
(37972,-1631123,'My queen... they come...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16725,1,0,0,'SAY_KELESETH_DEATH'),
(37973,-1631124,'Tremble before Taldaram, mortals, for the power of the orb flows through me!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16857,1,0,0,'SAY_TALDARAM_INVOCATION'),
(37973,-1631125,'Invocation of Blood jumps to Prince Taldaram!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0,'EMOTE_TALDARAM_INVOCATION'),
(37973,-1631126,'Delight in the pain!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16858,1,0,0,'SAY_TALDARAM_SPECIAL'),
(37973,-1631127,'Inferno Flames speed toward $N!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0,'EMOTE_TALDARAM_FLAME'),
(37973,-1631128,'Worm food.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16853,1,0,0,'SAY_TALDARAM_KILL_1'),
(37973,-1631129,'Beg for mercy!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16854,1,0,0,'SAY_TALDARAM_KILL_2'),
(37973,-1631130,'%s laughs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16856,2,0,0,'EMOTE_TALDARAM_BERSERK'),
(37973,-1631131,'%s gurgles and dies.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16855,2,0,0,'EMOTE_TALDARAM_DEATH'),
(37970,-1631132,'Naxxanar was merely a setback! With the power of the orb, Valanar will have his vengeance!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16685,1,0,0,'SAY_VALANAR_INVOCATION'),
(37970,-1631133,'Invocation of Blood jumps to Prince Valanar!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0,'EMOTE_VALANAR_INVOCATION'),
(37970,-1631134,'My cup runneth over.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16686,1,0,0,'SAY_VALANAR_SPECIAL'),
(37970,-1631135,'%s begins casting Empowered Schock Vortex!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0,'EMOTE_VALANAR_SHOCK_VORTEX'),
(37970,-1631136,'Dinner... is served.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16681,1,0,0,'SAY_VALANAR_KILL_1'),
(37970,-1631137,'Do you see NOW the power of the Darkfallen?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16682,1,0,0,'SAY_VALANAR_KILL_2'),
(37970,-1631138,'BOW DOWN BEFORE THE SAN''LAYN!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16684,1,0,0,'SAY_VALANAR_BERSERK'),
(37970,-1631139,'...why...?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16683,1,0,0,'SAY_VALANAR_DEATH');


INSERT INTO `script_texts`(`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(37955,-1666053,'Is that all you got?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16791,1,0,0,''),
(37955,-1666054,'You have made an... unwise... decision.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16782,1,0,0,''),
(37955,-1666055,'Just a taste...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16783,1,0,0,''),
(37955,-1666056,'Know my hunger!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16784,1,0,0,''),
(37955,-1666057,'SUFFER!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16786,1,0,0,''),
(37955,-1666058,'Can you handle this?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16787,1,0,0,''),
(37955,-1666059,'Yes... feed my precious one! You''re mine now! ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16790,1,0,0,''),
(37955,-1666060,'Here it comes.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16788,1,0,0,''),
(37955,-1666061,'THIS ENDS NOW!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16793,1,0,0,''),
(37955,-1666062,'But... we were getting along... so well...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16794,1,0,0,'');


INSERT INTO `script_texts`(`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(36789,-1666063,'Heroes, lend me your aid! I... I cannot hold them off much longer! You must heal my wounds!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17064,1,0,0,''),
(36789,-1666064,'I have opened a portal into the Emerald Dream. Your salvation lies within, heroes.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17068,1,0,0,''),
(36789,-1666065,'My strength is returning! Press on, heroes!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17070,1,0,0,''),
(36789,-1666066,'I will not last much longer!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17069,1,0,0,''),
(36789,-1666067,'Forgive me for what I do! I... cannot... stop... ONLY NIGHTMARES REMAIN!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17072,1,0,0,''),
(36789,-1666068,'A tragic loss...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17066,1,0,0,''),
(36789,-1666069,'FAILURES!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17067,1,0,0,''),
(36789,-1666070,'I am renewed! Ysera grants me the favor to lay these foul creatures to rest!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17071,1,0,0,'');


INSERT INTO `script_texts`(`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(36853,-1666071,'You are fools to have come to this place! The icy winds of Northrend will consume your souls!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17007,1,0,0,''),
(36853,-1666072,'Suffer, mortals, as your pathetic magic betrays you!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17014,1,0,0,''),
(36853,-1666073,'Can you feel the cold hand of death upon your heart?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17013,1,0,0,''),
(36853,-1666074,'Aaah! It burns! What sorcery is this?!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17015,1,0,0,''),
(36853,-1666075,'Your incursion ends here! None shall survive!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17012,1,0,0,''),
(36853,-1666076,'Now feel my master''s limitless power and despair!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17016,1,0,0,''),
(36853,-1666077,'Perish!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17008,1,0,0,''),
(36853,-1666078,'A flaw of mortality...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17009,1,0,0,''),
(36853,-1666079,'Enough! I tire of these games!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17011,1,0,0,''),
(36853,-1666080,'Free...at last...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17010,1,0,0,'');


INSERT INTO script_texts (npc_entry,entry,content_default,content_loc1,content_loc2,content_loc3,content_loc4,content_loc5,content_loc6,content_loc7,content_loc8,sound,type,language,emote,comment)VALUES
(36597,-1810001, 'So...the Light''s vaunted justice has finally arrived. Shall I lay down Frostmourne and throw myself at your mercy, Fordring?',null,null,null,null,null,null,null,null,17349,1,0,0,''),
(38995,-1810002, 'We will grant you a swift death, Arthas. More than can be said for the thousands you''ve tortured and slain.',null,null,null,null,null,null,null,null,17390,1,0,0,''),
(36597,-1810003, 'You will learn of that first hand. When my work is complete, you will beg for mercy -- and I will deny you. Your anguished cries will be testament to my unbridled power.',null,null,null,null,null,null,null,null,17350,1,0,22,''),
(38995,-1810004, 'So be it. Champions, attack!',null,null,null,null,null,null,null,null,17391,1,0,397,''),
(36597,-1810005, 'I''ll keep you alive to witness the end, Fordring. I would not want the Light''s greatest champion to miss seeing this wretched world remade in my image.',null,null,null,null,null,null,null,null,17351,1,0,0,''),
(38995,-1810006, 'Come then champions, feed me your rage!',null,null,null,null,null,null,null,null,17352,1,0,0,''),
(36597,-1810007, 'I will freeze you from within until all that remains is an icy husk!',null,null,null,null,null,null,null,null,17369,1,0,0,''),
(36597,-1810008, 'Apocalypse!',null,null,null,null,null,null,null,null,17371,1,0,0,''),
(36597,-1810009, 'Bow down before your lord and master!',null,null,null,null,null,null,null,null,17372,1,0,0,''),
(36597,-1810010, 'Hope wanes!',null,null,null,null,null,null,null,null,17363,1,0,0,''),
(36597,-1810011, 'The end has come!',null,null,null,null,null,null,null,null,17364,1,0,0,''),
(36597,-1810012, 'Face now your tragic end!',null,null,null,null,null,null,null,null,17365,1,0,0,''),
(36597,-1810013, 'No question remains unanswered. No doubts linger. You are Azeroth''s greatest champions! You overcame every challenge I laid before you. My mightiest servants have fallen before your relentless onslaught, your unbridled fury... Is it truly righteousness that drives you? I wonder.',null,null,null,null,null,null,null,null,17353,1,0,0,''),
(36597,-1810014, 'You trained them well, Fordring. You delivered the greatest fighting force this world has ever known... right into my hands -- exactly as I intended. You shall be rewarded for your unwitting sacrifice.',null,null,null,null,null,null,null,null,17355,1,0,0,''),
(36597,-1810015, 'Watch now as I raise them from the dead to become masters of the Scourge. They will shroud this world in chaos and destruction. Azeroth''s fall will come at their hands -- and you will be the first to die.',null,null,null,null,null,null,null,null,17356,0,0,0,''),
(36597,-1810016, 'I delight in the irony.',null,null,null,null,null,null,null,null,17357,1,0,0,''),
(38995,-1810017, 'LIGHT, GRANT ME ONE FINAL BLESSING. GIVE ME THE STRENGTH... TO SHATTER THESE BONDS!',null,null,null,null,null,null,null,null,17392,0,0,0,''),
(36597,-1810018, 'Impossible...',null,null,null,null,null,null,null,null,17358,1,0,0,''),
(38995,-1810020, 'No more, Arthas! No more lives will be consumed by your hatred!',null,null,null,null,null,null,null,null,17393,1,0,0,''),
(38579,-1810021, 'Free at last! It is over, my son. This is the moment of reckoning.',null,null,null,null,null,null,null,null,17397,1,0,0,''),
(38995,-1810022, 'The Lich King must fall!',null,null,null,null,null,null,null,null,17389,1,0,0,''),
(38579,-1810023, 'Rise up, champions of the Light!',null,null,null,null,null,null,null,null,17398,1,0,0,''),
(36597,-1810024, 'Now I stand, the lion before the lambs... and they do not fear.',null,null,null,null,null,null,null,null,17361,1,0,0,''),
(36597,-1810025, 'They cannot fear.',null,null,null,null,null,null,null,null,17362,1,0,0,''),
(0,-1810026, 'Argh... Frostmourne, obey me!',null,null,null,null,null,null,null,null,17367,1,0,0,''),
(36597,-1810027, 'Frostmourne hungers...',null,null,null,null,null,null,null,null,17366,1,0,0,''),
(0,-1810028, 'Frostmourne feeds on the soul of your fallen ally!',null,null,null,null,null,null,null,null,17368,1,0,0,''),
(36597,-1810029, 'Val''kyr, your master calls!',null,null,null,null,null,null,null,null,17373,1,0,0,''),
(36597,-1810030, 'Watch as the world around you collapses!',null,null,null,null,null,null,null,null,17370,1,0,0,''),
(36597,-1810031, 'The Lich King begins to cast Defile',null,null,null,null,null,null,null,null,0,3,0,0,'');


UPDATE `script_texts` SET `content_loc8`='Вы здесь потому, что наделены особым знанием: вы понимаете, что на мир пало проклятье слепоты!' WHERE `entry`=-1631011;
UPDATE `script_texts` SET `content_loc8`='Вам удалось сквозь пелену лжи разглядеть источник истиной силы!' WHERE `entry`=-1631012;
UPDATE `script_texts` SET `content_loc8`='Посмотрите на свои руки, задумайтесь над нелепостью их строения!' WHERE `entry`=-1631013;
UPDATE `script_texts` SET `content_loc8`='Кожа, мускулы, кровь, что пульсирует в жилах, все это говорит о вашем не совершенстве, вашей слабостью. Создатели жестоко пошутили над вами!' WHERE `entry`=-1631014;
UPDATE `script_texts` SET `content_loc8`='Чем раньше вы осознаете собственную ущербность, тем скорее выберете иной путь!' WHERE `entry`=-1631015;
UPDATE `script_texts` SET `content_loc8`='Для нашего господина нет ничего невозможного, его сила не знает границ, ничто не может сломить его волю!' WHERE `entry`=-1631016;
UPDATE `script_texts` SET `content_loc8`='Тот, кто откажется повиноваться будет уничтожен. Тот же, кто будет служить ему верой и правдой, достигнет таких высот, о которых вы не в силах даже помыслить!' WHERE `entry`=-1631017;
UPDATE `script_texts` SET `content_loc8`='Как вы смеете ступать в эти священные покои, это место станет вашей могилой!' WHERE `entry`=-1631018;
UPDATE `script_texts` SET `content_loc8`='Довольно! Пришла пора взять все в свои руки!' WHERE `entry`=-1631019;
UPDATE `script_texts` SET `content_loc8`='Прими это благословение и покажи чужакам мощь нашего господина!' WHERE `entry`=-1631022;
UPDATE `script_texts` SET `content_loc8`='Я освобождаю тебя от проклятья плоти, мой верный слуга!' WHERE `entry`=-1631023;
UPDATE `script_texts` SET `content_loc8`='Восстань и обрети истинную форму!' WHERE `entry`=-1631024;
UPDATE `script_texts` SET `content_loc8`='Ты не в силах противится моей воле!' WHERE `entry`=-1631021;
UPDATE `script_texts` SET `content_loc8`='Мне надоел этот фарс!' WHERE `entry`=-1631027;
UPDATE `script_texts` SET `content_loc8`='На все воля господина...Ваша смерть неизбежна...' WHERE `entry`=-1631028;
UPDATE `script_texts` SET `content_loc8`='Вы осознали бессмысленность своих действий?' WHERE `entry`=-1631025;
UPDATE `script_texts` SET `content_loc8`='Ступай во тьму... Вечную тьму!' WHERE `entry`=-1631026;


UPDATE `script_texts` SET `content_loc8`='ВО ИМЯ КОРОЛЯ-ЛИЧА!' WHERE `entry`=-1631045;
UPDATE `script_texts` SET `content_loc8`='Земля обагрится вашей кровью!' WHERE `entry`=-1631046;
UPDATE `script_texts` SET `content_loc8`='Веселитесь, слуги мои!' WHERE `entry`=-1631047;
UPDATE `script_texts` SET `content_loc8`='Ты ничтожество!' WHERE `entry`=-1631048;
UPDATE `script_texts` SET `content_loc8`='Твоя душа не обретет покоя!' WHERE `entry`=-1631049;
UPDATE `script_texts` SET `content_loc8`='Я... Cтал СМЕРТЬЮ!' WHERE `entry`=-1631051;
UPDATE `script_texts` SET `content_loc8`='Я... Освободился.' WHERE `entry`=-1631052;
UPDATE `script_texts` SET `content_loc8`='Все павшие войны Орды. Все дохлые псы Альянса. Все пополнят Армию Короля-лича. Даже сейчас Валь`киры воскрешают ваших покойников, чтобы те стали частью Плети!' WHERE `entry`=-1631030;
UPDATE `script_texts` SET `content_loc8`='Сейчас всё будет ещё хуже. Идите сюда, я покажу вам какой силой меня наделил Король-лич!' WHERE `entry`=-1631031;
UPDATE `script_texts` SET `content_loc8`='Ха-ха-ха! Дворфы...' WHERE `entry`=-1631034;
UPDATE `script_texts` SET `content_loc8`='Присоеденись ко мне, отец. Перейди на мою сторону, и вместе мы разрушим этот мир во имя Плети и во славу Короля-лича!' WHERE `entry`=-1631037;
UPDATE `script_texts` SET `content_loc8`='Старый упрямец. У тебя нет шансов! Я сильнее и могущественнее, чем ты можешь представить!' WHERE `entry`=-1631039;
UPDATE `script_texts` SET `content_loc8`='Жалкий старик! Ну что ж, герои. Хотите узнать, сколь могущественна Плеть?' WHERE `entry`=-1631044;
UPDATE `script_texts` SET `content_loc8`='Один орк против мощи Альянса?' WHERE `entry`=-1631032;
UPDATE `script_texts` SET `content_loc8`='Кор''крон, выдвигайтесь! Герои, будьте начеку. Плеть только что...' WHERE `entry`=-1631036;
UPDATE `script_texts` SET `content_loc8`='Мой мальчик погиб у Врат Гнева. Я здесь, чтобы забрать его тело.' WHERE `entry`=-1631038;
UPDATE `script_texts` SET `content_loc8`='Мы назвали его Дранош - на орочьем это значит "Сердце Дренора". Я бы не позволил чернокнижникам збрать его. Он был бы в безопасности в Гарадаре под защитой старейшин.' WHERE `entry`=-1631040;
UPDATE `script_texts` SET `content_loc8`='Я пообещал его матери, когда она умирала, что пройду через Темный Портал один. неважно, умер бы я или выжил - мой сын остался бы цел. И чист...' WHERE `entry`=-1631041;
UPDATE `script_texts` SET `content_loc8`='Сегодня я исполню это обещание.' WHERE `entry`=-1631042;
UPDATE `script_texts` SET `content_loc8`='Мы похороним тебя как подобает, в Награнде, рядом с матерью и предками...' WHERE `entry`=-1666002;
UPDATE `script_texts` SET `content_loc8`='Помните о чести, герои... какой бы жестокой не была битва... никогда не трекайтесь от неё.' WHERE `entry`=-1666003;
UPDATE `script_texts` SET `content_loc8`='Мурадин защищай палубу, и приготовь солдат к штурму верхних этажей Цитадели. Я вызову из Штормграда подкрепление.' WHERE `entry`=-1665998;
UPDATE `script_texts` SET `content_loc8`='Отступи, Мурадин. Позволь пройти скорбящему отцу.' WHERE `entry`=-1631063;
UPDATE `script_texts` SET `content_loc8`='Я... Я не был у Врат Гнева. Но многое узнал от выживших солдат. Твой сын сражался достойно. Он пал смертью героя. И заслуживает погребения с почестями.' WHERE `entry`=-1631068;
UPDATE `script_texts` SET `content_loc8`='Джайна, почему ты плачешь?' WHERE `entry`=-1631070;


UPDATE `script_texts` SET `content_loc8`='Что? Прелесть? Нееееееееееееет!!!' WHERE `entry`=-1631094;
UPDATE `script_texts` SET `content_loc8`='УУИИИИИИ!' WHERE `entry`=-1631095;
UPDATE `script_texts` SET `content_loc8`='Отличные новости, народ! Слизь снова потекла!' WHERE `entry`=-1631091;
UPDATE `script_texts` SET `content_loc8`='Отличные новости, народ! Я починил трубы для подачи ядовитой слизи!' WHERE `entry`=-1631092;
UPDATE `script_texts` SET `content_loc8`='Папочка сделает новые игрушки из вас!' WHERE `entry`=-1631100;
UPDATE `script_texts` SET `content_loc8`='Я это заломал...' WHERE `entry`=-1631101;
UPDATE `script_texts` SET `content_loc8`='Папочка, не огорчайся…' WHERE `entry`=-1631103;
UPDATE `script_texts` SET `content_loc8`='Я сделал очень злую каку! Сейчас взорвется!' WHERE `entry`=-1631099;


UPDATE `script_texts` SET `content_loc8`='Тухлопуз, ты всегда был моим любимчиком, как и Гниломорд! Молодец, что оставил столько газа. Я его даже чувствую!' WHERE `entry`=-1631090;
UPDATE `script_texts` SET `content_loc8`='Нет! Вы убили Вонючку! Сейчас получите!' WHERE `entry`=-1631078;
UPDATE `script_texts` SET `content_loc8`='Повеселимся?' WHERE `entry`=-1631079;
UPDATE `script_texts` SET `content_loc8`='Что-то мне нехорошо...' WHERE `entry`=-1631083;
UPDATE `script_texts` SET `content_loc8`='Веселью конец!' WHERE `entry`=-1631088;
UPDATE `script_texts` SET `content_loc8`='Па-па...' WHERE `entry`=-1631089;
UPDATE `script_texts` SET `content_loc8`='Мер-твец, мер-твец, мер-твец!' WHERE `entry`=-1631087;
UPDATE `script_texts` SET `content_loc8`='Папочка! У меня получилось!' WHERE `entry`=-1631086;
UPDATE `script_texts` SET `content_loc8`='Это обычное облаго газа, только будьте осторожны, не такое уж оно и обычное!' WHERE `entry`=-1631080;


UPDATE `script_texts` SET `content_loc8`='Отличные новости, народ! Я усовершенствовал штамм чумы, которая уничтожит весь Азерот!' WHERE `entry`=-1666026;
UPDATE `script_texts` SET `content_loc8`='Хм, что-то я ничего не чувствую. Что?! Это еще откуда?' WHERE `entry`=-1666029;
UPDATE `script_texts` SET `content_loc8`='На вкус, как вишенка! ОЙ! Извиниите!' WHERE `entry`=-1666030;
UPDATE `script_texts` SET `content_loc8`='Плохие новости, народ… Похоже, у меня ничего не выйдет…' WHERE `entry`=-1666034;
UPDATE `script_texts` SET `content_loc8`='Герои, вы должны мне помочь! Мои силы... на исходе. Залечите мои раны...' WHERE `entry`=-1666063;
UPDATE `script_texts` SET `content_loc8`='Я открыла портал в Изумруднй Сон. Там вы найдете спасение, герои.' WHERE `entry`=-1666064;
UPDATE `script_texts` SET `content_loc8`='Силы возвращаются ко мне. Герои, ещё немного!' WHERE `entry`=-1666065;
UPDATE `script_texts` SET `content_loc8`='Я долго не продержусь!' WHERE `entry`=-1666066;
UPDATE `script_texts` SET `content_loc8`='Прискорбная потеря...' WHERE `entry`=-1666068;
UPDATE `script_texts` SET `content_loc8`='Простите меня! Я... не могу... оста... ВСЁ ВО ВЛАСТИ КОШМАРА!' WHERE `entry`=-1666067;
UPDATE `script_texts` SET `content_loc8`='НЕУДАЧНИКИ!' WHERE `entry`=-16660690;
UPDATE `script_texts` SET `content_loc8`='Я ИЗЛЕЧИЛАСЬ! Изера, даруй мне силу покончить с этими нечистивыми тварями.' WHERE `entry`=-1666070;



UPDATE `script_texts` SET `content_loc8`='Глупцы, зачем вы сюда явились! Ледяные ветра Нордскола унесут ваши души!' WHERE `entry`=-1666071;
UPDATE `script_texts` SET `content_loc8`='Трепещите, смертные, ибо ваша жалкая магия теперь бессильна!' WHERE `entry`=-1666072;
UPDATE `script_texts` SET `content_loc8`='Вы чувствуете?' WHERE `entry`=-1666073;
UPDATE `script_texts` SET `content_loc8`='Ааах! Жжется! Что это за магия?!' WHERE `entry`=-1666074;
UPDATE `script_texts` SET `content_loc8`='Сейчас вы почуствуете всю мощь нашего господина!' WHERE `entry`=-1666076;
UPDATE `script_texts` SET `content_loc8`='Погибни!' WHERE `entry`=-1666077;
UPDATE `script_texts` SET `content_loc8`='Удел смертных...' WHERE `entry`=-1666078;
UPDATE `script_texts` SET `content_loc8`='Довольно! Я устала от этих игр!' WHERE `entry`=-1666079;
UPDATE `script_texts` SET `content_loc8`='Наконец-то...свободна...' WHERE `entry`=-1666080;


UPDATE `script_texts` SET `content_loc8`='Неужели прибыли наконец хваленые силы Света? Мне бросить Ледяную Скорбь и сдаться на твою милось, Фордринг?' WHERE `entry`=-1810001;
UPDATE `script_texts` SET `content_loc8`='Мы даруем тебе быструю смерть, Артас. Более быструю, чем ты заслуживаешь за то, что замучал и погубил десятки тысяч душ' WHERE `entry`=-1810002;
UPDATE `script_texts` SET `content_loc8`='Ты пройдешь через эти мучения сам. И будешь МОЛИТЬ о пощаде, но я не буду слушать. Твои отчаянные крики послужат доказательством моей безграничной мощи.' WHERE `entry`=-1810003;
UPDATE `script_texts` SET `content_loc8`='Да будет так. Чемпионы, в атаку!' WHERE `entry`=-1810004;
UPDATE `script_texts` SET `content_loc8`='Я оставлю тебя в живых, чтобы ты увидел финал. Не могу допустить, чтобы величайший служитель Света пропустил рождение МОЕГО МИРА.' WHERE `entry`=-1810005;
UPDATE `script_texts` SET `content_loc8`='Я проморожу вас насквозь - и вы разлетитесь на ледяные осколки.' WHERE `entry`=-1810007;
UPDATE `script_texts` SET `content_loc8`='КОНЕЦ СВЕТА!' WHERE `entry`=-1810008;
UPDATE `script_texts` SET `content_loc8`='Склонись перед своим господином и повелителем!.' WHERE `entry`=-1810009;
UPDATE `script_texts` SET `content_loc8`='Надежда тает!' WHERE `entry`=-1810010;
UPDATE `script_texts` SET `content_loc8`='Пришел КОНЕЦ!' WHERE `entry`=-1810011;
UPDATE `script_texts` SET `content_loc8`='Встречайте трагический финал!' WHERE `entry`=-1810012;
UPDATE `script_texts` SET `content_loc8`='Сомнений нет, вы величайшие герои Азерота! Вы преодолели все препятствия, которые я воздвиг перед вами. Сильнейшие из моих слуг пали под вашим натиском, сгорели в пламени вашей ярости!' WHERE `entry`=-1810013;
UPDATE `script_texts` SET `content_loc8`='Ты отлично их обучил, Фордринг! ' WHERE `entry`=-1810014;
UPDATE `script_texts` SET `content_loc8`='Смотри, как я буду всокрешать их, и превращать в воинов Плети! Они повергнут этот мир в пучину хаоса. Азерот падет от их рук! и ты станешь первой жертвой.' WHERE `entry`=-1810015;
UPDATE `script_texts` SET `content_loc8`='Мне по душе эта ирония.' WHERE `entry`=-1810016;
UPDATE `script_texts` SET `content_loc8`='СВЕТ, ДАРУЙ МНЕ ПОСЛЕДНЕЕ БЛАГОСЛОВЛЕНИЕ... ДАЙ МНЕ СИЛЫ РАЗБИТЬ ЭТИ ОКОВЫ!' WHERE `entry`=-1810017;
UPDATE `script_texts` SET `content_loc8`='Невозможно...' WHERE `entry`=-1810018;
UPDATE `script_texts` SET `content_loc8`='Аах! Вы меня и правда ранили. Я слишком долго с вами играл! Испытайте на себе Возмездие СМЕРТИ!' WHERE `entry`=-1666080;
UPDATE `script_texts` SET `content_loc8`='И вот я стою как лев пред агнцами... И не дрожат они.' WHERE `entry`=-1810024;
UPDATE `script_texts` SET `content_loc8`='Им неведом страх.' WHERE `entry`=-1810025;
UPDATE `script_texts` SET `content_loc8`='Ну же герои, в вашей ярости моя сила!' WHERE `entry`=-1810006;
UPDATE `script_texts` SET `content_loc8`='Ледяная Скорбь жаждет крови!' WHERE `entry`=-1810027;
UPDATE `script_texts` SET `content_loc8`='Ледяная Скорбь поглотит душу вашего товарища.' WHERE `entry`=-1810028;
UPDATE `script_texts` SET `content_loc8`='Смотрите как мир рушится вокруг вас!' WHERE `entry`=-1810030;
UPDATE `script_texts` SET `content_loc8`='Валь''кира, твой гсоподин зовет!' WHERE `entry`=-1810029;
UPDATE `script_texts` SET `content_loc8`='Хватит, Артас! Твоя ненависть не заберет больше ни одной жизни!' WHERE `entry`=-1810020;
UPDATE `script_texts` SET `content_loc8`='Вы пришли, что бы вершить суд над Артасом? Что бы уничтожить Короля-лича?' WHERE `entry`=-1666080;
UPDATE `script_texts` SET `content_loc8`='Вы не должны оказаться во власти Ледяной Скорби. Иначе, как и я, будете навек порабощены этим проклятым клинком!' WHERE `entry`=-1666080;
UPDATE `script_texts` SET `content_loc8`='Помогите мне уничтожить эти истерзанные души! Вместе мы вытянем силу из Ледяной Скорби и ослабим Короля-лича!' WHERE `entry`=-1666080;
UPDATE `script_texts` SET `content_loc8`='Наконец я свободен! Всё кончено, сын мой... Настал час расплаты!' WHERE `entry`=-1810021;
UPDATE `script_texts` SET `content_loc8`='Поднимитесь, Воины Света!' WHERE `entry`=-1810023;
UPDATE `script_texts` SET `content_loc8`='Король-лич падет!' WHERE `entry`=-1810022;

-- Кузня душ
-- Яма Сарона
-- Залы отражений
REPLACE INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
   (36497,-1632001,'Finally...a captive audience!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Наконец-то... гости пожаловали!',16595,1,0,0,'Bronjham SAY_AGGRO'),
   (36497,-1632002,'Fodder for the engine!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Скормлю тебя машине!',16596,1,0,0,'Bronjham SAY_SLAY_1'),
   (36497,-1632003,'Another soul to strengthen the host!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Еще одна душа обогатит вместилище.',16597,1,0,0,'Bronjham SAY_SLAY_2'),
   (36497,-1632005,'The vortex of the harvested calls to you!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Вихрь погубленных душ взывает к вам!',16599,1,0,0,'Bronjham SAY_SOUL_STORM'),
   (36497,-1632006,'I will sever the soul from your body!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Я вырву душу из твоего тела!',16600,1,0,0,'Bronjham SAY_CORRUPT_SOUL'),
   (36502,-1632010,'You dare look upon the host of souls? I SHALL DEVOUR YOU WHOLE!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Вы осмелились взглянуть на вместилище душ?! Я СОЖРУ ВАС ЗАЖИВО!',16884,1,0,0,'Devoureur SAY_FACE_ANGER_AGGRO'),
   (36502,-1632011,'You dare look upon the host of souls? I SHALL DEVOUR YOU WHOLE!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Вы осмелились взглянуть на вместилище душ?! Я СОЖРУ ВАС ЗАЖИВО!',16890,1,0,0,'Devoureur SAY_FACE_DESIRE_AGGRO'),
   (36502,-1632012,'Damnation!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Проклинаю тебя!',16885,1,0,0,'Devoureur SAY_FACE_ANGER_SLAY_1'),
   (36502,-1632013,'Damnation!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Проклинаю тебя!',16896,1,0,0,'Devoureur SAY_FACE_SORROW_SLAY_1'),
   (36502,-1632014,'Damnation!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Проклинаю тебя!',16891,1,0,0,'Devoureur SAY_FACE_DESIRE_SLAY_1'),
   (36502,-1632015,'Doomed for eternity!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Обрекаю тебя на вечные муки!',16886,1,0,0,'Devoureur SAY_FACE_ANGER_SLAY_2'),
   (36502,-1632016,'Doomed for eternity!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Обрекаю тебя на вечные муки!',16897,1,0,0,'Devoureur SAY_FACE_SORROW_SLAY_2'),
   (36502,-1632017,'Doomed for eternity!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Обрекаю тебя на вечные муки!',16892,1,0,0,'Devoureur SAY_FACE_DESIRE_SLAY_2'),
   (36502,-1632018,'The swell of souls will not be abated! You only delay the inevitable!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Вместилище душ не ослабнет! Вы лишь пытаетесь отсрочить неизбежное!',16887,1,0,0,'Devoureur SAY_FACE_ANGER_DEATH'),
   (36502,-1632019,'The swell of souls will not be abated! You only delay the inevitable!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Вместилище душ не ослабнет! Вы лишь пытаетесь отсрочить неизбежное!',16898,1,0,0,'Devoureur SAY_FACE_SORROW_DEATH'),
   (36502,-1632020,'The swell of souls will not be abated! You only delay the inevitable!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Вместилище душ не ослабнет! Вы лишь пытаетесь отсрочить неизбежное!',16893,1,0,0,'Devoureur SAY_FACE_DESIRE_DEATH'),
   (36502,-1632023,'SUFFERING! ANGUISH! CHAOS! RISE AND FEED!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'СТРАДАНИЕ! МУЧЕНИЕ! ХАОС! ВОССТАНЬТЕ И ПИРУЙТЕ!',16888,1,0,0,'Devoureur SAY_FACE_ANGER_UNLEASH_SOUL'),
   (36502,-1632024,'SUFFERING! ANGUISH! CHAOS! RISE AND FEED!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'СТРАДАНИЕ! МУЧЕНИЕ! ХАОС! ВОССТАНЬТЕ И ПИРУЙТЕ!',16899,1,0,0,'Devoureur SAY_FACE_SORROW_UNLEASH_SOUL'),
   (36502,-1632025,'SUFFERING! ANGUISH! CHAOS! RISE AND FEED!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'СТРАДАНИЕ! МУЧЕНИЕ! ХАОС! ВОССТАНЬТЕ И ПИРУЙТЕ!',16894,1,0,0,'Devoureur SAY_FACE_DESIRE_UNLEASH_SOUL'),
   (36502,-1632027,'Stare into the abyss, and see your end!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Вглядитесь в бездну, и узрите свою смерть!',16889,1,0,0,'Devoureur SAY_FACE_ANGER_WAILING_SOUL'),
   (36502,-1632028,'Stare into the abyss, and see your end!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Вглядитесь в бездну, и узрите свою смерть!',16895,1,0,0,'Devoureur SAY_FACE_DESIRE_WAILING_SOUL'),
   (38160,-1632029,'Excellent work, champions! We shall set up our base camp in these chambers. My mages will get the Scourge transport device working shortly. Step inside it when you''re ready for your next mission. I will meet you on the other side.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Превосходно. Мы разобьем лагерь в этих покоях. Скоро мои маги заставят портал плети работать. Войдите в него, когда будете готовы к следующему заданию. Я присоединюсь к вам позже...',16625,1,0,0,'Jaina SAY_JAINA_OUTRO'),
   (38161,-1632030,'Excellent work, champions! We shall set up our base camp in these chambers. My mages will get the Scourge transport device working shortly. Step inside when you are ready for your next mission. I will meet you on the other side.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Превосходно. Мы разобьем лагерь в этих покоях. Скоро мои маги заставят портал плети работать. Войдите в него, когда будете готовы к следующему заданию. Я присоединюсь к вам позже...',17044,1,0,0,'Sylvanas SAY_SYLVANAS_OUTRO'),
   (37597,-1632040,'Thank the light for seeing you here safely. We have much work to do if we are to defeat the Lich King and put an end to the Scourge.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Слава свету, вы целы и невредимы. Нам предстоит многое сделать, если мы хотим покончить с Королем Личом и Плетью',16617,0,0,0,'Jaina SAY_INTRO_1'),
   (37597,-1632041,'Our allies within the Argent Crusade and the Knights of the Ebon Blade have broken through the front gate of Icecrown and are attempting to establish a foothold within the Citadel.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Серебряный Авангард и Рыцари Черного Клинка прорвались через главные ворота, и пытаются укрепить свои позиции в Цитадели.',16618,0,0,0,'Jaina SAY_INTRO_2'),
   (37597,-1632042,'Their success hinges upon what we discover in these cursed halls. Although our mission is a wrought with peril, we must persevere!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Успех зависит от того, что мы найдем в этих ужасных залах. Пусть наша миссия опасна, но мы должны выстоять!',16619,0,0,0,'Jaina SAY_INTRO_3'),
   (37597,-1632043,'With the attention of the Lich King drawn toward the front gate, we will be working our way through the side in search of information that will enable us to defeat the Scourge - once and for all.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Пока Король Лич отвлекся на главные ворота, мы проникнем внутрь другим путем, и постараемся узнать, как можно покончить с Плетью раз и навсегда.',16620,0,0,0,'Jaina SAY_INTRO_4'),
   (37597,-1632044,'King Varian''s SI7 agents have gathered information about a private sanctum of the Lich King''s deep within a place called the Halls of Reflection.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Разведчики ШРУ, отправленные Варианом, сообщают, что покои короля находятся в глубине дворца. Это место называется Залами Отражений',16621,0,0,0,'Jaina SAY_INTRO_5'),
   (37597,-1632045,'We will carve a path through this wretched place and find a way to enter the Halls of Reflection. I sense powerful magic hidden away within those walls... Magic that could be the key to destroy the Scourge.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Мы проложим себе путь сквозь это Проклятое место, и найдем вход в Залы Отражений. Я чувствую, что в них сокрыта могущественная магия, которая поможет нам сокрушить Плеть.',16622,0,0,0,'Jaina SAY_INTRO_6'),
   (37597,-1632046,'Your first mission is to destroy the machines of death within this malevolent engine of souls, and clear a path for our soldiers.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ваша первая задача - разрушить машины смерти в этом гнусном механизме душ. Это откроет путь нашим солдатам.',16623,0,0,0,'Jaina SAY_INTRO_7'),
   (37597,-1632047,'Make haste, champions! I will prepare the troops to fall in behind you.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Спешите, герои! Я прикажу солдатам следовать за вами.',16624,0,0,0,'Jaina SAY_INTRO_8'),
   (37596,-1632050,'The Argent Crusade and the Knights of the Ebon Blade have assaulted the gates of Icecrown Citadel and are preparing for a massive attack upon the Scourge. Our missition is a bit more subtle, but equally as important.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Серебряный Авангард и Рыцари Черного Клинка штурмуют ворота Цитадели Ледяной Короны, и готовятся нанести решающий удар. Мы будем действовать незаметно, но не менее эффективно!',17038,0,0,0,'Sylvanas SAY_INTRO_1'),
   (37596,-1632051,'With the attention of the Lich King turned towards the front gate, we''ll be working our way through the side in search of information that will enable us to defeat the Lich King - once and for all.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Пока Король Лич отвлекся на главные ворота, мы проникнем внутрь другим путем и постараемся понять, как можно покончить с ним раз и навсегда!',17039,0,0,0,'Sylvanas SAY_INTRO_2'),
   (37596,-1632052,'Our scouts have reported that the Lich King has a private chamber, outside of the Frozen Throne, deep within a place called the Halls of Reflection. That is our target, champions.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Наши разведчики сообщили, что покои Короля Лича находятся в глубине дворца, неподалеку от Ледяного Трона. Это место называется Залами Отражений. Туда и лежит наш путь.',17040,0,0,0,'Sylvanas SAY_INTRO_3'),
   (37596,-1632053,'We will cut a swath of destruction through this cursed place and find a way to enter the Halls of Reflection. If there is anything of value to be found here, it will be found in the Halls.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Мы проложим себе путь сквозь это Проклятое место, и найдем вход в Залы Отражений. Если в Цитадели и есть что-то достойное внимания, оно ждет нас именно там.',17041,0,0,0,'Sylvanas SAY_INTRO_4'),
   (37596,-1632054,'Your first mission is to destroy the machines of death within this wretched engine of souls, and clear a path for our soldiers.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Вашей первой задачей будет разрушение машин смерти в этом гнусном механизме душ. Это откроет путь нашим солдатам.',17042,0,0,0,'Sylvanas SAY_INTRO_5'),
   (37596,-1632055,'The Dark Lady watches over you. Make haste!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17043,0,0,0,'Sylvanas SAY_INTRO_6'),
   (36494,-1658001,'Tiny creatures under feet, you bring Garfrost something good to eat!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Маленьких букашек тыща принести Гархладу пища... Ха-ха-ха-ха',16912,1,0,0,'garfrost SAY_AGGRO'),
   (36494,-1658002,'Will save for snack. For later.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Оставить на потом. Сейчас не хочу...',16913,1,0,0,'garfrost SAY_SLAY_1'),
   (36494,-1658003,'That one maybe not so good to eat now. Stupid Garfrost! BAD! BAD!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Этот кусок сейчас лучше не есть, глупый Гархлад. Плохой! Плохой!',16914,1,0,0,'garfrost SAY_SLAY_2'),
   (36494,-1658004,'Garfrost hope giant underpants clean. Save boss great shame. For later.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Гархлад надеется, большие штаны чистые. Спасет от большого позора. Пока.',16915,1,0,0,'garfrost SAY_DEATH'),
   (36494,-1658005,'Axe too weak. Garfrost make better and CRUSH YOU!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Топор слабый. Гархлад, сделает другую штуку и раздавит вас',16916,1,0,0,'garfrost SAY_PHASE2'),
   (36494,-1658006,'Garfrost tired of puny mortals. Now your bones will freeze!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Гархлад устал от жалких смертных. Сейчас ваши кости - леденец.',16917,1,0,0,'garfrost SAY_PHASE3'),
   (36658,-1658007,'Another shall take his place. You waste your time.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Его место займет другой. Вы попусту тратите время',16752,1,0,0,'Tyrannus SAY_TYRANNUS_DEATH'),
   (36477,-1658010,'Our work must not be interrupted! Ick! Take care of them!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Нельзя мешать нашей работе! Ик! Займемся ими!',16926,1,0,0,'Krick SAY_AGGRO'),
   (36477,-1658011,'Ooh...We could probably use these parts!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'О-хо-хо... Твои культяпки нам пригодятся!',16927,1,0,0,'Krick SAY_SLAY_1'),
   (36477,-1658012,'Arms and legs are in short supply...Thanks for your contribution!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'У нас как раз кончались руки и ноги... Благодарю за вклад!',16928,1,0,0,'Krick SAY_SLAY_2'),
   (36477,-1658013,'Enough moving around! Hold still while I blow them all up!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Хватит суетиться! Замри, пока я буду их взрывать!',16929,1,0,0,'Krick SAY_BARRAGE_1'),
   (36477,-1658015,'Quickly! Poison them all while they''re still close!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Скорей! Отрави их, пока они близко!',16930,1,0,0,'Krick SAY_POISON_NOVA'),
   (36477,-1658016,'No! That one! That one! Get that one!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Нет же! Целься в этого! Да вот в этого!',16931,1,0,0,'Krick SAY_CHASE_1'),
   (36477,-1658017,'I''ve changed my mind...go get that one instead!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Я... передумал... лучше в этого!',16932,1,0,0,'Krick SAY_CHASE_2'),
   (36477,-1658018,'What are you attacking him for? The dangerous one is over there,fool!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Да что ты к тому привязался? Этот опаснее, тупица!',16933,1,0,0,'Krick SAY_CHASE_3'),
   (36477,-1658030,'Wait! Stop! Don''t kill me, please! I''ll tell you everything!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Подождите! Не убивайте меня, умоляю! Я вам все расскажу!',16934,1,0,0,'Krick SAY_KRICK_OUTRO_1'),
   (36993,-1658031,'I''m not so naive as to believe your appeal for clemency, but I will listen.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Я не так наивна, чтобы верить твоим причитаниям. Но я выслушаю тебя.',16611,1,0,0,'Jaina SAY_JAINA_OUTRO_2'),
   (36990,-1658032,'Why should the Banshee Queen spare your miserable life?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Почему королева Банши должна выслушивать твое нытьё?',17033,1,0,0,'Sylvanas SAY_SYLVANAS_OUTRO_2'),
   (36477,-1658033,'What you seek is in the master''s lair, but you must destroy Tyrannus to gain entry. Within the Halls of Reflection you will find Frostmourne. It... it holds the truth.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'То, что вы ищете, находится в покоях господина, но чтобы попасть туда, вам надо убить Тирания. В Залах Отражений хранится Ледяная Скорбь. В клинке... сокрыта Истина!',16935,1,0,0,'Krick SAY_KRICK_OUTRO_3'),
   (36993,-1658034,'Frostmourne lies unguarded? Impossible!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Меч никто не охраняет? Не может быть.',16612,1,0,0,'Jaina SAY_JAINA_OUTRO_4'),
   (36990,-1658035,'Frostmourne? The Lich King is never without his blade! If you are lying to me...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Король Лич никогда не расстается со своим мечом, если ты мне лжешь...',17034,1,0,0,'Sylvanas SAY_SYLVANAS_OUTRO_4'),
   (36477,-1658036,'I swear it is true! Please, don''t kill me!!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Клянусь это правда! Прошу, не убивайте меня!!',16936,1,0,0,'Krick SAY_KRICK_OUTRO_5'),
   (36658,-1658037,'Worthless gnat! Death is all that awaits you!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Жалкая букашка! Тебя ждет лишь смерть!',16753,1,0,0,'Tyrannus SAY_TYRANNUS_OUTRO_7'),
   (36477,-1658038,'Urg... no!!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Неет!...',16937,1,0,0,'Krick SAY_KRICK_OUTRO_8'),
   (36658,-1658039,'Do not think that I shall permit you entry into my master''s sanctum so easily. Pursue me if you dare.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Не думайте, что я так легко позволю вам пройти в покои господина. Сразитесь со мной, если посмеете.',16754,1,0,0,'Tyrannus SAY_TYRANNUS_OUTRO_9'),
   (36993,-1658040,'What a cruel end. Come, heroes. We must see if the gnome''s story is true. If we can separate Arthas from Frostmourne, we might have a chance at stopping him.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Какая ужасная смерть... Идемте, герои, проверим, правду ли сказал гном. Если нам удастся завладеть Ледяной Скорбью, возможно, мы сумеем остановить Артаса.',16613,1,0,0,'Jaina SAY_JAINA_OUTRO_10'),
   (36990,-1658041,'A fitting end for a traitor. Come, we must free the slaves and see what is within the Lich King''s chamber for ourselves.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Смерть, достойная предателя. Идемте, освободим рабов и увидим своими глазами, что хранится в покоях Короля Лича',17035,1,0,0,'Sylvanas SAY_SYLVANAS_OUTRO_10'),
   (36658,-1658050,'Your pursuit shall be in vain, adventurers, for the Lich King has placed an army of undead at my command! Behold!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Все ваши усилия напрасны, чужаки, ибо Король Лич поставил меня во главе целой армии нежити! Берегитесь!',16755,1,0,0,'Tyrannus SAY_AMBUSH_1'),
   (36658,-1658051,'Persistent whelps! You will not reach the entrance of my lord''s lair! Soldiers, destroy them!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Настырные щенки! Вам не пройти в покои моего господина. Солдаты, уничтожить их!',16756,1,0,0,'Tyrannus SAY_AMBUSH_2'),
   (36658,-1658052,'Rimefang! Trap them within the tunnel! Bury them alive!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Иней, останови их! Похорони их заживо!',16757,1,0,0,'Tyrannus SAY_GAUNTLET_START'),
   (36658,-1658053,'Alas, brave, brave adventurers, your meddling has reached its end. Do you hear the clatter of bone and steel coming up the tunnel behind you? That is the sound of your impending demise.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Увы, бесстрашные герои, ваша навязчивость ускорила развязку. Вы слышите громыхание костей и скрежет стали за вашими спинами? Это предвестники скорой погибели!',16758,1,0,0,'Tyrannus SAY_TYRANNUS_INTRO_1'),
   (36658,-1658055,'Ha, such an amusing gesture from the rabble. When I have finished with you, my master''s blade will feast upon your souls. Die!', NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ха-ха-ха-ха.. кто бы мог ожидать такого от черни. Когда я с вами покончу, клинок господина насытится вашими душами. Умрите!',16759,1,0,0,'Tyrannus SAY_TYRANNUS_INTRO_3'),
   (36658,-1658056,'I shall not fail The Lich King! Come and meet your end!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Я не подведу Короля Лича! Идите ко мне, и встретьте свою смерть!',16760,1, 0,0,'Tyrannus SAY_AGGRO'),
   (36658,-1658057,'Such a shameful display... You are better off dead!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Какое жалкое кривляние... Умри и не позорься!',16761,1,0,0,'Tyrannus SAY_SLAY_1'),
   (36658,-1658058,'Perhaps you should have stayed in the mountains!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Тебе надо было остаться в горах!',16762,1,0,0,'Tyrannus SAY_SLAY_2'),
   (36658,-1658059,'Impossible! Rimefang... Warn...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Не может быть! Иней... предупреди...',16763,1,0,0,'Tyrannus SAY_DEATH'),
   (36658,-1658060,'Rimefang, destroy this fool!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Иней, уничтожь этого глупца!',16764,1,0,0,'Tyrannus SAY_MARK_RIMEFANG_1'),
   (36658,-1658062,'Power... overwhelming!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Меня переполняет мощь!',16765,1,0,0,'Tyrannus SAY_DARK_MIGHT_1'),
   (36993,-1658066,'Heroes, to me!', NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ко мне, герои!',16614,1,0,0,'Jaina SAY_JAYNA_OUTRO_3'),
   (36990,-1658067,'Take cover behind me! Quickly!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Укройтесь за мной! Скорее!',17037,1,0,0,'Sylvanas SAY_SYLVANAS_OUTRO_3'),
   (36993,-1658068,'The Frost Queen is gone. We must keep moving - our objective is near.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Королева льда улетела. Надо продолжать путь - цель уже близка.',16615, 0,0,0,'Jaina SAY_JAYNA_OUTRO_4'),
   (36990,-1658069,'I thought he''d never shut up. At last, Sindragosa silenced that long-winded fool. To the Halls of Reflection, champions! Our objective is near... I can sense it.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Я думала, он никогда не заткнется. Но Синдрагоса заставила этого болтливого дурня умолкнуть. В Залы Отражений, герои!',17036, 0,0,0,'Sylvanas SAY_SYLVANAS_OUTRO_4'),
   (36993,-1658070,'I... I could not save them... Damn you, Arthas! DAMN YOU!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Я... Я не смогла их спасти... Будь ты Проклят, Артас! Будь ты Проклят!',16616, 0,0,0,'Jaina SAY_JAYNA_OUTRO_5'),
   (37221,-1668001,'The chill of this place... Brr... I can feel my blood freezing.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Как же здесь холодно... Брр... Кровь стынет в жилах',16631,1,0,0,'Jaina SAY_JAINA_INTRO_1'),
   (37221,-1668002,'What is that? Up ahead! Could it be... ? Heroes at my side!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Что это там? Впереди! Неужели.. Скорее, герои!',16632,1,0,0,'Jaina SAY_JAINA_INTRO_2'),
   (37221,-1668003,'Frostmourne! The blade that destroyed our kingdom...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ледяная Скорбь! Клинок, разрушивший наше королевство...',16633,1,0,0,'Jaina SAY_JAINA_INTRO_3'),
   (37221,-1668004,'Stand back! Touch that blade and your soul will be scarred for all eternity! I must attempt to commune with the spirits locked away within Frostmourne. Give me space, back up please!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Отойдите! Тот, кто коснется этого клинка, обречет себя на вечные муки! Я попытаюсь заговорить с душами, заключенными в Ледяной Скорби, расступитесь, прошу.',16634,1,0,0,'Jaina SAY_JAINA_INTRO_4'),
   (37225,-1668005,'Jaina! Could it truly be you?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Джайна! Неужели это ты?!',16666,1,0,0,'Uther SAY_UTHER_INTRO_A2_1'),
   (37221,-1668006,'Uther! Dear Uther! ... I... I''m so sorry.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Утер... Милый Утер... Мне... Мне так жаль...',16635,0,0,0,'Jaina SAY_JAINA_INTRO_5'),
   (37225,-1668007,'Jaina you haven''t much time. The Lich King sees what the sword sees. He will be here shortly!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Джайна, у вас мало времени. Король Лич видит все, что видит Ледяная Скорбь. Вскоре он будет здесь!',16667,0,0,0,'Uther SAY_UTHER_INTRO_A2_2'),
   (37221,-1668008,'Arthas is here? Maybe I...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Артас здесь? Может я...',16636,0,0,0,'Jaina SAY_JAINA_INTRO_6'),
   (37225,-1668009,'No, girl. Arthas is not here. Arthas is merely a presence within the Lich King''s mind. A dwindling presence...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Нет, девочка. Артаса здесь нет. Артас - лишь тень, мелькающая в сознании Короля Лича. Смутная тень...',16668,0,0,0,'Uther SAY_UTHER_INTRO_A2_3'),
   (37221,-1668010,'But Uther, if there''s any hope of reaching Arthas. I... I must try.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Но если есть малейшая надежда вернуть Артаса, я должна попытаться',16637,0,0,0,'Jaina SAY_JAINA_INTRO_7'),
   (37225,-1668011,'Jaina, listen to me. You must destroy the Lich King. You cannot reason with him. He will kill you and your allies and raise you all as powerful soldiers of the Scourge.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Джайна, послушай меня. Вам нужно уничтожить Короля Лича. С ним нельзя договориться. Он убьет вас всех и превратит в могущественных воинов плети.',16669,0,0,0,'Uther SAY_UTHER_INTRO_A2_4'),
   (37221,-1668012,'Tell me how, Uther? How do I destroy my prince? My...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Но как, Утер? Как мне убить моего принца? Моего...',16638,0,0,0,'Jaina SAY_JAINA_INTRO_8'),
   (37225,-1668013,'Snap out of it, girl. You must destroy the Lich King at the place where he merged with Ner''zhul - atop the spire, at the Frozen Throne. It is the only way.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Забудь об этом, девочка. Короля Лича нужно уничтожить на том месте, где он слился с Нер` Зулом. На самой вершине, у Ледяного Трона.',16670,0,0,0,'Uther SAY_UTHER_INTRO_A2_5'),
   (37221,-1668014,'You''re right, Uther. Forgive me. I... I don''t know what got a hold of me. We will deliver this information to the King and the knights that battle the Scourge within Icecrown Citadel.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ты прав, Утер. Прости меня, я не знаю, что на меня нашло. Мы передадим твои слова Королю и Рыцарям, которые сражаются с Плетью, в Цитадели Ледяной Короны.',16639,0,0,0,'Jaina SAY_JAINA_INTRO_9'),
   (37225,-1668015,'There is... something else that you should know about the Lich King. Control over the Scourge must never be lost. Even if you were to strike down the Lich King, another would have to take his place. For without the control of its master, the Scourge would run rampant across the world - destroying all living things.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Тебе нужно... знать еще кое-что о Короле Личе. Плеть не должна выйти из-под контроля! Даже если вы убьете Короля Лича, кто-то должен будет занять его место. Без Короля, Плеть налетит на мир, как стая саранчи, и уничтожит все живое!...',16671,0,0,0,'Uther SAY_UTHER_INTRO_A2_6'),
   (37225,-1668016,'A grand sacrifice by a noble soul...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Великая жертва, благородной души...',16672,0,0,0,'Uther SAY_UTHER_INTRO_A2_7'),
   (37221,-1668017,'Who could bear such a burden?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Кому по силам такое бремя?',16640,0,0,0,'Jaina SAY_JAINA_INTRO_10'),
   (37225,-1668018,'I do not know, Jaina. I suspect that the piece of Arthas that might be left inside the Lich King is all that holds the Scourge from annihilating Azeroth.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Не знаю, Джайна. Мне кажется если бы не Артас, который все еще является частью Короля Лича, Плеть давно бы уже уничтожила Азерот.',16673,0,0,0,'Uther SAY_UTHER_INTRO_A2_8'),
   (37221,-1668019,'Then maybe there is still hope...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Но может еще есть надежда...',16641,0,0,0,'Jaina SAY_JAINA_INTRO_11'),
   (37225,-1668020,'No, Jaina! Aargh! He... He is coming! You... You must...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Нет, Джайна! Ааааа! Он... Он приближается! Вы... Вы должны...',16674,0,0,0,'Uther SAY_UTHER_INTRO_A2_9'),
   (37223,-1668021,'I... I don''t believe it! Frostmourne stands before us, unguarded! Just as the Gnome claimed. Come, heroes!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Я... Я не верю своим глазам! Ледяная скорбь перед нами, безо всякой охраны, как и говорил гном. Вперед, герои!',17049,1,0,0,'Sylvanas SAY_SYLVANAS_INTRO_1'),
   (37223,-1668022,'Standing this close to the blade that ended my life... The pain... It is renewed.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Боль снова захлестывает меня, когда я вижу так близко меч, отнявший у меня жизнь.',17050,1,0,0,'Sylvanas SAY_SYLVANAS_INTRO_2'),
   (37223,-1668023,'I dare not touch it. Stand back! Stand back as I attempt to commune with the blade! Perhaps our salvation lies within...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Я не смею его коснуться. Назад! Отступите, я попробую установить связь с мечом! Возможно, спасение находится внутри...',17051,1,0,0,'Sylvanas SAY_SYLVANAS_INTRO_3'),
   (37225,-1668024,'Careful, girl. I''ve heard talk of that cursed blade saving us before. Look around you and see what has been born of Frostmourne.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Осторожней, девочка. Однажды мне уже говорили, что этот Проклятый меч может нас спасти. Посмотри вокруг, и ты увидишь, что из этого вышло.',16659,0,0,0,'Uther SAY_UTHER_INTRO_H2_1'),
   (37223,-1668025,'Uther...Uther the Lightbringer. How...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Утер... Утер Светоносный... Как...',17052,0,0,0,'Sylvanas SAY_SYLVANAS_INTRO_4'),
   (37225,-1668026,'You haven''t much time. The Lich King sees what the sword sees. He will be here shortly.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'У вас мало времени. Король Лич видит все, что видит Ледяная Скорбь. Вскоре он будет здесь!',16660,0,0,0,'Uther SAY_UTHER_INTRO_H2_2'),
   (37223,-1668027,'The Lich King is here? Then my destiny shall be fulfilled today!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Король Лич здесь?! Значит, моя судьба решится сегодня!',17053,0,0,0,'Sylvanas SAY_SYLVANAS_INTRO_5'),
   (37225,-1668028,'You cannot defeat the Lich King. Not here. You would be a fool to try. He will kill those who follow you and raise them as powerful servants of the Scourge. But for you, Sylvanas, his reward for you would be worse than the last.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Вам не победить Короля Лича. По крайней мере, не здесь. Глупо и пытаться. Он убьет твоих соратников, и воскресит их как воинов плети. Но что до тебя, Сильвана, он готовит тебе участь еще страшнее, чем в прошлый раз',16661,0,0,0,'Uther SAY_UTHER_INTRO_H2_3'),
   (37223,-1668029,'There must be a way... ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Должен быть способ...',17054,0,0,0,'Sylvanas SAY_SYLVANAS_INTRO_6'),
   (37225,-1668030,'Perhaps, but know this: there must always be a Lich King. Even if you were to strike down Arthas, another would have to take his place, for without the control of the Lich King, the Scourge would wash over this world like locusts, destroying all that they touched.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Возможно, но знай: Король Лич должен быть всегда. Даже если вы убьете Артаса, кто-то обязан будет занять его место. Лишившись правителя, Плеть налетит на мир как стая саранчи, и разрушит все на своем пути!',16662,0,0,0,'Uther SAY_UTHER_INTRO_H2_4'),
   (37223,-1668031,'Who could bear such a burden?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Кому по силам такое бремя?',17055,0,0,0,'Sylvanas SAY_SYLVANAS_INTRO_7'),
   (37225,-1668032,'I do not know, Banshee Queen. I suspect that the piece of Arthas that might be left inside the Lich King is all that holds the Scourge from annihilating Azeroth.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Не знаю, Королева Банши. Если бы не Артас, который все еще является частью Короля Лича, Плеть давно бы уже уничтожила Азерот.',16663,0,0,0,'Uther SAY_UTHER_INTRO_H2_5'),
   (37225,-1668033,'Alas, the only way to defeat the Lich King is to destroy him at the place he was created.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Увы, единственный способ одолеть Короля Лича - это убить его там, где он был порожден.',16664,0,0,0,'Uther SAY_UTHER_INTRO_H2_6'),
   (37223,-1668034,'The Frozen Throne...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ледяной Трон...',17056,0,0,0,'Sylvanas SAY_SYLVANAS_INTRO_8'),
   (37225,-1668035,'I... Aargh... He... He is coming... You... You must...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Да... Аааа... Он... Он приближается... Вы... Вы должны...',16665,0,0,0,'Uther SAY_UTHER_INTRO_H2_7'),
   (37226,-1668036,'SILENCE, PALADIN!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ЗАМОЛЧИ, ПАЛАДИН!',17225,1,0,0,'Lich King SAY_LK_INTRO_1'),
   (37226,-1668037,'So you wish to commune with the dead? You shall have your wish.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Так ты хочешь поговорить с мертвыми? Нет ничего проще.',17226,1,0,0,'Lich King SAY_LK_INTRO_2'),
   (37226,-1668038,'Falric. Marwyn. Bring their corpses to my chamber when you are through.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Фалрик, Марвин, когда закончите, принесите их тела в мои покои.',17227,1,0,0,'Lich King SAY_LK_INTRO_3'),
   (38112,-1668039,'As you wish, my lord.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Как пожелаете, мой Господин',16717,1,0,0,'Falric SAY_FALRIC_INTRO_1'),
   (38113,-1668040,'As you wish, my lord.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Как пожелаете, мой Господин',16741,1,0,0,'Marwyn SAY_MARWYN_INTRO_1'),
   (38112,-1668041,'Soldiers of Lordaeron, rise to meet your master''s call!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Солдаты Лордерона, восстаньте по зову господина',16714,1,0,0,'Falric SAY_FALRIC_INTRO_2'),
   (37221,-1668042,'You won''t deny me this Arthas! I must know! I must find out!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ты от меня не отмахнешься, Артас! Я должна понять! Я должна знать!',16642,1,0,0,'Jaina SAY_JAINA_INTRO_END'),
   (37223,-1668043,'You will not escape me that easily, Arthas! I will have my vengeance!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ты так просто от меня не уйдешь, Артас! Я отомщу тебе!',17057,1,0,0,'Sylvanas SAY_SYLVANAS_INTRO_END'),
   (38112,-1668050,'Men, women and children... None were spared the master''s wrath. Your death will be no different.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Мужчины, женщины и дети... Никто не избежал гнева господина. Вы разделите их участь.',16710,1,0,0,'Falric SAY_AGGRO'),
   (38112,-1668051,'Sniveling maggot!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Сопливый червяк!',16711,1,0,0,'Falric SAY_SLAY_1'),
   (38112,-1668052,'The children of Stratholme fought with more ferocity!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Стратхольмские детишки, и те защищались отчаяннее.',16712,1,0,0,'Falric SAY_SLAY_2'),
   (38112,-1668053,'Marwyn, finish them...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Марвин, добей их...',16713,1,0,0,'Falric SAY_DEATH'),
   (38112,-1668054,'Despair... so delicious...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Как сладостно... отчаяние...',16715,1,0,0,'Falric SAY_IMPENDING_DESPAIR'),
   (38112,-1668055,'Fear... so exhilarating...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Как приятен... страх...',16716,1,0,0,'Falric SAY_DEFILING_HORROR'),
   (38113,-1668060,'Death is all that you will find here!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Вы найдете здесь лишь смерть!',16734,1,0,0,'Marwyn SAY_AGGRO'),
   (38113,-1668061,'I saw the same look in his eyes when he died. Terenas could hardly believe it. Hahahaha!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'У Теренаса был такой же взгляд в миг смерти. Он никак не мог поверить. Хахахахаха!',16735,1,0,0,'Marwyn SAY_SLAY_1'),
   (38113,-1668062,'Choke on your suffering!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Захлебнись страданием!',16736,1,0,0,'Marwyn SAY_SLAY_2'),
   (38113,-1668063,'Yes... Run... Run to meet your destiny... Its bitter, cold embrace, awaits you.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Да... Бегите навстречу судьбе... Ее жестокие, холодные объятия, ждут вас.',16737,1,0,0,'Marwyn SAY_DEATH'),
   (38113,-1668064,'Your flesh has decayed before your very eyes!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Вы увидите, как разлагается ваша плоть!',16739,1,0,0,'Marwyn SAY_CORRUPTED_FLESH_1'),
   (38113,-1668065,'Waste away into nothingness!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Сгиньте без следа!',16740,1,0,0,'Marwyn SAY_CORRUPTED_FLESH_2'),  
-- Испытание Крестоносца
(0,-1649070,'Welcome champions, you have heard the call of the Argent Crusade and you have boldly answered. It is here in the crusaders coliseum that you will face your greatest challenges. Those of you who survive the rigors of the coliseum will join the Argent Crusade on its marsh to ice crown citadel.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Добро пожаловать, герои, вы услышали призыв Серебряного Авангарда и без колебаний откликнулись на него. В этом Колизее вам предстоит сразиться с опаснейшими противниками. Те, из вас, кто смогут пережить испытания, войдут в ряды Серебряного Авангарда, который направится в Цитадель Ледяной Короны',16036,1,0,0,'34996'),
(0,-1649072,'Your beast will be no match for my champions Tirion!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Твои чудовища не чета героям альянса, Тирион!',16069,1,0,0,'34990'),
(0,-1649073,'I have seen  more  worthy  challenges in the ring of blood, you waste our time paladin.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Я видел и более достойных соперников в багровом круге, ты напрасно тратишь наше время, паладин.',16026,1,0,0,'34995'),
(0,-1649071,'Hailing from the deepest, darkest carverns of the storm peaks, Gormok the Impaler! Battle on, heroes!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Из самых глубоких и темных пещер Грозовой Гряды, был призван Гормок Пронзающий Бивень! В бой, герои!',16038,1,0,0,'34996'),
(0,-1649074,'Steel yourselves, heroes, for the twin terrors Acidmaw and Dreadscale. Enter the arena!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Приготовьтесь к схватке с близнецами чудовищами. Кислотной Утробой и Жуткой Чешуей',16039,1,0,0,'34996'),
(0,-1649075,'The air freezes with the introduction of our next combatant, Icehowl! Kill or be killed, champions!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'В воздухе повеяло ледяным дыханием следующего бойца. На арену выходит Ледяной Рев! Сражайтесь или погибните, герои!',16040,1,0,0,'34996'),
(0,-1649076,'The monstrous menagerie has been vanquished!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Все чудовища повержены!',16041,1,0,0,'34996'),
(0,-1649080,'Grand Warlock Wilfred Fizzlebang will summon forth your next challenge. Stand by for his entry!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Сейчас великий чернокнижник Вилфред Непопамс призовет вашего нового противника. Готовьтесь к бою!',16043,1,0,0,'34996'),
(0,-1649081,'Thank you, Highlord! Now challengers, I will begin the ritual of summoning! When I am done, a fearsome Doomguard will appear!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Благодарю, Верховный Лорд! А теперь, смельчаки, я приступаю к ритуалу призыва! Когда я закончу, появится грозный Демон!',16268,1,0,0,'35458'),
(0,-1649082,'Prepare for oblivion!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Готовьтесь к забвению!',16269,1,0,0,'35458'),
(0,-1649083,'Ah ha! Behold the absolute power of Wilfred Fizzlebang, master summoner! You are bound to ME, demon!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ага! Получилось! Трепещи перед всевластным Вилфредом Непопамсом, мастером призыва! Ты покорен МНЕ, демон!',16270,1,0,0,'35458'),
(0,-1649030,'Trifling gnome, your arrogance will be your undoing!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ничтожный гном, тебя погубит твоя самоуверенность!',16143,1,0,0,'34780'),
(0,-1649084,'But I am in charge here-',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Тут я главный... Аааа...',16271,1,0,0,'35458'),
(0,-1649031,'You face Jaraxxus, eredar lord of the Burning Legion!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Перед вами Джераксус, Эредарский повелитель Пылающего Легиона!',16144,1,0,0,'34780'),
(0,-1649037,'Come forth, sister! Your master calls!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Явись, сестра! Господин зовет!',16150,1,0,0,'34780'),
(0,-1649039,'INFERNO!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ИНФЕРНАЛ!',16151,1,0,0,'34780'),
(0,-1649032,'Another will take my place. Your world is doomed.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Мое место займут другие. Ваш мир обречен.',16147,1,0,0,'34780'),
(0,-1649088,'Treacherous Alliance dogs! You summon a demon lord against warriors of the Horde!? Your deaths will be swift!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Подлые собаки Альянса! Вы выпустили повелителя демонов на воинов Орды!? Ваша смерть будет быстрой!',16021,1,0,0,'34995'),
(0,-1649089,'The Alliance doesnt need the help of a demon lord to deal with Horde filth. Come, pig!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Альянсу не нужна помощь повелителя демонов, чтобы справиться с Ордынским отродьем. Пёс!',16064,1,0,0,'34990'),
(0,-1649087,'The loss of Wilfred Fizzlebang, while unfortunate, should be a lesson to those that dare dabble in dark magic. Alas, you are victorious and must now face the next challenge.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Гибель Вилфреда Непопамса весьма трагична, и должна послужить уроком тем, кто смеет беспечно играть с темной магией. К счастью вы победили демона, и теперь вас ждет новый противник!',16045,1,0,0,'34996'),
(0,-1649090,'Everyone, calm down! Compose yourselves! There is no conspiracy at play here. The warlock acted on his own volition - outside of influences from the Alliance. The tournament must go on!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Тише, успокойтесь! Никакого заговора здесь нет. Чернокнижник заигрался - и поплатился за это. Турнир продолжается!',16046,1,0,0,'34996'),
(0,-1649091,'The next battle will be against the Argent Crusades most powerful knights! Only by defeating them will you be deemed worthy...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'В следующем бою вы встретитесь с могучими рыцарями Серебряного Авангарда. Лишь победив, их вы заслужите достойную награду...',16047,1,0,0,'34996'),
(0,-1649092,'Our honor has been besmirched! They make wild claims and false accusations against us. I demand justice! Allow my champions to fight in place of your knights, Tirion. We challenge the Horde!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Они хотели запятнать честь Альянса! Они пытались нас оклеветать. Я требую справедливости! Тирион, позволь моим чемпионам сражаться вместо твоих рыцарей. Мы бросаем вызов Орде!',16066,1,0,0,'34990'),
(0,-1649093,'The Horde demands justice! We challenge the Alliance. Allow us to battle in place of your knights, paladin. We will show these dogs what it means to insult the Horde!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Орда требует справедливости! Мы вызываем Альянс на бой. Позволь нам встать на место твоих рыцарей, паладин. Мы покажем этим псам, как оскорблять орду!',16023,1,0,0,'34995'),
(0,-1649094,'Very well, I will allow it. Fight with honor!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Хорошо, да будет так. Сражайтесь с честью.',16048,1,0,0,'34996'),
(0,-1649095,'Fight for the glory of the Alliance, heroes! Honor your king and your people!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Сражайтесь во славу Альянса, герои! Во имя вашего короля!',16065,1,0,0,'34990'),
(0,-1649096,'Show them no mercy, Horde champions! LOK-TAR OGAR!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Не щадите никого, герои Орды! ЛОК-ТАР ОГАР!',16022,1,0,0,'34995'),
(0,-1649097,'GLORY OF THE ALLIANCE!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'СЛАВА АЛЬЯНСУ!',16067,1,0,0,'34990'),
(0,-1649098,'LOK-TAR OGAR!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ЛОК-ТАР ОГАР!',16024,1,0,0,'34995'),
(0,-1649099,'A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Пустая и горькая победа. После сегодняшних потерь мы стали слабее как целое. Кто еще кроме Короля Лича выиграет от подобной глупости? Пали великие воины. И ради чего? Истинная опасность еще впереди - нас ждет битва с Королем Личом.',16049,1,0,0,'34996'),
(0,-1649100,'Only by working together will you overcome the final challenge. From the depths of Icecrown come two of the Scourges most powerful lieutenants: fearsome valkyr, winged harbingers of the Lich King!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Лишь сплотившись, вы сможете пройти следующее испытание. Из глубин Ледяной Короны навстречу вам подымаются две могучие воительницы Плети: жуткие валькиры, крылатые вестницы Короля Лича!',16050,1,0,0,'34996'),
(0,-1649101,'Let the games begin!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Пусть состязания начнутся!',16037,1,0,0,'34996'),
(0,-1649040,'In the name of our dark master. For the Lich King. You. Will. Die.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Во имя темного повелителя. Во имя Короля Лича. Вы умрете!',16272,1,0,0,'34497'),
(0,-1649041,'The Scourge cannot be stopped...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Плеть не остановить...',16275,1,0,0,'34496'),
(0,-1649050,'Let the dark consume you!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Да поглотит вас тьма!',16278,1,0,0,'34496'),
(0,-1649048,'Let the light consume you!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Да поглотит вас свет!',16279,1,0,0,'34496'),
(0,-1649103,'Do you still question the might of the horde paladin? We will take on all comers.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ты все еще сомневаешься в могуществе Орды, паладин? Мы примем любой вызов.',16025,1,0,0,'34995'),
(0,-1649104,'A mighty blow has been dealt to the Lich King! You have proven yourselves able bodied champions of the Argent Crusade. Together we will strike at Icecrown Citadel and destroy what remains of the Scourge! There is no challenge that we cannot face united!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Король Лич понес тяжелую потерю! Вы проявили себя как бесстрашные герои Серебряного Авангарда. Мы вместе нанесем удар по Цитадели Ледяной Короны и разнесем в клочья остатки Плети! Нет такого испытания, которое мы бы не могли пройти сообща!',16051,1,0,0,'34996'),
(0,-1649105,'You will have your challenge, Fordring.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Будет тебе такое испытание, Фордринг.',16321,1,0,0,'35877'),
(0,-1649106,'Arthas! You are hopelessly outnumbered! Lay down Frostmourne and I will grant you a just death.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Артас! Нас гораздо больше! Сложи Ледяную Скорбь, и я подарю тебе заслуженную смерть.',16052,1,0,0,'34996'),
(0,-1649107,'The Nerubians built an empire beneath the frozen wastes of Northrend. An empire that you so foolishly built your structures upon. MY EMPIRE.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Нерубианцы воздвигли целую империю под льдами Нордскола. Империю, на которой вы так бездумно построили свои дома. МОЮ ИМПЕРИЮ.',16322,1,0,0,'35877'),
(0,-1649108,'The souls of your fallen champions will be mine, Fordring.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Души твоих павших чемпионов будут принадлежать мне, Фордринг.',16323,1,0,0,'35877'),
(0,-1649102,'Not even the Lich King most powerful minions can stand against the Alliance! All hail our victors!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Против Альянса не выстоять даже самым сильным прислужникам Короля Лича! Все славьте наших героев!',16068,1,0,0,'34990'),
(0,-1649056,'This place will serve as your tomb!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Это место станет вашей могилой!',16234,1,0,0,'34564'),
(0,-1649063,'The swarm shall overtake you!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Стая поглотит вас!',16241,1,0,0,'34564'),
(0,-1649059,'I have failed you, master...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Я подвел тебя, господин...',16238,1,0,0,'34564');  


-- fix mobs aggro for keldelar quest npc
UPDATE `quest_template` SET `SourceSpellId` = '70974' WHERE `Id` =20439;
UPDATE `creature_template` SET `flags_extra` = '2' WHERE `entry` = 31885;
UPDATE `creature_template` SET `flags_extra` = '2' WHERE `entry` = 31886;
UPDATE `creature_template` SET `flags_extra` = '2' WHERE `entry` = 31557;
UPDATE `creature_template` SET `flags_extra` = '2' WHERE `entry` = 32419;
UPDATE `creature_template` SET `flags_extra` = '2' WHERE `entry` = 32420;
UPDATE `creature_template` SET `flags_extra` = '2' WHERE `entry` = 32253;
UPDATE `creature_template` SET `flags_extra` = '2' WHERE `entry` = 32415;
UPDATE `creature_template` SET `flags_extra` = '2' WHERE `entry` = 32412;
UPDATE `creature_template` SET `flags_extra` = '2' WHERE `entry` = 32251;
UPDATE `creature_template` SET `flags_extra` = '2' WHERE `entry` = 32252;
UPDATE `quest_template` SET `SourceSpellId` = '70972' WHERE `Id` =24451;
UPDATE `creature_template` SET `flags_extra` = '2' WHERE `entry` = 35507;
UPDATE `creature_template` SET `flags_extra` = '2' WHERE `entry` = 31580;
UPDATE `creature_template` SET `flags_extra` = '2' WHERE `entry` = 31579;
UPDATE `creature_template` SET `flags_extra` = '2' WHERE `entry` = 35494;
UPDATE `creature_template` SET `flags_extra` = '2' WHERE `entry` = 37942;
UPDATE `creature_template` SET `flags_extra` = '2' WHERE `entry` = 33964;  

-- Fix Shadowmeld
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_gen_shadowmeld';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES	
(58984,'spell_gen_shadowmeld');

-- Anticheat
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('anticheat global', '2', 'Syntax: .anticheat 
global returns the total amount reports and the average. (top three players)'), ('anticheat player', '2', 
'Syntax: .anticheat player $name returns the players''s total amount of warnings, the average and the 
amount of each cheat type.'), ('anticheat handle', '2', 'Syntax: .anticheat handle [on|off] Turn on/off the 
AntiCheat-Detection .'),
('anticheat delete', '2', 'Syntax: .anticheat delete [deleteall|$name] Deletes the report records of all the players or deletes all the reports of player $name.');

-- A Suitable Disguise
SET @ENTRY := 36856;
SET @SOURCETYPE := 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,1,0,62,0,100,0,10854,0,0,0,56,49648,1,0,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,"Alliance"),
(@ENTRY,@SOURCETYPE,2,0,62,0,100,0,10854,1,0,0,56,49648,1,0,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,"Horde");

-- Fix quest 11676
UPDATE quest_template SET RequiredSpellCast1=45807 WHERE id=11676;

-- Fix quest 11310
UPDATE `creature_template` SET `KillCredit1`=24274 WHERE `entry` IN (23564, 24198, 24199);

-- naxramas

UPDATE `script_texts` SET `content_loc8`='Спаси… бо…' WHERE (`npc_entry`='15928') AND (`entry`='-1533035');
UPDATE `script_texts` SET `content_loc8`='Теперь… умри!!!' WHERE (`npc_entry`='15928') AND (`entry`='-1533033');
UPDATE `script_texts` SET `content_loc8`='Я сожру… ваши… кости…' WHERE (`npc_entry`='15928') AND (`entry`='-1533031');
UPDATE `script_texts` SET `content_loc8`='Убью…' WHERE (`npc_entry`='15928') AND (`entry`='-1533030');
UPDATE `script_texts` SET `content_loc8`='Растерзаю!!!' WHERE (`npc_entry`='15928') AND (`entry`='-1533032');


-- Великая вдова Фарлина

UPDATE `script_texts` SET `content_loc8`='Господин отомстит за меня!' WHERE (`npc_entry`='15953') AND (`entry`='-1533016');
UPDATE `script_texts` SET `content_loc8`='Бегите, пока еще можете!!' WHERE (`npc_entry`='15953') AND (`entry`='-1533013');
UPDATE `script_texts` SET `content_loc8`='Ваши дряхлые жизни, ваши бренные желания ничего не значат… теперь вы – адепты господина! Вы будете служить нашему делу, не спрашивая ни о чем! Умереть за господина – величайшая доблесть!' WHERE (`npc_entry`='15953') AND (`entry`='-1533009');
UPDATE `script_texts` SET `content_loc8`='Убейте их во имя господина!' WHERE (`npc_entry`='15953') AND (`entry`='-1533010');
UPDATE `script_texts` SET `content_loc8`='Вам не скрыться от меня!' WHERE (`npc_entry`='15953') AND (`entry`='-1533011');
UPDATE `script_texts` SET `content_loc8`='Склонитесь передо мной, черви!' WHERE (`npc_entry`='15953') AND (`entry`='-1533012');
UPDATE `script_texts` SET `content_loc8`='Тебе не повезло!' WHERE (`npc_entry`='15953') AND (`entry`='-1533014');
UPDATE `script_texts` SET `content_loc8`='Жалкое ничтожество!' WHERE (`npc_entry`='15953') AND (`entry`='-1533015');

-- Нот Чумной

UPDATE `script_texts` SET `content_loc8`='Я буду служить господину… даже после смерти!' WHERE (`npc_entry`='15954') AND (`entry`='-1533081');
UPDATE `script_texts` SET `content_loc8`='Встаньте, мои воины! Встаньте и сражайтесь вновь!' WHERE (`npc_entry`='15954') AND (`entry`='-1533078');
UPDATE `script_texts` SET `content_loc8`='Дело сделано!' WHERE (`npc_entry`='15954') AND (`entry`='-1533079');
UPDATE `script_texts` SET `content_loc8`='Смерть чужакам!' WHERE (`npc_entry`='15954') AND (`entry`='-1533077');
UPDATE `script_texts` SET `content_loc8`='Этот вздох был для тебя последним!' WHERE (`npc_entry`='15954') AND (`entry`='-1533080');
UPDATE `script_texts` SET `content_loc8`='Слава господину!' WHERE (`npc_entry`='15954') AND (`entry`='-1533075');
UPDATE `script_texts` SET `content_loc8`='Прощайся с жизнью!' WHERE (`npc_entry`='15954') AND (`entry`='-1533076');

-- Ануб'Рекан

UPDATE `script_texts` SET `content_loc8`='Ш-ш-ш… скоро все будет кончено.' WHERE (`npc_entry`='15956') AND (`entry`='-1533008');
UPDATE `script_texts` SET `content_loc8`='Подойдите ближе. Лакомые кусочки. Я слишком долго мечтал о еде. И крови.' WHERE (`npc_entry`='15956') AND (`entry`='-1533007');
UPDATE `script_texts` SET `content_loc8`='Кого мне съесть первым? Сложный выбор… Все они пахнут так вкусно…' WHERE (`npc_entry`='15956') AND (`entry`='-1533006');
UPDATE `script_texts` SET `content_loc8`='Куда идти? Что делать? Выбирайте, но все пути ведут к боли… и смерти.' WHERE (`npc_entry`='15956') AND (`entry`='-1533005');
UPDATE `script_texts` SET `content_loc8`='Я слышу биение маленьких сердец. Да… теперь они бьются быстрее… Но скоро они остановятся.' WHERE (`npc_entry`='15956') AND (`entry`='-1533004');
UPDATE `script_texts` SET `content_loc8`='Посмотрим, какие вы на вкус!' WHERE (`npc_entry`='15956') AND (`entry`='-1533001');
UPDATE `script_texts` SET `content_loc8`='Вам отсюда не выбраться.' WHERE (`npc_entry`='15956') AND (`entry`='-1533002');

-- Сапфирон

UPDATE `script_texts` SET `content_loc8`='%s впадает в ярость!' WHERE (`npc_entry`='15989') AND (`entry`='-1533083');
UPDATE `script_texts` SET `content_loc8`='%s глубоко вздыхает...' WHERE (`npc_entry`='15989') AND (`entry`='-1533082');

-- Pit of saron

DELETE FROM script_texts WHERE entry IN (-1658074, -1658075, -1658076, -1658077, -1658078, -1658080, -1658081, -1658082, -1658084, -1658085, -1658086, -1658087, -1658088);

INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`sound`,`type`,`language`,`emote`,`comment`) VALUES 
('0', '-1658074', 'Intruders have entered the masters domain. Signal the alarms!', 16747, 1, 0, 0, 'Tyrannus Opening'),
('0', '-1658075', 'Hmph fodder Not even fit to labor in the quarry. Relish these final moments for soon you will be nothing more than mindless undead', 16748, 1, 0, 0, 'Tyrannus Opening'),
('0', '-1658076', 'Soldiers of the Horde, attack!', 17045, 1, 0, 0, 'Sylvanas Opening'),
('0', '-1658077', 'Heroes of the Alliance, attack!', 16626, 1, 0, 0, 'Jaina Opening'),
('0', '-1658078', 'Your last waking memory will be of agonizing pain', 16749, 1, 0, 0, 'Tyrannus Opening'),
('0', '-1658080', 'Pathetic weaklings', 17046, 1, 0, 0, 'Sylvanas Opening'),
('0', '-1658081', 'NO! YOU MONSTER!', 16627, 1, 0, 0, 'Jaina Opening'),
('0', '-1658082', 'Minions, destroy these interlopers!', 16751, 1, 0, 0, 'Tyrannus Opening'),
('0', '-1658084', 'I do what i must. Please forgive me noble soldiers', 16628, 1, 0, 0, 'Jaina Opening'),
('0', '-1658085', 'You will have to battle your way through this cesspit on your own.', 17047, 0, 0, 0, 'Sylvanas Opening'),
('0', '-1658086', 'You will have to make your way across this quarry on your own.', 16629, 0, 0, 0, 'Jaina Opening'),
('0', '-1658087', 'Free any horde slaves that you come across. We will most certainly need there assistance in battling Tyrannus. I will gather reinforcements and join you on the other side of the quarry.', 17048, 0, 0, 0, 'Sylvanas Opening'),
('0', '-1658088', 'Free any Alliance slaves that you come across. We will most certainly need there assistance in battling Tyrannus. I will gather reinforcements and join you on the other side of the quarry.', 16630, 0, 0, 0, 'Jaina Opening');

DELETE FROM `vehicle_template_accessory` WHERE `entry` IN (36794);

UPDATE creature_template SET scriptname = "pitofsaron_start" WHERE entry IN (36794);
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES 
(367880, 37609, 0, 0, 0, 0, 22196, 0, 0, 0, 'Deathwhisper Necrolyte', 'Cult of the Damned', '', 0, 80, 80, 2, 21, 21, 0, 1.5, 1.14286, 1, 1, 307, 459, 0, 115, 9.6, 2000, 2000, 8, 32832, 8, 0, 0, 0, 0, 0, 246, 367, 92, 7, 0, 36788, 0, 0, 0, 0, 0, 0, 0, 0, 69578, 69577, 69577, 70270, 0, 0, 0, 0, 0, 0, 6705, 6705, 'SmartAI', 2, 3, 16, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2014, 1, 0, '', 12340);

REPLACE INTO `locales_creature` (`entry`, `name_loc1`, `name_loc2`, `name_loc3`, `name_loc4`, `name_loc5`, `name_loc6`, `name_loc7`, `name_loc8`, `subname_loc1`, `subname_loc2`, `subname_loc3`, `subname_loc4`, `subname_loc5`, `subname_loc6`, `subname_loc7`, `subname_loc8`) values
('367880','','','','','','','','Некролит из свиты Леди',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Культ Проклятых');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('203465','36788','658','2','64','0','2014','500.296','205.471','528.709','0.308489','300','0','0','302400','8814','0','0','0','0');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('203884','36788','658','1','128','0','2014','504.241','209.88','528.71','6.14493','300','0','0','161280','8814','2','0','0','0');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('124337','36788','658','3','1','22196','0','677.835','200.002','508.507','0.833533','7200','0','0','302400','8814','2','0','0','0');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('124336','36788','658','3','1','22196','0','613.756','121.853','507.693','1.17976','7200','0','0','302400','8814','2','0','0','0');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('124338','36788','658','3','1','22196','0','762.657','-42.8069','508.525','3.7459','7200','0','0','302400','8814','2','0','0','0');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125677','36788','658','3','1','22196','0','559.615','143.49','516.209','5.55015','7200','0','0','302400','8814','2','0','0','0');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125690','36788','658','3','1','22196','0','602.344','300.214','506.946','4.6153','7200','0','0','302400','8814','2','0','0','0');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('204240','36788','658','2','128','0','2014','499.366','205.466','528.71','6.24154','300','0','0','302400','8814','0','0','0','0');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('201550','36788','658','1','64','0','2014','504.444','211.062','528.71','6.17006','300','0','0','161280','8814','2','0','0','0');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('124326','36794','658','3','1','27982','0','906.905','-49.0381','618.802','1.79769','7200','0','0','107848','4169','0','0','0','0');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('204246','36794','658','2','128','0','0','494.439','223.624','535.979','3.35285','300','0','0','107848','4169','0','0','0','0');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('203440','36794','658','2','64','0','0','499.549','226.895','542.988','3.33399','300','0','0','107848','4169','0','0','0','0');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('200586','36794','658','1','64','0','0','530.315','227.842','547.769','3.29551','300','0','0','107848','4169','0','0','0','0');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('203861','36794','658','1','128','0','0','520.005','226.382','542.703','3.24603','300','0','0','107848','4169','0','0','0','0');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('204242','367880','658','2','128','0','2014','493.31','250.667','528.709','0.578034','300','0','0','302400','8814','0','0','0','0');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('203886','367880','658','1','128','0','2014','489.779','246.912','528.709','0.871771','300','0','0','161280','8814','2','0','0','0');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('202512','367880','658','1','64','0','2014','487.464','246.891','528.709','0.0416026','300','0','0','161280','8814','2','0','0','0');
Replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('203463','367880','658','2','64','0','2014','494.272','251.478','528.709','0.467289','300','0','0','302400','8814','0','0','0','0');

REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES (36796, 37657, 0, 0, 0, 0, 9785, 0, 0, 0, 'Corrupted Champion', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1.14286, 1, 0, 1, 2, 0, 0, 1, 2000, 2000, 1, 0, 8, 0, 0, 0, 0, 0, 1, 2, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 8388624, 0, '', 12340);

UPDATE creature_template SET type_flags = 192 WHERE entry = 36661;


replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('207618','36764','658','2','128','0','254','722.254','177.784','511.468','1.94884','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('207616','36764','658','2','128','0','254','710.517','192.395','513.241','2.00382','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('207614','36764','658','2','128','0','254','691.783','208.938','511.734','1.2302','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('207612','36764','658','2','128','0','254','684.361','223.07','511.097','2.43657','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('207610','36764','658','2','128','0','254','664.916','229.741','510.033','2.02031','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('207608','36764','658','2','128','0','254','636.156','260.379','509.442','1.42891','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('207579','36764','658','2','128','0','254','638.037','307.148','509.06','1.56556','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('207577','36764','658','2','128','0','254','614.689','329.023','508.287','3.22118','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('207575','36764','658','2','128','0','254','594.213','315.169','508.704','3.41203','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('207573','36764','658','2','128','0','254','579.673','312.303','508.587','2.446','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('207445','36764','658','2','128','0','254','539.858','331.055','508.627','1.36921','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('207401','36764','658','2','128','0','254','537.672','322.103','508.606','3.60367','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('207357','36764','658','2','128','0','254','534.879','302.256','508.827','4.33017','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('206683','36764','658','1','128','0','254','722.169','178.082','511.491','2.21992','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('206681','36764','658','1','128','0','254','710.392','192.689','513.238','2.0864','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('206679','36764','658','1','128','0','254','691.751','209.091','511.684','1.71334','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('206677','36764','658','1','128','0','254','684.248','223.137','511.097','2.34166','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('206675','36764','658','1','128','0','254','664.762','229.865','510.027','2.43591','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('206643','36764','658','1','128','0','254','637.795','307.43','508.977','1.65208','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('206641','36764','658','1','128','0','254','614.044','328.953','508.287','3.25037','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('206639','36764','658','1','128','0','254','594.206','315.202','508.7','3.3564','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('206637','36764','658','1','128','0','254','540.099','331.287','508.627','1.22875','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('206635','36764','658','1','128','0','254','537.652','322.217','508.609','4.17792','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('206633','36764','658','1','128','0','254','535.057','302.368','508.842','4.44103','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('206631','36764','658','1','128','0','254','579.554','312.338','508.584','2.52859','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('104371','36764','658','3','128','0','0','750.149','-107.019','513.02','5.77704','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('104370','36764','658','3','128','0','0','546.786','77.5','527.738','3.66519','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('104363','36764','658','3','128','0','0','636.259','-70.6215','512.671','3.90954','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('104140','36764','658','3','128','0','0','834.316','-17.3299','509.567','4.01426','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('104141','36764','658','3','128','0','0','698.283','-119.566','513.96','4.74729','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('104359','36764','658','3','128','0','0','692.682','-118.651','513.96','4.74729','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('104362','36764','658','3','128','0','0','723.545','-169.236','526.813','5.45946','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125728','36764','658','3','128','0','0','681.099','-120.312','513.96','4.74729','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125708','36764','658','3','128','0','0','704.797','-119.415','513.96','4.74729','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125737','36764','658','3','128','0','0','688.446','-120.693','513.96','4.74729','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('104369','36764','658','3','128','0','0','572.309','168.01','509.939','3.4383','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('104368','36764','658','3','128','0','0','587.977','198.151','509.651','2.93215','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('104367','36764','658','3','128','0','0','581.635','-5.30382','512.681','3.42085','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('104366','36764','658','3','128','0','0','581.865','-16.9219','512.681','2.77507','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('104372','36764','658','3','128','0','0','721.189','-70.2917','492.521','4.2586','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('104373','36764','658','3','128','0','0','721.995','-43.9149','479.963','5.35816','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('104374','36764','658','3','128','0','0','691.132','-46','486.064','4.67748','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('207622','36765','658','2','128','0','254','732.296','152.235','511.174','2.5371','300','0','0','63000','3994','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('207620','36765','658','2','128','0','254','729.335','147.948','511.161','2.54103','300','0','0','63000','3994','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('206710','36765','658','1','128','0','254','727.387','152.566','511.227','2.25448','300','0','0','37800','3994','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('206685','36765','658','1','128','0','254','722.456','148.052','511.413','2.64718','300','0','0','37800','3994','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('118232','36765','658','3','128','30372','0','748.805','53.4028','463.444','1.8326','7200','0','0','63000','3994','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125725','36765','658','3','128','30372','0','683.92','-58.8646','507.507','3.35103','7200','0','0','63000','3994','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205928','36770','658','1','64','0','254','614.338','329.129','508.287','2.94286','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205926','36770','658','1','64','0','254','594.251','315.229','508.699','3.47222','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205963','36770','658','1','64','0','254','684.179','223.06','511.097','2.54781','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205961','36770','658','1','64','0','254','664.751','229.798','510.012','2.4889','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205959','36770','658','1','64','0','254','636.149','260.458','509.44','1.5802','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205922','36770','658','1','64','0','254','539.963','331.564','508.626','1.6234','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205920','36770','658','1','64','0','254','537.562','322.079','508.607','3.72355','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205918','36770','658','1','64','0','254','534.937','302.367','508.846','4.04949','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205517','36770','658','2','64','0','254','722.076','178.338','511.509','2.07658','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205515','36770','658','2','64','0','254','710.502','192.782','513.28','1.73257','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205513','36770','658','2','64','0','254','691.636','208.909','511.621','1.68152','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205511','36770','658','2','64','0','254','684.229','223.269','511.097','2.44571','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205509','36770','658','2','64','0','254','664.678','229.842','510.007','2.37031','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205507','36770','658','2','64','0','254','652.947','241.898','514.99','2.20852','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205505','36770','658','2','64','0','254','636.075','260.372','509.401','1.59199','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205969','36770','658','1','64','0','254','722.097','178.352','511.511','2.11348','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205967','36770','658','1','64','0','254','710.496','192.953','513.296','2.24307','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205965','36770','658','1','64','0','254','691.318','209.295','511.521','1.67994','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205930','36770','658','1','64','0','254','637.852','307.146','508.972','2.12605','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205924','36770','658','1','64','0','254','579.421','312.414','508.579','2.51011','300','0','0','37800','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205474','36770','658','2','64','0','254','614.41','328.99','508.287','2.98999','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205470','36770','658','2','64','0','254','579.499','312.468','508.577','2.258','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205472','36770','658','2','64','0','254','594.233','315.182','508.703','3.44788','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('118229','36770','658','3','64','30383','0','834.316','-17.3299','509.567','4.01426','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('118225','36770','658','3','64','30380','0','692.682','-118.651','513.96','4.74729','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('118224','36770','658','3','64','30382','0','698.283','-119.566','513.96','4.74729','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('118227','36770','658','3','64','30383','0','688.446','-120.693','513.96','4.74729','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125741','36770','658','3','64','30380','0','704.797','-119.415','513.96','4.74729','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125727','36770','658','3','64','30380','0','681.099','-120.313','513.96','4.74729','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125729','36770','658','3','64','30380','0','723.545','-169.236','526.813','5.45946','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125706','36770','658','3','64','30381','0','636.259','-70.6215','512.671','3.90954','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('135304','36770','658','3','64','30382','0','581.865','-16.9219','512.681','2.77507','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125739','36770','658','3','64','30380','0','581.635','-5.30382','512.681','3.42085','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125707','36770','658','3','64','30383','0','587.977','198.151','509.651','2.93215','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125703','36770','658','3','64','30382','0','572.309','168.01','509.939','3.4383','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125702','36770','658','3','64','30382','0','546.786','77.5','527.738','3.66519','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('118223','36770','658','3','64','30381','0','750.149','-107.019','513.02','5.77704','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('118205','36770','658','3','64','30380','0','721.189','-70.2917','492.521','4.2586','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('118206','36770','658','3','64','30383','0','721.995','-43.9149','479.963','5.35816','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('118209','36770','658','3','64','30382','0','691.132','-46','486.064','4.67748','7200','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205445','36770','658','2','64','0','254','539.956','331.329','508.627','1.50009','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205442','36770','658','2','64','0','254','537.337','322.066','508.609','3.22404','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205356','36770','658','2','64','0','254','534.622','302.448','508.871','3.25153','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('205476','36770','658','2','64','0','254','638.021','307.324','509.072','1.57628','300','0','0','63000','0','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125713','36771','658','3','64','30384','0','725.977','149.089','511.345','1.11701','7200','0','0','63000','3994','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('118231','36771','658','3','64','30384','0','866.153','-11.3438','509.741','5.46288','7200','0','0','63000','3994','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('118228','36771','658','3','64','30385','0','777.953','6.66146','489.561','6.03884','7200','0','0','63000','3994','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('118235','36771','658','3','64','30384','0','676.29','168.757','508.003','0.139626','7200','0','0','63000','3994','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125685','36771','658','3','64','30385','0','632.587','-59.5139','512.672','2.77507','7200','0','0','63000','3994','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('123688','36771','658','3','64','30384','0','591.67','-23.7361','512.714','5.61996','7200','0','0','63000','3994','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125738','36771','658','3','64','30385','0','586.727','6.61111','512.674','3.35103','7200','0','0','63000','3994','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125698','36771','658','3','64','30384','0','548.403','89.5608','525.462','2.75762','7200','0','0','63000','3994','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('125711','36771','658','3','64','30384','0','754.168','-95.066','512.83','0.069813','7200','0','0','63000','3994','0','0','0','0');
replace into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('118210','36771','658','3','64','30385','0','647.373','-112.151','513.411','2.70526','7200','0','0','63000','3994','0','0','0','0');

-- Pit of Saron part 2

UPDATE creature_template SET scriptname = "pos_intro" WHERE entry IN (36990, 36993);

INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(5578,'at_ymirjar_flamebearer_pos');

DELETE FROM `areatrigger_scripts` where `entry`= 5579;
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(5579,'at_fallen_warrior_pos');

DELETE FROM `areatrigger_scripts` where `entry`= 5580;
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(5580,'at_ice_cicle_pos');

DELETE FROM `areatrigger_scripts` where `entry`= 5573;
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(5573,'at_pos_intro');

DELETE FROM `areatrigger_scripts` where `entry`= 5598;
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(5598,'at_slave_rescued_pos');

DELETE FROM `areatrigger_scripts` where `entry`= 5599;
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(5599,'at_geist_ambusher_pos');

UPDATE creature_template SET Scriptname = 'pos_outro' WHERE entry IN (38189, 38188);

DELETE FROM script_texts WHERE entry IN(-1658022, -1658023);
INSERT INTO script_texts (entry,content_default,sound,type,language,emote,comment) VALUES
(-1658022,'%s lance un rocher saronite massive sur vous !',0,5,0,0,'garfrost EMOTE_THROW_SARONITE'), 
(-1658023,'%s jette Deep Freeze sur $N.',0,3,0,0,'garfrost EMOTE_DEEP_FREEZE');

DELETE FROM `script_texts` WHERE entry = -1658071;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(36888,-1658071,'Par Ici ! Nous sommes sur le point de monter a l\'assaut de l\'antre du Seigneur du Fleau Tyrannus',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'SAY_RESCOUD_HORDE_ALLIANCE');

update creature_template set unit_flags = 32832, faction_A = 21, faction_H = 21 where entry IN(36830, 36892);

UPDATE gameobject_template set flags = 1, faction = 1375 WHERE entry = 201848;

UPDATE creature_template SET scriptname = '' WHERE entry IN (36794);

UPDATE creature_template SET MovementType = 2 where entry IN (36788, 367880);

-- Icecrown Citadel (Lich King) coordinates fixes
-- Highlord Tirion Fordring (38995)
UPDATE `creature` SET `position_z` = 840.94 WHERE `guid`=115781;
-- The Lich King
UPDATE `creature` SET `position_z` = 864.96 WHERE `guid`=115782;
-- Platform
UPDATE `gameobject`  SET `position_z` = 840.86 WHERE `guid` IN (8304,8310,8364,9007);
UPDATE `gameobject`  SET `position_z` = 836.61 WHERE `guid` IN (8322,8344,8377,8482);
UPDATE `gameobject`  SET `position_z` = 840.52 WHERE `guid`=8790;
UPDATE `gameobject`  SET `position_z` = 858.68 WHERE `guid`=8967;
UPDATE `creature_template` SET `mechanic_immune_mask`=0, `flags_extra`=0 WHERE  `entry` =38995;

-- Teleports
DELETE FROM `locales_npc_text` WHERE `entry` BETWEEN 800000 AND 800006;
INSERT INTO `locales_npc_text` (`entry`, `Text0_0_loc8`) VALUES
(800000, 'Молот света'),
(800001, 'Молельня проклятых'),
(800002, 'Черепной вал'),
(800003, 'Подъем смертоносного'),
(800004, 'Шпиль'),
(800005, 'Логово Королевы Льда'),
(800006, 'Ледяной трон');

-- valkyrs
UPDATE `creature_template` SET `unit_flags` = 512, mechanic_immune_mask=2, `vehicleid` = 533 WHERE `entry` IN (36609, 39120, 39121, 39122);

-- fix arena Grizzly Hills
UPDATE `quest_template` SET `RequiredNpcOrGo1`=27715, `RequiredNpcOrGoCount1`=1 WHERE  `Id`=12427;
UPDATE `quest_template` SET `RequiredNpcOrGo1`=27716, `RequiredNpcOrGoCount1`=1 WHERE  `Id`=12428;
UPDATE `quest_template` SET `RequiredNpcOrGo1`=27717, `RequiredNpcOrGoCount1`=1 WHERE  `Id`=12429;
UPDATE `quest_template` SET `RequiredNpcOrGo1`=27718, `RequiredNpcOrGoCount1`=1 WHERE  `Id`=12430;
UPDATE `quest_template` SET `RequiredNpcOrGo1`=27727, `RequiredNpcOrGoCount1`=1 WHERE  `Id`=12431; -- This Krenna work?

-- fix quest 9977
UPDATE `quest_template` SET `RequiredNpcOrGo1`=18069, `RequiredNpcOrGoCount1`=1 WHERE  `Id`=9977;

-- fix quest 12948

UPDATE `creature_template` SET `ScriptName`='npc_vladof_the_butcher' WHERE `entry` = 30022;


-- Right loot for Argent Crusade Tribute Chest in Trial of The Crusader
DELETE FROM `gameobject_loot_template` WHERE `entry` IN (195665,195666,195667,195668,195669,195670,195671,195672);
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(195665, 47242, 100, 1, 0, 2, 2),
(195665, 47556, 100, 1, 0, 1, 1),
(195666, 47242, 100, 1, 0, 2, 2),
(195666, 47556, 100, 1, 0, 1, 1),
(195666, 48693, 0, 1, 2, 1, 1),
(195666, 48695, 0, 1, 2, 1, 1),
(195666, 48697, 0, 1, 2, 1, 1),
(195666, 48699, 0, 1, 2, 1, 1),
(195666, 48701, 0, 1, 2, 1, 1),
(195666, 48703, 0, 1, 2, 1, 1),
(195666, 48705, 0, 1, 2, 1, 1),
(195666, 48708, 0, 1, 1, 1, 1),
(195666, 48709, 0, 1, 1, 1, 1),
(195666, 48710, 0, 1, 1, 1, 1),
(195666, 48711, 0, 1, 1, 1, 1),
(195666, 48712, 0, 1, 1, 1, 1),
(195666, 48713, 0, 1, 1, 1, 1),
(195666, 48714, 0, 1, 1, 1, 1),
(195667, 47242, 100, 1, 0, 4, 4),
(195667, 47556, 100, 1, 0, 1, 1),
(195667, 48693, 0, 1, 2, 1, 1),
(195667, 48695, 0, 1, 2, 1, 1),
(195667, 48697, 0, 1, 2, 1, 1),
(195667, 48699, 0, 1, 2, 1, 1),
(195667, 48701, 0, 1, 2, 1, 1),
(195667, 48703, 0, 1, 2, 1, 1),
(195667, 48705, 0, 1, 2, 1, 1),
(195667, 48708, 0, 1, 1, 1, 1),
(195667, 48709, 0, 1, 1, 1, 1),
(195667, 48710, 0, 1, 1, 1, 1),
(195667, 48711, 0, 1, 1, 1, 1),
(195667, 48712, 0, 1, 1, 1, 1),
(195667, 48713, 0, 1, 1, 1, 1),
(195667, 48714, 0, 1, 1, 1, 1),
(195668, 47242, 100, 1, 0, 4, 4),
(195668, 47556, 100, 1, 0, 1, 1),
(195668, 48666, 0, 1, 4, 1, 1),
(195668, 48667, 0, 1, 4, 1, 1),
(195668, 48668, 0, 1, 4, 1, 1),
(195668, 48669, 0, 1, 4, 1, 1),
(195668, 48670, 0, 1, 4, 1, 1),
(195668, 48671, 0, 1, 3, 1, 1),
(195668, 48672, 0, 1, 3, 1, 1),
(195668, 48673, 0, 1, 3, 1, 1),
(195668, 48674, 0, 1, 3, 1, 1),
(195668, 48675, 0, 1, 3, 1, 1),
(195668, 48693, 0, 1, 2, 1, 1),
(195668, 48695, 0, 1, 2, 1, 1),
(195668, 48697, 0, 1, 2, 1, 1),
(195668, 48699, 0, 1, 2, 1, 1),
(195668, 48701, 0, 1, 2, 1, 1),
(195668, 48703, 0, 1, 2, 1, 1),
(195668, 48705, 0, 1, 2, 1, 1),
(195668, 48708, 0, 1, 1, 1, 1),
(195668, 48709, 0, 1, 1, 1, 1),
(195668, 48710, 0, 1, 1, 1, 1),
(195668, 48711, 0, 1, 1, 1, 1),
(195668, 48712, 0, 1, 1, 1, 1),
(195668, 48713, 0, 1, 1, 1, 1),
(195668, 48714, 0, 1, 1, 1, 1),
(195668, 49044, 100, 1, 0, 1, 1),
(195668, 49046, 100, 1, 0, 1, 1),
(195669, 47557, 100, 1, 0, -47557, 2),
(195670, 47506, 0, 1, 1, 1, 1),
(195670, 47513, 0, 1, 2, 1, 1),
(195670, 47515, 0, 1, 1, 1, 1),
(195670, 47516, 0, 1, 2, 1, 1),
(195670, 47517, 0, 1, 1, 1, 1),
(195670, 47518, 0, 1, 2, 1, 1),
(195670, 47519, 0, 1, 1, 1, 1),
(195670, 47520, 0, 1, 2, 1, 1),
(195670, 47521, 0, 1, 1, 1, 1),
(195670, 47523, 0, 1, 2, 1, 1),
(195670, 47524, 0, 1, 1, 1, 1),
(195670, 47525, 0, 1, 2, 1, 1),
(195670, 47526, 0, 1, 1, 1, 1),
(195670, 47528, 0, 1, 2, 1, 1),
(195670, 47557, 100, 1, 0, -47557, 2),
(195671, 47506, 0, 1, 1, 1, 1),
(195671, 47513, 0, 1, 2, 1, 1),
(195671, 47515, 0, 1, 1, 1, 1),
(195671, 47516, 0, 1, 2, 1, 1),
(195671, 47517, 0, 1, 1, 1, 1),
(195671, 47518, 0, 1, 2, 1, 1),
(195671, 47519, 0, 1, 1, 1, 1),
(195671, 47520, 0, 1, 2, 1, 1),
(195671, 47521, 0, 1, 1, 1, 1),
(195671, 47523, 0, 1, 2, 1, 1),
(195671, 47524, 0, 1, 1, 1, 1),
(195671, 47525, 0, 1, 2, 1, 1),
(195671, 47526, 0, 1, 1, 1, 1),
(195671, 47528, 0, 1, 2, 1, 1),
(195671, 47557, 100, 1, 0, -47557, 4),
(195672, 47506, 0, 1, 1, 1, 1),
(195672, 47513, 0, 1, 2, 1, 1),
(195672, 47515, 0, 1, 1, 1, 1),
(195672, 47516, 0, 1, 2, 1, 1),
(195672, 47517, 0, 1, 1, 1, 1),
(195672, 47518, 0, 1, 2, 1, 1),
(195672, 47519, 0, 1, 1, 1, 1),
(195672, 47520, 0, 1, 2, 1, 1),
(195672, 47521, 0, 1, 1, 1, 1),
(195672, 47523, 0, 1, 2, 1, 1),
(195672, 47524, 0, 1, 1, 1, 1),
(195672, 47525, 0, 1, 2, 1, 1),
(195672, 47526, 0, 1, 1, 1, 1),
(195672, 47528, 0, 1, 2, 1, 1),
(195672, 47545, 0, 1, 3, 1, 1),
(195672, 47546, 0, 1, 4, 1, 1),
(195672, 47547, 0, 1, 3, 1, 1),
(195672, 47548, 0, 1, 4, 1, 1),
(195672, 47549, 0, 1, 3, 1, 1),
(195672, 47550, 0, 1, 4, 1, 1),
(195672, 47551, 0, 1, 4, 1, 1),
(195672, 47552, 0, 1, 3, 1, 1),
(195672, 47553, 0, 1, 3, 1, 1),
(195672, 47554, 0, 1, 4, 1, 1),
(195672, 47557, 100, 1, 0, -47557, 4);

-- Fix quest 10256
UPDATE quest_template SET RequiredSourceItemId2='0', RequiredSourceItemCount2='0', RequiredNpcOrGo1='0', RequiredNpcOrGoCount1='0' WHERE id ='10256';

-- Fix quest 11911
DELETE FROM `creature_loot_template` WHERE `entry`=30524 AND `item`=35490;
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(30524,35490,-100,1,0,1,1);

-- Fix fishing
DELETE FROM `fishing_loot_template` WHERE `item` = 7973;
INSERT INTO `fishing_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(16, 7973, 8, 1, 0, 1, 1), -- Azshara
(440, 7973, 6, 1, 0, 1, 1), -- Tanaris
(47, 7973, 5, 1, 0, 1, 1), -- The Hinterlands
(357, 7973, 1.6, 1, 0, 1, 1); -- Feralas

-- Fix quest 13828 , closes #783
UPDATE `quest_template` SET `RequiredNpcOrGo2` = 33341, `RequiredNpcOrGoCount2` = 5 WHERE `Id` = 13828;

-- Fix quest 10714
UPDATE creature_template SET unit_flags = 320 WHERE entry IN (20912, 21599);
UPDATE `quest_template` SET `RequiredSpellCast1`=0 WHERE `Id`=10714;
DELETE FROM `spell_script_names` WHERE `spell_id`=38173;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (38173, 'spell_gen_summon_spirit_rexxars_whistle');

-- fix broken RequiredNpcOrGoId1 in quest 13828 (Master of the Melee), Horde was already working
UPDATE quest_template SET RequiredNpcOrGo1 = 33973 WHERE id = 13828 LIMIT 1;

-- fix CoQ in GrizzlyHills
UPDATE `creature_template` SET `ScriptName`='npc_grennix_shivwiggle' WHERE `entry` = 27719;
UPDATE `creature_template` SET `ScriptName`='npc_ironhide' WHERE `entry` = 27715;
UPDATE `creature_template` SET `ScriptName`='npc_torgg_thundertotem' WHERE `entry` = 27716;
UPDATE `creature_template` SET `ScriptName`='rustblood' WHERE `entry` = 27717;
UPDATE `creature_template` SET `ScriptName`='npc_horgrenn_hellcleave' WHERE `entry` = 27718;
UPDATE `creature_template` SET `ScriptName`='npc_conqueror_krenna' WHERE `entry` = 27727;

-- fix quest 54
DELETE FROM `quest_start_scripts` WHERE `id` = 54;
DELETE FROM `db_script_string` WHERE `entry`=2000000059;
UPDATE `quest_template` SET `StartScript`='54', `SpecialFlags`='0' WHERE `Id`='54';
INSERT INTO `quest_start_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
('54','1','15','6245','0','0','0','0','0','0'),
('54','2','1','113','0','0','0','0','0','0'),
('54','2','0','0','0','2000000059','0','0','0','0');
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000059','You are Dismissed, $N',NULL,NULL,NULL,NULL,NULL,NULL,NULL, 'Ты уволен, $N');

-- fix unit_flags Zul'Farrak
UPDATE `creature_template` SET `unit_flags`=32768 WHERE  `entry`=5649 LIMIT 1;

-- Fix ICC putricide table
UPDATE `gameobject_template` SET `ScriptName`='go_icc_putricide_table' WHERE `entry`=201584;

-- Fix quest 11317
DELETE FROM gameobject WHERE guid=150377;
UPDATE gameobject_template SET data2=11322 WHERE entry=186649;

DELETE FROM event_scripts WHERE id=11322;
INSERT INTO event_scripts VALUES
(11322,1,8,27959,0,0,0,0,0,0);

-- Fix GO ice_stone
UPDATE `gameobject_template` SET `ScriptName`='go_ice_stone' WHERE `entry`=187882;

-- Some quest fixes in Hellfire Peninsula
UPDATE `creature_template` SET `gossip_menu_id` = 0, `AIName` = '', `ScriptName` = 'npc_taxi' WHERE `entry` = 18930;
UPDATE `creature_template` SET `gossip_menu_id` = 0, `AIName` = '', `ScriptName` = 'npc_taxi' WHERE `entry` = 18931;


-- Serverside Spells
DELETE FROM `spell_dbc` WHERE `Id` IN (29710,58934);
INSERT INTO `spell_dbc` (`Id`, `Dispel`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesEx2`, `AttributesEx3`, `AttributesEx4`, `AttributesEx5`, `Stances`, `StancesNot`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcFlags`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `StackAmount`, `EquippedItemClass`, `EquippedItemSubClassMask`, `EquippedItemInventoryTypeMask`, `Effect1`, `Effect2`, `Effect3`, `EffectDieSides1`, `EffectDieSides2`, `EffectDieSides3`, `EffectRealPointsPerLevel1`, `EffectRealPointsPerLevel2`, `EffectRealPointsPerLevel3`, `EffectBasePoints1`, `EffectBasePoints2`, `EffectBasePoints3`, `EffectMechanic1`, `EffectMechanic2`, `EffectMechanic3`, `EffectImplicitTargetA1`, `EffectImplicitTargetA2`, `EffectImplicitTargetA3`, `EffectImplicitTargetB1`, `EffectImplicitTargetB2`, `EffectImplicitTargetB3`, `EffectRadiusIndex1`, `EffectRadiusIndex2`, `EffectRadiusIndex3`, `EffectApplyAuraName1`, `EffectApplyAuraName2`, `EffectApplyAuraName3`, `EffectAmplitude1`, `EffectAmplitude2`, `EffectAmplitude3`, `EffectMultipleValue1`, `EffectMultipleValue2`, `EffectMultipleValue3`, `EffectMiscValue1`, `EffectMiscValue2`, `EffectMiscValue3`, `EffectMiscValueB1`, `EffectMiscValueB2`, `EffectMiscValueB3`, `EffectTriggerSpell1`, `EffectTriggerSpell2`, `EffectTriggerSpell3`, `EffectSpellClassMaskA1`, `EffectSpellClassMaskA2`, `EffectSpellClassMaskA3`, `EffectSpellClassMaskB1`, `EffectSpellClassMaskB2`, `EffectSpellClassMaskB3`, `EffectSpellClassMaskC1`, `EffectSpellClassMaskC2`, `EffectSpellClassMaskC3`, `MaxTargetLevel`, `SpellFamilyName`, `SpellFamilyFlags1`, `SpellFamilyFlags2`, `SpellFamilyFlags3`, `MaxAffectedTargets`, `DmgClass`, `PreventionType`, `DmgMultiplier1`, `DmgMultiplier2`, `DmgMultiplier3`, `AreaGroupId`, `SchoolMask`, `Comment`) VALUES
('29710','0','0','256','0','0','0','0','0','0','0','0','1','0','0','101','0','0','0','0','0','1','0','-1','0','0','140','0','0','0','0','0','0','0','0','0','0','0','0','0','0','25','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','29531','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','1','Ribbon Pole - Force Cast Ribbon Pole Channel'),
('58934','0','0','536870912','0','0','0','0','0','0','0','0','1','0','0','101','0','0','0','0','0','1','0','-1','0','0','3','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','28','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','Burning Hot Pole Dance credit marker');

-- Link Dancer Check Aura and Visual to Ribbon Pole Channel
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (29531,45390);	
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(29531,45390,0, 'Ribbon Pole - Dancer Check Aura'),
(45390,45406,2, 'Ribbon Pole - Periodic Visual');

DELETE FROM `spell_script_names` WHERE `spell_id`=45390;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(45390, 'spell_gen_ribbon_pole_dancer_check');


-- Fix spell 29801 
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 29801;
INSERT INTO `spell_linked_spell` (spell_trigger, spell_effect, type, comment) VALUES
(29801, -29801, 2, 'Rampage');


-- Loot for item 54536 Satchel of Chilled Goods
DELETE FROM `gameobject_loot_template` WHERE `entry` = 28682 AND `item` IN (49426, 54806, 53641);
INSERT INTO `gameobject_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(28682, 49426, 100, 1, 0, 1, 1),	
(28682, 54806, 20, 1, 0, 1, 1),	
(28682, 53641, 20, 1, 0, 1, 1);


-- Fix glyph of shadowflame should only proc when dealing damage to the target (fixing the range issue)
UPDATE `spell_proc_event` SET `procEx` = procEx|262144 WHERE`entry` = 63310;


-- Fix quest 11851, 11855, 11854, 11835, 11843, 11858
-- The Flame Keeper of Outland - Achievement=1027
DELETE FROM `creature_involvedrelation` WHERE `quest` IN (11851,11855,11835,11858,11863,11821,11854);
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES
(25934, 11851), -- Hellfire Peninsula
(25938, 11855), -- Shadowmoon Valley
(25918, 11835), -- Netherstorm
(25942, 11858), -- Terokkar
(25947, 11863), -- Zangarmarsh
(25937, 11854); -- Nagrand
UPDATE `quest_template` SET `RewardOrRequiredMoney`=37000,`RewardMoneyMaxLevel`=29300,`RequiredRaces`=690,`OfferRewardText`='Honor the Hellfire Peninsula flame!' WHERE `Id`=11851;
UPDATE `quest_template` SET `RewardOrRequiredMoney`=37000,`RewardMoneyMaxLevel`=29300,`RequiredRaces`=690,`OfferRewardText`='Honor the Shadowmoon Valley flame!' WHERE `Id`=11855;
UPDATE `quest_template` SET `RewardOrRequiredMoney`=37000,`RewardMoneyMaxLevel`=29300,`RequiredRaces`=690,`OfferRewardText`='Honor the Nagrand flame!' WHERE `Id`=11854;
UPDATE `quest_template` SET `RewardOrRequiredMoney`=37000,`RewardMoneyMaxLevel`=29300,`RequiredRaces`=690,`OfferRewardText`='Honor the Netherstorm flame!' WHERE `Id`=11835;
UPDATE `quest_template` SET `RewardOrRequiredMoney`=37000,`RewardMoneyMaxLevel`=29300,`RequiredRaces`=690,`OfferRewardText`='Honor the Blades Edge Mountains flame! ', `RequestItemsText`='' WHERE `Id`=11843;
UPDATE `quest_template` SET `RewardOrRequiredMoney`=37000,`RewardMoneyMaxLevel`=29300,`RequiredRaces`=690,`OfferRewardText`='Honor the Terokkar flame!' WHERE `Id`=11858;
UPDATE `quest_template` SET `RewardOrRequiredMoney`=37000,`RewardMoneyMaxLevel`=29300,`RequiredRaces`=690,`OfferRewardText`='Honor the Zangarmarsh flame!' WHERE `Id`=11863;


-- Fix achievement 272 
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 6937 AND `type` = 6;
INSERT INTO `achievement_criteria_data` (criteria_id, type, value1, value2, ScriptName) VALUES
(6937, 6, 4395, 0, '');


-- Rogue T10 2p bonus
UPDATE spell_proc_event SET procFlags=0, `Cooldown`=1 WHERE entry= 70805;


-- Scripts/SlavePens: Ahune
-- Commiter: denis aka jacob
-- set script names
UPDATE `creature_template` SET `ScriptName` = 'boss_ahune' WHERE `entry` = 25740;
UPDATE `creature_template` SET `ScriptName` = 'npc_frozen_core' WHERE `entry` = 25865;
UPDATE `creature_template` SET `ScriptName` = 'npc_ahunite_hailstone' WHERE `entry` = 25755;
UPDATE `creature_template` SET `ScriptName` = 'npc_ahunite_coldweave' WHERE `entry` = 25756;
UPDATE `creature_template` SET `ScriptName` = 'npc_ahunite_frostwind' WHERE `entry` = 25757;

-- update npc levels to wotlk, set factions to monster
UPDATE `creature_template` SET `minLevel` = 82, `maxLevel` = 82, `faction_A` = 14, `faction_H` = 14, `dmg_multiplier` = 2 WHERE `entry` = 26338;
UPDATE `creature_template` SET `minLevel` = 73, `maxLevel` = 73, `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 25740;
UPDATE `creature_template` SET `minLevel` = 80, `maxLevel` = 80, `faction_A` = 14, `faction_H` = 14, `dmg_multiplier` = 2 WHERE `entry` IN (26339, 26342, 26340, 26341);
UPDATE `creature_template` SET `minLevel` = 70, `maxLevel` = 70, `faction_A` = 14, `faction_H` = 14 WHERE `entry` IN (25865, 25755, 25756, 25757);

-- update templates to make frozen core match ahune's health
UPDATE `creature_template` SET `exp` = 2, `Health_mod` = 39 WHERE `entry` IN (26338, 26339);
UPDATE `creature_template` SET `exp` = 2, `Health_mod` = 32 WHERE `entry` IN (25740, 25865);

-- update damage
UPDATE `creature_template` SET 
    `mindmg` = 2200, 
    `maxdmg` = 2400, 
    `attackpower` = ROUND((`mindmg` + `maxdmg`) / 4 * 7), 
    `mindmg` = ROUND(`mindmg` - `attackpower` / 7), 
    `maxdmg` = ROUND(`maxdmg` - `attackpower` / 7) 
  WHERE `entry` IN (25740, 26338);

UPDATE `creature_template` SET
    `mindmg` = 350, 
    `maxdmg` = 450, 
    `attackpower` = ROUND((`mindmg` + `maxdmg`) / 4 * 7), 
    `mindmg` = ROUND(`mindmg` - `attackpower` / 7),
    `maxdmg` = ROUND(`maxdmg` - `attackpower` / 7) 
  WHERE `entry` IN (26341, 25757, 26340, 25756);

UPDATE `creature_template` SET 
    `mindmg` = 650, 
    `maxdmg` = 800, 
    `attackpower` = ROUND((`mindmg` + `maxdmg`) / 4 * 7), 
    `mindmg` = ROUND(`mindmg` - `attackpower` / 7), 
    `maxdmg` = ROUND(`maxdmg` - `attackpower` / 7) 
  WHERE `entry` IN (26342, 25755);

-- spawn 
DELETE FROM `gameobject` WHERE `id` = 187882 AND `map` = 547;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(440701, 187882, 547, 3, 1, -62.151, -160.632, -1.80114, 3.40964, 0, 0, 0.703812, 0.710386, 300, 0, 1);
DELETE FROM `game_event_gameobject` WHERE `guid` IN (440701,440795,440768,440770,440772,440774,440776,440778,440794);
INSERT INTO `game_event_gameobject` (`guid`, `evententry`) VALUES
(440701,1);

UPDATE `gameobject_template` SET `ScriptName` = 'go_ice_stone' WHERE `entry` = 187882;


DELETE FROM `creature_involvedrelation` WHERE `quest` = 11691;
DELETE FROM `gameobject_involvedrelation` WHERE `id` = 188152;
INSERT INTO `gameobject_involvedrelation` (`id`, `quest`) VALUES
(188152 , 11691);


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 46363;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(13, 0, 46363, 0, 0, 18, 0, 1, 25740, 0, 0, 0, '', 'Beam Attack against Ahune 2 - targets Ahune');

-- Move Malygos (EoE) to his original position, corresponding to TDB46.
DELETE FROM `creature` WHERE `id` = 28859 AND `map`=616;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (132313, 28859, 616, 3, 1, 26752, 0, 808.535, 1213.55, 295.972, 3.22503, 604800, 5, 0, 6972500, 212900, 1, 0, 0, 0);


-- Fix quest 10839 Dunkelstein des Skithverstecks 
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22288;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 22288 AND `source_type` = 0;
INSERT INTO `smart_scripts` (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(22288, 0, 0, 0, 10, 0, 100, 0, 0, 15, 1000, 1000, 15, 10839, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Quest Target - Complete Quest 10839 on SpellHit');

-- Quest Shadowmourne
UPDATE `quest_template` SET `RequiredClasses`=35 WHERE `Id` IN (24545,24743,24547,24749,24756,24757,24548,24549,24748);


-- Dalaran Sewers and Ring of Valor
UPDATE `gameobject_template` SET `flags` = '36' WHERE `entry` IN (192642,192643);
DELETE FROM disables WHERE sourceType = 3 AND entry IN (10,11);

-- implicit target for hotr throwback in eadric the pure encounter
DELETE FROM conditions WHERE SourceTypeOrReferenceId = 13 AND SourceEntry = 66905;
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReferenceId, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(13, 0, 66905, 0, 0, 18, 0, 1, 35119, 0, 0, 0, '', 'Hammer of the Righteous - Implict Target Eadric the Pure');


-- Fix quest 9645
DELETE FROM `event_scripts` WHERE `id`=10951;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES (10951, 0, 7, 9645, 50, 0, 0, 0, 0, 0);

-- Fix test totems
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry` IN (23789,61904);
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES
(0, 23789, 8, 'Stoneclaw Totem TEST - can crash client by spawning too many totems'),
(0, 61904, 8, 'Magma Totem TEST - can crash client by spawning too many totems');

-- Achievement: Bros. Before Ho Ho Ho's, http://old.wowhead.com/achievement=1685
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~0x100, `type_flags`=`type_flags`|0x4000000 WHERE `entry` IN (739,927,1182,1351,1444,5484,5489,5661,8140,12336,26044);
UPDATE `creature` SET `spawntimesecs`=20 WHERE `id` IN (739,927,1182,1351,1444,5484,5489,5661,8140,12336,26044);
UPDATE `item_template` SET `Flags`=0x40 WHERE `entry`=21519;
UPDATE `creature_template` SET `faction_A`='85',`faction_H`='85' WHERE `entry`='5661';


-- Fix quest 12928
DELETE FROM `event_scripts` WHERE `id` = 19410 AND `command` = 10 AND `datalong` = 29775;
INSERT INTO `event_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(19410, 0, 10, 29775, 30000, 0, 7991.81, -827.7, 968.3, 0);
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` = 29775;
DELETE FROM `creature_loot_template` WHERE `item` = 41258 AND `entry` = 29775;
INSERT INTO `creature_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(29775, 41258, -100, 1, 0, 1, 1);
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 29775);
DELETE FROM `creature` WHERE `id` = 29775;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `ConditionTypeOrReference` = 23 AND `SourceEntry` = 55197;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(17, 0, 55197, 0, 0, 23, 0, 4485, 0, 0, 0, 0, '', '');


-- Fix quests 11731, 11921, 11922, 11926, 11923, 11925, 11657, 11924
UPDATE `gameobject_template` SET `data1` = 50 WHERE `entry` = 300068;
DELETE FROM `game_event_gameobject` WHERE `guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` = 300068);
DELETE FROM `gameobject` WHERE `id` = 300068;
INSERT INTO `gameobject` (id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(300068, 0, 1, 1, -8822.72, 855.232, 99.0484, 5.9631, 0, 0, 0.159362, -0.98722, 300, 0, 1),
(300068, 0, 1, 1, -4682.71, -1225.83, 501.659, 0.101229, 0, 0, 0.0505929, 0.998719, 300, 0, 1),
(300068, 0, 1, 1, 1837.2, 219.057, 60.166, 6.24609, 0, 0, 0.0185457, -0.999828, 300, 0, 1),
(300068, 1, 1, 1, -1041.72, 305.708, 134.702, 2.29825, 0, 0, 0.912405, 0.409288, 300, 0, 1),
(300068, 1, 1, 1, 1920.53, -4320.48, 22.0346, 1.43789, 0, 0, 0.658591, 0.752501, 300, 0, 1),
(300068, 1, 1, 1, 8717.87, 928.938, 15.7723, 3.20661, 0, 0, 0.999472, -0.0325044, 300, 0, 1),
(300068, 530, 1, 1, -3775.33, -11512.1, -134.56, 2.67663, 0, 0, 0.973098, 0.230391, 300, 0, 1),
(300068, 530, 1, 1, 9816.61, -7228.03, 26.1073, 6.27033, 0, 0, 0.00642763, -0.999979, 300, 0, 1);
INSERT INTO `game_event_gameobject` (eventEntry, guid) SELECT 1, `guid` FROM `gameobject` WHERE `id` = 300068;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25535;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25535 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2553500 AND `source_type` = 9;
INSERT INTO `smart_scripts` (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(25535, 0, 0, 1, 8, 0, 100, 0, 46054, 0, 0, 0, 44, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '[DNT] Torch Tossing Target Bunny - Set ingame phase to 2 on spellhit 46054'),
(25535, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 2553500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '[DNT] Torch Tossing Target Bunny - Call timed actionlist 2553500'),
(2553500, 9, 0, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '[DNT] Torch Tossing Target Bunny - Set back to ingame phase 1 after 30 seconds');
DELETE FROM `game_event_creature` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 25535);
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 25535);
DELETE FROM `creature` WHERE `id` = 25535;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(25535, 1, 1, 1, 11686, 0, -1041.61, 313.163, 133.278, -1.76278, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 1923.87, -4315.27, 22.4918, -2.18166, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 1920.49, -4319.35, 21.8167, 0.698132, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -8825.72, 845.613, 99.0511, 2.89725, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, -1042.52, 306.56, 134.451, -1.98968, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 1915.58, -4320.46, 21.8202, -1.58825, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 8722.04, 933.662, 15.9977, -2.18166, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 8716.73, 936.471, 14.8964, -1.58825, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, -1035.88, 312.549, 134.666, -1.58825, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, -1049.08, 306.373, 132.937, -2.18166, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 8716.85, 928.883, 15.3478, -1.76278, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 8721.22, 923.779, 16.4874, 0.698132, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 8717.3, 920.104, 15.1784, -1.98968, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 1925.15, -4321.27, 21.6547, -1.76278, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -4675.41, -1224.66, 501.659, -1.98968, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -4677.39, -1229.83, 501.659, -1.58825, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -4685.95, -1218.96, 501.659, 0.698132, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, 1838.23, 218.969, 60.1496, -1.76278, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, 1837.19, 225.627, 60.246, -1.58825, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, -1048.8, 299.889, 134.401, 0.698132, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 1918.07, -4314.9, 22.8562, -1.98968, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, 1837.4, 213.158, 60.3433, -1.98968, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, 1840.84, 216.245, 60.074, -2.18166, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, 1840.18, 222.607, 60.2069, 0.698132, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -4683.98, -1232.64, 501.659, -1.76278, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -4678.69, -1219.43, 501.659, -2.18166, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -8819.46, 848.506, 98.9483, -2.18166, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, -3768.73, -11511.2, -134.479, 2.70805, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, -3773.26, -11519.4, -134.56, 2.53526, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, -3776.32, -11511.5, -134.569, 5.69256, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, -3775.23, -11506.7, -134.539, 5.79074, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, -3780.47, -11514.1, -134.626, 5.66115, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, 9817.67, -7227.84, 26.1104, 3.89843, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, 9810.38, -7226.95, 26.0582, 0.898206, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, 9819.87, -7234.51, 26.1176, 0.898206, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, 9823.56, -7229.12, 26.1209, 3.78847, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, 9817.55, -7221.36, 26.1142, 3.80025, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -8816.54, 854.183, 98.882, 4.34518, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -8815.11, 860.487, 98.96, 4.75751, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -8818.01, 865.253, 98.9761, 4.47084, 30, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO `game_event_creature` (eventEntry, guid) SELECT 1, `guid` FROM `creature` WHERE `id` = 25535;
-- Apply required changes to quest templates
UPDATE `quest_template` SET `RequiredNpcOrGo1` = 25535, `RequiredSpellCast1` = 46054, `RequiredSourceItemId2` = 34862, `RequiredSourceItemCount2` = 1, `StartScript` = `Id` WHERE `Id` IN (11731, 11921, 11922, 11926);
UPDATE `quest_template` SET `RequiredNpcOrGoCount1` = 8 WHERE `Id` IN (11731, 11922);
UPDATE `quest_template` SET `RequiredNpcOrGoCount1` = 20 WHERE `Id` IN (11921, 11926);
UPDATE `quest_template` SET `RequiredRaces` = 1101 WHERE `Id` IN (11731, 11921);
UPDATE `quest_template` SET `RequiredRaces` = 690 WHERE `Id` IN (11922, 11926);
UPDATE `quest_template` SET `RequiredNpcOrGo1` = 25515, `RequiredSourceItemId2` = 34833, `RequiredSourceItemCount2` = 1, `StartScript` = `Id`, `ObjectiveText1` = 'Fackeln gefangen' WHERE `Id` IN (11923, 11925, 11657, 11924);
UPDATE `quest_template` SET `RequiredNpcOrGoCount1` = 4 WHERE `Id` IN (11923, 11657);
UPDATE `quest_template` SET `RequiredNpcOrGoCount1` = 10 WHERE `Id` IN (11925, 11924);
UPDATE `quest_template` SET `RequiredRaces` = 1101 WHERE `Id` IN (11657, 11924);
UPDATE `quest_template` SET `RequiredRaces` = 690 WHERE `Id` IN (11923, 11925);
DELETE FROM `quest_start_scripts` WHERE `id` IN (11731, 11921, 11922, 11926, 11923, 11925, 11657, 11924);
INSERT INTO `quest_start_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(11731, 0, 7, 11731, 10, 0, 0, 0, 0, 0),
(11921, 0, 7, 11921, 10, 0, 0, 0, 0, 0),
(11922, 0, 7, 11922, 10, 0, 0, 0, 0, 0),
(11926, 0, 7, 11926, 10, 0, 0, 0, 0, 0),
(11923, 0, 7, 11923, 10, 0, 0, 0, 0, 0),
(11925, 0, 7, 11925, 10, 0, 0, 0, 0, 0),
(11657, 0, 7, 11657, 10, 0, 0, 0, 0, 0),
(11924, 0, 7, 11924, 10, 0, 0, 0, 0, 0);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (46054, 45732, 46747);
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(13, 0, 46054, 0, 1, 18, 0, 1, 25535, 0, 0, 0, '', 'Quest support midsummer festival - target NPC 25535'),
(13, 0, 45732, 0, 1, 18, 0, 1, 25535, 0, 0, 0, '', 'Quest support midsummer festival - target NPC 25535'),
(13, 0, 46747, 0, 1, 18, 0, 1, 0, 0, 0, 0, '', 'Quest support midsummer festival - target palyer');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (46747, 45693);
INSERT INTO `spell_linked_spell` (spell_trigger, spell_effect, type, comment) VALUES
(46747, 45693, 0, 'Quest support midsummer festival'),
(45693, -45693, 0, 'Quest support midsummer festival');


-- Fix damage calculations for Deathknight / Todesritter talents Crypt Fever / Ebon Plaugebringer / Schwarzer Seuchenbringer / Gruftfieber
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 65142;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(65142, -65142, 2, 'Deathknight trigger spell for talents Crypt Fever / Ebon Plaguebringer - only stack once');


-- Fix Shadowfiend mana regeneration
UPDATE `creature_template_addon` SET `auras`='28305' WHERE `entry`=19668;


-- Fix quest 10588
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` = 21181;


-- Fix quest 24498 and quest 24507
UPDATE `gameobject_template` SET `AIName` = '', `ScriptName` = 'go_ball_and_chain' WHERE `entry` = 201969;

-- Fix Gorrila fang(TC FIX)
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=50 WHERE `item`=2799 AND `entry` IN (1108,1557,1558,1559);

-- Fix Quest: The Prophecy of Akida
UPDATE `quest_template` SET `StartScript` = 0 WHERE `Id` = 9544;

-- Fix Quest: Saving Princess Stillpine
DELETE FROM `quest_start_scripts` WHERE `id`=9667;
INSERT INTO `quest_start_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES 
(9667, 1, 10, 17702, 120000, '0', -2496.03, -12311.96, 14.5844, 2.5908);

-- Fix Quest: Cho'war the Pillager
UPDATE `quest_template` SET `RequiredNpcOrGo1` = 18445 WHERE `Id` = 9955;

-- Fix Quest:  The Cleansing
UPDATE `creature_template` SET `modelid2` = 11686, `flags_extra` = 0 WHERE `entry` = 27959;

-- Fix Quest: Slaves of the Stormforged
UPDATE `quest_template` SET `RequiredNpcOrGo1` = 29384 WHERE `Id` = 12957;
UPDATE `creature_template` SET `gossip_menu_id` = '', `AIName` = '', `ScriptName` = 'npc_captive_mechagnome' WHERE `entry` = 29384;
