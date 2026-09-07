start "zapret: %~n0" /min "%~dp0bin\winws2.exe" ^
--lua-init=@"%~dp0lua\zapret-lib.lua" --lua-init=@"%~dp0lua\zapret-antidpi.lua" ^
--blob=tls_hp:@"%~dp0bin\tls_clienthello_hp_com.bin" ^

--wf-tcp-out=80,443,6112 ^
--filter-tcp=6112 --ipset="%~dp0lists\gw.txt" --payload=unknown --out-range="n2<n3" --lua-desync=fake:blob=tls_hp:tcp_ts=-1000:payload=unknown --new ^
--filter-tcp=80 --hostlist-domains=assetcdn.101.ArenaNetworks.com --payload=http_req --out-range="a-d2" --lua-desync=fake:blob=tls_hp:tcp_ts=-1000 --new ^
--filter-tcp=443 --hostlist-domains=ncplatform.net,privacy.xboxlive.com,guildwars2.com,staticwars.com,catalog.gamepass.com --payload=tls_client_hello --lua-desync=fake:blob=tls_hp:tcp_ts=-1000