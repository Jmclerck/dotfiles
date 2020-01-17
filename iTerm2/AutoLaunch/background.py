#!/usr/bin/env python3

import iterm2
import random
from pathlib import Path

home = Path.home()

async def SetPresetInSession(session):
    profile = await session.async_get_profile()

    if not profile:
        return

    path = f'{home}/Documents/GitHub/dotfiles/oh-my-zsh/themes/webicons/backdrop-{random.randrange(1, 4)}.png'
    
    await profile.async_set_background_image_location(path)

async def main(connection):
    app = await iterm2.async_get_app(connection)

    async with iterm2.NewSessionMonitor(connection) as mon:
        while True:
            session_id = await mon.async_get()
            session = app.get_session_by_id(session_id)

            if session:
                await SetPresetInSession(session)

iterm2.run_forever(main)

