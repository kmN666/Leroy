/*
 * Copyright (C) 2012 DeadCore <https://bitbucket.org/jacobcore/deadcore>
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

#ifndef _AUTHSOCKET_H
#define _AUTHSOCKET_H

#include "Common.h"
#include "BigNumber.h"
#include "RealmSocket.h"

// Handle login commands
class AuthSocket: public RealmSocket::Session
{
public:
    const static int s_BYTE_SIZE = 32;

    AuthSocket(RealmSocket& socket);
    virtual ~AuthSocket(void);

    virtual void OnRead(void);
    virtual void OnAccept(void);
    virtual void OnClose(void);

    bool _HandleLogonChallenge();
    bool _HandleLogonProof();
    bool _HandleReconnectChallenge();
    bool _HandleReconnectProof();
    bool _HandleRealmList();

    //data transfer handle for patch
    bool _HandleXferResume();
    bool _HandleXferCancel();
    bool _HandleXferAccept();

    void _SetVSFields(const std::string& rI);

    FILE* pPatch;
    ACE_Thread_Mutex patcherLock;

private:
    RealmSocket& socket_;
    RealmSocket& socket(void) { return socket_; }

    BigNumber N, s, g, v;
    BigNumber b, B;
    BigNumber K;
    BigNumber _reconnectProof;

    bool _authed;

    std::string _login;

    // Since GetLocaleByName() is _NOT_ bijective, we have to store the locale as a string. Otherwise we can't differ
    // between enUS and enGB, which is important for the patch system
    std::string _localizationName;
    std::string _os;
    uint16 _build;
    uint8 _expversion;
    AccountTypes _accountSecurityLevel;
};

#endif
