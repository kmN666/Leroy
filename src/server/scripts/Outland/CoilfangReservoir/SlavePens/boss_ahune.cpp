/*
 * Copyright (C) 2012 DeadCore <https://bitbucket.org/jacobcore/deadcore>
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

#include "ScriptPCH.h"

enum Creatures
{
    NPC_AHUNE                   = 25740,
    NPC_FROZEN_CORE             = 25865,
    NPC_AHUNITE_COLDWEAVE       = 25756,
    NPC_AHUNITE_FROSTWIND       = 25757,
    NPC_AHUNITE_HAILSTONE       = 25755,
    NPC_SLIPPERY_FLOOR          = 25952,
    NPC_ICESPEAR_BUNNY          = 25985,
    NPC_EARTHEN_RING_TOTEM      = 25961,
};

enum GameObjects
{
    GO_ICE_STONE                = 187882,
    GO_ICE_SPEAR                = 188077,
    GO_ICE_CHEST                = 187892,
};

enum Spells
{
    // Ahune
    SPELL_AHUNES_SHIELD         = 45954,
    SPELL_COLD_SLAP             = 46145,

    SPELL_ICESPEAR_SUMMON_BUNNY = 46359,
    SPELL_ICESPEAR_SUMMON_GO    = 46369,
    SPELL_ICESPEAR_KNOCKBACK    = 46360, 

    SPELL_MAKE_BONFIRE          = 45930,
    SPELL_SUMMONING_VISUAL1     = 45937, 
    SPELL_SUMMONING_VISUAL2     = 45938, 
    SPELL_SUMMON_MINION_VISUAL  = 46103, 
    SPELL_GHOST_VISUAL          = 46786,
    SPELL_RESURFACE             = 46402, 
    SPELL_SLIPPERY_FLOOR_AMBIENT = 46314,

    SPELL_LOOT_CHEST            = 45939,
    SPELL_LOOT_CHEST_HC         = 46622,

    SPELL_AHUNE_ACHIEVEMENT     = 62043, 

    SPELL_BEAM_ATTACK           = 46336, 
    SPELL_BEAM_ATTACK_BEAM      = 46363,

    SPELL_BITTER_BLAST          = 46406,

    SPELL_LIGHTNING_SHIELD      = 12550,
    SPELL_WIND_BUFFET           = 46568,

    SPELL_CHILLING_AURA         = 46542, 
    SPELL_CHILLING_AURA_PERIODIC = 46885, 
    SPELL_PULVERIZE             = 2676,
};

enum Events
{
    EVENT_SWITCH_PHASE          = 1,
    EVENT_SUMMON_HAILSTONE      = 2,
    EVENT_SUMMON_COLDWEAVE      = 3,
    EVENT_SUMMON_FROSTWIND      = 4,
    EVENT_ICE_SPEAR             = 5,
    EVENT_ICE_SPEAR_KNOCKBACK   = 6,
    EVENT_COLD_SLAP             = 7,

    EVENT_GHOST_VISUAL          = 8,
    EVENT_RESURFACE_SOON        = 9,

    EVENT_BITTER_BLAST          = 10,

    EVENT_WIND_BUFFET           = 11,

    EVENT_CHILLING_AURA         = 12,
    EVENT_PULVERIZE             = 13,

    EVENT_EARTHEN_RING_ATTACK   = 14,
};

enum Phases
{
    PHASE_ONE    = 1,
    PHASE_TWO    = 2,

    PHASE_MASK_ONE  = 1 << PHASE_ONE,
    PHASE_MASK_TWO  = 1 << PHASE_TWO,
};

#define GOSSIP_AHUNE_SUMMON "Disturb the Stone and summon Lord Ahune."
#define EMOTE_SUBMERGE "Ahune Retreats. His Defenses Diminish."
#define EMOTE_EMERGE_SOON "Ahune will soon resurface."



Position const SummonPositions[4] =
{
        {-88.495071f, -254.462997f, -1.077302f, 1.84f}, 
        {-90.891891f, -243.488068f, -1.116222f}, 
        {-97.389175f, -239.780701f, -1.264044f}, 
        {-85.160637f, -236.127808f, -1.572418f}, 
};

class boss_ahune : public CreatureScript
{
    public:
        boss_ahune() : CreatureScript("boss_ahune") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_ahuneAI(creature);
        }

        struct boss_ahuneAI : public Scripted_NoMovementAI
        {
            boss_ahuneAI(Creature* creature) : Scripted_NoMovementAI(creature), summons(me) { }

            EventMap events;
            SummonList summons;

            bool intro;

            void Reset()
            {
                summons.DespawnAll();

                events.Reset();
                events.SetPhase(PHASE_ONE);

                intro = false;

                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK_DEST, true);

                me->CastSpell(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), SPELL_SUMMONING_VISUAL1, true);
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);

                me->AddAura(SPELL_AHUNES_SHIELD, me);
            }

            void EnterCombat(Unit* who)
            {
                DoZoneInCombat();

                events.Reset();
                events.SetPhase(PHASE_ONE);
                events.ScheduleEvent(EVENT_SWITCH_PHASE, 90000); 
                events.ScheduleEvent(EVENT_COLD_SLAP, 500, 0, PHASE_ONE); 
                events.ScheduleEvent(EVENT_SUMMON_HAILSTONE, 1000, 0, PHASE_ONE); 
                events.ScheduleEvent(EVENT_SUMMON_COLDWEAVE, 8000, 0, PHASE_ONE); 
                events.ScheduleEvent(EVENT_ICE_SPEAR, 9500, 0, PHASE_ONE); 
                events.ScheduleEvent(EVENT_EARTHEN_RING_ATTACK, 10000, 0, PHASE_ONE); 
            }

            void JustDied(Unit* killer)
            {
                Map::PlayerList const& playerList = me->GetMap()->GetPlayers();
                if (!playerList.isEmpty())
                    for (Map::PlayerList::const_iterator i = playerList.begin(); i != playerList.end(); ++i)
                        if (i->getSource())
                            DoCast(i->getSource(), SPELL_AHUNE_ACHIEVEMENT);

                DoCast(me, SPELL_LOOT_CHEST);
            }

            void JustSummoned(Creature* summoned)
            {
                summons.Summon(summoned);

                switch (summoned->GetEntry())
                {
                    case NPC_ICESPEAR_BUNNY:
                        summoned->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_DISABLE_MOVE);
                        break;
                    case NPC_SLIPPERY_FLOOR:
                        summoned->SetReactState(REACT_PASSIVE);
                        summoned->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_DISABLE_MOVE);
                        summoned->SetDisplayId(11686);
                        me->AddAura(SPELL_SLIPPERY_FLOOR_AMBIENT, summoned);
                        return;
                    case NPC_FROZEN_CORE:
                        summoned->SetHealth(me->GetHealth()); // sync health on phase change
                        break;
                }

                DoZoneInCombat(summoned);
            }

            void SummonedCreatureDespawn(Creature* summoned)
            {
                summons.Despawn(summoned);
            }

            void UpdateAI(uint32 const diff)
            {
                if (!intro)
                {
                    me->SummonCreature(NPC_SLIPPERY_FLOOR, SummonPositions[0]); // floor ambient
                    me->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    intro = true;
                }

                if (!UpdateVictim())
                    return;

                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_SWITCH_PHASE:
                            if (events.GetPhaseMask() & PHASE_MASK_ONE)
                            {
                                // Emote: Ahune retreats. His defenses diminish.
                                //                                 me->MonsterTextEmote(EMOTE_SUBMERGE, 0, true); //Hack Fix by jacob


                                events.SetPhase(PHASE_TWO);
                                events.ScheduleEvent(EVENT_SWITCH_PHASE, 30000);

                                DoCast(me, SPELL_MAKE_BONFIRE);

                                me->AttackStop();
                                me->SetReactState(REACT_PASSIVE);
                                me->setFaction(35);
                                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_SUBMERGED);
                                me->HandleEmoteCommand(EMOTE_ONESHOT_SUBMERGE);

                                me->SummonCreature(NPC_FROZEN_CORE, SummonPositions[0], TEMPSUMMON_CORPSE_DESPAWN);
                            }
                            else
                            {
                                events.SetPhase(PHASE_ONE);
                                events.ScheduleEvent(EVENT_SWITCH_PHASE, 90000);
                                events.ScheduleEvent(EVENT_COLD_SLAP, 500, 0, PHASE_ONE);
                                events.ScheduleEvent(EVENT_SUMMON_HAILSTONE, 1000, 0, PHASE_ONE);
                                events.ScheduleEvent(EVENT_SUMMON_COLDWEAVE, 8000, 0, PHASE_ONE);
                                events.ScheduleEvent(EVENT_SUMMON_FROSTWIND, 9000, 0, PHASE_ONE);
                                events.ScheduleEvent(EVENT_ICE_SPEAR, 9500, 0, PHASE_ONE);
                                events.ScheduleEvent(EVENT_EARTHEN_RING_ATTACK, 10000, 0, PHASE_ONE);

                                me->SetReactState(REACT_AGGRESSIVE);
                                me->setFaction(14);
                                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                                me->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);

                                DoCastVictim(SPELL_RESURFACE);

                                summons.DespawnEntry(NPC_FROZEN_CORE);
                            }
                            break;
                        case EVENT_COLD_SLAP:
                            if (Unit* target = SelectTarget(SELECT_TARGET_NEAREST, 0, 8.0f, true))
                            {
                                DoCast(target, SPELL_COLD_SLAP);
                                Position targetPos;
                                target->GetNearPosition(targetPos, float(rand_norm()) * 5.0f + 35.0f, me->GetAngle(target));
                                target->GetMotionMaster()->MoveJump(targetPos.GetPositionX(), targetPos.GetPositionY(), targetPos.GetPositionZ(), target->GetExactDist2d(targetPos.GetPositionX(), targetPos.GetPositionY()), 10.0f);
                            }
                            events.ScheduleEvent(EVENT_COLD_SLAP, 500, 0, PHASE_ONE);
                            break;
                        case EVENT_ICE_SPEAR: 
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 120.0f, true))
                            {
                                target->CastSpell(target, SPELL_ICESPEAR_SUMMON_BUNNY);
                                target->CastSpell(target, SPELL_ICESPEAR_SUMMON_GO);
                                events.ScheduleEvent(EVENT_ICE_SPEAR_KNOCKBACK, 2000);
                            }
                            events.ScheduleEvent(EVENT_ICE_SPEAR, 7000, 0, PHASE_ONE);
                            break;
                        case EVENT_ICE_SPEAR_KNOCKBACK:
                            if (GameObject* go = me->FindNearestGameObject(GO_ICE_SPEAR, 120.0f))
                            {
                                go->UseDoorOrButton();
                                Map::PlayerList const& playerList = me->GetMap()->GetPlayers();
                                if (!playerList.isEmpty())
                                    for (Map::PlayerList::const_iterator i = playerList.begin(); i != playerList.end(); ++i)
                                        if (i->getSource() && go->GetDistance(i->getSource()) <= 2.0f)
                                            i->getSource()->CastSpell(i->getSource(), SPELL_ICESPEAR_KNOCKBACK);
                                go->Delete();
                            }
                            break;
                        case EVENT_SUMMON_HAILSTONE:
                            me->SummonCreature(NPC_AHUNITE_HAILSTONE, SummonPositions[1], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                            break;
                        case EVENT_SUMMON_COLDWEAVE: 
                            me->SummonCreature(NPC_AHUNITE_COLDWEAVE, SummonPositions[2], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                            me->SummonCreature(NPC_AHUNITE_COLDWEAVE, SummonPositions[3], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                            events.ScheduleEvent(EVENT_SUMMON_COLDWEAVE, 5000, 0, PHASE_ONE);
                            break;
                        case EVENT_SUMMON_FROSTWIND: 
                            me->SummonCreature(NPC_AHUNITE_FROSTWIND, SummonPositions[urand(2,3)], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                            events.ScheduleEvent(EVENT_SUMMON_FROSTWIND, 7000, 0, PHASE_ONE);
                            break;
                        case EVENT_EARTHEN_RING_ATTACK:
                            if (Creature* totem = me->FindNearestCreature(NPC_EARTHEN_RING_TOTEM, 200.0f))
                            {
                                totem->CastSpell(me, SPELL_BEAM_ATTACK, false);
                                totem->CastSpell(me, SPELL_BEAM_ATTACK_BEAM, false);
                            }
                            events.ScheduleEvent(EVENT_EARTHEN_RING_ATTACK, 10000, 0, PHASE_ONE);
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };
};

class npc_frozen_core : public CreatureScript
{
    public:
        npc_frozen_core() : CreatureScript("npc_frozen_core") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_frozen_coreAI(creature);
        }

        struct npc_frozen_coreAI : public Scripted_NoMovementAI
        {
            npc_frozen_coreAI(Creature* creature) : Scripted_NoMovementAI(creature) { }

            EventMap events;

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_RESURFACE_SOON, 25000); 

                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK_DEST, true);

                me->MonsterTextEmote(EMOTE_SUBMERGE, 0, true);
            }

            void DamageTaken(Unit* who, uint32& damage)
            {
                if (me->ToTempSummon())
                {
                    if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                    {
                        if (me->GetHealth() > damage)
                            summoner->SetHealth((summoner->GetMaxHealth() / 100) * me->GetHealthPct());
                        else
                            who->Kill(summoner);
                    }
                }
                if (!me->HasAura(SPELL_GHOST_VISUAL))
                    DoCast(me, SPELL_GHOST_VISUAL);
            }

            void JustDied(Unit* killer)
            {
                if (me->ToTempSummon())
                    if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                        if (summoner->isAlive())
                            killer->Kill(summoner);
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_RESURFACE_SOON:
                            me->MonsterTextEmote(EMOTE_EMERGE_SOON, 0, true);
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };
};

class go_ice_stone : public GameObjectScript
{
    public:
        go_ice_stone() : GameObjectScript("go_ice_stone") { }

        bool OnGossipHello(Player* player, GameObject* go)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_AHUNE_SUMMON, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
            player->SEND_GOSSIP_MENU(player->GetGossipTextId(go), go->GetGUID());

            return true;
        }

        bool OnGossipSelect(Player* player, GameObject* go, uint32 /*sender*/, uint32 action)
        {
            player->PlayerTalkClass->ClearMenus();

            if (action == GOSSIP_ACTION_INFO_DEF)
            {
                go->SummonCreature(NPC_AHUNE, SummonPositions[0], TEMPSUMMON_DEAD_DESPAWN);
                go->Delete();
            }

            return true;
        }
};

class npc_ahunite_hailstone : public CreatureScript
{
    public:
        npc_ahunite_hailstone() : CreatureScript("npc_ahunite_hailstone") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_ahunite_hailstoneAI(creature);
        }

        struct npc_ahunite_hailstoneAI : public ScriptedAI
        {
            npc_ahunite_hailstoneAI(Creature* creature) : ScriptedAI(creature) { }

            EventMap events;

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_PULVERIZE, urand(6000, 8000));

                DoCast(me, SPELL_CHILLING_AURA);
                DoCast(me, SPELL_CHILLING_AURA_PERIODIC); 
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_PULVERIZE:
                            DoCastVictim(SPELL_PULVERIZE);
                            events.ScheduleEvent(EVENT_PULVERIZE, urand(6000, 8000));
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };
};

class npc_ahunite_coldweave : public CreatureScript
{
    public:
        npc_ahunite_coldweave() : CreatureScript("npc_ahunite_coldweave") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_ahunite_coldweaveAI(creature);
        }

        struct npc_ahunite_coldweaveAI : public ScriptedAI
        {
            npc_ahunite_coldweaveAI(Creature* creature) : ScriptedAI(creature) { }

            EventMap events;

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_BITTER_BLAST, 500);
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_BITTER_BLAST:
                            DoCastVictim(SPELL_BITTER_BLAST);
                            events.ScheduleEvent(EVENT_BITTER_BLAST, urand(5000, 7000));
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };
};

class npc_ahunite_frostwind : public CreatureScript
{
    public:
        npc_ahunite_frostwind() : CreatureScript("npc_ahunite_frostwind") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_ahunite_frostwindAI(creature);
        }

        struct npc_ahunite_frostwindAI : public ScriptedAI
        {
            npc_ahunite_frostwindAI(Creature* creature) : ScriptedAI(creature) { }

            EventMap events;

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_WIND_BUFFET, 2000); 

                DoCast(me, SPELL_LIGHTNING_SHIELD);
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_WIND_BUFFET:
                            if (Unit* target = SelectTarget(SELECT_TARGET_FARTHEST, 0, 120.0f))
                                DoCast(target, SPELL_WIND_BUFFET);
                            events.ScheduleEvent(EVENT_WIND_BUFFET, urand(5000, 7000));
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };
};

void AddSC_boss_ahune()
{
    new boss_ahune();
    new npc_frozen_core();
    new go_ice_stone();
    new npc_ahunite_hailstone();
    new npc_ahunite_coldweave();
    new npc_ahunite_frostwind();
}