#!/usr/bin/env bash

set -euo pipefail

BUSYBOX_ACCOUNT=0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
LUA_ACCOUNT=0x90F79bf6EB2c4f870365E785982E1f101E93b906
SQLITE_ACCOUNT=0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65
RICH_SPONSOR_ACCOUNT=0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc
HACKER_ACCOUNT=0x976EA74026E726554dB657fA54763abd0C3a0aa9

LUA_LOGO="https://upload.wikimedia.org/wikipedia/commons/c/cf/Lua-Logo.svg"
LUA_BOUNTY_DESC=$(cat <<-END
Find bugs in Lua, a powerful, efficient, lightweight, embeddable scripting language!

Submitted Lua code will run inside a sanboxed Lua environment, to win the bounty the code must crash its interpreter or escape the sandbox and exit with segmentation fault status (code 139).

The source code of the bounty can be inspected at:
https://github.com/crypto-bug-hunters/bug-buster/tree/main/tests/bounties/lua-bounty
END
)

SQLITE_LOGO="https://www.svgrepo.com/show/374094/sqlite.svg"
SQLITE_BOUNTY_DESC=$(cat <<-END
Find bugs in SQLite, the most used database engine in the world!

Submitted SQL code will run inside a SQLite safe shell open on an empty database, to win the bounty the SQL code must crash the SQLite shell.

The source code of the bounty can be inspected at:
https://github.com/crypto-bug-hunters/bug-buster/tree/main/tests/bounties/sqlite-bounty
END
)

BUSYBOX_LOGO="https://uawartifacts.blob.core.windows.net/upload-files/Busy_Box_c74c024d34.svg"
BUSYBOX_BOUNTY_DESC=$(cat <<-END
Find bugs in BusyBox, a software suite that provides several Unix utilities!

Did you know it is one of the most downloaded software in Docker Hub, with more than one billion downloads?

Submitted shell code will run inside a BusyBox with only ash utility enabled, to win this bounty the shell code must crash it.

The source code of the bounty can be inspected at:
https://github.com/crypto-bug-hunters/bug-buster/tree/main/tests/bounties/busybox-bounty
END
)

# send DApp address so we can generate vouchers later
go run ./cli send dapp-address

# Busybox 1.36.1
CURR_BOUNTY=$(go run ./cli state | jq '.bounties | length')
go run ./cli send bounty \
    -f $BUSYBOX_ACCOUNT \
    -n "BusyBox 1.36.1" \
    -i "$BUSYBOX_LOGO" \
    -d "$BUSYBOX_BOUNTY_DESC" \
    --duration $((14*86400)) \
    -c "./tests/bounties/busybox-bounty/busybox-1.36.1-bounty_riscv64.tar.xz"

go run ./cli send sponsor \
    -f $BUSYBOX_ACCOUNT \
    -b $CURR_BOUNTY \
    -n "BusyBox Sponsor" \
    -v 0.99

go run ./cli send sponsor \
    -f $RICH_SPONSOR_ACCOUNT \
    -b $CURR_BOUNTY \
    -n "Rich Crypto Person" \
    -v 1.337

go run ./cli send exploit \
    -f $HACKER_ACCOUNT \
    -b $CURR_BOUNTY \
    -n "Hacker" \
    -e "./tests/bounties/busybox-bounty/exploit-busybox-1.36.1.sh"

# Lua 5.4.3
CURR_BOUNTY=$(go run ./cli state | jq '.bounties | length')
go run ./cli send bounty \
    -f $LUA_ACCOUNT \
    -n "Lua 5.4.3" \
    -i "$LUA_LOGO" \
    -d "$LUA_BOUNTY_DESC" \
    --duration $((30*86400)) \
    -c "./tests/bounties/lua-bounty/lua-5.4.3-bounty_riscv64.tar.xz"

go run ./cli send sponsor \
    -f $LUA_ACCOUNT \
    -b $CURR_BOUNTY \
    -n "Lua Sponsor" \
    -v 0.05

go run ./cli send sponsor \
    -f $RICH_SPONSOR_ACCOUNT \
    -b $CURR_BOUNTY \
    -n "Rich Crypto Person" \
    -v 1.337

# go run ./cli send exploit \
#     -f $HACKER_ACCOUNT \
#     -b $CURR_BOUNTY \
#     -n "The Hacker" \
#     -e "./tests/bounties/lua-bounty/exploit-lua-5.4.3.lua"

# Lua 5.4.6
CURR_BOUNTY=$(go run ./cli state | jq '.bounties | length')
go run ./cli send bounty \
    -f $LUA_ACCOUNT \
    -n "Lua 5.4.6" \
    -i "$LUA_LOGO" \
    -d "$LUA_BOUNTY_DESC" \
    --duration $((60*86400)) \
    -c "./tests/bounties/lua-bounty/lua-5.4.6-bounty_riscv64.tar.xz"

go run ./cli send sponsor \
    -f $LUA_ACCOUNT \
    -b $CURR_BOUNTY \
    -n "Lua Sponsor" \
    -v 0.05

go run ./cli send sponsor \
    -f $RICH_SPONSOR_ACCOUNT \
    -b $CURR_BOUNTY \
    -n "Rich Crypto Person" \
    -v 1.337

# SQLite 3.32.2
CURR_BOUNTY=$(go run ./cli state | jq '.bounties | length')
go run ./cli send bounty \
    -f $SQLITE_ACCOUNT \
    -n "SQLite 3.32.2" \
    -i "$SQLITE_LOGO" \
    -d "$SQLITE_BOUNTY_DESC" \
    --duration $((50*86400)) \
    -c "./tests/bounties/sqlite-bounty/sqlite-3.32.2-bounty_riscv64.tar.xz"

go run ./cli send sponsor \
    -f $SQLITE_ACCOUNT \
    -b $CURR_BOUNTY \
    -n "SQLite Sponsor" \
    -v 0.32

go run ./cli send sponsor \
    -f $RICH_SPONSOR_ACCOUNT \
    -b $CURR_BOUNTY \
    -n "Rich Crypto Person" \
    -v 1.337

# go run ./cli send exploit \
#     -f $HACKER_ACCOUNT \
#     -b $CURR_BOUNTY \
#     -n "The Hacker" \
#     -e "./tests/bounties/sqlite-bounty/exploit-sqlite-3.32.2.sql"

# SQLite 3.43.2
# CURR_BOUNTY=$(go run ./cli state | jq '.bounties | length')
# go run ./cli send bounty \
#     -f $SQLITE_ACCOUNT \
#     -n "SQLite 3.43.2" \
#     -i "$SQLITE_LOGO" \
#     -d "$SQLITE_BOUNTY_DESC" \
#     --duration $((90*86400)) \
#     -c "./tests/bounties/sqlite-bounty/sqlite-3.43.2-bounty_riscv64.tar.xz"
# 
# go run ./cli send sponsor \
#     -f $SQLITE_ACCOUNT \
#     -b $CURR_BOUNTY \
#     -n "SQLite Sponsor" \
#     -v 0.43
# 
# go run ./cli send sponsor \
#     -f $RICH_SPONSOR_ACCOUNT \
#     -b $CURR_BOUNTY \
#     -n "Rich Crypto Person" \
#     -v 1.337
