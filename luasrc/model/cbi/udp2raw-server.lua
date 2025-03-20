-- Copyright (C) 2025 luci-app-udp2raw-server
-- Copyright (C) 2025 NagaseKouichi
-- Licensed to the public under the GNU General Public License v3.

local m, s, o

local raw_modes                   = {
    "faketcp",
    "udp",
    "icmp",
}

local cipher_modes                = {
    "aes128cbc",
    "xor",
    "none",
}

local auth_modes                  = {
    "md5",
    "crc32",
    "simple",
    "none",
}

m                                 = Map("udp2raw-server", translate("Udp2raw Server"),
    translate("A simple Luci webui for starting Udp2raw Server."))

m:section(SimpleSection).template = "udp2raw-server/status"

s                                 = m:section(TypedSection, "udp2raw-server", translate("General Setting"))
s.anonymous                       = true

o                                 = s:option(Flag, "enable", translate("Enable"))
o.rmempty                         = false

o                                 = s:option(Value, "listen_addr", translate("Server Listen Host"))
o.datatype                        = "ipaddr"
o.placeholder                     = "0.0.0.0"

o                                 = s:option(Value, "listen_port", translate("Server Listen Port"))
o.datatype                        = "port"
o.placeholder                     = "54321"

o                                 = s:option(Value, "remote_addr", translate("Remote Address"))
o.datatype                        = "host"
o.rmempty                         = false

o                                 = s:option(Value, "remote_port", translate("Remote Port"))
o.datatype                        = "port"
o.placeholder                     = "12345"

o                                 = s:option(Value, "key", translate("Password"))
o.password                        = true

o                                 = s:option(ListValue, "raw_mode", translate("Raw Mode"))
for _, v in ipairs(raw_modes) do o:value(v, v:lower()) end
o.default = "faketcp"
o.rmempty = false

o         = s:option(ListValue, "cipher_mode", translate("Cipher Mode"))
for _, v in ipairs(cipher_modes) do o:value(v, v:lower()) end
o.default = "aes128cbc"

o = s:option(ListValue, "auth_mode", translate("Auth Mode"))
for _, v in ipairs(auth_modes) do o:value(v, v:lower()) end
o.default = "md5"

o         = s:option(Flag, "fix_gro", translate("Fix GRO"))
o.rmempty = false

return m
