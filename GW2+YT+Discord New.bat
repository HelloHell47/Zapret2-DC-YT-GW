start "zapret2: %~n0" /min "%~dp0bin\winws2.exe" ^
--lua-init=@"%~dp0lua\zapret-lib.lua" --lua-init=@"%~dp0lua\zapret-antidpi.lua" ^
--blob=tls_hp:@"%~dp0bin\tls_clienthello_hp_com.bin" ^
--blob=tls_max:@"%~dp0bin\tls_clienthello_max_ru.bin" ^
--blob=tls_4pda:@"%~dp0bin\tls_clienthello_4pda_to.bin" ^
--blob=tls_iana:@"%~dp0bin\tls_clienthello_www_iana_org.bin" ^
--blob=tls_deepseek:@"%~dp0bin\tls_clienthello_chat_deepseek_com.bin" ^
--blob=tls_google:@"%~dp0bin\tls_clienthello_www_google_com.bin" ^
--blob=tls_11:@"%~dp0bin\tls_clienthello_11.bin" ^
--blob=quic_google:@"%~dp0bin\quic_initial_www_google_com.bin" ^
--blob=quic_dbank:@"%~dp0bin\quic_initial_dbankcloud_ru.bin" ^
--blob=quic_steam:@"%~dp0bin\quic_initial_steamcommunity_com.bin" ^
--blob=stun:@"%~dp0bin\stun.bin" ^
--wf-raw-part=@"%~dp0windivert.filter\windivert_part.discord_media.txt" ^
--wf-raw-part=@"%~dp0windivert.filter\windivert_part.wireguard.txt" ^
--wf-raw-part=@"%~dp0windivert.filter\windivert_part.stun.txt" ^
--wf-raw-part=@"%~dp0windivert.filter\windivert_part.quic_initial_ietf.txt" ^

--wf-tcp-out=80,443,2053,2083,2087,2096,8443,6112 ^
--wf-udp-out=443,19294-19344,50000-50100 ^

--filter-tcp=443 ^
--hostlist-domains=ncplatform.net,privacy.xboxlive.com,guildwars2.com,staticwars.com,catalog.gamepass.com ^
--payload=tls_client_hello ^
--lua-desync=hostfakesplit:repeats=4:tcp_ts=-1000:host=www.reddit.com ^
--new ^

--filter-tcp=80 ^
--hostlist-domains=assetcdn.101.ArenaNetworks.com ^
--payload=http_req ^
--lua-desync=fake:blob=tls_11:tcp_ts=-1000 ^
--new ^

--filter-tcp=6112 ^
--ipset="%~dp0lists\gw.txt" ^
--payload=unknown ^
--out-range="n2<n3" ^
--lua-desync=fake:blob=tls_11:tcp_ts=-1000:payload=unknown ^
--new ^

--filter-tcp=443,2053,2083,2087,2096,8443 ^
--payload=all ^
--hostlist-domains=discord.media ^
--lua-desync=hostfakesplit:repeats=4:tcp_ts=-1000:host=www.reddit.com ^
--new ^

--filter-tcp=443 --filter-l7=tls ^
--hostlist="%~dp0lists\list-google.txt" ^
--payload=tls_client_hello ^
--lua-desync=fake:blob=tls_iana:tls_mod=rnd,dupsid,sni=fonts.google.com:tcp_seq=1448 ^
--lua-desync=multidisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1 ^
--new ^

--filter-tcp=443 --filter-l7=tls ^
--hostlist-domains=killproof.me ^
--payload=tls_client_hello ^
--lua-desync=multisplit:blob=tls_4pda:tcp_ts=-1000:pos=2:nodrop:repeats=1 ^
--lua-desync=multisplit:pos=sniext+4 ^
--new ^

--filter-tcp=443,8443 ^
--hostlist="%~dp0lists\zapret-general.txt" ^
--hostlist-exclude="%~dp0lists\zapret-exclude.txt" ^
--out-range=-d10 ^
--payload=tls_client_hello ^
--lua-desync=hostfakesplit:repeats=4:tcp_ts=-1000:host=www.reddit.com ^
--new ^

--filter-tcp=80 --filter-l7=http ^
--hostlist="%~dp0lists\zapret-general.txt" ^
--hostlist-exclude="%~dp0lists\zapret-exclude.txt" ^
--payload=http_req ^
--lua-desync=fake:blob=tls_google:ip_autottl=-2,3-20:ip6_autottl=-2,3-20:tcp_md5 ^
--lua-desync=fakedsplit:ip_autottl=-2,3-20:ip6_autottl=-2,3-20:tcp_md5 ^
--new ^

--filter-udp=19294-19344,50000-50100 --filter-l7=discord,stun ^
--payload=stun,discord_ip_discovery ^
--lua-desync=fake:blob=quic_steam:repeats=6 ^
--new ^

--filter-udp=443 --filter-l7=quic ^
--hostlist="%~dp0lists\list-google.txt" ^
--hostlist="%~dp0lists\zapret-general.txt" ^
--hostlist-exclude="%~dp0lists\zapret-exclude.txt" ^
--payload=quic_initial ^
--lua-desync=fake:blob=quic_google:repeats=11

