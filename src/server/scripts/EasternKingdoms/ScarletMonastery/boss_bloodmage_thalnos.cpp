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
SDName: Boss_Bloodmage_Thalnos
SD%Complete: 100
SDComment:
SDCategory: Scarlet Monastery
EndScriptData */

#include "ScriptPCH.h"

enum eEnums
{
    SAY_AGGRO               = -1189016,
    SAY_HEALTH              = -1189017,
    SAY_KILL                = -1189018,

    SPELL_FLAMESHOCK        = 8053,
    SPELL_SHADOWBOLT        = 1106,
    SPELL_FLAMESPIKE        = 8814,
    SPELL_FIRENOVA          = 16079,
};

class boss_bloodmage_thalnos : public CreatureScript
{
public:
    boss_bloodmage_thalnos() : CreatureScript("boss_bloodmage_thalnos") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_bloodmage_thalnosAI (creature);
    }

    struct boss_bloodmage_thalnosAI : public ScriptedAI
    {
        boss_bloodmage_thalnosAI(Creature* creature) : ScriptedAI(creature) {}

        bool HpYell;
        uint32 FlameShock_Timer;
        uint32 ShadowBolt_Timer;
        uint32 FlameSpike_Timer;
        uint32 FireNova_Timer;

        void Reset()
        {
            HpYell = false;
            FlameShock_Timer = 10000;
            ShadowBolt_Timer = 2000;
            FlameSpike_Timer = 8000;
            FireNova_Timer = 40000;
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_AGGRO, me);
        }

        void KilledUnit(Unit* /*Victim*/)
        {
            DoScriptText(SAY_KILL, me);
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            //If we are <35% hp
            if (!HpYell && !HealthAbovePct(35))
            {
                DoScriptText(SAY_HEALTH, me);
                HpYell = true;
            }

            //FlameShock_Timer
            if (FlameShock_Timer <= diff)
            {
                DoCast(me->getVictim(), SPELL_FLAMESHOCK);
                FlameShock_Timer = urand(10000, 15000);
            }
            else FlameShock_Timer -= diff;

            //FlameSpike_Timer
            if (FlameSpike_Timer <= diff)
            {
                DoCast(me->getVictim(), SPELL_FLAMESPIKE);
                FlameSpike_Timer = 30000;
            }
            else FlameSpike_Timer -= diff;

            //FireNova_Timer
            if (FireNova_Timer <= diff)
            {
                DoCast(me->getVictim(), SPELL_FIRENOVA);
                FireNova_Timer = 40000;
            }
            else FireNova_Timer -= diff;

            //ShadowBolt_Timer
            if (ShadowBolt_Timer <= diff)
            {
                DoCast(me->getVictim(), SPELL_SHADOWBOLT);
                ShadowBolt_Timer = 2000;
            }
            else ShadowBolt_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_bloodmage_thalnos()
{
    new boss_bloodmage_thalnos();
}
