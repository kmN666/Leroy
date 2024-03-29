/*
 * Copyright (C) 2012 DeadCore <https://bitbucket.org/jacobcore/deadcore>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* ScriptData
SDName: Tanaris
SD%Complete: 80
SDComment: Quest support: 648, 1560, 2954, 4005, 10277, 10279(Special flight path). Noggenfogger vendor
SDCategory: Tanaris
EndScriptData */

/* ContentData
mob_aquementas
npc_custodian_of_time
npc_marin_noggenfogger
npc_steward_of_time
npc_stone_watcher_of_norgannon
npc_OOX17
npc_tooga
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "ScriptedFollowerAI.h"

/*######
## mob_aquementas
######*/

enum Aquementas
{
    AGGRO_YELL_AQUE     = -1000350,

    SPELL_AQUA_JET      = 13586,
    SPELL_FROST_SHOCK   = 15089
};

class mob_aquementas : public CreatureScript
{
public:
    mob_aquementas() : CreatureScript("mob_aquementas") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_aquementasAI (creature);
    }

    struct mob_aquementasAI : public ScriptedAI
    {
        mob_aquementasAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 SendItemTimer;
        uint32 SwitchFactionTimer;
        bool isFriendly;

        uint32 FrostShockTimer;
        uint32 AquaJetTimer;

        void Reset()
        {
            SendItemTimer = 0;
            SwitchFactionTimer = 10000;
            me->setFaction(35);
            isFriendly = true;

            AquaJetTimer = 5000;
            FrostShockTimer = 1000;
        }

        void SendItem(Unit* receiver)
        {
            if (CAST_PLR(receiver)->HasItemCount(11169, 1, false) &&
                CAST_PLR(receiver)->HasItemCount(11172, 11, false) &&
                CAST_PLR(receiver)->HasItemCount(11173, 1, false) &&
                !CAST_PLR(receiver)->HasItemCount(11522, 1, true))
            {
                ItemPosCountVec dest;
                uint8 msg = CAST_PLR(receiver)->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 11522, 1, NULL);
                if (msg == EQUIP_ERR_OK)
                    CAST_PLR(receiver)->StoreNewItem(dest, 11522, 1, true);
            }
        }

        void EnterCombat(Unit* who)
        {
            DoScriptText(AGGRO_YELL_AQUE, me, who);
        }

        void UpdateAI(const uint32 diff)
        {
            if (isFriendly)
            {
                if (SwitchFactionTimer <= diff)
                {
                    me->setFaction(91);
                    isFriendly = false;
                } else SwitchFactionTimer -= diff;
            }

            if (!UpdateVictim())
                return;

            if (!isFriendly)
            {
                if (SendItemTimer <= diff)
                {
                    if (me->getVictim()->GetTypeId() == TYPEID_PLAYER)
                        SendItem(me->getVictim());
                    SendItemTimer = 5000;
                } else SendItemTimer -= diff;
            }

            if (FrostShockTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_FROST_SHOCK);
                FrostShockTimer = 15000;
            } else FrostShockTimer -= diff;

            if (AquaJetTimer <= diff)
            {
                DoCast(me, SPELL_AQUA_JET);
                AquaJetTimer = 15000;
            } else AquaJetTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };

};

/*######
## npc_custodian_of_time
######*/

enum CustodianOfTime
{
    WHISPER_CUSTODIAN_1     = -1000217,
    WHISPER_CUSTODIAN_2     = -1000218,
    WHISPER_CUSTODIAN_3     = -1000219,
    WHISPER_CUSTODIAN_4     = -1000220,
    WHISPER_CUSTODIAN_5     = -1000221,
    WHISPER_CUSTODIAN_6     = -1000222,
    WHISPER_CUSTODIAN_7     = -1000223,
    WHISPER_CUSTODIAN_8     = -1000224,
    WHISPER_CUSTODIAN_9     = -1000225,
    WHISPER_CUSTODIAN_10    = -1000226,
    WHISPER_CUSTODIAN_11    = -1000227,
    WHISPER_CUSTODIAN_12    = -1000228,
    WHISPER_CUSTODIAN_13    = -1000229,
    WHISPER_CUSTODIAN_14    = -1000230
};

class npc_custodian_of_time : public CreatureScript
{
public:
    npc_custodian_of_time() : CreatureScript("npc_custodian_of_time") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_custodian_of_timeAI(creature);
    }

    struct npc_custodian_of_timeAI : public npc_escortAI
    {
        npc_custodian_of_timeAI(Creature* creature) : npc_escortAI(creature) {}

        void WaypointReached(uint32 waypointId)
        {
            if (Player* player = GetPlayerForEscort())
            {
                switch (waypointId)
                {
                    case 0:
                        DoScriptText(WHISPER_CUSTODIAN_1, me, player);
                        break;
                    case 1:
                        DoScriptText(WHISPER_CUSTODIAN_2, me, player);
                        break;
                    case 2:
                        DoScriptText(WHISPER_CUSTODIAN_3, me, player);
                        break;
                    case 3:
                        DoScriptText(WHISPER_CUSTODIAN_4, me, player);
                        break;
                    case 5:
                        DoScriptText(WHISPER_CUSTODIAN_5, me, player);
                        break;
                    case 6:
                        DoScriptText(WHISPER_CUSTODIAN_6, me, player);
                        break;
                    case 7:
                        DoScriptText(WHISPER_CUSTODIAN_7, me, player);
                        break;
                    case 8:
                        DoScriptText(WHISPER_CUSTODIAN_8, me, player);
                        break;
                    case 9:
                        DoScriptText(WHISPER_CUSTODIAN_9, me, player);
                        break;
                    case 10:
                        DoScriptText(WHISPER_CUSTODIAN_4, me, player);
                        break;
                    case 13:
                        DoScriptText(WHISPER_CUSTODIAN_10, me, player);
                        break;
                    case 14:
                        DoScriptText(WHISPER_CUSTODIAN_4, me, player);
                        break;
                    case 16:
                        DoScriptText(WHISPER_CUSTODIAN_11, me, player);
                        break;
                    case 17:
                        DoScriptText(WHISPER_CUSTODIAN_12, me, player);
                        break;
                    case 18:
                        DoScriptText(WHISPER_CUSTODIAN_4, me, player);
                        break;
                    case 22:
                        DoScriptText(WHISPER_CUSTODIAN_13, me, player);
                        break;
                    case 23:
                        DoScriptText(WHISPER_CUSTODIAN_4, me, player);
                        break;
                    case 24:
                        DoScriptText(WHISPER_CUSTODIAN_14, me, player);
                        DoCast(player, 34883);
                        // below here is temporary workaround, to be removed when spell works properly
                        player->AreaExploredOrEventHappens(10277);
                        break;
                }
            }
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (HasEscortState(STATE_ESCORT_ESCORTING))
                return;

            if (who->GetTypeId() == TYPEID_PLAYER)
            {
                if (who->HasAura(34877) && CAST_PLR(who)->GetQuestStatus(10277) == QUEST_STATUS_INCOMPLETE)
                {
                    float Radius = 10.0f;
                    if (me->IsWithinDistInMap(who, Radius))
                    {
                        Start(false, false, who->GetGUID());
                    }
                }
            }
        }

        void EnterCombat(Unit* /*who*/) {}
        void Reset() {}

        void UpdateAI(const uint32 diff)
        {
            npc_escortAI::UpdateAI(diff);
        }
    };

};

/*######
## npc_marin_noggenfogger
######*/

class npc_marin_noggenfogger : public CreatureScript
{
public:
    npc_marin_noggenfogger() : CreatureScript("npc_marin_noggenfogger") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_TRADE)
            player->GetSession()->SendListInventory(creature->GetGUID());

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (creature->isVendor() && player->GetQuestRewardStatus(2662))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

};

/*######
## npc_steward_of_time
######*/

#define GOSSIP_ITEM_FLIGHT  "Please take me to the master's lair."

class npc_steward_of_time : public CreatureScript
{
public:
    npc_steward_of_time() : CreatureScript("npc_steward_of_time") { }

    bool OnQuestAccept(Player* player, Creature* /*creature*/, Quest const* quest)
    {
        if (quest->GetQuestId() == 10279)                      //Quest: To The Master's Lair
            player->CastSpell(player, 34891, true);               //(Flight through Caverns)

        return false;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
            player->CastSpell(player, 34891, true);               //(Flight through Caverns)

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(10279) == QUEST_STATUS_INCOMPLETE || player->GetQuestRewardStatus(10279))
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_FLIGHT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->SEND_GOSSIP_MENU(9978, creature->GetGUID());
        }
        else
            player->SEND_GOSSIP_MENU(9977, creature->GetGUID());

        return true;
    }

};

/*######
## npc_stone_watcher_of_norgannon
######*/

#define GOSSIP_ITEM_NORGANNON_1     "What function do you serve?"
#define GOSSIP_ITEM_NORGANNON_2     "What are the Plates of Uldum?"
#define GOSSIP_ITEM_NORGANNON_3     "Where are the Plates of Uldum?"
#define GOSSIP_ITEM_NORGANNON_4     "Excuse me? We've been \"reschedueled for visitations\"? What does that mean?!"
#define GOSSIP_ITEM_NORGANNON_5     "So, what's inside Uldum?"
#define GOSSIP_ITEM_NORGANNON_6     "I will return when i have the Plates of Uldum."

class npc_stone_watcher_of_norgannon : public CreatureScript
{
public:
    npc_stone_watcher_of_norgannon() : CreatureScript("npc_stone_watcher_of_norgannon") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_NORGANNON_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
                player->SEND_GOSSIP_MENU(1675, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+1:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_NORGANNON_3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
                player->SEND_GOSSIP_MENU(1676, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_NORGANNON_4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
                player->SEND_GOSSIP_MENU(1677, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_NORGANNON_5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
                player->SEND_GOSSIP_MENU(1678, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+4:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_NORGANNON_6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
                player->SEND_GOSSIP_MENU(1679, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+5:
                player->CLOSE_GOSSIP_MENU();
                player->AreaExploredOrEventHappens(2954);
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(2954) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_NORGANNON_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

        player->SEND_GOSSIP_MENU(1674, creature->GetGUID());

        return true;
    }

};

/*######
## npc_OOX17
######*/

enum Npc00X17
{
    //texts are signed for 7806
    SAY_OOX_START           = -1000287,
    SAY_OOX_AGGRO1          = -1000288,
    SAY_OOX_AGGRO2          = -1000289,
    SAY_OOX_AMBUSH          = -1000290,
    SAY_OOX17_AMBUSH_REPLY  = -1000291,
    SAY_OOX_END             = -1000292,

    Q_OOX17                 = 648,
    SPAWN_FIRST             = 7803,
    SPAWN_SECOND_1          = 5617,
    SPAWN_SECOND_2          = 7805
};

class npc_OOX17 : public CreatureScript
{
public:
    npc_OOX17() : CreatureScript("npc_OOX17") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == Q_OOX17)
        {
            creature->setFaction(113);
            creature->SetFullHealth();
            creature->SetUInt32Value(UNIT_FIELD_BYTES_1, 0);
            creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
            DoScriptText(SAY_OOX_START, creature);

            if (npc_escortAI* pEscortAI = CAST_AI(npc_OOX17::npc_OOX17AI, creature->AI()))
                pEscortAI->Start(true, false, player->GetGUID());
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_OOX17AI(creature);
    }

    struct npc_OOX17AI : public npc_escortAI
    {
        npc_OOX17AI(Creature* creature) : npc_escortAI(creature) {}

        void WaypointReached(uint32 waypointId)
        {
            if (Player* player = GetPlayerForEscort())
            {
                switch (waypointId)
                {
                    case 23:
                        me->SummonCreature(SPAWN_FIRST, -8350.96f, -4445.79f, 10.10f, 6.20f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                        me->SummonCreature(SPAWN_FIRST, -8355.96f, -4447.79f, 10.10f, 6.27f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                        me->SummonCreature(SPAWN_FIRST, -8353.96f, -4442.79f, 10.10f, 6.08f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                        DoScriptText(SAY_OOX_AMBUSH, me);
                        break;
                    case 56:
                        me->SummonCreature(SPAWN_SECOND_1, -7510.07f, -4795.50f, 9.35f, 6.06f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                        me->SummonCreature(SPAWN_SECOND_2, -7515.07f, -4797.50f, 9.35f, 6.22f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                        me->SummonCreature(SPAWN_SECOND_2, -7518.07f, -4792.50f, 9.35f, 6.22f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                        DoScriptText(SAY_OOX_AMBUSH, me);
                        if (Unit* scoff = me->FindNearestCreature(SPAWN_SECOND_2, 30))
                            DoScriptText(SAY_OOX17_AMBUSH_REPLY, scoff);
                        break;
                    case 86:
                        DoScriptText(SAY_OOX_END, me);
                        player->GroupEventHappens(Q_OOX17, me);
                        break;
                }
            }
        }

        void Reset(){}

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(RAND(SAY_OOX_AGGRO1, SAY_OOX_AGGRO2), me);
        }

        void JustSummoned(Creature* summoned)
        {
            summoned->AI()->AttackStart(me);
        }
    };
};

/*####
# npc_tooga
####*/

enum Tooga
{
    SAY_TOOG_THIRST             = -1000391,
    SAY_TOOG_WORRIED            = -1000392,
    SAY_TOOG_POST_1             = -1000393,
    SAY_TORT_POST_2             = -1000394,
    SAY_TOOG_POST_3             = -1000395,
    SAY_TORT_POST_4             = -1000396,
    SAY_TOOG_POST_5             = -1000397,
    SAY_TORT_POST_6             = -1000398,

    QUEST_TOOGA                 = 1560,
    NPC_TORTA                   = 6015,

    POINT_ID_TO_WATER           = 1,
    FACTION_TOOG_ESCORTEE       = 113
};

Position const ToWaterLoc = {-7032.664551f, -4906.199219f, -1.606446f, 0.0f};

class npc_tooga : public CreatureScript
{
public:
    npc_tooga() : CreatureScript("npc_tooga") { }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest)
    {
        if (quest->GetQuestId() == QUEST_TOOGA)
        {
            if (npc_toogaAI* pToogaAI = CAST_AI(npc_tooga::npc_toogaAI, creature->AI()))
                pToogaAI->StartFollow(player, FACTION_TOOG_ESCORTEE, quest);
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_toogaAI(creature);
    }

    struct npc_toogaAI : public FollowerAI
    {
        npc_toogaAI(Creature* creature) : FollowerAI(creature) { }

        uint32 CheckSpeechTimer;
        uint32 PostEventTimer;
        uint32 PhasePostEvent;

        uint64 TortaGUID;

        void Reset()
        {
            CheckSpeechTimer = 2500;
            PostEventTimer = 1000;
            PhasePostEvent = 0;

            TortaGUID = 0;
        }

        void MoveInLineOfSight(Unit* who)
        {
            FollowerAI::MoveInLineOfSight(who);

            if (!me->getVictim() && !HasFollowState(STATE_FOLLOW_COMPLETE | STATE_FOLLOW_POSTEVENT) && who->GetEntry() == NPC_TORTA)
            {
                if (me->IsWithinDistInMap(who, INTERACTION_DISTANCE))
                {
                    Player* player = GetLeaderForFollower();
                    if (player && player->GetQuestStatus(QUEST_TOOGA) == QUEST_STATUS_INCOMPLETE)
                        player->GroupEventHappens(QUEST_TOOGA, me);

                    TortaGUID = who->GetGUID();
                    SetFollowComplete(true);
                }
            }
        }

        void MovementInform(uint32 MotionType, uint32 PointId)
        {
            FollowerAI::MovementInform(MotionType, PointId);

            if (MotionType != POINT_MOTION_TYPE)
                return;

            if (PointId == POINT_ID_TO_WATER)
                SetFollowComplete();
        }

        void UpdateFollowerAI(const uint32 Diff)
        {
            if (!UpdateVictim())
            {
                //we are doing the post-event, or...
                if (HasFollowState(STATE_FOLLOW_POSTEVENT))
                {
                    if (PostEventTimer <= Diff)
                    {
                        PostEventTimer = 5000;

                        Unit* pTorta = Unit::GetUnit(*me, TortaGUID);
                        if (!pTorta || !pTorta->isAlive())
                        {
                            //something happened, so just complete
                            SetFollowComplete();
                            return;
                        }

                        switch (PhasePostEvent)
                        {
                            case 1:
                                DoScriptText(SAY_TOOG_POST_1, me);
                                break;
                            case 2:
                                DoScriptText(SAY_TORT_POST_2, pTorta);
                                break;
                            case 3:
                                DoScriptText(SAY_TOOG_POST_3, me);
                                break;
                            case 4:
                                DoScriptText(SAY_TORT_POST_4, pTorta);
                                break;
                            case 5:
                                DoScriptText(SAY_TOOG_POST_5, me);
                                break;
                            case 6:
                                DoScriptText(SAY_TORT_POST_6, pTorta);
                                me->GetMotionMaster()->MovePoint(POINT_ID_TO_WATER, ToWaterLoc);
                                break;
                        }

                        ++PhasePostEvent;
                    }
                    else
                        PostEventTimer -= Diff;
                }
                //...we are doing regular speech check
                else if (HasFollowState(STATE_FOLLOW_INPROGRESS))
                {
                    if (CheckSpeechTimer <= Diff)
                    {
                        CheckSpeechTimer = 5000;

                        if (urand(0, 9) > 8)
                            DoScriptText(RAND(SAY_TOOG_THIRST, SAY_TOOG_WORRIED), me);
                    }
                    else
                        CheckSpeechTimer -= Diff;
                }

                return;
            }

            DoMeleeAttackIfReady();
        }
    };

};

void AddSC_tanaris()
{
    new mob_aquementas();
    new npc_custodian_of_time();
    new npc_marin_noggenfogger();
    new npc_steward_of_time();
    new npc_stone_watcher_of_norgannon();
    new npc_OOX17();
    new npc_tooga();
}
