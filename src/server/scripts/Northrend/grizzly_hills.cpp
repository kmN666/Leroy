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

#include "ScriptPCH.h"
#include "ScriptedEscortAI.h"

/*######
## Quest 12027: Mr. Floppy's Perilous Adventure
######*/

enum eFloppy
{
    NPC_MRFLOPPY                = 26589,
    NPC_HUNGRY_WORG             = 26586,
    NPC_RAVENOUS_WORG           = 26590,   //RWORG
    NPC_EMILY                   = 26588,

    QUEST_PERILOUS_ADVENTURE    = 12027,

    SPELL_MRFLOPPY              = 47184,    //vehicle aura

    SAY_WORGHAGGRO1             = -1800001, //Um... I think one of those wolves is back...
    SAY_WORGHAGGRO2             = -1800002, //He's going for Mr. Floppy!
    SAY_WORGRAGGRO3             = -1800003, //Oh, no! Look, it's another wolf, and it's a biiiiiig one!
    SAY_WORGRAGGRO4             = -1800004, //He's gonna eat Mr. Floppy! You gotta help Mr. Floppy! You just gotta!
    SAY_RANDOMAGGRO             = -1800005, //There's a big meanie attacking Mr. Floppy! Help!
    SAY_VICTORY1                = -1800006, //Let's get out of here before more wolves find us!
    SAY_VICTORY2                = -1800007, //Don't go toward the light, Mr. Floppy!
    SAY_VICTORY3                = -1800008, //Mr. Floppy, you're ok! Thank you so much for saving Mr. Floppy!
    SAY_VICTORY4                = -1800009, //I think I see the camp! We're almost home, Mr. Floppy! Let's go!
    TEXT_EMOTE_WP1              = -1800010, //Mr. Floppy revives
    TEXT_EMOTE_AGGRO            = -1800011, //The Ravenous Worg chomps down on Mr. Floppy
    SAY_QUEST_ACCEPT            = -1800012, //Are you ready, Mr. Floppy? Stay close to me and watch out for those wolves!
    SAY_QUEST_COMPLETE          = -1800013  //Thank you for helping me get back to the camp. Go tell Walter that I'm safe now!
};

//emily
class npc_emily : public CreatureScript
{
public:
    npc_emily() : CreatureScript("npc_emily") { }

    struct npc_emilyAI : public npc_escortAI
    {
        npc_emilyAI(Creature* creature) : npc_escortAI(creature) { }

        uint32 m_uiChatTimer;

        uint64 RWORGGUID;
        uint64 MrfloppyGUID;

        bool Completed;

        void JustSummoned(Creature* summoned)
        {
            if (Creature* Mrfloppy = GetClosestCreatureWithEntry(me, NPC_MRFLOPPY, 50.0f))
                summoned->AI()->AttackStart(Mrfloppy);
            else
                summoned->AI()->AttackStart(me->getVictim());
        }

        void WaypointReached(uint32 waypointId)
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 9:
                    if (Creature* Mrfloppy = GetClosestCreatureWithEntry(me, NPC_MRFLOPPY, 100.0f))
                        MrfloppyGUID = Mrfloppy->GetGUID();
                    break;
                case 10:
                    if (Unit::GetCreature(*me, MrfloppyGUID))
                    {
                        DoScriptText(SAY_WORGHAGGRO1, me);
                        me->SummonCreature(NPC_HUNGRY_WORG, me->GetPositionX()+5, me->GetPositionY()+2, me->GetPositionZ()+1, 3.229f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 120000);
                    }
                    break;
                case 11:
                    if (Creature* Mrfloppy = Unit::GetCreature(*me, MrfloppyGUID))
                        Mrfloppy->GetMotionMaster()->MoveFollow(me, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
                    break;
                case 17:
                    if (Creature* Mrfloppy = Unit::GetCreature(*me, MrfloppyGUID))
                        Mrfloppy->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
                    DoScriptText(SAY_WORGRAGGRO3, me);
                    if (Creature* RWORG = me->SummonCreature(NPC_RAVENOUS_WORG, me->GetPositionX()+10, me->GetPositionY()+8, me->GetPositionZ()+2, 3.229f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 120000))
                    {
                        RWORG->setFaction(35);
                        RWORGGUID = RWORG->GetGUID();
                    }
                    break;
                case 18:
                    if (Creature* Mrfloppy = Unit::GetCreature(*me, MrfloppyGUID))
                    {
                        if (Creature* RWORG = Unit::GetCreature(*me, RWORGGUID))
                            RWORG->GetMotionMaster()->MovePoint(0, Mrfloppy->GetPositionX(), Mrfloppy->GetPositionY(), Mrfloppy->GetPositionZ());
                        DoCast(Mrfloppy, SPELL_MRFLOPPY);
                    }
                    break;
                case 19:
                    if (Creature* Mrfloppy = Unit::GetCreature(*me, MrfloppyGUID))
                    {
                        if (Mrfloppy->HasAura(SPELL_MRFLOPPY, 0))
                        {
                            if (Creature* RWORG = Unit::GetCreature(*me, RWORGGUID))
                                Mrfloppy->EnterVehicle(RWORG);
                        }
                    }
                    break;
                case 20:
                    if (Creature* RWORG = Unit::GetCreature(*me, RWORGGUID))
                        RWORG->HandleEmoteCommand(34);
                    break;
                case 21:
                    if (Creature* Mrfloppy = Unit::GetCreature(*me, MrfloppyGUID))
                    {
                        if (Creature* RWORG = Unit::GetCreature(*me, RWORGGUID))
                        {
                            RWORG->Kill(Mrfloppy);
                            Mrfloppy->ExitVehicle();
                            RWORG->setFaction(14);
                            RWORG->GetMotionMaster()->MovePoint(0, RWORG->GetPositionX()+10, RWORG->GetPositionY()+80, RWORG->GetPositionZ());
                            DoScriptText(SAY_VICTORY2, me);
                        }
                    }
                    break;
                case 22:
                    if (Creature* Mrfloppy = Unit::GetCreature(*me, MrfloppyGUID))
                    {
                        if (Mrfloppy->isDead())
                        {
                            if (Creature* RWORG = Unit::GetCreature(*me, RWORGGUID))
                                RWORG->DisappearAndDie();
                            me->GetMotionMaster()->MovePoint(0, Mrfloppy->GetPositionX(), Mrfloppy->GetPositionY(), Mrfloppy->GetPositionZ());
                            Mrfloppy->setDeathState(ALIVE);
                            Mrfloppy->GetMotionMaster()->MoveFollow(me, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
                            DoScriptText(SAY_VICTORY3, me);
                        }
                    }
                    break;
                case 24:
                    if (player)
                    {
                        Completed = true;
                        player->GroupEventHappens(QUEST_PERILOUS_ADVENTURE, me);
                        DoScriptText(SAY_QUEST_COMPLETE, me, player);
                    }
                    me->SetWalk(false);
                    break;
                case 25:
                    DoScriptText(SAY_VICTORY4, me);
                    break;
                case 27:
                    me->DisappearAndDie();
                    if (Creature* Mrfloppy = Unit::GetCreature(*me, MrfloppyGUID))
                        Mrfloppy->DisappearAndDie();
                    break;
            }
        }

        void EnterCombat(Unit* /*Who*/)
        {
            DoScriptText(SAY_RANDOMAGGRO, me);
        }

        void Reset()
        {
            m_uiChatTimer = 4000;
            MrfloppyGUID = 0;
            RWORGGUID = 0;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            npc_escortAI::UpdateAI(uiDiff);

            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
                if (m_uiChatTimer <= uiDiff)
                    m_uiChatTimer = 12000;
                else
                    m_uiChatTimer -= uiDiff;
            }
        }
    };

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_PERILOUS_ADVENTURE)
        {
            DoScriptText(SAY_QUEST_ACCEPT, creature);
            if (Creature* Mrfloppy = GetClosestCreatureWithEntry(creature, NPC_MRFLOPPY, 180.0f))
                Mrfloppy->GetMotionMaster()->MoveFollow(creature, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);

            if (npc_escortAI* pEscortAI = CAST_AI(npc_emily::npc_emilyAI, (creature->AI())))
                pEscortAI->Start(true, false, player->GetGUID());
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_emilyAI(creature);
    }
};

//mrfloppy
class npc_mrfloppy : public CreatureScript
{
public:
    npc_mrfloppy() : CreatureScript("npc_mrfloppy") { }

    struct npc_mrfloppyAI : public ScriptedAI
    {
        npc_mrfloppyAI(Creature* creature) : ScriptedAI(creature) {}

        uint64 EmilyGUID;
        uint64 RWORGGUID;
        uint64 HWORGGUID;

        void Reset() {}

        void EnterCombat(Unit* Who)
        {
            if (Creature* Emily = GetClosestCreatureWithEntry(me, NPC_EMILY, 50.0f))
            {
                switch (Who->GetEntry())
                {
                    case NPC_HUNGRY_WORG:
                        DoScriptText(SAY_WORGHAGGRO2, Emily);
                        break;
                    case NPC_RAVENOUS_WORG:
                        DoScriptText(SAY_WORGRAGGRO4, Emily);
                        break;
                    default:
                        DoScriptText(SAY_RANDOMAGGRO, Emily);
                }
            }
        }

        void EnterEvadeMode() {}

        void MoveInLineOfSight(Unit* /*who*/) {}

        void UpdateAI(const uint32 /*diff*/)
        {
            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_mrfloppyAI(creature);
    }
};

// Outhouse Bunny

enum eOuthouseBunny
{
    SPELL_OUTHOUSE_GROANS           = 48382,
    SPELL_CAMERA_SHAKE              = 47533,
    SPELL_DUST_FIELD                = 48329
};

enum eSounds
{
    SOUND_FEMALE        = 12671,
    SOUND_MALE          = 12670
};

class npc_outhouse_bunny : public CreatureScript
{
public:
    npc_outhouse_bunny() : CreatureScript("npc_outhouse_bunny") { }

    struct npc_outhouse_bunnyAI : public ScriptedAI
    {
        npc_outhouse_bunnyAI(Creature* creature) : ScriptedAI(creature) {}

        uint8 m_counter;
        uint8 m_gender;

        void Reset()
        {
            m_counter = 0;
            m_gender = 0;
        }

        void SetData(uint32 uiType, uint32 uiData)
        {
            if (uiType == 1)
                m_gender = uiData;
        }

        void SpellHit(Unit* pCaster, const SpellInfo* pSpell)
        {
             if (pSpell->Id == SPELL_OUTHOUSE_GROANS)
             {
                ++m_counter;
                if (m_counter < 5)
                    DoCast(pCaster, SPELL_CAMERA_SHAKE, true);
                else
                    m_counter = 0;
                DoCast(me, SPELL_DUST_FIELD, true);
                switch (m_gender)
                {
                    case GENDER_FEMALE:
                        DoPlaySoundToSet(me, SOUND_FEMALE);
                        break;

                    case GENDER_MALE:
                        DoPlaySoundToSet(me, SOUND_MALE);
                        break;
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_outhouse_bunnyAI(creature);
    }
};

// Tallhorn Stage

enum etallhornstage
{
    OBJECT_HAUNCH                   = 188665
};

class npc_tallhorn_stag : public CreatureScript
{
public:
    npc_tallhorn_stag() : CreatureScript("npc_tallhorn_stag") { }

    struct npc_tallhorn_stagAI : public ScriptedAI
    {
        npc_tallhorn_stagAI(Creature* creature) : ScriptedAI(creature) {}

        uint8 m_uiPhase;

        void Reset()
        {
            m_uiPhase = 1;
        }

        void UpdateAI(const uint32 /*uiDiff*/)
        {
            if (m_uiPhase == 1)
            {
                if (me->FindNearestGameObject(OBJECT_HAUNCH, 2.0f))
                {
                    me->SetStandState(UNIT_STAND_STATE_DEAD);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                    me->SetUInt32Value(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
                }
                m_uiPhase = 0;
            }
            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_tallhorn_stagAI(creature);
    }
};

// Amberpine Woodsman

enum eamberpinewoodsman
{
    TALLHORN_STAG                   = 26363
};

class npc_amberpine_woodsman : public CreatureScript
{
public:
    npc_amberpine_woodsman() : CreatureScript("npc_amberpine_woodsman") { }

    struct npc_amberpine_woodsmanAI : public ScriptedAI
    {
        npc_amberpine_woodsmanAI(Creature* creature) : ScriptedAI(creature) {}

        uint8 m_uiPhase;
        uint32 m_uiTimer;

        void Reset()
        {
            m_uiTimer = 0;
            m_uiPhase = 1;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            // call this each update tick?
            if (me->FindNearestCreature(TALLHORN_STAG, 0.2f))
            {
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_USE_STANDING);
            }
            else
                if (m_uiPhase)
                {
                    if (m_uiTimer <= uiDiff)
                    {
                        switch (m_uiPhase)
                        {
                            case 1:
                                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_LOOT);
                                m_uiTimer = 3000;
                                m_uiPhase = 2;
                                break;
                            case 2:
                                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_ATTACK1H);
                                m_uiTimer = 4000;
                                m_uiPhase = 1;
                                break;
                        }
                    }
                    else
                    m_uiTimer -= uiDiff;
                }
                ScriptedAI::UpdateAI(uiDiff);

            UpdateVictim();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_amberpine_woodsmanAI(creature);
    }
};
/*######
## Quest 12288: Overwhelmed!
######*/

enum eSkirmisher
{
    SPELL_RENEW_SKIRMISHER  = 48812,
    CREDIT_NPC              = 27466,

    RANDOM_SAY_1             =  -1800044,        //Ahh..better..
    RANDOM_SAY_2             =  -1800045,        //Whoa.. i nearly died there. Thank you, $Race!
    RANDOM_SAY_3             =  -1800046         //Thank you. $Class!
};

class npc_wounded_skirmisher : public CreatureScript
{
public:
    npc_wounded_skirmisher() : CreatureScript("npc_wounded_skirmisher") { }

    struct npc_wounded_skirmisherAI : public ScriptedAI
    {
        npc_wounded_skirmisherAI(Creature* creature) : ScriptedAI(creature) {}

        uint64 uiPlayerGUID;

        uint32 DespawnTimer;

        void Reset()
        {
            DespawnTimer = 5000;
            uiPlayerGUID = 0;
        }

        void MovementInform(uint32, uint32 id)
        {
            if (id == 1)
                me->DespawnOrUnsummon(DespawnTimer);
        }

        void SpellHit(Unit* caster, const SpellInfo* spell)
        {
            if (spell->Id == SPELL_RENEW_SKIRMISHER && caster->GetTypeId() == TYPEID_PLAYER
                && caster->ToPlayer()->GetQuestStatus(12288) == QUEST_STATUS_INCOMPLETE)
            {
                caster->ToPlayer()->KilledMonsterCredit(CREDIT_NPC, 0);
                DoScriptText(RAND(RANDOM_SAY_1, RANDOM_SAY_2, RANDOM_SAY_3), caster);
                if (me->IsStandState())
                    me->GetMotionMaster()->MovePoint(1, me->GetPositionX()+7, me->GetPositionY()+7, me->GetPositionZ());
                else
                {
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    me->DespawnOrUnsummon(DespawnTimer);
                }
            }
        }

        void UpdateAI(const uint32 /*diff*/)
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_wounded_skirmisherAI(creature);
    }
};

/*Lightning Sentry - if you kill it when you have your Minion with you, you will get a quest credit*/
enum eSentry
{
    QUEST_OR_MAYBE_WE_DONT_A                     = 12138,
    QUEST_OR_MAYBE_WE_DONT_H                     = 12198,

    NPC_LIGHTNING_SENTRY                         = 26407,
    NPC_WAR_GOLEM                                = 27017,

    SPELL_CHARGED_SENTRY_TOTEM                   = 52703,
};

class npc_lightning_sentry : public CreatureScript
{
public:
    npc_lightning_sentry() : CreatureScript("npc_lightning_sentry") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_lightning_sentryAI(creature);
    }

    struct npc_lightning_sentryAI : public ScriptedAI
    {
        npc_lightning_sentryAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 uiChargedSentryTotem;

        void Reset()
        {
            uiChargedSentryTotem = urand(10000, 12000);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (uiChargedSentryTotem <= uiDiff)
            {
                DoCast(SPELL_CHARGED_SENTRY_TOTEM);
                uiChargedSentryTotem = urand(10000, 12000);
            }
            else
                uiChargedSentryTotem -= uiDiff;

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* killer)
        {
            if (killer->ToPlayer() && killer->ToPlayer()->GetTypeId() == TYPEID_PLAYER)
            {
                if (me->FindNearestCreature(NPC_WAR_GOLEM, 10.0f, true))
                {
                    if (killer->ToPlayer()->GetQuestStatus(QUEST_OR_MAYBE_WE_DONT_A) == QUEST_STATUS_INCOMPLETE ||
                        killer->ToPlayer()->GetQuestStatus(QUEST_OR_MAYBE_WE_DONT_H) == QUEST_STATUS_INCOMPLETE)
                        killer->ToPlayer()->KilledMonsterCredit(NPC_WAR_GOLEM, 0);
                }
            }
        }
    };
};

/*Venture co. Straggler - when you cast Smoke Bomb, he will yell and run away*/
enum eSmokeEmOut
{
    SAY_SEO1                                     = -1603535,
    SAY_SEO2                                     = -1603536,
    SAY_SEO3                                     = -1603537,
    SAY_SEO4                                     = -1603538,
    SAY_SEO5                                     = -1603539,
    QUEST_SMOKE_EM_OUT_A                         = 12323,
    QUEST_SMOKE_EM_OUT_H                         = 12324,
    SPELL_SMOKE_BOMB                             = 49075,
    SPELL_CHOP                                   = 43410,
    NPC_VENTURE_CO_STABLES_KC                    = 27568,
};

class npc_venture_co_straggler : public CreatureScript
{
public:
    npc_venture_co_straggler() : CreatureScript("npc_venture_co_straggler") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_venture_co_stragglerAI(creature);
    }

    struct npc_venture_co_stragglerAI : public ScriptedAI
    {
        npc_venture_co_stragglerAI(Creature* creature) : ScriptedAI(creature) { }

        uint64 uiPlayerGUID;
        uint32 uiRunAwayTimer;
        uint32 uiTimer;
        uint32 uiChopTimer;

        void Reset()
        {
            uiPlayerGUID = 0;
            uiTimer = 0;
            uiChopTimer = urand(10000, 12500);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC);
            me->SetReactState(REACT_AGGRESSIVE);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (uiRunAwayTimer <= uiDiff)
            {
                if (Player* player = Unit::GetPlayer(*me, uiPlayerGUID))
                {
                    switch (uiTimer)
                    {
                        case 0:
                            if (player->GetQuestStatus(QUEST_SMOKE_EM_OUT_A) == QUEST_STATUS_INCOMPLETE ||
                                player->GetQuestStatus(QUEST_SMOKE_EM_OUT_H) == QUEST_STATUS_INCOMPLETE)
                                player->KilledMonsterCredit(NPC_VENTURE_CO_STABLES_KC, 0);
                            me->GetMotionMaster()->MovePoint(0, me->GetPositionX()-7, me->GetPositionY()+7, me->GetPositionZ());
                            uiRunAwayTimer = 2500;
                            ++uiTimer;
                            break;
                        case 1:
                            DoScriptText(RAND(SAY_SEO1, SAY_SEO2, SAY_SEO3, SAY_SEO4, SAY_SEO5), me);
                            me->GetMotionMaster()->MovePoint(0, me->GetPositionX()-7, me->GetPositionY()-5, me->GetPositionZ());
                            uiRunAwayTimer = 2500;
                            ++uiTimer;
                            break;
                        case 2:
                            me->GetMotionMaster()->MovePoint(0, me->GetPositionX()-5, me->GetPositionY()-5, me->GetPositionZ());
                            uiRunAwayTimer = 2500;
                            ++uiTimer;
                            break;
                        case 3:
                            me->DisappearAndDie();
                            uiTimer = 0;
                            break;
                    }
                }
            }
            else
                uiRunAwayTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            if (uiChopTimer <= uiDiff)
            {
                DoCast(me->getVictim(), SPELL_CHOP);
                uiChopTimer = urand(10000, 12000);
            }
            else
                uiChopTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }

        void SpellHit(Unit* pCaster, const SpellInfo* pSpell)
        {
            if (pCaster && pCaster->GetTypeId() == TYPEID_PLAYER && pSpell->Id == SPELL_SMOKE_BOMB)
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC);
                me->SetReactState(REACT_PASSIVE);
                me->CombatStop(false);
                uiPlayerGUID = pCaster->GetGUID();
                uiRunAwayTimer = 3500;
            }
        }
    };
};

#define GOSSIP_ITEM1 "You're free to go Orsonn, but first tell me what's wrong with the furbolg."
#define GOSSIP_ITEM2 "What happened then?"	
#define GOSSIP_ITEM3 "Thank you, Son of Ursoc. I'll see what can be done."
#define GOSSIP_ITEM4 "Who was this stranger?"
#define GOSSIP_ITEM5 "Thank you, Kodian. I'll do what I can."

enum eEnums	
{
    GOSSIP_TEXTID_ORSONN1       = 12793,
    GOSSIP_TEXTID_ORSONN2       = 12794,
    GOSSIP_TEXTID_ORSONN3       = 12796,	

    GOSSIP_TEXTID_KODIAN1       = 12797,	
    GOSSIP_TEXTID_KODIAN2       = 12798,	

    NPC_ORSONN                  = 27274,	
    NPC_KODIAN                  = 27275,

    NPC_ORSONN_CREDIT           = 27322,	
    NPC_KODIAN_CREDIT           = 27321,

    QUEST_CHILDREN_OF_URSOC     = 12247,	
    QUEST_THE_BEAR_GODS_OFFSPRING        = 12231	
};	

class npc_orsonn_and_kodian : public CreatureScript	
{
public:	
    npc_orsonn_and_kodian() : CreatureScript("npc_orsonn_and_kodian") { }
	
    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());	
	
        if (player->GetQuestStatus(QUEST_CHILDREN_OF_URSOC) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(QUEST_THE_BEAR_GODS_OFFSPRING) == QUEST_STATUS_INCOMPLETE)
        {
            switch(creature->GetEntry())
            {
                case NPC_ORSONN:
                    if (!player->GetReqKillOrCastCurrentCount(QUEST_CHILDREN_OF_URSOC, NPC_ORSONN_CREDIT) || !player->GetReqKillOrCastCurrentCount(QUEST_THE_BEAR_GODS_OFFSPRING, NPC_ORSONN_CREDIT))
                    {
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
                        player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ORSONN1, creature->GetGUID());	
                        return true;
                    }	
                    break;	
                case NPC_KODIAN:	
                    if (!player->GetReqKillOrCastCurrentCount(QUEST_CHILDREN_OF_URSOC, NPC_KODIAN_CREDIT) || !player->GetReqKillOrCastCurrentCount(QUEST_THE_BEAR_GODS_OFFSPRING, NPC_KODIAN_CREDIT))
                    {
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
                        player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_KODIAN1, creature->GetGUID());
                        return true;	
                    }	
                    break;	
            }
        }	
	
        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());	
        return true;	
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)	
    {	
        player->PlayerTalkClass->ClearMenus();	
        switch(uiAction)
        {	
            case GOSSIP_ACTION_INFO_DEF+1:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);	
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ORSONN2, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:	
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ORSONN3, creature->GetGUID());	
                break;	
            case GOSSIP_ACTION_INFO_DEF+3:	
                player->CLOSE_GOSSIP_MENU();
                player->TalkedToCreature(NPC_ORSONN_CREDIT, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+4:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_KODIAN2, creature->GetGUID());	
                break;	
            case GOSSIP_ACTION_INFO_DEF+5:
                player->CLOSE_GOSSIP_MENU();	
                player->TalkedToCreature(NPC_KODIAN_CREDIT, creature->GetGUID());
                break;
        }	

        return true;	
    }
};	


/*####
## npc_grennix_shivwiggle
####*/
#define		QUEST_BW  12427
#define		QUEST_MFF  12428
#define		QUEST_BAM  12429
#define		QUEST_DIL  12430
#define		QUEST_FS  12431
#define		NPC_IRONHIDE  27715
#define		NPC_TORGG	 27716
#define		NPC_RUSTBLOOD	 27717
#define		NPC_HELLCLEAVE	 27718
#define	    NPC_KRENNA	 27727

class npc_grennix_shivwiggle : public CreatureScript
{
    public: 
	npc_grennix_shivwiggle() : CreatureScript("npc_grennix_shivwiggle") { }

	struct npc_grennix_shivwiggleAI : public ScriptedAI
	{
		npc_grennix_shivwiggleAI(Creature* creature) : ScriptedAI(creature) {}

		uint64 SummonGUID;
		uint64 uiPlayerGUID;

		uint32 uiTimer;
		uint32 uiPhase;
		uint32 uiRemoveFlagTimer;
        uint32 uiQuest;

        bool bRemoveFlag;

        void Reset()
        {
            SummonGUID = 0;
            uiPlayerGUID = 0;

            me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
            uiTimer = 0;
            uiPhase = 0;
            uiQuest = 0;
            uiRemoveFlagTimer = 5000;

            bRemoveFlag = false;
        }

		void SetGUID(uint64 guid, int32 /*id*/)
        {
            uiPlayerGUID = guid;
        }

		void SetData(uint32 uiId, uint32 uiValue)
        {
            bRemoveFlag = true;
            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);

            switch (uiId)
            {
                case 1:
                    switch (uiValue)
                    {
					   case QUEST_BW:
						   uiPhase = 1;
						   uiTimer = 4000;
						   break;
					   case QUEST_MFF:
						   uiPhase = 2;
						   uiTimer = 4000;
						   break;
					   case QUEST_BAM:
						   uiPhase = 3;
						   uiTimer = 4000;
						   break;
					   case QUEST_DIL:
						   uiPhase = 4;
						   uiTimer = 4000;
						   break;
					}
					break;
			}
		}

		void UpdateAI(const uint32 uiDiff)
		{
			ScriptedAI::UpdateAI(uiDiff);

			if (bRemoveFlag)
            {
                if (uiRemoveFlagTimer <= uiDiff)
                {
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                    bRemoveFlag = false;

                    uiRemoveFlagTimer = 10000;
                } else uiRemoveFlagTimer -= uiDiff;
            }

			if(uiPhase)
			{
				Player* player = me->GetPlayer(*me, uiPlayerGUID);

                if (uiTimer <= uiDiff)
				{
					switch(uiPhase)
					{
					   case 1:
						//   if(Creature* crt = me->SummonCreature(NPC_IRONHIDE, 3271.17f, -2283.29f, 108.50f, 0, TEMPSUMMON_CORPSE_DESPAWN, 1000))
						//   SummonGUID = crt->GetGUID();
						   uiPhase = 0;
						   uiTimer = 4000;
						   break;
					   case 2:
						//   if(Creature* crt = me->SummonCreature(NPC_TORGG, 3271.17f, -2283.29f, 108.50f, 0, TEMPSUMMON_CORPSE_DESPAWN, 1000))
						//   SummonGUID = crt->GetGUID();
						   uiPhase = 0;
						   uiTimer = 4000;
						   break;
					   case 3:
						//   if(Creature* crt = me->SummonCreature(NPC_RUSTBLOOD, 3271.17f, -2283.29f, 108.50f, 0, TEMPSUMMON_CORPSE_DESPAWN, 1000))
						//   SummonGUID = crt->GetGUID();
						   uiPhase = 0;
						   uiTimer = 4000;
						   break;
					   case 4:
						//   if(Creature* crt = me->SummonCreature(NPC_HELLCLEAVE, 3271.17f, -2283.29f, 108.50f, 0, TEMPSUMMON_CORPSE_DESPAWN, 1000))
						 //  SummonGUID = crt->GetGUID();
						   uiPhase = 0;
						   uiTimer = 4000;
						   break;
					   case 5:
						//   if(Creature* crt = me->SummonCreature(NPC_KRENNA, 3271.17f, -2283.29f, 108.50f, 0, TEMPSUMMON_CORPSE_DESPAWN, 1000))
						 //  SummonGUID = crt->GetGUID();
						   uiPhase = 0;
						   uiTimer = 4000;
						   break;
					}
				}
				else uiTimer -= uiDiff;
			}
		}
	};

	bool OnQuestAccept(Player *player, Creature *creature, Quest const* quest)
	{
		switch(quest->GetQuestId())
		{
		    case QUEST_BW:
				creature->AI()->SetData(1, quest->GetQuestId());
				break;
			case QUEST_MFF:
				creature->AI()->SetData(1, quest->GetQuestId());
				break;
			case QUEST_BAM:
				creature->AI()->SetData(1, quest->GetQuestId());
				break;
			case QUEST_DIL:
				creature->AI()->SetData(1, quest->GetQuestId());
				break;
		}
		creature->AI()->SetGUID(player->GetGUID());

        return false;
	}

	CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_grennix_shivwiggleAI(creature);
    }
};
/*####
## npc_ironhide
####*/
#define SPELL_CHARGE 32323
#define SPELL_MAUL 34298
#define SPELL_SWIPE 31279

class npc_ironhide : public CreatureScript
{
    public:
	npc_ironhide() : CreatureScript("npc_ironhide") {}

	struct npc_ironhideAI : public ScriptedAI
	{
		npc_ironhideAI(Creature* creature) : ScriptedAI(creature) {}

		uint32 uiMaulTimer;
		uint32 uiSwipeTimer;

		void Reset()
		{
			uiMaulTimer = 7000;
			uiSwipeTimer = 7000;
		}

		void EnterCombat(Unit* pWho)
        {
            DoCast(pWho, SPELL_CHARGE);
        }

		void UpdateAI(const uint32 uiDiff)
		{
			if(!UpdateVictim())
				return;

			if(uiMaulTimer <= uiDiff)
			{
				DoCast(me->getVictim(), SPELL_MAUL);
			}
			else uiMaulTimer -= uiDiff;

			if(uiSwipeTimer <= uiDiff)
			{
				DoCast(me->getVictim(), SPELL_SWIPE);
			}
			else uiSwipeTimer -= uiDiff;

			DoMeleeAttackIfReady();
		}

		void JustDied(Unit* killer)
		{
			if (Player* player = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
                player->GetCharmerOrOwnerPlayerOrPlayerItself()->GroupEventHappens(QUEST_BW, killer);
		}
	};

	CreatureAI* GetAI(Creature *creature) const
    {
        return new npc_ironhideAI(creature);
    }
};

/*####
## npc_torgg_thundertotem
####*/
#define SPELL_CHAIN_LIGHT 16033
#define SPELL_NOVA_TOTEM 31991
#define SPELL_EARTH_SHOCK 15501
#define SPELL_HEALING_WAVE 15982

class npc_torgg_thundertotem : public CreatureScript
{
public:
	npc_torgg_thundertotem() : CreatureScript("npc_torgg_thundertotem") {}

	struct npc_torgg_thundertotemAI : public ScriptedAI
	{
		npc_torgg_thundertotemAI(Creature* creature) : ScriptedAI(creature)
		{

		}

		uint32 uiChainTimer;
		uint32 uiNovaTimer;
		uint32 uiEarthTimer;
		uint32 uiHWTimer;

		void Reset()
		{
			uiChainTimer = 5000;
			uiNovaTimer = 20000;
			uiEarthTimer = 7000;
			uiHWTimer = 5000;
		}

		void EnterCombat(Unit* pWho)
		{
			DoCast(pWho, SPELL_NOVA_TOTEM);
		}

		void UpdateAI(const uint32 diff)
		{
			if(!UpdateVictim())
			return;

			if(uiChainTimer <= diff)
			{
				DoCast(me->getVictim(), SPELL_CHAIN_LIGHT);
			}
			else uiChainTimer -= diff;

			if(uiEarthTimer <= diff)
			{
				DoCast(me->getVictim(), SPELL_EARTH_SHOCK);
			}
			else uiEarthTimer -= diff;

			if(uiNovaTimer <= diff)
			{
				DoCast(me->getVictim(), SPELL_NOVA_TOTEM);
			}
			else uiNovaTimer -= diff;

			if(HealthBelowPct(15) && uiHWTimer <= diff)
			{
				DoCast(me, SPELL_HEALING_WAVE);
			}
			else uiHWTimer -= diff;
		    DoMeleeAttackIfReady();
		}

		void JustDied(Unit* killer)
        {
		   if (Player* player = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
                player->GetCharmerOrOwnerPlayerOrPlayerItself()->GroupEventHappens(12428, killer);
		}
	};

	CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_torgg_thundertotemAI(creature);
    }
};

/*####
## npc_rustblood
####*/
#define SPELL_CLEAVE 42746
#define SPELL_HEAD_SMASH 14102
#define SPELL_KNOCKBACK	49398
#define SPELL_LIGHT_BOLT 61893

class npc_rustblood : public CreatureScript
{
    public:
	npc_rustblood() : CreatureScript("npc_rustblood") {}

	struct npc_rustbloodAI : public ScriptedAI
	{
		npc_rustbloodAI(Creature* creature) : ScriptedAI(creature) { }

		uint32 CleaveTimer;
		uint32 HSTimer;
		uint32 KnockTimer;
		uint32 LBTimer;

		void Reset()
		{
		  CleaveTimer = 10000;
		  HSTimer = 5000;
		  KnockTimer = 4000;
		  LBTimer = 7000;
		}

		void UpdateAI(const uint32 diff)
		{
			if(!UpdateVictim())
			return;

			if(CleaveTimer <= diff)
			{
				DoCast(me->getVictim(), SPELL_CLEAVE);
			}
			else CleaveTimer -= diff;
			if(HSTimer <= diff)
			{
				DoCast(me->getVictim(), SPELL_HEAD_SMASH);
			}
			else HSTimer -= diff;

			if(KnockTimer <= diff)
			{
				DoCast(me->getVictim(), SPELL_KNOCKBACK);
			}
			else KnockTimer -= diff;

			if(LBTimer <= diff)
			{
				DoCast(me->getVictim(), SPELL_LIGHT_BOLT);
			}
			else LBTimer -= diff;

		   DoMeleeAttackIfReady();
		}

		void JustDied(Unit* killer)
        {
		   if (Player* player = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
                player->GetCharmerOrOwnerPlayerOrPlayerItself()->GroupEventHappens(12429, killer);
		}
	};

	CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_rustbloodAI(creature);
    }
};

/*####
## npc_horgrenn_hellcleave
####*/
#define SPELL_BRUTSTR 58460
#define SPELL_INTERCEPT 58747
#define SPELL_INT_ROAR 16508
#define SPELL_SUNDER_ARMOR 15572
#define SPELL_WHIRLWIND1 38619
#define SPELL_WHIRLWIND2 38618

class npc_horgrenn_hellcleave : public CreatureScript 
{ 
    public:
    npc_horgrenn_hellcleave () : CreatureScript("boss_horgrenn_hellcleave") {}

    struct npc_horgrenn_hellcleaveAI : public ScriptedAI 
    { 
       npc_horgrenn_hellcleaveAI(Creature* creature) : ScriptedAI(creature) {} 
  
	   uint32 bsTimer;
	   uint32 interTimer;
	   uint32 roarTimer;
	   uint32 armTimer;
	   uint32 ww1Timer;
	   uint32 ww2Timer;

       void Reset() 
       { 
		   bsTimer = 8000;
	       interTimer = 3000;
	       roarTimer = 4000;
	       armTimer = 12000;
	       ww1Timer = 6000;
	       ww2Timer = 4000;
       } 
       void EnterCombat(Unit* who) 
       { 
		   DoCast(who, SPELL_INTERCEPT);
       } 

       void UpdateAI(const uint32 diff) 
       { 
		   if(!UpdateVictim())
			   return;

		   if(bsTimer <= diff)
		   {
			   DoCast(me->getVictim(), SPELL_BRUTSTR);
		   }
		   else bsTimer -= diff;

		   if(interTimer <= diff)
		   {
			   DoCast(me->getVictim(), SPELL_INTERCEPT);
		   }
		   else interTimer -= diff;

		   if(roarTimer <= diff)
		   {
			   DoCast(me->getVictim(), SPELL_INT_ROAR);
		   }
		   else roarTimer -= diff;

		   if(armTimer <= diff)
		   {
			   DoCast(me->getVictim(), SPELL_SUNDER_ARMOR);
		   }
		   else armTimer -= diff;

		   if(ww1Timer <= diff)
		   {
			   DoCast(me->getVictim(), SPELL_WHIRLWIND1);
		   }
		   else ww1Timer -= diff;

		   if(HealthBelowPct(10) && ww2Timer <= diff)
		   {
			   DoCast(me->getVictim(), SPELL_WHIRLWIND2);
		   }
		   else ww2Timer -= diff;

           DoMeleeAttackIfReady(); 
        } 

	   void JustDied(Unit* killer)
        {
			if(killer->GetTypeId() == TYPEID_PLAYER)
				killer->GetCharmerOrOwnerPlayerOrPlayerItself()->GroupEventHappens(12430, killer);
		  /* if (Player* player = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
               player->GetCharmerOrOwnerPlayerOrPlayerItself()->GroupEventHappens(12430, killer);*/
		}
     };

	 CreatureAI* GetAI(Creature* creature) const 
     { 
        return new npc_horgrenn_hellcleaveAI(creature); 
     } 
}; 

/*####
## npc_horgrenn_hellcleave
####*/
#define SPELL_CLV 15284
#define SPELL_FIXATE 34179
#define SPELL_PUMMEL 12555
#define SPELL_SLAM 11430
class npc_conqueror_krenna: public CreatureScript 
{ 
     public:
     npc_conqueror_krenna () : CreatureScript("npc_conqueror_krenna") {} 
 
     CreatureAI* GetAI(Creature* creature) const 
     { 
        return new npc_conqueror_krennaAI (creature); 
     } 
 
    struct npc_conqueror_krennaAI : public ScriptedAI 
    { 
       npc_conqueror_krennaAI(Creature* creature) : ScriptedAI(creature) {} 
  
	   uint32 clTimer;
	   uint32 fxTimer;
	   uint32 pmTimer;
	   uint32 slTimer;
         void Reset() 
         { 
			 clTimer = 10000;
			 fxTimer = 3000;
			 pmTimer = 5000;
			 slTimer = 5000;
         } 

         void UpdateAI(const uint32 diff) 
         { 
			 if(!UpdateVictim())
			   return;

		   if(clTimer <= diff)
		   {
			   DoCast(me->getVictim(), SPELL_CLV);
		   }
		   else clTimer -= diff;

		   if(fxTimer <= diff)
		   {
			   DoCast(me->getVictim(), SPELL_FIXATE);
		   }
		   else fxTimer -= diff;

		   if(pmTimer <= diff)
		   {
			   DoCast(me->getVictim(), SPELL_PUMMEL);
		   }
		   else pmTimer -= diff;

		   if(slTimer <= diff)
		   {
			   DoCast(me->getVictim(), SPELL_SLAM);
		   }
		   else slTimer -= diff;

           DoMeleeAttackIfReady(); 
         } 

		 void JustDied(Unit* killer)
         {
			 if (Player* player = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
                player->GetCharmerOrOwnerPlayerOrPlayerItself()->GroupEventHappens(12431, killer);
		 }
     };
};


void AddSC_grizzly_hills()
{
    new npc_emily();
    new npc_mrfloppy();
    new npc_outhouse_bunny();
    new npc_tallhorn_stag();
    new npc_amberpine_woodsman();
    new npc_wounded_skirmisher();
    new npc_lightning_sentry();
    new npc_venture_co_straggler();
    new npc_orsonn_and_kodian;
	new npc_grennix_shivwiggle();
	new npc_ironhide();
	new npc_torgg_thundertotem();
	new npc_rustblood();
	new npc_horgrenn_hellcleave();
	new npc_conqueror_krenna();
}
