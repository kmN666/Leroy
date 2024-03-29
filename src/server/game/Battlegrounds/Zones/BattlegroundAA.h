/*
 * Copyright (C) 2012 DeadCore <https://bitbucket.org/selectorcore/deadcore-private>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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
#ifndef __BATTLEGROUNDAA_H
#define __BATTLEGROUNDAA_H

class Battleground;

class BattlegroundAAScore : public BattlegroundScore
{
    public:
        BattlegroundAAScore() {};
        virtual ~BattlegroundAAScore() {};
        //TODO fix me
};

class BattlegroundAA : public Battleground
{
    public:
        BattlegroundAA();
        ~BattlegroundAA();

        /* inherited from BattlegroundClass */
        virtual void AddPlayer(Player* player);
        virtual void StartingEventCloseDoors();
        virtual void StartingEventOpenDoors();

        void RemovePlayer(Player* player, uint64 guid, uint32 team);
        void HandleAreaTrigger(Player* Source, uint32 Trigger);
        bool SetupBattleground();
        void HandleKillPlayer(Player* player, Player* killer);
};
#endif
