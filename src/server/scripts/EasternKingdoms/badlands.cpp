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
SDName: Badlands
SD%Complete: 
SDComment: Quest support: 778
SDCategory: Badlands
EndScriptData */

#include "ScriptPCH.h"

/* ContentData
npc_lotwil_veriatus
EndContentData */

enum lotwil
{
	BE_HARD_QUEST = 778,
	NPC_FAMRETOR = 2919
}

//const Position[] = { -6655.4360f, -2693.4123f, 243.3465f, 3.2106f };

class npc_lotwil_veriatus : public CreatureScript
{
public : 
	npc_lotwil_veriatus() : CreatureScript("npc_lotwil_veriatus") { }

	struct npc_lotwil_veriatusAI : public ScriptedAI
    {
        npc_lotwil_veriatusAI(Creature* creature) : ScriptedAI(creature) {}

		uint64 pSummonGuid;
		uint64 pPlayerGuid;

		uint32 uiPhase;
		uint32 uiTimer;

		void Reset()
		{
			pSummonGuid = 0;
			pPlayerGuid = 0;
			uiPhase = 0;
			uiTimer = 0;
		}

		void SetGUID(uint64 guid, int32 /*id*/)
        {
            pPlayerGuid = guid;
        }

		void SetData(uint32 uiId, uint32 uiValue)
        {
			switch(uiId)
			{
			   case 1:
				   switch(uiValue)
				   {
				       case BE_HARD_QUEST:
						   uiPhase = 1;
						   uiTimer = 2000;
						   break;
				   }
				   break;
			}
		}

		void UpdateAI(const uint32 uiDiff)
        {
            ScriptedAI::UpdateAI(uiDiff);

			if(uiPhase)
			{
				Player* player = me->GetPlayer(*me, pPlayerGuid);

				if(uiTimer <= diff)
				{
					switch(uiPhase)
					{
					   case 1:
						   if(Creature* sum = me->SummonCreature(NPC_FAMRETOR, -6655.4360f, -2693.4123f, 243.3465f, TEMPSUMMON_DESPAWN_CORPSE, 1000))
							   pSummonGuid = sum->GetGUID();
						   uiPhase = 2;
						   uiTimer = 2000;
						   break;
					   case 2:
						   uiPhase = 0;
						   pSummonGuid = 0;
						   break;
					}
				}
				else uiTimer -= diff;
			}
		}
	};

	bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
      switch (quest->GetQuestId())
      {
		 case BE_HARD_QUEST:
         creature->AI()->SetData(1, quest->GetQuestId());
         break;
	  }
	  creature->AI()->SetGUID(player->GetGUID());
      return false;
	 }

	CreatureAI* GetAI(Creature* creature) const
    {
      return new npc_lotwil_veriatusAI(creature);
    }
};


/*####
## npc_farmetor_guardian
####*/

class npc_farmetor_guardian : public CreatureScript
{
public:
    npc_farmetor_guardian() : CreatureScript("npc_orinoko_tuskbreaker") { }

    struct npc_farmetor_guardianAI : public ScriptedAI
    {
        npc_farmetor_guardianAI(Creature* creature) : ScriptedAI(creature)
        {

		}

		void Reset()
		{

		}

		void UpdateAI(const uint32 diff)
		{

		}

		void JustDied(Unit* killer)
        {
            if (killer->GetTypeId() == TYPEID_PLAYER && killer->GetQuestStatus(BE_HARD_QUEST) == QUEST_STATUS_INCOMPLETE)
               // killer->GetCharmerOrOwnerPlayerOrPlayerItself()->GroupEventHappens(BE_HARD_QUEST, killer);
			   killer->CompleteQuest(BE_HARD_QUEST);
        }
	};

	CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_farmetor_guardianAI(creature);
    }
};

void AddSC_badlands()
{
	new npc_farmetor_guardian();
	new npc_lotwil_veriatus();
}