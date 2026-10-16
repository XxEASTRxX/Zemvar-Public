repeat
	task.wait(1)
until game:IsLoaded();

secure({
    ["preload"] = true, --loadstring(secretstring("dJZ2fICV2It1m5iAvHWDnXrnldjb3szc3d3XzFnpz1lUXdzo6ene3aX5oZS5kvzGvcKbwJ7mtnTGyqo="))(),
    ["message"] = secretstring("VomTftJ4mZF9iZC9g3qJ13SjgaafrqDlipLOf6WplKhkp7Gl2JWbuo25p9W2krudt/2X54/Q3+R9KwzZzLK7sqUFxNi6tLi/ELHP28fSIsW/zMfNxd3v2iLG6h3Sytniz9PmE9vcFe3h2+DY8e8="),
    ["urls"] = {secretstring("jZCEmJY="), secretstring("j4Fri5N7jHRxjJ2PdYuG"), secretstring("VJaGhWCUmnN3gQ=="), secretstring("hpJ8ln+IiniGjY0="), secretstring("cpJ9e42Jj3XFyg=="), secretstring("hZiRfZmQi5J1"), secretstring("iIZ8mIySmQ=="), secretstring("d5aThYiBfw=="), secretstring("WrJip24="), secretstring("ZI2Rh3WKltHF"), secretstring("VIaMmIqzi4GXqQ=="), secretstring("VIaMmIo5x8w="), secretstring("b7hmfIKOig=="), secretstring("jYOCfo95j4+C"), secretstring("cJaMfJaKqYKEkoyRfw=="), secretstring("c4J5hYk="), secretstring("hJKQkJSKkIx0zs0="), secretstring("gYR2fZN4mZF9iZB0fHQ="), secretstring("b5eImI+Sl3OmrMPEUoaKlIQ="), secretstring("ZpaLi5p+mtDFyg=="), secretstring("Y5aOjH9/j4B6sY9/iA=="), secretstring("UoSCno95j4+Cgg=="), secretstring("Uo2RiF+IiniGjYY="), secretstring("ZYx9knyK"), secretstring("hYx9knyK"), secretstring("ZJZ9e3WKj3ODjZ98enaI"), secretstring("dpCMmL44zYA="), secretstring("d5J4jH+IiniGjY0="), secretstring("ZpaLi5p+ms8="), secretstring("YXvPno95j4+CjA=="), secretstring("iYp9kpOCyQ=="), secretstring("VoOLi5mVnbJzmpc="), secretstring("gXt9joCSiIuD"), secretstring("aoaMub04"), secretstring("c4Z6jIBCyc0="), secretstring("gYOUfJSRkICCjsvPvw=="), secretstring("doOLi5mVnbSDnI50foc="), secretstring("doOLi414mYB5"), secretstring("c5SLlH+IiniGjQ=="), secretstring("gYOVksA5yc8="), secretstring("gYOVkn+UmXh1lY0="), secretstring("dJCMk5ODiYKEkoyRf72GnoY="), secretstring("jo6IkJNVjHaG"), secretstring("joaLfo95j4+C15B6fg=="), secretstring("hHqIfZOV1ot3iQ=="), secretstring("joaLiZmXm7WCmIw="), secretstring("dJCMk5ODkIBzlJ+Pf72GnoY="), secretstring("hJZ9e3+IiniGjY27gnyK"), secretstring("dpCMmH+IiniGjY27gnyK"), secretstring("j5OIfH+Il4txndqRe4s="), secretstring("d5J4jJp+mg==")},
    ["pathetic"] = {secretstring("tNC7ug=="),secretstring("hXmHjn1/m7+CkZOOrnp1mH2h"),secretstring("hpaOe5E="),secretstring("g5CGjIo="),secretstring("gZR8jH14")}	
})

local _DENTA, DENTA_VERSION, DENTA_TYPE = identifyexecutor();
local GLOOPY_SAFE_REQUEST = function(data)
    local success = nil
    local ret = nil

    if data.Method == "GET" then
        success, ret = pcall(game.HttpGetAsync, game, data.Url)
    elseif data.Method == "POST" then
        local content_type = "*/*"
        if data.Headers and data.Headers["Content-Type"] then
            content_type = data.Headers["Content-Type"]
        end

        success, ret = pcall(game.HttpPostAsync, game, data.Url, data.Body, content_type)
    end

    if success then
        return { ["StatusCode"] = 200, ["StatusMessage"] = "OK", ["Body"] = ret }
    elseif success ~= nil and type(ret) == "string" then
        local status_code = string.match(ret, "%d+")
        if status_code then
            return { ["StatusCode"] = tonumber(status_code), ["StatusMessage"] = ret, ["Body"] = "" }
        end
    end

    return { ["StatusCode"] = 0, ["StatusMessage"] = "UNK", ["Body"] = "" }
end

local status, res1, res2 = pcall(function()
    -------------------------------------------------------------------------------
    -- ! zemvar letmeauth library (replaces platoboost)
    local ZEMVAR_AUTH = (function()
--!strict
-------------------------------------------------------------------------------
-- ZEMVAR auth module (LetMeAuth protocol v1)
-- Bundled sources (byte-identical, wrapped in module closures):
--   * LetMeAuth Luau SDK 0.1.0-alpha.1 @ f22ff39 (sdks/luau/src)
--   * daily3014/cryptography@3.1.4 EdDSA subtree @ 6147c4702726ab59c4b31ed9304dbe8bb843f05f
-- Rebuild: work/letmeauth/build_bundle.py
-------------------------------------------------------------------------------

local __mods = {}


__mods["sdk/CryptoEncoding"] = { dir = "sdk", fn = function(require)
	--!strict
	
	local Encoding = {}
	
	local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"
	local decodeMap: { [string]: number } = {}
	for index = 1, #alphabet do
		decodeMap[string.sub(alphabet, index, index)] = index - 1
	end
	
	local ed25519SpkiPrefix = string.char(
		0x30,
		0x2A,
		0x30,
		0x05,
		0x06,
		0x03,
		0x2B,
		0x65,
		0x70,
		0x03,
		0x21,
		0x00
	)
	
	local function fail(message: string): never
		error("LetMeAuth crypto encoding error: " .. message, 3)
	end
	
	local function sextet(character: string): number
		local value = decodeMap[character]
		if value == nil then
			fail("base64url input contains invalid characters")
		end
		return value
	end
	
	function Encoding.base64UrlEncode(value: string): string
		if type(value) ~= "string" then
			fail("base64url source must be a binary string")
		end
	
		local parts: { string } = {}
		local outputIndex = 1
		local index = 1
		while index <= #value do
			local a = string.byte(value, index)
			local b = if index + 1 <= #value then string.byte(value, index + 1) else nil
			local c = if index + 2 <= #value then string.byte(value, index + 2) else nil
	
			parts[outputIndex] = string.sub(alphabet, math.floor(a / 4) + 1, math.floor(a / 4) + 1)
			outputIndex += 1
	
			local second = (a % 4) * 16 + if b == nil then 0 else math.floor(b / 16)
			parts[outputIndex] = string.sub(alphabet, second + 1, second + 1)
			outputIndex += 1
	
			if b ~= nil then
				local third = (b % 16) * 4 + if c == nil then 0 else math.floor(c / 64)
				parts[outputIndex] = string.sub(alphabet, third + 1, third + 1)
				outputIndex += 1
			end
	
			if c ~= nil then
				local fourth = c % 64
				parts[outputIndex] = string.sub(alphabet, fourth + 1, fourth + 1)
				outputIndex += 1
			end
	
			index += 3
		end
	
		return table.concat(parts)
	end
	
	function Encoding.base64UrlDecodeStrict(value: string): string
		if type(value) ~= "string" or #value == 0 then
			fail("base64url input must be a non-empty string")
		end
		if string.find(value, "=", 1, true) ~= nil then
			fail("base64url input must be unpadded")
		end
		if #value % 4 == 1 then
			fail("base64url input has an invalid length")
		end
	
		local bytes: { string } = {}
		local byteIndex = 1
		local index = 1
		while index <= #value do
			local remaining = #value - index + 1
			local take = math.min(4, remaining)
			if take == 1 then
				fail("base64url input has an invalid terminal quantum")
			end
	
			local a = sextet(string.sub(value, index, index))
			local b = sextet(string.sub(value, index + 1, index + 1))
			local c = if take >= 3 then sextet(string.sub(value, index + 2, index + 2)) else nil
			local d = if take == 4 then sextet(string.sub(value, index + 3, index + 3)) else nil
	
			bytes[byteIndex] = string.char(a * 4 + math.floor(b / 16))
			byteIndex += 1
	
			if c ~= nil then
				bytes[byteIndex] = string.char((b % 16) * 16 + math.floor(c / 4))
				byteIndex += 1
			elseif b % 16 ~= 0 then
				fail("base64url input has non-zero trailing bits")
			end
	
			if d ~= nil and c ~= nil then
				bytes[byteIndex] = string.char((c % 4) * 64 + d)
				byteIndex += 1
			elseif c ~= nil and c % 4 ~= 0 then
				fail("base64url input has non-zero trailing bits")
			end
	
			index += take
		end
	
		local decoded = table.concat(bytes)
		if Encoding.base64UrlEncode(decoded) ~= value then
			fail("base64url input is not canonical")
		end
		return decoded
	end
	
	function Encoding.decodeEd25519Signature(signatureBase64Url: string): string
		local signature = Encoding.base64UrlDecodeStrict(signatureBase64Url)
		if #signature ~= 64 then
			fail("Ed25519 signature must decode to exactly 64 bytes")
		end
		return signature
	end
	
	function Encoding.extractEd25519RawPublicKey(publicKeySpkiBase64Url: string): string
		local spki = Encoding.base64UrlDecodeStrict(publicKeySpkiBase64Url)
		if #spki ~= 44 then
			fail("Ed25519 SPKI must decode to exactly 44 bytes")
		end
		if string.sub(spki, 1, #ed25519SpkiPrefix) ~= ed25519SpkiPrefix then
			fail("Ed25519 SPKI does not match the RFC 8410 structure")
		end
	
		local raw = string.sub(spki, #ed25519SpkiPrefix + 1)
		if #raw ~= 32 then
			fail("Ed25519 public key must be exactly 32 bytes")
		end
		return raw
	end
	
	return table.freeze(Encoding)

end }

__mods["sdk/AuthorizationProtocol"] = { dir = "sdk", fn = function(require)
	--!strict
	
	local Protocol = {}
	
	local MAX_SAFE_INTEGER = 9007199254740991
	
	local allowedCodes: { [string]: boolean } = {
		AUTHORIZED = true,
		INVALID_CREDENTIAL = true,
		EXPIRED = true,
		REVOKED = true,
		DEVICE_REQUIRED = true,
		DEVICE_LIMIT = true,
		SESSION_LIMIT = true,
		VERSION_BLOCKED = true,
		APPLICATION_DISABLED = true,
		RATE_LIMITED = true,
		REPLAYED = true,
		SERVICE_UNAVAILABLE = true,
	}
	
	local allowedFields: { [string]: boolean } = {
		protocolVersion = true,
		keyId = true,
		applicationId = true,
		environment = true,
		decision = true,
		code = true,
		issuedAt = true,
		expiresAt = true,
		requestNonce = true,
		licenseId = true,
		sessionId = true,
		entitlements = true,
	}
	
	local function fail(message: string): never
		error("LetMeAuth protocol error: " .. message, 3)
	end
	
	local function requireString(value: any, name: string): string
		if type(value) ~= "string" or #value == 0 then
			fail(name .. " must be a non-empty string")
		end
		return value
	end
	
	local function requireInteger(value: any, name: string): number
		if
			type(value) ~= "number"
			or value ~= value
			or value == math.huge
			or value == -math.huge
			or value ~= math.floor(value)
			or math.abs(value) > MAX_SAFE_INTEGER
		then
			fail(name .. " must be a safe integer")
		end
		return value
	end
	
	local function jsonString(value: string): string
		local output = table.create(#value + 2)
		table.insert(output, '"')
	
		for index = 1, #value do
			local byte = string.byte(value, index)
			if byte == 34 then
				table.insert(output, '\\"')
			elseif byte == 92 then
				table.insert(output, "\\\\")
			elseif byte == 8 then
				table.insert(output, "\\b")
			elseif byte == 9 then
				table.insert(output, "\\t")
			elseif byte == 10 then
				table.insert(output, "\\n")
			elseif byte == 12 then
				table.insert(output, "\\f")
			elseif byte == 13 then
				table.insert(output, "\\r")
			elseif byte < 32 then
				table.insert(output, string.format("\\u%04x", byte))
			else
				table.insert(output, string.sub(value, index, index))
			end
		end
	
		table.insert(output, '"')
		return table.concat(output)
	end
	
	local function decimalInteger(value: number): string
		return string.format("%.0f", value)
	end
	
	local function sortedEntitlements(value: any): { string }
		if type(value) ~= "table" then
			fail("entitlements must be an array")
		end
	
		local count = 0
		for key, entitlement in pairs(value) do
			count += 1
			if type(key) ~= "number" or key < 1 or key ~= math.floor(key) then
				fail("entitlements must be a dense array")
			end
			if type(entitlement) ~= "string" or #entitlement == 0 then
				fail("each entitlement must be a non-empty string")
			end
			if string.match(entitlement, "^[A-Za-z0-9._:%-]+$") == nil then
				fail("entitlement contains unsupported characters")
			end
		end
	
		if count ~= #value then
			fail("entitlements must be a dense array")
		end
	
		local copy: { string } = {}
		for index = 1, #value do
			local entitlement = value[index]
			if type(entitlement) ~= "string" then
				fail("each entitlement must be a non-empty string")
			end
			copy[index] = entitlement
		end
		table.sort(copy)
		return copy
	end
	
	function Protocol.canonicalizeV1(grant: { [any]: any }): string
		if type(grant) ~= "table" then
			fail("grant must be a table")
		end
	
		for key in pairs(grant) do
			if type(key) ~= "string" or not allowedFields[key] then
				fail("grant contains an unknown field")
			end
		end
	
		if grant.protocolVersion ~= 1 then
			fail("protocolVersion must be 1")
		end
	
		local keyId = requireString(grant.keyId, "keyId")
		local applicationId = requireString(grant.applicationId, "applicationId")
		local environment = requireString(grant.environment, "environment")
		if environment ~= "development" and environment ~= "production" then
			fail("environment is invalid")
		end
	
		local decision = requireString(grant.decision, "decision")
		if decision ~= "allow" and decision ~= "deny" then
			fail("decision is invalid")
		end
	
		local code = requireString(grant.code, "code")
		if not allowedCodes[code] then
			fail("code is invalid")
		end
	
		local issuedAt = requireInteger(grant.issuedAt, "issuedAt")
		local expiresAt = requireInteger(grant.expiresAt, "expiresAt")
		local requestNonce = requireString(grant.requestNonce, "requestNonce")
	
		local licenseId: string? = nil
		if grant.licenseId ~= nil then
			licenseId = requireString(grant.licenseId, "licenseId")
		end
	
		local sessionId: string? = nil
		if grant.sessionId ~= nil then
			sessionId = requireString(grant.sessionId, "sessionId")
		end
	
		local entitlements = sortedEntitlements(grant.entitlements)
	
		local fields = {
			'{"protocolVersion":1',
			',"keyId":' .. jsonString(keyId),
			',"applicationId":' .. jsonString(applicationId),
			',"environment":' .. jsonString(environment),
			',"decision":' .. jsonString(decision),
			',"code":' .. jsonString(code),
			',"issuedAt":' .. decimalInteger(issuedAt),
			',"expiresAt":' .. decimalInteger(expiresAt),
			',"requestNonce":' .. jsonString(requestNonce),
		}
	
		if licenseId ~= nil then
			table.insert(fields, ',"licenseId":' .. jsonString(licenseId))
		end
		if sessionId ~= nil then
			table.insert(fields, ',"sessionId":' .. jsonString(sessionId))
		end
	
		local encodedEntitlements = table.create(#entitlements)
		for index, entitlement in ipairs(entitlements) do
			encodedEntitlements[index] = jsonString(entitlement)
		end
		table.insert(fields, ',"entitlements":[' .. table.concat(encodedEntitlements, ",") .. "]}")
		return table.concat(fields)
	end
	
	return table.freeze(Protocol)

end }

__mods["sdk/AuthorizationVerifier"] = { dir = "sdk", fn = function(require)
	--!strict
	
	local Protocol = require("./AuthorizationProtocol")
	local HostAdapter = require("./HostAdapter")
	
	local Verifier = {}
	
	local function fail(message: string): never
		error("LetMeAuth authorization verification error: " .. message, 3)
	end
	
	local function requireString(value: any, name: string): string
		if type(value) ~= "string" or #value == 0 then
			fail(name .. " must be a non-empty string")
		end
		return value
	end
	
	local function requireInteger(value: any, name: string): number
		if
			type(value) ~= "number"
			or value ~= value
			or value == math.huge
			or value == -math.huge
			or value ~= math.floor(value)
		then
			fail(name .. " must be a finite integer")
		end
		return value
	end
	
	local function copyEntitlements(value: any): { string }
		if type(value) ~= "table" then
			fail("entitlements must be an array")
		end
		local result: { string } = {}
		for index = 1, #value do
			local entitlement = value[index]
			if type(entitlement) ~= "string" then
				fail("entitlements must contain strings")
			end
			result[index] = entitlement
		end
		return result
	end
	
	local function findVerificationKey(keysResponse: any, applicationId: string, environment: string, keyId: string): any
		if
			type(keysResponse) ~= "table"
			or keysResponse.ok ~= true
			or keysResponse.application_id ~= applicationId
			or keysResponse.environment ~= environment
			or type(keysResponse.keys) ~= "table"
		then
			fail("verification-key response is invalid")
		end
	
		for _, candidate in ipairs(keysResponse.keys) do
			if type(candidate) ~= "table" then
				fail("verification-key response contains an invalid key")
			end
			if candidate.kid == keyId then
				if
					candidate.alg ~= "Ed25519"
					or (candidate.status ~= "active" and candidate.status ~= "retiring")
					or type(candidate.public_key) ~= "string"
					or #candidate.public_key == 0
				then
					fail("matching verification key is invalid")
				end
				requireInteger(candidate.not_before, "verification key not_before")
				if candidate.retire_at ~= nil then
					requireInteger(candidate.retire_at, "verification key retire_at")
				end
				return candidate
			end
		end
	
		return fail("verification key was not found")
	end
	
	function Verifier.verifySignedAuthorization(
		host: any,
		config: any,
		envelope: any,
		keysResponse: any,
		binding: any
	): any
		HostAdapter.validate(host)
	
		if type(config) ~= "table" then
			fail("config must be a table")
		end
		local applicationId = requireString(config.applicationId, "applicationId")
		local environment = requireString(config.environment, "environment")
		if environment ~= "development" and environment ~= "production" then
			fail("environment is invalid")
		end
	
		local maxClockSkewSeconds = if config.maxClockSkewSeconds == nil
			then 30
			else requireInteger(config.maxClockSkewSeconds, "maxClockSkewSeconds")
		if maxClockSkewSeconds < 0 or maxClockSkewSeconds > 600 then
			fail("maxClockSkewSeconds must be between 0 and 600")
		end
	
		if type(envelope) ~= "table" or type(envelope.grant) ~= "table" then
			fail("authorization envelope is invalid")
		end
		local signature = requireString(envelope.signature, "signature")
		if string.match(signature, "^[A-Za-z0-9_-]+$") == nil then
			fail("signature encoding is invalid")
		end
	
		local grant = envelope.grant
		local canonical = Protocol.canonicalizeV1(grant)
		local keyId = requireString(grant.keyId, "grant keyId")
		local key = findVerificationKey(keysResponse, applicationId, environment, keyId)
	
		HostAdapter.verifyEd25519(host, key.public_key, signature, canonical)
	
		if type(binding) ~= "table" then
			fail("binding must be a table")
		end
		local expectedNonce = requireString(binding.nonce, "binding nonce")
		local expectedSessionId = binding.sessionId
		if expectedSessionId ~= nil then
			expectedSessionId = requireString(expectedSessionId, "binding sessionId")
		end
	
		if
			grant.applicationId ~= applicationId
			or grant.environment ~= environment
			or grant.requestNonce ~= expectedNonce
			or (expectedSessionId ~= nil and grant.sessionId ~= expectedSessionId)
		then
			fail("signed authorization does not match the originating request")
		end
	
		local nowSeconds = HostAdapter.nowSeconds(host)
		local issuedAt = requireInteger(grant.issuedAt, "grant issuedAt")
		local expiresAt = requireInteger(grant.expiresAt, "grant expiresAt")
		if
			issuedAt > nowSeconds + maxClockSkewSeconds
			or expiresAt <= issuedAt
			or expiresAt < nowSeconds - maxClockSkewSeconds
		then
			fail("signed authorization is outside its valid time window")
		end
	
		local issuedAtMs = issuedAt * 1000
		local skewMs = maxClockSkewSeconds * 1000
		local notBefore = requireInteger(key.not_before, "verification key not_before")
		if issuedAtMs + skewMs < notBefore then
			fail("signing key was not valid when the authorization was issued")
		end
		if key.retire_at ~= nil then
			local retireAt = requireInteger(key.retire_at, "verification key retire_at")
			if issuedAtMs - skewMs >= retireAt then
				fail("signing key was retired when the authorization was issued")
			end
		end
	
		local decision = requireString(grant.decision, "grant decision")
		local code = requireString(grant.code, "grant code")
		local entitlements = copyEntitlements(grant.entitlements)
		local licenseId = grant.licenseId
		if licenseId ~= nil then
			licenseId = requireString(licenseId, "grant licenseId")
		end
		local sessionId = grant.sessionId
		if sessionId ~= nil then
			sessionId = requireString(sessionId, "grant sessionId")
		end
	
		if decision == "allow" then
			if code ~= "AUTHORIZED" or licenseId == nil then
				fail("signed allow result is inconsistent")
			end
		elseif decision == "deny" then
			if code == "AUTHORIZED" or licenseId ~= nil or sessionId ~= nil or #entitlements ~= 0 then
				fail("signed denial result is inconsistent")
			end
		else
			fail("grant decision is invalid")
		end
	
		return {
			decision = decision,
			code = code,
			licenseId = licenseId,
			sessionId = sessionId,
			entitlements = entitlements,
			issuedAt = issuedAt,
			expiresAt = expiresAt,
		}
	end
	
	return table.freeze(Verifier)

end }

__mods["sdk/HostAdapter"] = { dir = "sdk", fn = function(require)
	--!strict
	
	local HostAdapter = {}
	
	local requiredFunctions = {
		"request",
		"encodeJson",
		"decodeJson",
		"nowSeconds",
		"randomNonce",
		"verifyEd25519",
	}
	
	local function fail(message: string): never
		error("LetMeAuth host adapter error: " .. message, 3)
	end
	
	function HostAdapter.validate(adapter: any): any
		if type(adapter) ~= "table" then
			fail("adapter must be a table")
		end
	
		for _, name in ipairs(requiredFunctions) do
			if type(adapter[name]) ~= "function" then
				fail(name .. " capability is required")
			end
		end
	
		return adapter
	end
	
	function HostAdapter.nowSeconds(adapter: any): number
		HostAdapter.validate(adapter)
		local ok, value = pcall(adapter.nowSeconds)
		if
			not ok
			or type(value) ~= "number"
			or value ~= value
			or value == math.huge
			or value == -math.huge
			or value ~= math.floor(value)
		then
			fail("nowSeconds must return a finite integer Unix timestamp")
		end
		return value
	end
	
	function HostAdapter.randomNonce(adapter: any): string
		HostAdapter.validate(adapter)
		local ok, value = pcall(adapter.randomNonce)
		if not ok or type(value) ~= "string" or string.match(value, "^[A-Za-z0-9_-]+$") == nil then
			fail("randomNonce must return URL-safe characters")
		end
		if #value < 16 or #value > 128 then
			fail("randomNonce must return 16 to 128 URL-safe characters")
		end
		return value
	end
	
	function HostAdapter.verifyEd25519(
		adapter: any,
		publicKeySpkiBase64Url: string,
		signatureBase64Url: string,
		message: string
	): boolean
		HostAdapter.validate(adapter)
	
		if type(publicKeySpkiBase64Url) ~= "string" or #publicKeySpkiBase64Url == 0 then
			fail("public verification key is invalid")
		end
		if type(signatureBase64Url) ~= "string" or #signatureBase64Url == 0 then
			fail("authorization signature is invalid")
		end
		if type(message) ~= "string" then
			fail("canonical authorization message is invalid")
		end
	
		local ok, verified = pcall(
			adapter.verifyEd25519,
			publicKeySpkiBase64Url,
			signatureBase64Url,
			message
		)
		if not ok or verified ~= true then
			fail("Ed25519 signature verification failed")
		end
		return true
	end
	
	return table.freeze(HostAdapter)

end }

__mods["sdk/RobloxCryptographyAdapter"] = { dir = "sdk", fn = function(require)
	--!strict
	
	local Encoding = require("./CryptoEncoding")
	
	local Adapter = {}
	
	local VECTOR_PUBLIC_KEY = "MCowBQYDK2VwAyEA11qYAYKxCrfVS_7TyWQHOg7hcvPapiMlrwIaaPcHURo"
	local VECTOR_SIGNATURE = "rbH3pxTMFG3EwoYnvVITBEMzEjieY4tSgVj_z_7uNdFNt5gt2sO3v3qIvhoKDFPvmkdDBDnGSrYGQhepuvedDQ"
	local VECTOR_MESSAGE = '{"protocolVersion":1,"keyId":"lma_kid_vector_1","applicationId":"lma_app_vector","environment":"production","decision":"allow","code":"AUTHORIZED","issuedAt":1790000000,"expiresAt":1790000060,"requestNonce":"abcdefghijklmnop","licenseId":"lma_lic_vector","sessionId":"lma_flow_session_vector","entitlements":["alpha","feature.export","premium"]}'
	
	local function fail(message: string): never
		error("LetMeAuth Roblox cryptography adapter error: " .. message, 3)
	end
	
	local function requireEd25519(cryptography: any): any
		if type(cryptography) ~= "table" then
			fail("cryptography module must be a table")
		end
		if type(cryptography.Verification) ~= "table" or type(cryptography.Verification.EdDSA) ~= "table" then
			fail("cryptography.Verification.EdDSA is required")
		end
		local ed25519 = cryptography.Verification.EdDSA
		if type(ed25519.Verify) ~= "function" then
			fail("cryptography.Verification.EdDSA.Verify is required")
		end
		return ed25519
	end
	
	local function binaryBuffer(value: string): buffer
		return buffer.fromstring(value)
	end
	
	local function verifyWithModule(
		ed25519: any,
		publicKeySpkiBase64Url: string,
		signatureBase64Url: string,
		message: string
	): boolean
		local publicKey = Encoding.extractEd25519RawPublicKey(publicKeySpkiBase64Url)
		local signature = Encoding.decodeEd25519Signature(signatureBase64Url)
	
		local ok, verified = pcall(
			ed25519.Verify,
			binaryBuffer(message),
			binaryBuffer(publicKey),
			binaryBuffer(signature)
		)
		return ok and verified == true
	end
	
	function Adapter.assertConformance(cryptography: any): boolean
		local ed25519 = requireEd25519(cryptography)
		if not verifyWithModule(ed25519, VECTOR_PUBLIC_KEY, VECTOR_SIGNATURE, VECTOR_MESSAGE) then
			fail("Ed25519 implementation failed the LetMeAuth protocol-v1 known-answer test")
		end
	
		local tampered = VECTOR_MESSAGE .. " "
		if verifyWithModule(ed25519, VECTOR_PUBLIC_KEY, VECTOR_SIGNATURE, tampered) then
			fail("Ed25519 implementation accepted a tampered LetMeAuth known-answer message")
		end
	
		return true
	end
	
	function Adapter.createVerifier(cryptography: any): (
		publicKeySpkiBase64Url: string,
		signatureBase64Url: string,
		message: string
	) -> boolean
		local ed25519 = requireEd25519(cryptography)
		Adapter.assertConformance(cryptography)
	
		return function(
			publicKeySpkiBase64Url: string,
			signatureBase64Url: string,
			message: string
		): boolean
			if type(message) ~= "string" then
				return false
			end
			return verifyWithModule(ed25519, publicKeySpkiBase64Url, signatureBase64Url, message)
		end
	end
	
	function Adapter.createHost(httpService: any, cryptography: any): any
		if type(httpService) ~= "table" then
			fail("HttpService is required")
		end
		for _, name in ipairs({ "RequestAsync", "JSONEncode", "JSONDecode", "GenerateGUID" }) do
			if type(httpService[name]) ~= "function" then
				fail("HttpService." .. name .. " is required")
			end
		end
	
		local verifyEd25519 = Adapter.createVerifier(cryptography)
	
		return {
			request = function(input: any): any
				if type(input) ~= "table" or type(input.url) ~= "string" or type(input.method) ~= "string" then
					fail("HTTP request input is invalid")
				end
	
				local requestInfo: any = {
					Url = input.url,
					Method = input.method,
					Headers = if type(input.headers) == "table" then input.headers else {},
				}
				if input.body ~= nil then
					if type(input.body) ~= "string" then
						fail("HTTP request body must be a string")
					end
					requestInfo.Body = input.body
				end
	
				local ok, response = pcall(httpService.RequestAsync, httpService, requestInfo)
				if
					not ok
					or type(response) ~= "table"
					or type(response.StatusCode) ~= "number"
					or type(response.Body) ~= "string"
				then
					fail("HttpService.RequestAsync failed")
				end
	
				return {
					status = response.StatusCode,
					body = response.Body,
				}
			end,
			encodeJson = function(value: any): string
				local ok, result = pcall(httpService.JSONEncode, httpService, value)
				if not ok or type(result) ~= "string" then
					fail("HttpService.JSONEncode failed")
				end
				return result
			end,
			decodeJson = function(value: string): any
				local ok, result = pcall(httpService.JSONDecode, httpService, value)
				if not ok or type(result) ~= "table" then
					fail("HttpService.JSONDecode failed")
				end
				return result
			end,
			nowSeconds = function(): number
				return os.time()
			end,
			randomNonce = function(): string
				local ok, value = pcall(httpService.GenerateGUID, httpService, false)
				if not ok or type(value) ~= "string" then
					fail("HttpService.GenerateGUID failed")
				end
				value = string.gsub(value, "[{}]", "")
				if #value < 16 or string.match(value, "^[A-Za-z0-9_-]+$") == nil then
					fail("HttpService.GenerateGUID returned an invalid nonce")
				end
				return value
			end,
			verifyEd25519 = verifyEd25519,
		}
	end
	
	return table.freeze(Adapter)

end }

__mods["sdk/Client"] = { dir = "sdk", fn = function(require)
	--!strict
	
	local HostAdapter = require("./HostAdapter")
	local Verifier = require("./AuthorizationVerifier")
	
	local Client = {}
	Client.__index = Client
	
	local function fail(message: string): never
		error("LetMeAuth client error: " .. message, 3)
	end
	
	local function requireString(value: any, name: string): string
		if type(value) ~= "string" or #value == 0 then
			fail(name .. " must be a non-empty string")
		end
		return value
	end
	
	local function normalizeOrigin(value: any): string
		local origin = requireString(value, "apiOrigin")
		if string.match(origin, "^https?://[^%s]+$") == nil then
			fail("apiOrigin must be an absolute HTTP(S) origin")
		end
		local authority = string.match(origin, "^http://([^/%?#]+)")
		if authority ~= nil then
			local hostname = string.lower(string.match(authority, "^(.-):%d+$") or authority)
			if hostname ~= "localhost" and hostname ~= "127.0.0.1" and hostname ~= "[::1]" then
				fail("apiOrigin requires HTTPS except for loopback testing")
			end
		end
		origin = string.gsub(origin, "/+$", "")
		if #origin == 0 then
			fail("apiOrigin is invalid")
		end
		return origin
	end
	
	local function validateApplicationId(value: any): string
		local applicationId = requireString(value, "applicationId")
		if string.match(applicationId, "^lma_app_[A-Za-z0-9_-]+$") == nil or #applicationId < 14 then
			fail("applicationId is invalid")
		end
		return applicationId
	end
	
	local function validateEnvironment(value: any): string
		if value ~= "development" and value ~= "production" then
			fail("environment is invalid")
		end
		return value
	end
	
	local function encodeJson(host: any, value: any): string
		local ok, encoded = pcall(host.encodeJson, value)
		if not ok or type(encoded) ~= "string" or #encoded == 0 then
			fail("host JSON encoding failed")
		end
		return encoded
	end
	
	local function decodeJson(host: any, value: string): any
		local ok, decoded = pcall(host.decodeJson, value)
		if not ok or type(decoded) ~= "table" then
			fail("host JSON decoding failed")
		end
		return decoded
	end
	
	local function request(host: any, input: any): any
		local ok, response = pcall(host.request, input)
		if not ok or type(response) ~= "table" then
			fail("host HTTP request failed")
		end
		if
			type(response.status) ~= "number"
			or response.status ~= math.floor(response.status)
			or response.status < 100
			or response.status > 599
			or type(response.body) ~= "string"
		then
			fail("host HTTP response is invalid")
		end
		return response
	end
	
	function Client.new(host: any, config: any): any
		HostAdapter.validate(host)
		if type(config) ~= "table" then
			fail("config must be a table")
		end
	
		local self = setmetatable({}, Client)
		self._host = host
		self._apiOrigin = normalizeOrigin(config.apiOrigin)
		self._applicationId = validateApplicationId(config.applicationId)
		self._environment = validateEnvironment(config.environment)
		self._maxClockSkewSeconds = if config.maxClockSkewSeconds == nil
			then 30
			else config.maxClockSkewSeconds
	
		if
			type(self._maxClockSkewSeconds) ~= "number"
			or self._maxClockSkewSeconds ~= math.floor(self._maxClockSkewSeconds)
			or self._maxClockSkewSeconds < 0
			or self._maxClockSkewSeconds > 600
		then
			fail("maxClockSkewSeconds must be an integer between 0 and 600")
		end
	
		return self
	end
	
	function Client._listVerificationKeys(self: any): any
		local response = request(self._host, {
			method = "GET",
			url = self._apiOrigin
				.. "/v1/apps/"
				.. self._applicationId
				.. "/environments/"
				.. self._environment
				.. "/verification-keys",
			headers = {
				accept = "application/json",
			},
		})
	
		if response.status < 200 or response.status >= 300 then
			fail("verification-key request failed with HTTP status " .. tostring(response.status))
		end
	
		return decodeJson(self._host, response.body)
	end
	
	function Client.authorizeLicense(self: any, input: any): any
		if type(input) ~= "table" then
			fail("authorizeLicense input must be a table")
		end
	
		local licenseKey = requireString(input.licenseKey, "licenseKey")
		if #licenseKey < 8 or #licenseKey > 512 then
			fail("licenseKey must be 8 to 512 characters")
		end
	
		local deviceId = input.deviceId
		if deviceId ~= nil then
			deviceId = requireString(deviceId, "deviceId")
			if #deviceId > 512 then
				fail("deviceId must be 1 to 512 characters")
			end
		end
	
		local sessionId = input.sessionId
		if sessionId ~= nil then
			sessionId = requireString(sessionId, "sessionId")
			if
				#sessionId > 128
				or #sessionId < 20
				or string.match(sessionId, "^lma_ses_[A-Za-z0-9_-]+$") == nil
			then
				fail("sessionId is invalid")
			end
		end
	
		local clientVersion = input.clientVersion
		if clientVersion ~= nil then
			clientVersion = requireString(clientVersion, "clientVersion")
			if #clientVersion > 128 then
				fail("clientVersion must be 1 to 128 characters")
			end
		end
	
		local nonce = input.nonce
		if nonce == nil then
			nonce = HostAdapter.randomNonce(self._host)
		else
			nonce = requireString(nonce, "nonce")
		end
		if #nonce < 16 or #nonce > 128 or string.match(nonce, "^[A-Za-z0-9_-]+$") == nil then
			fail("nonce must contain 16 to 128 URL-safe characters")
		end
	
		local timestamp = HostAdapter.nowSeconds(self._host)
		local payload: { [string]: any } = {
			protocol_version = 1,
			application_id = self._applicationId,
			environment = self._environment,
			credential = {
				type = "license_key",
				value = licenseKey,
			},
			nonce = nonce,
			timestamp = timestamp,
		}
		if deviceId ~= nil then
			payload.device_id = deviceId
		end
		if sessionId ~= nil then
			payload.session_id = sessionId
		end
		if clientVersion ~= nil then
			payload.client_version = clientVersion
		end
	
		local response = request(self._host, {
			method = "POST",
			url = self._apiOrigin .. "/v1/authorize",
			headers = {
				accept = "application/json",
				["content-type"] = "application/json",
			},
			body = encodeJson(self._host, payload),
		})
	
		if response.status < 200 or response.status >= 300 then
			fail("authorization request failed with HTTP status " .. tostring(response.status))
		end
	
		local envelope = decodeJson(self._host, response.body)
		if type(envelope.grant) ~= "table" or type(envelope.signature) ~= "string" then
			fail("authorization response is invalid")
		end
	
		local keysResponse = self:_listVerificationKeys()
		local verified = Verifier.verifySignedAuthorization(
			self._host,
			{
				applicationId = self._applicationId,
				environment = self._environment,
				maxClockSkewSeconds = self._maxClockSkewSeconds,
			},
			envelope,
			keysResponse,
			if sessionId == nil then { nonce = nonce } else { nonce = nonce, sessionId = sessionId }
		)
	
		return {
			decision = verified.decision,
			code = verified.code,
			licenseId = verified.licenseId,
			sessionId = verified.sessionId,
			entitlements = verified.entitlements,
			issuedAt = verified.issuedAt,
			expiresAt = verified.expiresAt,
			authorization = envelope,
		}
	end
	
	
	local function requireFiniteNumber(value: any, name: string): number
		if
			type(value) ~= "number"
			or value ~= value
			or value == math.huge
			or value == -math.huge
		then
			fail(name .. " must be a finite number")
		end
		return value
	end
	
	local function copyStringArray(value: any, name: string): { string }
		if type(value) ~= "table" then
			fail(name .. " must be an array")
		end
		local result: { string } = {}
		local count = 0
		for key, item in pairs(value) do
			count += 1
			if type(key) ~= "number" or key < 1 or key ~= math.floor(key) then
				fail(name .. " must be a dense array")
			end
			if type(item) ~= "string" then
				fail(name .. " must contain only strings")
			end
		end
		if count ~= #value then
			fail(name .. " must be a dense array")
		end
		for index = 1, #value do
			local item = value[index]
			if type(item) ~= "string" then
				fail(name .. " must contain only strings")
			end
			result[index] = item
		end
		return result
	end
	
	local function equalStringSets(left: { string }, right: { string }): boolean
		local a: { string } = {}
		local b: { string } = {}
		for index, value in ipairs(left) do
			a[index] = value
		end
		for index, value in ipairs(right) do
			b[index] = value
		end
		table.sort(a)
		table.sort(b)
		if #a ~= #b then
			return false
		end
		for index = 1, #a do
			if a[index] ~= b[index] then
				return false
			end
		end
		return true
	end
	
	local function safeHttpUrl(value: any, secret: string?): string
		local url = requireString(value, "flowUrl")
		if string.match(url, "^https?://[^%s]+$") == nil then
			fail("flowUrl must be an absolute HTTP(S) URL")
		end
		if secret ~= nil and string.find(url, secret, 1, true) ~= nil then
			fail("flowUrl must not contain the claim bearer")
		end
		return url
	end
	
	function Client.restoreAccessFlowClaim(self: any, value: any): any
		if type(value) ~= "table" then
			fail("persisted claim handle is invalid")
		end
	
		local applicationId = requireString(value.applicationId, "claim applicationId")
		local environment = requireString(value.environment, "claim environment")
		local flowId = requireString(value.flowId, "claim flowId")
		local sessionId = requireString(value.sessionId, "claim sessionId")
		local claimId = requireString(value.claimId, "claim claimId")
		local claimToken = requireString(value.claimToken, "claim claimToken")
		local nonce = requireString(value.nonce, "claim nonce")
		local sessionExpiresAt = requireFiniteNumber(value.sessionExpiresAt, "claim sessionExpiresAt")
		local claimExpiresAt = requireFiniteNumber(value.claimExpiresAt, "claim claimExpiresAt")
	
		if
			value.protocolVersion ~= 1
			or applicationId ~= self._applicationId
			or environment ~= self._environment
			or string.match(flowId, "^lma_flow_[A-Za-z0-9_-]+$") == nil
			or #flowId < 17
			or string.match(sessionId, "^lma_flow_session_[A-Za-z0-9_-]+$") == nil
			or #sessionId < 25
			or string.match(claimId, "^lma_flow_claim_[A-Za-z0-9_-]+$") == nil
			or #claimId < 23
			or string.match(claimToken, "^lma_flow_claim_secret_[A-Za-z0-9_-]+$") == nil
			or #claimToken < 42
			or string.match(nonce, "^[A-Za-z0-9_-]+$") == nil
			or #nonce < 16
			or #nonce > 128
		then
			fail("persisted claim handle is invalid")
		end
	
		local flowUrl = safeHttpUrl(value.flowUrl, claimToken)
	
		return {
			protocolVersion = 1,
			applicationId = applicationId,
			environment = environment,
			flowId = flowId,
			sessionId = sessionId,
			sessionExpiresAt = sessionExpiresAt,
			claimId = claimId,
			claimToken = claimToken,
			claimExpiresAt = claimExpiresAt,
			nonce = nonce,
			flowUrl = flowUrl,
		}
	end
	
	function Client.createAccessFlowClaim(self: any, input: any): any
		if type(input) ~= "table" then
			fail("createAccessFlowClaim input must be a table")
		end
	
		local flowId = requireString(input.flowId, "flowId")
		if string.match(flowId, "^lma_flow_[A-Za-z0-9_-]+$") == nil or #flowId < 17 then
			fail("flowId is invalid")
		end
	
		local deviceId = input.deviceId
		if deviceId ~= nil then
			deviceId = requireString(deviceId, "deviceId")
			if #deviceId > 512 then
				fail("deviceId must be 1 to 512 characters")
			end
		end
	
		local clientVersion = input.clientVersion
		if clientVersion ~= nil then
			clientVersion = requireString(clientVersion, "clientVersion")
			if #clientVersion > 128 then
				fail("clientVersion must be 1 to 128 characters")
			end
		end
	
		local nonce = input.nonce
		if nonce == nil then
			nonce = HostAdapter.randomNonce(self._host)
		else
			nonce = requireString(nonce, "nonce")
		end
		if #nonce < 16 or #nonce > 128 or string.match(nonce, "^[A-Za-z0-9_-]+$") == nil then
			fail("nonce must contain 16 to 128 URL-safe characters")
		end
	
		local payload: { [string]: any } = {
			application_id = self._applicationId,
			environment = self._environment,
			nonce = nonce,
			timestamp = HostAdapter.nowSeconds(self._host),
		}
		if deviceId ~= nil then
			payload.device_id = deviceId
		end
		if clientVersion ~= nil then
			payload.client_version = clientVersion
		end
	
		local response = request(self._host, {
			method = "POST",
			url = self._apiOrigin .. "/v1/access/flows/" .. flowId .. "/client-claims",
			headers = {
				accept = "application/json",
				["content-type"] = "application/json",
			},
			body = encodeJson(self._host, payload),
		})
		if response.status < 200 or response.status >= 300 then
			fail("Access Flow claim request failed with HTTP status " .. tostring(response.status))
		end
	
		local body = decodeJson(self._host, response.body)
		if body.ok ~= true or type(body.claim) ~= "table" then
			fail("Access Flow claim response is invalid")
		end
	
		local responseFlowId = requireString(body.flow_id, "response flow_id")
		if responseFlowId ~= flowId then
			fail("Access Flow claim response does not match the requested flow")
		end
		local sessionId = requireString(body.session_id, "response session_id")
		local sessionExpiresAt = requireFiniteNumber(body.session_expires_at, "response session_expires_at")
		local claimId = requireString(body.claim.id, "response claim id")
		local claimToken = requireString(body.claim.token, "response claim token")
		local claimExpiresAt = requireFiniteNumber(body.claim.expires_at, "response claim expires_at")
		local flowUrl = safeHttpUrl(body.flow_url, claimToken)
	
		return self:restoreAccessFlowClaim({
			protocolVersion = 1,
			applicationId = self._applicationId,
			environment = self._environment,
			flowId = responseFlowId,
			sessionId = sessionId,
			sessionExpiresAt = sessionExpiresAt,
			claimId = claimId,
			claimToken = claimToken,
			claimExpiresAt = claimExpiresAt,
			nonce = nonce,
			flowUrl = flowUrl,
		})
	end
	
	local function parseClaimLicense(value: any): any
		if type(value) ~= "table" then
			fail("completed claim license is invalid")
		end
	
		local id = requireString(value.id, "license id")
		local key = value.key
		if key ~= nil then
			key = requireString(key, "license key")
		end
		local keyPrefix = requireString(value.key_prefix, "license key_prefix")
		local validFrom = requireFiniteNumber(value.valid_from, "license valid_from")
	
		local expiresAt = value.expires_at
		if expiresAt ~= nil then
			expiresAt = requireFiniteNumber(expiresAt, "license expires_at")
		end
	
		local maxDevices = value.max_devices
		if maxDevices ~= nil then
			maxDevices = requireFiniteNumber(maxDevices, "license max_devices")
			if maxDevices ~= math.floor(maxDevices) or maxDevices < 1 then
				fail("license max_devices is invalid")
			end
		end
	
		return {
			id = id,
			key = key,
			keyPrefix = keyPrefix,
			validFrom = validFrom,
			expiresAt = expiresAt,
			maxDevices = maxDevices,
			entitlements = copyStringArray(value.entitlements, "license entitlements"),
		}
	end
	
	function Client.pollAccessFlowClaim(self: any, claimValue: any): any
		local claim = self:restoreAccessFlowClaim(claimValue)
		if HostAdapter.nowSeconds(self._host) * 1000 >= claim.claimExpiresAt then
			fail("Access Flow claim has expired")
		end
	
		local response = request(self._host, {
			method = "GET",
			url = self._apiOrigin .. "/v1/access/claims/" .. claim.claimId,
			headers = {
				accept = "application/json",
				authorization = "Bearer " .. claim.claimToken,
			},
		})
		if response.status < 200 or response.status >= 300 then
			fail("Access Flow claim read failed with HTTP status " .. tostring(response.status))
		end
	
		local body = decodeJson(self._host, response.body)
		if body.ok ~= true then
			fail("Access Flow claim response is invalid")
		end
	
		local flowId = requireString(body.flow_id, "claim flow_id")
		local sessionId = requireString(body.session_id, "claim session_id")
		local claimExpiresAt = requireFiniteNumber(body.claim_expires_at, "claim claim_expires_at")
		if
			flowId ~= claim.flowId
			or sessionId ~= claim.sessionId
			or claimExpiresAt ~= claim.claimExpiresAt
		then
			fail("Access Flow claim response does not match the originating claim")
		end
	
		if body.status == "pending" then
			return {
				status = "pending",
				flowId = flowId,
				sessionId = sessionId,
				claimExpiresAt = claimExpiresAt,
			}
		end
		if body.status ~= "completed" then
			fail("Access Flow claim response has an invalid status")
		end
	
		local license = parseClaimLicense(body.license)
		local envelope = body.authorization
		if type(envelope) ~= "table" or type(envelope.grant) ~= "table" or type(envelope.signature) ~= "string" then
			fail("completed claim authorization is invalid")
		end
	
		local keysResponse = self:_listVerificationKeys()
		local verified = Verifier.verifySignedAuthorization(
			self._host,
			{
				applicationId = self._applicationId,
				environment = self._environment,
				maxClockSkewSeconds = self._maxClockSkewSeconds,
			},
			envelope,
			keysResponse,
			{
				nonce = claim.nonce,
				sessionId = claim.sessionId,
			}
		)
	
		if verified.decision == "allow" then
			if
				verified.code ~= "AUTHORIZED"
				or verified.licenseId ~= license.id
				or license.key == nil
				or not equalStringSets(verified.entitlements, license.entitlements)
			then
				fail("signed authorization does not match the issued license")
			end
		else
			if
				verified.code == "AUTHORIZED"
				or verified.licenseId ~= nil
				or license.key ~= nil
				or #verified.entitlements ~= 0
			then
				fail("signed denial contains inconsistent license data")
			end
		end
	
		return {
			status = "completed",
			flowId = flowId,
			sessionId = sessionId,
			claimExpiresAt = claimExpiresAt,
			decision = verified.decision,
			code = verified.code,
			license = license,
			authorization = envelope,
		}
	end
	
	
	local function nowMilliseconds(host: any): number
		return HostAdapter.nowSeconds(host) * 1000
	end
	
	local function requirePositiveFiniteNumber(value: any, name: string): number
		local numberValue = requireFiniteNumber(value, name)
		if numberValue <= 0 then
			fail(name .. " must be greater than zero")
		end
		return numberValue
	end
	
	function Client.waitForAccessFlowClaim(self: any, claimValue: any, options: any?): any
		local claim = self:restoreAccessFlowClaim(claimValue)
		local resolvedOptions = if options == nil then {} else options
		if type(resolvedOptions) ~= "table" then
			fail("waitForAccessFlowClaim options must be a table")
		end
	
		local sleep = resolvedOptions.sleep
		if type(sleep) ~= "function" then
			fail("waitForAccessFlowClaim requires a sleep(milliseconds) callback")
		end
	
		local intervalMs = if resolvedOptions.intervalMs == nil
			then 1000
			else requirePositiveFiniteNumber(resolvedOptions.intervalMs, "intervalMs")
		if intervalMs < 100 then
			fail("intervalMs must be at least 100 milliseconds")
		end
	
		local timeoutMs = resolvedOptions.timeoutMs
		if timeoutMs ~= nil then
			timeoutMs = requirePositiveFiniteNumber(timeoutMs, "timeoutMs")
		end
	
		local startedAt = nowMilliseconds(self._host)
		local timeoutAt = if timeoutMs == nil then claim.claimExpiresAt else startedAt + timeoutMs
	
		while true do
			local state = self:pollAccessFlowClaim(claim)
			if state.status == "completed" then
				return state
			end
	
			local currentTime = nowMilliseconds(self._host)
			if currentTime >= claim.claimExpiresAt then
				fail("Access Flow claim expired while waiting")
			end
			if currentTime >= timeoutAt then
				fail("timed out waiting for Access Flow claim completion")
			end
	
			local delayMs = math.min(intervalMs, claim.claimExpiresAt - currentTime, timeoutAt - currentTime)
			if delayMs <= 0 then
				fail("timed out waiting for Access Flow claim completion")
			end
	
			local ok = pcall(sleep, delayMs)
			if not ok then
				fail("sleep callback failed while waiting for Access Flow completion")
			end
		end
	end
	
	function Client.runAccessFlow(self: any, input: any, options: any?): any
		local resolvedOptions = if options == nil then {} else options
		if type(resolvedOptions) ~= "table" then
			fail("runAccessFlow options must be a table")
		end
	
		local openUrl = resolvedOptions.openUrl
		if type(openUrl) ~= "function" then
			fail("runAccessFlow requires an openUrl(url) callback")
		end
		if type(resolvedOptions.sleep) ~= "function" then
			fail("runAccessFlow requires a sleep(milliseconds) callback")
		end
		if resolvedOptions.onClaimCreated ~= nil and type(resolvedOptions.onClaimCreated) ~= "function" then
			fail("onClaimCreated must be a function")
		end
	
		local claim = self:createAccessFlowClaim(input)
	
		if resolvedOptions.onClaimCreated ~= nil then
			local ok = pcall(resolvedOptions.onClaimCreated, claim)
			if not ok then
				fail("onClaimCreated callback failed before browser launch")
			end
		end
	
		local okOpen = pcall(openUrl, claim.flowUrl)
		if not okOpen then
			fail("openUrl callback failed")
		end
	
		return self:waitForAccessFlowClaim(claim, {
			sleep = resolvedOptions.sleep,
			intervalMs = resolvedOptions.intervalMs,
			timeoutMs = resolvedOptions.timeoutMs,
		})
	end
	
	return table.freeze(Client)

end }

__mods["crypto/EdDSA/CSPRNG/Blake3"] = { dir = "crypto/EdDSA/CSPRNG", fn = function(require)
	--[=[
		Cryptography library: Blake3
		
		Sizes:
			Key: 32 bytes
			Output: variable
		
		Return type: string (hex)
		Example usage:
			local Message = buffer.fromstring("Hello World")
			local Key = buffer.fromstring(string.rep("k", 32))
			
			--------Standard Hash--------
			local Hash = Blake3.Digest(Message, 32)
			
			--------Keyed Hash--------
			local KeyedHash = Blake3.DigestKeyed(Key, Message, 32)
			
			--------Key Derivation--------
			local Context = buffer.fromstring("my context")
			local KeyDeriver = Blake3.DeriveKey(Context)
			local DerivedKey = KeyDeriver(Message, 32)
	--]=]

	--!strict
	--!optimize 2
	--!native

	local BLOCK_SIZE = 64
	local CV_SIZE = 32
	local EXTENDED_CV_SIZE = 64
	local MAX_STACK_DEPTH = 64
	local STACK_BUFFER_SIZE = MAX_STACK_DEPTH * CV_SIZE

	local CHUNK_START = 0x01
	local CHUNK_END = 0x02
	local PARENT_FLAG = 0x04
	local ROOT_FLAG = 0x08

	local INITIAL_VECTORS = buffer.create(CV_SIZE) do
		local IV = {
			0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
			0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19,
		}
		for Index, Value in ipairs(IV) do
			buffer.writeu32(INITIAL_VECTORS, (Index - 1) * 4, Value)
		end
	end

	local function Compress(Hash: buffer, MessageBlock: buffer, Counter: number, V14: number, V15: number, IsFull: boolean?): buffer
		local Hash00 = buffer.readu32(Hash, 0)
		local Hash01 = buffer.readu32(Hash, 4)
		local Hash02 = buffer.readu32(Hash, 8)
		local Hash03 = buffer.readu32(Hash, 12)
		local Hash04 = buffer.readu32(Hash, 16)
		local Hash05 = buffer.readu32(Hash, 20)
		local Hash06 = buffer.readu32(Hash, 24)
		local Hash07 = buffer.readu32(Hash, 28)

		local V00, V01, V02, V03 = Hash00, Hash01, Hash02, Hash03
		local V04, V05, V06, V07 = Hash04, Hash05, Hash06, Hash07
		local V08, V09, V10, V11 = 0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a

		local V12 = Counter % (2 ^ 32)
		local V13 = (Counter - V12) * (2 ^ -32)

		local M00 = buffer.readu32(MessageBlock, 0)
		local M01 = buffer.readu32(MessageBlock, 4)
		local M02 = buffer.readu32(MessageBlock, 8)
		local M03 = buffer.readu32(MessageBlock, 12)
		local M04 = buffer.readu32(MessageBlock, 16)
		local M05 = buffer.readu32(MessageBlock, 20)
		local M06 = buffer.readu32(MessageBlock, 24)
		local M07 = buffer.readu32(MessageBlock, 28)
		local M08 = buffer.readu32(MessageBlock, 32)
		local M09 = buffer.readu32(MessageBlock, 36)
		local M10 = buffer.readu32(MessageBlock, 40)
		local M11 = buffer.readu32(MessageBlock, 44)
		local M12 = buffer.readu32(MessageBlock, 48)
		local M13 = buffer.readu32(MessageBlock, 52)
		local M14 = buffer.readu32(MessageBlock, 56)
		local M15 = buffer.readu32(MessageBlock, 60)

		local Temp
		for Index = 1, 7 do
			V00 += V04 + M00; V12 = bit32.lrotate(bit32.bxor(V12, V00), 16)
			V08 += V12; V04 = bit32.lrotate(bit32.bxor(V04, V08), 20)
			V00 += V04 + M01; V12 = bit32.lrotate(bit32.bxor(V12, V00), 24)
			V08 += V12; V04 = bit32.lrotate(bit32.bxor(V04, V08), 25)

			V01 += V05 + M02; V13 = bit32.lrotate(bit32.bxor(V13, V01), 16)
			V09 += V13; V05 = bit32.lrotate(bit32.bxor(V05, V09), 20)
			V01 += V05 + M03; V13 = bit32.lrotate(bit32.bxor(V13, V01), 24)
			V09 += V13; V05 = bit32.lrotate(bit32.bxor(V05, V09), 25)

			V02 += V06 + M04; V14 = bit32.lrotate(bit32.bxor(V14, V02), 16)
			V10 += V14; V06 = bit32.lrotate(bit32.bxor(V06, V10), 20)
			V02 += V06 + M05; V14 = bit32.lrotate(bit32.bxor(V14, V02), 24)
			V10 += V14; V06 = bit32.lrotate(bit32.bxor(V06, V10), 25)

			V03 += V07 + M06; V15 = bit32.lrotate(bit32.bxor(V15, V03), 16)
			V11 += V15; V07 = bit32.lrotate(bit32.bxor(V07, V11), 20)
			V03 += V07 + M07; V15 = bit32.lrotate(bit32.bxor(V15, V03), 24)
			V11 += V15; V07 = bit32.lrotate(bit32.bxor(V07, V11), 25)

			V00 += V05 + M08; V15 = bit32.lrotate(bit32.bxor(V15, V00), 16)
			V10 += V15; V05 = bit32.lrotate(bit32.bxor(V05, V10), 20)
			V00 += V05 + M09; V15 = bit32.lrotate(bit32.bxor(V15, V00), 24)
			V10 += V15; V05 = bit32.lrotate(bit32.bxor(V05, V10), 25)

			V01 += V06 + M10; V12 = bit32.lrotate(bit32.bxor(V12, V01), 16)
			V11 += V12; V06 = bit32.lrotate(bit32.bxor(V06, V11), 20)
			V01 += V06 + M11; V12 = bit32.lrotate(bit32.bxor(V12, V01), 24)
			V11 += V12; V06 = bit32.lrotate(bit32.bxor(V06, V11), 25)

			V02 += V07 + M12; V13 = bit32.lrotate(bit32.bxor(V13, V02), 16)
			V08 += V13; V07 = bit32.lrotate(bit32.bxor(V07, V08), 20)
			V02 += V07 + M13; V13 = bit32.lrotate(bit32.bxor(V13, V02), 24)
			V08 += V13; V07 = bit32.lrotate(bit32.bxor(V07, V08), 25)

			V03 += V04 + M14; V14 = bit32.lrotate(bit32.bxor(V14, V03), 16)
			V09 += V14; V04 = bit32.lrotate(bit32.bxor(V04, V09), 20)
			V03 += V04 + M15; V14 = bit32.lrotate(bit32.bxor(V14, V03), 24)
			V09 += V14; V04 = bit32.lrotate(bit32.bxor(V04, V09), 25)

			if Index ~= 7 then
				Temp = M02
				M02 = M03
				M03 = M10
				M10 = M12
				M12 = M09
				M09 = M11
				M11 = M05
				M05 = M00
				M00 = Temp

				Temp = M06
				M06 = M04
				M04 = M07
				M07 = M13
				M13 = M14
				M14 = M15
				M15 = M08
				M08 = M01
				M01 = Temp
			end
		end

		if IsFull then
			local Result = buffer.create(EXTENDED_CV_SIZE)
			buffer.writeu32(Result, 0, bit32.bxor(V00, V08))
			buffer.writeu32(Result, 4, bit32.bxor(V01, V09))
			buffer.writeu32(Result, 8, bit32.bxor(V02, V10))
			buffer.writeu32(Result, 12, bit32.bxor(V03, V11))
			buffer.writeu32(Result, 16, bit32.bxor(V04, V12))
			buffer.writeu32(Result, 20, bit32.bxor(V05, V13))
			buffer.writeu32(Result, 24, bit32.bxor(V06, V14))
			buffer.writeu32(Result, 28, bit32.bxor(V07, V15))

			buffer.writeu32(Result, 32, bit32.bxor(V08, Hash00))
			buffer.writeu32(Result, 36, bit32.bxor(V09, Hash01))
			buffer.writeu32(Result, 40, bit32.bxor(V10, Hash02))
			buffer.writeu32(Result, 44, bit32.bxor(V11, Hash03))
			buffer.writeu32(Result, 48, bit32.bxor(V12, Hash04))
			buffer.writeu32(Result, 52, bit32.bxor(V13, Hash05))
			buffer.writeu32(Result, 56, bit32.bxor(V14, Hash06))
			buffer.writeu32(Result, 60, bit32.bxor(V15, Hash07))

			return Result
		else
			local Result = buffer.create(CV_SIZE)
			buffer.writeu32(Result, 0, bit32.bxor(V00, V08))
			buffer.writeu32(Result, 4, bit32.bxor(V01, V09))
			buffer.writeu32(Result, 8, bit32.bxor(V02, V10))
			buffer.writeu32(Result, 12, bit32.bxor(V03, V11))
			buffer.writeu32(Result, 16, bit32.bxor(V04, V12))
			buffer.writeu32(Result, 20, bit32.bxor(V05, V13))
			buffer.writeu32(Result, 24, bit32.bxor(V06, V14))
			buffer.writeu32(Result, 28, bit32.bxor(V07, V15))

			return Result
		end
	end

	local function ProcessMessage(InitialHashVector: buffer, Flags: number, Message: buffer, Length: number): buffer
		local MessageLength = buffer.len(Message)
		local StateCvs = buffer.create(STACK_BUFFER_SIZE)
		local StackSize = 0
		local StateCv = buffer.create(CV_SIZE)
		buffer.copy(StateCv, 0, InitialHashVector, 0, CV_SIZE)

		local StateCounter = 0
		local StateChunkNumber = 0
		local StateEndFlag = 0
		local StateStartFlag = CHUNK_START

		local BlockBuffer = buffer.create(BLOCK_SIZE)

		for BlockOffset = 0, MessageLength - BLOCK_SIZE - 1, BLOCK_SIZE do
			buffer.copy(BlockBuffer, 0, Message, BlockOffset, BLOCK_SIZE)
			local StateFlags = Flags + StateStartFlag + StateEndFlag

			StateCv = Compress(StateCv, BlockBuffer, StateCounter, BLOCK_SIZE, StateFlags)
			StateStartFlag = 0
			StateChunkNumber += 1

			if StateChunkNumber == 15 then
				StateEndFlag = CHUNK_END
			elseif StateChunkNumber == 16 then
				local MergeCv = StateCv
				local MergeAmount = StateCounter + 1

				while MergeAmount % 2 == 0 do
					StackSize = StackSize - 1
					local PopCv = buffer.create(CV_SIZE)
					buffer.copy(PopCv, 0, StateCvs, StackSize * CV_SIZE, CV_SIZE)

					local Block = buffer.create(EXTENDED_CV_SIZE)
					buffer.copy(Block, 0, PopCv, 0, CV_SIZE)
					buffer.copy(Block, CV_SIZE, MergeCv, 0, CV_SIZE)

					MergeCv = Compress(InitialHashVector, Block, 0, BLOCK_SIZE, Flags + PARENT_FLAG)
					MergeAmount = MergeAmount / 2
				end

				buffer.copy(StateCvs, StackSize * CV_SIZE, MergeCv, 0, CV_SIZE)
				StackSize = StackSize + 1
				buffer.copy(StateCv, 0, InitialHashVector, 0, CV_SIZE)
				StateStartFlag = CHUNK_START

				StateCounter += 1
				StateChunkNumber = 0
				StateEndFlag = 0
			end
		end

		local LastLength = MessageLength == 0 and 0 or ((MessageLength - 1) % BLOCK_SIZE + 1)
		local PaddedMessage = buffer.create(BLOCK_SIZE)

		if LastLength > 0 then
			buffer.copy(PaddedMessage, 0, Message, MessageLength - LastLength, LastLength)
		end

		local OutputCv: buffer
		local OutputBlock: buffer
		local OutputLength: number
		local OutputFlags: number

		if StateCounter > 0 then
			local StateFlags = Flags + StateStartFlag + CHUNK_END
			local MergeCv = Compress(StateCv, PaddedMessage, StateCounter, LastLength, StateFlags)

			for Index = StackSize, 2, -1 do
				local StackCv = buffer.create(CV_SIZE)
				buffer.copy(StackCv, 0, StateCvs, (Index - 1) * CV_SIZE, CV_SIZE)

				local Block = buffer.create(EXTENDED_CV_SIZE)
				buffer.copy(Block, 0, StackCv, 0, CV_SIZE)
				buffer.copy(Block, CV_SIZE, MergeCv, 0, CV_SIZE)

				MergeCv = Compress(InitialHashVector, Block, 0, BLOCK_SIZE, Flags + PARENT_FLAG)
			end

			OutputCv = InitialHashVector
			local FirstStackCv = buffer.create(CV_SIZE)
			buffer.copy(FirstStackCv, 0, StateCvs, 0, CV_SIZE)

			OutputBlock = buffer.create(EXTENDED_CV_SIZE)
			buffer.copy(OutputBlock, 0, FirstStackCv, 0, CV_SIZE)
			buffer.copy(OutputBlock, CV_SIZE, MergeCv, 0, CV_SIZE)

			OutputLength = BLOCK_SIZE
			OutputFlags = Flags + ROOT_FLAG + PARENT_FLAG
		else
			OutputCv = StateCv
			OutputBlock = PaddedMessage
			OutputLength = LastLength
			OutputFlags = Flags + StateStartFlag + CHUNK_END + ROOT_FLAG
		end

		local Output = buffer.create(Length)
		local OutputOffset = 0

		for Index = 0, Length // BLOCK_SIZE do
			local MessageDigest = Compress(OutputCv, OutputBlock, Index, OutputLength, OutputFlags, true)

			local BytesToCopy = math.min(BLOCK_SIZE, Length - OutputOffset)
			buffer.copy(Output, OutputOffset, MessageDigest, 0, BytesToCopy)
			OutputOffset += BytesToCopy

			if OutputOffset >= Length then
				break
			end
		end

		return Output
	end

	return function(Message: buffer, Length: number?): buffer
		return ProcessMessage(INITIAL_VECTORS, 0, Message, Length or 32)
	end

end }

__mods["crypto/EdDSA/CSPRNG/ChaCha20"] = { dir = "crypto/EdDSA/CSPRNG", fn = function(require)
	--[=[
		Cryptography library: ChaCha20
		
		Sizes:
			Nonce: 12 bytes
			Key: 16/32 bytes
		
		Return type: buffer
		Example usage:
			local Data = buffer.fromstring("Hello World")
			local Key = buffer.fromstring(string.rep("k", 32))
			local Nonce = buffer.fromstring(string.rep("n", 12))
			
			--------Usage Case 1--------
			local Encrypted = ChaCha20(Data, Key, Nonce)
			
			--------Usage Case 2--------
			local Decrypted = ChaCha20(Encrypted, Key, Nonce)
	--]=]

	--!strict
	--!native
	--!optimize 2

	local DWORD = 4
	local BLOCK_SIZE = 64
	local STATE_SIZE = 16

	local CHACHA20_NONCE_SIZE = 12
	local CHACHA20_KEY_SIZE_16 = 16
	local CHACHA20_KEY_SIZE_32 = 32

	local SIGMA_CONSTANTS = buffer.create(16) do
		local SigmaBytes = { string.byte("expand 32-byte k", 1, -1) }
		for Index, ByteValue in SigmaBytes do
			buffer.writeu8(SIGMA_CONSTANTS, Index - 1, ByteValue)
		end
	end

	local TAU_CONSTANTS = buffer.create(16) do
		local TauBytes = { string.byte("expand 16-byte k", 1, -1) }
		for Index, ByteValue in TauBytes do
			buffer.writeu8(TAU_CONSTANTS, Index - 1, ByteValue)
		end
	end

	local function ProcessBlock(InitialState: buffer, Rounds: number)
		local S0: number, S1: number, S2: number, S3: number, S4: number, S5: number, S6: number, S7: number, S8: number, S9: number, S10: number, S11: number, S12: number, S13: number, S14: number, S15: number =
			buffer.readu32(InitialState, 0), buffer.readu32(InitialState, 4),
			buffer.readu32(InitialState, 8), buffer.readu32(InitialState, 12),
			buffer.readu32(InitialState, 16), buffer.readu32(InitialState, 20),
			buffer.readu32(InitialState, 24), buffer.readu32(InitialState, 28),
			buffer.readu32(InitialState, 32), buffer.readu32(InitialState, 36),
			buffer.readu32(InitialState, 40), buffer.readu32(InitialState, 44),
			buffer.readu32(InitialState, 48), buffer.readu32(InitialState, 52),
			buffer.readu32(InitialState, 56), buffer.readu32(InitialState, 60)

		for Round = 1, Rounds do
			local IsOddRound = Round % 2 == 1

			if IsOddRound then
				S0 = bit32.bor(S0 + S4, 0); S12 = bit32.lrotate(bit32.bxor(S12, S0), 16)
				S8 = bit32.bor(S8 + S12, 0); S4 = bit32.lrotate(bit32.bxor(S4, S8), 12)
				S0 = bit32.bor(S0 + S4, 0); S12 = bit32.lrotate(bit32.bxor(S12, S0), 8)
				S8 = bit32.bor(S8 + S12, 0); S4 = bit32.lrotate(bit32.bxor(S4, S8), 7)

				S1 = bit32.bor(S1 + S5, 0); S13 = bit32.lrotate(bit32.bxor(S13, S1), 16)
				S9 = bit32.bor(S9 + S13, 0); S5 = bit32.lrotate(bit32.bxor(S5, S9), 12)
				S1 = bit32.bor(S1 + S5, 0); S13 = bit32.lrotate(bit32.bxor(S13, S1), 8)
				S9 = bit32.bor(S9 + S13, 0); S5 = bit32.lrotate(bit32.bxor(S5, S9), 7)

				S2 = bit32.bor(S2 + S6, 0); S14 = bit32.lrotate(bit32.bxor(S14, S2), 16)
				S10 = bit32.bor(S10 + S14, 0); S6 = bit32.lrotate(bit32.bxor(S6, S10), 12)
				S2 = bit32.bor(S2 + S6, 0); S14 = bit32.lrotate(bit32.bxor(S14, S2), 8)
				S10 = bit32.bor(S10 + S14, 0); S6 = bit32.lrotate(bit32.bxor(S6, S10), 7)

				S3 = bit32.bor(S3 + S7, 0); S15 = bit32.lrotate(bit32.bxor(S15, S3), 16)
				S11 = bit32.bor(S11 + S15, 0); S7 = bit32.lrotate(bit32.bxor(S7, S11), 12)
				S3 = bit32.bor(S3 + S7, 0); S15 = bit32.lrotate(bit32.bxor(S15, S3), 8)
				S11 = bit32.bor(S11 + S15, 0); S7 = bit32.lrotate(bit32.bxor(S7, S11), 7)
			else
				S0 = bit32.bor(S0 + S5, 0); S15 = bit32.lrotate(bit32.bxor(S15, S0), 16)
				S10 = bit32.bor(S10 + S15, 0); S5 = bit32.lrotate(bit32.bxor(S5, S10), 12)
				S0 = bit32.bor(S0 + S5, 0); S15 = bit32.lrotate(bit32.bxor(S15, S0), 8)
				S10 = bit32.bor(S10 + S15, 0); S5 = bit32.lrotate(bit32.bxor(S5, S10), 7)

				S1 = bit32.bor(S1 + S6, 0); S12 = bit32.lrotate(bit32.bxor(S12, S1), 16)
				S11 = bit32.bor(S11 + S12, 0); S6 = bit32.lrotate(bit32.bxor(S6, S11), 12)
				S1 = bit32.bor(S1 + S6, 0); S12 = bit32.lrotate(bit32.bxor(S12, S1), 8)
				S11 = bit32.bor(S11 + S12, 0); S6 = bit32.lrotate(bit32.bxor(S6, S11), 7)

				S2 = bit32.bor(S2 + S7, 0); S13 = bit32.lrotate(bit32.bxor(S13, S2), 16)
				S8 = bit32.bor(S8 + S13, 0); S7 = bit32.lrotate(bit32.bxor(S7, S8), 12)
				S2 = bit32.bor(S2 + S7, 0); S13 = bit32.lrotate(bit32.bxor(S13, S2), 8)
				S8 = bit32.bor(S8 + S13, 0); S7 = bit32.lrotate(bit32.bxor(S7, S8), 7)

				S3 = bit32.bor(S3 + S4, 0); S14 = bit32.lrotate(bit32.bxor(S14, S3), 16)
				S9 = bit32.bor(S9 + S14, 0); S4 = bit32.lrotate(bit32.bxor(S4, S9), 12)
				S3 = bit32.bor(S3 + S4, 0); S14 = bit32.lrotate(bit32.bxor(S14, S3), 8)
				S9 = bit32.bor(S9 + S14, 0); S4 = bit32.lrotate(bit32.bxor(S4, S9), 7)
			end
		end

		buffer.writeu32(InitialState, 0, buffer.readu32(InitialState, 0) + S0)
		buffer.writeu32(InitialState, 4, buffer.readu32(InitialState, 4) + S1)
		buffer.writeu32(InitialState, 8, buffer.readu32(InitialState, 8) + S2)
		buffer.writeu32(InitialState, 12, buffer.readu32(InitialState, 12) + S3)
		buffer.writeu32(InitialState, 16, buffer.readu32(InitialState, 16) + S4)
		buffer.writeu32(InitialState, 20, buffer.readu32(InitialState, 20) + S5)
		buffer.writeu32(InitialState, 24, buffer.readu32(InitialState, 24) + S6)
		buffer.writeu32(InitialState, 28, buffer.readu32(InitialState, 28) + S7)
		buffer.writeu32(InitialState, 32, buffer.readu32(InitialState, 32) + S8)
		buffer.writeu32(InitialState, 36, buffer.readu32(InitialState, 36) + S9)
		buffer.writeu32(InitialState, 40, buffer.readu32(InitialState, 40) + S10)
		buffer.writeu32(InitialState, 44, buffer.readu32(InitialState, 44) + S11)
		buffer.writeu32(InitialState, 48, buffer.readu32(InitialState, 48) + S12)
		buffer.writeu32(InitialState, 52, buffer.readu32(InitialState, 52) + S13)
		buffer.writeu32(InitialState, 56, buffer.readu32(InitialState, 56) + S14)
		buffer.writeu32(InitialState, 60, buffer.readu32(InitialState, 60) + S15)
	end

	local function InitializeState(Key: buffer, Nonce: buffer, Counter: number): buffer
		local KeyLength = buffer.len(Key)
		local State = buffer.create(STATE_SIZE * DWORD)

		local Constants = KeyLength == 32 and SIGMA_CONSTANTS or TAU_CONSTANTS

		buffer.copy(State, 0, Constants, 0, 16)

		buffer.copy(State, 16, Key, 0, math.min(KeyLength, 16))
		if KeyLength == 32 then
			buffer.copy(State, 32, Key, 16, 16)
		else
			buffer.copy(State, 32, Key, 0, 16)
		end

		buffer.writeu32(State, 48, Counter)
		buffer.copy(State, 52, Nonce, 0, 12)

		return State
	end

	local function ChaCha20(Data: buffer, Key: buffer, Nonce: buffer, Counter: number?, Rounds: number?): buffer
		if Data == nil then
			error("Data cannot be nil", 2)
		end

		if typeof(Data) ~= "buffer" then
			error(`Data must be a buffer, got {typeof(Data)}`, 2)
		end

		if Key == nil then
			error("Key cannot be nil", 2)
		end

		if typeof(Key) ~= "buffer" then
			error(`Key must be a buffer, got {typeof(Key)}`, 2)
		end

		local KeyLength = buffer.len(Key)
		if KeyLength ~= CHACHA20_KEY_SIZE_16 and KeyLength ~= CHACHA20_KEY_SIZE_32 then
			error(`Key must be {CHACHA20_KEY_SIZE_16} or {CHACHA20_KEY_SIZE_32} bytes long, got {KeyLength} bytes`, 2)
		end

		if Nonce == nil then
			error("Nonce cannot be nil", 2)
		end

		if typeof(Nonce) ~= "buffer" then
			error(`Nonce must be a buffer, got {typeof(Nonce)}`, 2)
		end

		local NonceLength = buffer.len(Nonce)
		if NonceLength ~= CHACHA20_NONCE_SIZE then
			error(`Nonce must be exactly {CHACHA20_NONCE_SIZE} bytes long, got {NonceLength} bytes`, 2)
		end

		if Counter then
			if typeof(Counter) ~= "number" then
				error(`Counter must be a number, got {typeof(Counter)}`, 2)
			end

			if Counter < 0 then
				error(`Counter cannot be negative, got {Counter}`, 2)
			end

			if Counter ~= math.floor(Counter) then
				error(`Counter must be an integer, got {Counter}`, 2)
			end

			if Counter >= 2^32 then
				error(`Counter must be less than 2^32, got {Counter}`, 2)
			end
		end

		if Rounds then
			if typeof(Rounds) ~= "number" then
				error(`Rounds must be a number, got {typeof(Rounds)}`, 2)
			end

			if Rounds <= 0 then
				error(`Rounds must be positive, got {Rounds}`, 2)
			end

			if Rounds ~= math.floor(Rounds) then
				error(`Rounds must be an integer, got {Rounds}`, 2)
			end

			if Rounds % 2 ~= 0 then
				error(`Rounds must be even, got {Rounds}`, 2)
			end
		end

		local BlockCounter = Counter or 1
		local BlockRounds = Rounds or 20

		local DataLength = buffer.len(Data)
		if DataLength == 0 then
			return buffer.create(0)
		end

		local Output = buffer.create(DataLength)

		local DataOffset = 0

		local State = InitializeState(Key, Nonce, BlockCounter)
		local StateBackup = buffer.create(64)
		buffer.copy(StateBackup, 0, State, 0)

		while DataOffset < DataLength do
			ProcessBlock(State, BlockRounds)

			local BytesToProcess = math.min(BLOCK_SIZE, DataLength - DataOffset)

			for Index = 0, BytesToProcess - 1 do
				local DataByte = buffer.readu8(Data, DataOffset + Index)
				local KeystreamByte = buffer.readu8(State, Index)
				buffer.writeu8(Output, DataOffset + Index, bit32.bxor(DataByte, KeystreamByte))
			end

			DataOffset += BytesToProcess
			BlockCounter += 1
			buffer.copy(State, 0, StateBackup, 0)
			buffer.writeu32(State, 48, BlockCounter)
		end

		return Output
	end

	return ChaCha20

end }

__mods["crypto/EdDSA/CSPRNG/Conversions"] = { dir = "crypto/EdDSA/CSPRNG", fn = function(require)
	--[=[
		Cryptography library: Conversions
		
		Return type: string / buffer
		Example Usage:
			local HexString = Conversions.ToHex(buffer.fromstring("Hello World"))
			local OriginalBuffer = Conversions.FromHex("48656c6c6f20576f726c64")
	--]=]

	--!strict
	--!optimize 2
	--!native

	local ENCODE_LOOKUP = buffer.create(256 * 2) do
		local HexChars = "0123456789abcdef"
		for Byte = 0, 255 do
			local HighNibble = bit32.rshift(Byte, 4)
			local LowNibble = Byte % 16

			local HighChar = string.byte(HexChars, HighNibble + 1)
			local LowChar = string.byte(HexChars, LowNibble + 1)

			local Combined = HighChar + bit32.lshift(LowChar, 8)
			buffer.writeu16(ENCODE_LOOKUP, Byte * 2, Combined)
		end
	end

	local DECODE_LOOKUP = buffer.create(65536 * 2) do
		for High = 0, 255 do
			for Low = 0, 255 do
				local HighNibble = 0
				local LowNibble = 0

				if High >= 48 and High <= 57 then
					HighNibble = High - 48
				elseif High >= 65 and High <= 70 then
					HighNibble = High - 55
				elseif High >= 97 and High <= 102 then
					HighNibble = High - 87
				else
					HighNibble = 0
				end

				if Low >= 48 and Low <= 57 then
					LowNibble = Low - 48
				elseif Low >= 65 and Low <= 70 then
					LowNibble = Low - 55
				elseif Low >= 97 and Low <= 102 then
					LowNibble = Low - 87
				else
					LowNibble = 0
				end

				local Combined = bit32.lshift(HighNibble, 4) + LowNibble
				local Index = bit32.lshift(Low, 8) + High
				buffer.writeu16(DECODE_LOOKUP, Index * 2, Combined)
			end
		end
	end

	local Conversions = {}

	function Conversions.ToHex(Buffer: buffer): string
		local Length = buffer.len(Buffer)
		local Hex = buffer.create(Length * 2)

		local Lookup = ENCODE_LOOKUP

		local Leftover = Length % 8
		local HexCursor = 0

		for Index = 0, Length - Leftover - 1, 8 do
			local Hex1 = buffer.readu16(Lookup, buffer.readu8(Buffer, Index) * 2)
			local Hex2 = buffer.readu16(Lookup, buffer.readu8(Buffer, Index + 1) * 2)
			local Hex3 = buffer.readu16(Lookup, buffer.readu8(Buffer, Index + 2) * 2)
			local Hex4 = buffer.readu16(Lookup, buffer.readu8(Buffer, Index + 3) * 2)
			local Hex5 = buffer.readu16(Lookup, buffer.readu8(Buffer, Index + 4) * 2)
			local Hex6 = buffer.readu16(Lookup, buffer.readu8(Buffer, Index + 5) * 2)
			local Hex7 = buffer.readu16(Lookup, buffer.readu8(Buffer, Index + 6) * 2)
			local Hex8 = buffer.readu16(Lookup, buffer.readu8(Buffer, Index + 7) * 2)

			buffer.writeu16(Hex, HexCursor, Hex1)
			buffer.writeu16(Hex, HexCursor + 2, Hex2)
			buffer.writeu16(Hex, HexCursor + 4, Hex3)
			buffer.writeu16(Hex, HexCursor + 6, Hex4)
			buffer.writeu16(Hex, HexCursor + 8, Hex5)
			buffer.writeu16(Hex, HexCursor + 10, Hex6)
			buffer.writeu16(Hex, HexCursor + 12, Hex7)
			buffer.writeu16(Hex, HexCursor + 14, Hex8)

			HexCursor += 16
		end

		for Index = Length - Leftover, Length - 1 do
			local HexPair = buffer.readu16(Lookup, buffer.readu8(Buffer, Index) * 2)
			buffer.writeu16(Hex, HexCursor, HexPair)
			HexCursor += 2
		end

		return buffer.tostring(Hex)
	end

	function Conversions.FromHex(Hex: string | buffer): buffer
		local BufferHex = if type(Hex) == "string" then buffer.fromstring(Hex) else Hex
		local Length = buffer.len(BufferHex)
		if Length % 2 ~= 0 then
			error(`Length must be even, got {Length}`)
		end

		local Buffer = buffer.create(bit32.rshift(Length, 1))
		local Leftover = Length % 16
		local BufferCursor = 0
		local Lookup = DECODE_LOOKUP

		for Index = 0, Length - Leftover - 1, 16 do
			local Pair1 = buffer.readu16(BufferHex, Index)
			local Pair2 = buffer.readu16(BufferHex, Index + 2)
			local Pair3 = buffer.readu16(BufferHex, Index + 4)
			local Pair4 = buffer.readu16(BufferHex, Index + 6)
			local Pair5 = buffer.readu16(BufferHex, Index + 8)
			local Pair6 = buffer.readu16(BufferHex, Index + 10)
			local Pair7 = buffer.readu16(BufferHex, Index + 12)
			local Pair8 = buffer.readu16(BufferHex, Index + 14)

			local Byte1 = buffer.readu16(Lookup, Pair1 * 2)
			local Byte2 = buffer.readu16(Lookup, Pair2 * 2)
			local Byte3 = buffer.readu16(Lookup, Pair3 * 2)
			local Byte4 = buffer.readu16(Lookup, Pair4 * 2)
			local Byte5 = buffer.readu16(Lookup, Pair5 * 2)
			local Byte6 = buffer.readu16(Lookup, Pair6 * 2)
			local Byte7 = buffer.readu16(Lookup, Pair7 * 2)
			local Byte8 = buffer.readu16(Lookup, Pair8 * 2)

			local Chunk1 = bit32.lshift(Byte4, 24) + bit32.lshift(Byte3, 16) + 
				bit32.lshift(Byte2, 8) + Byte1
			local Chunk2 = bit32.lshift(Byte8, 24) + bit32.lshift(Byte7, 16) + 
				bit32.lshift(Byte6, 8) + Byte5

			buffer.writeu32(Buffer, BufferCursor, Chunk1)
			buffer.writeu32(Buffer, BufferCursor + 4, Chunk2)
			BufferCursor += 8
		end

		for Index = Length - Leftover, Length - 1, 2 do
			local Pair = buffer.readu16(BufferHex, Index)
			local Byte = buffer.readu16(Lookup, Pair * 2)
			buffer.writeu8(Buffer, BufferCursor, Byte)
			BufferCursor += 1
		end

		return Buffer
	end

	return Conversions

end }

__mods["crypto/EdDSA/CSPRNG/init"] = { dir = "crypto/EdDSA/CSPRNG", fn = function(require)
	--[=[
		Cryptography library: Cryptographically Secure RNG
		
		Usage:
			local RandomFloat = CSPRNG.Random()
			local RandomInt = CSPRNG.RandomInt(1, 100)
			local RandomNumber = CSPRNG.RandomNumber(0.5, 10.5)
			local RandomBytes = CSPRNG.RandomBytes(32)
			local RandomHex = CSPRNG.RandomHex(16)
			local FastString = CSPRNG.RandomString(16, false)
			local FastBuffer = CSPRNG.RandomString(32, true)
			
			local Ed25519Clamped = CSPRNG.Ed25519ClampedBytes(SomeBuffer)
			local Ed25519Random = CSPRNG.Ed25519Random()
			
			CSPRNG.AddEntropyProvider(function)
			CSPRNG.RemoveEntropyProvider(function)
			CSPRNG.Reseed()
			
			CSPRNG.BytesLeft
	--]=]

	--!strict
	--!optimize 2
	--!native

	local Conversions = require("@self/Conversions")
	local ChaCha20 = require("@self/ChaCha20")
	local Blake3 = require("@self/Blake3")

	export type EntropyProvider = (BytesLeft: number) -> buffer?

	type CSPRNGModule = {
		BlockExpansion: boolean,

		SizeTarget: number,
		RekeyAfter: number,

		Key: buffer,
		Nonce: buffer,
		Buffer: buffer,

		Counter: number,
		BufferPosition: number,
		BufferSize: number,
		BytesLeft: number,

		EntropyProviders: { EntropyProvider },

		Reseed: (CustomEntropy: buffer?) -> (),
		AddEntropyProvider: (ProviderFunction: EntropyProvider) -> (),
		RemoveEntropyProvider: (ProviderFunction: EntropyProvider) -> (),

		Random: () -> number,
		RandomInt: (Min: number, Max: number?) -> number,
		RandomNumber: (Min: number, Max: number?) -> number,
		RandomBytes: (Count: number) -> buffer,
		RandomString: (Length: number, AsBuffer: boolean?) -> string | buffer,
		RandomHex: (Length: number) -> string,
		Ed25519ClampedBytes: (Input: buffer) -> buffer,
		Ed25519Random: () -> buffer,
	}

	local BLOCK_SIZE = 64
	local KEY_SIZE = 32
	local NONCE_SIZE = 12

	local CSPRNG: CSPRNGModule = {
		BlockExpansion = true,
		SizeTarget = 2048,
		RekeyAfter = 1024,

		Key = buffer.create(0),
		Nonce = buffer.create(0),
		Buffer = buffer.create(0),

		Counter = 0,
		BufferPosition = 0,
		BufferSize = 0,
		BytesLeft = 0,

		EntropyProviders = {},
	} :: CSPRNGModule

	local INPUT_BUFFER = buffer.create(BLOCK_SIZE)

	local function Reset()
		CSPRNG.Key = buffer.create(0)
		CSPRNG.Nonce = buffer.create(0)
		CSPRNG.Buffer = buffer.create(0)

		CSPRNG.Counter = 0
		CSPRNG.BufferPosition = 0
		CSPRNG.BufferSize = 0
	end

	local function GatherEntropy(CustomEntropy: buffer?): number
		local EntropyBuffers = buffer.create(1024)
		local Offset = 0

		local function WriteToBuffer(Source: buffer)
			local Size = buffer.len(Source)
			buffer.copy(EntropyBuffers, Offset, Source, 0, Size)
			Offset += Size
		end

		local CurrentTime = 1.234
		if tick then
			CurrentTime = tick()
			local TimeBuffer = buffer.create(8)
			buffer.writef64(TimeBuffer, 0, CurrentTime)
			WriteToBuffer(TimeBuffer)
		end

		local ClockTime = os.clock()
		local ClockBuffer = buffer.create(8)
		buffer.writef64(ClockBuffer, 0, ClockTime)
		WriteToBuffer(ClockBuffer)

		local UnixTime = os.time()
		local UnixBuffer = buffer.create(8)
		buffer.writeu32(UnixBuffer, 0, UnixTime % 0x100000000)
		buffer.writeu32(UnixBuffer, 4, math.floor(UnixTime / 0x100000000))
		WriteToBuffer(UnixBuffer)

		local DateTimeMillis = 5.678
		if DateTime then
			DateTimeMillis = DateTime.now().UnixTimestampMillis
			local DateTimeBuffer = buffer.create(8)
			buffer.writef64(DateTimeBuffer, 0, DateTimeMillis)
			WriteToBuffer(DateTimeBuffer)

			local DateTimePrecisionBuffer = buffer.create(16)
			buffer.writef32(DateTimePrecisionBuffer, 0, DateTimeMillis / 1000)
			buffer.writef32(DateTimePrecisionBuffer, 4, (DateTimeMillis % 1000) / 100)
			buffer.writef32(DateTimePrecisionBuffer, 8, DateTimeMillis / 86400000)
			buffer.writef32(DateTimePrecisionBuffer, 12, (DateTimeMillis * 0.001) % 1)
			WriteToBuffer(DateTimePrecisionBuffer)
		else
			WriteToBuffer(buffer.create(24))
		end

		local FracTimeBuffer = buffer.create(16)
		buffer.writef32(FracTimeBuffer, 0, ClockTime / 100)
		buffer.writef32(FracTimeBuffer, 4, CurrentTime / 1000)
		buffer.writef32(FracTimeBuffer, 8, (ClockTime * 12345.6789) % 1)
		buffer.writef32(FracTimeBuffer, 12, (CurrentTime * 98765.4321) % 1)
		WriteToBuffer(FracTimeBuffer)

		local NoiseBuffer = buffer.create(32)
		for Index = 0, 7 do
			local Noise1 = math.noise(ClockTime + Index, UnixTime + Index, ClockTime + UnixTime + Index)
			local Noise2 = math.noise(CurrentTime + Index * 0.1, DateTimeMillis * 0.0001 + Index, ClockTime * 1.5 + Index)
			local Noise3 = math.noise(UnixTime * 0.01 + Index, ClockTime + DateTimeMillis * 0.001, CurrentTime + Index * 2)
			local Noise4 =
				math.noise(DateTimeMillis * 0.00001 + Index, UnixTime + ClockTime + Index, CurrentTime * 0.1 + Index)

			buffer.writef32(NoiseBuffer, Index * 4, Noise1 + Noise2 + Noise3 + Noise4)
		end
		WriteToBuffer(NoiseBuffer)

		local BenchmarkTimings = buffer.create(32)
		for Index = 0, 7 do
			local StartTime = os.clock()
			local Sum = 0

			local Iterations = 50 + (Index * 25)
			for Iteration = 1, Iterations do
				Sum += Iteration * Iteration + math.sin(Iteration / 10) * math.cos(Iteration / 7)
			end

			local EndTime = os.clock()
			local TimingDelta = EndTime - StartTime
			buffer.writef32(BenchmarkTimings, Index * 4, TimingDelta * 1000000)
		end
		WriteToBuffer(BenchmarkTimings)

		local AllocTimings = buffer.create(24)
		for Index = 0, 5 do
			local AllocStart = os.clock()

			for AllocIndex = 1, 20 do
				local _TempBuf = buffer.create(64 + AllocIndex)
			end

			local AllocEnd = os.clock()
			buffer.writef32(AllocTimings, Index * 4, (AllocEnd - AllocStart) * 10000000)
		end
		WriteToBuffer(AllocTimings)

		local MicroTime = math.floor(CurrentTime * 1000000)
		local MicroTimeBuffer = buffer.create(8)
		buffer.writeu32(MicroTimeBuffer, 0, MicroTime % 0x100000000)
		buffer.writeu32(MicroTimeBuffer, 4, math.floor(MicroTime / 0x100000000))
		WriteToBuffer(MicroTimeBuffer)

		if game then
			local HttpService = game:FindService("HttpService") :: HttpService?
			if HttpService then
				WriteToBuffer(buffer.fromstring(HttpService:GenerateGUID(false)))
			end

			if game.JobId and #game.JobId > 0 then
				local JobIdBuffer = buffer.fromstring(game.JobId)
				WriteToBuffer(JobIdBuffer)
			end

			if game.PlaceId then
				local PlaceIdBuffer = buffer.create(8)
				buffer.writeu32(PlaceIdBuffer, 0, game.PlaceId % 0x100000000)
				buffer.writeu32(PlaceIdBuffer, 4, math.floor(game.PlaceId / 0x100000000))
				WriteToBuffer(PlaceIdBuffer)
			end

			if workspace and workspace.DistributedGameTime then
				local DistTimeBuffer = buffer.create(8)
				buffer.writef64(DistTimeBuffer, 0, workspace.DistributedGameTime)
				WriteToBuffer(DistTimeBuffer)

				local DistMicroTime = math.floor(workspace.DistributedGameTime * 1000000)
				local DistMicroBuffer = buffer.create(8)
				buffer.writeu32(DistMicroBuffer, 0, DistMicroTime % 0x100000000)
				buffer.writeu32(DistMicroBuffer, 4, math.floor(DistMicroTime / 0x100000000))
				WriteToBuffer(DistMicroBuffer)
			end
		end

		local AddressEntropy = buffer.create(128)
		for Index = 0, 7 do
			local TempTable = {}
			local TempFunc = function() end
			local TempBuffer = buffer.create(0)
			local TempUserdata = newproxy()

			local TableAddr = string.gsub(tostring(TempTable), "table: ", "")
			local FuncAddr = string.gsub(tostring(TempFunc), "function: ", "")
			local BufferAddr = string.gsub(tostring(TempBuffer), "buffer: ", "")
			local UserdataAddr = string.gsub(tostring(TempUserdata), "userdata: ", "")

			local TableHash = 0
			local ThreadHash = 0
			local FuncHash = 0
			local BufferHash = 0
			local UserdataHash = 0

			for AddrIndex = 1, #TableAddr do
				TableHash = bit32.bxor(TableHash, string.byte(TableAddr, AddrIndex)) * 31
			end

			if coroutine then
				local ThreadAddr = string.gsub(tostring(coroutine.create(function() end)), "thread: ", "")
				for AddrIndex = 1, #ThreadAddr do
					ThreadHash = bit32.bxor(ThreadHash, string.byte(ThreadAddr, AddrIndex)) * 31
				end
			end

			for AddrIndex = 1, #FuncAddr do
				FuncHash = bit32.bxor(FuncHash, string.byte(FuncAddr, AddrIndex)) * 37
			end
			for AddrIndex = 1, #BufferAddr do
				BufferHash = bit32.bxor(BufferHash, string.byte(BufferAddr, AddrIndex)) * 41
			end
			for AddrIndex = 1, #UserdataAddr do
				UserdataHash = bit32.bxor(UserdataHash, string.byte(UserdataAddr, AddrIndex)) * 43
			end

			buffer.writeu32(AddressEntropy, Index * 16, TableHash)
			buffer.writeu32(AddressEntropy, Index * 16 + 4, ThreadHash)
			buffer.writeu32(AddressEntropy, Index * 16 + 8, FuncHash)
			buffer.writeu32(AddressEntropy, Index * 16 + 12, bit32.bxor(BufferHash, UserdataHash))
		end
		WriteToBuffer(AddressEntropy)

		local function AddExtraEntropy(Entropy: buffer?, Warn: boolean, Provider: string?)
			if not Entropy then
				return
			end

			local BytesLeft = 1024 - Offset

			if BytesLeft > 0 then
				local Extra = buffer.len(Entropy) - BytesLeft
				local Truncated = math.min(BytesLeft, buffer.len(Entropy))

				if Extra > 0 and Warn and Provider then
					warn(
						`CSPRNG: {Provider} returned {Extra} bytes more than available and was truncated to {Truncated} bytes`
					)
				end

				buffer.copy(EntropyBuffers, Offset, Entropy, 0, Truncated)
				Offset += Truncated
			end
		end

		for Index, Provider in CSPRNG.EntropyProviders do
			local BytesLeft = 1024 - Offset
			if BytesLeft > 0 then
				local Success: boolean, ExtraEntropy: buffer? = pcall(Provider, BytesLeft)
				if not Success then
					warn(`CSPRNG Provider errored with {ExtraEntropy}`)
				end

				AddExtraEntropy(ExtraEntropy, true, `Entropy Provider #{Index}`)
			end
		end

		if CustomEntropy then
			AddExtraEntropy(CustomEntropy, false)
		end

		local KeyMaterial = Blake3(EntropyBuffers, KEY_SIZE + NONCE_SIZE)

		CSPRNG.Key = buffer.create(KEY_SIZE)
		buffer.copy(CSPRNG.Key, 0, KeyMaterial, 0, KEY_SIZE)

		CSPRNG.Nonce = buffer.create(NONCE_SIZE)
		buffer.copy(CSPRNG.Nonce, 0, KeyMaterial, KEY_SIZE, NONCE_SIZE)

		return buffer.len(EntropyBuffers) - Offset
	end

	local function GenerateBlock()
		buffer.fill(INPUT_BUFFER, 0, 0, BLOCK_SIZE)
		local ChaChaOutput = ChaCha20(INPUT_BUFFER, CSPRNG.Key, CSPRNG.Nonce, CSPRNG.Counter, 20)
		local RekeyThreshold = math.max(math.floor(CSPRNG.RekeyAfter), 2)
		local SizeTargetClamped = math.clamp(math.floor(CSPRNG.SizeTarget), 64, 4294967295)

		CSPRNG.Buffer = if CSPRNG.BlockExpansion then Blake3(ChaChaOutput, SizeTargetClamped) else ChaChaOutput
		CSPRNG.BufferPosition = 0
		CSPRNG.BufferSize = buffer.len(CSPRNG.Buffer)
		CSPRNG.Counter += 1

		if CSPRNG.Counter % RekeyThreshold == 0 then
			GatherEntropy()
			CSPRNG.Counter = 0
		end
	end

	local function GetBytes(Count: number): buffer
		local Result = buffer.create(Count)
		local ResultPosition = 0

		while ResultPosition < Count do
			if CSPRNG.BufferPosition >= CSPRNG.BufferSize then
				GenerateBlock()
			end

			local BytesNeeded = Count - ResultPosition
			local BytesAvailable = CSPRNG.BufferSize - CSPRNG.BufferPosition
			local BytesToCopy = math.min(BytesNeeded, BytesAvailable)

			buffer.copy(Result, ResultPosition, CSPRNG.Buffer, CSPRNG.BufferPosition, BytesToCopy)
			ResultPosition += BytesToCopy
			CSPRNG.BufferPosition += BytesToCopy
		end

		return Result
	end

	local function GetFloat(): number
		if CSPRNG.BufferPosition + 8 > CSPRNG.BufferSize then
			GenerateBlock()
		end

		local Value1 = buffer.readu32(CSPRNG.Buffer, CSPRNG.BufferPosition)
		local Value2 = buffer.readu32(CSPRNG.Buffer, CSPRNG.BufferPosition + 4)
		CSPRNG.BufferPosition += 8

		local High = bit32.rshift(Value1, 5)
		local Low = bit32.rshift(Value2, 6)

		return (High * 67108864.0 + Low) / 9007199254740992.0
	end

	local function GetIntRange(Min: number, Max: number): number
		local Range = Max - Min + 1
		local MaxUInt32 = 0xFFFFFFFF
		local Limit = MaxUInt32 - (MaxUInt32 % Range)

		if CSPRNG.BufferPosition + 4 > CSPRNG.BufferSize then
			GenerateBlock()
		end

		local Value = buffer.readu32(CSPRNG.Buffer, CSPRNG.BufferPosition)
		CSPRNG.BufferPosition += 4

		if bit32.band(Range, Range - 1) == 0 then
			return Min + bit32.band(Value, Range - 1)
		else
			while Value >= Limit do
				if CSPRNG.BufferPosition + 4 > CSPRNG.BufferSize then
					GenerateBlock()
				end
				Value = buffer.readu32(CSPRNG.Buffer, CSPRNG.BufferPosition)
				CSPRNG.BufferPosition += 4
			end

			return Min + (Value % Range)
		end
	end

	local function GetNumberRange(Min: number, Max: number): number
		if Min > Max then
			Min, Max = Max, Min
		end

		local Range = Max - Min
		if Range <= 0 then
			return Min
		end

		return Min + (GetFloat() * Range)
	end

	local function GetRandomString(Length: number, AsBuffer: boolean?): string | buffer
		local Characters = buffer.create(Length)

		for Index = 0, Length - 1 do
			buffer.writeu8(Characters, Index, GetIntRange(36, 122))
		end

		return if AsBuffer then Characters else buffer.tostring(Characters)
	end

	local function GetEd25519RandomBytes(): buffer
		local Output = buffer.create(32)

		for Index = 0, 31 do
			buffer.writeu8(Output, Index, GetIntRange(0, 255))
		end

		return Output
	end

	local function GetEd25519ClampedBytes(Input: buffer): buffer
		local Output = buffer.create(32)
		buffer.copy(Output, 0, Input, 0, 32)

		local FirstByte = buffer.readu8(Output, 0)
		FirstByte = bit32.band(FirstByte, 0xF8)
		buffer.writeu8(Output, 0, FirstByte)

		local LastByte = buffer.readu8(Output, 31)
		LastByte = bit32.band(LastByte, 0x7F)
		LastByte = bit32.bor(LastByte, 0x40)
		buffer.writeu8(Output, 31, LastByte)

		local HasVariation = false
		local FirstMiddleByte = buffer.readu8(Output, 1)
		for Index = 2, 30 do
			if buffer.readu8(Output, Index) ~= FirstMiddleByte then
				HasVariation = true
				break
			end
		end

		if not HasVariation then
			buffer.writeu8(Output, 15, bit32.bxor(FirstMiddleByte, 0x55))
		end

		return Output
	end

	local function GetHexString(Length: number): string
		local BytesNeeded = Length / 2
		local Bytes = GetBytes(BytesNeeded)
		local Hex = Conversions.ToHex(Bytes)

		return Hex
	end

	function CSPRNG.AddEntropyProvider(ProviderFunction: EntropyProvider)
		table.insert(CSPRNG.EntropyProviders, ProviderFunction)
	end

	function CSPRNG.RemoveEntropyProvider(ProviderFunction: EntropyProvider)
		for Index = #CSPRNG.EntropyProviders, 1, -1 do
			if CSPRNG.EntropyProviders[Index] == ProviderFunction then
				table.remove(CSPRNG.EntropyProviders, Index)
				break
			end
		end
	end

	function CSPRNG.Random(): number
		return GetFloat()
	end

	local function ValidateArgument(Name: string, Value: any, Integer: boolean, Optional: boolean): (boolean, string?)
		if Value == nil then
			if Optional then
				return true, nil
			end

			return false, `{Name} must be a number`
		end

		if type(Value) ~= "number" then
			return false, `{Name} must be a number, got {typeof(Value)}`
		end

		if not Value then
			return true, nil
		end

		if not math.isfinite(Value) then
			local Type = if math.isnan(Value) then "NaN" else "inf"

			return false, `{Name} must be a finite number, got {Type}`
		end

		if Integer and Value % 1 ~= 0 then
			return false, `{Name} must be an integer, got {Value}`
		end

		return true, nil
	end

	function CSPRNG.RandomInt(Min: number, Max: number?): number
		assert(ValidateArgument("Min", Min, true, false))
		assert(ValidateArgument("Max", Max, true, true))

		if Max then
			if Max < Min then
				error(`Max ({Max}) can't be less than Min ({Min})`, 2)
			elseif Max == Min then
				error(`Max ({Max}) can't be equal to Min ({Min})`, 2)
			end
		end

		local ActualMax: number
		local ActualMin: number

		if Max == nil then
			if Min < 1 then
				error(`When passing one argument, Min must be at least 1, got {Min}`, 2)
			end

			ActualMax = Min
			ActualMin = 1
		else
			ActualMax = Max
			ActualMin = Min
		end

		return GetIntRange(ActualMin, ActualMax)
	end

	function CSPRNG.RandomNumber(Min: number, Max: number?): number
		assert(ValidateArgument("Min", Min, false, false))
		assert(ValidateArgument("Max", Max, false, true))

		if Max then
			if Max < Min then
				error(`Max ({Max}) must be bigger than Min ({Min})`, 2)
			end

			if Max == Min then
				error(`Max ({Max}) can't be equal to Min ({Min})`, 2)
			end
		end

		local ActualMax: number
		local ActualMin: number

		if Max == nil then
			if Min <= 0 then
				error(`When passing one argument, Min must be more than 0, got {Min}`, 2)
			end

			ActualMax = Min
			ActualMin = 0
		else
			ActualMax = Max
			ActualMin = Min
		end

		return GetNumberRange(ActualMin, ActualMax)
	end

	function CSPRNG.RandomBytes(Count: number): buffer
		if type(Count) ~= "number" then
			error(`Count must be a number, got {typeof(Count)}`, 2)
		end

		if Count <= 0 then
			error(`Count must be bigger than 0, got {Count}`, 2)
		end

		if Count % 1 ~= 0 then
			error("Count must be an integer", 2)
		end

		return GetBytes(Count)
	end

	function CSPRNG.RandomString(Length: number, AsBuffer: boolean?): string | buffer
		assert(ValidateArgument("Length", Length, true, false))

		if Length <= 0 then
			error(`Length must be bigger than 0, got {Length}`, 2)
		end

		if AsBuffer ~= nil and type(AsBuffer) ~= "boolean" then
			error(`AsBuffer must be a boolean or nil, got {typeof(AsBuffer)}`, 2)
		end

		return GetRandomString(Length, AsBuffer)
	end

	function CSPRNG.RandomHex(Length: number): string
		assert(ValidateArgument("Length", Length, true, false))

		if Length <= 0 then
			error(`Length must be bigger than 0, got {Length}`, 2)
		end

		if Length % 2 ~= 0 then
			error(`Length must be even, got {Length}`, 2)
		end

		return GetHexString(Length)
	end

	function CSPRNG.Ed25519ClampedBytes(Input: buffer): buffer
		if type(Input) ~= "buffer" then
			error(`Input must be a buffer, got {typeof(Input)}`, 2)
		end

		return GetEd25519ClampedBytes(Input)
	end

	function CSPRNG.Ed25519Random(): buffer
		return GetEd25519ClampedBytes(GetEd25519RandomBytes())
	end

	function CSPRNG.Reseed(CustomEntropy: buffer?)
		if CustomEntropy ~= nil and type(CustomEntropy) ~= "buffer" then
			error(`CustomEntropy must be a buffer or nil, got {typeof(CustomEntropy)}`, 2)
		end

		Reset()
		GatherEntropy(CustomEntropy)
	end

	CSPRNG.BytesLeft = GatherEntropy()
	GenerateBlock()

	return CSPRNG

end }

__mods["crypto/EdDSA/Curve25519"] = { dir = "crypto/EdDSA", fn = function(require)
	--[=[
		Cryptography library: Curve25519 Montgomery

		Return type: varies by function
		Example usage:
			local Curve25519 = require("Curve25519")
			local FieldQuadratic = require("FieldQuadratic")

			--------Usage Case 1: Point multiplication--------
			local BasePoint = Curve25519.G
			local SomeScalar = FieldQuadratic.Decode(ScalarBytes)
			local ScalarBits, BitCount = FieldQuadratic.Bits(SomeScalar)
			local Result = Curve25519.Ladder8(BasePoint, ScalarBits, BitCount)

			--------Usage Case 2: Encode/decode points--------
			local EncodedPoint = Curve25519.Encode(Curve25519.Scale(Result))
			local DecodedPoint = Curve25519.Decode(EncodedPoint)
	--]=]

	--!strict
	--!optimize 2
	--!native

	local FieldPrime = require("./FieldPrime")
	local CSPRNG = require("./CSPRNG")

	local MONTGOMERY_POINT_SIZE = 208
	local COORD_SIZE = 104

	local function GetMontgomeryCoord(Point: buffer, Index: number): buffer
		local Coord = buffer.create(COORD_SIZE)
		buffer.copy(Coord, 0, Point, Index * COORD_SIZE, COORD_SIZE)

		return Coord
	end

	local function Double(PointToDouble: buffer): buffer
		local CoordX = GetMontgomeryCoord(PointToDouble, 0)
		local CoordZ = GetMontgomeryCoord(PointToDouble, 1)

		local SumXZ = FieldPrime.Add(CoordX, CoordZ)
		local SumSquared = FieldPrime.Square(SumXZ)
		local DiffXZ = FieldPrime.Sub(CoordX, CoordZ)
		local DiffSquared = FieldPrime.Square(DiffXZ)
		local Difference = FieldPrime.Sub(SumSquared, DiffSquared)
		local NewX = FieldPrime.Mul(SumSquared, DiffSquared)
		local NewZ = FieldPrime.Mul(Difference, FieldPrime.Add(DiffSquared, FieldPrime.KMul(Difference, 121666)))

		local Point = buffer.create(MONTGOMERY_POINT_SIZE)
		buffer.copy(Point, 0 * COORD_SIZE, NewX, 0, COORD_SIZE)
		buffer.copy(Point, 1 * COORD_SIZE, NewZ, 0, COORD_SIZE)

		return Point
	end

	local function LadderStep(DifferencePoint: buffer, Point1: buffer, Point2: buffer): (buffer, buffer)
		local DiffX = GetMontgomeryCoord(DifferencePoint, 0)
		local DiffZ = GetMontgomeryCoord(DifferencePoint, 1)
		local X1 = GetMontgomeryCoord(Point1, 0)
		local Z1 = GetMontgomeryCoord(Point1, 1)
		local X2 = GetMontgomeryCoord(Point2, 0)
		local Z2 = GetMontgomeryCoord(Point2, 1)

		local SumA = FieldPrime.Add(X1, Z1)
		local SumSquaredAA = FieldPrime.Square(SumA)
		local DiffB = FieldPrime.Sub(X1, Z1)
		local DiffSquaredBB = FieldPrime.Square(DiffB)

		local DifferenceE = FieldPrime.Sub(SumSquaredAA, DiffSquaredBB)
		local DiffD = FieldPrime.Sub(X2, Z2)
		local CrossDA = FieldPrime.Mul(DiffD, SumA)
		local SumC = FieldPrime.Add(X2, Z2)
		local CrossCB = FieldPrime.Mul(SumC, DiffB)

		local NewX4 = FieldPrime.Mul(DiffZ, FieldPrime.Square(FieldPrime.Add(CrossDA, CrossCB)))
		local NewZ4 = FieldPrime.Mul(DiffX, FieldPrime.Square(FieldPrime.Sub(CrossDA, CrossCB)))
		local NewX3 = FieldPrime.Mul(SumSquaredAA, DiffSquaredBB)
		local NewZ3 = FieldPrime.Mul(DifferenceE, FieldPrime.Add(DiffSquaredBB, FieldPrime.KMul(DifferenceE, 121666)))

		local Point = buffer.create(MONTGOMERY_POINT_SIZE)
		buffer.copy(Point, 0 * COORD_SIZE, NewX3, 0, COORD_SIZE)
		buffer.copy(Point, 1 * COORD_SIZE, NewZ3, 0, COORD_SIZE)

		local SecondPoint = buffer.create(MONTGOMERY_POINT_SIZE)
		buffer.copy(SecondPoint, 0 * COORD_SIZE, NewX4, 0, COORD_SIZE)
		buffer.copy(SecondPoint, 1 * COORD_SIZE, NewZ4, 0, COORD_SIZE)

		return Point, SecondPoint
	end

	local function Ladder(DifferencePoint: buffer, ScalarBits: buffer, ScalarBitCount: number): buffer
		local CurrentP = buffer.create(MONTGOMERY_POINT_SIZE)
		buffer.copy(CurrentP, 0 * COORD_SIZE, FieldPrime.Num(1), 0, COORD_SIZE)
		buffer.copy(CurrentP, 1 * COORD_SIZE, FieldPrime.Num(0), 0, COORD_SIZE)

		local CurrentQ = buffer.create(MONTGOMERY_POINT_SIZE)
		buffer.copy(CurrentQ, 0, DifferencePoint, 0, MONTGOMERY_POINT_SIZE)

		local LadderStep = LadderStep

		for BitIndex = ScalarBitCount, 1, -1 do
			local BitValue = buffer.readf64(ScalarBits, (BitIndex - 1) * 8)
			if BitValue == 0 then
				CurrentP, CurrentQ = LadderStep(DifferencePoint, CurrentP, CurrentQ)
			else
				CurrentQ, CurrentP = LadderStep(DifferencePoint, CurrentQ, CurrentP)
			end
		end

		return CurrentP
	end

	local Curve25519 = {}

	function Curve25519.DifferentialAdd(DifferencePoint: buffer, Point1: buffer, Point2: buffer): buffer
		local DiffX = GetMontgomeryCoord(DifferencePoint, 0)
		local DiffZ = GetMontgomeryCoord(DifferencePoint, 1)
		local X1 = GetMontgomeryCoord(Point1, 0)
		local Z1 = GetMontgomeryCoord(Point1, 1)
		local X2 = GetMontgomeryCoord(Point2, 0)
		local Z2 = GetMontgomeryCoord(Point2, 1)

		local SumA = FieldPrime.Add(X1, Z1)
		local DiffB = FieldPrime.Sub(X1, Z1)
		local SumC = FieldPrime.Add(X2, Z2)
		local DiffD = FieldPrime.Sub(X2, Z2)
		local CrossDA = FieldPrime.Mul(DiffD, SumA)
		local CrossCB = FieldPrime.Mul(SumC, DiffB)

		local NewX = FieldPrime.Mul(DiffZ, FieldPrime.Square(FieldPrime.Add(CrossDA, CrossCB)))
		local NewZ = FieldPrime.Mul(DiffX, FieldPrime.Square(FieldPrime.Sub(CrossDA, CrossCB)))

		local Point = buffer.create(MONTGOMERY_POINT_SIZE)
		buffer.copy(Point, 0 * COORD_SIZE, NewX, 0, COORD_SIZE)
		buffer.copy(Point, 1 * COORD_SIZE, NewZ, 0, COORD_SIZE)

		return Point
	end

	function Curve25519.Decode(EncodedBuffer: buffer): buffer
		local Point = buffer.create(MONTGOMERY_POINT_SIZE)
		buffer.copy(Point, 0 * COORD_SIZE, FieldPrime.Decode(EncodedBuffer), 0, COORD_SIZE)
		buffer.copy(Point, 1 * COORD_SIZE, FieldPrime.Num(1), 0, COORD_SIZE)

		return Point
	end

	function Curve25519.Prac(BasePoint: buffer, PracRuleset: {any}): (buffer?, buffer?, buffer?)
		local DifferentialAdd = Curve25519.DifferentialAdd
		local RandomBuffer = CSPRNG.Ed25519Random()
		local RandomFactor = FieldPrime.Decode(RandomBuffer)

		local BaseX = GetMontgomeryCoord(BasePoint, 0)
		local BaseZ = GetMontgomeryCoord(BasePoint, 1)
		local RandomizedA = buffer.create(MONTGOMERY_POINT_SIZE)
		buffer.copy(RandomizedA, 0 * COORD_SIZE, FieldPrime.Mul(BaseX, RandomFactor), 0, COORD_SIZE)
		buffer.copy(RandomizedA, 1 * COORD_SIZE, FieldPrime.Mul(BaseZ, RandomFactor), 0, COORD_SIZE)

		RandomizedA = Double(Double(Double(RandomizedA)))

		local AZ = GetMontgomeryCoord(RandomizedA, 1)
		if FieldPrime.Eqz(AZ) then
			return nil, nil, nil
		end

		RandomizedA = Ladder(RandomizedA, PracRuleset[1], PracRuleset[2])

		local Rules: buffer = PracRuleset[3]
		local RuleCount: number = PracRuleset[4]
		if RuleCount == 0 then
			return RandomizedA, nil, nil
		end

		local CurrentB, CurrentC
		local FirstRule = buffer.readf64(Rules, (RuleCount - 1) * 8)
		if FirstRule == 2 then
			local DoubledA = Double(RandomizedA)
			RandomizedA, CurrentB, CurrentC = DifferentialAdd(RandomizedA, DoubledA, RandomizedA), RandomizedA, DoubledA
		elseif FirstRule == 3 or FirstRule == 5 then
			RandomizedA, CurrentB, CurrentC = Double(RandomizedA), RandomizedA, RandomizedA
		elseif FirstRule == 6 then
			local DoubledA = Double(RandomizedA)
			local TripledA = DifferentialAdd(RandomizedA, DoubledA, RandomizedA)
			RandomizedA, CurrentB, CurrentC = Double(TripledA), RandomizedA, DifferentialAdd(RandomizedA, TripledA, DoubledA)
		elseif FirstRule == 7 then
			local DoubledA = Double(RandomizedA)
			local TripledA = DifferentialAdd(RandomizedA, DoubledA, RandomizedA)
			local QuadrupleA = Double(DoubledA)
			RandomizedA, CurrentB, CurrentC = DifferentialAdd(TripledA, QuadrupleA, RandomizedA), RandomizedA, QuadrupleA
		elseif FirstRule == 8 then
			local DoubledA = Double(RandomizedA)
			local TripledA = DifferentialAdd(RandomizedA, DoubledA, RandomizedA)
			RandomizedA, CurrentB, CurrentC = Double(DoubledA), RandomizedA, TripledA
		else
			RandomizedA, CurrentB, CurrentC = RandomizedA, Double(RandomizedA), RandomizedA
		end

		if not CurrentC then
			return nil, nil, nil
		end

		for RuleIndex = RuleCount - 1, 1, -1 do
			local CurrentRule = buffer.readf64(Rules, (RuleIndex - 1) * 8)
			if CurrentRule == 0 then
				RandomizedA, CurrentB = CurrentB, RandomizedA
			elseif CurrentRule == 1 then
				local SumAB = DifferentialAdd(CurrentC, RandomizedA, CurrentB)
				RandomizedA, CurrentB = DifferentialAdd(CurrentB, SumAB, RandomizedA), DifferentialAdd(RandomizedA, SumAB, CurrentB)
			elseif CurrentRule == 2 then
				RandomizedA, CurrentC = DifferentialAdd(CurrentB, DifferentialAdd(CurrentC, RandomizedA, CurrentB), RandomizedA), Double(RandomizedA)
			elseif CurrentRule == 3 then
				RandomizedA, CurrentC = DifferentialAdd(CurrentC, RandomizedA, CurrentB), RandomizedA
			elseif CurrentRule == 5 then
				RandomizedA, CurrentC = Double(RandomizedA), DifferentialAdd(CurrentB, RandomizedA, CurrentC)
			elseif CurrentRule == 6 then
				local SumAB = DifferentialAdd(CurrentC, RandomizedA, CurrentB)
				local DoubledSumAABB = Double(SumAB)
				RandomizedA, CurrentC = DifferentialAdd(SumAB, DoubledSumAABB, SumAB), DifferentialAdd(DifferentialAdd(RandomizedA, SumAB, CurrentB), DoubledSumAABB, RandomizedA)
			elseif CurrentRule == 7 then
				local SumAB = DifferentialAdd(CurrentC, RandomizedA, CurrentB)
				local DoubleAAB = DifferentialAdd(CurrentB, SumAB, RandomizedA)
				RandomizedA, CurrentC = DifferentialAdd(RandomizedA, DoubleAAB, SumAB), DifferentialAdd(SumAB, DoubleAAB, RandomizedA)
			elseif CurrentRule == 8 then
				local DoubledA = Double(RandomizedA)
				RandomizedA, CurrentC = DifferentialAdd(CurrentC, DoubledA, DifferentialAdd(CurrentC, RandomizedA, CurrentB)), DifferentialAdd(RandomizedA, DoubledA, RandomizedA)
			else
				CurrentB, CurrentC = Double(CurrentB), DifferentialAdd(RandomizedA, CurrentC, CurrentB)
			end
		end

		return RandomizedA, CurrentB, CurrentC
	end

	local Point = buffer.create(MONTGOMERY_POINT_SIZE)
	buffer.copy(Point, 0 * COORD_SIZE, FieldPrime.Num(9), 0, COORD_SIZE)
	buffer.copy(Point, 1 * COORD_SIZE, FieldPrime.Num(1), 0, COORD_SIZE)
	Curve25519.G = Point

	return Curve25519

end }

__mods["crypto/EdDSA/Edwards25519"] = { dir = "crypto/EdDSA", fn = function(require)
	--[=[
		Cryptography library: Edwards25519

		Return type: varies by function
		Example usage:
			local Edwards = require("Edwards25519")
			local FieldQuadratic = require("FieldQuadratic")

			--------Usage Case 1: Point addition--------
			local Point1 = Edwards.Decode(SomeEncodedBuffer)
			local Point2 = Edwards.Decode(AnotherEncodedBuffer)
			local NielsPoint2 = Edwards.Niels(Point2)
			local Sum = Edwards.Add(Point1, NielsPoint2)

			--------Usage Case 2: Scalar multiplication with buffer-based bits--------
			local SomeScalar = FieldQuadratic.Decode(ScalarBytes)
			local ScalarBits, BitCount = FieldQuadratic.Bits(SomeScalar)
			local Result = Edwards.MulG(ScalarBits, BitCount)
			local EncodedResult = Edwards.Encode(Result)
	--]=]

	--!strict
	--!optimize 2
	--!native

	local FieldPrime = require("./FieldPrime")

	local POINT_SIZE = 416
	local COORD_SIZE = 104
	local AFFINE_NIELS_SIZE = 312
	local BASE_RADIX_WIDTH = 6
	local BASE_POINT_ROW = 2 ^ BASE_RADIX_WIDTH / 2

	local CURVE_D = FieldPrime.Mul(FieldPrime.Num(-121665), FieldPrime.Invert(FieldPrime.Num(121666)))
	local CURVE_K = FieldPrime.KMul(CURVE_D, 2)

	local IDENTITY_O = buffer.create(POINT_SIZE) do
		buffer.copy(IDENTITY_O, 0, FieldPrime.Num(0), 0, COORD_SIZE)
		buffer.copy(IDENTITY_O, COORD_SIZE, FieldPrime.Num(1), 0, COORD_SIZE)
		buffer.copy(IDENTITY_O, 2 * COORD_SIZE, FieldPrime.Num(1), 0, COORD_SIZE)
		buffer.copy(IDENTITY_O, 3 * COORD_SIZE, FieldPrime.Num(0), 0, COORD_SIZE)
	end

	local COORD_BUFFER_0 = buffer.create(COORD_SIZE)
	local COORD_BUFFER_1 = buffer.create(COORD_SIZE)
	local COORD_BUFFER_2 = buffer.create(COORD_SIZE)
	local COORD_BUFFER_3 = buffer.create(COORD_SIZE)
	local COORD_BUFFER_4 = buffer.create(COORD_SIZE)
	local COORD_BUFFER_5 = buffer.create(COORD_SIZE)
	local COORD_BUFFER_6 = buffer.create(COORD_SIZE)
	local COORD_BUFFER_7 = buffer.create(COORD_SIZE)

	local MUL_RESULT_POINT = buffer.create(POINT_SIZE)
	local MUL_NIELS_POINT = buffer.create(POINT_SIZE)
	local MUL_DOUBLE_X = buffer.create(COORD_SIZE)
	local MUL_DOUBLE_Y = buffer.create(COORD_SIZE)
	local MUL_DOUBLE_Z = buffer.create(COORD_SIZE)
	local MUL_DOUBLE_A = buffer.create(COORD_SIZE)
	local MUL_DOUBLE_B = buffer.create(COORD_SIZE)
	local MUL_DOUBLE_E = buffer.create(COORD_SIZE)
	local MUL_DOUBLE_G = buffer.create(COORD_SIZE)
	local MUL_P1X = buffer.create(COORD_SIZE)
	local MUL_P1Y = buffer.create(COORD_SIZE)
	local MUL_P1Z = buffer.create(COORD_SIZE)
	local MUL_P1T = buffer.create(COORD_SIZE)
	local MUL_N2P = buffer.create(COORD_SIZE)
	local MUL_N2M = buffer.create(COORD_SIZE)
	local MUL_N2Z = buffer.create(COORD_SIZE)
	local MUL_N2T = buffer.create(COORD_SIZE)
	local MUL_TMP = buffer.create(COORD_SIZE)

	local MULG_RESULT_POINT = buffer.create(POINT_SIZE)
	local MULG_AFFINE_NIELS = buffer.create(AFFINE_NIELS_SIZE)
	local MULG_DUMMY_POINT = buffer.create(POINT_SIZE)
	local MULG_P1X = buffer.create(COORD_SIZE)
	local MULG_P1Y = buffer.create(COORD_SIZE)
	local MULG_P1Z = buffer.create(COORD_SIZE)
	local MULG_P1T = buffer.create(COORD_SIZE)
	local MULG_N2P = buffer.create(COORD_SIZE)
	local MULG_N2M = buffer.create(COORD_SIZE)
	local MULG_N2T = buffer.create(COORD_SIZE)
	local MULG_TMP = buffer.create(COORD_SIZE)

	local NAF_TABLE_DOUBLED = buffer.create(POINT_SIZE)
	local NAF_TABLE_P1X = buffer.create(COORD_SIZE)
	local NAF_TABLE_P1Y = buffer.create(COORD_SIZE)
	local NAF_TABLE_P1Z = buffer.create(COORD_SIZE)
	local NAF_TABLE_P1T = buffer.create(COORD_SIZE)
	local NAF_TABLE_N2P = buffer.create(COORD_SIZE)
	local NAF_TABLE_N2M = buffer.create(COORD_SIZE)
	local NAF_TABLE_N2Z = buffer.create(COORD_SIZE)
	local NAF_TABLE_N2T = buffer.create(COORD_SIZE)
	local NAF_TABLE_TMP = buffer.create(COORD_SIZE)
	local NAF_TABLE_DBL_P = buffer.create(COORD_SIZE)
	local NAF_TABLE_DBL_M = buffer.create(COORD_SIZE)
	local NAF_TABLE_DBL_Z = buffer.create(COORD_SIZE)
	local NAF_TABLE_DBL_T = buffer.create(COORD_SIZE)

	local NAF_OUTPUT = buffer.create(512 * 8)
	local RADIX_OUTPUT = buffer.create(272 * 8)

	local BASEPONT_G: buffer? = nil
	local AFFINE_BASEPOINT_TABLE: buffer? = nil

	local function GetCoord(Point: buffer, Index: number, Storage: buffer?): buffer
		local Coord = Storage or buffer.create(COORD_SIZE)
		buffer.copy(Coord, 0, Point, Index * COORD_SIZE, COORD_SIZE)
		return Coord
	end

	local Edwards25519 = {}

	function Edwards25519.Double(Point1: buffer, Storage: buffer?): buffer
		local Point1X = GetCoord(Point1, 0, COORD_BUFFER_0)
		local Point1Y = GetCoord(Point1, 1, COORD_BUFFER_1)
		local Point1Z = GetCoord(Point1, 2, COORD_BUFFER_2)

		local SquaredA = FieldPrime.Square(Point1X)
		local SquaredB = FieldPrime.Square(Point1Y)
		FieldPrime.Square(Point1Z, Point1Z)
		FieldPrime.Add(Point1Z, Point1Z, Point1Z)
		local DoubledD = Point1Z
		local SumE = FieldPrime.Add(SquaredA, SquaredB)
		FieldPrime.Add(Point1X, Point1Y, Point1X)
		local SumF = Point1X
		local SquaredG = FieldPrime.Square(SumF)
		FieldPrime.Sub(SquaredG, SumE, SquaredG)
		FieldPrime.Carry(SquaredG, SquaredG)
		local DiffH = SquaredG
		FieldPrime.Sub(SquaredB, SquaredA, SquaredB)
		local DiffI = SquaredB
		FieldPrime.Sub(DoubledD, DiffI, DoubledD)
		FieldPrime.Carry(DoubledD, DoubledD)
		local DiffJ = DoubledD

		local NewX = FieldPrime.Mul(DiffH, DiffJ)
		local NewY = FieldPrime.Mul(DiffI, SumE)
		FieldPrime.Mul(DiffJ, DiffI, DiffJ)
		local NewZ = DiffJ
		FieldPrime.Mul(DiffH, SumE, DiffH)
		local NewT = DiffH

		local Result = Storage or buffer.create(POINT_SIZE)
		buffer.copy(Result, 0 * COORD_SIZE, NewX, 0, COORD_SIZE)
		buffer.copy(Result, 1 * COORD_SIZE, NewY, 0, COORD_SIZE)
		buffer.copy(Result, 2 * COORD_SIZE, NewZ, 0, COORD_SIZE)
		buffer.copy(Result, 3 * COORD_SIZE, NewT, 0, COORD_SIZE)

		return Result
	end

	function Edwards25519.Add(Point1: buffer, NielsPoint2: buffer, Storage: buffer?): buffer
		local Point1X = GetCoord(Point1, 0, COORD_BUFFER_0)
		local Point1Y = GetCoord(Point1, 1, COORD_BUFFER_1)
		local Point1Z = GetCoord(Point1, 2, COORD_BUFFER_2)
		local Point1T = GetCoord(Point1, 3, COORD_BUFFER_3)

		local Niels1Plus = GetCoord(NielsPoint2, 0, COORD_BUFFER_4)
		local Niels1Minus = GetCoord(NielsPoint2, 1, COORD_BUFFER_5)
		local Niels1Z = GetCoord(NielsPoint2, 2, COORD_BUFFER_6)
		local Niels1T = GetCoord(NielsPoint2, 3, COORD_BUFFER_7)

		local DiffA = FieldPrime.Sub(Point1Y, Point1X)
		FieldPrime.Mul(DiffA, Niels1Minus, DiffA)
		local ProductB = DiffA

		local SumC = FieldPrime.Add(Point1Y, Point1X)
		FieldPrime.Mul(SumC, Niels1Plus, SumC)
		local ProductD = SumC

		FieldPrime.Mul(Point1T, Niels1T, Point1T)
		local ProductE = Point1T

		FieldPrime.Mul(Point1Z, Niels1Z, Point1Z)
		local ProductF = Point1Z

		local DiffG = FieldPrime.Sub(ProductD, ProductB)
		local DiffH = FieldPrime.Sub(ProductF, ProductE)

		FieldPrime.Add(ProductF, ProductE, ProductF)
		local SumI = ProductF

		FieldPrime.Add(ProductD, ProductB, ProductD)
		local SumJ = ProductD

		local NewX = FieldPrime.Mul(DiffG, DiffH)
		local NewY = FieldPrime.Mul(SumI, SumJ)
		FieldPrime.Mul(DiffH, SumI, DiffH)
		local NewZ = DiffH
		FieldPrime.Mul(DiffG, SumJ, DiffG)
		local NewT = DiffG

		local Result = Storage or buffer.create(POINT_SIZE)
		buffer.copy(Result, 0 * COORD_SIZE, NewX, 0, COORD_SIZE)
		buffer.copy(Result, 1 * COORD_SIZE, NewY, 0, COORD_SIZE)
		buffer.copy(Result, 2 * COORD_SIZE, NewZ, 0, COORD_SIZE)
		buffer.copy(Result, 3 * COORD_SIZE, NewT, 0, COORD_SIZE)

		return Result
	end

	function Edwards25519.Sub(Point1: buffer, NielsPoint2: buffer, Storage: buffer?): buffer
		local Point1X = GetCoord(Point1, 0, COORD_BUFFER_0)
		local Point1Y = GetCoord(Point1, 1, COORD_BUFFER_1)
		local Point1Z = GetCoord(Point1, 2, COORD_BUFFER_2)
		local Point1T = GetCoord(Point1, 3, COORD_BUFFER_3)

		local Niels1Plus = GetCoord(NielsPoint2, 0, COORD_BUFFER_4)
		local Niels1Minus = GetCoord(NielsPoint2, 1, COORD_BUFFER_5)
		local Niels1Z = GetCoord(NielsPoint2, 2, COORD_BUFFER_6)
		local Niels1T = GetCoord(NielsPoint2, 3, COORD_BUFFER_7)

		local DiffA = FieldPrime.Sub(Point1Y, Point1X)
		FieldPrime.Mul(DiffA, Niels1Plus, DiffA)
		local ProductB = DiffA
		FieldPrime.Add(Point1Y, Point1X, Point1Y)
		local SumC = Point1Y
		FieldPrime.Mul(SumC, Niels1Minus, SumC)
		local ProductD = SumC
		FieldPrime.Mul(Point1T, Niels1T, Point1T)
		local ProductE = Point1T
		FieldPrime.Mul(Point1Z, Niels1Z, Point1Z)
		local ProductF = Point1Z
		local DiffG = FieldPrime.Sub(ProductD, ProductB)
		local SumH = FieldPrime.Add(ProductF, ProductE)
		local DiffI = FieldPrime.Sub(ProductF, ProductE)
		FieldPrime.Add(ProductD, ProductB, ProductD)
		local SumJ = ProductD

		local NewX = FieldPrime.Mul(DiffG, SumH)
		local NewY = FieldPrime.Mul(DiffI, SumJ)
		FieldPrime.Mul(SumH, DiffI, SumH)
		local NewZ = SumH
		FieldPrime.Mul(DiffG, SumJ, DiffG)
		local NewT = DiffG

		local Result = Storage or buffer.create(POINT_SIZE)
		buffer.copy(Result, 0 * COORD_SIZE, NewX, 0, COORD_SIZE)
		buffer.copy(Result, 1 * COORD_SIZE, NewY, 0, COORD_SIZE)
		buffer.copy(Result, 2 * COORD_SIZE, NewZ, 0, COORD_SIZE)
		buffer.copy(Result, 3 * COORD_SIZE, NewT, 0, COORD_SIZE)

		return Result
	end

	function Edwards25519.Niels(Point1: buffer, Storage: buffer?): buffer
		local Point1X = GetCoord(Point1, 0, COORD_BUFFER_0)
		local Point1Y = GetCoord(Point1, 1, COORD_BUFFER_1)
		local Point1Z = GetCoord(Point1, 2, COORD_BUFFER_2)
		local Point1T = GetCoord(Point1, 3, COORD_BUFFER_3)

		local PlusN3 = FieldPrime.Add(Point1Y, Point1X)
		local MinusN3 = FieldPrime.Sub(Point1Y, Point1X)
		FieldPrime.Add(Point1Z, Point1Z, Point1Z)
		local DoubledN3Z = Point1Z
		FieldPrime.Mul(Point1T, CURVE_K, Point1T)
		local ScaledN3T = Point1T

		local Result = Storage or buffer.create(POINT_SIZE)
		buffer.copy(Result, 0 * COORD_SIZE, PlusN3, 0, COORD_SIZE)
		buffer.copy(Result, 1 * COORD_SIZE, MinusN3, 0, COORD_SIZE)
		buffer.copy(Result, 2 * COORD_SIZE, DoubledN3Z, 0, COORD_SIZE)
		buffer.copy(Result, 3 * COORD_SIZE, ScaledN3T, 0, COORD_SIZE)

		return Result
	end

	function Edwards25519.AffineNiels(Point1: buffer, Storage: buffer?): buffer
		local Point1X = GetCoord(Point1, 0, COORD_BUFFER_0)
		local Point1Y = GetCoord(Point1, 1, COORD_BUFFER_1)
		local Point1T = GetCoord(Point1, 3, COORD_BUFFER_3)

		local YPlusX = FieldPrime.Add(Point1Y, Point1X)
		local YMinusX = FieldPrime.Sub(Point1Y, Point1X)
		FieldPrime.Mul(Point1T, CURVE_K, Point1T)
		local T2d = Point1T

		local Result = Storage or buffer.create(AFFINE_NIELS_SIZE)
		buffer.copy(Result, 0 * COORD_SIZE, YPlusX, 0, COORD_SIZE)
		buffer.copy(Result, 1 * COORD_SIZE, YMinusX, 0, COORD_SIZE)
		buffer.copy(Result, 2 * COORD_SIZE, T2d, 0, COORD_SIZE)

		return Result
	end

	function Edwards25519.AddAffine(Point1: buffer, AffineNiels2: buffer, Storage: buffer?): buffer
		local Point1X = GetCoord(Point1, 0, COORD_BUFFER_0)
		local Point1Y = GetCoord(Point1, 1, COORD_BUFFER_1)
		local Point1Z = GetCoord(Point1, 2, COORD_BUFFER_2)
		local Point1T = GetCoord(Point1, 3, COORD_BUFFER_3)

		local Niels2YPlusX = GetCoord(AffineNiels2, 0, COORD_BUFFER_4)
		local Niels2YMinusX = GetCoord(AffineNiels2, 1, COORD_BUFFER_5)
		local Niels2T2d = GetCoord(AffineNiels2, 2, COORD_BUFFER_6)

		local DiffA = FieldPrime.Sub(Point1Y, Point1X)
		FieldPrime.Mul(DiffA, Niels2YMinusX, DiffA)
		local ProductB = DiffA

		local SumC = FieldPrime.Add(Point1Y, Point1X)
		FieldPrime.Mul(SumC, Niels2YPlusX, SumC)
		local ProductD = SumC

		FieldPrime.Mul(Point1T, Niels2T2d, Point1T)
		local ProductE = Point1T

		FieldPrime.Add(Point1Z, Point1Z, Point1Z)
		local ProductF = Point1Z

		local DiffG = FieldPrime.Sub(ProductD, ProductB)
		local DiffH = FieldPrime.Sub(ProductF, ProductE)

		FieldPrime.Add(ProductF, ProductE, ProductF)
		local SumI = ProductF

		FieldPrime.Add(ProductD, ProductB, ProductD)
		local SumJ = ProductD

		local NewX = FieldPrime.Mul(DiffG, DiffH)
		local NewY = FieldPrime.Mul(SumI, SumJ)
		FieldPrime.Mul(DiffH, SumI, DiffH)
		local NewZ = DiffH
		FieldPrime.Mul(DiffG, SumJ, DiffG)
		local NewT = DiffG

		local Result = Storage or buffer.create(POINT_SIZE)
		buffer.copy(Result, 0 * COORD_SIZE, NewX, 0, COORD_SIZE)
		buffer.copy(Result, 1 * COORD_SIZE, NewY, 0, COORD_SIZE)
		buffer.copy(Result, 2 * COORD_SIZE, NewZ, 0, COORD_SIZE)
		buffer.copy(Result, 3 * COORD_SIZE, NewT, 0, COORD_SIZE)

		return Result
	end

	function Edwards25519.SubAffine(Point1: buffer, AffineNiels2: buffer, Storage: buffer?): buffer
		local Point1X = GetCoord(Point1, 0, COORD_BUFFER_0)
		local Point1Y = GetCoord(Point1, 1, COORD_BUFFER_1)
		local Point1Z = GetCoord(Point1, 2, COORD_BUFFER_2)
		local Point1T = GetCoord(Point1, 3, COORD_BUFFER_3)

		local Niels2YPlusX = GetCoord(AffineNiels2, 0, COORD_BUFFER_4)
		local Niels2YMinusX = GetCoord(AffineNiels2, 1, COORD_BUFFER_5)
		local Niels2T2d = GetCoord(AffineNiels2, 2, COORD_BUFFER_6)

		local DiffA = FieldPrime.Sub(Point1Y, Point1X)
		FieldPrime.Mul(DiffA, Niels2YPlusX, DiffA)
		local ProductB = DiffA

		FieldPrime.Add(Point1Y, Point1X, Point1Y)
		local SumC = Point1Y
		FieldPrime.Mul(SumC, Niels2YMinusX, SumC)
		local ProductD = SumC

		FieldPrime.Mul(Point1T, Niels2T2d, Point1T)
		local ProductE = Point1T

		FieldPrime.Add(Point1Z, Point1Z, Point1Z)
		local ProductF = Point1Z

		local DiffG = FieldPrime.Sub(ProductD, ProductB)
		local SumH = FieldPrime.Add(ProductF, ProductE)
		local DiffI = FieldPrime.Sub(ProductF, ProductE)
		FieldPrime.Add(ProductD, ProductB, ProductD)
		local SumJ = ProductD

		local NewX = FieldPrime.Mul(DiffG, SumH)
		local NewY = FieldPrime.Mul(DiffI, SumJ)
		FieldPrime.Mul(SumH, DiffI, SumH)
		local NewZ = SumH
		FieldPrime.Mul(DiffG, SumJ, DiffG)
		local NewT = DiffG

		local Result = Storage or buffer.create(POINT_SIZE)
		buffer.copy(Result, 0 * COORD_SIZE, NewX, 0, COORD_SIZE)
		buffer.copy(Result, 1 * COORD_SIZE, NewY, 0, COORD_SIZE)
		buffer.copy(Result, 2 * COORD_SIZE, NewZ, 0, COORD_SIZE)
		buffer.copy(Result, 3 * COORD_SIZE, NewT, 0, COORD_SIZE)

		return Result
	end

	function Edwards25519.Scale(Point1: buffer): buffer
		local Point1X = GetCoord(Point1, 0, COORD_BUFFER_0)
		local Point1Y = GetCoord(Point1, 1, COORD_BUFFER_1)
		local Point1Z = GetCoord(Point1, 2, COORD_BUFFER_2)

		FieldPrime.Invert(Point1Z, Point1Z)
		local ZInverse = Point1Z
		FieldPrime.Mul(Point1X, ZInverse, Point1X)
		local NewX = Point1X
		FieldPrime.Mul(Point1Y, ZInverse, Point1Y)
		local NewY = Point1Y
		local NewZ = FieldPrime.Num(1)
		local NewT = FieldPrime.Mul(NewX, NewY)

		local Result = buffer.create(POINT_SIZE)
		buffer.copy(Result, 0 * COORD_SIZE, NewX, 0, COORD_SIZE)
		buffer.copy(Result, 1 * COORD_SIZE, NewY, 0, COORD_SIZE)
		buffer.copy(Result, 2 * COORD_SIZE, NewZ, 0, COORD_SIZE)
		buffer.copy(Result, 3 * COORD_SIZE, NewT, 0, COORD_SIZE)

		return Result
	end

	function Edwards25519.Encode(Point1: buffer): buffer
		local ScaledPoint = Edwards25519.Scale(Point1)
		local Point1X = GetCoord(ScaledPoint, 0, COORD_BUFFER_0)
		local Point1Y = GetCoord(ScaledPoint, 1, COORD_BUFFER_1)

		local EncodedY = FieldPrime.Encode(Point1Y)
		local CanonicalX = FieldPrime.Canonicalize(Point1X)
		local XSignBit = buffer.readf64(CanonicalX, 0) % 2

		local ResultBuffer = buffer.create(32)
		buffer.copy(ResultBuffer, 0, EncodedY, 0, 32)

		local LastByte = buffer.readu8(ResultBuffer, 31)
		buffer.writeu8(ResultBuffer, 31, LastByte + XSignBit * 128)

		return ResultBuffer
	end

	function Edwards25519.Decode(EncodedBuffer: buffer): buffer?
		local WorkingBuffer = buffer.create(32)
		buffer.copy(WorkingBuffer, 0, EncodedBuffer, 0, 32)

		local LastByte = buffer.readu8(WorkingBuffer, 31)
		local SignBit = bit32.extract(LastByte, 7)
		buffer.writeu8(WorkingBuffer, 31, bit32.band(LastByte, 0x7F))

		local YCoord = FieldPrime.Decode(WorkingBuffer)
		local YSquared = FieldPrime.Square(YCoord)
		local Numerator = FieldPrime.Sub(YSquared, FieldPrime.Num(1))
		local Denominator = FieldPrime.Mul(YSquared, CURVE_D)
		local DenomPlusOne = FieldPrime.Add(Denominator, FieldPrime.Num(1))

		local XCoord = FieldPrime.SqrtDiv(Numerator, DenomPlusOne)
		if not XCoord then
			return nil
		end

		local CanonicalX = FieldPrime.Canonicalize(XCoord)
		local XSignBit = buffer.readf64(CanonicalX, 0) % 2

		if XSignBit ~= SignBit then
			XCoord = FieldPrime.Carry(FieldPrime.Neg(XCoord))
		end

		local ZCoord = FieldPrime.Num(1)
		local TCoord = FieldPrime.Mul(XCoord, YCoord)

		local Result = buffer.create(POINT_SIZE)
		buffer.copy(Result, 0 * COORD_SIZE, XCoord, 0, COORD_SIZE)
		buffer.copy(Result, 1 * COORD_SIZE, YCoord, 0, COORD_SIZE)
		buffer.copy(Result, 2 * COORD_SIZE, ZCoord, 0, COORD_SIZE)
		buffer.copy(Result, 3 * COORD_SIZE, TCoord, 0, COORD_SIZE)

		return Result
	end

	local BASEPOINT_BYTES = buffer.create(32) do
		local BasePointHex = {
			0x58, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66,
			0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66,
			0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66,
			0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66
		}

		for Index = 1, 32 do
			buffer.writeu8(BASEPOINT_BYTES, Index - 1, BasePointHex[Index])
		end

		BASEPONT_G = Edwards25519.Decode(BASEPOINT_BYTES)
	end

	function Edwards25519.AffineRadixWTable(BasePoint: buffer, RadixWidth: number): buffer
		if RadixWidth <= 0 or RadixWidth > 8 then
			error("Invalid Radix width", 2)
		end

		if buffer.len(BasePoint) ~= POINT_SIZE then
			error("Invalid Basepoint", 2)
		end

		local MaxWindows = math.ceil(256 / RadixWidth)
		local MaxRowSize = 2 ^ RadixWidth / 2

		local TableData = buffer.create(MaxWindows * MaxRowSize * AFFINE_NIELS_SIZE)

		local CurrentBasePoint = buffer.create(POINT_SIZE)
		buffer.copy(CurrentBasePoint, 0, BasePoint, 0, POINT_SIZE)

		local AffineNiels = Edwards25519.AffineNiels
		local Add = Edwards25519.Add
		local Double = Edwards25519.Double
		local Scale = Edwards25519.Scale
		local Niels = Edwards25519.Niels
		local NielsSize = AFFINE_NIELS_SIZE

		for WindowIndex = 1, MaxWindows do
			local BaseOffset = ((WindowIndex - 1) * MaxRowSize * NielsSize)
			local WorkingPoint = buffer.create(POINT_SIZE)
			buffer.copy(WorkingPoint, 0, CurrentBasePoint, 0, POINT_SIZE)

			local ScaledPoint = Scale(WorkingPoint)
			local FirstAffineNiels = AffineNiels(ScaledPoint)
			buffer.copy(TableData, BaseOffset, FirstAffineNiels, 0, NielsSize)

			local FirstNiels = Niels(ScaledPoint)

			for Multiple = 2, MaxRowSize do
				Add(WorkingPoint, FirstNiels, WorkingPoint)
				local Scaled = Scale(WorkingPoint)
				local AffineNielsBuffer = AffineNiels(Scaled)

				local Offset = BaseOffset + ((Multiple - 1) * NielsSize)
				buffer.copy(TableData, Offset, AffineNielsBuffer, 0, NielsSize)
			end

			for _ = 1, RadixWidth do
				CurrentBasePoint = Double(CurrentBasePoint)
			end
		end

		return TableData
	end

	do
		if BASEPONT_G then
			AFFINE_BASEPOINT_TABLE = Edwards25519.AffineRadixWTable(BASEPONT_G, BASE_RADIX_WIDTH)
		end
	end

	function Edwards25519.GetAffineBasePointTableEntry(WindowIndex: number, Multiple: number, Storage: buffer?): buffer
		if not AFFINE_BASEPOINT_TABLE then
			return buffer.create(0)
		end

		local BaseOffset = ((WindowIndex - 1) * BASE_POINT_ROW * AFFINE_NIELS_SIZE)
		local Offset = BaseOffset + ((Multiple - 1) * AFFINE_NIELS_SIZE)

		local AffineNielsPoint = Storage or buffer.create(AFFINE_NIELS_SIZE)
		buffer.copy(AffineNielsPoint, 0, AFFINE_BASEPOINT_TABLE, Offset, AFFINE_NIELS_SIZE)

		return AffineNielsPoint
	end

	function Edwards25519.SignedRadixW(ScalarBits: buffer, ScalarBitCount: number, RadixWidth: number): (buffer, number)
		if ScalarBitCount <= 0 or ScalarBitCount > 256 then
			error("Invalid scalar bit count", 2)
		end

		if RadixWidth <= 0 or RadixWidth > 8 then
			error("Invalid Radix width", 2)
		end

		local RadixValue = 2 ^ RadixWidth
		local HalfRadix = RadixValue / 2
		local MaxOutputLength = 272
		local OutputDigits = RADIX_OUTPUT
		local OutputLength, Accumulator = 0, 0
		local Multiplier = 1

		for BitIndex = 1, ScalarBitCount do
			if BitIndex > ScalarBitCount then
				break
			end

			local BitValue = buffer.readf64(ScalarBits, (BitIndex - 1) * 8)
			Accumulator += BitValue * Multiplier
			Multiplier *= 2

			while BitIndex == ScalarBitCount and Accumulator > 0 or Multiplier > RadixValue do
				if OutputLength >= MaxOutputLength then
					error("Output overflow in SignedRadixW")
				end

				local Remainder = Accumulator % RadixValue
				if Remainder >= HalfRadix then
					Remainder -= RadixValue
				end
				Accumulator = (Accumulator - Remainder) / RadixValue
				Multiplier /= RadixValue
				buffer.writef64(OutputDigits, OutputLength * 8, Remainder)
				OutputLength += 1
			end
		end

		return OutputDigits, OutputLength
	end

	function Edwards25519.WindowedNAF(ScalarBits: buffer, ScalarBitCount: number, WindowWidth: number): (buffer, number)
		local WindowValue = 2 ^ WindowWidth
		local HalfWindow = WindowValue / 2
		local OutputNAF = NAF_OUTPUT
		local OutputLength = 0
		local Accumulator = 0
		local Multiplier = 1

		for BitIndex = 1, ScalarBitCount do
			local BitValue = buffer.readf64(ScalarBits, (BitIndex - 1) * 8)
			Accumulator += BitValue * Multiplier
			Multiplier *= 2

			while BitIndex == ScalarBitCount and Accumulator > 0 or Multiplier > WindowValue do
				if Accumulator % 2 == 0 then
					Accumulator /= 2
					Multiplier /= 2
					buffer.writef64(OutputNAF, OutputLength * 8, 0)
					OutputLength += 1
				else
					local Remainder = Accumulator % WindowValue
					if Remainder >= HalfWindow then
						Remainder -= WindowValue
					end
					Accumulator -= Remainder
					buffer.writef64(OutputNAF, OutputLength * 8, Remainder)
					OutputLength += 1
				end
			end
		end

		while OutputLength > 0 and buffer.readf64(OutputNAF, (OutputLength - 1) * 8) == 0 do
			OutputLength -= 1
		end

		return OutputNAF, OutputLength
	end

	function Edwards25519.WindowedNAFTable(BasePoint: buffer, WindowWidth: number): buffer
		local PointSize = POINT_SIZE
		local CoordSize = COORD_SIZE
		local CurveK = CURVE_K
		local MaxOddMultiples = 2 ^ WindowWidth

		Edwards25519.Double(BasePoint, NAF_TABLE_DOUBLED)

		local TableData = buffer.create(MaxOddMultiples * PointSize)

		local FAdd = FieldPrime.Add
		local FSub = FieldPrime.Sub
		local FMul = FieldPrime.Mul

		local P1X = NAF_TABLE_P1X
		local P1Y = NAF_TABLE_P1Y
		local P1Z = NAF_TABLE_P1Z
		local P1T = NAF_TABLE_P1T
		local N2P = NAF_TABLE_N2P
		local N2M = NAF_TABLE_N2M
		local N2Z = NAF_TABLE_N2Z
		local N2T = NAF_TABLE_N2T
		local TMP = NAF_TABLE_TMP
		local DBLP = NAF_TABLE_DBL_P
		local DBLM = NAF_TABLE_DBL_M
		local DBLZ = NAF_TABLE_DBL_Z
		local DBLT = NAF_TABLE_DBL_T
		local Doubled = NAF_TABLE_DOUBLED

		buffer.copy(P1X, 0, Doubled, 0, CoordSize)
		buffer.copy(P1Y, 0, Doubled, CoordSize, CoordSize)
		buffer.copy(P1Z, 0, Doubled, 2 * CoordSize, CoordSize)
		buffer.copy(P1T, 0, Doubled, 3 * CoordSize, CoordSize)

		FAdd(P1Y, P1X, DBLP)
		FSub(P1Y, P1X, DBLM)
		FAdd(P1Z, P1Z, DBLZ)
		FMul(P1T, CurveK, DBLT)

		buffer.copy(P1X, 0, BasePoint, 0, CoordSize)
		buffer.copy(P1Y, 0, BasePoint, CoordSize, CoordSize)
		buffer.copy(P1Z, 0, BasePoint, 2 * CoordSize, CoordSize)
		buffer.copy(P1T, 0, BasePoint, 3 * CoordSize, CoordSize)

		FAdd(P1Y, P1X, N2P)
		FSub(P1Y, P1X, N2M)
		FAdd(P1Z, P1Z, N2Z)
		FMul(P1T, CurveK, N2T)

		buffer.copy(TableData, 0, N2P, 0, CoordSize)
		buffer.copy(TableData, CoordSize, N2M, 0, CoordSize)
		buffer.copy(TableData, 2 * CoordSize, N2Z, 0, CoordSize)
		buffer.copy(TableData, 3 * CoordSize, N2T, 0, CoordSize)

		buffer.copy(P1X, 0, BasePoint, 0, CoordSize)
		buffer.copy(P1Y, 0, BasePoint, CoordSize, CoordSize)
		buffer.copy(P1Z, 0, BasePoint, 2 * CoordSize, CoordSize)
		buffer.copy(P1T, 0, BasePoint, 3 * CoordSize, CoordSize)

		for OddMultiple = 3, MaxOddMultiples, 2 do
			local CurrentOffset = ((OddMultiple - 1) * PointSize)

			FSub(P1Y, P1X, TMP)
			FMul(TMP, DBLM, TMP)
			FAdd(P1Y, P1X, N2P)
			FMul(N2P, DBLP, N2P)
			FMul(P1T, DBLT, P1T)
			FMul(P1Z, DBLZ, P1Z)

			FSub(N2P, TMP, N2M)
			FSub(P1Z, P1T, N2Z)
			FAdd(P1Z, P1T, P1Z)
			FAdd(N2P, TMP, N2P)

			FMul(N2M, N2Z, P1X)
			FMul(P1Z, N2P, P1Y)
			FMul(N2Z, P1Z, P1Z)
			FMul(N2M, N2P, P1T)

			FAdd(P1Y, P1X, N2P)
			FSub(P1Y, P1X, N2M)
			FAdd(P1Z, P1Z, N2Z)
			FMul(P1T, CurveK, N2T)

			buffer.copy(TableData, CurrentOffset, N2P, 0, CoordSize)
			buffer.copy(TableData, CurrentOffset + CoordSize, N2M, 0, CoordSize)
			buffer.copy(TableData, CurrentOffset + 2 * CoordSize, N2Z, 0, CoordSize)
			buffer.copy(TableData, CurrentOffset + 3 * CoordSize, N2T, 0, CoordSize)
		end

		return TableData
	end

	function Edwards25519.MulG(ScalarBits: buffer, ScalarBitCount: number): buffer
		local PointSize = POINT_SIZE
		local CoordSize = COORD_SIZE
		local AffineNielsSize = AFFINE_NIELS_SIZE
		local IdentityO = IDENTITY_O
		local BaseRadixWidth = BASE_RADIX_WIDTH
		local BasePointRow = BASE_POINT_ROW
		local AffineTable = AFFINE_BASEPOINT_TABLE :: buffer

		local SignedWindows, WindowCount = Edwards25519.SignedRadixW(ScalarBits, ScalarBitCount, BaseRadixWidth)

		local ResultPoint = MULG_RESULT_POINT
		buffer.copy(ResultPoint, 0, IdentityO, 0, PointSize)

		local AffineNielsPoint = MULG_AFFINE_NIELS
		local DummyPoint = MULG_DUMMY_POINT
		buffer.copy(DummyPoint, 0, IdentityO, 0, PointSize)

		local FAdd = FieldPrime.Add
		local FSub = FieldPrime.Sub
		local FMul = FieldPrime.Mul

		local P1X = MULG_P1X
		local P1Y = MULG_P1Y
		local P1Z = MULG_P1Z
		local P1T = MULG_P1T
		local N2P = MULG_N2P
		local N2M = MULG_N2M
		local N2T = MULG_N2T
		local TMP = MULG_TMP

		for WindowIndex = 1, WindowCount do
			local WindowValue = buffer.readf64(SignedWindows, (WindowIndex - 1) * 8)

			if WindowValue > 0 then
				local BaseOffset = ((WindowIndex - 1) * BasePointRow * AffineNielsSize)
				local Offset = BaseOffset + ((WindowValue - 1) * AffineNielsSize)
				buffer.copy(AffineNielsPoint, 0, AffineTable, Offset, AffineNielsSize)

				buffer.copy(P1X, 0, ResultPoint, 0, CoordSize)
				buffer.copy(P1Y, 0, ResultPoint, CoordSize, CoordSize)
				buffer.copy(P1Z, 0, ResultPoint, 2 * CoordSize, CoordSize)
				buffer.copy(P1T, 0, ResultPoint, 3 * CoordSize, CoordSize)
				buffer.copy(N2P, 0, AffineNielsPoint, 0, CoordSize)
				buffer.copy(N2M, 0, AffineNielsPoint, CoordSize, CoordSize)
				buffer.copy(N2T, 0, AffineNielsPoint, 2 * CoordSize, CoordSize)

				FSub(P1Y, P1X, TMP)
				FMul(TMP, N2M, TMP)
				FAdd(P1Y, P1X, P1X)
				FMul(P1X, N2P, P1X)
				FMul(P1T, N2T, P1T)
				FAdd(P1Z, P1Z, P1Z)

				FSub(P1X, TMP, P1Y)
				FSub(P1Z, P1T, N2P)
				FAdd(P1Z, P1T, P1Z)
				FAdd(P1X, TMP, P1X)

				FMul(P1Y, N2P, TMP)
				FMul(P1Z, P1X, P1T)
				FMul(N2P, P1Z, P1Z)
				FMul(P1Y, P1X, P1X)

				buffer.copy(ResultPoint, 0, TMP, 0, CoordSize)
				buffer.copy(ResultPoint, CoordSize, P1T, 0, CoordSize)
				buffer.copy(ResultPoint, 2 * CoordSize, P1Z, 0, CoordSize)
				buffer.copy(ResultPoint, 3 * CoordSize, P1X, 0, CoordSize)

			elseif WindowValue < 0 then
				local BaseOffset = ((WindowIndex - 1) * BasePointRow * AffineNielsSize)
				local Offset = BaseOffset + (((-WindowValue) - 1) * AffineNielsSize)
				buffer.copy(AffineNielsPoint, 0, AffineTable, Offset, AffineNielsSize)

				buffer.copy(P1X, 0, ResultPoint, 0, CoordSize)
				buffer.copy(P1Y, 0, ResultPoint, CoordSize, CoordSize)
				buffer.copy(P1Z, 0, ResultPoint, 2 * CoordSize, CoordSize)
				buffer.copy(P1T, 0, ResultPoint, 3 * CoordSize, CoordSize)
				buffer.copy(N2P, 0, AffineNielsPoint, 0, CoordSize)
				buffer.copy(N2M, 0, AffineNielsPoint, CoordSize, CoordSize)
				buffer.copy(N2T, 0, AffineNielsPoint, 2 * CoordSize, CoordSize)

				FSub(P1Y, P1X, TMP)
				FMul(TMP, N2P, TMP)
				FAdd(P1Y, P1X, P1X)
				FMul(P1X, N2M, P1X)
				FMul(P1T, N2T, P1T)
				FAdd(P1Z, P1Z, P1Z)

				FSub(P1X, TMP, P1Y)
				FAdd(P1Z, P1T, N2P)
				FSub(P1Z, P1T, P1Z)
				FAdd(P1X, TMP, P1X)

				FMul(P1Y, N2P, TMP)
				FMul(P1Z, P1X, P1T)
				FMul(N2P, P1Z, P1Z)
				FMul(P1Y, P1X, P1X)

				buffer.copy(ResultPoint, 0, TMP, 0, CoordSize)
				buffer.copy(ResultPoint, CoordSize, P1T, 0, CoordSize)
				buffer.copy(ResultPoint, 2 * CoordSize, P1Z, 0, CoordSize)
				buffer.copy(ResultPoint, 3 * CoordSize, P1X, 0, CoordSize)

			else
				local BaseOffset = ((WindowIndex - 1) * BasePointRow * AffineNielsSize)
				buffer.copy(AffineNielsPoint, 0, AffineTable, BaseOffset, AffineNielsSize)

				buffer.copy(P1X, 0, DummyPoint, 0, CoordSize)
				buffer.copy(P1Y, 0, DummyPoint, CoordSize, CoordSize)
				buffer.copy(P1Z, 0, DummyPoint, 2 * CoordSize, CoordSize)
				buffer.copy(P1T, 0, DummyPoint, 3 * CoordSize, CoordSize)
				buffer.copy(N2P, 0, AffineNielsPoint, 0, CoordSize)
				buffer.copy(N2M, 0, AffineNielsPoint, CoordSize, CoordSize)
				buffer.copy(N2T, 0, AffineNielsPoint, 2 * CoordSize, CoordSize)

				FSub(P1Y, P1X, TMP)
				FMul(TMP, N2M, TMP)
				FAdd(P1Y, P1X, P1X)
				FMul(P1X, N2P, P1X)
				FMul(P1T, N2T, P1T)
				FAdd(P1Z, P1Z, P1Z)

				FSub(P1X, TMP, P1Y)
				FSub(P1Z, P1T, N2P)
				FAdd(P1Z, P1T, P1Z)
				FAdd(P1X, TMP, P1X)

				FMul(P1Y, N2P, TMP)
				FMul(P1Z, P1X, P1T)
				FMul(N2P, P1Z, P1Z)
				FMul(P1Y, P1X, P1X)

				buffer.copy(DummyPoint, 0, TMP, 0, CoordSize)
				buffer.copy(DummyPoint, CoordSize, P1T, 0, CoordSize)
				buffer.copy(DummyPoint, 2 * CoordSize, P1Z, 0, CoordSize)
				buffer.copy(DummyPoint, 3 * CoordSize, P1X, 0, CoordSize)
			end
		end

		local Output = buffer.create(PointSize)
		buffer.copy(Output, 0, ResultPoint, 0, PointSize)
		return Output
	end

	function Edwards25519.Mul(BasePoint: buffer, ScalarBits: buffer, ScalarBitCount: number): buffer
		local PointSize = POINT_SIZE
		local CoordSize = COORD_SIZE
		local IdentityO = IDENTITY_O

		local NAFForm, NAFLength = Edwards25519.WindowedNAF(ScalarBits, ScalarBitCount, 5)
		local MultipleTable = Edwards25519.WindowedNAFTable(BasePoint, 5)

		local ResultPoint = MUL_RESULT_POINT
		buffer.copy(ResultPoint, 0, IdentityO, 0, PointSize)

		local NielsPoint = MUL_NIELS_POINT

		local Square = FieldPrime.Square
		local FAdd = FieldPrime.Add
		local FSub = FieldPrime.Sub
		local FMul = FieldPrime.Mul
		local Carry = FieldPrime.Carry

		local DoubleX = MUL_DOUBLE_X
		local DoubleY = MUL_DOUBLE_Y
		local DoubleZ = MUL_DOUBLE_Z
		local DoubleA = MUL_DOUBLE_A
		local DoubleB = MUL_DOUBLE_B
		local DoubleE = MUL_DOUBLE_E
		local DoubleG = MUL_DOUBLE_G

		local P1X = MUL_P1X
		local P1Y = MUL_P1Y
		local P1Z = MUL_P1Z
		local P1T = MUL_P1T
		local N2P = MUL_N2P
		local N2M = MUL_N2M
		local N2Z = MUL_N2Z
		local N2T = MUL_N2T
		local TMP = MUL_TMP

		for NAFIndex = NAFLength, 1, -1 do
			local NAFDigit = buffer.readf64(NAFForm, (NAFIndex - 1) * 8)

			if NAFDigit == 0 then
				buffer.copy(DoubleX, 0, ResultPoint, 0, CoordSize)
				buffer.copy(DoubleY, 0, ResultPoint, CoordSize, CoordSize)
				buffer.copy(DoubleZ, 0, ResultPoint, 2 * CoordSize, CoordSize)

				Square(DoubleX, DoubleA)
				Square(DoubleY, DoubleB)
				Square(DoubleZ, DoubleZ)
				FAdd(DoubleZ, DoubleZ, DoubleZ)
				FAdd(DoubleA, DoubleB, DoubleE)
				FAdd(DoubleX, DoubleY, DoubleX)
				Square(DoubleX, DoubleG)
				FSub(DoubleG, DoubleE, DoubleG)
				Carry(DoubleG, DoubleG)
				FSub(DoubleB, DoubleA, DoubleB)
				FSub(DoubleZ, DoubleB, DoubleZ)
				Carry(DoubleZ, DoubleZ)

				FMul(DoubleG, DoubleZ, DoubleX)
				FMul(DoubleB, DoubleE, DoubleY)
				FMul(DoubleZ, DoubleB, DoubleZ)
				FMul(DoubleG, DoubleE, DoubleE)

				buffer.copy(ResultPoint, 0, DoubleX, 0, CoordSize)
				buffer.copy(ResultPoint, CoordSize, DoubleY, 0, CoordSize)
				buffer.copy(ResultPoint, 2 * CoordSize, DoubleZ, 0, CoordSize)
				buffer.copy(ResultPoint, 3 * CoordSize, DoubleE, 0, CoordSize)

			elseif NAFDigit > 0 then
				buffer.copy(NielsPoint, 0, MultipleTable, ((NAFDigit - 1) * PointSize), PointSize)

				buffer.copy(P1X, 0, ResultPoint, 0, CoordSize)
				buffer.copy(P1Y, 0, ResultPoint, CoordSize, CoordSize)
				buffer.copy(P1Z, 0, ResultPoint, 2 * CoordSize, CoordSize)
				buffer.copy(P1T, 0, ResultPoint, 3 * CoordSize, CoordSize)
				buffer.copy(N2P, 0, NielsPoint, 0, CoordSize)
				buffer.copy(N2M, 0, NielsPoint, CoordSize, CoordSize)
				buffer.copy(N2Z, 0, NielsPoint, 2 * CoordSize, CoordSize)
				buffer.copy(N2T, 0, NielsPoint, 3 * CoordSize, CoordSize)

				FSub(P1Y, P1X, TMP)
				FMul(TMP, N2M, TMP)
				FAdd(P1Y, P1X, P1X)
				FMul(P1X, N2P, P1X)
				FMul(P1T, N2T, P1T)
				FMul(P1Z, N2Z, P1Z)

				FSub(P1X, TMP, P1Y)
				FSub(P1Z, P1T, N2P)
				FAdd(P1Z, P1T, P1Z)
				FAdd(P1X, TMP, P1X)

				FMul(P1Y, N2P, TMP)
				FMul(P1Z, P1X, P1T)
				FMul(N2P, P1Z, P1Z)
				FMul(P1Y, P1X, P1X)

				buffer.copy(ResultPoint, 0, TMP, 0, CoordSize)
				buffer.copy(ResultPoint, CoordSize, P1T, 0, CoordSize)
				buffer.copy(ResultPoint, 2 * CoordSize, P1Z, 0, CoordSize)
				buffer.copy(ResultPoint, 3 * CoordSize, P1X, 0, CoordSize)

			else
				buffer.copy(NielsPoint, 0, MultipleTable, (((-NAFDigit) - 1) * PointSize), PointSize)

				buffer.copy(P1X, 0, ResultPoint, 0, CoordSize)
				buffer.copy(P1Y, 0, ResultPoint, CoordSize, CoordSize)
				buffer.copy(P1Z, 0, ResultPoint, 2 * CoordSize, CoordSize)
				buffer.copy(P1T, 0, ResultPoint, 3 * CoordSize, CoordSize)
				buffer.copy(N2P, 0, NielsPoint, 0, CoordSize)
				buffer.copy(N2M, 0, NielsPoint, CoordSize, CoordSize)
				buffer.copy(N2Z, 0, NielsPoint, 2 * CoordSize, CoordSize)
				buffer.copy(N2T, 0, NielsPoint, 3 * CoordSize, CoordSize)

				FSub(P1Y, P1X, TMP)
				FMul(TMP, N2P, TMP)
				FAdd(P1Y, P1X, P1X)
				FMul(P1X, N2M, P1X)
				FMul(P1T, N2T, P1T)
				FMul(P1Z, N2Z, P1Z)

				FSub(P1X, TMP, P1Y)
				FAdd(P1Z, P1T, N2P)
				FSub(P1Z, P1T, P1Z)
				FAdd(P1X, TMP, P1X)

				FMul(P1Y, N2P, TMP)
				FMul(P1Z, P1X, P1T)
				FMul(N2P, P1Z, P1Z)
				FMul(P1Y, P1X, P1X)

				buffer.copy(ResultPoint, 0, TMP, 0, CoordSize)
				buffer.copy(ResultPoint, CoordSize, P1T, 0, CoordSize)
				buffer.copy(ResultPoint, 2 * CoordSize, P1Z, 0, CoordSize)
				buffer.copy(ResultPoint, 3 * CoordSize, P1X, 0, CoordSize)
			end
		end

		local Output = buffer.create(PointSize)
		buffer.copy(Output, 0, ResultPoint, 0, PointSize)
		return Output
	end

	return Edwards25519

end }

__mods["crypto/EdDSA/FieldPrime"] = { dir = "crypto/EdDSA", fn = function(require)
	--[=[
		Cryptography library: Field Prime (Curve25519 Base Field)

		Return type: varies by function
		Example usage:
			local FieldPrime = require("FieldPrime")

			--------Usage Case 1: Basic arithmetic--------
			local ElementA = FieldPrime.Num(42)
			local ElementB = FieldPrime.Num(17)
			local Sum = FieldPrime.Add(ElementA, ElementB)
			local Product = FieldPrime.Mul(ElementA, ElementB)

			--------Usage Case 2: Encoding/decoding--------
			local Encoded = FieldPrime.Encode(ElementA)
			local Decoded = FieldPrime.Decode(Encoded)
	--]=]

	--!strict
	--!optimize 2
	--!native

	local SIZE = 104
	local COMPOUND_V = (19 / 2 ^ 255)
	local SQUARES = buffer.create(SIZE) do
		local Tbl = {
			0958640 * 2 ^ 0,
			0826664 * 2 ^ 22,
			1613251 * 2 ^ 43,
			1041528 * 2 ^ 64,
			0013673 * 2 ^ 85,
			0387171 * 2 ^ 107,
			1824679 * 2 ^ 128,
			0313839 * 2 ^ 149,
			0709440 * 2 ^ 170,
			0122635 * 2 ^ 192,
			0262782 * 2 ^ 213,
			0712905 * 2 ^ 234,
		}

		for Index = 1, 12 do
			buffer.writef64(SQUARES, (Index - 1) * 8, Tbl[Index])
		end
	end

	local FieldPrime = {}

	function FieldPrime.Num(Number: number): buffer
		local Buf = buffer.create(SIZE)
		buffer.writef64(Buf, 0, Number)

		return Buf
	end

	function FieldPrime.Neg(ElementA: buffer): buffer
		local A00, A01, A02, A03, A04, A05, A06, A07, A08, A09, A10, A11 =
			buffer.readf64(ElementA, 0), buffer.readf64(ElementA, 8),
			buffer.readf64(ElementA, 16), buffer.readf64(ElementA, 24),
			buffer.readf64(ElementA, 32), buffer.readf64(ElementA, 40),
			buffer.readf64(ElementA, 48), buffer.readf64(ElementA, 56),
			buffer.readf64(ElementA, 64), buffer.readf64(ElementA, 72),
			buffer.readf64(ElementA, 80), buffer.readf64(ElementA, 88)

		local Buf = buffer.create(SIZE)

		buffer.writef64(Buf, 0, -A00)
		buffer.writef64(Buf, 8, -A01)
		buffer.writef64(Buf, 16, -A02)
		buffer.writef64(Buf, 24, -A03)
		buffer.writef64(Buf, 32, -A04)
		buffer.writef64(Buf, 40, -A05)
		buffer.writef64(Buf, 48, -A06)
		buffer.writef64(Buf, 56, -A07)
		buffer.writef64(Buf, 64, -A08)
		buffer.writef64(Buf, 72, -A09)
		buffer.writef64(Buf, 80, -A10)
		buffer.writef64(Buf, 88, -A11)

		return Buf
	end

	function FieldPrime.Add(ElementA: buffer, ElementB: buffer, Storage: buffer?): buffer
		local A00, A01, A02, A03, A04, A05, A06, A07, A08, A09, A10, A11 =
			buffer.readf64(ElementA, 0), buffer.readf64(ElementA, 8),
			buffer.readf64(ElementA, 16), buffer.readf64(ElementA, 24),
			buffer.readf64(ElementA, 32), buffer.readf64(ElementA, 40),
			buffer.readf64(ElementA, 48), buffer.readf64(ElementA, 56),
			buffer.readf64(ElementA, 64), buffer.readf64(ElementA, 72),
			buffer.readf64(ElementA, 80), buffer.readf64(ElementA, 88)

		local B00, B01, B02, B03, B04, B05, B06, B07, B08, B09, B10, B11 =
			buffer.readf64(ElementB, 0), buffer.readf64(ElementB, 8),
			buffer.readf64(ElementB, 16), buffer.readf64(ElementB, 24),
			buffer.readf64(ElementB, 32), buffer.readf64(ElementB, 40),
			buffer.readf64(ElementB, 48), buffer.readf64(ElementB, 56),
			buffer.readf64(ElementB, 64), buffer.readf64(ElementB, 72),
			buffer.readf64(ElementB, 80), buffer.readf64(ElementB, 88)

		local Buf = Storage or buffer.create(SIZE)

		buffer.writef64(Buf, 0, A00 + B00)
		buffer.writef64(Buf, 8, A01 + B01)
		buffer.writef64(Buf, 16, A02 + B02)
		buffer.writef64(Buf, 24, A03 + B03)
		buffer.writef64(Buf, 32, A04 + B04)
		buffer.writef64(Buf, 40, A05 + B05)
		buffer.writef64(Buf, 48, A06 + B06)
		buffer.writef64(Buf, 56, A07 + B07)
		buffer.writef64(Buf, 64, A08 + B08)
		buffer.writef64(Buf, 72, A09 + B09)
		buffer.writef64(Buf, 80, A10 + B10)
		buffer.writef64(Buf, 88, A11 + B11)

		return Buf
	end

	function FieldPrime.Sub(ElementA: buffer, ElementB: buffer, Storage: buffer?): buffer
		local A00, A01, A02, A03, A04, A05, A06, A07, A08, A09, A10, A11 =
			buffer.readf64(ElementA, 0), buffer.readf64(ElementA, 8),
			buffer.readf64(ElementA, 16), buffer.readf64(ElementA, 24),
			buffer.readf64(ElementA, 32), buffer.readf64(ElementA, 40),
			buffer.readf64(ElementA, 48), buffer.readf64(ElementA, 56),
			buffer.readf64(ElementA, 64), buffer.readf64(ElementA, 72),
			buffer.readf64(ElementA, 80), buffer.readf64(ElementA, 88)

		local B00, B01, B02, B03, B04, B05, B06, B07, B08, B09, B10, B11 =
			buffer.readf64(ElementB, 0), buffer.readf64(ElementB, 8),
			buffer.readf64(ElementB, 16), buffer.readf64(ElementB, 24),
			buffer.readf64(ElementB, 32), buffer.readf64(ElementB, 40),
			buffer.readf64(ElementB, 48), buffer.readf64(ElementB, 56),
			buffer.readf64(ElementB, 64), buffer.readf64(ElementB, 72),
			buffer.readf64(ElementB, 80), buffer.readf64(ElementB, 88)

		local Buf = Storage or buffer.create(SIZE)

		buffer.writef64(Buf, 0, A00 - B00)
		buffer.writef64(Buf, 8, A01 - B01)
		buffer.writef64(Buf, 16, A02 - B02)
		buffer.writef64(Buf, 24, A03 - B03)
		buffer.writef64(Buf, 32, A04 - B04)
		buffer.writef64(Buf, 40, A05 - B05)
		buffer.writef64(Buf, 48, A06 - B06)
		buffer.writef64(Buf, 56, A07 - B07)
		buffer.writef64(Buf, 64, A08 - B08)
		buffer.writef64(Buf, 72, A09 - B09)
		buffer.writef64(Buf, 80, A10 - B10)
		buffer.writef64(Buf, 88, A11 - B11)

		return Buf
	end

	function FieldPrime.Carry(ElementA: buffer, Storage: buffer?): buffer
		local A00, A01, A02, A03, A04, A05, A06, A07, A08, A09, A10, A11 =
			buffer.readf64(ElementA, 0), buffer.readf64(ElementA, 8),
			buffer.readf64(ElementA, 16), buffer.readf64(ElementA, 24),
			buffer.readf64(ElementA, 32), buffer.readf64(ElementA, 40),
			buffer.readf64(ElementA, 48), buffer.readf64(ElementA, 56),
			buffer.readf64(ElementA, 64), buffer.readf64(ElementA, 72),
			buffer.readf64(ElementA, 80), buffer.readf64(ElementA, 88)

		local C00, C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11

		C11 = A11 + 3 * 2 ^ 306 - 3 * 2 ^ 306
		A00 += 19 / 2 ^ 255 * C11

		C00 = A00 + 3 * 2 ^ 73 - 3 * 2 ^ 73
		A01 += C00
		C01 = A01 + 3 * 2 ^ 94 - 3 * 2 ^ 94
		A02 += C01
		C02 = A02 + 3 * 2 ^ 115 - 3 * 2 ^ 115
		A03 += C02
		C03 = A03 + 3 * 2 ^ 136 - 3 * 2 ^ 136
		A04 += C03
		C04 = A04 + 3 * 2 ^ 158 - 3 * 2 ^ 158
		A05 += C04
		C05 = A05 + 3 * 2 ^ 179 - 3 * 2 ^ 179
		A06 += C05
		C06 = A06 + 3 * 2 ^ 200 - 3 * 2 ^ 200
		A07 += C06
		C07 = A07 + 3 * 2 ^ 221 - 3 * 2 ^ 221
		A08 += C07
		C08 = A08 + 3 * 2 ^ 243 - 3 * 2 ^ 243
		A09 += C08
		C09 = A09 + 3 * 2 ^ 264 - 3 * 2 ^ 264
		A10 += C09
		C10 = A10 + 3 * 2 ^ 285 - 3 * 2 ^ 285
		A11 = A11 - C11 + C10

		C11 = A11 + 3 * 2 ^ 306 - 3 * 2 ^ 306

		local Buf = Storage or buffer.create(SIZE)

		buffer.writef64(Buf, 0, A00 - C00 + 19 / 2 ^ 255 * C11)
		buffer.writef64(Buf, 8, A01 - C01)
		buffer.writef64(Buf, 16, A02 - C02)
		buffer.writef64(Buf, 24, A03 - C03)
		buffer.writef64(Buf, 32, A04 - C04)
		buffer.writef64(Buf, 40, A05 - C05)
		buffer.writef64(Buf, 48, A06 - C06)
		buffer.writef64(Buf, 56, A07 - C07)
		buffer.writef64(Buf, 64, A08 - C08)
		buffer.writef64(Buf, 72, A09 - C09)
		buffer.writef64(Buf, 80, A10 - C10)
		buffer.writef64(Buf, 88, A11 - C11)

		return Buf
	end

	function FieldPrime.Canonicalize(ElementA: buffer, Storage: buffer?): buffer
		local A00, A01, A02, A03, A04, A05, A06, A07, A08, A09, A10, A11 =
			buffer.readf64(ElementA, 0), buffer.readf64(ElementA, 8),
			buffer.readf64(ElementA, 16), buffer.readf64(ElementA, 24),
			buffer.readf64(ElementA, 32), buffer.readf64(ElementA, 40),
			buffer.readf64(ElementA, 48), buffer.readf64(ElementA, 56),
			buffer.readf64(ElementA, 64), buffer.readf64(ElementA, 72),
			buffer.readf64(ElementA, 80), buffer.readf64(ElementA, 88)

		local C00, C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11

		C00 = A00 % 2 ^ 22
		A01 += A00 - C00
		C01 = A01 % 2 ^ 43
		A02 += A01 - C01
		C02 = A02 % 2 ^ 64
		A03 += A02 - C02
		C03 = A03 % 2 ^ 85
		A04 += A03 - C03
		C04 = A04 % 2 ^ 107
		A05 += A04 - C04
		C05 = A05 % 2 ^ 128
		A06 += A05 - C05
		C06 = A06 % 2 ^ 149
		A07 += A06 - C06
		C07 = A07 % 2 ^ 170
		A08 += A07 - C07
		C08 = A08 % 2 ^ 192
		A09 += A08 - C08
		C09 = A09 % 2 ^ 213
		A10 += A09 - C09
		C10 = A10 % 2 ^ 234
		A11 += A10 - C10
		C11 = A11 % 2 ^ 255
		C00 += 19 / 2 ^ 255 * (A11 - C11)

		local Buf = Storage or buffer.create(SIZE)
		if C11 / 2 ^ 234 == 2 ^ 21 - 1
			and C10 / 2 ^ 213 == 2 ^ 21 - 1
			and C09 / 2 ^ 192 == 2 ^ 21 - 1
			and C08 / 2 ^ 170 == 2 ^ 22 - 1
			and C07 / 2 ^ 149 == 2 ^ 21 - 1
			and C06 / 2 ^ 128 == 2 ^ 21 - 1
			and C05 / 2 ^ 107 == 2 ^ 21 - 1
			and C04 / 2 ^ 85 == 2 ^ 22 - 1
			and C03 / 2 ^ 64 == 2 ^ 21 - 1
			and C02 / 2 ^ 43 == 2 ^ 21 - 1
			and C01 / 2 ^ 22 == 2 ^ 21 - 1
			and C00 >= 2 ^ 22 - 19
		then
			buffer.writef64(Buf, 0, 19 - 2 ^ 22 + C00)
			for Index = 8, 88, 8 do
				buffer.writef64(Buf, Index, 0)
			end
		else
			buffer.writef64(Buf, 0, C00)
			buffer.writef64(Buf, 8, C01)
			buffer.writef64(Buf, 16, C02)
			buffer.writef64(Buf, 24, C03)
			buffer.writef64(Buf, 32, C04)
			buffer.writef64(Buf, 40, C05)
			buffer.writef64(Buf, 48, C06)
			buffer.writef64(Buf, 56, C07)
			buffer.writef64(Buf, 64, C08)
			buffer.writef64(Buf, 72, C09)
			buffer.writef64(Buf, 80, C10)
			buffer.writef64(Buf, 88, C11)
		end

		return Buf
	end

	function FieldPrime.Eq(ElementA: buffer, ElementB: buffer): boolean
		local Difference = FieldPrime.Canonicalize(FieldPrime.Sub(ElementA, ElementB))
		local DifferenceAccumulator = 0
		for LimbIndex = 0, 88, 8 do
			local LimbLow = buffer.readu32(Difference, LimbIndex)
			local LimbHigh = buffer.readu32(Difference, LimbIndex + 4)
			DifferenceAccumulator = bit32.bor(DifferenceAccumulator, LimbLow, LimbHigh)
		end

		return DifferenceAccumulator == 0
	end

	local A00: number, A01: number, A02: number, A03: number, A04: number, A05: number, A06: number,
	A07: number, A08: number, A09: number, A10: number, A11: number
	local B00: number, B01: number, B02: number, B03: number, B04: number, B05: number, B06: number,
	B07: number, B08: number, B09: number, B10: number, B11: number

	function FieldPrime.Mul(ElementA: buffer, ElementB: buffer, Storage: buffer?): buffer
		local CompoundV = COMPOUND_V
		A00, A01, A02, A03, A04, A05, A06, A07, A08, A09, A10, A11 =
			buffer.readf64(ElementA, 0), buffer.readf64(ElementA, 8),
			buffer.readf64(ElementA, 16), buffer.readf64(ElementA, 24),
			buffer.readf64(ElementA, 32), buffer.readf64(ElementA, 40),
			buffer.readf64(ElementA, 48), buffer.readf64(ElementA, 56),
			buffer.readf64(ElementA, 64), buffer.readf64(ElementA, 72),
			buffer.readf64(ElementA, 80), buffer.readf64(ElementA, 88)

		B00, B01, B02, B03, B04, B05, B06, B07, B08, B09, B10, B11 =
			buffer.readf64(ElementB, 0), buffer.readf64(ElementB, 8),
			buffer.readf64(ElementB, 16), buffer.readf64(ElementB, 24),
			buffer.readf64(ElementB, 32), buffer.readf64(ElementB, 40),
			buffer.readf64(ElementB, 48), buffer.readf64(ElementB, 56),
			buffer.readf64(ElementB, 64), buffer.readf64(ElementB, 72),
			buffer.readf64(ElementB, 80), buffer.readf64(ElementB, 88)

		local T00: number, T01: number, T02: number, T03: number, T04: number, T05: number, T06: number,
		T07: number, T08: number, T09: number, T10: number, T11: number =
			A00, A01, A02, A03, A04, A05, A06, A07, A08, A09, A10, A11

		local U00: number, U01: number, U02: number, U03: number, U04: number, U05: number, U06: number,
		U07: number, U08: number, U09: number, U10: number, U11: number =
			B00, B01, B02, B03, B04, B05, B06, B07, B08, B09, B10, B11

		local C00 = T11 * U01
			+ T10 * U02
			+ T09 * U03
			+ T08 * U04
			+ T07 * U05
			+ T06 * U06
			+ T05 * U07
			+ T04 * U08
			+ T03 * U09
			+ T02 * U10
			+ T01 * U11

		local C01 = T11 * U02
			+ T10 * U03
			+ T09 * U04
			+ T08 * U05
			+ T07 * U06
			+ T06 * U07
			+ T05 * U08
			+ T04 * U09
			+ T03 * U10
			+ T02 * U11

		local C02 = T11 * U03
			+ T10 * U04
			+ T09 * U05
			+ T08 * U06
			+ T07 * U07
			+ T06 * U08
			+ T05 * U09
			+ T04 * U10
			+ T03 * U11

		local C03 = T11 * U04
			+ T10 * U05
			+ T09 * U06
			+ T08 * U07
			+ T07 * U08
			+ T06 * U09
			+ T05 * U10
			+ T04 * U11

		local C04 = T11 * U05
			+ T10 * U06
			+ T09 * U07
			+ T08 * U08
			+ T07 * U09
			+ T06 * U10
			+ T05 * U11

		local C05 = T11 * U06
			+ T10 * U07
			+ T09 * U08
			+ T08 * U09
			+ T07 * U10
			+ T06 * U11

		local C06 = T11 * U07
			+ T10 * U08
			+ T09 * U09
			+ T08 * U10
			+ T07 * U11

		local C07 = T11 * U08
			+ T10 * U09
			+ T09 * U10
			+ T08 * U11

		local C08 = T11 * U09
			+ T10 * U10
			+ T09 * U11

		local C09 = T11 * U10 + T10 * U11
		local C10 = T11 * U11

		C00 *= CompoundV
		C00 += T00 * U00

		C01 *= CompoundV
		C01 += T01 * U00
			+ T00 * U01

		C02 *= CompoundV
		C02 += T02 * U00
			+ T01 * U01
			+ T00 * U02

		C03 *= CompoundV
		C03 += T03 * U00
			+ T02 * U01
			+ T01 * U02
			+ T00 * U03

		C04 *= CompoundV
		C04 += T04 * U00
			+ T03 * U01
			+ T02 * U02
			+ T01 * U03
			+ T00 * U04

		C05 *= CompoundV
		C05 += T05 * U00
			+ T04 * U01
			+ T03 * U02
			+ T02 * U03
			+ T01 * U04
			+ T00 * U05

		C06 *= CompoundV
		C06 += T06 * U00
			+ T05 * U01
			+ T04 * U02
			+ T03 * U03
			+ T02 * U04
			+ T01 * U05
			+ T00 * U06

		C07 *= CompoundV
		C07 += T07 * U00
			+ T06 * U01
			+ T05 * U02
			+ T04 * U03
			+ T03 * U04
			+ T02 * U05
			+ T01 * U06
			+ T00 * U07

		C08 *= CompoundV
		C08 += T08 * U00
			+ T07 * U01
			+ T06 * U02
			+ T05 * U03
			+ T04 * U04
			+ T03 * U05
			+ T02 * U06
			+ T01 * U07
			+ T00 * U08

		C09 *= CompoundV
		C09 += T09 * U00
			+ T08 * U01
			+ T07 * U02
			+ T06 * U03
			+ T05 * U04
			+ T04 * U05
			+ T03 * U06
			+ T02 * U07
			+ T01 * U08
			+ T00 * U09

		C10 *= CompoundV
		C10 += T10 * U00
			+ T09 * U01
			+ T08 * U02
			+ T07 * U03
			+ T06 * U04
			+ T05 * U05
			+ T04 * U06
			+ T03 * U07
			+ T02 * U08
			+ T01 * U09
			+ T00 * U10

		local C11 = T11 * U00
			+ T10 * U01
			+ T09 * U02
			+ T08 * U03
			+ T07 * U04
			+ T06 * U05
			+ T05 * U06
			+ T04 * U07
			+ T03 * U08
			+ T02 * U09
			+ T01 * U10
			+ T00 * U11

		T10 = C10 + 3 * 2 ^ 285 - 3 * 2 ^ 285
		C11 += T10
		T11 = C11 + 3 * 2 ^ 306 - 3 * 2 ^ 306
		C00 += CompoundV * T11

		T00 = C00 + 3 * 2 ^ 73 - 3 * 2 ^ 73
		C01 += T00
		T01 = C01 + 3 * 2 ^ 94 - 3 * 2 ^ 94
		C02 += T01
		T02 = C02 + 3 * 2 ^ 115 - 3 * 2 ^ 115
		C03 += T02
		T03 = C03 + 3 * 2 ^ 136 - 3 * 2 ^ 136
		C04 += T03
		T04 = C04 + 3 * 2 ^ 158 - 3 * 2 ^ 158
		C05 += T04
		T05 = C05 + 3 * 2 ^ 179 - 3 * 2 ^ 179
		C06 += T05
		T06 = C06 + 3 * 2 ^ 200 - 3 * 2 ^ 200
		C07 += T06
		T07 = C07 + 3 * 2 ^ 221 - 3 * 2 ^ 221
		C08 += T07
		T08 = C08 + 3 * 2 ^ 243 - 3 * 2 ^ 243
		C09 += T08
		T09 = C09 + 3 * 2 ^ 264 - 3 * 2 ^ 264
		C10 = C10 - T10 + T09
		T10 = C10 + 3 * 2 ^ 285 - 3 * 2 ^ 285
		C11 = C11 - T11 + T10

		T11 = C11 + 3 * 2 ^ 306 - 3 * 2 ^ 306

		local Buf = Storage or buffer.create(SIZE)

		buffer.writef64(Buf, 0, C00 - T00 + CompoundV * T11)
		buffer.writef64(Buf, 8, C01 - T01)
		buffer.writef64(Buf, 16, C02 - T02)
		buffer.writef64(Buf, 24, C03 - T03)
		buffer.writef64(Buf, 32, C04 - T04)
		buffer.writef64(Buf, 40, C05 - T05)
		buffer.writef64(Buf, 48, C06 - T06)
		buffer.writef64(Buf, 56, C07 - T07)
		buffer.writef64(Buf, 64, C08 - T08)
		buffer.writef64(Buf, 72, C09 - T09)
		buffer.writef64(Buf, 80, C10 - T10)
		buffer.writef64(Buf, 88, C11 - T11)

		return Buf
	end

	function FieldPrime.Square(ElementA: buffer, Storage: buffer?): buffer
		local A00, A01, A02, A03, A04, A05, A06, A07, A08, A09, A10, A11 =
			buffer.readf64(ElementA, 0), buffer.readf64(ElementA, 8),
			buffer.readf64(ElementA, 16), buffer.readf64(ElementA, 24),
			buffer.readf64(ElementA, 32), buffer.readf64(ElementA, 40),
			buffer.readf64(ElementA, 48), buffer.readf64(ElementA, 56),
			buffer.readf64(ElementA, 64), buffer.readf64(ElementA, 72),
			buffer.readf64(ElementA, 80), buffer.readf64(ElementA, 88)

		local D00 = A00 * 2
		local D01 = A01 * 2
		local D02 = A02 * 2
		local D03 = A03 * 2
		local D04 = A04 * 2
		local D05 = A05 * 2
		local D06 = A06 * 2
		local D07 = A07 * 2
		local D08 = A08 * 2
		local D09 = A09 * 2
		local D10 = A10 * 2

		local ReductionFactor = 19 / 2 ^ 255

		local H00 = A11 * D01 + A10 * D02 + A09 * D03 + A08 * D04 + A07 * D05 + A06 * A06
		local H01 = A11 * D02 + A10 * D03 + A09 * D04 + A08 * D05 + A07 * D06
		local H02 = A11 * D03 + A10 * D04 + A09 * D05 + A08 * D06 + A07 * A07
		local H03 = A11 * D04 + A10 * D05 + A09 * D06 + A08 * D07
		local H04 = A11 * D05 + A10 * D06 + A09 * D07 + A08 * A08
		local H05 = A11 * D06 + A10 * D07 + A09 * D08
		local H06 = A11 * D07 + A10 * D08 + A09 * A09
		local H07 = A11 * D08 + A10 * D09
		local H08 = A11 * D09 + A10 * A10
		local H09 = A11 * D10
		local H10 = A11 * A11

		local L00 = A00 * A00
		local L01 = A01 * D00
		local L02 = A02 * D00 + A01 * A01
		local L03 = A03 * D00 + A02 * D01
		local L04 = A04 * D00 + A03 * D01 + A02 * A02
		local L05 = A05 * D00 + A04 * D01 + A03 * D02
		local L06 = A06 * D00 + A05 * D01 + A04 * D02 + A03 * A03
		local L07 = A07 * D00 + A06 * D01 + A05 * D02 + A04 * D03
		local L08 = A08 * D00 + A07 * D01 + A06 * D02 + A05 * D03 + A04 * A04
		local L09 = A09 * D00 + A08 * D01 + A07 * D02 + A06 * D03 + A05 * D04
		local L10 = A10 * D00 + A09 * D01 + A08 * D02 + A07 * D03 + A06 * D04 + A05 * A05
		local L11 = A11 * D00 + A10 * D01 + A09 * D02 + A08 * D03 + A07 * D04 + A06 * D05

		local Result = Storage or buffer.create(SIZE)
		buffer.writef64(Result, 0, H00 * ReductionFactor + L00)
		buffer.writef64(Result, 8, H01 * ReductionFactor + L01)
		buffer.writef64(Result, 16, H02 * ReductionFactor + L02)
		buffer.writef64(Result, 24, H03 * ReductionFactor + L03)
		buffer.writef64(Result, 32, H04 * ReductionFactor + L04)
		buffer.writef64(Result, 40, H05 * ReductionFactor + L05)
		buffer.writef64(Result, 48, H06 * ReductionFactor + L06)
		buffer.writef64(Result, 56, H07 * ReductionFactor + L07)
		buffer.writef64(Result, 64, H08 * ReductionFactor + L08)
		buffer.writef64(Result, 72, H09 * ReductionFactor + L09)
		buffer.writef64(Result, 80, H10 * ReductionFactor + L10)
		buffer.writef64(Result, 88, L11)

		return FieldPrime.Carry(Result, Result)
	end

	function FieldPrime.KMul(ElementA: buffer, SmallK: number, Storage: buffer?): buffer
		local A00, A01, A02, A03, A04, A05, A06, A07, A08, A09, A10, A11 =
			buffer.readf64(ElementA, 0), buffer.readf64(ElementA, 8),
			buffer.readf64(ElementA, 16), buffer.readf64(ElementA, 24),
			buffer.readf64(ElementA, 32), buffer.readf64(ElementA, 40),
			buffer.readf64(ElementA, 48), buffer.readf64(ElementA, 56),
			buffer.readf64(ElementA, 64), buffer.readf64(ElementA, 72),
			buffer.readf64(ElementA, 80), buffer.readf64(ElementA, 88)

		local C00, C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11

		A00 *= SmallK
		A01 *= SmallK
		A02 *= SmallK
		A03 *= SmallK
		A04 *= SmallK
		A05 *= SmallK
		A06 *= SmallK
		A07 *= SmallK
		A08 *= SmallK
		A09 *= SmallK
		A10 *= SmallK
		A11 *= SmallK

		C11 = A11 + 3 * 2 ^ 306 - 3 * 2 ^ 306
		A00 += 19 / 2 ^ 255 * C11

		C00 = A00 + 3 * 2 ^ 73 - 3 * 2 ^ 73
		A01 += C00
		C01 = A01 + 3 * 2 ^ 94 - 3 * 2 ^ 94
		A02 += C01
		C02 = A02 + 3 * 2 ^ 115 - 3 * 2 ^ 115
		A03 += C02
		C03 = A03 + 3 * 2 ^ 136 - 3 * 2 ^ 136
		A04 += C03
		C04 = A04 + 3 * 2 ^ 158 - 3 * 2 ^ 158
		A05 += C04
		C05 = A05 + 3 * 2 ^ 179 - 3 * 2 ^ 179
		A06 += C05
		C06 = A06 + 3 * 2 ^ 200 - 3 * 2 ^ 200
		A07 += C06
		C07 = A07 + 3 * 2 ^ 221 - 3 * 2 ^ 221
		A08 += C07
		C08 = A08 + 3 * 2 ^ 243 - 3 * 2 ^ 243
		A09 += C08
		C09 = A09 + 3 * 2 ^ 264 - 3 * 2 ^ 264
		A10 += C09
		C10 = A10 + 3 * 2 ^ 285 - 3 * 2 ^ 285
		A11 = A11 - C11 + C10

		C11 = A11 + 3 * 2 ^ 306 - 3 * 2 ^ 306

		local Buf = Storage or buffer.create(SIZE)

		buffer.writef64(Buf, 0, A00 - C00 + 19 / 2 ^ 255 * C11)
		buffer.writef64(Buf, 8, A01 - C01)
		buffer.writef64(Buf, 16, A02 - C02)
		buffer.writef64(Buf, 24, A03 - C03)
		buffer.writef64(Buf, 32, A04 - C04)
		buffer.writef64(Buf, 40, A05 - C05)
		buffer.writef64(Buf, 48, A06 - C06)
		buffer.writef64(Buf, 56, A07 - C07)
		buffer.writef64(Buf, 64, A08 - C08)
		buffer.writef64(Buf, 72, A09 - C09)
		buffer.writef64(Buf, 80, A10 - C10)
		buffer.writef64(Buf, 88, A11 - C11)

		return Buf
	end

	function FieldPrime.NSquare(ElementA: buffer, SquareCount: number, StoreInBuffer: boolean?): buffer
		local Square = FieldPrime.Square
		if StoreInBuffer then
			for _ = 1, SquareCount do
				Square(ElementA, ElementA)
			end

			return ElementA
		else
			for _ = 1, SquareCount do
				ElementA = Square(ElementA)
			end

			return ElementA
		end
	end

	function FieldPrime.Invert(ElementA: buffer, Storage: buffer?): buffer
		local Mul = FieldPrime.Mul

		local A2 = FieldPrime.Square(ElementA)
		local A9 = Mul(ElementA, FieldPrime.NSquare(A2, 2))
		local A11 = Mul(A9, A2)

		local X5 = Mul(FieldPrime.Square(A11), A9)
		local X10 = Mul(FieldPrime.NSquare(X5, 5), X5)
		local X20 = Mul(FieldPrime.NSquare(X10, 10), X10)
		local X40 = Mul(FieldPrime.NSquare(X20, 20), X20)
		local X50 = Mul(FieldPrime.NSquare(X40, 10), X10)
		local X100 = Mul(FieldPrime.NSquare(X50, 50), X50)
		local X200 = Mul(FieldPrime.NSquare(X100, 100), X100)
		local X250 = Mul(FieldPrime.NSquare(X200, 50), X50)

		return Mul(FieldPrime.NSquare(X250, 5), A11, Storage)
	end

	function FieldPrime.SqrtDiv(ElementU: buffer, ElementV: buffer): buffer?
		local Mul = FieldPrime.Mul
		local Square = FieldPrime.Square
		local Carry = FieldPrime.Carry

		Carry(ElementU, ElementU)

		local V2 = Square(ElementV)
		local V3 = Mul(ElementV, V2)
		local UV3 = Mul(ElementU, V3)
		local V4 = Square(V2)
		local UV7 = Mul(UV3, V4)

		local X2 = Mul(Square(UV7), UV7)
		local X4 = Mul(FieldPrime.NSquare(X2, 2), X2)
		local X8 = Mul(FieldPrime.NSquare(X4, 4), X4)
		local X16 = Mul(FieldPrime.NSquare(X8, 8), X8)
		local X18 = Mul(FieldPrime.NSquare(X16, 2), X2)
		local X32 = Mul(FieldPrime.NSquare(X16, 16), X16)
		local X50 = Mul(FieldPrime.NSquare(X32, 18), X18)
		local X100 = Mul(FieldPrime.NSquare(X50, 50), X50)
		local X200 = Mul(FieldPrime.NSquare(X100, 100), X100)
		local X250 = Mul(FieldPrime.NSquare(X200, 50), X50)
		local PowerResult = Mul(FieldPrime.NSquare(X250, 2), UV7)

		local CandidateB = Mul(UV3, PowerResult)
		local B2 = Square(CandidateB)
		local VB2 = Mul(ElementV, B2)

		if not FieldPrime.Eq(VB2, ElementU) then
			CandidateB = Mul(CandidateB, SQUARES)
			B2 = Square(CandidateB)
			VB2 = Mul(ElementV, B2)
		end

		if FieldPrime.Eq(VB2, ElementU) then
			return CandidateB
		else
			return nil
		end
	end

	function FieldPrime.Encode(ElementA: buffer): buffer
		ElementA = FieldPrime.Canonicalize(ElementA)
		local A00, A01, A02, A03, A04, A05, A06, A07, A08, A09, A10, A11 =
			buffer.readf64(ElementA, 0), buffer.readf64(ElementA, 8),
			buffer.readf64(ElementA, 16), buffer.readf64(ElementA, 24),
			buffer.readf64(ElementA, 32), buffer.readf64(ElementA, 40),
			buffer.readf64(ElementA, 48), buffer.readf64(ElementA, 56),
			buffer.readf64(ElementA, 64), buffer.readf64(ElementA, 72),
			buffer.readf64(ElementA, 80), buffer.readf64(ElementA, 88)

		local Buf = buffer.create(32)
		local ByteIndex = 0
		local Accumulator = A00

		local Byte0 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte0)
		Accumulator = (Accumulator - Byte0) / 256
		ByteIndex += 1

		local Byte1 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte1)
		Accumulator = (Accumulator - Byte1) / 256
		ByteIndex += 1

		Accumulator += A01 / 2 ^ 16

		Byte0 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte0)
		Accumulator = (Accumulator - Byte0) / 256
		ByteIndex += 1

		Byte1 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte1)
		Accumulator = (Accumulator - Byte1) / 256
		ByteIndex += 1

		local Byte2 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte2)
		Accumulator = (Accumulator - Byte2) / 256
		ByteIndex += 1

		Accumulator += A02 / 2 ^ 40

		Byte0 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte0)
		Accumulator = (Accumulator - Byte0) / 256
		ByteIndex += 1

		Byte1 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte1)
		Accumulator = (Accumulator - Byte1) / 256
		ByteIndex += 1

		Byte2 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte2)
		Accumulator = (Accumulator - Byte2) / 256
		ByteIndex += 1

		Accumulator += A03 / 2 ^ 64

		Byte0 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte0)
		Accumulator = (Accumulator - Byte0) / 256
		ByteIndex += 1

		Byte1 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte1)
		Accumulator = (Accumulator - Byte1) / 256
		ByteIndex += 1

		Accumulator += A04 / 2 ^ 80

		Byte0 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte0)
		Accumulator = (Accumulator - Byte0) / 256
		ByteIndex += 1

		Byte1 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte1)
		Accumulator = (Accumulator - Byte1) / 256
		ByteIndex += 1

		Byte2 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte2)
		Accumulator = (Accumulator - Byte2) / 256
		ByteIndex += 1

		Accumulator += A05 / 2 ^ 104

		Byte0 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte0)
		Accumulator = (Accumulator - Byte0) / 256
		ByteIndex += 1

		Byte1 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte1)
		Accumulator = (Accumulator - Byte1) / 256
		ByteIndex += 1

		Byte2 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte2)
		Accumulator = (Accumulator - Byte2) / 256
		ByteIndex += 1

		Accumulator += A06 / 2 ^ 128

		Byte0 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte0)
		Accumulator = (Accumulator - Byte0) / 256
		ByteIndex += 1

		Byte1 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte1)
		Accumulator = (Accumulator - Byte1) / 256
		ByteIndex += 1

		Accumulator += A07 / 2 ^ 144

		Byte0 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte0)
		Accumulator = (Accumulator - Byte0) / 256
		ByteIndex += 1

		Byte1 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte1)
		Accumulator = (Accumulator - Byte1) / 256
		ByteIndex += 1

		Byte2 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte2)
		Accumulator = (Accumulator - Byte2) / 256
		ByteIndex += 1

		Accumulator += A08 / 2 ^ 168

		Byte0 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte0)
		Accumulator = (Accumulator - Byte0) / 256
		ByteIndex += 1

		Byte1 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte1)
		Accumulator = (Accumulator - Byte1) / 256
		ByteIndex += 1

		Byte2 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte2)
		Accumulator = (Accumulator - Byte2) / 256
		ByteIndex += 1

		Accumulator += A09 / 2 ^ 192

		Byte0 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte0)
		Accumulator = (Accumulator - Byte0) / 256
		ByteIndex += 1

		Byte1 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte1)
		Accumulator = (Accumulator - Byte1) / 256
		ByteIndex += 1

		Accumulator += A10 / 2 ^ 208

		Byte0 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte0)
		Accumulator = (Accumulator - Byte0) / 256
		ByteIndex += 1

		Byte1 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte1)
		Accumulator = (Accumulator - Byte1) / 256
		ByteIndex += 1

		Byte2 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte2)
		Accumulator = (Accumulator - Byte2) / 256
		ByteIndex += 1

		Accumulator += A11 / 2 ^ 232

		Byte0 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte0)
		Accumulator = (Accumulator - Byte0) / 256
		ByteIndex += 1

		Byte1 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte1)
		Accumulator = (Accumulator - Byte1) / 256
		ByteIndex += 1

		Byte2 = Accumulator % 256
		buffer.writeu8(Buf, ByteIndex, Byte2)

		return Buf
	end

	function FieldPrime.Decode(EncodedBytes: buffer): buffer
		local B0, B1, B2 = buffer.readu8(EncodedBytes, 0), buffer.readu8(EncodedBytes, 1), buffer.readu8(EncodedBytes, 2)
		local W00 = B0 + B1 * 256 + B2 * 65536

		B0, B1, B2 = buffer.readu8(EncodedBytes, 3), buffer.readu8(EncodedBytes, 4), buffer.readu8(EncodedBytes, 5)
		local W01 = B0 + B1 * 256 + B2 * 65536

		local W02 = buffer.readu16(EncodedBytes, 6)

		B0, B1, B2 = buffer.readu8(EncodedBytes, 8), buffer.readu8(EncodedBytes, 9), buffer.readu8(EncodedBytes, 10)
		local W03 = B0 + B1 * 256 + B2 * 65536

		B0, B1, B2 = buffer.readu8(EncodedBytes, 11), buffer.readu8(EncodedBytes, 12), buffer.readu8(EncodedBytes, 13)
		local W04 = B0 + B1 * 256 + B2 * 65536

		local W05 = buffer.readu16(EncodedBytes, 14)

		B0, B1, B2 = buffer.readu8(EncodedBytes, 16), buffer.readu8(EncodedBytes, 17), buffer.readu8(EncodedBytes, 18)
		local W06 = B0 + B1 * 256 + B2 * 65536

		B0, B1, B2 = buffer.readu8(EncodedBytes, 19), buffer.readu8(EncodedBytes, 20), buffer.readu8(EncodedBytes, 21)
		local W07 = B0 + B1 * 256 + B2 * 65536

		local W08 = buffer.readu16(EncodedBytes, 22)

		B0, B1, B2 = buffer.readu8(EncodedBytes, 24), buffer.readu8(EncodedBytes, 25), buffer.readu8(EncodedBytes, 26)
		local W09 = B0 + B1 * 256 + B2 * 65536

		B0, B1, B2 = buffer.readu8(EncodedBytes, 27), buffer.readu8(EncodedBytes, 28), buffer.readu8(EncodedBytes, 29)
		local W10 = B0 + B1 * 256 + B2 * 65536

		local W11 = buffer.readu16(EncodedBytes, 30) % 32768

		local Buf = buffer.create(SIZE)

		buffer.writef64(Buf, 0, W00)
		buffer.writef64(Buf, 8, W01 * 2 ^ 24)
		buffer.writef64(Buf, 16, W02 * 2 ^ 48)
		buffer.writef64(Buf, 24, W03 * 2 ^ 64)
		buffer.writef64(Buf, 32, W04 * 2 ^ 88)
		buffer.writef64(Buf, 40, W05 * 2 ^ 112)
		buffer.writef64(Buf, 48, W06 * 2 ^ 128)
		buffer.writef64(Buf, 56, W07 * 2 ^ 152)
		buffer.writef64(Buf, 64, W08 * 2 ^ 176)
		buffer.writef64(Buf, 72, W09 * 2 ^ 192)
		buffer.writef64(Buf, 80, W10 * 2 ^ 216)
		buffer.writef64(Buf, 88, W11 * 2 ^ 240)

		return FieldPrime.Carry(Buf, Buf)
	end

	function FieldPrime.Eqz(ElementA: buffer): boolean
		local Canonical = FieldPrime.Canonicalize(ElementA)
		local C00, C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11 =
			buffer.readf64(Canonical, 0), buffer.readf64(Canonical, 8),
			buffer.readf64(Canonical, 16), buffer.readf64(Canonical, 24),
			buffer.readf64(Canonical, 32), buffer.readf64(Canonical, 40),
			buffer.readf64(Canonical, 48), buffer.readf64(Canonical, 56),
			buffer.readf64(Canonical, 64), buffer.readf64(Canonical, 72),
			buffer.readf64(Canonical, 80), buffer.readf64(Canonical, 88)

		return C00 + C01 + C02 + C03 + C04 + C05 + C06 + C07 + C08 + C09 + C10 + C11 == 0
	end

	return FieldPrime

end }

__mods["crypto/EdDSA/FieldQuadratic"] = { dir = "crypto/EdDSA", fn = function(require)
	--[=[
		Cryptography library: Field Quadratic (Curve25519 Scalar Field)

		Return type: varies by function
		Example usage:
			local FieldQuadratic = require("FieldQuadratic")

			--------Usage Case 1: Basic scalar arithmetic--------
			local ScalarA = FieldQuadratic.Decode(SomeBytes)
			local ScalarB = FieldQuadratic.Decode(OtherBytes)
			local Sum = FieldQuadratic.Add(ScalarA, ScalarB)
			local Product = FieldQuadratic.Mul(ScalarA, ScalarB)

			--------Usage Case 2: Convert to bits for scalar multiplication--------
			local ScalarBits = FieldQuadratic.Bits(ScalarA)
			local EncodedResult = FieldQuadratic.Encode(Product)
	--]=]

	--!strict
	--!optimize 2
	--!native

	local MultiPrecision = require("./MultiPrecision")

	local CONSTANT_ZERO = MultiPrecision.Num(0)

	local OUTPUT_BUFFER = buffer.create(8192)
	local RULE_BUFFER = buffer.create(8192)
	local DECODE_WIDE_LOW = buffer.create(96)
	local DECODE_WIDE_HIGH = buffer.create(96)
	local DECODE_BUFFER = buffer.create(96)
	local CLAMPED_BUFFER = buffer.create(32)

	local FIELD_ORDER_BYTES = buffer.create(32) do
		local Bytes = {
			0xed, 0xd3, 0xf5, 0x5c, 0x1a, 0x63, 0x12, 0x58,
			0xd6, 0x9c, 0xf7, 0xa2, 0xde, 0xf9, 0xde, 0x14,
			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10
		}
		for Index = 1, 32 do
			buffer.writeu8(FIELD_ORDER_BYTES, Index - 1, Bytes[Index])
		end
	end

	local FIELD_ORDER = buffer.create(96) do
		local ByteIndex = 0

		for LimbIndex = 0, 9 do
			local Value = buffer.readu8(FIELD_ORDER_BYTES, ByteIndex)
				+ buffer.readu8(FIELD_ORDER_BYTES, ByteIndex + 1) * 256
				+ buffer.readu8(FIELD_ORDER_BYTES, ByteIndex + 2) * 65536

			buffer.writef64(FIELD_ORDER, LimbIndex * 8, Value)
			ByteIndex += 3
		end

		local LastValue = buffer.readu8(FIELD_ORDER_BYTES, 30)
			+ buffer.readu8(FIELD_ORDER_BYTES, 31) * 256
		buffer.writef64(FIELD_ORDER, 10 * 8, LastValue)
	end

	local MONTGOMERY_T0 = buffer.create(96) do
		local Values = {
			05537307, 01942290, 16765621, 16628356, 10618610,
			07072433, 03735459, 01369940, 15276086, 13038191,
			13409718
		}
		for Index = 1, 11 do
			buffer.writef64(MONTGOMERY_T0, (Index - 1) * 8, Values[Index])
		end
	end

	local MONTGOMERY_T1 = buffer.create(96) do
		local Values = {
			11711996, 01747860, 08326961, 03814718, 01859974,
			13327461, 16105061, 07590423, 04050668, 08138906,
			00000283
		}
		for Index = 1, 11 do
			buffer.writef64(MONTGOMERY_T1, (Index - 1) * 8, Values[Index])
		end
	end

	local DIVIDE_8 = buffer.create(96) do
		local Values = {
			5110253, 3039345, 2503500, 11779568, 15416472,
			16766550, 16777215, 16777215, 16777215, 16777215,
			4095
		}
		for Index = 1, 11 do
			buffer.writef64(DIVIDE_8, (Index - 1) * 8, Values[Index])
		end
	end

	local function Reduce(LargeNumber: buffer): buffer
		local Difference = MultiPrecision.Sub(LargeNumber, FIELD_ORDER)

		if MultiPrecision.Approx(Difference) < 0 then
			return MultiPrecision.Carry(LargeNumber)
		end

		return MultiPrecision.Carry(Difference)
	end

	local function Demontgomery(MontgomeryScalar: buffer): buffer
		local ReductionLow, ReductionHigh = MultiPrecision.Mul(MultiPrecision.LMul(MontgomeryScalar, MONTGOMERY_T0), FIELD_ORDER)
		local _, ResultHigh = MultiPrecision.DWAdd(MontgomeryScalar, CONSTANT_ZERO, ReductionLow, ReductionHigh)

		return Reduce(ResultHigh)
	end

	local function RebaseLE(InputBuffer: buffer, InputLength: number, FromBase: number, ToBase: number): (buffer, number)
		local OutputLength = 0
		local Accumulator = 0
		local Multiplier = 1

		for Index = 0, InputLength - 1 do
			Accumulator += buffer.readf64(InputBuffer, Index * 8) * Multiplier
			Multiplier *= FromBase
			while Multiplier >= ToBase do
				local Remainder = Accumulator % ToBase
				Accumulator = (Accumulator - Remainder) / ToBase
				Multiplier /= ToBase
				buffer.writef64(OUTPUT_BUFFER, OutputLength * 8, Remainder)
				OutputLength += 1
			end
		end

		if Multiplier > 0 then
			buffer.writef64(OUTPUT_BUFFER, OutputLength * 8, Accumulator)
			OutputLength += 1
		end

		return OUTPUT_BUFFER, OutputLength
	end

	local FieldQuadratic = {}

	function FieldQuadratic.IsValidScalar(ScalarBytes: buffer): boolean
		local FieldOrder = FIELD_ORDER_BYTES
		local Borrow = 0

		for Index = 0, 31 do
			local ScalarByte = buffer.readu8(ScalarBytes, Index)
			local OrderByte = buffer.readu8(FieldOrder, Index)
			local Diff = ScalarByte - OrderByte - Borrow
			Borrow = 1 - bit32.rshift(Diff + 256, 8)
		end

		return Borrow == 1
	end

	function FieldQuadratic.Montgomery(RegularScalar: buffer): buffer
		return FieldQuadratic.Mul(RegularScalar, MONTGOMERY_T1)
	end

	function FieldQuadratic.Add(ScalarA: buffer, ScalarB: buffer): buffer
		return Reduce(MultiPrecision.Add(ScalarA, ScalarB))
	end

	function FieldQuadratic.Neg(ScalarA: buffer): buffer
		return Reduce(MultiPrecision.Sub(FIELD_ORDER, ScalarA))
	end

	function FieldQuadratic.Sub(ScalarA: buffer, ScalarB: buffer): buffer
		return FieldQuadratic.Add(ScalarA, FieldQuadratic.Neg(ScalarB))
	end

	function FieldQuadratic.Mul(ScalarA: buffer, ScalarB: buffer): buffer
		local ProductLow, ProductHigh = MultiPrecision.Mul(ScalarA, ScalarB)
		local ReductionLow, ReductionHigh = MultiPrecision.Mul(MultiPrecision.LMul(ProductLow, MONTGOMERY_T0), FIELD_ORDER)
		local _, ResultHigh = MultiPrecision.DWAdd(ProductLow, ProductHigh, ReductionLow, ReductionHigh)

		return Reduce(ResultHigh)
	end

	function FieldQuadratic.Encode(MontgomeryScalar: buffer): buffer
		local DemontResult = Demontgomery(MontgomeryScalar)
		local EncodedBuffer = buffer.create(32)
		local ByteIndex = 0
		for LimbIndex = 0, 9 do
			local Value = buffer.readf64(DemontResult, LimbIndex * 8)
			buffer.writeu8(EncodedBuffer, ByteIndex, Value % 256)
			Value = Value // 256
			buffer.writeu8(EncodedBuffer, ByteIndex + 1, Value % 256)
			Value = Value // 256
			buffer.writeu8(EncodedBuffer, ByteIndex + 2, Value % 256)
			ByteIndex += 3
		end

		local LastValue = buffer.readf64(DemontResult, 10 * 8)
		buffer.writeu8(EncodedBuffer, 30, LastValue % 256)
		LastValue = LastValue // 256
		buffer.writeu8(EncodedBuffer, 31, LastValue % 256)

		return EncodedBuffer
	end

	function FieldQuadratic.Decode(EncodedBuffer: buffer): buffer
		local DecodedBuffer = DECODE_BUFFER
		local ByteIndex = 0

		for LimbIndex = 0, 9 do
			local Value = buffer.readu8(EncodedBuffer, ByteIndex)
				+ buffer.readu8(EncodedBuffer, ByteIndex + 1) * 256
				+ buffer.readu8(EncodedBuffer, ByteIndex + 2) * 65536

			buffer.writef64(DecodedBuffer, LimbIndex * 8, Value)
			ByteIndex += 3
		end

		local LastValue = buffer.readu8(EncodedBuffer, 30)
			+ buffer.readu8(EncodedBuffer, 31) * 256
		buffer.writef64(DecodedBuffer, 10 * 8, LastValue)

		return FieldQuadratic.Montgomery(DecodedBuffer)
	end

	function FieldQuadratic.DecodeWide(WideBuffer: buffer): buffer
		local LowPart = DECODE_WIDE_LOW
		local HighPart = DECODE_WIDE_HIGH

		for LimbIndex = 0, 10 do
			local ByteIndex = LimbIndex * 3
			local Value = buffer.readu8(WideBuffer, ByteIndex)
				+ buffer.readu8(WideBuffer, ByteIndex + 1) * 256
				+ buffer.readu8(WideBuffer, ByteIndex + 2) * 65536
			buffer.writef64(LowPart, LimbIndex * 8, Value)
		end

		for LimbIndex = 0, 9 do
			local ByteIndex = 33 + LimbIndex * 3
			local Value = buffer.readu8(WideBuffer, ByteIndex)
				+ buffer.readu8(WideBuffer, ByteIndex + 1) * 256
				+ buffer.readu8(WideBuffer, ByteIndex + 2) * 65536
			buffer.writef64(HighPart, LimbIndex * 8, Value)
		end
		buffer.writef64(HighPart, 10 * 8, buffer.readu8(WideBuffer, 63))

		local MontLow = FieldQuadratic.Montgomery(LowPart)
		local MontHigh = FieldQuadratic.Montgomery(HighPart)
		local MontMontHigh = FieldQuadratic.Montgomery(MontHigh)

		return FieldQuadratic.Add(MontLow, MontMontHigh)
	end

	function FieldQuadratic.DecodeClamped(ClampedBuffer: buffer): buffer
		local ClampedCopy = CLAMPED_BUFFER
		buffer.copy(ClampedCopy, 0, ClampedBuffer, 0, 32)

		local FirstByte = buffer.readu8(ClampedCopy, 0)
		buffer.writeu8(ClampedCopy, 0, bit32.band(FirstByte, 0xF8))

		local LastByte = buffer.readu8(ClampedCopy, 31)
		buffer.writeu8(ClampedCopy, 31, bit32.bor(bit32.band(LastByte, 0x7F), 0x40))

		return FieldQuadratic.Decode(ClampedCopy)
	end

	function FieldQuadratic.Eighth(MontgomeryScalar: buffer): buffer
		return FieldQuadratic.Mul(MontgomeryScalar, DIVIDE_8)
	end

	function FieldQuadratic.Bits(MontgomeryScalar: buffer): (buffer, number)
		local DemontResult = Demontgomery(MontgomeryScalar)
		local BitOutput, BitCount = RebaseLE(DemontResult, 11, 2 ^ 24, 2)

		if BitCount > 253 then
			BitCount = 253
		end

		return BitOutput, BitCount
	end

	function FieldQuadratic.MakeRuleset(ScalarA: buffer, ScalarB: buffer): (buffer, number, buffer, number)
		local DTable = Demontgomery(ScalarA)
		local ETable = Demontgomery(ScalarB)
		local FTable = MultiPrecision.Sub(DTable, ETable)

		local DMod2 = MultiPrecision.Mod2(DTable)
		local EMod2 = MultiPrecision.Mod2(ETable)

		local DMod3 = MultiPrecision.Mod3(DTable)
		local EMod3 = MultiPrecision.Mod3(ETable)

		local EFloat = MultiPrecision.Approx(ETable)
		local FFloat = MultiPrecision.Approx(FTable)

		local Mod3Lut = {[0] = 0, 2, 1}

		local RuleBuffer = RULE_BUFFER
		local RuleCount = 0

		while FFloat ~= 0 do
			local Rule = -1

			if FFloat < 0 then
				Rule = 0
				DTable, ETable = ETable, DTable
				DMod2, EMod2 = EMod2, DMod2
				DMod3, EMod3 = EMod3, DMod3
				EFloat = MultiPrecision.Approx(ETable)
				FTable = MultiPrecision.Sub(DTable, ETable)
				FFloat = -FFloat
			elseif 4 * FFloat < EFloat and DMod3 == Mod3Lut[EMod3] then
				Rule = 1
				DTable, ETable = MultiPrecision.Third(MultiPrecision.Add(DTable, FTable)), MultiPrecision.Third(MultiPrecision.Sub(ETable, FTable)) :: buffer
				DMod2, EMod2 = EMod2, DMod2
				DMod3, EMod3 = MultiPrecision.Mod3(DTable), MultiPrecision.Mod3(ETable)
				EFloat = MultiPrecision.Approx(ETable)
			elseif 4 * FFloat < EFloat and DMod2 == EMod2 and DMod3 == EMod3 then
				Rule = 2
				DTable = MultiPrecision.Half(FTable)
				DMod2 = MultiPrecision.Mod2(DTable)
				DMod3 = Mod3Lut[(DMod3 - EMod3) % 3]
				FTable = MultiPrecision.Sub(DTable, ETable)
				FFloat = MultiPrecision.Approx(FTable)
			elseif FFloat < 3 * EFloat then
				Rule = 3
				DTable = MultiPrecision.CarryWeak(FTable)
				DMod2 = (DMod2 - EMod2) % 2
				DMod3 = (DMod3 - EMod3) % 3
				FTable = MultiPrecision.Sub(DTable, ETable)
				FFloat = MultiPrecision.Approx(FTable)
			elseif DMod2 == EMod2 then
				Rule = 2
				DTable = MultiPrecision.Half(FTable)
				DMod2 = MultiPrecision.Mod2(DTable)
				DMod3 = Mod3Lut[(DMod3 - EMod3) % 3]
				FTable = MultiPrecision.Sub(DTable, ETable)
				FFloat = MultiPrecision.Approx(FTable)
			elseif DMod2 == 0 then
				Rule = 5
				DTable = MultiPrecision.Half(DTable)
				DMod2 = MultiPrecision.Mod2(DTable)
				DMod3 = Mod3Lut[DMod3]
				FTable = MultiPrecision.Sub(DTable, ETable)
				FFloat = MultiPrecision.Approx(FTable)
			elseif DMod3 == 0 then
				Rule = 6
				DTable = MultiPrecision.CarryWeak(MultiPrecision.Sub(MultiPrecision.Third(DTable), ETable))
				DMod2 = (DMod2 - EMod2) % 2
				DMod3 = MultiPrecision.Mod3(DTable)
				FTable = MultiPrecision.Sub(DTable, ETable)
				FFloat = MultiPrecision.Approx(FTable)
			elseif DMod3 == Mod3Lut[EMod3] then
				Rule = 7
				DTable = MultiPrecision.Third(MultiPrecision.Sub(FTable, ETable))
				DMod3 = MultiPrecision.Mod3(DTable)
				FTable = MultiPrecision.Sub(DTable, ETable)
				FFloat = MultiPrecision.Approx(FTable)
			elseif DMod3 == EMod3 then
				Rule = 8
				DTable = MultiPrecision.Third(FTable)
				DMod2 = (DMod2 - EMod2) % 2
				DMod3 = MultiPrecision.Mod3(DTable)
				FTable = MultiPrecision.Sub(DTable, ETable)
				FFloat = MultiPrecision.Approx(FTable)
			else
				Rule = 9
				ETable = MultiPrecision.Half(ETable)
				EMod2 = MultiPrecision.Mod2(ETable)
				EMod3 = Mod3Lut[EMod3]
				EFloat = MultiPrecision.Approx(ETable)
				FTable = MultiPrecision.Sub(DTable, ETable)
				FFloat = MultiPrecision.Approx(FTable)
			end

			buffer.writef64(RuleBuffer, RuleCount * 8, Rule)
			RuleCount += 1
		end

		local FinalBits, FinalBitCount = RebaseLE(DTable, 11, 2 ^ 24, 2)
		while FinalBitCount > 0 and buffer.readf64(FinalBits, (FinalBitCount - 1) * 8) == 0 do
			FinalBitCount -= 1
		end

		return FinalBits, FinalBitCount, RuleBuffer, RuleCount
	end

	return FieldQuadratic

end }

__mods["crypto/EdDSA/MultiPrecision"] = { dir = "crypto/EdDSA", fn = function(require)
	--[=[
		Cryptography library: Multi-Precision Arithmetic (264-bit integers)

		Return type: varies by function
		Example usage:
			local MultiPrecision = require("MultiPrecision")

			--------Usage Case 1: Basic arithmetic--------
			local NumberA = MultiPrecision.Num(42)
			local NumberB = MultiPrecision.Num(17)
			local Sum = MultiPrecision.Add(NumberA, NumberB)
			local Product = MultiPrecision.Mul(NumberA, NumberB)

			--------Usage Case 2: Carry operations--------
			local LargeSum = MultiPrecision.Add(Sum, Product)
			local Normalized = MultiPrecision.Carry(LargeSum)
	--]=]

	--!strict
	--!optimize 2
	--!native

	local CARRY = 88
	local SIZE = 96

	local MultiPrecision = {}

	function MultiPrecision.CarryWeak(LargeNumber: buffer, Storage: buffer?): buffer
		local A00, A01, A02, A03, A04, A05, A06, A07, A08, A09, A10 =
			buffer.readf64(LargeNumber, 0), buffer.readf64(LargeNumber, 8),
			buffer.readf64(LargeNumber, 16), buffer.readf64(LargeNumber, 24),
			buffer.readf64(LargeNumber, 32), buffer.readf64(LargeNumber, 40),
			buffer.readf64(LargeNumber, 48), buffer.readf64(LargeNumber, 56),
			buffer.readf64(LargeNumber, 64), buffer.readf64(LargeNumber, 72),
			buffer.readf64(LargeNumber, 80)

		local Carry00 = A00 + 3 * 2 ^ 75 - 3 * 2 ^ 75; A01 += Carry00 * 2 ^ -24
		local Carry01 = A01 + 3 * 2 ^ 75 - 3 * 2 ^ 75; A02 += Carry01 * 2 ^ -24
		local Carry02 = A02 + 3 * 2 ^ 75 - 3 * 2 ^ 75; A03 += Carry02 * 2 ^ -24
		local Carry03 = A03 + 3 * 2 ^ 75 - 3 * 2 ^ 75; A04 += Carry03 * 2 ^ -24
		local Carry04 = A04 + 3 * 2 ^ 75 - 3 * 2 ^ 75; A05 += Carry04 * 2 ^ -24
		local Carry05 = A05 + 3 * 2 ^ 75 - 3 * 2 ^ 75; A06 += Carry05 * 2 ^ -24
		local Carry06 = A06 + 3 * 2 ^ 75 - 3 * 2 ^ 75; A07 += Carry06 * 2 ^ -24
		local Carry07 = A07 + 3 * 2 ^ 75 - 3 * 2 ^ 75; A08 += Carry07 * 2 ^ -24
		local Carry08 = A08 + 3 * 2 ^ 75 - 3 * 2 ^ 75; A09 += Carry08 * 2 ^ -24
		local Carry09 = A09 + 3 * 2 ^ 75 - 3 * 2 ^ 75; A10 += Carry09 * 2 ^ -24
		local Carry10 = A10 + 3 * 2 ^ 75 - 3 * 2 ^ 75

		local Buf = Storage or buffer.create(SIZE)

		buffer.writef64(Buf, 0, A00 - Carry00)
		buffer.writef64(Buf, 8, A01 - Carry01)
		buffer.writef64(Buf, 16, A02 - Carry02)
		buffer.writef64(Buf, 24, A03 - Carry03)
		buffer.writef64(Buf, 32, A04 - Carry04)
		buffer.writef64(Buf, 40, A05 - Carry05)
		buffer.writef64(Buf, 48, A06 - Carry06)
		buffer.writef64(Buf, 56, A07 - Carry07)
		buffer.writef64(Buf, 64, A08 - Carry08)
		buffer.writef64(Buf, 72, A09 - Carry09)
		buffer.writef64(Buf, 80, A10 - Carry10)
		buffer.writef64(Buf, 88, Carry10 * 2 ^ -24)

		return Buf
	end

	function MultiPrecision.Carry(LargeNumber: buffer, Storage: buffer?): buffer
		local A00, A01, A02, A03, A04, A05, A06, A07, A08, A09, A10 =
			buffer.readf64(LargeNumber, 0), buffer.readf64(LargeNumber, 8),
			buffer.readf64(LargeNumber, 16), buffer.readf64(LargeNumber, 24),
			buffer.readf64(LargeNumber, 32), buffer.readf64(LargeNumber, 40),
			buffer.readf64(LargeNumber, 48), buffer.readf64(LargeNumber, 56),
			buffer.readf64(LargeNumber, 64), buffer.readf64(LargeNumber, 72),
			buffer.readf64(LargeNumber, 80)

		local Low00 = A00 % 2 ^ 24; A01 += (A00 - Low00) * 2 ^ -24
		local Low01 = A01 % 2 ^ 24; A02 += (A01 - Low01) * 2 ^ -24
		local Low02 = A02 % 2 ^ 24; A03 += (A02 - Low02) * 2 ^ -24
		local Low03 = A03 % 2 ^ 24; A04 += (A03 - Low03) * 2 ^ -24
		local Low04 = A04 % 2 ^ 24; A05 += (A04 - Low04) * 2 ^ -24
		local Low05 = A05 % 2 ^ 24; A06 += (A05 - Low05) * 2 ^ -24
		local Low06 = A06 % 2 ^ 24; A07 += (A06 - Low06) * 2 ^ -24
		local Low07 = A07 % 2 ^ 24; A08 += (A07 - Low07) * 2 ^ -24
		local Low08 = A08 % 2 ^ 24; A09 += (A08 - Low08) * 2 ^ -24
		local Low09 = A09 % 2 ^ 24; A10 += (A09 - Low09) * 2 ^ -24
		local Low10 = A10 % 2 ^ 24

		local Buf = Storage or buffer.create(SIZE)

		buffer.writef64(Buf, 0, Low00)
		buffer.writef64(Buf, 8, Low01)
		buffer.writef64(Buf, 16, Low02)
		buffer.writef64(Buf, 24, Low03)
		buffer.writef64(Buf, 32, Low04)
		buffer.writef64(Buf, 40, Low05)
		buffer.writef64(Buf, 48, Low06)
		buffer.writef64(Buf, 56, Low07)
		buffer.writef64(Buf, 64, Low08)
		buffer.writef64(Buf, 72, Low09)
		buffer.writef64(Buf, 80, Low10)
		buffer.writef64(Buf, 88, (A10 - Low10) * 2 ^ -24)

		return Buf
	end

	function MultiPrecision.Add(NumberA: buffer, NumberB: buffer, Storage: buffer?): buffer
		local A00, A01, A02, A03, A04, A05, A06, A07, A08, A09, A10 =
			buffer.readf64(NumberA, 0), buffer.readf64(NumberA, 8),
			buffer.readf64(NumberA, 16), buffer.readf64(NumberA, 24),
			buffer.readf64(NumberA, 32), buffer.readf64(NumberA, 40),
			buffer.readf64(NumberA, 48), buffer.readf64(NumberA, 56),
			buffer.readf64(NumberA, 64), buffer.readf64(NumberA, 72),
			buffer.readf64(NumberA, 80)

		local B00, B01, B02, B03, B04, B05, B06, B07, B08, B09, B10 =
			buffer.readf64(NumberB, 0), buffer.readf64(NumberB, 8),
			buffer.readf64(NumberB, 16), buffer.readf64(NumberB, 24),
			buffer.readf64(NumberB, 32), buffer.readf64(NumberB, 40),
			buffer.readf64(NumberB, 48), buffer.readf64(NumberB, 56),
			buffer.readf64(NumberB, 64), buffer.readf64(NumberB, 72),
			buffer.readf64(NumberB, 80)

		local Buf = Storage or buffer.create(SIZE)

		buffer.writef64(Buf, 0, A00 + B00)
		buffer.writef64(Buf, 8, A01 + B01)
		buffer.writef64(Buf, 16, A02 + B02)
		buffer.writef64(Buf, 24, A03 + B03)
		buffer.writef64(Buf, 32, A04 + B04)
		buffer.writef64(Buf, 40, A05 + B05)
		buffer.writef64(Buf, 48, A06 + B06)
		buffer.writef64(Buf, 56, A07 + B07)
		buffer.writef64(Buf, 64, A08 + B08)
		buffer.writef64(Buf, 72, A09 + B09)
		buffer.writef64(Buf, 80, A10 + B10)

		return Buf
	end

	function MultiPrecision.Sub(NumberA: buffer, NumberB: buffer, Storage: buffer?): buffer
		local A00, A01, A02, A03, A04, A05, A06, A07, A08, A09, A10 =
			buffer.readf64(NumberA, 0), buffer.readf64(NumberA, 8),
			buffer.readf64(NumberA, 16), buffer.readf64(NumberA, 24),
			buffer.readf64(NumberA, 32), buffer.readf64(NumberA, 40),
			buffer.readf64(NumberA, 48), buffer.readf64(NumberA, 56),
			buffer.readf64(NumberA, 64), buffer.readf64(NumberA, 72),
			buffer.readf64(NumberA, 80)

		local B00, B01, B02, B03, B04, B05, B06, B07, B08, B09, B10 =
			buffer.readf64(NumberB, 0), buffer.readf64(NumberB, 8),
			buffer.readf64(NumberB, 16), buffer.readf64(NumberB, 24),
			buffer.readf64(NumberB, 32), buffer.readf64(NumberB, 40),
			buffer.readf64(NumberB, 48), buffer.readf64(NumberB, 56),
			buffer.readf64(NumberB, 64), buffer.readf64(NumberB, 72),
			buffer.readf64(NumberB, 80)

		local Buf = Storage or buffer.create(SIZE)

		buffer.writef64(Buf, 0, A00 - B00)
		buffer.writef64(Buf, 8, A01 - B01)
		buffer.writef64(Buf, 16, A02 - B02)
		buffer.writef64(Buf, 24, A03 - B03)
		buffer.writef64(Buf, 32, A04 - B04)
		buffer.writef64(Buf, 40, A05 - B05)
		buffer.writef64(Buf, 48, A06 - B06)
		buffer.writef64(Buf, 56, A07 - B07)
		buffer.writef64(Buf, 64, A08 - B08)
		buffer.writef64(Buf, 72, A09 - B09)
		buffer.writef64(Buf, 80, A10 - B10)

		return Buf
	end

	function MultiPrecision.LMul(NumberA: buffer, NumberB: buffer, Storage: buffer?): buffer
		local A00, A01, A02, A03, A04, A05, A06, A07, A08, A09, A10 =
			buffer.readf64(NumberA, 0), buffer.readf64(NumberA, 8),
			buffer.readf64(NumberA, 16), buffer.readf64(NumberA, 24),
			buffer.readf64(NumberA, 32), buffer.readf64(NumberA, 40),
			buffer.readf64(NumberA, 48), buffer.readf64(NumberA, 56),
			buffer.readf64(NumberA, 64), buffer.readf64(NumberA, 72),
			buffer.readf64(NumberA, 80)

		local B00, B01, B02, B03, B04, B05, B06, B07, B08, B09, B10 =
			buffer.readf64(NumberB, 0), buffer.readf64(NumberB, 8),
			buffer.readf64(NumberB, 16), buffer.readf64(NumberB, 24),
			buffer.readf64(NumberB, 32), buffer.readf64(NumberB, 40),
			buffer.readf64(NumberB, 48), buffer.readf64(NumberB, 56),
			buffer.readf64(NumberB, 64), buffer.readf64(NumberB, 72),
			buffer.readf64(NumberB, 80)

		local Buf = Storage or buffer.create(SIZE)

		buffer.writef64(Buf, 0, A00 * B00)
		buffer.writef64(Buf, 8, A01 * B00 + A00 * B01)
		buffer.writef64(Buf, 16, A02 * B00 + A01 * B01 + A00 * B02)
		buffer.writef64(Buf, 24, A03 * B00 + A02 * B01 + A01 * B02 + A00 * B03)
		buffer.writef64(Buf, 32, A04 * B00 + A03 * B01 + A02 * B02 + A01 * B03 + A00 * B04)
		buffer.writef64(Buf, 40, A05 * B00 + A04 * B01 + A03 * B02 + A02 * B03 + A01 * B04 + A00 * B05)
		buffer.writef64(Buf, 48, A06 * B00 + A05 * B01 + A04 * B02 + A03 * B03 + A02 * B04 + A01 * B05 + A00 * B06)
		buffer.writef64(Buf, 56, A07 * B00 + A06 * B01 + A05 * B02 + A04 * B03 + A03 * B04 + A02 * B05 + A01 * B06 + A00 * B07)
		buffer.writef64(Buf, 64, A08 * B00 + A07 * B01 + A06 * B02 + A05 * B03 + A04 * B04 + A03 * B05 + A02 * B06 + A01 * B07 + A00 * B08)
		buffer.writef64(Buf, 72, A09 * B00 + A08 * B01 + A07 * B02 + A06 * B03 + A05 * B04 + A04 * B05 + A03 * B06 + A02 * B07 + A01 * B08 + A00 * B09)
		buffer.writef64(Buf, 80, A10 * B00 + A09 * B01 + A08 * B02 + A07 * B03 + A06 * B04 + A05 * B05 + A04 * B06 + A03 * B07 + A02 * B08 + A01 * B09 + A00 * B10)

		return MultiPrecision.Carry(Buf, Buf)
	end

	function MultiPrecision.Mul(NumberA: buffer, NumberB: buffer, LowStorage: buffer?, HighStorage: buffer?): (buffer, buffer)
		local LowResult = MultiPrecision.LMul(NumberA, NumberB, LowStorage)
		local Overflow = buffer.readf64(LowResult, CARRY)

		local A01, A02, A03, A04, A05, A06, A07, A08, A09, A10 =
			buffer.readf64(NumberA, 8), buffer.readf64(NumberA, 16),
			buffer.readf64(NumberA, 24), buffer.readf64(NumberA, 32),
			buffer.readf64(NumberA, 40), buffer.readf64(NumberA, 48),
			buffer.readf64(NumberA, 56), buffer.readf64(NumberA, 64),
			buffer.readf64(NumberA, 72), buffer.readf64(NumberA, 80)

		local B01, B02, B03, B04, B05, B06, B07, B08, B09, B10 =
			buffer.readf64(NumberB, 8), buffer.readf64(NumberB, 16),
			buffer.readf64(NumberB, 24), buffer.readf64(NumberB, 32),
			buffer.readf64(NumberB, 40), buffer.readf64(NumberB, 48),
			buffer.readf64(NumberB, 56), buffer.readf64(NumberB, 64),
			buffer.readf64(NumberB, 72), buffer.readf64(NumberB, 80)

		local Buf = HighStorage or buffer.create(SIZE)

		buffer.writef64(Buf, 0, Overflow + A10 * B01 + A09 * B02 + A08 * B03 + A07 * B04 + A06 * B05 + A05 * B06 + A04 * B07 + A03 * B08 + A02 * B09 + A01 * B10)
		buffer.writef64(Buf, 8, A10 * B02 + A09 * B03 + A08 * B04 + A07 * B05 + A06 * B06 + A05 * B07 + A04 * B08 + A03 * B09 + A02 * B10)
		buffer.writef64(Buf, 16, A10 * B03 + A09 * B04 + A08 * B05 + A07 * B06 + A06 * B07 + A05 * B08 + A04 * B09 + A03 * B10)
		buffer.writef64(Buf, 24, A10 * B04 + A09 * B05 + A08 * B06 + A07 * B07 + A06 * B08 + A05 * B09 + A04 * B10)
		buffer.writef64(Buf, 32, A10 * B05 + A09 * B06 + A08 * B07 + A07 * B08 + A06 * B09 + A05 * B10)
		buffer.writef64(Buf, 40, A10 * B06 + A09 * B07 + A08 * B08 + A07 * B09 + A06 * B10)
		buffer.writef64(Buf, 48, A10 * B07 + A09 * B08 + A08 * B09 + A07 * B10)
		buffer.writef64(Buf, 56, A10 * B08 + A09 * B09 + A08 * B10)
		buffer.writef64(Buf, 64, A10 * B09 + A09 * B10)
		buffer.writef64(Buf, 72, A10 * B10)
		buffer.writef64(Buf, 80, 0)

		return LowResult, MultiPrecision.Carry(Buf, Buf)
	end

	function MultiPrecision.DWAdd(NumberA0: buffer, NumberA1: buffer, NumberB0: buffer, NumberB1: buffer, LowStorage: buffer?, HighStorage: buffer?): (buffer, buffer, number)
		local LowSum = MultiPrecision.Carry(MultiPrecision.Add(NumberA0, NumberB0, LowStorage), LowStorage)
		local CarryOut = buffer.readf64(LowSum, CARRY)

		local HighSum = MultiPrecision.Add(NumberA1, NumberB1, HighStorage)
		buffer.writef64(HighSum, 0, buffer.readf64(HighSum, 0) + CarryOut)
		local Carried = MultiPrecision.Carry(HighSum, HighSum)

		return LowSum, Carried, buffer.readf64(Carried, CARRY)
	end

	function MultiPrecision.Half(NumberA: buffer, Storage: buffer?): buffer
		local A00, A01, A02, A03, A04, A05, A06, A07, A08, A09, A10 =
			buffer.readf64(NumberA, 0),
			buffer.readf64(NumberA, 8),
			buffer.readf64(NumberA, 16),
			buffer.readf64(NumberA, 24),
			buffer.readf64(NumberA, 32),
			buffer.readf64(NumberA, 40),
			buffer.readf64(NumberA, 48),
			buffer.readf64(NumberA, 56),
			buffer.readf64(NumberA, 64),
			buffer.readf64(NumberA, 72),
			buffer.readf64(NumberA, 80)

		local Buf = Storage or buffer.create(SIZE)

		buffer.writef64(Buf, 0, A00 * 0.5 + A01 * 2 ^ 23)
		buffer.writef64(Buf, 8, A02 * 2 ^ 23)
		buffer.writef64(Buf, 16, A03 * 2 ^ 23)
		buffer.writef64(Buf, 24, A04 * 2 ^ 23)
		buffer.writef64(Buf, 32, A05 * 2 ^ 23)
		buffer.writef64(Buf, 40, A06 * 2 ^ 23)
		buffer.writef64(Buf, 48, A07 * 2 ^ 23)
		buffer.writef64(Buf, 56, A08 * 2 ^ 23)
		buffer.writef64(Buf, 64, A09 * 2 ^ 23)
		buffer.writef64(Buf, 72, A10 * 2 ^ 23)
		buffer.writef64(Buf, 80, 0)

		return MultiPrecision.CarryWeak(Buf, Buf)
	end

	function MultiPrecision.Third(NumberA: buffer, Storage: buffer?): buffer
		local A00, A01, A02, A03, A04, A05, A06, A07, A08, A09, A10 =
			buffer.readf64(NumberA, 0),
			buffer.readf64(NumberA, 8),
			buffer.readf64(NumberA, 16),
			buffer.readf64(NumberA, 24),
			buffer.readf64(NumberA, 32),
			buffer.readf64(NumberA, 40),
			buffer.readf64(NumberA, 48),
			buffer.readf64(NumberA, 56),
			buffer.readf64(NumberA, 64),
			buffer.readf64(NumberA, 72),
			buffer.readf64(NumberA, 80)

		local Division00 = A00 * 0xaaaaaa
		local Division01 = A01 * 0xaaaaaa + Division00
		local Division02 = A02 * 0xaaaaaa + Division01
		local Division03 = A03 * 0xaaaaaa + Division02
		local Division04 = A04 * 0xaaaaaa + Division03
		local Division05 = A05 * 0xaaaaaa + Division04
		local Division06 = A06 * 0xaaaaaa + Division05
		local Division07 = A07 * 0xaaaaaa + Division06
		local Division08 = A08 * 0xaaaaaa + Division07
		local Division09 = A09 * 0xaaaaaa + Division08
		local Division10 = A10 * 0xaaaaaa + Division09

		local Buf = Storage or buffer.create(SIZE)

		buffer.writef64(Buf, 0, A00 + Division00)
		buffer.writef64(Buf, 8, A01 + Division01)
		buffer.writef64(Buf, 16, A02 + Division02)
		buffer.writef64(Buf, 24, A03 + Division03)
		buffer.writef64(Buf, 32, A04 + Division04)
		buffer.writef64(Buf, 40, A05 + Division05)
		buffer.writef64(Buf, 48, A06 + Division06)
		buffer.writef64(Buf, 56, A07 + Division07)
		buffer.writef64(Buf, 64, A08 + Division08)
		buffer.writef64(Buf, 72, A09 + Division09)
		buffer.writef64(Buf, 80, A10 + Division10)

		return MultiPrecision.CarryWeak(Buf, Buf)
	end

	function MultiPrecision.Mod2(NumberA: buffer): number
		return buffer.readf64(NumberA, 0) % 2
	end

	function MultiPrecision.Mod3(NumberA: buffer): number
		return (
			buffer.readf64(NumberA, 0) +
				buffer.readf64(NumberA, 8) +
				buffer.readf64(NumberA, 16) +
				buffer.readf64(NumberA, 24) +
				buffer.readf64(NumberA, 32) +
				buffer.readf64(NumberA, 40) +
				buffer.readf64(NumberA, 48) +
				buffer.readf64(NumberA, 56) +
				buffer.readf64(NumberA, 64) +
				buffer.readf64(NumberA, 72) +
				buffer.readf64(NumberA, 80)
		) % 3
	end

	function MultiPrecision.Approx(NumberA: buffer): number
		return buffer.readf64(NumberA, 0)
			+ buffer.readf64(NumberA, 8) * 2 ^ 24
			+ buffer.readf64(NumberA, 16) * 2 ^ 48
			+ buffer.readf64(NumberA, 24) * 2 ^ 72
			+ buffer.readf64(NumberA, 32) * 2 ^ 96
			+ buffer.readf64(NumberA, 40) * 2 ^ 120
			+ buffer.readf64(NumberA, 48) * 2 ^ 144
			+ buffer.readf64(NumberA, 56) * 2 ^ 168
			+ buffer.readf64(NumberA, 64) * 2 ^ 192
			+ buffer.readf64(NumberA, 72) * 2 ^ 216
			+ buffer.readf64(NumberA, 80) * 2 ^ 240
	end

	function MultiPrecision.Cmp(NumberA: buffer, NumberB: buffer): number
		return MultiPrecision.Approx(MultiPrecision.Sub(NumberA, NumberB))
	end

	function MultiPrecision.Num(RegularNumber: number): buffer
		local Buf = buffer.create(SIZE)
		buffer.writef64(Buf, 0, RegularNumber)

		return Buf
	end

	return MultiPrecision

end }

__mods["crypto/EdDSA/SHA512"] = { dir = "crypto/EdDSA", fn = function(require)
	--!strict
	--!optimize 2
	--!native

	local K_HI = {
		0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
		0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
		0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
		0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
		0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
		0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
		0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
		0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
		0xca273ece, 0xd186b8c7, 0xeada7dd6, 0xf57d4f7f, 0x06f067aa, 0x0a637dc5, 0x113f9804, 0x1b710b35,
		0x28db77f5, 0x32caab7b, 0x3c9ebe0a, 0x431d67c4, 0x4cc5d4be, 0x597f299c, 0x5fcb6fab, 0x6c44198c,
	}

	local K_LO = {
		0xd728ae22, 0x23ef65cd, 0xec4d3b2f, 0x8189dbbc, 0xf348b538, 0xb605d019, 0xaf194f9b, 0xda6d8118,
		0xa3030242, 0x45706fbe, 0x4ee4b28c, 0xd5ffb4e2, 0xf27b896f, 0x3b1696b1, 0x25c71235, 0xcf692694,
		0x9ef14ad2, 0x384f25e3, 0x8b8cd5b5, 0x77ac9c65, 0x592b0275, 0x6ea6e483, 0xbd41fbd4, 0x831153b5,
		0xee66dfab, 0x2db43210, 0x98fb213f, 0xbeef0ee4, 0x3da88fc2, 0x930aa725, 0xe003826f, 0x0a0e6e70,
		0x46d22ffc, 0x5c26c926, 0x5ac42aed, 0x9d95b3df, 0x8baf63de, 0x3c77b2a8, 0x47edaee6, 0x1482353b,
		0x4cf10364, 0xbc423001, 0xd0f89791, 0x0654be30, 0xd6ef5218, 0x5565a910, 0x5771202a, 0x32bbd1b8,
		0xb8d2d0c8, 0x5141ab53, 0xdf8eeb99, 0xe19b48a8, 0xc5c95a63, 0xe3418acb, 0x7763e373, 0xd6b2b8a3,
		0x5defb2fc, 0x43172f60, 0xa1f0ab72, 0x1a6439ec, 0x23631e28, 0xde82bde9, 0xb2c67915, 0xe372532b,
		0xea26619c, 0x21c0c207, 0xcde0eb1e, 0xee6ed178, 0x72176fba, 0xa2c898a6, 0xbef90dae, 0x131c471b,
		0x23047d84, 0x40c72493, 0x15c9bebc, 0x9c100d4c, 0xcb3e42b6, 0xfc657e2a, 0x3ad6faec, 0x4a475817,
	}

	local W_HI = table.create(80) :: {number}
	local W_LO = table.create(80) :: {number}
	local RESULT_BUFFER = buffer.create(64)

	local function PreProcess(Contents: buffer): (buffer, number)
		local ContentLength = buffer.len(Contents)
		local Padding = (128 - ((ContentLength + 17) % 128)) % 128
		local NewLength = ContentLength + 1 + Padding + 16

		local Result = buffer.create(NewLength)
		buffer.copy(Result, 0, Contents)
		buffer.writeu8(Result, ContentLength, 0x80)
		buffer.fill(Result, ContentLength + 1, 0, Padding + 8)

		local BitLength = ContentLength * 8
		local LengthOffset = ContentLength + 1 + Padding + 8

		for Index = 7, 0, -1 do
			buffer.writeu8(Result, LengthOffset + Index, BitLength % 256)
			BitLength = BitLength // 256
		end

		return Result, NewLength
	end

	local function SHA512(Message: buffer): buffer
		local Blocks, Length = PreProcess(Message)

		local Hi, Lo = W_HI, W_LO
		local KHi, KLo = K_HI, K_LO

		local H1Hi, H2Hi, H3Hi, H4Hi = 0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a
		local H5Hi, H6Hi, H7Hi, H8Hi = 0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
		local H1Lo, H2Lo, H3Lo, H4Lo = 0xf3bcc908, 0x84caa73b, 0xfe94f82b, 0x5f1d36f1
		local H5Lo, H6Lo, H7Lo, H8Lo = 0xade682d1, 0x2b3e6c1f, 0xfb41bd6b, 0x137e2179

		for Offset = 0, Length - 1, 128 do
			for T = 1, 16 do
				local ByteOffset = Offset + (T - 1) * 8
				Hi[T] = bit32.byteswap(buffer.readu32(Blocks, ByteOffset))
				Lo[T] = bit32.byteswap(buffer.readu32(Blocks, ByteOffset + 4))
			end

			for T = 17, 80 do
				local P15Hi, P15Lo = Hi[T - 15], Lo[T - 15]
				local P2Hi, P2Lo = Hi[T - 2], Lo[T - 2]

				local S0Lo = bit32.bxor(bit32.rshift(P15Lo, 1) + bit32.lshift(P15Hi, 31), bit32.rshift(P15Lo, 8) + bit32.lshift(P15Hi, 24), bit32.rshift(P15Lo, 7) + bit32.lshift(P15Hi, 25))
				local S1Lo = bit32.bxor(bit32.rshift(P2Lo, 19) + bit32.lshift(P2Hi, 13), bit32.lshift(P2Lo, 3) + bit32.rshift(P2Hi, 29), bit32.rshift(P2Lo, 6) + bit32.lshift(P2Hi, 26))

				local TmpLo = Lo[T - 16] + S0Lo + Lo[T - 7] + S1Lo
				Lo[T] = bit32.bor(TmpLo, 0)
				Hi[T] = bit32.bxor(bit32.rshift(P15Hi, 1) + bit32.lshift(P15Lo, 31), bit32.rshift(P15Hi, 8) + bit32.lshift(P15Lo, 24), bit32.rshift(P15Hi, 7)) +
					bit32.bxor(bit32.rshift(P2Hi, 19) + bit32.lshift(P2Lo, 13), bit32.lshift(P2Hi, 3) + bit32.rshift(P2Lo, 29), bit32.rshift(P2Hi, 6)) +
					Hi[T - 16] + Hi[T - 7] + TmpLo // 0x100000000
			end

			local AHi, ALo = H1Hi, H1Lo
			local BHi, BLo = H2Hi, H2Lo
			local CHi, CLo = H3Hi, H3Lo
			local DHi, DLo = H4Hi, H4Lo
			local EHi, ELo = H5Hi, H5Lo
			local FHi, FLo = H6Hi, H6Lo
			local GHi, GLo = H7Hi, H7Lo
			local HHi, HLo = H8Hi, H8Lo

			for T = 1, 79, 2 do
				local Sigma1Lo = bit32.bxor(bit32.rshift(ELo, 14) + bit32.lshift(EHi, 18), bit32.rshift(ELo, 18) + bit32.lshift(EHi, 14), bit32.lshift(ELo, 23) + bit32.rshift(EHi, 9))
				local Sigma1Hi = bit32.bxor(bit32.rshift(EHi, 14) + bit32.lshift(ELo, 18), bit32.rshift(EHi, 18) + bit32.lshift(ELo, 14), bit32.lshift(EHi, 23) + bit32.rshift(ELo, 9))
				local Sigma0Lo = bit32.bxor(bit32.rshift(ALo, 28) + bit32.lshift(AHi, 4), bit32.lshift(ALo, 30) + bit32.rshift(AHi, 2), bit32.lshift(ALo, 25) + bit32.rshift(AHi, 7))
				local Sigma0Hi = bit32.bxor(bit32.rshift(AHi, 28) + bit32.lshift(ALo, 4), bit32.lshift(AHi, 30) + bit32.rshift(ALo, 2), bit32.lshift(AHi, 25) + bit32.rshift(ALo, 7))
				local ChLo = bit32.band(ELo, FLo) + bit32.band(-1 - ELo, GLo)
				local ChHi = bit32.band(EHi, FHi) + bit32.band(-1 - EHi, GHi)
				local MajLo = bit32.band(CLo, BLo) + bit32.band(ALo, bit32.bxor(CLo, BLo))
				local MajHi = bit32.band(CHi, BHi) + bit32.band(AHi, bit32.bxor(CHi, BHi))

				local T1Lo = HLo + Sigma1Lo + ChLo + KLo[T] + Lo[T]
				local T1Hi = HHi + Sigma1Hi + ChHi + KHi[T] + Hi[T] + T1Lo // 0x100000000
				T1Lo = bit32.bor(T1Lo, 0)

				HHi, HLo = GHi, GLo
				GHi, GLo = FHi, FLo
				FHi, FLo = EHi, ELo

				local ELoNew = DLo + T1Lo
				EHi = DHi + T1Hi + ELoNew // 0x100000000
				ELo = bit32.bor(ELoNew, 0)

				DHi, DLo = CHi, CLo
				CHi, CLo = BHi, BLo
				BHi, BLo = AHi, ALo

				local ALoNew = T1Lo + Sigma0Lo + MajLo
				AHi = T1Hi + Sigma0Hi + MajHi + ALoNew // 0x100000000
				ALo = bit32.bor(ALoNew, 0)

				local T2 = T + 1
				Sigma1Lo = bit32.bxor(bit32.rshift(ELo, 14) + bit32.lshift(EHi, 18), bit32.rshift(ELo, 18) + bit32.lshift(EHi, 14), bit32.lshift(ELo, 23) + bit32.rshift(EHi, 9))
				Sigma1Hi = bit32.bxor(bit32.rshift(EHi, 14) + bit32.lshift(ELo, 18), bit32.rshift(EHi, 18) + bit32.lshift(ELo, 14), bit32.lshift(EHi, 23) + bit32.rshift(ELo, 9))
				Sigma0Lo = bit32.bxor(bit32.rshift(ALo, 28) + bit32.lshift(AHi, 4), bit32.lshift(ALo, 30) + bit32.rshift(AHi, 2), bit32.lshift(ALo, 25) + bit32.rshift(AHi, 7))
				Sigma0Hi = bit32.bxor(bit32.rshift(AHi, 28) + bit32.lshift(ALo, 4), bit32.lshift(AHi, 30) + bit32.rshift(ALo, 2), bit32.lshift(AHi, 25) + bit32.rshift(ALo, 7))
				ChLo = bit32.band(ELo, FLo) + bit32.band(-1 - ELo, GLo)
				ChHi = bit32.band(EHi, FHi) + bit32.band(-1 - EHi, GHi)
				MajLo = bit32.band(CLo, BLo) + bit32.band(ALo, bit32.bxor(CLo, BLo))
				MajHi = bit32.band(CHi, BHi) + bit32.band(AHi, bit32.bxor(CHi, BHi))

				T1Lo = HLo + Sigma1Lo + ChLo + KLo[T2] + Lo[T2]
				T1Hi = HHi + Sigma1Hi + ChHi + KHi[T2] + Hi[T2] + T1Lo // 0x100000000
				T1Lo = bit32.bor(T1Lo, 0)

				HHi, HLo = GHi, GLo
				GHi, GLo = FHi, FLo
				FHi, FLo = EHi, ELo

				ELoNew = DLo + T1Lo
				EHi = DHi + T1Hi + ELoNew // 0x100000000
				ELo = bit32.bor(ELoNew, 0)

				DHi, DLo = CHi, CLo
				CHi, CLo = BHi, BLo
				BHi, BLo = AHi, ALo

				ALoNew = T1Lo + Sigma0Lo + MajLo
				AHi = T1Hi + Sigma0Hi + MajHi + ALoNew // 0x100000000
				ALo = bit32.bor(ALoNew, 0)
			end

			H1Lo = H1Lo + ALo
			H1Hi = bit32.bor(H1Hi + AHi + H1Lo // 0x100000000, 0)
			H1Lo = bit32.bor(H1Lo, 0)

			H2Lo = H2Lo + BLo
			H2Hi = bit32.bor(H2Hi + BHi + H2Lo // 0x100000000, 0)
			H2Lo = bit32.bor(H2Lo, 0)

			H3Lo = H3Lo + CLo
			H3Hi = bit32.bor(H3Hi + CHi + H3Lo // 0x100000000, 0)
			H3Lo = bit32.bor(H3Lo, 0)

			H4Lo = H4Lo + DLo
			H4Hi = bit32.bor(H4Hi + DHi + H4Lo // 0x100000000, 0)
			H4Lo = bit32.bor(H4Lo, 0)

			H5Lo = H5Lo + ELo
			H5Hi = bit32.bor(H5Hi + EHi + H5Lo // 0x100000000, 0)
			H5Lo = bit32.bor(H5Lo, 0)

			H6Lo = H6Lo + FLo
			H6Hi = bit32.bor(H6Hi + FHi + H6Lo // 0x100000000, 0)
			H6Lo = bit32.bor(H6Lo, 0)

			H7Lo = H7Lo + GLo
			H7Hi = bit32.bor(H7Hi + GHi + H7Lo // 0x100000000, 0)
			H7Lo = bit32.bor(H7Lo, 0)

			H8Lo = H8Lo + HLo
			H8Hi = bit32.bor(H8Hi + HHi + H8Lo // 0x100000000, 0)
			H8Lo = bit32.bor(H8Lo, 0)
		end

		buffer.writeu32(RESULT_BUFFER, 0, bit32.byteswap(H1Hi))
		buffer.writeu32(RESULT_BUFFER, 4, bit32.byteswap(H1Lo))
		buffer.writeu32(RESULT_BUFFER, 8, bit32.byteswap(H2Hi))
		buffer.writeu32(RESULT_BUFFER, 12, bit32.byteswap(H2Lo))
		buffer.writeu32(RESULT_BUFFER, 16, bit32.byteswap(H3Hi))
		buffer.writeu32(RESULT_BUFFER, 20, bit32.byteswap(H3Lo))
		buffer.writeu32(RESULT_BUFFER, 24, bit32.byteswap(H4Hi))
		buffer.writeu32(RESULT_BUFFER, 28, bit32.byteswap(H4Lo))
		buffer.writeu32(RESULT_BUFFER, 32, bit32.byteswap(H5Hi))
		buffer.writeu32(RESULT_BUFFER, 36, bit32.byteswap(H5Lo))
		buffer.writeu32(RESULT_BUFFER, 40, bit32.byteswap(H6Hi))
		buffer.writeu32(RESULT_BUFFER, 44, bit32.byteswap(H6Lo))
		buffer.writeu32(RESULT_BUFFER, 48, bit32.byteswap(H7Hi))
		buffer.writeu32(RESULT_BUFFER, 52, bit32.byteswap(H7Lo))
		buffer.writeu32(RESULT_BUFFER, 56, bit32.byteswap(H8Hi))
		buffer.writeu32(RESULT_BUFFER, 60, bit32.byteswap(H8Lo))

		return RESULT_BUFFER
	end

	return SHA512

end }

__mods["crypto/EdDSA/X25519"] = { dir = "crypto/EdDSA", fn = function(require)
	--[=[
		Cryptography library: X25519 with cofactor clearing

		Return type: varies by function
		Example usage:
			local AlicePrivate = CSPRNG.Ed25519Random()
			local BobPrivate = CSPRNG.Ed25519Random()

			local AliceMasked = X25519.Mask(AlicePrivate)
			local BobMasked = X25519.Mask(BobPrivate)

			local AlicePublic = X25519.PublicKey(AliceMasked)
			local BobPublic = X25519.PublicKey(BobMasked)

			local AliceSharedPrimary, AliceEphemeralSecret = X25519.Exchange(AliceMasked, BobPublic)
			local BobSharedPrimary, BobEphemeralSecret = X25519.Exchange(BobMasked, AlicePublic)

			Expect(ToHex(AliceSharedPrimary)).ToBe(ToHex(BobSharedPrimary))
			Expect(ToHex(AliceEphemeralSecret)).Never.ToBe(ToHex(BobEphemeralSecret))
	--]=]

	--!strict
	--!optimize 2
	--!native

	local FieldQuadratic = require("./FieldQuadratic")
	local FieldPrime = require("./FieldPrime")
	local Curve25519 = require("./Curve25519")
	local SHA512 = require("./SHA512")
	local CSPRNG = require("./CSPRNG")

	local COORD_SIZE = 104

	local X25519_SECRET_KEY_SIZE = 32
	local X25519_PUBLIC_KEY_SIZE = 32
	local X25519_MASKED_KEY_SIZE = 64

	local X25519_SIGNATURE_SECRET_KEY_SIZE = 32

	local Mask = {}

	function Mask.Mask(SecretKey: buffer): buffer
		if SecretKey == nil then
			error("SecretKey cannot be nil", 2)
		end

		if typeof(SecretKey) ~= "buffer" then
			error(`SecretKey must be a buffer, got {typeof(SecretKey)}`, 2)
		end

		local SecretKeyLength = buffer.len(SecretKey)
		if SecretKeyLength ~= X25519_SECRET_KEY_SIZE then
			error(`SecretKey must be exactly {X25519_SECRET_KEY_SIZE} bytes long, got {SecretKeyLength} bytes`, 2)
		end

		local RandomMask = CSPRNG.Ed25519Random()
		local ScalarX = FieldQuadratic.DecodeClamped(SecretKey)
		local ScalarR = FieldQuadratic.DecodeClamped(RandomMask)
		local MaskedScalar = FieldQuadratic.Sub(ScalarX, ScalarR)
		local EncodedMaskedScalar = FieldQuadratic.Encode(MaskedScalar)

		local MaskedKey = buffer.create(64)
		buffer.copy(MaskedKey, 0, EncodedMaskedScalar, 0, 32)
		buffer.copy(MaskedKey, 32, RandomMask, 0, 32)

		return MaskedKey
	end

	function Mask.MaskSignature(SignatureSecretKey: buffer): buffer
		if SignatureSecretKey == nil then
			error("SignatureSecretKey cannot be nil", 2)
		end

		if typeof(SignatureSecretKey) ~= "buffer" then
			error(`SignatureSecretKey must be a buffer, got {typeof(SignatureSecretKey)}`, 2)
		end

		local SignatureKeyLength = buffer.len(SignatureSecretKey)
		if SignatureKeyLength ~= X25519_SIGNATURE_SECRET_KEY_SIZE then
			error(`SignatureSecretKey must be exactly {X25519_SIGNATURE_SECRET_KEY_SIZE} bytes long, got {SignatureKeyLength} bytes`, 2)
		end

		local HashResult = SHA512(SignatureSecretKey)
		local FirstHalf = buffer.create(32)
		buffer.copy(FirstHalf, 0, HashResult, 0, 32)

		return Mask.Mask(FirstHalf)
	end

	function Mask.Remask(MaskedKey: buffer): buffer
		if MaskedKey == nil then
			error("MaskedKey cannot be nil", 2)
		end

		if typeof(MaskedKey) ~= "buffer" then
			error(`MaskedKey must be a buffer, got {typeof(MaskedKey)}`, 2)
		end

		local MaskedKeyLength = buffer.len(MaskedKey)
		if MaskedKeyLength ~= X25519_MASKED_KEY_SIZE then
			error(`MaskedKey must be exactly {X25519_MASKED_KEY_SIZE} bytes long, got {MaskedKeyLength} bytes`, 2)
		end

		local NewRandomMask = CSPRNG.Ed25519Random()

		local MaskedScalarBytes = buffer.create(32)
		buffer.copy(MaskedScalarBytes, 0, MaskedKey, 0, 32)
		local MaskedScalar = FieldQuadratic.Decode(MaskedScalarBytes)

		local OldMaskBytes = buffer.create(32)
		buffer.copy(OldMaskBytes, 0, MaskedKey, 32, 32)
		local OldMask = FieldQuadratic.DecodeClamped(OldMaskBytes)

		local NewMask = FieldQuadratic.DecodeClamped(NewRandomMask)
		local RemaskedScalar = FieldQuadratic.Add(MaskedScalar, FieldQuadratic.Sub(OldMask, NewMask))
		local EncodedRemaskedScalar = FieldQuadratic.Encode(RemaskedScalar)

		local RemaskedKey = buffer.create(64)
		buffer.copy(RemaskedKey, 0, EncodedRemaskedScalar, 0, 32)
		buffer.copy(RemaskedKey, 32, NewRandomMask, 0, 32)

		return RemaskedKey
	end

	function Mask.MaskComponent(MaskedKey: buffer): buffer
		if MaskedKey == nil then
			error("MaskedKey cannot be nil", 2)
		end

		if typeof(MaskedKey) ~= "buffer" then
			error(`MaskedKey must be a buffer, got {typeof(MaskedKey)}`, 2)
		end

		local MaskedKeyLength = buffer.len(MaskedKey)
		if MaskedKeyLength ~= X25519_MASKED_KEY_SIZE then
			error(`MaskedKey must be exactly {X25519_MASKED_KEY_SIZE} bytes long, got {MaskedKeyLength} bytes`, 2)
		end

		local MaskKey = buffer.create(32)
		buffer.copy(MaskKey, 0, MaskedKey, 32, 32)

		return MaskKey
	end

	local function ExchangeOnPoint(MaskedSecretKey: buffer, CurvePoint: buffer): (buffer, buffer)
		local MaskedScalarBytes = buffer.create(32)
		buffer.copy(MaskedScalarBytes, 0, MaskedSecretKey, 0, 32)
		local MaskedScalar = FieldQuadratic.Decode(MaskedScalarBytes)

		local MaskBytes = buffer.create(32)
		buffer.copy(MaskBytes, 0, MaskedSecretKey, 32, 32)
		local MaskScalar = FieldQuadratic.DecodeClamped(MaskBytes)

		local MaskPoint, MaskedPoint, DifferencePoint = Curve25519.Prac(CurvePoint, {FieldQuadratic.MakeRuleset(FieldQuadratic.Eighth(MaskScalar), FieldQuadratic.Eighth(MaskedScalar))})
		if not MaskPoint then
			error("Invalid public key", 2)
		end

		if not DifferencePoint or not MaskedPoint then
			error("Invalid public key", 2)
		end

		local FullScalarPoint = Curve25519.DifferentialAdd(DifferencePoint, MaskPoint, MaskedPoint)

		local PointX = buffer.create(COORD_SIZE)
		buffer.copy(PointX, 0, CurvePoint, 0 * COORD_SIZE, COORD_SIZE)
		local PointZ = buffer.create(COORD_SIZE)
		buffer.copy(PointZ, 0, CurvePoint, 1 * COORD_SIZE, COORD_SIZE)

		local FullPointX = buffer.create(COORD_SIZE)
		buffer.copy(FullPointX, 0, FullScalarPoint, 0 * COORD_SIZE, COORD_SIZE)
		local FullPointZ = buffer.create(COORD_SIZE)
		buffer.copy(FullPointZ, 0, FullScalarPoint, 1 * COORD_SIZE, COORD_SIZE)

		local MaskPointX = buffer.create(COORD_SIZE)
		buffer.copy(MaskPointX, 0, MaskPoint, 0 * COORD_SIZE, COORD_SIZE)
		local MaskPointZ = buffer.create(COORD_SIZE)
		buffer.copy(MaskPointZ, 0, MaskPoint, 1 * COORD_SIZE, COORD_SIZE)

		PointX, PointZ = FieldPrime.Mul(PointX, PointZ), FieldPrime.Square(PointZ) :: buffer
		FullPointX, FullPointZ = FieldPrime.Mul(FullPointX, FullPointZ), FieldPrime.Square(FullPointZ) :: buffer
		MaskPointX, MaskPointZ = FieldPrime.Mul(MaskPointX, MaskPointZ), FieldPrime.Square(MaskPointZ) :: buffer

		local PointXSquared = FieldPrime.Square(PointX)
		local PointZSquared = FieldPrime.Square(PointZ)
		local PointXZ = FieldPrime.Mul(PointX, PointZ)
		local CurveConstantTerm = FieldPrime.KMul(PointXZ, 486662)
		local RightHandSide = FieldPrime.Mul(PointX, FieldPrime.Add(PointXSquared, FieldPrime.Carry(FieldPrime.Add(CurveConstantTerm, PointZSquared))))

		local SquareRoot = FieldPrime.SqrtDiv(FieldPrime.Num(1), FieldPrime.Mul(FieldPrime.Mul(FullPointZ, MaskPointZ), RightHandSide))
		if not SquareRoot then
			error("Invalid public key", 2)
		end

		local CombinedInverse = FieldPrime.Mul(FieldPrime.Square(SquareRoot), RightHandSide)
		local FullPointZInverse = FieldPrime.Mul(CombinedInverse, MaskPointZ)
		local MaskPointZInverse = FieldPrime.Mul(CombinedInverse, FullPointZ)

		return FieldPrime.Encode(FieldPrime.Mul(FullPointX, FullPointZInverse)), FieldPrime.Encode(FieldPrime.Mul(MaskPointX, MaskPointZInverse))
	end

	function Mask.PublicKey(MaskedKey: buffer): buffer
		if MaskedKey == nil then
			error("MaskedKey cannot be nil", 2)
		end

		if typeof(MaskedKey) ~= "buffer" then
			error(`MaskedKey must be a buffer, got {typeof(MaskedKey)}`, 2)
		end

		local MaskedKeyLength = buffer.len(MaskedKey)
		if MaskedKeyLength ~= X25519_MASKED_KEY_SIZE then
			error(`MaskedKey must be exactly {X25519_MASKED_KEY_SIZE} bytes long, got {MaskedKeyLength} bytes`, 2)
		end

		return (ExchangeOnPoint(MaskedKey, Curve25519.G))
	end

	function Mask.Exchange(MaskedSecretKey: buffer, TheirPublicKey: buffer): (buffer, buffer)
		if MaskedSecretKey == nil then
			error("MaskedSecretKey cannot be nil", 2)
		end

		if typeof(MaskedSecretKey) ~= "buffer" then
			error(`MaskedSecretKey must be a buffer, got {typeof(MaskedSecretKey)}`, 2)
		end

		local MaskedSecretKeyLength = buffer.len(MaskedSecretKey)
		if MaskedSecretKeyLength ~= X25519_MASKED_KEY_SIZE then
			error(`MaskedSecretKey must be exactly {X25519_MASKED_KEY_SIZE} bytes long, got {MaskedSecretKeyLength} bytes`, 2)
		end

		if TheirPublicKey == nil then
			error("TheirPublicKey cannot be nil", 2)
		end

		if typeof(TheirPublicKey) ~= "buffer" then
			error(`TheirPublicKey must be a buffer, got {typeof(TheirPublicKey)}`, 2)
		end

		local TheirPublicKeyLength = buffer.len(TheirPublicKey)
		if TheirPublicKeyLength ~= X25519_PUBLIC_KEY_SIZE then
			error(`TheirPublicKey must be exactly {X25519_PUBLIC_KEY_SIZE} bytes long, got {TheirPublicKeyLength} bytes`, 2)
		end

		return ExchangeOnPoint(MaskedSecretKey, Curve25519.Decode(TheirPublicKey))
	end

	return Mask

end }

__mods["crypto/EdDSA/init"] = { dir = "crypto/EdDSA", fn = function(require)
	--[=[
		Cryptography library: EdDSA (Ed25519) with Batch Verification

		Return type: varies by function
		Example usage:
			local EdDSA = require("EdDSA")

			--------Usage Case 1--------
			local SecretKey = RandomBytes.Generate(32)
			local PublicKey = EdDSA.PublicKey(SecretKey)

			--------Usage Case 2--------
			local Message = buffer.fromstring("Hello World")
			local Signature = EdDSA.Sign(Message, SecretKey, PublicKey)

			--------Usage Case 3--------
			local IsValid = EdDSA.Verify(Message, PublicKey, Signature)

			--------Usage Case 4: Batch Verification--------
			local AllValid = EdDSA.VerifyBatch({
				{Message = M1, PublicKey = PK1, Signature = S1},
				{Message = M2, PublicKey = PK2, Signature = S2},
				...
			})
	--]=]

	--!strict
	--!optimize 2
	--!native

	local FieldQuadratic = require("@self/FieldQuadratic")
	local FieldPrime = require("@self/FieldPrime")
	local SHA512 = require("@self/SHA512")
	local Edwards25519 = require("@self/Edwards25519")
	local X25519 = require("@self/X25519")
	local CSPRNG = require("@self/CSPRNG")

	local ED25519_SECRET_KEY_SIZE = 32
	local ED25519_PUBLIC_KEY_SIZE = 32
	local ED25519_SIGNATURE_SIZE = 64

	local function ConcatBuffers(...): buffer
		local Buffers = {...}
		local TotalLength = 0

		for _, Buffer in Buffers do
			TotalLength += buffer.len(Buffer)
		end

		local Result = buffer.create(TotalLength)
		local Offset = 0

		for _, Buffer in Buffers do
			local Length = buffer.len(Buffer)
			buffer.copy(Result, Offset, Buffer, 0, Length)
			Offset += Length
		end

		return Result
	end

	export type SignatureEntry = {
		PublicKey: buffer,
		Message: buffer,
		Signature: buffer,
	}

	local EDDSA = {
		CSPRNG = CSPRNG,
		X25519 = X25519
	}

	function EDDSA.PublicKey(SecretKey: buffer): buffer
		if SecretKey == nil then
			error("SecretKey cannot be nil", 2)
		end

		if typeof(SecretKey) ~= "buffer" then
			error(`SecretKey must be a buffer, got {typeof(SecretKey)}`, 2)
		end

		local SecretKeyLength = buffer.len(SecretKey)
		if SecretKeyLength ~= ED25519_SECRET_KEY_SIZE then
			error(`SecretKey must be exactly {ED25519_SECRET_KEY_SIZE} bytes long, got {SecretKeyLength} bytes`, 2)
		end

		local Hash = SHA512(SecretKey)
		local FirstHalf = buffer.create(32)
		buffer.copy(FirstHalf, 0, Hash, 0, 32)

		local ScalarX = FieldQuadratic.DecodeClamped(FirstHalf)
		local ScalarBits, BitCount = FieldQuadratic.Bits(ScalarX)

		return Edwards25519.Encode(Edwards25519.MulG(ScalarBits, BitCount))
	end

	function EDDSA.Sign(Message: buffer, SecretKey: buffer, PublicKey: buffer): buffer
		if SecretKey == nil then
			error("SecretKey cannot be nil", 2)
		end

		if typeof(SecretKey) ~= "buffer" then
			error(`SecretKey must be a buffer, got {typeof(SecretKey)}`, 2)
		end

		local SecretKeyLength = buffer.len(SecretKey)
		if SecretKeyLength ~= ED25519_SECRET_KEY_SIZE then
			error(`SecretKey must be exactly {ED25519_SECRET_KEY_SIZE} bytes long, got {SecretKeyLength} bytes`, 2)
		end

		if PublicKey == nil then
			error("PublicKey cannot be nil", 2)
		end

		if typeof(PublicKey) ~= "buffer" then
			error(`PublicKey must be a buffer, got {typeof(PublicKey)}`, 2)
		end

		local PublicKeyLength = buffer.len(PublicKey)
		if PublicKeyLength ~= ED25519_PUBLIC_KEY_SIZE then
			error(`PublicKey must be exactly {ED25519_PUBLIC_KEY_SIZE} bytes long, got {PublicKeyLength} bytes`, 2)
		end

		if Message == nil then
			error("Message cannot be nil", 2)
		end

		if typeof(Message) ~= "buffer" then
			error(`Message must be a buffer, got {typeof(Message)}`, 2)
		end

		local Hash = SHA512(SecretKey)

		local FirstHalf = buffer.create(32)
		buffer.copy(FirstHalf, 0, Hash, 0, 32)
		local ScalarX = FieldQuadratic.DecodeClamped(FirstHalf)

		local SecondHalf = buffer.create(32)
		buffer.copy(SecondHalf, 0, Hash, 32, 32)

		local NonceSource = ConcatBuffers(SecondHalf, Message)
		local NonceHash = SHA512(NonceSource)
		local NonceK = FieldQuadratic.DecodeWide(NonceHash)

		local NonceBits, NonceBitCount = FieldQuadratic.Bits(NonceK)
		local CommitmentR = Edwards25519.MulG(NonceBits, NonceBitCount)
		local CommitmentString = Edwards25519.Encode(CommitmentR)

		local ChallengeInput = ConcatBuffers(CommitmentString, PublicKey, Message)
		local ChallengeHash = SHA512(ChallengeInput)
		local ChallengeE = FieldQuadratic.DecodeWide(ChallengeHash)

		local ResponseS = FieldQuadratic.Add(NonceK, FieldQuadratic.Mul(ScalarX, ChallengeE))
		local ResponseString = FieldQuadratic.Encode(ResponseS)

		return ConcatBuffers(CommitmentString, ResponseString)
	end

	function EDDSA.Verify(Message: buffer, PublicKey: buffer, Signature: buffer): boolean
		if PublicKey == nil then
			error("PublicKey cannot be nil", 2)
		end

		if typeof(PublicKey) ~= "buffer" then
			error(`PublicKey must be a buffer, got {typeof(PublicKey)}`, 2)
		end

		local PublicKeyLength = buffer.len(PublicKey)
		if PublicKeyLength ~= ED25519_PUBLIC_KEY_SIZE then
			error(`PublicKey must be exactly {ED25519_PUBLIC_KEY_SIZE} bytes long, got {PublicKeyLength} bytes`, 2)
		end

		if Message == nil then
			error("Message cannot be nil", 2)
		end

		if typeof(Message) ~= "buffer" then
			error(`Message must be a buffer, got {typeof(Message)}`, 2)
		end

		if Signature == nil then
			error("Signature cannot be nil", 2)
		end

		if typeof(Signature) ~= "buffer" then
			error(`Signature must be a buffer, got {typeof(Signature)}`, 2)
		end

		local SignatureLength = buffer.len(Signature)
		if SignatureLength ~= ED25519_SIGNATURE_SIZE then
			error(`Signature must be exactly {ED25519_SIGNATURE_SIZE} bytes long, got {SignatureLength} bytes`, 2)
		end

		local LastByte = buffer.readu8(Signature, 63)
		if bit32.band(LastByte, 0xE0) ~= 0x00 then
			return false
		end

		local CommitmentBytes = buffer.create(32)
		buffer.copy(CommitmentBytes, 0, Signature, 0, 32)
		local ResponseBytes = buffer.create(32)
		buffer.copy(ResponseBytes, 0, Signature, 32, 32)

		if not FieldQuadratic.IsValidScalar(ResponseBytes) then
			return false
		end

		local PublicPoint = Edwards25519.Decode(PublicKey)
		if not PublicPoint then
			return false
		end

		local CommitmentPoint = Edwards25519.Decode(CommitmentBytes)
		if not CommitmentPoint then
			return false
		end

		local ChallengeInput = ConcatBuffers(CommitmentBytes, PublicKey, Message)
		local ChallengeHash = SHA512(ChallengeInput)
		local ChallengeScalar = FieldQuadratic.DecodeWide(ChallengeHash)

		local ResponseScalar = FieldQuadratic.Decode(ResponseBytes)
		local ResponseBits, ResponseBitCount = FieldQuadratic.Bits(ResponseScalar)
		local SB = Edwards25519.MulG(ResponseBits, ResponseBitCount)

		local ChallengeBits, ChallengeBitCount = FieldQuadratic.Bits(ChallengeScalar)
		local KA = Edwards25519.Mul(PublicPoint, ChallengeBits, ChallengeBitCount)

		local KANiels = Edwards25519.Niels(KA)
		local RKA = Edwards25519.Add(CommitmentPoint, KANiels)

		local SBNiels = Edwards25519.Niels(SB)
		local Difference = Edwards25519.Sub(RKA, SBNiels)

		Difference = Edwards25519.Double(Difference)
		Difference = Edwards25519.Double(Difference)
		Difference = Edwards25519.Double(Difference)

		local DifferenceX = buffer.create(104)
		local DifferenceT = buffer.create(104)
		buffer.copy(DifferenceX, 0, Difference, 0 * 104, 104)
		buffer.copy(DifferenceT, 0, Difference, 3 * 104, 104)

		local XIsZero = FieldPrime.Eqz(DifferenceX)
		local TIsZero = FieldPrime.Eqz(DifferenceT)

		return XIsZero and TIsZero
	end

	function EDDSA.VerifyBatch(Entries: {SignatureEntry}): boolean
		local Count = #Entries
		if Count == 0 then
			return true
		end

		if Count == 1 then
			local Entry = Entries[1]
			return EDDSA.Verify(Entry.Message, Entry.PublicKey, Entry.Signature)
		end

		local TranscriptData = {}
		local ParsedData = {}

		for Index, Entry in Entries do
			local PublicKey = Entry.PublicKey
			local Message = Entry.Message
			local Signature = Entry.Signature

			if typeof(PublicKey) ~= "buffer" or buffer.len(PublicKey) ~= ED25519_PUBLIC_KEY_SIZE then
				return false
			end

			if typeof(Message) ~= "buffer" then
				return false
			end

			if typeof(Signature) ~= "buffer" or buffer.len(Signature) ~= ED25519_SIGNATURE_SIZE then
				return false
			end

			local LastByte = buffer.readu8(Signature, 63)
			if bit32.band(LastByte, 0xE0) ~= 0x00 then
				return false
			end

			local CommitmentBytes = buffer.create(32)
			buffer.copy(CommitmentBytes, 0, Signature, 0, 32)
			local ResponseBytes = buffer.create(32)
			buffer.copy(ResponseBytes, 0, Signature, 32, 32)

			if not FieldQuadratic.IsValidScalar(ResponseBytes) then
				return false
			end

			local PublicPoint = Edwards25519.Decode(PublicKey)
			if not PublicPoint then
				return false
			end

			local CommitmentPoint = Edwards25519.Decode(CommitmentBytes)
			if not CommitmentPoint then
				return false
			end

			local ChallengeInput = ConcatBuffers(CommitmentBytes, PublicKey, Message)
			local ChallengeHash = SHA512(ChallengeInput)
			local ChallengeScalar = FieldQuadratic.DecodeWide(ChallengeHash)

			local ResponseScalar = FieldQuadratic.Decode(ResponseBytes)

			table.insert(TranscriptData, ChallengeHash)
			table.insert(TranscriptData, ResponseBytes)

			ParsedData[Index] = {
				PublicPoint = PublicPoint,
				CommitmentPoint = CommitmentPoint,
				ChallengeScalar = ChallengeScalar,
				ResponseScalar = ResponseScalar,
			}
		end

		local TranscriptBuffer = ConcatBuffers(table.unpack(TranscriptData))

		local SumS: buffer? = nil
		local Accumulator: buffer? = nil

		for Index, Parsed in ParsedData do
			local IndexBuffer = buffer.create(2)
			buffer.writeu16(IndexBuffer, 0, Index)
			local ZInput = ConcatBuffers(IndexBuffer, TranscriptBuffer)
			local ZHash = SHA512(ZInput)

			local ZBytes = buffer.create(32)
			buffer.copy(ZBytes, 0, ZHash, 0, 32)
			buffer.writeu8(ZBytes, 31, bit32.band(buffer.readu8(ZBytes, 31), 0x0F))
			local Z = FieldQuadratic.Decode(ZBytes)

			local ZS = FieldQuadratic.Mul(Z, Parsed.ResponseScalar)
			if SumS == nil then
				SumS = ZS
			else
				SumS = FieldQuadratic.Add(SumS, ZS)
			end

			local ZH = FieldQuadratic.Mul(Z, Parsed.ChallengeScalar)
			local ZHBits, ZHBitCount = FieldQuadratic.Bits(ZH)
			local ZHA = Edwards25519.Mul(Parsed.PublicPoint, ZHBits, ZHBitCount)

			local ZBits, ZBitCount = FieldQuadratic.Bits(Z)
			local ZR = Edwards25519.Mul(Parsed.CommitmentPoint, ZBits, ZBitCount)

			local ZHANiels = Edwards25519.Niels(ZHA)
			local ZRHA = Edwards25519.Add(ZR, ZHANiels)

			if Accumulator == nil then
				Accumulator = ZRHA
			else
				local ZRHANiels = Edwards25519.Niels(ZRHA)
				Accumulator = Edwards25519.Add(Accumulator, ZRHANiels)
			end
		end

		if SumS == nil or Accumulator == nil then
			return false
		end

		local SumSBits, SumSBitCount = FieldQuadratic.Bits(SumS)
		local LeftSide = Edwards25519.MulG(SumSBits, SumSBitCount)

		local LeftNiels = Edwards25519.Niels(LeftSide)
		local Difference = Edwards25519.Sub(Accumulator :: buffer, LeftNiels)

		Difference = Edwards25519.Double(Difference)
		Difference = Edwards25519.Double(Difference)
		Difference = Edwards25519.Double(Difference)

		local DifferenceX = buffer.create(104)
		local DifferenceT = buffer.create(104)
		buffer.copy(DifferenceX, 0, Difference, 0 * 104, 104)
		buffer.copy(DifferenceT, 0, Difference, 3 * 104, 104)

		local XIsZero = FieldPrime.Eqz(DifferenceX)
		local TIsZero = FieldPrime.Eqz(DifferenceT)

		return XIsZero and TIsZero
	end

	return EDDSA

end }


local __cache = {}

local function __split(s)
	local out = {}
	for part in s:gmatch("[^/]+") do
		table.insert(out, part)
	end
	return out
end

local function __norm(parts)
	local out = {}
	for _, p in ipairs(parts) do
		if p == ".." then
			table.remove(out)
		else
			table.insert(out, p)
		end
	end
	return table.concat(out, "/")
end

-- Resolve a require spec relative to the requiring module's directory.
local function __resolve(dir, spec)
	local s = spec
	if s:sub(1, 6) == "@self/" then
		s = s:sub(7)
	elseif s:sub(1, 2) == "./" then
		s = s:sub(3)
	end
	return __norm(__split(dir .. "/" .. s))
end

local function __req(key)
	local m = __cache[key]
	if not m then
		local entry = __mods[key] or __mods[key .. "/init"]
		if not entry then
			error("ZEMVAR auth: missing module " .. key, 0)
		end
		local function boundRequire(spec)
			return __req(__resolve(entry.dir, spec))
		end
		m = entry.fn(boundRequire)
		__cache[key] = m
	end
	return m
end

-------------------------------------------------------------------------------
-- ! host wiring
-------------------------------------------------------------------------------
local HttpService = game:GetService("HttpService")

-- Ed25519 provider (external, pinned; only Verification.EdDSA is consumed).
local Cryptography = { Verification = { EdDSA = __req("crypto/EdDSA/init") } }

local Adapter = __req("sdk/RobloxCryptographyAdapter")
local ClientMod = __req("sdk/Client")

-- Roblox os.time() epoch calibration: stock clients return seconds since
-- 2001-08-23 (offset exactly 998654400 from Unix); many executors return
-- real Unix time. Pick the interpretation that lands after Nov 2023.
local ROBLOX_EPOCH_OFFSET = 998654400
local _epochOffset = 0
do
	local t = os.time()
	if t < 1700000000 and (t + ROBLOX_EPOCH_OFFSET) >= 1700000000 then
		_epochOffset = ROBLOX_EPOCH_OFFSET
	end
end

-- createHost runs the Ed25519 known-answer self-test eagerly.
local host = Adapter.createHost(HttpService, Cryptography)
host.nowSeconds = function()
	return os.time() + _epochOffset
end

-------------------------------------------------------------------------------
-- ! configuration (public IDs only; no private keys embedded)
-------------------------------------------------------------------------------
local CONFIG = {
	apiOrigin = "https://api.letmeauth.com",
	applicationId = "lma_app_53RT85Xw8Y040yKVQwGXPQMp",
	environment = "production",
	flowId = "lma_flow_uPQ8p2sFaIgYeP4DNeLkYpwn",
	maxClockSkewSeconds = 120,
}

local CLIENT_VERSION = "zemvar-android/1.0"

-------------------------------------------------------------------------------
-- ! storage (internal files with plain-file fallback)
-------------------------------------------------------------------------------
local STORE_INSTALL_ID = "zemvar_install_id"
local STORE_LICENSE_KEY = "zemvar_license_key"
local STORE_PENDING_CLAIM = "zemvar_pending_claim"

local function _storeRead(name)
	if type(readinternal) == "function" and type(isinternalfile) == "function" then
		if isinternalfile(name) then
			return readinternal(name)
		end
		return nil
	end
	if type(readfile) == "function" and type(isfile) == "function" then
		if isfile(name) then
			return readfile(name)
		end
	end
	return nil
end

local function _storeWrite(name, data)
	local ok
	if type(writeinternal) == "function" then
		ok = pcall(writeinternal, name, data)
	else
		ok = pcall(writefile, name, data)
	end
	return ok and true or false
end

local function _storeDelete(name)
	if type(deleteinternal) == "function" then
		pcall(deleteinternal, name)
		return true
	end
	if type(delfile) == "function" or type(deletefile) == "function" then
		local del = delfile or deletefile
		pcall(del, name)
		return true
	end
	return _storeWrite(name, "")
end

-------------------------------------------------------------------------------
-- ! install id (stable across restarts; not IP-based)
-------------------------------------------------------------------------------
local _installId = nil

local function getInstallId()
	if _installId then
		return _installId
	end
	local existing = _storeRead(STORE_INSTALL_ID)
	if type(existing) == "string" and #existing >= 16 and existing:match("^[%w%-_]+$") then
		_installId = existing
		return _installId
	end
	local id = nil
	local ok, guid = pcall(HttpService.GenerateGUID, HttpService, false)
	if ok and type(guid) == "string" then
		id = (guid:gsub("[{}]", ""))
	end
	if not id or #id < 16 then
		local chars = "0123456789abcdef"
		local parts = {}
		for i = 1, 32 do
			parts[i] = chars:sub(math.random(1, 16), math.random(1, 16))
		end
		id = table.concat(parts)
	end
	_storeWrite(STORE_INSTALL_ID, id)
	_installId = id
	return _installId
end

-------------------------------------------------------------------------------
-- ! client singleton (lazy; init validates config + Ed25519 conformance)
-------------------------------------------------------------------------------
local _client = nil
local _initErr = nil

local function getClient()
	if _client then
		return _client, nil
	end
	if _initErr then
		return nil, _initErr
	end
	getInstallId()
	local ok, clientOrErr = pcall(ClientMod.new, host, CONFIG)
	if not ok or type(clientOrErr) ~= "table" then
		_initErr = if type(clientOrErr) == "string" then clientOrErr else "client init failed"
		return nil, _initErr
	end
	_client = clientOrErr
	return _client, nil
end

-------------------------------------------------------------------------------
-- ! pending claim persistence (restart/resume support)
-------------------------------------------------------------------------------
local function savePendingClaim(claim)
	local ok, encoded = pcall(HttpService.JSONEncode, HttpService, claim)
	if not ok or type(encoded) ~= "string" then
		return false
	end
	return _storeWrite(STORE_PENDING_CLAIM, encoded)
end

local function loadPendingClaim()
	local raw = _storeRead(STORE_PENDING_CLAIM)
	if type(raw) ~= "string" or #raw == 0 then
		return nil
	end
	local ok, decoded = pcall(HttpService.JSONDecode, HttpService, raw)
	if not ok or type(decoded) ~= "table" then
		_storeDelete(STORE_PENDING_CLAIM)
		return nil
	end
	-- Structural check: must carry the fields restoreAccessFlowClaim requires.
	for _, field in ipairs({
		"protocolVersion",
		"applicationId",
		"environment",
		"flowId",
		"sessionId",
		"sessionExpiresAt",
		"claimId",
		"claimToken",
		"claimExpiresAt",
		"nonce",
	}) do
		if decoded[field] == nil then
			_storeDelete(STORE_PENDING_CLAIM)
			return nil
		end
	end
	return decoded
end

local function clearPendingClaim()
	_storeDelete(STORE_PENDING_CLAIM)
end

-------------------------------------------------------------------------------
-- ! license key storage
-------------------------------------------------------------------------------
local function saveLicenseKey(key)
	return _storeWrite(STORE_LICENSE_KEY, key)
end

local function getStoredLicenseKey()
	local raw = _storeRead(STORE_LICENSE_KEY)
	if type(raw) == "string" and #raw >= 8 then
		return raw:match("^(.-)%s*$")
	end
	return nil
end

-------------------------------------------------------------------------------
-- ! flow callbacks (wired by the host script to UI messaging + unlock)
-------------------------------------------------------------------------------
local _callbacks = { onMessage = function(_msg) end, onUnlocked = function() end }

local function configure(opts)
	if type(opts) == "table" then
		if type(opts.onMessage) == "function" then
			_callbacks.onMessage = opts.onMessage
		end
		if type(opts.onUnlocked) == "function" then
			_callbacks.onUnlocked = opts.onUnlocked
		end
	end
end

local function say(msg)
	pcall(_callbacks.onMessage, msg)
end

-------------------------------------------------------------------------------
-- ! get-key claim flow (create/resume + bounded background polling)
-------------------------------------------------------------------------------
local POLL_INTERVAL_MS = 3000
local SESSION_TIMEOUT_MS = 15 * 60 * 1000 -- per-launch bound; claim TTL also bounds

local _flow = { active = false, cancelled = false }

local function nowMs()
	return (os.time() + _epochOffset) * 1000
end

-- Handle a completed claim result: persist key on allow, clear claim either way.
local function handleCompletedClaim(state)
	clearPendingClaim()
	if state.decision == "allow" and type(state.license) == "table" and state.license.key then
		saveLicenseKey(state.license.key)
		say("Zemvar key activated.")
		pcall(_callbacks.onUnlocked)
	else
		say("Activation finished: " .. tostring(state.code or "denied"))
	end
end

local function runPollLoop(claim, startedAtMs)
	while not _flow.cancelled do
		if nowMs() - startedAtMs > SESSION_TIMEOUT_MS then
			say("Waiting for activation timed out. Tap Get Key to try again.")
			break
		end
		local ok, stateOrErr = pcall(ClientMod.pollAccessFlowClaim, _client, claim)
		if not ok then
			local msg = if type(stateOrErr) == "string" then stateOrErr else "poll failed"
			-- Expired claims are terminal: drop the persisted claim.
			if msg:find("expired", 1, true) then
				clearPendingClaim()
				say("Activation link expired. Tap Get Key for a new one.")
			else
				say(msg .. " (will retry)")
			end
		else
			if stateOrErr.status == "completed" then
				handleCompletedClaim(stateOrErr)
				break
			end
		end
		task.wait(POLL_INTERVAL_MS / 1000)
	end
	_flow.active = false
end

-- Create a claim (or reuse the pending one), open/copy its URL, poll in background.
local function startGetKeyFlow()
	if _flow.active then
		return true, "already running"
	end
	local client, err = getClient()
	if not client then
		return false, err or "auth not ready"
	end

	local claim = loadPendingClaim()
	local createdNew = false
	if claim == nil then
		local ok, resultOrErr = pcall(
			ClientMod.createAccessFlowClaim,
			client,
			{ flowId = CONFIG.flowId, deviceId = getInstallId(), clientVersion = CLIENT_VERSION }
		)
		if not ok or type(resultOrErr) ~= "table" then
			return false, if type(resultOrErr) == "string" then resultOrErr else "claim creation failed"
		end
		claim = resultOrErr
		createdNew = true
	end

	if not savePendingClaim(claim) then
		say("Warning: could not persist activation state; restart will need a new link.")
	end

	-- Open the launch URL in a browser when possible, else copy it.
	local opened = false
	for _, name in ipairs({ "openurl", "open_url" }) do
		if type(_G[name]) == "function" then
			opened = pcall(_G[name], claim.flowUrl) and true or false
			break
		end
	end
	if not opened then
		local okCopy = pcall(setclipboard, claim.flowUrl)
		if okCopy then
			say("Activation link copied. Paste it into your browser to finish.")
		else
			say(claim.flowUrl)
		end
	end

	_flow.active = true
	_flow.cancelled = false
	local startedAtMs = nowMs()
	task.spawn(function()
		runPollLoop(claim, startedAtMs)
	end)
	return true, if createdNew then "created" else "resumed"
end

-- Single-shot check of a persisted claim; restarts background polling if pending.
local function resumePendingClaim()
	local client, err = getClient()
	if not client then
		return "error", err or "auth not ready"
	end
	local claim = loadPendingClaim()
	if claim == nil then
		return "none", nil
	end

	local ok, stateOrErr = pcall(ClientMod.pollAccessFlowClaim, client, claim)
	if not ok then
		local msg = if type(stateOrErr) == "string" then stateOrErr else "poll failed"
		if msg:find("expired", 1, true) then
			clearPendingClaim()
		return "expired", nil
		end
		-- Transient error: let the background loop retry.
	else
		if stateOrErr.status == "completed" then
			handleCompletedClaim(stateOrErr)
			return if stateOrErr.decision == "allow" then "completed-allow" else "completed-deny", nil
		end
	end

	-- Still pending: resume bounded background polling.
	if not _flow.active then
		_flow.active = true
		_flow.cancelled = false
		local startedAtMs = nowMs()
		task.spawn(function()
			runPollLoop(claim, startedAtMs)
		end)
	end
	return "pending", nil
end

local function cancelFlow()
	_flow.cancelled = true
end

-------------------------------------------------------------------------------
-- ! authorization (recurring at startup + manual key entry)
-------------------------------------------------------------------------------
-- Authorize a license key for this install. Persists the key on allow.
local function authorizeKey(key)
	if type(key) ~= "string" or #key < 8 then
		return nil, "no key"
	end
	local client, err = getClient()
	if not client then
		return nil, err or "auth not ready"
	end
	local ok, resultOrErr = pcall(
		ClientMod.authorizeLicense,
		client,
		{ licenseKey = key, deviceId = getInstallId(), clientVersion = CLIENT_VERSION }
	)
	if not ok then
		return nil, if type(resultOrErr) == "string" then resultOrErr else "authorization failed"
	end
	local result = resultOrErr
	if result.decision == "allow" then
		saveLicenseKey(key)
		clearPendingClaim()
	end
	return result, nil
end

-------------------------------------------------------------------------------
-- ! public API
-------------------------------------------------------------------------------
local M = {}

function M.init()
	local _clientRef, err = getClient()
	if not _clientRef then
		return false, err or "auth init failed"
	end
	return true, nil
end

M.getInstallId = getInstallId
M.authorizeKey = authorizeKey
M.startGetKeyFlow = startGetKeyFlow
M.resumePendingClaim = resumePendingClaim
M.cancelFlow = cancelFlow
M.configure = configure
M.getStoredLicenseKey = getStoredLicenseKey
M.hasPendingClaim = function()
	return loadPendingClaim() ~= nil
end

-- Exposed for host-script diagnostics (not part of the protocol surface).
M._debug = {
	epochOffset = _epochOffset,
	config = CONFIG,
}

return M
    end)()

    -- ! callbacks
    local onMessage = function(message)end;

    do
        local okInit, initErr = pcall(ZEMVAR_AUTH.init)
        if not okInit then
            warn("Zemvar auth init failed: " .. tostring(initErr))
        end
    end

    ZEMVAR_AUTH.configure({
        onMessage = function(msg)
            onMessage(tostring(msg))
        end,
        onUnlocked = function()
            local env = uienv and uienv() or nil
            local grant = type(env) == "table" and env.GrantAccess or nil
            if type(grant) == "function" then
                pcall(grant)
            end
        end
    })

    -- ! functions (same surface as the old platoboost block)
    local verifyKey = function(key)
        local result, err = ZEMVAR_AUTH.authorizeKey(key)
        if type(result) == "table" and result.decision == "allow" then
            return true;
        end
        onMessage(tostring(err or (type(result) == "table" and result.code or "key is invalid.")))
        return false;
    end

    local copyLink = function()
        local ok, msg = ZEMVAR_AUTH.startGetKeyFlow()
        if not ok then
            onMessage(tostring(msg or "failed to start activation"))
        end
    end

    -- Remote flag hook (platoboost legacy). LetMeAuth has no flags endpoint;
    -- keyless beta mode is replaced by issued keys / free entitlements.
    local getFlag = function(_name)
        return nil
    end
    -------------------------------------------------------------------------------
    if not game:IsLoaded() then
	repeat
		task.wait()
	until game:IsLoaded();
    end
		
    local loader = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/XxEASTRxX/Zemvar-Public/main/loader/dev_loader.lua"))()
    local loadAssets, getAsset, getProgress = loader.loadAssets, loader.getAsset, loader.getProgress

    loadAssets()

    local title = "Zemvar Upgrade";
    local url = "https://zemvar.com";

    local versionsToUpdate = {"2.633.513", "2.634.417", "2.635.590", "2.636.626", "2.637.730", "2.638.610", "2.642.635"};

    -- Updater internals [START]
    local fVersion, fStringFormat = Version, string.format;
    local currentVersion = fVersion();
    local localizationService = game:GetService("LocalizationService");

    local execname, execversion = identifyexecutor();

    local sLocaleId = localizationService.SystemLocaleId;
    local translationVector1 = {
        [0] = {
            code = "es",
            locale = "es-es",
            translated = "Copiar URL"
        },
        [1] = {
            code = "nl",
            locale = "nl-nl",
            translated = "Kopie URL"
        },
        [2] = {
            code = "pt",
            locale = "pt-br",
            translated = "Copiar URL"
        },
        [3] = {
            code = "tr",
            locale = "tr-tr",
            translated = "Url'yi kopyala"
        },
        [4] = {
            code = "fi",
            locale = "fi-fi",
            translated = "Kopioida URL -osoite"
        },
        [5] = {
            code = "de",
            locale = "de-de",
            translated = "URL kopieren"
        },
        [6] = {
            code = "it",
            locale = "it-it",
            translated = "Copia URL"
        },
        [7] = {
            code = "ko",
            locale = "ko-kr",
            translated = "URL을 복사하십시오"
        },
        [8] = {
            code = "tl",
            locale = "tl-ph",
            translated = "Kopyahin ang URL"
        },
        [9] = {
            code = "ar",
            locale = "ar-sa",
            translated = "إنسخ الرابط"
        },
        [10] = {
            code = "hi",
            locale = "hi-in",
            translated = "यूआरएल कॉपी करें"
        },
        [11] = {
            code = "da",
            locale = "da-dk",
            translated = "Kopier URL"
        },
        [12] = {
            code = "ru",
            locale = "ru-ru",
            translated = "Копия URL"
        },
        [13] = {
            code = "el",
            locale = "el-gr",
            translated = "Αντιγραφή URL"
        },
        [14] = {
            code = "cs",
            locale = "cs-cz",
            translated = "Kopírovat URL"
        },
        [15] = {
            code = "en",
            locale = "en-us",
            translated = "Copy URL"
        },
        [16] = {
            code = "pl",
            locale = "pl-pl",
            translated = "Kopiuj URL"
        },
        [17] = {
            code = "fr",
            locale = "fr-fr",
            translated = "Copier le lien"
        },
        [18] = {
            code = "sv",
            locale = "sv-se",
            translated = "Kopiera URL"
        },
        [19] = {
            code = "th",
            locale = "th-th",
            translated = "คัดลอก URL"
        },
        [20] = {
            code = "ja",
            locale = "ja-jp",
            translated = "URLをコピーします"
        },
        [21] = {
            code = "zh",
            locale = "zh-cn",
            translated = "复制URL"
        },
        [22] = {
            code = "zh",
            locale = "zh-tw",
            translated = "複製URL"
        },
        [23] = {
            code = "vi",
            locale = "vi-vn",
            translated = "Sao chép URL"
        },
        [24] = {
            code = "ms",
            locale = "ms-my",
            translated = "Salin URL"
        },
        [25] = {
            code = "hu",
            locale = "hu-hu",
            translated = "Másolja az URL -t"
        },
        [26] = {
            code = "id",
            locale = "id-id",
            translated = "Salin URL"
        },
        [27] = {
            code = "ro",
            locale = "ro-ro",
            translated = "URL de copiere"
        }
    }
    local translationVector2 = {
        [0] = {
            code = "en",
            locale = "en-us",
            translated = "Your version (%s) of Roblox is out of date and will not work properly. Please update it at Zemvar's website: https://zemvar.com"
        },
        [1] = {
            code = "hi",
            locale = "hi-in",
            translated = "Roblox का आपका संस्करण (%s) पुराना है और ठीक से काम नहीं करेगा।कृपया इसे डेल्टा की वेबसाइट पर अपडेट करें: https://zemvar.com"
        },
        [2] = {
            code = "zh",
            locale = "zh-cn",
            translated = "您的Roblox版本（%s）已过时，无法正常工作。请在Zemvar的网站上进行更新：https://zemvar.com"
        },
        [3] = {
            code = "es",
            locale = "es-es",
            translated = "Su versión (%s) de Roblox está desactualizada y no funcionará correctamente.Actualizarlo en el sitio web de Zemvar: https://zemvar.com"
        },
        [4] = {
            code = "vi",
            locale = "vi-vn",
            translated = "Phiên bản của bạn (%s) của Roblox đã lỗi thời và sẽ không hoạt động đúng.Vui lòng cập nhật nó tại trang web của Zemvar: https://zemvar.com"
        },
        [5] = {
            code = "id",
            locale = "id-id",
            translated = "Versi Anda (%s) dari Roblox sudah ketinggalan zaman dan tidak akan berfungsi dengan baik.Harap perbarui di situs web Zemvar: https://zemvar.com"
        },
        [6] = {
            code = "el",
            locale = "el-gr",
            translated = "Η έκδοση σας (%s) του Roblox είναι ξεπερασμένη και δεν θα λειτουργήσει σωστά.Ενημερώστε το στην ιστοσελίδα της Zemvar: https://zemvar.com"
        },
        [7] = {
            code = "da",
            locale = "da-dk",
            translated = "Din version (%s) af Roblox er forældet og fungerer ikke korrekt.Opdater det på Zemvar's websted: https://zemvar.com"
        },
        [8] = {
            code = "tl",
            locale = "tl-ph",
            translated = "Ang iyong bersyon (%s) ng Roblox ay wala sa oras at hindi gagana nang maayos.Mangyaring i -update ito sa website ng Zemvar: https://zemvar.com"
        },
        [9] = {
            code = "sv",
            locale = "sv-se",
            translated = "Din version (%s) av Roblox är föråldrad och fungerar inte korrekt.Uppdatera den på Zemvars webbplats: https://zemvar.com"
        },
        [10] = {
            code = "ko",
            locale = "ko-kr",
            translated = "Roblox의 버전 (%s)은 구식이 아니며 제대로 작동하지 않습니다.델타 웹 사이 트 https://zemvar.com에서 업데이트하십시오"
        },
        [11] = {
            code = "pl",
            locale = "pl-pl",
            translated = "Twoja wersja (%s) Roblox jest nieaktualna i nie będzie działać poprawnie.Zaktualizuj go na stronie internetowej Zemvar: https://zemvar.com"
        },
        [12] = {
            code = "ru",
            locale = "ru-ru",
            translated = "Ваша версия (%s) Roblox устарела и не будет работать должным образом.Пожалуйста, обновите его на веб -сайте Zemvar: https://zemvar.com"
        },
        [13] = {
            code = "ja",
            locale = "ja-jp",
            translated = "Robloxのバージョン（%s）は時代遅れであり、適切に機能しません。ZemvarのWeb サイトhttps://zemvar.comで更新してください"
        },
        [14] = {
            code = "nl",
            locale = "nl-nl",
            translated = "Uw versie (%s) van Roblox is verouderd en werkt niet goed.Werk het bij op de website van Zemvar: https://zemvar.com"
        },
        [15] = {
            code = "ms",
            locale = "ms-my",
            translated = "Versi anda (%s) Roblox sudah ketinggalan zaman dan tidak akan berfungsi dengan baik.Sila kemas kini di laman web Zemvar: https://zemvar.com"
        },
        [16] = {
            code = "pt",
            locale = "pt-br",
            translated = "Sua versão (%s) do Roblox está desatualizada e não funcionará corretamente.Atualize -o no site da Zemvar: https://zemvar.com"
        },
        [17] = {
            code = "tr",
            locale = "tr-tr",
            translated = "Roblox'un sürümünüz (%s) güncel değil ve düzgün çalışmayacak.Lütfen Zemvar'nın web sitesinde güncelleyin: https://zemvar.com"
        },
        [18] = {
            code = "hu",
            locale = "hu-hu",
            translated = "A Roblox verziója (%s) elavult, és nem fog megfelelően működni.Kérjük, frissítse a Zemvar weboldalán: https://zemvar.com"
        },
        [19] = {
            code = "fi",
            locale = "fi-fi",
            translated = "Robloxin versio (%s) on vanhentunut eikä toimi kunnolla.Päivitä se Zemvar -verkkosivustolla: https://zemvar.com"
        },
        [20] = {
            code = "de",
            locale = "de-de",
            translated = "Ihre Version (%s) von Roblox ist veraltet und funktioniert nicht ordnungsgemäß.Bitte aktualisieren Sie es auf der Website von Zemvar: https://zemvar.com"
        },
        [21] = {
            code = "th",
            locale = "th-th",
            translated = "เวอร์ชันของคุณ (%s) ของ Roblox ล้าสมัยและจะทำงานไม่ถูกต้องโปรดอัปเดตที่เว          ว็บไซต์ของ Zemvar: https://zemvar.com"
        },
        [22] = {
            code = "ar",
            locale = "ar-sa",
            translated = "نسختك (%s) من Roblox قديمة ولن تعمل بشكل صحيح.يرجى تحديثه على موقع Zemvar على الويب: https://zemvar.com"
        },
        [23] = {
            code = "cs",
            locale = "cs-cz",
            translated = "Vaše verze (%s) ROBLOX je zastaralá a nebude fungovat správně.Aktualizujte ji na webových stránkách Zemvar: https://zemvar.com"
        },
        [24] = {
            code = "zh",
            locale = "zh-tw",
            translated = "您的Roblox版本（%s）已過時，無法正常工作。請在Zemvar的網站上進行更新：https://zemvar.com"
        },
        [25] = {
            code = "it",
            locale = "it-it",
            translated = "La tua versione (%s) di Roblox è obsole e non funzionerà correttamente.Aggiornalo sul sito web di Zemvar: https://zemvar.com"
        }
    }

    function split_locale(input_locale)
        local result = {}
        local from = 1
        local delim_from, delim_to = string.find(input_locale, "-", from)
        while delim_from do
            table.insert(result, string.sub(input_locale, from, delim_from - 1))
            from = delim_to + 1
            delim_from, delim_to = string.find(input_locale, "-", from)
        end
        table.insert(result, string.sub(input_locale, from))
        return result
    end

    function searchTranslationVector(vector, locale)
        -- find by locale
        for _, translation in next, vector do
            if (string.lower(translation.locale) == string.lower(locale)) then
                return translation.translated;
            end
        end

        -- find by code
        for _, translation in next, vector do
            if (string.lower(translation.code) == string.lower(locale)) then
                return translation.translated;
            end
        end

        if string.find(locale, "-") then
            local l1, l2 = unpack(split_locale(locale));

            for _, translation in next, vector do
                if (string.lower(translation.code) == string.lower(l1)) then
                    return translation.translated;
                end
            end

            for _, translation in next, vector do
                if (string.lower(translation.code) == string.lower(l2)) then
                    return translation.translated;
                end
            end
        end

        for _, translation in next, vector do
            if (string.lower(translation.code) == "en") then
                return translation.translated;
            end
        end
    end

    function showModal(a, b, c)
        local d = {}
        local e = game:GetService("GuiService")
        d["1"] = Instance.new("ScreenGui", gethui())
        d["1"]["IgnoreGuiInset"] = true;
        d["1"]["Enabled"] = false;
        d["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
        d["1"]["Name"] = [[LOADERLoadingScreen]]
        d["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
        d["1"]["ResetOnSpawn"] = false;
        d["2"] = Instance.new("Frame", d["1"])
        d["2"]["ZIndex"] = -100;
        d["2"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
        d["2"]["BackgroundTransparency"] = 0.6600000262260437;
        d["2"]["Size"] = UDim2.new(2, 0, 2, 0)
        d["2"]["Position"] = UDim2.new(-1, 0, -1, 0)
        d["2"]["Name"] = [[DarkOverlay]]
        d["3"] = Instance.new("ImageLabel", d["1"])
        d["3"].BorderSizePixel = 0;
        d["3"].ScaleType = Enum.ScaleType.Crop;
        d["3"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        d["3"].Image = getAsset"13387419794"
        d["3"].LayoutOrder = 10;
        d["3"].Size = UDim2.new(0.32863849401474, 0, 0.31259891390800476, 0)
        d["3"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        d["3"].Name = "MainFrame"
        local f = d["3"].Size;
        local g = e:GetScreenResolution().X / 2;
        local h = e:GetScreenResolution().Y / 2;
        local i = g - f.X.Offset / 2;
        local j = h - f.Y.Offset / 2;
        d["3"].Position = UDim2.new(0, i, 0, j / 20)
        d["4"] = Instance.new("UICorner", d["3"])
        d["4"]["CornerRadius"] = UDim.new(0.07000000029802322, 0)
        d["5"] = Instance.new("ImageLabel", d["3"])
        d["5"]["BackgroundColor3"] = Color3.fromRGB(26, 27, 36)
        d["5"]["Image"] = getAsset[[13387657138]]
        d["5"]["LayoutOrder"] = 10;
        d["5"]["Size"] = UDim2.new(1, 0, 1, 0)
        d["5"]["Name"] = [[Overlay]]
        d["5"]["BackgroundTransparency"] = 0.800000011920929;
        d["6"] = Instance.new("UICorner", d["5"])
        d["6"]["CornerRadius"] = UDim.new(0.07000000029802322, 0)
        d["7"] = Instance.new("TextLabel", d["5"])
        d["7"]["TextWrapped"] = true;
        d["7"]["TextScaled"] = true;
        d["7"]["BackgroundColor3"] = Color3.fromRGB(118, 192, 255)
        d["7"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        d["7"]["TextSize"] = 14;
        d["7"]["TextColor3"] = Color3.fromRGB(203, 244, 255)
        d["7"]["AnchorPoint"] = Vector2.new(0, 0.5)
        d["7"]["Size"] = UDim2.new(0.6451469659805298, 0, 0.1418459564447403, 0)
        d["7"]["Text"] = a;
        d["7"]["Name"] = [[Title]]
        d["7"]["BackgroundTransparency"] = 1;
        d["7"]["Position"] = UDim2.new(0.1773512363433838, 0, 0.2073548913002014, 0)
        d["8"] = Instance.new("TextLabel", d["5"])
        d["8"]["TextWrapped"] = true;
        d["8"]["TextScaled"] = true;
        d["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
        d["8"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        d["8"]["TextSize"] = 36;
        d["8"]["TextColor3"] = Color3.fromRGB(203, 244, 255)
        d["8"]["AnchorPoint"] = Vector2.new(0, 0.5)
        d["8"]["Size"] = UDim2.new(0.8879498243331909, 0, 0.4277613639831543, 0)
        d["8"]["Text"] = b;
        local k = d;
        k["13"] = Instance.new("ImageButton", k["5"])
        k["13"]["Active"] = false;
        k["13"]["BorderSizePixel"] = 0;
        k["13"]["BackgroundColor3"] = Color3.fromRGB(31, 37, 47)
        k["13"]["Selectable"] = false;
        k["13"]["AnchorPoint"] = Vector2.new(0, 1)
        k["13"]["Size"] = UDim2.new(0.6975729584693909, 0, 0.1604293990135193, 0)
        k["13"]["Name"] = [[Button2]]
        k["13"]["Position"] = UDim2.new(0.15, 0, 0.9699996423721313, 0)
        k["14"] = Instance.new("UICorner", k["13"])
        k["14"]["CornerRadius"] = UDim.new(0.20000000298023224, 0)
        k["15"] = Instance.new("UIStroke", k["13"])
        k["15"]["Color"] = Color3.fromRGB(31, 37, 47)
        k["15"]["Thickness"] = 2;
        k["16"] = Instance.new("TextLabel", k["13"])
        k["16"]["TextWrapped"] = true;
        k["16"]["BorderSizePixel"] = 0;
        k["16"]["TextScaled"] = true;
        k["16"]["BackgroundColor3"] = Color3.fromRGB(31, 37, 47)
        k["16"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        k["16"]["TextSize"] = 14;
        k["16"]["TextColor3"] = Color3.fromRGB(162, 191, 212)
        k["16"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
        k["16"]["Size"] = UDim2.new(0.8865329027175903, 0, 0.5, 0)
        k["16"]["Text"] = searchTranslationVector(translationVector1, sLocaleId);
        k["16"]["Name"] = [[Input]]
        k["16"]["BackgroundTransparency"] = 1;
        k["16"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)
        k["13"].MouseButton1Click:Connect(function()
            setclipboard(c)
        end)
        d["8"]["Name"] = [[Desc]]
        d["8"]["BackgroundTransparency"] = 1;
        d["8"]["Position"] = UDim2.new(0.06185942143201828, 0, 0.5393086075782776, 0)
        d["9"] = Instance.new("Frame", d["3"])
        d["9"]["ZIndex"] = 0;
        d["9"]["BorderSizePixel"] = 0;
        d["9"]["BackgroundTransparency"] = 1;
        d["9"]["Size"] = UDim2.new(1, 0, 1, 0)
        d["9"]["Name"] = [[DropShadowHolder]]
        d["a"] = Instance.new("ImageLabel", d["9"])
        d["a"]["ZIndex"] = 0;
        d["a"]["BorderSizePixel"] = 0;
        d["a"]["SliceCenter"] = Rect.new(49, 49, 450, 450)
        d["a"]["ScaleType"] = Enum.ScaleType.Slice;
        d["a"]["ImageColor3"] = Color3.fromRGB(0, 0, 0)
        d["a"]["ImageTransparency"] = 0.699999988079071;
        d["a"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
        d["a"]["Image"] = getAsset[[6014261993]]
        d["a"]["Size"] = UDim2.new(1, 47, 1, 47)
        d["a"]["Name"] = [[DropShadow]]
        d["a"]["BackgroundTransparency"] = 1;
        d["a"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)
        d["b"] = Instance.new("UIAspectRatioConstraint", d["3"])
        d["b"]["AspectRatio"] = 1.8712739944458008;
        local l = {}
        local m = d["1"]
        local n = game:GetService("TweenService")
        local o = m.MainFrame;
        local p = m.DarkOverlay;
        local q = false;
        local r = 0.6;
        function l:Start()
            q = true;
            m.Enabled = true;
            o.Position = UDim2.new(0.336, 0, -0.372, 0)
            p.Transparency = 1;
            local s = n:Create(o, TweenInfo.new(r, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.336, 0, 0.322, 0)
            })
            local t = n:Create(p, TweenInfo.new(r, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 0.66
            })
            s:Play()
            t:Play()
            t.Completed:Wait()
        end
        coroutine.wrap(function()
            l:Start()
        end)()
    end

    --[[if execversion ~= "1.3.652.762" then
        local message = fStringFormat(searchTranslationVector(translationVector2, sLocaleId), execversion);
        showModal(title, message, url);
        error(message);
        return
    end--]]

    --[[
    for _, outdatedVersion in next, versionsToUpdate do
        if (currentVersion == outdatedVersion) then
            local message = fStringFormat(searchTranslationVector(translationVector2, sLocaleId), currentVersion);
            showModal(title, message, url);
            error(message);
            return
        end
    end
    ]]--

    local httpService = cloneref(game:GetService("HttpService"));

    local _tablefind = clonefunction(table.find);

    local isA = clonefunction(game.IsA);

    local GuiService = game:GetService("GuiService")

    if not isinternalfile("iconsize") then
        writeinternal("iconsize", "Medium")
    end

    if not isinternalfile("iconshape") then
        writeinternal("iconshape", "Squircle")
    end

    if not isinternalfile("iconcolor") then
        writeinternal("iconcolor", "Blue")
    end

    uienv().syn_backup = syn

    if not isinternalfile("uses_syn") then
        uienv().syn = nil
    end

    -- Go to near end line for configs.

    local Players_BC = game:GetService("Players")

local blacklist = {
    "672a0ae340e8ce7e21a51e37c6bf0cc1",
    "aa63ce25cd44fa60f0b155dcc3593445",
    "fe9186f93ffe4000120ba5db7ef9443b",
    "c84ecefd7fa63a35d454d3ecefe3ee7e",
    "e945f55997c4240abc865c0bcc2136c5",
    "588c84c135c213eb9badde611f08be9b",	
}


local function executescript(sc)
    run_script(sc)
end

--[[local function executescript(sc)
    for _, blocked in ipairs(blacklist) do
        if string.find(sc, blocked) then
            local player = Players_BC.LocalPlayer
            if player then
                player:Kick("Malicious Script Blocked: Auth Headers/Cookie Retrieval Attempt")
            end
            return -- early exit only if match found
        end
    end
    run_script(sc)
end ]]--

    uienv().readclipboard_hideenv = nil

    local DELTA = {};

    -- StarterGui.Delta
    DELTA["1"] = Instance.new("ScreenGui", gethui());
    DELTA["1"]["Name"] = tostring({}):sub(10);
    DELTA["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
    DELTA["1"]["ResetOnSpawn"] = false;
    DELTA["1"]["DisplayOrder"] = 10;
    DELTA["1"].Enabled = false

    -- Dis is for floating icon Players
    DELTA["Ui"] = Instance.new("ScreenGui", gethui())
    DELTA["Ui"].Enabled = false
    DELTA["Ui"].Name = tostring({}):sub(10)

    DELTA["DaIcon"] = Instance.new("ImageButton", DELTA["Ui"])

    local iconsize = readinternal("iconsize")
    if iconsize == "Medium" then
        DELTA["DaIcon"].Size = UDim2.new(0, 45, 0, 45)
    elseif iconsize == "Small" then
        DELTA["DaIcon"].Size = UDim2.new(0, 30, 0, 30)
    elseif iconsize == "Large" then
        DELTA["DaIcon"].Size = UDim2.new(0, 60, 0, 60)
    else
        DELTA["DaIcon"].Size = UDim2.new(0, 45, 0, 45)
    end

    if not isfile("zemvar_logo.png") then
        local new_logo = game:HttpGetAsync(
            "https://raw.githubusercontent.com/XxEASTRxX/Zemvar-Public/main/logo/zemvar_logo.png")
        writefile("zemvar_logo.png", new_logo)
    end

    local DaIconSize = DELTA["DaIcon"].Size
    local ScreenCenterX = GuiService:GetScreenResolution().X / 2
    local ScreenCenterY = GuiService:GetScreenResolution().Y / 2

    local DaIconPositionX = ScreenCenterX - DaIconSize.X.Offset / 2
    local DaIconPositionY = ScreenCenterY - DaIconSize.Y.Offset / 2
    DELTA["DaIcon"].Position = UDim2.new(0, DaIconPositionX, 0, DaIconPositionY / 20)
    DELTA["DaIcon"].Draggable = true
    DELTA["DaIcon"].Image = getcustomasset("zemvar_logo.png")
    DELTA["DaIcon"].BackgroundColor3 = Color3.fromRGB(48, 50, 59)

    DELTA["das"] = Instance.new("UICorner", DELTA["DaIcon"]);

    local iconsize = readinternal("iconshape")
    if iconsize == "Squircle" then
        DELTA["das"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);
    elseif iconsize == "Circle" then
        DELTA["das"]["CornerRadius"] = UDim.new(0.50000000298023224, 0);
    elseif iconsize == "Square" then
        DELTA["das"]["CornerRadius"] = UDim.new(0, 0);
    else
        DELTA["das"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);
    end

    DELTA["daStroke"] = Instance.new("UIStroke", DELTA["DaIcon"])
    DELTA["daStroke"].Thickness = 2
    DELTA["daStroke"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local iconsize = readinternal("iconcolor")
    if iconsize == "Blue" then
        DELTA["daStroke"].Color = Color3.fromRGB(65, 169, 255)
    elseif iconsize == "Green" then
        DELTA["daStroke"].Color = Color3.fromRGB(55, 219, 69)
    elseif iconsize == "Purple" then
        DELTA["daStroke"].Color = Color3.fromRGB(125, 65, 255)
    else
        DELTA["daStroke"].Color = Color3.fromRGB(65, 169, 255)
    end

    -- StarterGui.Delta.KeySystem
    DELTA["2"] = Instance.new("Frame", DELTA["1"]);
    DELTA["2"]["BackgroundColor3"] = Color3.fromRGB(26, 28, 36);
    DELTA["2"]["AnchorPoint"] = Vector2.new(1, 0.5);
    DELTA["2"]["Size"] = UDim2.new(0.328000009059906, 0, 1.2, 0);
    DELTA["2"]["Position"] = UDim2.new(1, 0, 0.5, 0);
    DELTA["2"]["Visible"] = false;
    DELTA["2"]["Name"] = tostring({}):sub(10);

    -- StarterGui.Delta.KeySystem.Holder
    DELTA["3"] = Instance.new("Frame", DELTA["2"]);
    DELTA["3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["3"]["AnchorPoint"] = Vector2.new(1, 0.5);
    DELTA["3"]["BackgroundTransparency"] = 1;
    DELTA["3"]["Size"] = UDim2.new(1, 0, 1, 0);
    DELTA["3"]["Position"] = UDim2.new(1, 0, 0.5, 0);
    DELTA["3"]["Name"] = [[Holder]];

    -- StarterGui.Delta.KeySystem.Holder.UIListLayout
    DELTA["4"] = Instance.new("UIListLayout", DELTA["3"]);
    DELTA["4"]["Padding"] = UDim.new(0.03999999910593033, 0);
    DELTA["4"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.KeySystem.Holder.Title
    DELTA["5"] = Instance.new("Frame", DELTA["3"]);
    DELTA["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["5"]["BackgroundTransparency"] = 1;
    DELTA["5"]["Size"] = UDim2.new(1, 0, 0.18677474558353424, 0);
    DELTA["5"]["Name"] = [[Title]];

    -- StarterGui.Delta.KeySystem.Holder.Title.UIListLayout
    DELTA["6"] = Instance.new("UIListLayout", DELTA["5"]);
    DELTA["6"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.KeySystem.Holder.Title.Title
    DELTA["7"] = Instance.new("TextLabel", DELTA["5"]);
    DELTA["7"]["TextWrapped"] = true;
    DELTA["7"]["TextScaled"] = true;
    DELTA["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["7"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["7"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["7"]["TextSize"] = 14;
    DELTA["7"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["7"]["AnchorPoint"] = Vector2.new(0.5, 0);
    DELTA["7"]["Size"] = UDim2.new(0.8398135900497437, 0, 0.4, 0);
    DELTA["7"]["Text"] = [[Welcome back!]];
    DELTA["7"]["Name"] = [[Title]];
    DELTA["7"]["BackgroundTransparency"] = 1;
    DELTA["7"]["Position"] = UDim2.new(0.4199067950248718, 0, 0, 0);

    -- StarterGui.Delta.KeySystem.Holder.Title.Paragraph
    DELTA["8"] = Instance.new("TextLabel", DELTA["5"]);
    DELTA["8"]["TextWrapped"] = true;
    DELTA["8"]["TextScaled"] = true;
    DELTA["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["8"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["8"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["8"]["TextSize"] = 14;
    DELTA["8"]["TextColor3"] = Color3.fromRGB(115, 127, 152);
    DELTA["8"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["8"]["Size"] = UDim2.new(0.8980631828308105, 0, 0.35361653566360474, 0);
    DELTA["8"]["Text"] = [[Access Zemvar through completing the key system, doesn't take long!]];
    DELTA["8"]["Name"] = [[Paragraph]];
    DELTA["8"]["BackgroundTransparency"] = 1;
    DELTA["8"]["Position"] = UDim2.new(0.4490315914154053, 0, 0.85361647605896, 0);

    -- StarterGui.Delta.KeySystem.Holder.Input
    DELTA["9"] = Instance.new("Frame", DELTA["3"]);
    DELTA["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["9"]["BackgroundTransparency"] = 1;
    DELTA["9"]["LayoutOrder"] = 1;
    DELTA["9"]["Size"] = UDim2.new(1, 0, 0.13557736575603485, 0);
    DELTA["9"]["Position"] = UDim2.new(0, 0, 0.22365736961364746, 0);
    DELTA["9"]["Name"] = [[Input]];

    -- StarterGui.Delta.KeySystem.Holder.Input.Title
    DELTA["a"] = Instance.new("TextLabel", DELTA["9"]);
    DELTA["a"]["TextWrapped"] = true;
    DELTA["a"]["TextScaled"] = true;
    DELTA["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["a"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["a"]["TextSize"] = 14;
    DELTA["a"]["TextColor3"] = Color3.fromRGB(129, 143, 164);
    DELTA["a"]["AnchorPoint"] = Vector2.new(0.5, 0);
    DELTA["a"]["Size"] = UDim2.new(0.6213776469230652, 0, 0.2623675465583801, 0);
    DELTA["a"]["Text"] = [[Enter key]];
    DELTA["a"]["Name"] = [[Title]];
    DELTA["a"]["BackgroundTransparency"] = 1;
    DELTA["a"]["Position"] = UDim2.new(0.3106888234615326, 0, -2.339766922432318e-07, 0);

    -- StarterGui.Delta.KeySystem.Holder.Input.TextBox
    DELTA["b"] = Instance.new("Frame", DELTA["9"]);
    DELTA["b"]["BorderSizePixel"] = 0;
    DELTA["b"]["BackgroundColor3"] = Color3.fromRGB(31, 37, 47);
    DELTA["b"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["b"]["Size"] = UDim2.new(0.9975729584693909, 0, 0.6160375475883484, 0);
    DELTA["b"]["Position"] = UDim2.new(0.49878647923469543, 0, 1, 0);
    DELTA["b"]["Name"] = [[TextBox]];

    -- StarterGui.Delta.KeySystem.Holder.Input.TextBox.Input
    DELTA["c"] = Instance.new("TextBox", DELTA["b"]);
    DELTA["c"]["Active"] = true;
    DELTA["c"]["PlaceholderColor3"] = Color3.fromRGB(104, 120, 144);
    DELTA["c"]["BorderSizePixel"] = 0;
    DELTA["c"]["TextSize"] = 14;
    DELTA["c"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["c"]["TextWrapped"] = true;
    DELTA["c"]["TextScaled"] = true;
    DELTA["c"]["BackgroundColor3"] = Color3.fromRGB(31, 37, 47);
    DELTA["c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["c"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular,
        Enum.FontStyle.Normal);
    DELTA["c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["c"]["BackgroundTransparency"] = 1;
    DELTA["c"]["PlaceholderText"] = [[examplekey123$]];
    DELTA["c"]["Size"] = UDim2.new(0.8865329027175903, 0, 0.5, 0);
    DELTA["c"]["Selectable"] = false;
    DELTA["c"]["Text"] = [[]];
    DELTA["c"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    DELTA["c"]["Name"] = [[Input]];

    -- StarterGui.Delta.KeySystem.Holder.Input.TextBox.UICorner
    DELTA["d"] = Instance.new("UICorner", DELTA["b"]);
    DELTA["d"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.KeySystem.Holder.Buttons
    DELTA["e"] = Instance.new("Frame", DELTA["3"]);
    DELTA["e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["e"]["BackgroundTransparency"] = 1;
    DELTA["e"]["LayoutOrder"] = 2;
    DELTA["e"]["Size"] = UDim2.new(1, 0, 0.19585928320884705, 0);
    DELTA["e"]["Position"] = UDim2.new(0, 0, 0.39611735939979553, 0);
    DELTA["e"]["Name"] = [[Buttons]];

    -- StarterGui.Delta.KeySystem.Holder.Buttons.Button1
    DELTA["f"] = Instance.new("ImageButton", DELTA["e"]);
    DELTA["f"]["Active"] = false;
    DELTA["f"]["BorderSizePixel"] = 0;
    DELTA["f"]["BackgroundColor3"] = Color3.fromRGB(60, 137, 196);
    DELTA["f"]["Selectable"] = false;
    DELTA["f"]["Size"] = UDim2.new(0.9975729584693909, 0, 0.43042951822280884, 0);
    DELTA["f"]["Name"] = [[Button1]];
    DELTA["f"]["BackgroundTransparency"] = 0.8799999952316284;

    -- StarterGui.Delta.KeySystem.Holder.Buttons.Button1.UICorner
    DELTA["10"] = Instance.new("UICorner", DELTA["f"]);
    DELTA["10"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.KeySystem.Holder.Buttons.Button1.UIStroke
    DELTA["11"] = Instance.new("UIStroke", DELTA["f"]);
    DELTA["11"]["Color"] = Color3.fromRGB(60, 137, 196);
    DELTA["11"]["Thickness"] = 2;

    -- StarterGui.Delta.KeySystem.Holder.Buttons.Button1.Input
    DELTA["12"] = Instance.new("TextLabel", DELTA["f"]);
    DELTA["12"]["TextWrapped"] = true;
    DELTA["12"]["BorderSizePixel"] = 0;
    DELTA["12"]["TextScaled"] = true;
    DELTA["12"]["BackgroundColor3"] = Color3.fromRGB(31, 37, 47);
    DELTA["12"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["12"]["TextSize"] = 14;
    DELTA["12"]["TextColor3"] = Color3.fromRGB(140, 206, 255);
    DELTA["12"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["12"]["Size"] = UDim2.new(0.8865329027175903, 0, 0.5, 0);
    DELTA["12"]["Text"] = [[Continue]];
    DELTA["12"]["Name"] = [[Input]];
    DELTA["12"]["BackgroundTransparency"] = 1;
    DELTA["12"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.KeySystem.Holder.Buttons.Button2
    DELTA["13"] = Instance.new("ImageButton", DELTA["e"]);
    DELTA["13"]["Active"] = false;
    DELTA["13"]["BorderSizePixel"] = 0;
    DELTA["13"]["BackgroundColor3"] = Color3.fromRGB(31, 37, 47);
    DELTA["13"]["Selectable"] = false;
    DELTA["13"]["AnchorPoint"] = Vector2.new(0, 1);
    DELTA["13"]["Size"] = UDim2.new(0.9975729584693909, 0, 0.4304293990135193, 0);
    DELTA["13"]["Name"] = [[Button2]];
    DELTA["13"]["Position"] = UDim2.new(0, 0, 0.9999996423721313, 0);

    -- StarterGui.Delta.KeySystem.Holder.Buttons.Button2.UICorner
    DELTA["14"] = Instance.new("UICorner", DELTA["13"]);
    DELTA["14"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.KeySystem.Holder.Buttons.Button2.UIStroke
    DELTA["15"] = Instance.new("UIStroke", DELTA["13"]);
    DELTA["15"]["Color"] = Color3.fromRGB(31, 37, 47);
    DELTA["15"]["Thickness"] = 2;

    -- StarterGui.Delta.KeySystem.Holder.Buttons.Button2.Input
    DELTA["16"] = Instance.new("TextLabel", DELTA["13"]);
    DELTA["16"]["TextWrapped"] = true;
    DELTA["16"]["BorderSizePixel"] = 0;
    DELTA["16"]["TextScaled"] = true;
    DELTA["16"]["BackgroundColor3"] = Color3.fromRGB(31, 37, 47);
    DELTA["16"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["16"]["TextSize"] = 14;
    DELTA["16"]["TextColor3"] = Color3.fromRGB(162, 191, 212);
    DELTA["16"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["16"]["Size"] = UDim2.new(0.8865329027175903, 0, 0.5, 0);
    DELTA["16"]["Text"] = [[Receive Key]];
    DELTA["16"]["Name"] = [[Input]];
    DELTA["16"]["BackgroundTransparency"] = 1;
    DELTA["16"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.KeySystem.Holder.Message
    DELTA["17"] = Instance.new("ImageLabel", DELTA["3"]);
    DELTA["17"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["17"]["Image"] = getAsset[[13363093418]];
    DELTA["17"]["LayoutOrder"] = 3;
    DELTA["17"]["Size"] = UDim2.new(1, 0, 0.13, 0);
    DELTA["17"]["Name"] = [[Message]];
    DELTA["17"]["BackgroundTransparency"] = 1;
    DELTA["17"]["Position"] = UDim2.new(0, 0, 0.6288594007492065, 0);

    -- StarterGui.Delta.KeySystem.Holder.Message.Paragraph
    DELTA["18"] = Instance.new("TextLabel", DELTA["17"]);
    DELTA["18"]["TextWrapped"] = true;
    DELTA["18"]["TextScaled"] = true;
    DELTA["18"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["18"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["18"]["TextSize"] = 14;
    DELTA["18"]["TextColor3"] = Color3.fromRGB(115, 127, 152);
    DELTA["18"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["18"]["Size"] = UDim2.new(0.6844813227653503, 0, 0.4, 0);
    DELTA["18"]["Text"] = [[Start exploiting when you complete our key system!]];
    DELTA["18"]["Name"] = [[Paragraph]];
    DELTA["18"]["BackgroundTransparency"] = 1;
    DELTA["18"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.KeySystem.Holder.Button2
    DELTA["19"] = Instance.new("ImageButton", DELTA["3"]);
    DELTA["19"]["Active"] = false;
    DELTA["19"]["BorderSizePixel"] = 0;
    DELTA["19"]["BackgroundColor3"] = Color3.fromRGB(31, 37, 47);
    DELTA["19"]["Selectable"] = false;
    DELTA["19"]["LayoutOrder"] = 4;
    DELTA["19"]["AnchorPoint"] = Vector2.new(0, 1);
    DELTA["19"]["Size"] = UDim2.new(0.9975730180740356, 0, 0.08399911224842072, 0);
    DELTA["19"]["Name"] = [[Button2]];
    DELTA["19"]["Position"] = UDim2.new(0, 0, 0.9326172471046448, 0);

    -- StarterGui.Delta.KeySystem.Holder.Button2.UICorner
    DELTA["1a"] = Instance.new("UICorner", DELTA["19"]);
    DELTA["1a"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.KeySystem.Holder.Button2.Input
    DELTA["1b"] = Instance.new("TextButton", DELTA["19"]);
    DELTA["1b"]["TextWrapped"] = true;
    DELTA["1b"]["Active"] = false;
    DELTA["1b"]["BorderSizePixel"] = 0;
    DELTA["1b"]["AutoButtonColor"] = false;
    DELTA["1b"]["TextScaled"] = true;
    DELTA["1b"]["BackgroundColor3"] = Color3.fromRGB(31, 37, 47);
    DELTA["1b"]["TextSize"] = 14;
    DELTA["1b"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["1b"]["TextColor3"] = Color3.fromRGB(162, 191, 212);
    DELTA["1b"]["Selectable"] = false;
    DELTA["1b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["1b"]["Size"] = UDim2.new(0.8865329027175903, 0, 0.5, 0);
    DELTA["1b"]["Name"] = [[Input]];
    DELTA["1b"]["Text"] = [[Discord]];
    DELTA["1b"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    DELTA["1b"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.KeySystem.Holder.Button2.UIStroke
    DELTA["1c"] = Instance.new("UIStroke", DELTA["19"]);
    DELTA["1c"]["Color"] = Color3.fromRGB(31, 37, 47);
    DELTA["1c"]["Thickness"] = 2;

    -- StarterGui.Delta.KeySystem.UIPadding
    DELTA["1d"] = Instance.new("UIPadding", DELTA["2"]);
    DELTA["1d"]["PaddingTop"] = UDim.new(0.05000000074505806, 0);
    DELTA["1d"]["PaddingRight"] = UDim.new(0.15000000596046448, 0);
    DELTA["1d"]["PaddingLeft"] = UDim.new(0.15000000596046448, 0);

    -- StarterGui.Delta.KeySystem.ImageButton
    DELTA["1e"] = Instance.new("ImageButton", DELTA["2"]);
    DELTA["1e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["1e"]["AnchorPoint"] = Vector2.new(1, 0);
    DELTA["1e"]["Image"] = getAsset[[13363121645]];
    DELTA["1e"]["Size"] = UDim2.new(0.07999999821186066, 0, 0.07999999821186066, 0);
    DELTA["1e"]["Position"] = UDim2.new(1, 0, 0.02012072503566742, 0);
    DELTA["1e"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.KeySystem.ImageButton.UIAspectRatioConstraint
    DELTA["1f"] = Instance.new("UIAspectRatioConstraint", DELTA["1e"]);

    -- StarterGui.Delta.KeySystem.Marker
    DELTA["20"] = Instance.new("StringValue", DELTA["2"]);
    DELTA["20"]["Value"] = [[Menu]];
    DELTA["20"]["Name"] = [[Marker]];

    -- StarterGui.Delta.KeySystem.LocalScript
    DELTA["21"] = Instance.new("LocalScript", DELTA["2"]);

    -- StarterGui.Delta.Sidebar
    DELTA["22"] = Instance.new("Frame", DELTA["1"]);
    DELTA["22"]["BorderSizePixel"] = 0;
    DELTA["22"]["BackgroundColor3"] = Color3.fromRGB(24, 25, 33);
    DELTA["22"]["AnchorPoint"] = Vector2.new(1, 0.5);
    DELTA["22"]["Size"] = UDim2.new(0.07823482155799866, 0, 1.17552649974823, 0);
    DELTA["22"]["Position"] = UDim2.new(0.9997662901878357, 0, 0.4742202162742615, 0);
    DELTA["22"]["Visible"] = false;
    DELTA["22"]["Name"] = [[Sidebar]];

    -- StarterGui.Delta.Sidebar.UIListLayout
    DELTA["23"] = Instance.new("UIListLayout", DELTA["22"]);
    DELTA["23"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    DELTA["23"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
    DELTA["23"]["Padding"] = UDim.new(0.03999999910593033, 0);
    DELTA["23"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.Sidebar.Home
    DELTA["24"] = Instance.new("ImageButton", DELTA["22"]);
    DELTA["24"]["AutoButtonColor"] = false;
    DELTA["24"]["BackgroundColor3"] = Color3.fromRGB(41, 45, 58);
    DELTA["24"]["LayoutOrder"] = 1;
    --DELTA["24"]["Image"] = getAsset[[0]];
    DELTA["24"]["Size"] = UDim2.new(0.5135505795478821, 0, 0.08553311228752136, 0);
    DELTA["24"]["Name"] = [[Home]];
    DELTA["24"]["Position"] = UDim2.new(0.274707168340683, 0, 0.29129067063331604, 0);

    -- StarterGui.Delta.Sidebar.Home.UIAspectRatioConstraint
    DELTA["25"] = Instance.new("UIAspectRatioConstraint", DELTA["24"]);

    -- StarterGui.Delta.Sidebar.Home.UICorner
    DELTA["26"] = Instance.new("UICorner", DELTA["24"]);
    DELTA["26"]["CornerRadius"] = UDim.new(0.4000000059604645, 0);

    -- StarterGui.Delta.Sidebar.Home.ImageLabel
    DELTA["27"] = Instance.new("ImageLabel", DELTA["24"]);
    DELTA["27"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["27"]["ImageColor3"] = Color3.fromRGB(138, 145, 164);
    DELTA["27"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["27"]["Image"] = getAsset[[13462268450]];
    DELTA["27"]["Size"] = UDim2.new(0.4556732177734375, 0, 0.4556732177734375, 0);
    DELTA["27"]["BackgroundTransparency"] = 1;
    DELTA["27"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Sidebar.Scripthub
    DELTA["28"] = Instance.new("ImageButton", DELTA["22"]);
    DELTA["28"]["AutoButtonColor"] = false;
    DELTA["28"]["BackgroundColor3"] = Color3.fromRGB(41, 45, 58);
    DELTA["28"]["LayoutOrder"] = 3;
    --DELTA["28"]["Image"] = getAsset[[0]];
    DELTA["28"]["Size"] = UDim2.new(0.5135507583618164, 0, 0.08553311228752136, 0);
    DELTA["28"]["Name"] = [[Scripthub]];
    DELTA["28"]["Position"] = UDim2.new(0.274707168340683, 0, 0.5514350533485413, 0);

    -- StarterGui.Delta.Sidebar.Scripthub.UIAspectRatioConstraint
    DELTA["29"] = Instance.new("UIAspectRatioConstraint", DELTA["28"]);

    -- StarterGui.Delta.Sidebar.Scripthub.UICorner
    DELTA["2a"] = Instance.new("UICorner", DELTA["28"]);
    DELTA["2a"]["CornerRadius"] = UDim.new(0.4000000059604645, 0);

    -- StarterGui.Delta.Sidebar.Scripthub.ImageLabel
    DELTA["2b"] = Instance.new("ImageLabel", DELTA["28"]);
    DELTA["2b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["2b"]["ImageColor3"] = Color3.fromRGB(138, 145, 164);
    DELTA["2b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["2b"]["Image"] = getAsset[[13462270380]];
    DELTA["2b"]["Size"] = UDim2.new(0.40817680954933167, 0, 0.3085578680038452, 0);
    DELTA["2b"]["BackgroundTransparency"] = 1;
    DELTA["2b"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Sidebar.Settings
    DELTA["2c"] = Instance.new("ImageButton", DELTA["22"]);
    DELTA["2c"]["AutoButtonColor"] = false;
    DELTA["2c"]["BackgroundColor3"] = Color3.fromRGB(41, 45, 58);
    DELTA["2c"]["LayoutOrder"] = 4;
    --DELTA["2c"]["Image"] = getAsset[[0]];
    DELTA["2c"]["Size"] = UDim2.new(0.5135504603385925, 0, 0.08553305268287659, 0);
    DELTA["2c"]["Name"] = [[Settings]];
    DELTA["2c"]["Position"] = UDim2.new(0.274707168340683, 0, 0.6815073490142822, 0);

    -- StarterGui.Delta.Sidebar.Settings.UICorner
    DELTA["2d"] = Instance.new("UICorner", DELTA["2c"]);
    DELTA["2d"]["CornerRadius"] = UDim.new(0.4000000059604645, 0);

    -- StarterGui.Delta.Sidebar.Settings.UIAspectRatioConstraint
    DELTA["2e"] = Instance.new("UIAspectRatioConstraint", DELTA["2c"]);

    -- StarterGui.Delta.Sidebar.Settings.ImageLabel
    DELTA["2f"] = Instance.new("ImageLabel", DELTA["2c"]);
    DELTA["2f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["2f"]["ImageColor3"] = Color3.fromRGB(138, 145, 164);
    DELTA["2f"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["2f"]["Image"] = getAsset[[13462271348]];
    DELTA["2f"]["Size"] = UDim2.new(0.4556732177734375, 0, 0.4556732177734375, 0);
    DELTA["2f"]["BackgroundTransparency"] = 1;
    DELTA["2f"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Sidebar.Executor
    DELTA["30"] = Instance.new("ImageButton", DELTA["22"]);
    DELTA["30"]["AutoButtonColor"] = false;
    DELTA["30"]["BackgroundColor3"] = Color3.fromRGB(41, 45, 58);
    DELTA["30"]["LayoutOrder"] = 2;
    --DELTA["30"]["Image"] = getAsset[[0]];
    DELTA["30"]["Size"] = UDim2.new(0.5135505795478821, 0, 0.08553306758403778, 0);
    DELTA["30"]["Name"] = [[Executor]];
    DELTA["30"]["Position"] = UDim2.new(0.274707168340683, 0, 0.42136284708976746, 0);

    -- StarterGui.Delta.Sidebar.Executor.UIAspectRatioConstraint
    DELTA["31"] = Instance.new("UIAspectRatioConstraint", DELTA["30"]);

    -- StarterGui.Delta.Sidebar.Executor.UICorner
    DELTA["32"] = Instance.new("UICorner", DELTA["30"]);
    DELTA["32"]["CornerRadius"] = UDim.new(0.4000000059604645, 0);

    -- StarterGui.Delta.Sidebar.Executor.ImageLabel
    DELTA["33"] = Instance.new("ImageLabel", DELTA["30"]);
    DELTA["33"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["33"]["ImageColor3"] = Color3.fromRGB(138, 145, 164);
    DELTA["33"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["33"]["Image"] = getAsset[[13462269327]];
    DELTA["33"]["Size"] = UDim2.new(0.4556732177734375, 0, 0.4556732177734375, 0);
    DELTA["33"]["BackgroundTransparency"] = 1;
    DELTA["33"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Sidebar.Console
    DELTA["34"] = Instance.new("ImageButton", DELTA["22"]);
    DELTA["34"]["AutoButtonColor"] = false;
    DELTA["34"]["BackgroundColor3"] = Color3.fromRGB(41, 45, 58);
    DELTA["34"]["LayoutOrder"] = 4;
    DELTA["34"]["Size"] = UDim2.new(0.5135504603385925, 0, 0.08553305268287659, 0);
    DELTA["34"]["Name"] = [[Console]];
    DELTA["34"]["Position"] = UDim2.new(0.274707168340683, 0, 0.6815073490142822, 0);

    -- StarterGui.Delta.Sidebar.Console.UICorner
    DELTA["35"] = Instance.new("UICorner", DELTA["34"]);
    DELTA["35"]["CornerRadius"] = UDim.new(0.4000000059604645, 0);

    -- StarterGui.Delta.Sidebar.Console.UIAspectRatioConstraint
    DELTA["36"] = Instance.new("UIAspectRatioConstraint", DELTA["34"]);

    -- StarterGui.Delta.Sidebar.Console.ImageLabel
    DELTA["37"] = Instance.new("ImageLabel", DELTA["34"]);
    DELTA["37"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["37"]["ImageColor3"] = Color3.fromRGB(137, 139, 172);
    DELTA["37"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["37"]["Image"] = getAsset[[13569242972]];
    DELTA["37"]["Size"] = UDim2.new(0.4556732177734375, 0, 0.4556732177734375, 0);
    DELTA["37"]["BackgroundTransparency"] = 1;
    DELTA["37"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Sidebar.ToggleUI
    DELTA["34tf"] = Instance.new("ImageButton", DELTA["22"]);
    DELTA["34tf"]["AutoButtonColor"] = false;
    DELTA["34tf"]["BackgroundColor3"] = Color3.fromRGB(41, 45, 58);
    DELTA["34tf"]["LayoutOrder"] = 4;
    DELTA["34tf"]["Size"] = UDim2.new(0.5135504603385925, 0, 0.08553305268287659, 0);
    DELTA["34tf"]["Name"] = [[ToggleUI]];
    DELTA["34tf"]["Position"] = UDim2.new(0.274707168340683, 0, 0.6815073490142822, 0);

    -- StarterGui.Delta.Sidebar.ToggleUI.UICorner
    DELTA["35tf"] = Instance.new("UICorner", DELTA["34tf"]);
    DELTA["35tf"]["CornerRadius"] = UDim.new(0.4000000059604645, 0);

    -- StarterGui.Delta.Sidebar.ToggleUI.UIAspectRatioConstraint
    DELTA["36tf"] = Instance.new("UIAspectRatioConstraint", DELTA["34tf"]);

    -- StarterGui.Delta.Sidebar.ToggleUI.ImageLabel
    DELTA["37tf"] = Instance.new("ImageLabel", DELTA["34tf"]);
    DELTA["37tf"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["37tf"]["ImageColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["37tf"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["37tf"]["Image"] = [[http://www.roblox.com/asset?id=13711943220]];
    DELTA["37tf"]["Size"] = UDim2.new(0.4556732177734375, 0, 0.4556732177734375, 0);
    DELTA["37tf"]["BackgroundTransparency"] = 1;
    DELTA["37tf"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Sidebar.ActiveColor
    DELTA["38"] = Instance.new("Color3Value", DELTA["22"]);
    DELTA["38"]["Value"] = Color3.fromRGB(34, 160, 255);
    DELTA["38"]["Name"] = [[ActiveColor]];

    -- StarterGui.Delta.Sidebar.SidebarHandler
    DELTA["39"] = Instance.new("LocalScript", DELTA["22"]);
    DELTA["39"]["Name"] = [[SidebarHandler]];

    -- StarterGui.Delta.Sidebar.InactiveColor
    DELTA["3a"] = Instance.new("Color3Value", DELTA["22"]);
    DELTA["3a"]["Value"] = Color3.fromRGB(41, 45, 58);
    DELTA["3a"]["Name"] = [[InactiveColor]];

    -- StarterGui.Delta.Scripthub
    DELTA["3b"] = Instance.new("Frame", DELTA["1"]);
    DELTA["3b"]["ZIndex"] = 100;
    DELTA["3b"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 0);
    DELTA["3b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["3b"]["BackgroundTransparency"] = 1;
    DELTA["3b"]["Size"] = UDim2.new(0.8483448028564453, 0, 0.8924814462661743, 0);
    DELTA["3b"]["Position"] = UDim2.new(0.47624671459198, 0, 0.5082324147224426, 0);
    DELTA["3b"]["Visible"] = false;
    DELTA["3b"]["Name"] = [[Scripthub]];

    -- StarterGui.Delta.Scripthub.Searchbar
    DELTA["3c"] = Instance.new("Frame", DELTA["3b"]);
    DELTA["3c"]["ZIndex"] = 2;
    DELTA["3c"]["BackgroundColor3"] = Color3.fromRGB(38, 41, 50);
    DELTA["3c"]["Size"] = UDim2.new(1, 0, 0.12585513293743134, 0);
    DELTA["3c"]["Name"] = [[Searchbar]];

    -- StarterGui.Delta.Scripthub.Searchbar.UICorner
    DELTA["3d"] = Instance.new("UICorner", DELTA["3c"]);
    DELTA["3d"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.Scripthub.Searchbar.ImageLabel
    DELTA["3e"] = Instance.new("ImageLabel", DELTA["3c"]);
    DELTA["3e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["3e"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["3e"]["Image"] = getAsset[[13365156882]];
    DELTA["3e"]["Size"] = UDim2.new(0.025552265346050262, 0, 0.40771156549453735, 0);
    DELTA["3e"]["BackgroundTransparency"] = 1;
    DELTA["3e"]["Position"] = UDim2.new(0.01834862306714058, 0, 0.5, 0);

    -- StarterGui.Delta.Scripthub.Searchbar.ImageLabel.UIAspectRatioConstraint
    DELTA["3f"] = Instance.new("UIAspectRatioConstraint", DELTA["3e"]);

    -- StarterGui.Delta.Scripthub.Searchbar.Input
    DELTA["40"] = Instance.new("TextBox", DELTA["3c"]);
    DELTA["40"]["Active"] = true;
    DELTA["40"]["TextSize"] = 14;
    DELTA["40"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["40"]["TextWrapped"] = true;
    DELTA["40"]["TextScaled"] = true;
    DELTA["40"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["40"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["40"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["40"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["40"]["BackgroundTransparency"] = 1;
    DELTA["40"]["PlaceholderText"] = [[Search on scriptblox.com...]];
    DELTA["40"]["Size"] = UDim2.new(0.8766564130783081, 0, 0.35361653566360474, 0);
    DELTA["40"]["Selectable"] = false;
    DELTA["40"]["Text"] = [[]];
    DELTA["40"]["Position"] = UDim2.new(0.061162080615758896, 0, 0.49999991059303284, 0);
    DELTA["40"]["Name"] = [[Input]];

    -- StarterGui.Delta.Scripthub.Holder
    DELTA["41"] = Instance.new("ScrollingFrame", DELTA["3b"]);
    DELTA["41"]["CanvasSize"] = UDim2.new(0, 0, 3, 0);
    DELTA["41"]["ScrollBarImageTransparency"] = 1;
    DELTA["41"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["41"]["VerticalScrollBarInset"] = Enum.ScrollBarInset.Always;
    DELTA["41"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["41"]["BackgroundTransparency"] = 1;
    DELTA["41"]["Size"] = UDim2.new(1, 0, 0.8350700736045837, 0);
    DELTA["41"]["Selectable"] = false;
    DELTA["41"]["ScrollBarThickness"] = 0;
    DELTA["41"]["Position"] = UDim2.new(0.5, 0, 1, 0);
    DELTA["41"]["Name"] = [[Holder]];

    -- StarterGui.Delta.Scripthub.Holder.UIGridLayout
    DELTA["42"] = Instance.new("UIGridLayout", DELTA["41"]);
    DELTA["42"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
    DELTA["42"]["CellSize"] = UDim2.new(0.31299999356269836, 0, 0.10000000149011612, 0);
    DELTA["42"]["CellPadding"] = UDim2.new(0.029999999329447746, 0, 0.009999999776482582, 0);

    -- StarterGui.Delta.Scripthub.Holder.Reserved
    DELTA["43"] = Instance.new("Folder", DELTA["41"]);
    DELTA["43"]["Name"] = [[Reserved]];

    -- StarterGui.Delta.Scripthub.Holder.Reserved.OldThumbnail
    DELTA["44"] = Instance.new("ImageButton", DELTA["43"]);
    DELTA["44"]["Active"] = false;
    DELTA["44"]["BackgroundColor3"] = Color3.fromRGB(26, 27, 36);
    DELTA["44"]["Selectable"] = false;
    DELTA["44"]["Image"] = getAsset[[13365407660]];
    DELTA["44"]["Size"] = UDim2.new(0.313303679227829, 0, 0.31330370903015137, 0);
    DELTA["44"]["Name"] = [[OldThumbnail]];
    DELTA["44"]["Visible"] = false;
    DELTA["44"]["Position"] = UDim2.new(9.43648092999183e-09, 0, 0, 0);

    -- StarterGui.Delta.Scripthub.Holder.Reserved.OldThumbnail.UICorner
    DELTA["45"] = Instance.new("UICorner", DELTA["44"]);
    DELTA["45"]["CornerRadius"] = UDim.new(0.05000000074505806, 0);

    -- StarterGui.Delta.Scripthub.Holder.Reserved.OldThumbnail.Overlay
    DELTA["46"] = Instance.new("Frame", DELTA["44"]);
    DELTA["46"]["BackgroundColor3"] = Color3.fromRGB(26, 27, 36);
    DELTA["46"]["BackgroundTransparency"] = 0.09200000017881393;
    DELTA["46"]["Size"] = UDim2.new(1, 0, 1, 0);
    DELTA["46"]["Name"] = [[Overlay]];

    -- StarterGui.Delta.Scripthub.Holder.Reserved.OldThumbnail.Overlay.UICorner
    DELTA["47"] = Instance.new("UICorner", DELTA["46"]);
    DELTA["47"]["CornerRadius"] = UDim.new(0.05000000074505806, 0);

    -- StarterGui.Delta.Scripthub.Holder.Reserved.OldThumbnail.Overlay.Title
    DELTA["48"] = Instance.new("Frame", DELTA["46"]);
    DELTA["48"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["48"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["48"]["BackgroundTransparency"] = 1;
    DELTA["48"]["Size"] = UDim2.new(0.8982645273208618, 0, 0.5242727994918823, 0);
    DELTA["48"]["Position"] = UDim2.new(0.04966278374195099, 0, 0.3592950105667114, 0);
    DELTA["48"]["Name"] = [[Title]];

    -- StarterGui.Delta.Scripthub.Holder.Reserved.OldThumbnail.Overlay.Title.Title
    DELTA["49"] = Instance.new("TextLabel", DELTA["48"]);
    DELTA["49"]["TextWrapped"] = true;
    DELTA["49"]["TextScaled"] = true;
    DELTA["49"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["49"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["49"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["49"]["TextSize"] = 14;
    DELTA["49"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["49"]["Size"] = UDim2.new(0.4335988163948059, 0, 0.5, 0);
    DELTA["49"]["Text"] = [[Arsenal 🐰]];
    DELTA["49"]["Name"] = [[Title]];
    DELTA["49"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Scripthub.Holder.Reserved.OldThumbnail.Overlay.Title.Paragraph
    DELTA["4a"] = Instance.new("TextLabel", DELTA["48"]);
    DELTA["4a"]["TextWrapped"] = true;
    DELTA["4a"]["TextScaled"] = true;
    DELTA["4a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["4a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["4a"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["4a"]["TextTransparency"] = 0.30000001192092896;
    DELTA["4a"]["TextSize"] = 14;
    DELTA["4a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["4a"]["AnchorPoint"] = Vector2.new(0, 1);
    DELTA["4a"]["Size"] = UDim2.new(0.6313457489013672, 0, 0.5, 0);
    DELTA["4a"]["Text"] = [[Aimbot, triggerbot, aim assist, wall-check gui]];
    DELTA["4a"]["Name"] = [[Paragraph]];
    DELTA["4a"]["BackgroundTransparency"] = 1;
    DELTA["4a"]["Position"] = UDim2.new(0, 0, 1.0000001192092896, 0);

    -- StarterGui.Delta.Scripthub.Holder.Reserved.OldThumbnail.Overlay.Title.Verified
    DELTA["4b"] = Instance.new("Frame", DELTA["48"]);
    DELTA["4b"]["BackgroundColor3"] = Color3.fromRGB(86, 173, 239);
    DELTA["4b"]["AnchorPoint"] = Vector2.new(1, 0.5);
    DELTA["4b"]["Size"] = UDim2.new(0.3242603540420532, 0, 0.3846021890640259, 0);
    DELTA["4b"]["Position"] = UDim2.new(0.9999999403953552, 0, 0.2522916793823242, 0);
    DELTA["4b"]["Name"] = [[Verified]];

    -- StarterGui.Delta.Scripthub.Holder.Reserved.OldThumbnail.Overlay.Title.Verified.UICorner
    DELTA["4c"] = Instance.new("UICorner", DELTA["4b"]);
    DELTA["4c"]["CornerRadius"] = UDim.new(1, 0);

    -- StarterGui.Delta.Scripthub.Holder.Reserved.OldThumbnail.Overlay.Title.Verified.Title
    DELTA["4d"] = Instance.new("TextLabel", DELTA["4b"]);
    DELTA["4d"]["TextWrapped"] = true;
    DELTA["4d"]["TextScaled"] = true;
    DELTA["4d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["4d"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["4d"]["TextSize"] = 14;
    DELTA["4d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["4d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["4d"]["Size"] = UDim2.new(0.8315319418907166, 0, 0.5, 0);
    DELTA["4d"]["Text"] = [[VERIFIED]];
    DELTA["4d"]["Name"] = [[Title]];
    DELTA["4d"]["BackgroundTransparency"] = 1;
    DELTA["4d"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Scripthub.Holder.Reserved.OldThumbnail.Overlay.Views
    DELTA["4e"] = Instance.new("Frame", DELTA["46"]);
    DELTA["4e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["4e"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["4e"]["BackgroundTransparency"] = 1;
    DELTA["4e"]["Size"] = UDim2.new(0.8982645869255066, 0, 0.233791321516037, 0);
    DELTA["4e"]["Position"] = UDim2.new(0.04966278374195099, 0, 0.7775326371192932, 0);
    DELTA["4e"]["Name"] = [[Views]];

    -- StarterGui.Delta.Scripthub.Holder.Reserved.OldThumbnail.Overlay.Views.Title
    DELTA["4f"] = Instance.new("TextLabel", DELTA["4e"]);
    DELTA["4f"]["TextWrapped"] = true;
    DELTA["4f"]["TextScaled"] = true;
    DELTA["4f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["4f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["4f"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["4f"]["TextSize"] = 14;
    DELTA["4f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["4f"]["AnchorPoint"] = Vector2.new(1, 0.5);
    DELTA["4f"]["Size"] = UDim2.new(1.0098563432693481, 0, 0.473459392786026, 0);
    DELTA["4f"]["Text"] = [[10 Views]];
    DELTA["4f"]["Name"] = [[Title]];
    DELTA["4f"]["BackgroundTransparency"] = 1;
    DELTA["4f"]["Position"] = UDim2.new(1.0098564624786377, 0, 0.7708343267440796, 0);

    -- StarterGui.Delta.Scripthub.Holder.ScriptBloxHandler
    DELTA["50"] = Instance.new("LocalScript", DELTA["41"]);
    DELTA["50"]["Name"] = [[ScriptBloxHandler]];

    -- StarterGui.Delta.Scripthub.DarkOverlay
    DELTA["51"] = Instance.new("Frame", DELTA["3b"]);
    DELTA["51"]["ZIndex"] = 99999;
    DELTA["51"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
    DELTA["51"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["51"]["BackgroundTransparency"] = 0.5;
    DELTA["51"]["Size"] = UDim2.new(10, 10, 2, 0);
    DELTA["51"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    DELTA["51"]["Visible"] = false;
    DELTA["51"]["Name"] = [[DarkOverlay]];

    -- StarterGui.Delta.Scripthub.Popup
    DELTA["52"] = Instance.new("Frame", DELTA["3b"]);
    DELTA["52"]["ZIndex"] = 100000;
    DELTA["52"]["BackgroundColor3"] = Color3.fromRGB(38, 41, 49);
    DELTA["52"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["52"]["Size"] = UDim2.new(0.43205055594444275, 0, 1.0513142347335815, 0);
    DELTA["52"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    DELTA["52"]["Name"] = [[Popup]]
    DELTA["52"].Active = true
    DELTA["52"].Visible = false

    -- StarterGui.Delta.Scripthub.Popup.Title
    DELTA["53"] = Instance.new("Frame", DELTA["52"]);
    DELTA["53"]["ZIndex"] = 999999999;
    DELTA["53"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["53"]["AnchorPoint"] = Vector2.new(0.5, 0);
    DELTA["53"]["BackgroundTransparency"] = 1;
    DELTA["53"]["Size"] = UDim2.new(0.8193565607070923, 0, 0.23179079592227936, 0);
    DELTA["53"]["Position"] = UDim2.new(0.5, 0, 0.09408924728631973, 0);
    DELTA["53"]["Name"] = [[Title]];

    -- StarterGui.Delta.Scripthub.Popup.Title.UIListLayout
    DELTA["54"] = Instance.new("UIListLayout", DELTA["53"]);
    DELTA["54"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.Scripthub.Popup.Title.Title
    DELTA["55"] = Instance.new("TextLabel", DELTA["53"]);
    DELTA["55"]["TextWrapped"] = true;
    DELTA["55"]["ZIndex"] = 999999999;
    DELTA["55"]["TextScaled"] = true;
    DELTA["55"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["55"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["55"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["55"]["TextSize"] = 14;
    DELTA["55"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["55"]["AnchorPoint"] = Vector2.new(0.5, 0);
    DELTA["55"]["Size"] = UDim2.new(0.7438986301422119, 0, 0.5, 0);
    DELTA["55"]["Text"] = [[Select Your Option]];
    DELTA["55"]["Name"] = [[Title]];
    DELTA["55"]["BackgroundTransparency"] = 1;
    DELTA["55"]["Position"] = UDim2.new(0.37194931507110596, 0, 0, 0);

    -- StarterGui.Delta.Scripthub.Popup.Title.Paragraph
    DELTA["56"] = Instance.new("TextLabel", DELTA["53"]);
    DELTA["56"]["TextWrapped"] = true;
    DELTA["56"]["ZIndex"] = 999999999;
    DELTA["56"]["TextScaled"] = true;
    DELTA["56"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["56"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["56"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["56"]["TextSize"] = 14;
    DELTA["56"]["TextColor3"] = Color3.fromRGB(161, 167, 182);
    DELTA["56"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["56"]["Size"] = UDim2.new(0.7438986301422119, 0, 0.3536166250705719, 0);
    DELTA["56"]["Text"] = [[Choose whether to execute, open in a new tab, etc..]];
    DELTA["56"]["Name"] = [[Paragraph]];
    DELTA["56"]["BackgroundTransparency"] = 1;
    DELTA["56"]["Position"] = UDim2.new(0.37194931507110596, 0, 0.8536167144775391, 0);

    -- StarterGui.Delta.Scripthub.Popup.Buttons
    DELTA["57"] = Instance.new("Frame", DELTA["52"]);
    DELTA["57"]["ZIndex"] = 999999999;
    DELTA["57"]["BorderSizePixel"] = 0;
    DELTA["57"]["BackgroundColor3"] = Color3.fromRGB(22, 22, 30);
    DELTA["57"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["57"]["BackgroundTransparency"] = 1;
    DELTA["57"]["Size"] = UDim2.new(0.8189999461174011, 0, 0.5725698471069336, 0);
    DELTA["57"]["ClipsDescendants"] = true;
    DELTA["57"]["Position"] = UDim2.new(0.5, 0, 0.9148041009902954, 0);
    DELTA["57"]["Name"] = [[Buttons]];

    -- StarterGui.Delta.Scripthub.Popup.Buttons.UIListLayout
    DELTA["58"] = Instance.new("UIListLayout", DELTA["57"]);
    DELTA["58"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    DELTA["58"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
    DELTA["58"]["Padding"] = UDim.new(0.05000000074505806, 0);
    DELTA["58"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.Scripthub.Popup.Buttons.Button1
    DELTA["59"] = Instance.new("ImageButton", DELTA["57"]);
    DELTA["59"]["Active"] = false;
    DELTA["59"]["ZIndex"] = 999999999;
    DELTA["59"]["BackgroundColor3"] = Color3.fromRGB(60, 137, 196);
    DELTA["59"]["Selectable"] = false;
    DELTA["59"]["Size"] = UDim2.new(0.9621250629425049, 0, 0.16304326057434082, 0);
    DELTA["59"]["Name"] = [[Button1]];
    DELTA["59"]["Position"] = UDim2.new(0.018937479704618454, 0, 0.17102082073688507, 0);
    DELTA["59"]["BackgroundTransparency"] = 0.8899999856948853;

    -- StarterGui.Delta.Scripthub.Popup.Buttons.Button1.UICorner
    DELTA["5a"] = Instance.new("UICorner", DELTA["59"]);
    DELTA["5a"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Scripthub.Popup.Buttons.Button1.Title
    DELTA["5b"] = Instance.new("TextLabel", DELTA["59"]);
    DELTA["5b"]["TextWrapped"] = true;
    DELTA["5b"]["ZIndex"] = 999999999;
    DELTA["5b"]["TextScaled"] = true;
    DELTA["5b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["5b"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["5b"]["TextSize"] = 14;
    DELTA["5b"]["TextColor3"] = Color3.fromRGB(140, 206, 255);
    DELTA["5b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["5b"]["Size"] = UDim2.new(0.8766257762908936, 0, 0.3993089199066162, 0);
    DELTA["5b"]["Text"] = [[EXECUTE SELECTED SCRIPT]];
    DELTA["5b"]["Name"] = [[Title]];
    DELTA["5b"]["BackgroundTransparency"] = 1;
    DELTA["5b"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Scripthub.Popup.Buttons.Button1.UIStroke
    DELTA["5c"] = Instance.new("UIStroke", DELTA["59"]);
    DELTA["5c"]["Color"] = Color3.fromRGB(60, 137, 196);
    DELTA["5c"]["Thickness"] = 2;

    -- StarterGui.Delta.Scripthub.Popup.Buttons.Button2
    DELTA["5d"] = Instance.new("ImageButton", DELTA["57"]);
    DELTA["5d"]["Active"] = false;
    DELTA["5d"]["ZIndex"] = 999999999;
    DELTA["5d"]["BackgroundColor3"] = Color3.fromRGB(94, 136, 169);
    DELTA["5d"]["Selectable"] = false;
    DELTA["5d"]["LayoutOrder"] = 1;
    DELTA["5d"]["Size"] = UDim2.new(0.9621250629425049, 0, 0.16304320096969604, 0);
    DELTA["5d"]["Name"] = [[Button2]];
    DELTA["5d"]["Position"] = UDim2.new(0.018937479704618454, 0, 0.3772318959236145, 0);
    DELTA["5d"]["BackgroundTransparency"] = 0.8999999761581421;

    -- StarterGui.Delta.Scripthub.Popup.Buttons.Button2.UICorner
    DELTA["5e"] = Instance.new("UICorner", DELTA["5d"]);
    DELTA["5e"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Scripthub.Popup.Buttons.Button2.Title
    DELTA["5f"] = Instance.new("TextLabel", DELTA["5d"]);
    DELTA["5f"]["TextWrapped"] = true;
    DELTA["5f"]["TextScaled"] = true;
    DELTA["5f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["5f"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["5f"]["TextSize"] = 14;
    DELTA["5f"]["TextColor3"] = Color3.fromRGB(185, 211, 230);
    DELTA["5f"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["5f"]["Size"] = UDim2.new(0.8766260147094727, 0, 0.3993089199066162, 0);
    DELTA["5f"]["Text"] = [[OPEN SCRIPT IN EDITOR]];
    DELTA["5f"]["Name"] = [[Title]];
    DELTA["5f"]["BackgroundTransparency"] = 1;
    DELTA["5f"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Scripthub.Popup.Buttons.Button2.UIStroke
    DELTA["60"] = Instance.new("UIStroke", DELTA["5d"]);
    DELTA["60"]["Color"] = Color3.fromRGB(69, 97, 119);
    DELTA["60"]["Thickness"] = 2;

    -- StarterGui.Delta.Scripthub.Popup.Buttons.Button3
    DELTA["61"] = Instance.new("ImageButton", DELTA["57"]);
    DELTA["61"]["Active"] = false;
    DELTA["61"]["ZIndex"] = 999999999;
    DELTA["61"]["BackgroundColor3"] = Color3.fromRGB(94, 136, 169);
    DELTA["61"]["Selectable"] = false;
    DELTA["61"]["LayoutOrder"] = 2;
    DELTA["61"]["Size"] = UDim2.new(0.9621250629425049, 0, 0.1630433201789856, 0);
    DELTA["61"]["Name"] = [[Button3]];
    DELTA["61"]["Position"] = UDim2.new(0.018937479704618454, 0, 0.5834426283836365, 0);
    DELTA["61"]["BackgroundTransparency"] = 0.8999999761581421;

    -- StarterGui.Delta.Scripthub.Popup.Buttons.Button3.UICorner
    DELTA["62"] = Instance.new("UICorner", DELTA["61"]);
    DELTA["62"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Scripthub.Popup.Buttons.Button3.Title
    DELTA["63"] = Instance.new("TextLabel", DELTA["61"]);
    DELTA["63"]["TextWrapped"] = true;
    DELTA["63"]["TextScaled"] = true;
    DELTA["63"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["63"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["63"]["TextSize"] = 14;
    DELTA["63"]["TextColor3"] = Color3.fromRGB(185, 211, 230);
    DELTA["63"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["63"]["Size"] = UDim2.new(0.8766259551048279, 0, 0.3993089497089386, 0);
    DELTA["63"]["Text"] = [[SAVE SELECTED SCRIPT]];
    DELTA["63"]["Name"] = [[Title]];
    DELTA["63"]["BackgroundTransparency"] = 1;
    DELTA["63"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Scripthub.Popup.Buttons.Button3.UIStroke
    DELTA["64"] = Instance.new("UIStroke", DELTA["61"]);
    DELTA["64"]["Color"] = Color3.fromRGB(69, 97, 119);
    DELTA["64"]["Thickness"] = 2;

    -- StarterGui.Delta.Scripthub.Popup.Buttons.Button4
    DELTA["65"] = Instance.new("ImageButton", DELTA["57"]);
    DELTA["65"]["Active"] = false;
    DELTA["65"]["ZIndex"] = 999999999;
    DELTA["65"]["BackgroundColor3"] = Color3.fromRGB(94, 136, 169);
    DELTA["65"]["Selectable"] = false;
    DELTA["65"]["LayoutOrder"] = 3;
    DELTA["65"]["Size"] = UDim2.new(0.9621250629425049, 0, 0.16304323077201843, 0);
    DELTA["65"]["Name"] = [[Button4]];
    DELTA["65"]["Position"] = UDim2.new(0.018937479704618454, 0, 0.7896538376808167, 0);
    DELTA["65"]["BackgroundTransparency"] = 0.8999999761581421;

    -- StarterGui.Delta.Scripthub.Popup.Buttons.Button4.UICorner
    DELTA["66"] = Instance.new("UICorner", DELTA["65"]);
    DELTA["66"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Scripthub.Popup.Buttons.Button4.Title
    DELTA["67"] = Instance.new("TextLabel", DELTA["65"]);
    DELTA["67"]["TextWrapped"] = true;
    DELTA["67"]["TextScaled"] = true;
    DELTA["67"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["67"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["67"]["TextSize"] = 14;
    DELTA["67"]["TextColor3"] = Color3.fromRGB(185, 211, 230);
    DELTA["67"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["67"]["Size"] = UDim2.new(0.8766259551048279, 0, 0.3993089497089386, 0);
    DELTA["67"]["Text"] = [[COPY TO CLIPBOARD]];
    DELTA["67"]["Name"] = [[Title]];
    DELTA["67"]["BackgroundTransparency"] = 1;
    DELTA["67"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Scripthub.Popup.Buttons.Button4.UIStroke
    DELTA["68"] = Instance.new("UIStroke", DELTA["65"]);
    DELTA["68"]["Color"] = Color3.fromRGB(69, 97, 119);
    DELTA["68"]["Thickness"] = 2;

    -- StarterGui.Delta.Scripthub.Popup.Buttons.ButtonsHandler
    DELTA["69"] = Instance.new("LocalScript", DELTA["57"]);
    DELTA["69"]["Name"] = [[ButtonsHandler]];

    -- StarterGui.Delta.Scripthub.Popup.UICorner
    DELTA["6a"] = Instance.new("UICorner", DELTA["52"]);
    DELTA["6a"]["CornerRadius"] = UDim.new(0.05000000074505806, 0);

    -- StarterGui.Delta.Scripthub.Popup.ImageButton
    DELTA["6b"] = Instance.new("ImageButton", DELTA["52"]);
    DELTA["6b"]["ZIndex"] = 999999999;
    DELTA["6b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["6b"]["AnchorPoint"] = Vector2.new(1, 0.5);
    DELTA["6b"]["Image"] = getAsset[[13363121645]];
    DELTA["6b"]["Size"] = UDim2.new(0.04585733264684677, 0, 0.04716602712869644, 0);
    DELTA["6b"]["Position"] = UDim2.new(0.8981863260269165, 0, 0.15145258605480194, 0);
    DELTA["6b"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Scripthub.Popup.ImageButton.UIAspectRatioConstraint
    DELTA["6c"] = Instance.new("UIAspectRatioConstraint", DELTA["6b"]);

    -- StarterGui.Delta.Scripthub.Marker
    DELTA["6d"] = Instance.new("StringValue", DELTA["3b"]);
    DELTA["6d"]["Value"] = [[Menu]];
    DELTA["6d"]["Name"] = [[Marker]];

    -- StarterGui.Delta.Settings
    DELTA["6e"] = Instance.new("Frame", DELTA["1"]);
    DELTA["6e"]["ZIndex"] = 100;
    DELTA["6e"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 0);
    DELTA["6e"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["6e"]["BackgroundTransparency"] = 1;
    DELTA["6e"]["Size"] = UDim2.new(0.8064976334571838, 0, 0.9616625905036926, 0);
    DELTA["6e"]["Position"] = UDim2.new(0.47783252596855164, 0, 0.5, 0);
    DELTA["6e"]["Visible"] = false;
    DELTA["6e"]["Name"] = [[Settings]];

    -- StarterGui.Delta.Settings.Searchbar
    DELTA["6f"] = Instance.new("Frame", DELTA["6e"]);
    DELTA["6f"]["ZIndex"] = 2;
    DELTA["6f"]["BackgroundColor3"] = Color3.fromRGB(38, 41, 50);
    DELTA["6f"]["AnchorPoint"] = Vector2.new(1, 0);
    DELTA["6f"]["Size"] = UDim2.new(0.7300000190734863, 0, 0.12585513293743134, 0);
    DELTA["6f"]["Position"] = UDim2.new(1, 0, 0, 0);
    DELTA["6f"]["Name"] = [[Searchbar]];

    -- StarterGui.Delta.Settings.Searchbar.UICorner
    DELTA["70"] = Instance.new("UICorner", DELTA["6f"]);
    DELTA["70"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.Settings.Searchbar.ImageLabel
    DELTA["71"] = Instance.new("ImageLabel", DELTA["6f"]);
    DELTA["71"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["71"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["71"]["Image"] = getAsset[[13365156882]];
    DELTA["71"]["Size"] = UDim2.new(0.025552265346050262, 0, 0.40771156549453735, 0);
    DELTA["71"]["BackgroundTransparency"] = 1;
    DELTA["71"]["Position"] = UDim2.new(0.01834862306714058, 0, 0.5, 0);

    -- StarterGui.Delta.Settings.Searchbar.ImageLabel.UIAspectRatioConstraint
    DELTA["72"] = Instance.new("UIAspectRatioConstraint", DELTA["71"]);

    -- StarterGui.Delta.Settings.Searchbar.Input
    DELTA["73"] = Instance.new("TextBox", DELTA["6f"]);
    DELTA["73"]["Active"] = true;
    DELTA["73"]["TextSize"] = 14;
    DELTA["73"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["73"]["TextWrapped"] = true;
    DELTA["73"]["TextScaled"] = true;
    DELTA["73"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["73"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["73"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["73"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["73"]["BackgroundTransparency"] = 1;
    DELTA["73"]["PlaceholderText"] = [[Search for options]];
    DELTA["73"]["Size"] = UDim2.new(0.8766564130783081, 0, 0.35361653566360474, 0);
    DELTA["73"]["Selectable"] = false;
    DELTA["73"]["Text"] = [[]];
    DELTA["73"]["Position"] = UDim2.new(0.061162080615758896, 0, 0.49999991059303284, 0);
    DELTA["73"]["Name"] = [[Input]];

    -- StarterGui.Delta.Settings.Searchbar.SettingsSearchHandler
    DELTA["74"] = Instance.new("LocalScript", DELTA["6f"]);
    DELTA["74"]["Name"] = [[SettingsSearchHandler]];

    -- StarterGui.Delta.Settings.Sort
    DELTA["75"] = Instance.new("Frame", DELTA["6e"]);
    DELTA["75"]["ZIndex"] = 2;
    DELTA["75"]["BackgroundColor3"] = Color3.fromRGB(24, 25, 33);
    DELTA["75"]["Size"] = UDim2.new(0.25, 0, 0.12585513293743134, 0);
    DELTA["75"]["Name"] = [[Sort]];

    -- StarterGui.Delta.Settings.Sort.UICorner
    DELTA["76"] = Instance.new("UICorner", DELTA["75"]);
    DELTA["76"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.Settings.Sort.UIListLayout
    DELTA["77"] = Instance.new("UIListLayout", DELTA["75"]);
    DELTA["77"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    DELTA["77"]["FillDirection"] = Enum.FillDirection.Horizontal;
    DELTA["77"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
    DELTA["77"]["Padding"] = UDim.new(0.029999999329447746, 0);
    DELTA["77"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.Settings.Sort.Enabled
    DELTA["78"] = Instance.new("TextButton", DELTA["75"]);
    DELTA["78"]["TextWrapped"] = true;
    DELTA["78"]["TextScaled"] = true;
    DELTA["78"]["BackgroundColor3"] = Color3.fromRGB(51, 56, 70);
    DELTA["78"]["TextSize"] = 14;
    DELTA["78"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["78"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["78"]["Size"] = UDim2.new(0.27783116698265076, 0, 0.5168541073799133, 0);
    DELTA["78"]["LayoutOrder"] = 1;
    DELTA["78"]["Name"] = [[Enabled]];
    DELTA["78"]["Text"] = [[Enabled]];
    DELTA["78"]["Position"] = UDim2.new(0.02489338628947735, 0, 0.24157275259494781, 0);
    DELTA["78"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Settings.Sort.Enabled.UICorner
    DELTA["79"] = Instance.new("UICorner", DELTA["78"]);
    DELTA["79"]["CornerRadius"] = UDim.new(1, 0);

    -- StarterGui.Delta.Settings.Sort.Enabled.UIPadding
    DELTA["7a"] = Instance.new("UIPadding", DELTA["78"]);
    DELTA["7a"]["PaddingTop"] = UDim.new(0.30000001192092896, 0);
    DELTA["7a"]["PaddingBottom"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Settings.Sort.Disabled
    DELTA["7b"] = Instance.new("TextButton", DELTA["75"]);
    DELTA["7b"]["TextWrapped"] = true;
    DELTA["7b"]["TextScaled"] = true;
    DELTA["7b"]["BackgroundColor3"] = Color3.fromRGB(51, 56, 70);
    DELTA["7b"]["TextSize"] = 14;
    DELTA["7b"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["7b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["7b"]["Size"] = UDim2.new(0.2778310179710388, 0, 0.5168541073799133, 0);
    DELTA["7b"]["LayoutOrder"] = 2;
    DELTA["7b"]["Name"] = [[Disabled]];
    DELTA["7b"]["Text"] = [[Disabled]];
    DELTA["7b"]["Position"] = UDim2.new(0.33081313967704773, 0, 0.24157275259494781, 0);
    DELTA["7b"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Settings.Sort.Disabled.UICorner
    DELTA["7c"] = Instance.new("UICorner", DELTA["7b"]);
    DELTA["7c"]["CornerRadius"] = UDim.new(1, 0);

    -- StarterGui.Delta.Settings.Sort.Disabled.UIPadding
    DELTA["7d"] = Instance.new("UIPadding", DELTA["7b"]);
    DELTA["7d"]["PaddingTop"] = UDim.new(0.30000001192092896, 0);
    DELTA["7d"]["PaddingBottom"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Settings.Sort.All
    DELTA["7e"] = Instance.new("TextButton", DELTA["75"]);
    DELTA["7e"]["TextWrapped"] = true;
    DELTA["7e"]["TextScaled"] = true;
    DELTA["7e"]["BackgroundColor3"] = Color3.fromRGB(51, 56, 70);
    DELTA["7e"]["TextSize"] = 14;
    DELTA["7e"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["7e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["7e"]["Size"] = UDim2.new(0.2778310179710388, 0, 0.5168541073799133, 0);
    DELTA["7e"]["LayoutOrder"] = 3;
    DELTA["7e"]["Name"] = [[All]];
    DELTA["7e"]["Text"] = [[All]];
    DELTA["7e"]["Position"] = UDim2.new(0.6367325186729431, 0, 0.24157275259494781, 0);

    -- StarterGui.Delta.Settings.Sort.All.UICorner
    DELTA["7f"] = Instance.new("UICorner", DELTA["7e"]);
    DELTA["7f"]["CornerRadius"] = UDim.new(1, 0);

    -- StarterGui.Delta.Settings.Sort.All.UIPadding
    DELTA["80"] = Instance.new("UIPadding", DELTA["7e"]);
    DELTA["80"]["PaddingTop"] = UDim.new(0.30000001192092896, 0);
    DELTA["80"]["PaddingBottom"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Settings.Sort.SettingsFilterHandler
    DELTA["81"] = Instance.new("LocalScript", DELTA["75"]);
    DELTA["81"]["Name"] = [[SettingsFilterHandler]];

    -- StarterGui.Delta.Settings.Holder
    DELTA["82"] = Instance.new("ScrollingFrame", DELTA["6e"]);
    DELTA["82"]["CanvasSize"] = UDim2.new(0, 0, 4, 0);
    DELTA["82"]["ScrollBarImageTransparency"] = 1;
    DELTA["82"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["82"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["82"]["BackgroundTransparency"] = 1;
    DELTA["82"]["Size"] = UDim2.new(1, 0, 0.8416813015937805, 0);
    DELTA["82"]["Selectable"] = false;
    DELTA["82"]["ScrollBarThickness"] = 1;
    DELTA["82"]["Position"] = UDim2.new(0.5, 0, 1.0000001192092896, 0);
    DELTA["82"]["Name"] = [[Holder]];

    -- StarterGui.Delta.Settings.Holder.UIListLayout
    DELTA["83"] = Instance.new("UIListLayout", DELTA["82"]);
    DELTA["83"]["Padding"] = UDim.new(0.004999999888241291, 0);
    DELTA["83"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.Settings.Marker
    DELTA["84"] = Instance.new("StringValue", DELTA["6e"]);
    DELTA["84"]["Value"] = [[Menu]];
    DELTA["84"]["Name"] = [[Marker]];

    -- StarterGui.Delta.DarkOverlay
    DELTA["85"] = Instance.new("Frame", DELTA["1"]);
    DELTA["85"]["ZIndex"] = -100;
    DELTA["85"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
    DELTA["85"]["BackgroundTransparency"] = 0.6600000262260437;
    DELTA["85"]["Size"] = UDim2.new(2, 0, 2, 0);
    DELTA["85"]["Position"] = UDim2.new(-1, 0, -1, 0);
    DELTA["85"]["Name"] = [[DarkOverlay]];

    -- StarterGui.Delta.Executor
    DELTA["86"] = Instance.new("Frame", DELTA["1"]);
    DELTA["86"]["ZIndex"] = 100;
    DELTA["86"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 0);
    DELTA["86"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["86"]["BackgroundTransparency"] = 1;
    DELTA["86"]["Size"] = UDim2.new(0.8397729992866516, 0, 0.7730588316917419, 0);
    DELTA["86"]["Position"] = UDim2.new(0.4824247360229492, 0, 0.524213433265686, 0);
    DELTA["86"]["Visible"] = false;
    DELTA["86"]["Name"] = [[Executor]];

    -- StarterGui.Delta.Executor.Executor
    DELTA["87"] = Instance.new("ImageLabel", DELTA["86"]);
    DELTA["87"]["BorderSizePixel"] = 0;
    DELTA["87"]["ScaleType"] = Enum.ScaleType.Crop;
    DELTA["87"]["BackgroundColor3"] = Color3.fromRGB(36, 0, 0);
    DELTA["87"]["AnchorPoint"] = Vector2.new(1, 0.5);
    DELTA["87"]["Image"] = getAsset[[13387419794]];
    DELTA["87"]["Size"] = UDim2.new(0.6566376686096191, 0, 0.9981886148452759, 0);
    DELTA["87"]["ClipsDescendants"] = true;
    DELTA["87"]["Name"] = [[Executor]];
    DELTA["87"]["Position"] = UDim2.new(1.0000001192092896, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay
    DELTA["88"] = Instance.new("ImageLabel", DELTA["87"]);
    DELTA["88"]["BackgroundColor3"] = Color3.fromRGB(26, 27, 36);
    DELTA["88"]["Image"] = getAsset[[13387657138]];
    DELTA["88"]["Size"] = UDim2.new(1, 0, 1, 0);
    DELTA["88"]["Name"] = [[Overlay]];
    DELTA["88"]["BackgroundTransparency"] = 0.800000011920929;

    -- StarterGui.Delta.Executor.Executor.Overlay.UICorner
    DELTA["89"] = Instance.new("UICorner", DELTA["88"]);
    DELTA["89"]["CornerRadius"] = UDim.new(0.05000000074505806, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu
    DELTA["8a"] = Instance.new("ImageButton", DELTA["88"]);
    DELTA["8a"]["ZIndex"] = 1000;
    DELTA["8a"]["BorderSizePixel"] = 0;
    DELTA["8a"]["BackgroundColor3"] = Color3.fromRGB(22, 22, 30);
    DELTA["8a"]["AnchorPoint"] = Vector2.new(1, 0);
    --DELTA["8a"]["Image"] = getAsset[[0]];
    DELTA["8a"]["Size"] = UDim2.new(0.06392838805913925, 0, 0.08036314696073532, 0);
    DELTA["8a"]["Name"] = [[Menu]];
    DELTA["8a"]["Position"] = UDim2.new(0.9912378787994385, 0, 0.026684332638978958, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.ImageButton
    DELTA["8b"] = Instance.new("ImageButton", DELTA["8a"]);
    DELTA["8b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["8b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["8b"]["Image"] = getAsset[[13387875723]];
    DELTA["8b"]["Size"] = UDim2.new(0.0789814367890358, 0, 0.4144761860370636, 0);
    DELTA["8b"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    DELTA["8b"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.UICorner
    DELTA["8c"] = Instance.new("UICorner", DELTA["8a"]);
    DELTA["8c"]["CornerRadius"] = UDim.new(1, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.UIAspectRatioConstraint
    DELTA["8d"] = Instance.new("UIAspectRatioConstraint", DELTA["8a"]);

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown
    DELTA["8e"] = Instance.new("Frame", DELTA["8a"]);
    DELTA["8e"]["BackgroundColor3"] = Color3.fromRGB(41, 44, 52);
    DELTA["8e"]["Size"] = UDim2.new(4.045529842376709, 0, 2.321711778640747, 0);
    DELTA["8e"]["Position"] = UDim2.new(-3.045860767364502, 0, 1.093127965927124, 0);
    DELTA["8e"]["Visible"] = false;
    DELTA["8e"]["Name"] = [[Dropdown]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.UIListLayout
    DELTA["8f"] = Instance.new("UIListLayout", DELTA["8e"]);
    DELTA["8f"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    DELTA["8f"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
    DELTA["8f"]["Padding"] = UDim.new(0.029999999329447746, 0);
    DELTA["8f"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.Option1
    DELTA["90"] = Instance.new("ImageButton", DELTA["8e"]);
    DELTA["90"]["BackgroundColor3"] = Color3.fromRGB(59, 139, 254);
    DELTA["90"]["AnchorPoint"] = Vector2.new(1, 0.5);
    --DELTA["90"]["Image"] = getAsset[[0]];
    DELTA["90"]["Size"] = UDim2.new(0.8604854345321655, 0, 0.22047363221645355, 0);
    DELTA["90"]["Name"] = [[Option1]];
    DELTA["90"]["Position"] = UDim2.new(0.9302427172660828, 0, 0.276297390460968, 0);
    DELTA["90"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.Option1.UICorner
    DELTA["91"] = Instance.new("UICorner", DELTA["90"]);
    DELTA["91"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.Option1.Title
    DELTA["92"] = Instance.new("TextLabel", DELTA["90"]);
    DELTA["92"]["TextWrapped"] = true;
    DELTA["92"]["ZIndex"] = 999999999;
    DELTA["92"]["TextScaled"] = true;
    DELTA["92"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["92"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["92"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    DELTA["92"]["TextSize"] = 14;
    DELTA["92"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["92"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["92"]["Size"] = UDim2.new(0.7953082323074341, 0, 0.8179191946983337, 0);
    DELTA["92"]["Text"] = [[Default]];
    DELTA["92"]["Name"] = [[Title]];
    DELTA["92"]["BackgroundTransparency"] = 1;
    DELTA["92"]["Position"] = UDim2.new(0, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.Option1.Checked
    DELTA["93"] = Instance.new("ImageButton", DELTA["90"]);
    DELTA["93"]["BackgroundColor3"] = Color3.fromRGB(59, 139, 254);
    DELTA["93"]["AnchorPoint"] = Vector2.new(1, 0.5);
    DELTA["93"]["Image"] = getAsset[[13441695981]];
    DELTA["93"]["Size"] = UDim2.new(0.0812797099351883, 0, 0.5769613981246948, 0);
    DELTA["93"]["Name"] = [[Checked]];
    DELTA["93"]["Position"] = UDim2.new(1, 0, 0.5, 0);
    DELTA["93"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.Option1.Checked.UIAspectRatioConstraint
    DELTA["94"] = Instance.new("UIAspectRatioConstraint", DELTA["93"]);

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.Divider
    DELTA["95"] = Instance.new("Frame", DELTA["8e"]);
    DELTA["95"]["BackgroundColor3"] = Color3.fromRGB(59, 63, 74);
    DELTA["95"]["Size"] = UDim2.new(0.8604854345321655, 0, 0.012410691007971764, 0);
    DELTA["95"]["Position"] = UDim2.new(0.06975728273391724, 0, 0.4001886248588562, 0);
    DELTA["95"]["Name"] = [[Divider]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.Option2
    DELTA["96"] = Instance.new("ImageButton", DELTA["8e"]);
    DELTA["96"]["BackgroundColor3"] = Color3.fromRGB(59, 139, 254);
    DELTA["96"]["AnchorPoint"] = Vector2.new(1, 0.5);
    --DELTA["96"]["Image"] = getAsset[[0]];
    DELTA["96"]["Size"] = UDim2.new(0.8604854345321655, 0, 0.22047372162342072, 0);
    DELTA["96"]["Name"] = [[Option2]];
    DELTA["96"]["Position"] = UDim2.new(0.9302427172660828, 0, 0.5364913940429688, 0);
    DELTA["96"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.Option2.UICorner
    DELTA["97"] = Instance.new("UICorner", DELTA["96"]);
    DELTA["97"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.Option2.Title
    DELTA["98"] = Instance.new("TextLabel", DELTA["96"]);
    DELTA["98"]["TextWrapped"] = true;
    DELTA["98"]["ZIndex"] = 999999999;
    DELTA["98"]["TextScaled"] = true;
    DELTA["98"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["98"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["98"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    DELTA["98"]["TextSize"] = 14;
    DELTA["98"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["98"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["98"]["Size"] = UDim2.new(0.7953082323074341, 0, 0.8179191946983337, 0);
    DELTA["98"]["Text"] = [[Light]];
    DELTA["98"]["Name"] = [[Title]];
    DELTA["98"]["BackgroundTransparency"] = 1;
    DELTA["98"]["Position"] = UDim2.new(0, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.Option2.Checked
    DELTA["99"] = Instance.new("ImageButton", DELTA["96"]);
    DELTA["99"]["BackgroundColor3"] = Color3.fromRGB(59, 139, 254);
    DELTA["99"]["AnchorPoint"] = Vector2.new(1, 0.5);
    DELTA["99"]["Image"] = getAsset[[13441695981]];
    DELTA["99"]["Size"] = UDim2.new(0.0812797099351883, 0, 0.5769613981246948, 0);
    DELTA["99"]["Name"] = [[Checked]];
    DELTA["99"]["Visible"] = false;
    DELTA["99"]["Position"] = UDim2.new(1, 0, 0.5, 0);
    DELTA["99"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.Option2.Checked.UIAspectRatioConstraint
    DELTA["9a"] = Instance.new("UIAspectRatioConstraint", DELTA["99"]);

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.Divider
    DELTA["9b"] = Instance.new("Frame", DELTA["8e"]);
    DELTA["9b"]["BackgroundColor3"] = Color3.fromRGB(59, 63, 74);
    DELTA["9b"]["Size"] = UDim2.new(0.8604854345321655, 0, 0.012410691007971764, 0);
    DELTA["9b"]["Position"] = UDim2.new(0.06975728273391724, 0, 0.6603825688362122, 0);
    DELTA["9b"]["Name"] = [[Divider]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.Option3
    DELTA["9c"] = Instance.new("ImageButton", DELTA["8e"]);
    DELTA["9c"]["BackgroundColor3"] = Color3.fromRGB(59, 139, 254);
    DELTA["9c"]["AnchorPoint"] = Vector2.new(1, 0.5);
    --DELTA["9c"]["Image"] = getAsset[[0]];
    DELTA["9c"]["Size"] = UDim2.new(0.8604854345321655, 0, 0.2204737514257431, 0);
    DELTA["9c"]["Name"] = [[Option3]];
    DELTA["9c"]["Position"] = UDim2.new(0.9302427172660828, 0, 0.7966850399971008, 0);
    DELTA["9c"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.Option3.UICorner
    DELTA["9d"] = Instance.new("UICorner", DELTA["9c"]);
    DELTA["9d"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.Option3.Title
    DELTA["9e"] = Instance.new("TextLabel", DELTA["9c"]);
    DELTA["9e"]["TextWrapped"] = true;
    DELTA["9e"]["ZIndex"] = 999999999;
    DELTA["9e"]["TextScaled"] = true;
    DELTA["9e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["9e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["9e"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    DELTA["9e"]["TextSize"] = 14;
    DELTA["9e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["9e"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["9e"]["Size"] = UDim2.new(0.7953082323074341, 0, 0.8179191946983337, 0);
    DELTA["9e"]["Text"] = [[Amoled]];
    DELTA["9e"]["Name"] = [[Title]];
    DELTA["9e"]["BackgroundTransparency"] = 1;
    DELTA["9e"]["Position"] = UDim2.new(0, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.Option3.Checked
    DELTA["9f"] = Instance.new("ImageButton", DELTA["9c"]);
    DELTA["9f"]["BackgroundColor3"] = Color3.fromRGB(59, 139, 254);
    DELTA["9f"]["AnchorPoint"] = Vector2.new(1, 0.5);
    DELTA["9f"]["Image"] = getAsset[[13441695981]];
    DELTA["9f"]["Size"] = UDim2.new(0.0812797099351883, 0, 0.5769613981246948, 0);
    DELTA["9f"]["Name"] = [[Checked]];
    DELTA["9f"]["Visible"] = false;
    DELTA["9f"]["Position"] = UDim2.new(1, 0, 0.5, 0);
    DELTA["9f"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.Option3.Checked.UIAspectRatioConstraint
    DELTA["a0"] = Instance.new("UIAspectRatioConstraint", DELTA["9f"]);

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.Dropdown.UICorner
    DELTA["a1"] = Instance.new("UICorner", DELTA["8e"]);
    DELTA["a1"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.LocalScript
    DELTA["a2"] = Instance.new("LocalScript", DELTA["8a"]);

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons
    DELTA["a3"] = Instance.new("Frame", DELTA["88"]);
    DELTA["a3"]["ZIndex"] = 200;
    DELTA["a3"]["BorderSizePixel"] = 0;
    DELTA["a3"]["BackgroundColor3"] = Color3.fromRGB(22, 22, 30);
    DELTA["a3"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["a3"]["BackgroundTransparency"] = 1;
    DELTA["a3"]["Size"] = UDim2.new(0.96828693151474, 0, 0.17342007160186768, 0);
    DELTA["a3"]["ClipsDescendants"] = true;
    DELTA["a3"]["Position"] = UDim2.new(0.507856547832489, 0, 0.9821560382843018, 0);
    DELTA["a3"]["Name"] = [[Buttons]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.UIListLayout
    DELTA["a4"] = Instance.new("UIListLayout", DELTA["a3"]);
    DELTA["a4"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    DELTA["a4"]["FillDirection"] = Enum.FillDirection.Horizontal;
    DELTA["a4"]["Padding"] = UDim.new(0.029999999329447746, 0);
    DELTA["a4"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.Execute
    DELTA["a5"] = Instance.new("ImageButton", DELTA["a3"]);
    DELTA["a5"]["Active"] = false;
    DELTA["a5"]["ZIndex"] = 300;
    DELTA["a5"]["BackgroundColor3"] = Color3.fromRGB(60, 137, 196);
    DELTA["a5"]["Selectable"] = false;
    DELTA["a5"]["Size"] = UDim2.new(0.2561585009098053, 0, 0.7000001668930054, 0);
    DELTA["a5"]["Name"] = [[Execute]];
    DELTA["a5"]["Position"] = UDim2.new(0.008000015281140804, 0, 0.20599937438964844, 0);
    DELTA["a5"]["BackgroundTransparency"] = 0.8899999856948853;

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.Execute.UICorner
    DELTA["a6"] = Instance.new("UICorner", DELTA["a5"]);
    DELTA["a6"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.Execute.Title
    DELTA["a7"] = Instance.new("TextLabel", DELTA["a5"]);
    DELTA["a7"]["TextWrapped"] = true;
    DELTA["a7"]["TextScaled"] = true;
    DELTA["a7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["a7"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["a7"]["TextSize"] = 14;
    DELTA["a7"]["TextColor3"] = Color3.fromRGB(140, 206, 255);
    DELTA["a7"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["a7"]["Size"] = UDim2.new(0.8766257762908936, 0, 0.3993089199066162, 0);
    DELTA["a7"]["Text"] = [[EXECUTE]];
    DELTA["a7"]["Name"] = [[Title]];
    DELTA["a7"]["BackgroundTransparency"] = 1;
    DELTA["a7"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.Execute.UIStroke
    DELTA["a8"] = Instance.new("UIStroke", DELTA["a5"]);
    DELTA["a8"]["Color"] = Color3.fromRGB(60, 137, 196);
    DELTA["a8"]["Thickness"] = 2;

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.Clear
    DELTA["a9"] = Instance.new("ImageButton", DELTA["a3"]);
    DELTA["a9"]["Active"] = false;
    DELTA["a9"]["ZIndex"] = 300;
    DELTA["a9"]["BackgroundColor3"] = Color3.fromRGB(94, 136, 169);
    DELTA["a9"]["Selectable"] = false;
    DELTA["a9"]["LayoutOrder"] = 1;
    DELTA["a9"]["Size"] = UDim2.new(0.22138313949108124, 0, 0.7000001668930054, 0);
    DELTA["a9"]["Name"] = [[Clear]];
    DELTA["a9"]["Position"] = UDim2.new(0.27973994612693787, 0, 0.20599937438964844, 0);
    DELTA["a9"]["BackgroundTransparency"] = 0.9300000071525574;

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.Clear.UICorner
    DELTA["aa"] = Instance.new("UICorner", DELTA["a9"]);
    DELTA["aa"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.Clear.Title
    DELTA["ab"] = Instance.new("TextLabel", DELTA["a9"]);
    DELTA["ab"]["TextWrapped"] = true;
    DELTA["ab"]["TextScaled"] = true;
    DELTA["ab"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["ab"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["ab"]["TextSize"] = 14;
    DELTA["ab"]["TextColor3"] = Color3.fromRGB(185, 211, 230);
    DELTA["ab"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["ab"]["Size"] = UDim2.new(0.8766260147094727, 0, 0.3993089199066162, 0);
    DELTA["ab"]["Text"] = [[CLEAR]];
    DELTA["ab"]["Name"] = [[Title]];
    DELTA["ab"]["BackgroundTransparency"] = 1;
    DELTA["ab"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.Clear.UIStroke
    DELTA["ac"] = Instance.new("UIStroke", DELTA["a9"]);
    DELTA["ac"]["Color"] = Color3.fromRGB(69, 97, 119);
    DELTA["ac"]["Thickness"] = 2;

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.ExecuteClipboard
    DELTA["ad"] = Instance.new("ImageButton", DELTA["a3"]);
    DELTA["ad"]["Active"] = false;
    DELTA["ad"]["ZIndex"] = 300;
    DELTA["ad"]["BackgroundColor3"] = Color3.fromRGB(94, 136, 169);
    DELTA["ad"]["Selectable"] = false;
    DELTA["ad"]["LayoutOrder"] = 2;
    DELTA["ad"]["Size"] = UDim2.new(0.3552889823913574, 0, 0.699999988079071, 0);
    DELTA["ad"]["Name"] = [[ExecuteClipboard]];
    DELTA["ad"]["Position"] = UDim2.new(0.5057284832000732, 0, 0.20600003004074097, 0);
    DELTA["ad"]["BackgroundTransparency"] = 0.9300000071525574;

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.ExecuteClipboard.UICorner
    DELTA["ae"] = Instance.new("UICorner", DELTA["ad"]);
    DELTA["ae"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.ExecuteClipboard.Title
    DELTA["af"] = Instance.new("TextLabel", DELTA["ad"]);
    DELTA["af"]["TextWrapped"] = true;
    DELTA["af"]["TextScaled"] = true;
    DELTA["af"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["af"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["af"]["TextSize"] = 14;
    DELTA["af"]["TextColor3"] = Color3.fromRGB(185, 211, 230);
    DELTA["af"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["af"]["Size"] = UDim2.new(0.8766259551048279, 0, 0.3993089497089386, 0);
    DELTA["af"]["Text"] = [[EXECUTE CLIPBOARD]];
    DELTA["af"]["Name"] = [[Title]];
    DELTA["af"]["BackgroundTransparency"] = 1;
    DELTA["af"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.ExecuteClipboard.UIStroke
    DELTA["b0"] = Instance.new("UIStroke", DELTA["ad"]);
    DELTA["b0"]["Color"] = Color3.fromRGB(69, 97, 119);
    DELTA["b0"]["Thickness"] = 2;

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.UIPadding
    DELTA["b1"] = Instance.new("UIPadding", DELTA["a3"]);
    DELTA["b1"]["PaddingTop"] = UDim.new(0.07999999821186066, 0);
    DELTA["b1"]["PaddingRight"] = UDim.new(0.00800000037997961, 0);
    DELTA["b1"]["PaddingBottom"] = UDim.new(0.07999999821186066, 0);
    DELTA["b1"]["PaddingLeft"] = UDim.new(0.00800000037997961, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.ButtonHandlers
    DELTA["b2"] = Instance.new("LocalScript", DELTA["a3"]);
    DELTA["b2"]["Name"] = [[ButtonHandlers]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.Button3
    DELTA["b3"] = Instance.new("TextBox", DELTA["a3"]);
    DELTA["b3"]["Active"] = true;
    DELTA["b3"]["ZIndex"] = 300;
    DELTA["b3"]["TextSize"] = 21;
    DELTA["b3"]["TextWrapped"] = true;
    DELTA["b3"]["BackgroundColor3"] = Color3.fromRGB(94, 136, 169);
    DELTA["b3"]["TextColor3"] = Color3.fromRGB(185, 211, 230);
    DELTA["b3"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["b3"]["LayoutOrder"] = 2;
    DELTA["b3"]["BackgroundTransparency"] = 0.9300000071525574;
    DELTA["b3"]["Size"] = UDim2.new(0.07424724847078323, 0, 0.699999988079071, 0);
    DELTA["b3"]["Selectable"] = false;
    DELTA["b3"]["Text"] = [[]];
    DELTA["b3"]["Position"] = UDim2.new(0.9160652756690979, 0, 0.20599988102912903, 0);
    DELTA["b3"]["Visible"] = false;
    DELTA["b3"]["Name"] = [[Button3]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.Button3.UICorner
    DELTA["b4"] = Instance.new("UICorner", DELTA["b3"]);
    DELTA["b4"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.Button3.UIStroke
    DELTA["b5"] = Instance.new("UIStroke", DELTA["b3"]);
    DELTA["b5"]["Color"] = Color3.fromRGB(69, 97, 119);
    DELTA["b5"]["Thickness"] = 2;
    DELTA["b5"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

    -- StarterGui.Delta.Executor.Executor.Overlay.Tabs
    DELTA["b6"] = Instance.new("ScrollingFrame", DELTA["88"]);
    DELTA["b6"]["ZIndex"] = 200;
    DELTA["b6"]["BorderSizePixel"] = 0;
    DELTA["b6"]["CanvasSize"] = UDim2.new(2, 0, 0, 0);
    DELTA["b6"]["BackgroundColor3"] = Color3.fromRGB(22, 22, 30);
    DELTA["b6"]["HorizontalScrollBarInset"] = Enum.ScrollBarInset.Always;
    DELTA["b6"]["AutomaticCanvasSize"] = Enum.AutomaticSize.X;
    DELTA["b6"]["Size"] = UDim2.new(0.9840000867843628, 0, 0.12545627355575562, 0);
    DELTA["b6"]["Selectable"] = false;
    DELTA["b6"]["ScrollBarThickness"] = 0;
    DELTA["b6"]["Position"] = UDim2.new(0.007965609431266785, 0, 0.016980938613414764, 0);
    DELTA["b6"]["Name"] = [[Tabs]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Tabs.UIPadding
    DELTA["b7"] = Instance.new("UIPadding", DELTA["b6"]);
    DELTA["b7"]["PaddingTop"] = UDim.new(0.07999999821186066, 0);
    DELTA["b7"]["PaddingRight"] = UDim.new(0.00800000037997961, 0);
    DELTA["b7"]["PaddingBottom"] = UDim.new(0.07999999821186066, 0);
    DELTA["b7"]["PaddingLeft"] = UDim.new(0.00800000037997961, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Tabs.UIListLayout
    DELTA["b8"] = Instance.new("UIListLayout", DELTA["b6"]);
    DELTA["b8"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    DELTA["b8"]["FillDirection"] = Enum.FillDirection.Horizontal;
    DELTA["b8"]["Padding"] = UDim.new(0.009999999776482582, 0);
    DELTA["b8"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.Executor.Executor.Overlay.Tabs.AddTab
    DELTA["b9"] = Instance.new("ImageButton", DELTA["b6"]);
    DELTA["b9"]["Active"] = false;
    DELTA["b9"]["ZIndex"] = 300;
    DELTA["b9"]["BackgroundColor3"] = Color3.fromRGB(34, 41, 50);
    DELTA["b9"]["Selectable"] = false;
    DELTA["b9"]["LayoutOrder"] = 1000;
    DELTA["b9"]["Size"] = UDim2.new(0.0526634119451046, 0, 0.6154626607894897, 0);
    DELTA["b9"]["Name"] = [[AddTab]];
    DELTA["b9"]["Position"] = UDim2.new(0.26442891359329224, 0, 0.30375349521636963, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Tabs.AddTab.UICorner
    DELTA["ba"] = Instance.new("UICorner", DELTA["b9"]);
    DELTA["ba"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Tabs.AddTab.ImageButton
    DELTA["bb"] = Instance.new("ImageButton", DELTA["b9"]);
    DELTA["bb"]["Active"] = false;
    DELTA["bb"]["Modal"] = true;
    DELTA["bb"]["AutoButtonColor"] = false;
    DELTA["bb"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["bb"]["AnchorPoint"] = Vector2.new(1, 0.5);
    DELTA["bb"]["Image"] = getAsset[[13387627918]];
    DELTA["bb"]["Size"] = UDim2.new(0.35981613397598267, 0, 0.3613884449005127, 0);
    DELTA["bb"]["Rotation"] = 45;
    DELTA["bb"]["Position"] = UDim2.new(0.699999988079071, 0, 0.5, 0);
    DELTA["bb"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Executor.Executor.Overlay.Tabs.AddTab.ImageButton.UIAspectRatioConstraint
    DELTA["bc"] = Instance.new("UIAspectRatioConstraint", DELTA["bb"]);

    -- StarterGui.Delta.Executor.Executor.Overlay.Tabs.AddTab.LocalScript
    DELTA["bd"] = Instance.new("LocalScript", DELTA["b9"]);

    -- StarterGui.Delta.Executor.Executor.Overlay.Tabs.AddTab.UIAspectRatioConstraint
    DELTA["be"] = Instance.new("UIAspectRatioConstraint", DELTA["b9"]);
    DELTA["be"]["AspectRatio"] = 1.004372477531433;

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved
    DELTA["bf"] = Instance.new("Folder", DELTA["88"]);
    DELTA["bf"]["Name"] = [[Reserved]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Textbox
    DELTA["c0"] = Instance.new("TextBox", DELTA["bf"]);
    DELTA["c0"]["LineHeight"] = 1.840000033378601;
    DELTA["c0"]["TextSize"] = 21;
    DELTA["c0"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["c0"]["TextWrapped"] = false;
    DELTA["c0"]["TextYAlignment"] = Enum.TextYAlignment.Top;
    DELTA["c0"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["c0"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["c0"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
    DELTA["c0"]["ShowNativeInput"] = false;
    DELTA["c0"]["MultiLine"] = true;
    DELTA["c0"]["BackgroundTransparency"] = 1;
    DELTA["c0"]["Size"] = UDim2.new(0.9882024526596069, 0, 0.9716954827308655, 0);
    DELTA["c0"]["Text"] = "";
    DELTA["c0"]["PlaceholderText"] =
        "Thank you for using Zemvar <3\nGet Zemvar only at zemvar.com !";
    DELTA["c0"]["Position"] = UDim2.new(0.011494521982967854, 0, 0.012946978211402893, 3);
    DELTA["c0"]["AutomaticSize"] = Enum.AutomaticSize.XY;
    DELTA["c0"]["Visible"] = false;
    DELTA["c0"]["Name"] = [[Textbox]];
    DELTA["c0"]["ClearTextOnFocus"] = false;

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitchOn
    DELTA["c1"] = Instance.new("Frame", DELTA["bf"]);
    DELTA["c1"]["BackgroundColor3"] = Color3.fromRGB(31, 51, 80);
    DELTA["c1"]["Size"] = UDim2.new(1, 0, 0.03193088620901108, 0);
    DELTA["c1"]["Visible"] = false;
    DELTA["c1"]["Name"] = [[SettingSwitchOn]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitchOn.UICorner
    DELTA["c2"] = Instance.new("UICorner", DELTA["c1"]);
    DELTA["c2"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitchOn.Title
    DELTA["c3"] = Instance.new("TextLabel", DELTA["c1"]);
    DELTA["c3"]["TextWrapped"] = true;
    DELTA["c3"]["TextScaled"] = true;
    DELTA["c3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["c3"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["c3"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["c3"]["TextSize"] = 14;
    DELTA["c3"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["c3"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["c3"]["Size"] = UDim2.new(0.18567337095737457, 0, 0.31746408343315125, 0);
    DELTA["c3"]["Text"] = [[Auto Execute]];
    DELTA["c3"]["Name"] = [[Title]];
    DELTA["c3"]["BackgroundTransparency"] = 1;
    DELTA["c3"]["Position"] = UDim2.new(0, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitchOn.UIPadding
    DELTA["c4"] = Instance.new("UIPadding", DELTA["c1"]);
    DELTA["c4"]["PaddingRight"] = UDim.new(0.029999999329447746, 0);
    DELTA["c4"]["PaddingLeft"] = UDim.new(0.029999999329447746, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitchOn.Desc
    DELTA["c5"] = Instance.new("TextLabel", DELTA["c1"]);
    DELTA["c5"]["TextWrapped"] = true;
    DELTA["c5"]["TextScaled"] = true;
    DELTA["c5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["c5"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["c5"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["c5"]["TextSize"] = 14;
    DELTA["c5"]["TextColor3"] = Color3.fromRGB(126, 139, 176);
    DELTA["c5"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["c5"]["Size"] = UDim2.new(0.6590386629104614, 0, 0.23099972307682037, 0);
    DELTA["c5"]["Text"] = [[automatically execute scripts in your autoexec file upon attached.]];
    DELTA["c5"]["Name"] = [[Desc]];
    DELTA["c5"]["BackgroundTransparency"] = 1;
    DELTA["c5"]["Position"] = UDim2.new(0.18517163395881653, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitchOn.Switch
    DELTA["c6"] = Instance.new("ImageButton", DELTA["c1"]);
    DELTA["c6"]["BackgroundColor3"] = Color3.fromRGB(59, 139, 254);
    DELTA["c6"]["AnchorPoint"] = Vector2.new(1, 0.5);
    --DELTA["c6"]["Image"] = getAsset[[0]];
    DELTA["c6"]["Size"] = UDim2.new(0.06560052931308746, 0, 0.473985493183136, 0);
    DELTA["c6"]["Name"] = [[Switch]];
    DELTA["c6"]["Position"] = UDim2.new(1, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitchOn.Switch.UICorner
    DELTA["c7"] = Instance.new("UICorner", DELTA["c6"]);
    DELTA["c7"]["CornerRadius"] = UDim.new(10, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitchOn.Switch.ImageButton
    DELTA["c8"] = Instance.new("ImageLabel", DELTA["c6"]);
    DELTA["c8"]["BackgroundColor3"] = Color3.fromRGB(254, 254, 254);
    DELTA["c8"]["Selectable"] = true;
    DELTA["c8"]["AnchorPoint"] = Vector2.new(1, 0.5);
    --DELTA["c8"]["Image"] = getAsset[[0]];
    DELTA["c8"]["Size"] = UDim2.new(0.34452590346336365, 0, 0.6585104465484619, 0);
    DELTA["c8"]["Active"] = true;
    DELTA["c8"]["Name"] = [[ImageButton]];
    DELTA["c8"]["Position"] = UDim2.new(0.8884302377700806, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitchOn.Switch.ImageButton.UICorner
    DELTA["c9"] = Instance.new("UICorner", DELTA["c8"]);
    DELTA["c9"]["CornerRadius"] = UDim.new(10, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitchOn.Switch.ImageButton.UIAspectRatioConstraint
    DELTA["ca"] = Instance.new("UIAspectRatioConstraint", DELTA["c8"]);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitchOn.Enabled
    DELTA["cb"] = Instance.new("BoolValue", DELTA["c1"]);
    DELTA["cb"]["Value"] = true;
    DELTA["cb"]["Name"] = [[Enabled]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Button
    DELTA["cc"] = Instance.new("Frame", DELTA["bf"]);
    DELTA["cc"]["BackgroundColor3"] = Color3.fromRGB(38, 41, 50);
    DELTA["cc"]["LayoutOrder"] = 2;
    DELTA["cc"]["Size"] = UDim2.new(1, 0, 0.03193088620901108, 0);
    DELTA["cc"]["Position"] = UDim2.new(0, 0, 0.079827219247818, 0);
    DELTA["cc"]["Visible"] = false;
    DELTA["cc"]["Name"] = [[Button]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Button.UICorner
    DELTA["cd"] = Instance.new("UICorner", DELTA["cc"]);
    DELTA["cd"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Button.Title
    DELTA["ce"] = Instance.new("TextLabel", DELTA["cc"]);
    DELTA["ce"]["TextWrapped"] = true;
    DELTA["ce"]["TextScaled"] = true;
    DELTA["ce"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["ce"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["ce"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["ce"]["TextSize"] = 14;
    DELTA["ce"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["ce"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["ce"]["Size"] = UDim2.new(0.18567337095737457, 0, 0.31746408343315125, 0);
    DELTA["ce"]["Text"] = [[Kill ROBLOX]];
    DELTA["ce"]["Name"] = [[Title]];
    DELTA["ce"]["BackgroundTransparency"] = 1;
    DELTA["ce"]["Position"] = UDim2.new(0, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Button.UIPadding
    DELTA["cf"] = Instance.new("UIPadding", DELTA["cc"]);
    DELTA["cf"]["PaddingRight"] = UDim.new(0.029999999329447746, 0);
    DELTA["cf"]["PaddingLeft"] = UDim.new(0.029999999329447746, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Button.Desc
    DELTA["d0"] = Instance.new("TextLabel", DELTA["cc"]);
    DELTA["d0"]["TextWrapped"] = true;
    DELTA["d0"]["TextScaled"] = true;
    DELTA["d0"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["d0"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["d0"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["d0"]["TextSize"] = 14;
    DELTA["d0"]["TextColor3"] = Color3.fromRGB(103, 109, 126);
    DELTA["d0"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["d0"]["Size"] = UDim2.new(0.6590386629104614, 0, 0.23099972307682037, 0);
    DELTA["d0"]["Text"] = [[self explanitory function right here]];
    DELTA["d0"]["Name"] = [[Desc]];
    DELTA["d0"]["BackgroundTransparency"] = 1;
    DELTA["d0"]["Position"] = UDim2.new(0.18517163395881653, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Button.Button
    DELTA["d1"] = Instance.new("ImageButton", DELTA["cc"]);
    DELTA["d1"]["BackgroundColor3"] = Color3.fromRGB(59, 139, 254);
    DELTA["d1"]["AnchorPoint"] = Vector2.new(1, 0.5);
    --DELTA["d1"]["Image"] = getAsset[[0]];
    DELTA["d1"]["Size"] = UDim2.new(0.12388666719198227, 0, 0.473985493183136, 0);
    DELTA["d1"]["Name"] = [[Button]];
    DELTA["d1"]["Position"] = UDim2.new(0.9995027780532837, 0, 0.5000000596046448, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Button.Button.UICorner
    DELTA["d2"] = Instance.new("UICorner", DELTA["d1"]);
    DELTA["d2"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Button.Button.Title
    DELTA["d3"] = Instance.new("TextLabel", DELTA["d1"]);
    DELTA["d3"]["TextWrapped"] = true;
    DELTA["d3"]["ZIndex"] = 999999999;
    DELTA["d3"]["TextScaled"] = true;
    DELTA["d3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["d3"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["d3"]["TextSize"] = 14;
    DELTA["d3"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["d3"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["d3"]["Size"] = UDim2.new(0.7953082323074341, 0, 0.44124072790145874, 0);
    DELTA["d3"]["Text"] = [[CLICK HERE]];
    DELTA["d3"]["Name"] = [[Title]];
    DELTA["d3"]["BackgroundTransparency"] = 1;
    DELTA["d3"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitch
    DELTA["d4"] = Instance.new("Frame", DELTA["bf"]);
    DELTA["d4"]["BackgroundColor3"] = Color3.fromRGB(38, 41, 50);
    DELTA["d4"]["LayoutOrder"] = 1;
    DELTA["d4"]["Size"] = UDim2.new(1, 0, 0.03193089738488197, 0);
    DELTA["d4"]["Position"] = UDim2.new(0, 0, 0.0399135947227478, 0);
    DELTA["d4"]["Visible"] = false;
    DELTA["d4"]["Name"] = [[SettingSwitch]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitch.UICorner
    DELTA["d5"] = Instance.new("UICorner", DELTA["d4"]);
    DELTA["d5"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitch.Title
    DELTA["d6"] = Instance.new("TextLabel", DELTA["d4"]);
    DELTA["d6"]["TextWrapped"] = true;
    DELTA["d6"]["TextScaled"] = true;
    DELTA["d6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["d6"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["d6"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["d6"]["TextSize"] = 14;
    DELTA["d6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["d6"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["d6"]["Size"] = UDim2.new(0.18567337095737457, 0, 0.31746408343315125, 0);
    DELTA["d6"]["Text"] = [[Auto Execute]];
    DELTA["d6"]["Name"] = [[Title]];
    DELTA["d6"]["BackgroundTransparency"] = 1;
    DELTA["d6"]["Position"] = UDim2.new(0, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitch.UIPadding
    DELTA["d7"] = Instance.new("UIPadding", DELTA["d4"]);
    DELTA["d7"]["PaddingRight"] = UDim.new(0.029999999329447746, 0);
    DELTA["d7"]["PaddingLeft"] = UDim.new(0.029999999329447746, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitch.Desc
    DELTA["d8"] = Instance.new("TextLabel", DELTA["d4"]);
    DELTA["d8"]["TextWrapped"] = true;
    DELTA["d8"]["TextScaled"] = true;
    DELTA["d8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["d8"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["d8"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["d8"]["TextSize"] = 14;
    DELTA["d8"]["TextColor3"] = Color3.fromRGB(103, 109, 126);
    DELTA["d8"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["d8"]["Size"] = UDim2.new(0.6590386629104614, 0, 0.23099972307682037, 0);
    DELTA["d8"]["Text"] = [[automatically execute scripts in your autoexec file upon attached.]];
    DELTA["d8"]["Name"] = [[Desc]];
    DELTA["d8"]["BackgroundTransparency"] = 1;
    DELTA["d8"]["Position"] = UDim2.new(0.18517163395881653, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitch.Switch
    DELTA["d9"] = Instance.new("ImageButton", DELTA["d4"]);
    DELTA["d9"]["BackgroundColor3"] = Color3.fromRGB(61, 66, 81);
    DELTA["d9"]["AnchorPoint"] = Vector2.new(1, 0.5);
    --DELTA["d9"]["Image"] = getAsset[[0]];
    DELTA["d9"]["Size"] = UDim2.new(0.06560052931308746, 0, 0.473985493183136, 0);
    DELTA["d9"]["Name"] = [[Switch]];
    DELTA["d9"]["Position"] = UDim2.new(1, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitch.Switch.UICorner
    DELTA["da"] = Instance.new("UICorner", DELTA["d9"]);
    DELTA["da"]["CornerRadius"] = UDim.new(10, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitch.Switch.ImageButton
    DELTA["db"] = Instance.new("ImageLabel", DELTA["d9"]);
    DELTA["db"]["BackgroundColor3"] = Color3.fromRGB(136, 140, 151);
    DELTA["db"]["Selectable"] = true;
    DELTA["db"]["AnchorPoint"] = Vector2.new(0, 0.5);
    --DELTA["db"]["Image"] = getAsset[[0]];
    DELTA["db"]["Size"] = UDim2.new(0.34452590346336365, 0, 0.6585104465484619, 0);
    DELTA["db"]["Active"] = true;
    DELTA["db"]["Name"] = [[ImageButton]];
    DELTA["db"]["Position"] = UDim2.new(0.11156979203224182, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitch.Switch.ImageButton.UICorner
    DELTA["dc"] = Instance.new("UICorner", DELTA["db"]);
    DELTA["dc"]["CornerRadius"] = UDim.new(10, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitch.Switch.ImageButton.UIAspectRatioConstraint
    DELTA["dd"] = Instance.new("UIAspectRatioConstraint", DELTA["db"]);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingSwitch.Enabled
    DELTA["de"] = Instance.new("BoolValue", DELTA["d4"]);
    DELTA["de"]["Name"] = [[Enabled]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown
    DELTA["df"] = Instance.new("Frame", DELTA["bf"]);
    DELTA["df"]["BackgroundColor3"] = Color3.fromRGB(38, 41, 50);
    DELTA["df"]["LayoutOrder"] = 3;
    DELTA["df"]["Size"] = UDim2.new(1, 0, 0.03193089738488197, 0);
    DELTA["df"]["Position"] = UDim2.new(0, 0, 0.11974083632230759, 0);
    DELTA["df"]["Visible"] = false;
    DELTA["df"]["Name"] = [[SettingDropdown]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.UICorner
    DELTA["e0"] = Instance.new("UICorner", DELTA["df"]);
    DELTA["e0"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Title
    DELTA["e1"] = Instance.new("TextLabel", DELTA["df"]);
    DELTA["e1"]["TextWrapped"] = true;
    DELTA["e1"]["TextScaled"] = true;
    DELTA["e1"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["e1"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["e1"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["e1"]["TextSize"] = 14;
    DELTA["e1"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["e1"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["e1"]["Size"] = UDim2.new(0.18567337095737457, 0, 0.31746408343315125, 0);
    DELTA["e1"]["Text"] = [[Themes]];
    DELTA["e1"]["Name"] = [[Title]];
    DELTA["e1"]["BackgroundTransparency"] = 1;
    DELTA["e1"]["Position"] = UDim2.new(0, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.UIPadding
    DELTA["e2"] = Instance.new("UIPadding", DELTA["df"]);
    DELTA["e2"]["PaddingRight"] = UDim.new(0.029999999329447746, 0);
    DELTA["e2"]["PaddingLeft"] = UDim.new(0.029999999329447746, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Button
    DELTA["e3"] = Instance.new("ImageButton", DELTA["df"]);
    DELTA["e3"]["BackgroundColor3"] = Color3.fromRGB(38, 41, 50);
    DELTA["e3"]["AnchorPoint"] = Vector2.new(1, 0.5);
    --DELTA["e3"]["Image"] = getAsset[[0]];
    DELTA["e3"]["Size"] = UDim2.new(0.12388666719198227, 0, 0.473985493183136, 0);
    DELTA["e3"]["Name"] = [[Button]];
    DELTA["e3"]["Position"] = UDim2.new(0.9995027780532837, 0, 0.5000000596046448, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Button.UICorner
    DELTA["e4"] = Instance.new("UICorner", DELTA["e3"]);
    DELTA["e4"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Button.Title
    DELTA["e5"] = Instance.new("TextLabel", DELTA["e3"]);
    DELTA["e5"]["TextWrapped"] = true;
    DELTA["e5"]["ZIndex"] = 999999999;
    DELTA["e5"]["TextScaled"] = true;
    DELTA["e5"]["BackgroundColor3"] = Color3.fromRGB(38, 41, 50);
    DELTA["e5"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["e5"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["e5"]["TextSize"] = 14;
    DELTA["e5"]["TextColor3"] = Color3.fromRGB(138, 146, 167);
    DELTA["e5"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["e5"]["Size"] = UDim2.new(0.5571646094322205, 0, 0.44124072790145874, 0);
    DELTA["e5"]["Text"] = [[DEFAULT]];
    DELTA["e5"]["Name"] = [[Title]];
    DELTA["e5"]["BackgroundTransparency"] = 1;
    DELTA["e5"]["Position"] = UDim2.new(0.5609880685806274, 0, 0.5000001192092896, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Button.Button
    DELTA["e6"] = Instance.new("ImageButton", DELTA["e3"]);
    DELTA["e6"]["BackgroundColor3"] = Color3.fromRGB(59, 139, 254);
    DELTA["e6"]["AnchorPoint"] = Vector2.new(1, 0.5);
    DELTA["e6"]["Image"] = getAsset[[13441628967]];
    DELTA["e6"]["Size"] = UDim2.new(0.07741968333721161, 0, 0.473985493183136, 0);
    DELTA["e6"]["Name"] = [[Button]];
    DELTA["e6"]["Position"] = UDim2.new(1, 0, 0.5, 0);
    DELTA["e6"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown
    DELTA["e7"] = Instance.new("Frame", DELTA["df"]);
    DELTA["e7"]["BackgroundColor3"] = Color3.fromRGB(41, 44, 52);
    DELTA["e7"]["Size"] = UDim2.new(0.2331225425004959, 0, 1.7701293230056763, 0);
    DELTA["e7"]["Position"] = UDim2.new(0.7665446996688843, 0, 1.0931282043457031, 0);
    DELTA["e7"]["Visible"] = false;
    DELTA["e7"]["ZIndex"] = 9999999999999;
    DELTA["e7"]["Name"] = [[Dropdown]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.UIListLayout
    DELTA["e8"] = Instance.new("UIListLayout", DELTA["e7"]);
    DELTA["e8"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    DELTA["e8"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
    DELTA["e8"]["Padding"] = UDim.new(0.029999999329447746, 0);
    DELTA["e8"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.Option2
    DELTA["e9"] = Instance.new("ImageButton", DELTA["e7"]);
    DELTA["e9"]["BackgroundColor3"] = Color3.fromRGB(59, 139, 254);
    DELTA["e9"]["LayoutOrder"] = 1;
    DELTA["e9"]["AnchorPoint"] = Vector2.new(1, 0.5);
    --DELTA["e9"]["Image"] = getAsset[[0]];
    DELTA["e9"]["Size"] = UDim2.new(0.8604854345321655, 0, 0.22047372162342072, 0);
    DELTA["e9"]["Name"] = [[Option2]];
    DELTA["e9"]["Position"] = UDim2.new(0.9302427172660828, 0, 0.5364913940429688, 0);
    DELTA["e9"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.Option2.UICorner
    DELTA["ea"] = Instance.new("UICorner", DELTA["e9"]);
    DELTA["ea"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.Option2.Title
    DELTA["eb"] = Instance.new("TextLabel", DELTA["e9"]);
    DELTA["eb"]["TextWrapped"] = true;
    DELTA["eb"]["ZIndex"] = 999999999;
    DELTA["eb"]["TextScaled"] = true;
    DELTA["eb"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["eb"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["eb"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    DELTA["eb"]["TextSize"] = 14;
    DELTA["eb"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["eb"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["eb"]["Size"] = UDim2.new(0.7953082323074341, 0, 0.8179191946983337, 0);
    DELTA["eb"]["Text"] = [[Light]];
    DELTA["eb"]["Name"] = [[Title]];
    DELTA["eb"]["BackgroundTransparency"] = 1;
    DELTA["eb"]["Position"] = UDim2.new(0, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.Option2.Checked
    DELTA["ec"] = Instance.new("ImageButton", DELTA["e9"]);
    DELTA["ec"]["BackgroundColor3"] = Color3.fromRGB(59, 139, 254);
    DELTA["ec"]["AnchorPoint"] = Vector2.new(1, 0.5);
    DELTA["ec"]["Image"] = getAsset[[13441695981]];
    DELTA["ec"]["Size"] = UDim2.new(0.0812797099351883, 0, 0.5769613981246948, 0);
    DELTA["ec"]["Name"] = [[Checked]];
    DELTA["ec"]["Visible"] = false;
    DELTA["ec"]["Position"] = UDim2.new(1, 0, 0.5, 0);
    DELTA["ec"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.Option2.Checked.UIAspectRatioConstraint
    DELTA["ed"] = Instance.new("UIAspectRatioConstraint", DELTA["ec"]);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.Divider
    DELTA["ee"] = Instance.new("Frame", DELTA["e7"]);
    DELTA["ee"]["BackgroundColor3"] = Color3.fromRGB(59, 63, 74);
    DELTA["ee"]["LayoutOrder"] = 1;
    DELTA["ee"]["Size"] = UDim2.new(0.8604854345321655, 0, 0.012410691007971764, 0);
    DELTA["ee"]["Position"] = UDim2.new(0.06975728273391724, 0, 0.6603825688362122, 0);
    DELTA["ee"]["Name"] = [[Divider]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.UICorner
    DELTA["ef"] = Instance.new("UICorner", DELTA["e7"]);
    DELTA["ef"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.Option1
    DELTA["f0"] = Instance.new("ImageButton", DELTA["e7"]);
    DELTA["f0"]["BackgroundColor3"] = Color3.fromRGB(59, 139, 254);
    DELTA["f0"]["LayoutOrder"] = -1;
    DELTA["f0"]["AnchorPoint"] = Vector2.new(1, 0.5);
    --DELTA["f0"]["Image"] = getAsset[[0]];
    DELTA["f0"]["Size"] = UDim2.new(0.8604854345321655, 0, 0.22047363221645355, 0);
    DELTA["f0"]["Name"] = [[Option1]];
    DELTA["f0"]["Position"] = UDim2.new(0.9302427172660828, 0, 0.276297390460968, 0);
    DELTA["f0"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.Option1.UICorner
    DELTA["f1"] = Instance.new("UICorner", DELTA["f0"]);
    DELTA["f1"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.Option1.Title
    DELTA["f2"] = Instance.new("TextLabel", DELTA["f0"]);
    DELTA["f2"]["TextWrapped"] = true;
    DELTA["f2"]["ZIndex"] = 999999999;
    DELTA["f2"]["TextScaled"] = true;
    DELTA["f2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["f2"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["f2"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    DELTA["f2"]["TextSize"] = 14;
    DELTA["f2"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["f2"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["f2"]["Size"] = UDim2.new(0.7953082323074341, 0, 0.8179191946983337, 0);
    DELTA["f2"]["Text"] = [[Default]];
    DELTA["f2"]["Name"] = [[Title]];
    DELTA["f2"]["BackgroundTransparency"] = 1;
    DELTA["f2"]["Position"] = UDim2.new(0, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.Option1.Checked
    DELTA["f3"] = Instance.new("ImageButton", DELTA["f0"]);
    DELTA["f3"]["BackgroundColor3"] = Color3.fromRGB(59, 139, 254);
    DELTA["f3"]["AnchorPoint"] = Vector2.new(1, 0.5);
    DELTA["f3"]["Image"] = getAsset[[13441695981]];
    DELTA["f3"]["Size"] = UDim2.new(0.0812797099351883, 0, 0.5769613981246948, 0);
    DELTA["f3"]["Name"] = [[Checked]];
    DELTA["f3"]["Position"] = UDim2.new(1, 0, 0.5, 0);
    DELTA["f3"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.Option1.Checked.UIAspectRatioConstraint
    DELTA["f4"] = Instance.new("UIAspectRatioConstraint", DELTA["f3"]);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.Divider
    DELTA["f5"] = Instance.new("Frame", DELTA["e7"]);
    DELTA["f5"]["BackgroundColor3"] = Color3.fromRGB(59, 63, 74);
    DELTA["f5"]["Size"] = UDim2.new(0.8604854345321655, 0, 0.012410691007971764, 0);
    DELTA["f5"]["Position"] = UDim2.new(0.06975728273391724, 0, 0.4001886248588562, 0);
    DELTA["f5"]["Name"] = [[Divider]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.Option3
    DELTA["f6"] = Instance.new("ImageButton", DELTA["e7"]);
    DELTA["f6"]["BackgroundColor3"] = Color3.fromRGB(59, 139, 254);
    DELTA["f6"]["LayoutOrder"] = 3;
    DELTA["f6"]["AnchorPoint"] = Vector2.new(1, 0.5);
    --DELTA["f6"]["Image"] = getAsset[[0]];
    DELTA["f6"]["Size"] = UDim2.new(0.8604854345321655, 0, 0.2204737514257431, 0);
    DELTA["f6"]["Name"] = [[Option3]];
    DELTA["f6"]["Position"] = UDim2.new(0.9302427172660828, 0, 0.7966850399971008, 0);
    DELTA["f6"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.Option3.UICorner
    DELTA["f7"] = Instance.new("UICorner", DELTA["f6"]);
    DELTA["f7"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.Option3.Title
    DELTA["f8"] = Instance.new("TextLabel", DELTA["f6"]);
    DELTA["f8"]["TextWrapped"] = true;
    DELTA["f8"]["ZIndex"] = 999999999;
    DELTA["f8"]["TextScaled"] = true;
    DELTA["f8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["f8"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["f8"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    DELTA["f8"]["TextSize"] = 14;
    DELTA["f8"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["f8"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["f8"]["Size"] = UDim2.new(0.7953082323074341, 0, 0.8179191946983337, 0);
    DELTA["f8"]["Text"] = [[Amoled]];
    DELTA["f8"]["Name"] = [[Title]];
    DELTA["f8"]["BackgroundTransparency"] = 1;
    DELTA["f8"]["Position"] = UDim2.new(0, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.Option3.Checked
    DELTA["f9"] = Instance.new("ImageButton", DELTA["f6"]);
    DELTA["f9"]["BackgroundColor3"] = Color3.fromRGB(59, 139, 254);
    DELTA["f9"]["AnchorPoint"] = Vector2.new(1, 0.5);
    DELTA["f9"]["Image"] = getAsset[[13441695981]];
    DELTA["f9"]["Size"] = UDim2.new(0.0812797099351883, 0, 0.5769613981246948, 0);
    DELTA["f9"]["Name"] = [[Checked]];
    DELTA["f9"]["Visible"] = false;
    DELTA["f9"]["Position"] = UDim2.new(1, 0, 0.5, 0);
    DELTA["f9"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Dropdown.Option3.Checked.UIAspectRatioConstraint
    DELTA["fa"] = Instance.new("UIAspectRatioConstraint", DELTA["f9"]);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingDropdown.Desc
    DELTA["fb"] = Instance.new("TextLabel", DELTA["df"]);
    DELTA["fb"]["TextWrapped"] = true;
    DELTA["fb"]["TextScaled"] = true;
    DELTA["fb"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["fb"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["fb"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["fb"]["TextSize"] = 14;
    DELTA["fb"]["TextColor3"] = Color3.fromRGB(103, 109, 126);
    DELTA["fb"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["fb"]["Size"] = UDim2.new(0.6590386629104614, 0, 0.23099972307682037, 0);
    DELTA["fb"]["Text"] = [[Select your desired Zemvar theme below]];
    DELTA["fb"]["Name"] = [[Desc]];
    DELTA["fb"]["BackgroundTransparency"] = 1;
    DELTA["fb"]["Position"] = UDim2.new(0.18517163395881653, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingTextbox
    DELTA["fc"] = Instance.new("Frame", DELTA["bf"]);
    DELTA["fc"]["BackgroundColor3"] = Color3.fromRGB(38, 41, 50);
    DELTA["fc"]["LayoutOrder"] = 2;
    DELTA["fc"]["Size"] = UDim2.new(1, 0, 0.03193088620901108, 0);
    DELTA["fc"]["Position"] = UDim2.new(0, 0, 0.079827219247818, 0);
    DELTA["fc"]["Visible"] = false;
    DELTA["fc"]["Name"] = [[SettingTextbox]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingTextbox.UICorner
    DELTA["fd"] = Instance.new("UICorner", DELTA["fc"]);
    DELTA["fd"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingTextbox.Title
    DELTA["fe"] = Instance.new("TextLabel", DELTA["fc"]);
    DELTA["fe"]["TextWrapped"] = true;
    DELTA["fe"]["TextScaled"] = true;
    DELTA["fe"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["fe"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["fe"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["fe"]["TextSize"] = 14;
    DELTA["fe"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["fe"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["fe"]["Size"] = UDim2.new(0.18567337095737457, 0, 0.31746408343315125, 0);
    DELTA["fe"]["Text"] = [[Kill ROBLOX]];
    DELTA["fe"]["Name"] = [[Title]];
    DELTA["fe"]["BackgroundTransparency"] = 1;
    DELTA["fe"]["Position"] = UDim2.new(0, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingTextbox.UIPadding
    DELTA["ff"] = Instance.new("UIPadding", DELTA["fc"]);
    DELTA["ff"]["PaddingRight"] = UDim.new(0.029999999329447746, 0);
    DELTA["ff"]["PaddingLeft"] = UDim.new(0.029999999329447746, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingTextbox.Desc
    DELTA["100"] = Instance.new("TextLabel", DELTA["fc"]);
    DELTA["100"]["TextWrapped"] = true;
    DELTA["100"]["TextScaled"] = true;
    DELTA["100"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["100"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["100"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["100"]["TextSize"] = 14;
    DELTA["100"]["TextColor3"] = Color3.fromRGB(103, 109, 126);
    DELTA["100"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["100"]["Size"] = UDim2.new(0.6590386629104614, 0, 0.23099972307682037, 0);
    DELTA["100"]["Text"] = [[self explanitory function right here]];
    DELTA["100"]["Name"] = [[Desc]];
    DELTA["100"]["BackgroundTransparency"] = 1;
    DELTA["100"]["Position"] = UDim2.new(0.18517163395881653, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingTextbox.InputText
    DELTA["101"] = Instance.new("TextBox", DELTA["fc"]);
    DELTA["101"]["Active"] = true;
    DELTA["101"]["BorderSizePixel"] = 0;
    DELTA["101"]["TextSize"] = 17;
    DELTA["101"]["TextWrapped"] = true;
    DELTA["101"]["TextScaled"] = true;
    DELTA["101"]["BackgroundColor3"] = Color3.fromRGB(31, 37, 47);
    DELTA["101"]["TextColor3"] = Color3.fromRGB(162, 191, 212);
    DELTA["101"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["101"]["AnchorPoint"] = Vector2.new(0, 1);
    DELTA["101"]["PlaceholderText"] = [[Input]];
    DELTA["101"]["Size"] = UDim2.new(0.19835805892944336, 0, 0.4205845594406128, 0);
    DELTA["101"]["Selectable"] = false;
    DELTA["101"]["Text"] = [[]];
    DELTA["101"]["Position"] = UDim2.new(0.7891961932182312, 0, 0.7077450752258301, 0);
    DELTA["101"]["Name"] = [[InputText]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingTextbox.InputText.UICorner
    DELTA["102"] = Instance.new("UICorner", DELTA["101"]);
    DELTA["102"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.SettingTextbox.InputText.UIStroke
    DELTA["103"] = Instance.new("UIStroke", DELTA["101"]);
    DELTA["103"]["Color"] = Color3.fromRGB(59, 71, 90);
    DELTA["103"]["Thickness"] = 2;
    DELTA["103"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.TabX
    DELTA["104"] = Instance.new("ImageButton", DELTA["bf"]);
    DELTA["104"]["Active"] = false;
    DELTA["104"]["ZIndex"] = 300;
    DELTA["104"]["BackgroundColor3"] = Color3.fromRGB(34, 41, 50);
    DELTA["104"]["Selectable"] = false;
    DELTA["104"]["LayoutOrder"] = 1;
    DELTA["104"]["Size"] = UDim2.new(0.23816877603530884, 0, 0.8693817853927612, 0);
    DELTA["104"]["Name"] = [[TabX]];
    DELTA["104"]["Visible"] = false;
    DELTA["104"]["Position"] = UDim2.new(0.016260094940662384, 0, 0.20600000023841858, 0);
    DELTA["104"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.TabX.UICorner
    DELTA["105"] = Instance.new("UICorner", DELTA["104"]);
    DELTA["105"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.TabX.Title
    DELTA["106"] = Instance.new("TextLabel", DELTA["104"]);
    DELTA["106"]["TextWrapped"] = true;
    DELTA["106"]["TextScaled"] = true;
    DELTA["106"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["106"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["106"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
    DELTA["106"]["TextTransparency"] = 0.30000001192092896;
    DELTA["106"]["TextSize"] = 14;
    DELTA["106"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["106"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["106"]["Size"] = UDim2.new(0.6458646059036255, 0, 0.4000000059604645, 0);
    DELTA["106"]["Text"] = [[script.lua]];
    DELTA["106"]["Name"] = [[Title]];
    DELTA["106"]["BackgroundTransparency"] = 1;
    DELTA["106"]["Position"] = UDim2.new(0.11627907305955887, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.TabX.ImageButton
    DELTA["107"] = Instance.new("ImageButton", DELTA["104"]);
    DELTA["107"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["107"]["AnchorPoint"] = Vector2.new(1, 0.5);
    DELTA["107"]["Image"] = getAsset[[13387627918]];
    DELTA["107"]["Size"] = UDim2.new(0.06472493708133698, 0, 0.19327585399150848, 0);
    DELTA["107"]["Position"] = UDim2.new(0.9190940260887146, 0, 0.49999985098838806, 0);
    DELTA["107"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.TabX.ImageButton.UIAspectRatioConstraint
    DELTA["108"] = Instance.new("UIAspectRatioConstraint", DELTA["107"]);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Script
    DELTA["109"] = Instance.new("ImageLabel", DELTA["bf"]);
    DELTA["109"]["BackgroundColor3"] = Color3.fromRGB(38, 41, 50);
    DELTA["109"]["LayoutOrder"] = 1;
    DELTA["109"]["Size"] = UDim2.new(0.997948408126831, 0, 0.0462365560233593, 0);
    DELTA["109"]["Position"] = UDim2.new(0, 0, 1.0919346493665216e-07, 0);
    DELTA["109"]["Name"] = [[Script]];
    DELTA["109"].Active = true;
    DELTA["109"].Visible = false

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Script.UICorner
    DELTA["10a"] = Instance.new("UICorner", DELTA["109"]);
    DELTA["10a"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Script.Title
    DELTA["10b"] = Instance.new("TextLabel", DELTA["109"]);
    DELTA["10b"]["TextWrapped"] = true;
    DELTA["10b"]["TextScaled"] = true;
    DELTA["10b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["10b"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["10b"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["10b"]["TextSize"] = 14;
    DELTA["10b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["10b"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["10b"]["Size"] = UDim2.new(0.15939868986606598, 0, 0.31746405363082886, 0);
    DELTA["10b"]["Text"] = [[Enter Your Script...]];
    DELTA["10b"]["Name"] = [[Title]];
    DELTA["10b"]["BackgroundTransparency"] = 1;
    DELTA["10b"]["Position"] = UDim2.new(-0.01293666660785675, 0, 0.5000000596046448, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Script.UIPadding
    DELTA["10c"] = Instance.new("UIPadding", DELTA["109"]);
    DELTA["10c"]["PaddingRight"] = UDim.new(0.029999999329447746, 0);
    DELTA["10c"]["PaddingLeft"] = UDim.new(0.029999999329447746, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Script.Button
    DELTA["10d"] = Instance.new("ImageButton", DELTA["109"]);
    DELTA["10d"]["BackgroundColor3"] = Color3.fromRGB(59, 64, 79);
    DELTA["10d"]["AnchorPoint"] = Vector2.new(1, 0.5);
    --DELTA["10d"]["Image"] = getAsset[[0]];
    DELTA["10d"]["Size"] = UDim2.new(0.09953451156616211, 0, 0.473985493183136, 0);
    DELTA["10d"]["Name"] = [[Button]];
    DELTA["10d"]["Position"] = UDim2.new(1.0157949924468994, 0, 0.5000000596046448, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Script.Button.UICorner
    DELTA["10e"] = Instance.new("UICorner", DELTA["10d"]);
    DELTA["10e"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Script.Button.Title
    DELTA["10f"] = Instance.new("TextLabel", DELTA["10d"]);
    DELTA["10f"]["TextWrapped"] = true;
    DELTA["10f"]["ZIndex"] = 999999999;
    DELTA["10f"]["TextScaled"] = true;
    DELTA["10f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["10f"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["10f"]["TextSize"] = 14;
    DELTA["10f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["10f"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["10f"]["Size"] = UDim2.new(0.7953082323074341, 0, 0.44124072790145874, 0);
    DELTA["10f"]["Text"] = [[EXECUTE]];
    DELTA["10f"]["Name"] = [[Title]];
    DELTA["10f"]["BackgroundTransparency"] = 1;
    DELTA["10f"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Script.Button1
    DELTA["10da"] = Instance.new("ImageButton", DELTA["109"]);
    DELTA["10da"]["BackgroundColor3"] = Color3.fromRGB(59, 64, 79);
    DELTA["10da"]["AnchorPoint"] = Vector2.new(1, 0.5);
    --DELTA["10da"]["Image"] = getAsset[[0]];
    DELTA["10da"]["Size"] = UDim2.new(0.09953451156616211, 0, 0.473985493183136, 0);
    DELTA["10da"]["Name"] = [[Button1]];
    DELTA["10da"]["Position"] = UDim2.new(0.9, 0, 0.5000000596046448, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Script.Button1.UICorner
    DELTA["10ea"] = Instance.new("UICorner", DELTA["10da"]);
    DELTA["10ea"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Script.Button1.Title
    DELTA["10fa"] = Instance.new("TextLabel", DELTA["10da"]);
    DELTA["10fa"]["TextWrapped"] = true;
    DELTA["10fa"]["ZIndex"] = 999999999;
    DELTA["10fa"]["TextScaled"] = true;
    DELTA["10fa"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["10fa"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["10fa"]["TextSize"] = 14;
    DELTA["10fa"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["10fa"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["10fa"]["Size"] = UDim2.new(0.7953082323074341, 0, 0.44124072790145874, 0);
    DELTA["10fa"]["Text"] = [[DELETE]];
    DELTA["10fa"]["Name"] = [[Title]];
    DELTA["10fa"]["BackgroundTransparency"] = 1;
    DELTA["10fa"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Script.Frame
    DELTA["110"] = Instance.new("Frame", DELTA["109"]);
    DELTA["110"]["BackgroundColor3"] = Color3.fromRGB(86, 173, 239);
    DELTA["110"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["110"]["Size"] = UDim2.new(0.08429200947284698, 0, 0.3846021890640259, 0);
    DELTA["110"]["Position"] = UDim2.new(0.14588697254657745, 0, 0.49755123257637024, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Script.Frame.UICorner
    DELTA["111"] = Instance.new("UICorner", DELTA["110"]);
    DELTA["111"]["CornerRadius"] = UDim.new(1, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Reserved.Script.Frame.Title
    DELTA["112"] = Instance.new("TextLabel", DELTA["110"]);
    DELTA["112"]["TextWrapped"] = true;
    DELTA["112"]["TextScaled"] = true;
    DELTA["112"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["112"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["112"]["TextSize"] = 14;
    DELTA["112"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["112"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["112"]["Size"] = UDim2.new(0.8315319418907166, 0, 0.5, 0);
    DELTA["112"]["Text"] = [[UTILITY]];
    DELTA["112"]["Name"] = [[Title]];
    DELTA["112"]["BackgroundTransparency"] = 1;
    DELTA["112"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Executor.Overlay.Code
    DELTA["113"] = Instance.new("ScrollingFrame", DELTA["88"]);
    DELTA["113"]["ZIndex"] = 200;
    DELTA["113"]["BorderSizePixel"] = 0;
    DELTA["113"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
    DELTA["113"]["TopImage"] = [[rbxasset://textures/ui/Scroll/scroll-middle.png]];
    DELTA["113"]["BackgroundColor3"] = Color3.fromRGB(22, 22, 30);
    DELTA["113"]["HorizontalScrollBarInset"] = Enum.ScrollBarInset.Always;
    DELTA["113"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["113"]["AutomaticCanvasSize"] = Enum.AutomaticSize.XY;
    DELTA["113"]["BackgroundTransparency"] = 1;
    DELTA["113"]["Size"] = UDim2.new(0.9764046669006348, 0, 0.6893500685691833, 0);
    DELTA["113"]["Selectable"] = false;
    DELTA["113"].ElasticBehavior = Enum.ElasticBehavior.Never
    DELTA["113"]["ScrollBarThickness"] = 15;
    DELTA["113"]["Position"] = UDim2.new(0.5117977261543274, 0, 0.8393499851226807, 0);
    DELTA["113"]["Name"] = [[Code]];
    DELTA["113"]["BottomImage"] = [[rbxasset://textures/ui/Scroll/scroll-middle.png]];

    -- StarterGui.Delta.Executor.Executor.Overlay.Frame
    DELTA["114"] = Instance.new("Frame", DELTA["88"]);
    DELTA["114"]["ZIndex"] = 201;
    DELTA["114"]["BorderSizePixel"] = 0;
    DELTA["114"]["BackgroundColor3"] = Color3.fromRGB(34, 41, 50);
    DELTA["114"]["Size"] = UDim2.new(1.0011208057403564, 0, 0.006693750154227018, 0);
    DELTA["114"]["Position"] = UDim2.new(5.143397530105176e-08, 0, 0.14056874811649323, 0);

    -- StarterGui.Delta.Executor.Executor.UICorner
    DELTA["115"] = Instance.new("UICorner", DELTA["87"]);
    DELTA["115"]["CornerRadius"] = UDim.new(0.05000000074505806, 0);

    -- StarterGui.Delta.Executor.Sidemenu
    DELTA["116"] = Instance.new("ImageLabel", DELTA["86"]);
    DELTA["116"]["BorderSizePixel"] = 0;
    DELTA["116"]["ScaleType"] = Enum.ScaleType.Crop;
    DELTA["116"]["BackgroundColor3"] = Color3.fromRGB(36, 0, 0);
    DELTA["116"]["AnchorPoint"] = Vector2.new(0, 0.5);
    --DELTA["116"]["Image"] = getAsset[[0]];
    DELTA["116"]["Size"] = UDim2.new(0.3273969292640686, 0, 0.9993020296096802, 0);
    DELTA["116"]["ClipsDescendants"] = true;
    DELTA["116"]["Name"] = [[Sidemenu]];
    DELTA["116"]["BackgroundTransparency"] = 1;
    DELTA["116"]["Position"] = UDim2.new(-0.004258748609572649, 0, 0.5005565881729126, 0);

    -- StarterGui.Delta.Executor.Sidemenu.Script
    DELTA["117"] = Instance.new("ImageLabel", DELTA["116"]);
    DELTA["117"]["BackgroundColor3"] = Color3.fromRGB(26, 27, 36);
    --DELTA["117"]["Image"] = getAsset[[0]];
    DELTA["117"]["Size"] = UDim2.new(1.0000001192092896, 0, 0.4340279698371887, 0);
    DELTA["117"]["ClipsDescendants"] = true;
    DELTA["117"]["Name"] = [[Script]];
    DELTA["117"]["Position"] = UDim2.new(-1.131473865711996e-07, 0, 0.09011479467153549, 0);

    -- StarterGui.Delta.Executor.Sidemenu.Script.UICorner
    DELTA["118"] = Instance.new("UICorner", DELTA["117"]);
    DELTA["118"]["CornerRadius"] = UDim.new(0.05000000074505806, 0);

    -- StarterGui.Delta.Executor.Sidemenu.Script.Overlay
    DELTA["119"] = Instance.new("Frame", DELTA["117"]);
    DELTA["119"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["119"]["BackgroundTransparency"] = 1;
    DELTA["119"]["Size"] = UDim2.new(1, 0, 1, 0);
    DELTA["119"]["Name"] = [[Overlay]];

    -- StarterGui.Delta.Executor.Sidemenu.Script.Overlay.Holder
    DELTA["11a"] = Instance.new("Frame", DELTA["119"]);
    DELTA["11a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["11a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["11a"]["BackgroundTransparency"] = 1;
    DELTA["11a"]["Size"] = UDim2.new(0.8012143969535828, 0, 0.7959624528884888, 0);
    DELTA["11a"]["Position"] = UDim2.new(0.5, 0, 0.49274569749832153, 0);
    DELTA["11a"]["Name"] = [[Holder]];

    -- StarterGui.Delta.Executor.Sidemenu.Script.Overlay.Holder.Title
    DELTA["11b"] = Instance.new("Frame", DELTA["11a"]);
    DELTA["11b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["11b"]["BackgroundTransparency"] = 1;
    DELTA["11b"]["Size"] = UDim2.new(1.0907094478607178, 0, 0.3451063930988312, 0);
    DELTA["11b"]["Position"] = UDim2.new(-0.045354731380939484, 0, 0.041554853320121765, 0);
    DELTA["11b"]["Name"] = [[Title]];

    -- StarterGui.Delta.Executor.Sidemenu.Script.Overlay.Holder.Title.Title
    DELTA["11c"] = Instance.new("TextLabel", DELTA["11b"]);
    DELTA["11c"]["TextWrapped"] = true;
    DELTA["11c"]["TextScaled"] = true;
    DELTA["11c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["11c"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["11c"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["11c"]["TextSize"] = 14;
    DELTA["11c"]["TextColor3"] = Color3.fromRGB(190, 206, 232);
    DELTA["11c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["11c"]["Size"] = UDim2.new(0.9879999756813049, 0, 0.4830000102519989, 0);
    DELTA["11c"]["Text"] = [[Check out this script!]];
    DELTA["11c"]["Name"] = [[Title]];
    DELTA["11c"]["BackgroundTransparency"] = 1;
    DELTA["11c"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Executor.Sidemenu.Script.Overlay.Holder.Showcase
    DELTA["11d"] = Instance.new("TextButton", DELTA["11a"]);
    DELTA["11d"]["BackgroundColor3"] = Color3.fromRGB(32, 35, 46);
    DELTA["11d"]["Selectable"] = false;
    DELTA["11d"]["Size"] = UDim2.new(1.0907094478607178, 0, 0.48145753145217896, 0);
    DELTA["11d"]["Name"] = [[Showcase]];
    DELTA["11d"]["Text"] = [[]];
    DELTA["11d"]["Position"] = UDim2.new(-0.0453546978533268, 0, 0.41410815715789795, 0);
    DELTA["11d"]["BackgroundTransparency"] = 0.4000000059604645;

    -- StarterGui.Delta.Executor.Sidemenu.Script.Overlay.Holder.Showcase.UICorner
    DELTA["11e"] = Instance.new("UICorner", DELTA["11d"]);
    DELTA["11e"]["CornerRadius"] = UDim.new(0.05000000074505806, 0);

    -- StarterGui.Delta.Executor.Sidemenu.Script.Overlay.Holder.Showcase.UIListLayout
    DELTA["11f"] = Instance.new("UIListLayout", DELTA["11d"]);
    DELTA["11f"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    DELTA["11f"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
    DELTA["11f"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.Executor.Sidemenu.Script.Overlay.Holder.Showcase.Title
    DELTA["120"] = Instance.new("TextLabel", DELTA["11d"]);
    DELTA["120"]["TextWrapped"] = true;
    DELTA["120"]["TextScaled"] = true;
    DELTA["120"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["120"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["120"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
    DELTA["120"]["TextSize"] = 14;
    DELTA["120"]["TextColor3"] = Color3.fromRGB(190, 206, 232);
    DELTA["120"]["AnchorPoint"] = Vector2.new(0.5, 0);
    DELTA["120"]["Size"] = UDim2.new(0.9109266400337219, 0, 0.2100510597229004, 0);
    DELTA["120"]["Active"] = true;
    DELTA["120"]["Text"] = [[INFINITE YIELD]];
    DELTA["120"]["Name"] = [[Title]];
    DELTA["120"]["Active"] = false;
    DELTA["120"]["BackgroundTransparency"] = 1;
    DELTA["120"]["Position"] = UDim2.new(0.5, 0, 0.24653124809265137, 0);

    -- StarterGui.Delta.Executor.Sidemenu.Script.Overlay.Holder.Showcase.Description
    DELTA["121"] = Instance.new("TextLabel", DELTA["11d"]);
    DELTA["121"]["TextWrapped"] = true;
    DELTA["121"]["TextScaled"] = true;
    DELTA["121"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["121"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["121"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    DELTA["121"]["TextSize"] = 14;
    DELTA["121"]["TextColor3"] = Color3.fromRGB(157, 162, 199);
    DELTA["121"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["121"]["Size"] = UDim2.new(0.9109266400337219, 0, 0.46432507038116455, 0);
    DELTA["121"]["Active"] = true;
    DELTA["121"]["Text"] = [[an admin script dedicated to provide the necessities of exploiting.]];
    DELTA["121"]["Active"] = false;
    DELTA["121"]["Name"] = [[Description]];
    DELTA["121"]["BackgroundTransparency"] = 1;
    DELTA["121"]["Position"] = UDim2.new(0.5, 0, 0.9209074378013611, 0);

    -- StarterGui.Delta.Executor.Sidemenu.Script.ScriptSuggestionHandler
    DELTA["122"] = Instance.new("LocalScript", DELTA["117"]);
    DELTA["122"]["Name"] = [[ScriptSuggestionHandler]];

    -- StarterGui.Delta.Executor.Sidemenu.Network
    DELTA["123"] = Instance.new("ImageLabel", DELTA["116"]);
    DELTA["123"]["ZIndex"] = 99999;
    DELTA["123"]["BackgroundColor3"] = Color3.fromRGB(26, 27, 36);
    --DELTA["123"]["Image"] = getAsset[[0]];
    DELTA["123"]["Size"] = UDim2.new(1.0000001192092896, 0, 0.3936704099178314, 0);
    DELTA["123"]["ClipsDescendants"] = true;
    DELTA["123"]["Name"] = [[Network]];
    DELTA["123"]["Position"] = UDim2.new(-1.3669654208570137e-07, 0, 0.6052098870277405, 0);

    -- StarterGui.Delta.Executor.Sidemenu.Network.UICorner
    DELTA["124"] = Instance.new("UICorner", DELTA["123"]);
    DELTA["124"]["CornerRadius"] = UDim.new(0.05000000074505806, 0);

    -- StarterGui.Delta.Executor.Sidemenu.Network.Overlay
    DELTA["125"] = Instance.new("Frame", DELTA["123"]);
    DELTA["125"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["125"]["BackgroundTransparency"] = 1;
    DELTA["125"]["Size"] = UDim2.new(1, 0, 1, 0);
    DELTA["125"]["Name"] = [[Overlay]];

    -- StarterGui.Delta.Executor.Sidemenu.Network.Overlay.Holder
    DELTA["126"] = Instance.new("Frame", DELTA["125"]);
    DELTA["126"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["126"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["126"]["BackgroundTransparency"] = 1;
    DELTA["126"]["Size"] = UDim2.new(0.8999999761581421, 0, 0.8310460448265076, 0);
    DELTA["126"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    DELTA["126"]["Name"] = [[Holder]];

    -- StarterGui.Delta.Executor.Sidemenu.Network.Overlay.Holder.UIListLayout
    DELTA["127"] = Instance.new("UIListLayout", DELTA["126"]);
    DELTA["127"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    DELTA["127"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
    DELTA["127"]["Padding"] = UDim.new(0.15000000596046448, 0);
    DELTA["127"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.Executor.Sidemenu.Network.Overlay.Holder.Frame
    DELTA["128"] = Instance.new("Frame", DELTA["126"]);
    DELTA["128"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["128"]["BackgroundTransparency"] = 1;
    DELTA["128"]["Size"] = UDim2.new(1, 0, 0.40413346886634827, 0);
    DELTA["128"]["Position"] = UDim2.new(0, 0, 0.027302570641040802, 0);

    -- StarterGui.Delta.Executor.Sidemenu.Network.Overlay.Holder.Frame.Description
    DELTA["129"] = Instance.new("TextLabel", DELTA["128"]);
    DELTA["129"]["TextWrapped"] = true;
    DELTA["129"]["TextScaled"] = true;
    DELTA["129"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["129"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["129"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    DELTA["129"]["TextSize"] = 14;
    DELTA["129"]["TextColor3"] = Color3.fromRGB(157, 162, 199);
    DELTA["129"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["129"]["Size"] = UDim2.new(0.9877889156341553, 0, 0.33333709836006165, 0);
    DELTA["129"]["Text"] = [[Client status information]];
    DELTA["129"]["Name"] = [[Description]];
    DELTA["129"]["BackgroundTransparency"] = 1;
    DELTA["129"]["Position"] = UDim2.new(0.5, 0, 0.9999999403953552, 0);

    -- StarterGui.Delta.Executor.Sidemenu.Network.Overlay.Holder.Frame.Title
    DELTA["12a"] = Instance.new("TextLabel", DELTA["128"]);
    DELTA["12a"]["TextWrapped"] = true;
    DELTA["12a"]["TextScaled"] = true;
    DELTA["12a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["12a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["12a"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["12a"]["TextSize"] = 14;
    DELTA["12a"]["TextColor3"] = Color3.fromRGB(190, 206, 232);
    DELTA["12a"]["AnchorPoint"] = Vector2.new(0.5, 0);
    DELTA["12a"]["Size"] = UDim2.new(0.9877890348434448, 0, 0.482876718044281, 0);
    DELTA["12a"]["Text"] = [[Network]];
    DELTA["12a"]["Name"] = [[Title]];
    DELTA["12a"]["BackgroundTransparency"] = 1;
    DELTA["12a"]["Position"] = UDim2.new(0.5, 0, 0, 0);

    -- StarterGui.Delta.Executor.Sidemenu.Network.Overlay.Holder.Information
    DELTA["12b"] = Instance.new("Frame", DELTA["126"]);
    DELTA["12b"]["BackgroundColor3"] = Color3.fromRGB(32, 35, 46);
    DELTA["12b"]["BackgroundTransparency"] = 0.4000000059604645;
    DELTA["12b"]["Size"] = UDim2.new(1, 0, 0.3164331018924713, 0);
    DELTA["12b"]["Position"] = UDim2.new(0, 0, 0.6628726124763489, 0);
    DELTA["12b"]["Name"] = [[Information]];

    -- StarterGui.Delta.Executor.Sidemenu.Network.Overlay.Holder.Information.UICorner
    DELTA["12c"] = Instance.new("UICorner", DELTA["12b"]);
    DELTA["12c"]["CornerRadius"] = UDim.new(1, 0);

    -- StarterGui.Delta.Executor.Sidemenu.Network.Overlay.Holder.Information.UIListLayout
    DELTA["12d"] = Instance.new("UIListLayout", DELTA["12b"]);
    DELTA["12d"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    DELTA["12d"]["FillDirection"] = Enum.FillDirection.Horizontal;
    DELTA["12d"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
    DELTA["12d"]["Padding"] = UDim.new(0.029999999329447746, 0);
    DELTA["12d"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.Executor.Sidemenu.Network.Overlay.Holder.Information.Memory
    DELTA["12e"] = Instance.new("TextLabel", DELTA["12b"]);
    DELTA["12e"]["TextWrapped"] = true;
    DELTA["12e"]["RichText"] = true;
    DELTA["12e"]["TextScaled"] = true;
    DELTA["12e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["12e"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
    DELTA["12e"]["TextSize"] = 14;
    DELTA["12e"]["TextColor3"] = Color3.fromRGB(157, 162, 199);
    DELTA["12e"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["12e"]["Size"] = UDim2.new(0.28310254216194153, 0, 0.2934793531894684, 0);
    DELTA["12e"]["Text"] = [[<font color="#4FA4F2">68</font> MB]];
    DELTA["12e"]["Name"] = [[Memory]];
    DELTA["12e"]["BackgroundTransparency"] = 1;
    DELTA["12e"]["Position"] = UDim2.new(0.05447632819414139, 0, 0.6467397809028625, 0);

    -- StarterGui.Delta.Executor.Sidemenu.Network.Overlay.Holder.Information.Ping
    DELTA["12f"] = Instance.new("TextLabel", DELTA["12b"]);
    DELTA["12f"]["TextWrapped"] = true;
    DELTA["12f"]["RichText"] = true;
    DELTA["12f"]["TextScaled"] = true;
    DELTA["12f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["12f"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
    DELTA["12f"]["TextSize"] = 14;
    DELTA["12f"]["TextColor3"] = Color3.fromRGB(157, 162, 199);
    DELTA["12f"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["12f"]["LayoutOrder"] = 2;
    DELTA["12f"]["Size"] = UDim2.new(0.3066037893295288, 0, 0.2934792935848236, 0);
    DELTA["12f"]["Text"] = [[<font color="#4FA4F2">68</font> MS Ping]];
    DELTA["12f"]["Name"] = [[Ping]];
    DELTA["12f"]["BackgroundTransparency"] = 1;
    DELTA["12f"]["Position"] = UDim2.new(0.2835494577884674, 0, 0.646739661693573, 0);

    -- StarterGui.Delta.Executor.Sidemenu.Network.Overlay.Holder.Information.Players
    DELTA["130"] = Instance.new("TextLabel", DELTA["12b"]);
    DELTA["130"]["TextWrapped"] = true;
    DELTA["130"]["RichText"] = true;
    DELTA["130"]["TextScaled"] = true;
    DELTA["130"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["130"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
    DELTA["130"]["TextSize"] = 14;
    DELTA["130"]["TextColor3"] = Color3.fromRGB(157, 162, 199);
    DELTA["130"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["130"]["LayoutOrder"] = 3;
    DELTA["130"]["Size"] = UDim2.new(0.3066039979457855, 0, 0.2934792935848236, 0);
    DELTA["130"]["Text"] = [[<font color="#4FA4F2">11</font> players]];
    DELTA["130"]["Name"] = [[Players]];
    DELTA["130"]["BackgroundTransparency"] = 1;
    DELTA["130"]["Position"] = UDim2.new(0.6138899326324463, 0, 0.646739661693573, 0);

    -- StarterGui.Delta.Executor.Sidemenu.Network.NetworkStatsHandler
    DELTA["131"] = Instance.new("LocalScript", DELTA["123"]);
    DELTA["131"]["Name"] = [[NetworkStatsHandler]];

    -- StarterGui.Delta.Executor.Sidemenu.UIListLayout
    DELTA["132"] = Instance.new("UIListLayout", DELTA["116"]);
    DELTA["132"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    DELTA["132"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Right;
    DELTA["132"]["Padding"] = UDim.new(0.05000000074505806, 0);
    DELTA["132"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.Executor.Marker
    DELTA["133"] = Instance.new("StringValue", DELTA["86"]);
    DELTA["133"]["Value"] = [[Menu]];
    DELTA["133"]["Name"] = [[Marker]];

    -- StarterGui.Delta.Home
    DELTA["134"] = Instance.new("Frame", DELTA["1"]);
    DELTA["134"]["ZIndex"] = 100;
    DELTA["134"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 0);
    DELTA["134"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["134"]["BackgroundTransparency"] = 1;
    DELTA["134"]["Size"] = UDim2.new(0.8483448028564453, 0, 0.8924814462661743, 0);
    DELTA["134"]["Position"] = UDim2.new(0.47624671459198, 0, 0.5082324147224426, 0);
    DELTA["134"]["Visible"] = false;
    DELTA["134"]["Name"] = [[Home]];

    -- StarterGui.Delta.Home.Searchbar
    DELTA["135"] = Instance.new("Frame", DELTA["134"]);
    DELTA["135"]["ZIndex"] = 2;
    DELTA["135"]["BackgroundColor3"] = Color3.fromRGB(38, 41, 50);
    DELTA["135"]["Size"] = UDim2.new(1, 0, 0.12585513293743134, 0);
    DELTA["135"]["Name"] = [[Searchbar]];

    -- StarterGui.Delta.Home.Searchbar.UICorner
    DELTA["136"] = Instance.new("UICorner", DELTA["135"]);
    DELTA["136"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.Home.Searchbar.ImageLabel
    DELTA["137"] = Instance.new("ImageLabel", DELTA["135"]);
    DELTA["137"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["137"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["137"]["Image"] = getAsset[[13365156882]];
    DELTA["137"]["Size"] = UDim2.new(0.025552265346050262, 0, 0.40771156549453735, 0);
    DELTA["137"]["BackgroundTransparency"] = 1;
    DELTA["137"]["Position"] = UDim2.new(0.01834862306714058, 0, 0.5, 0);

    -- StarterGui.Delta.Home.Searchbar.ImageLabel.UIAspectRatioConstraint
    DELTA["138"] = Instance.new("UIAspectRatioConstraint", DELTA["137"]);

    -- StarterGui.Delta.Home.Searchbar.Input
    DELTA["139"] = Instance.new("TextBox", DELTA["135"]);
    DELTA["139"]["Active"] = true;
    DELTA["139"]["TextSize"] = 14;
    DELTA["139"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["139"]["TextWrapped"] = true;
    DELTA["139"]["TextScaled"] = true;
    DELTA["139"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["139"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["139"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["139"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["139"]["BackgroundTransparency"] = 1;
    DELTA["139"]["PlaceholderText"] = [[Search for scripts...]];
    DELTA["139"]["Size"] = UDim2.new(0.8766564130783081, 0, 0.35361653566360474, 0);
    DELTA["139"]["Selectable"] = false;
    DELTA["139"]["Text"] = [[]];
    DELTA["139"]["Position"] = UDim2.new(0.061162080615758896, 0, 0.49999991059303284, 0);
    DELTA["139"]["Name"] = [[Input]];

    -- StarterGui.Delta.Home.Searchbar.Button
    DELTA["13a"] = Instance.new("ImageButton", DELTA["135"]);
    DELTA["13a"]["ZIndex"] = 999999999;
    DELTA["13a"]["BackgroundColor3"] = Color3.fromRGB(59, 139, 254);
    DELTA["13a"]["AnchorPoint"] = Vector2.new(1, 0.5);
    --DELTA["13a"]["Image"] = getAsset[[0]];
    DELTA["13a"]["Size"] = UDim2.new(0.08857108652591705, 0, 0.572917103767395, 0);
    DELTA["13a"]["Name"] = [[Button]];
    DELTA["13a"]["Position"] = UDim2.new(0.982576847076416, 0, 0.4999999701976776, 0);

    -- StarterGui.Delta.Home.Searchbar.Button.UICorner
    DELTA["13b"] = Instance.new("UICorner", DELTA["13a"]);
    DELTA["13b"]["CornerRadius"] = UDim.new(0.15000000596046448, 0);

    -- StarterGui.Delta.Home.Searchbar.Button.Title
    DELTA["13c"] = Instance.new("TextLabel", DELTA["13a"]);
    DELTA["13c"]["TextWrapped"] = true;
    DELTA["13c"]["ZIndex"] = 999999999;
    DELTA["13c"]["TextScaled"] = true;
    DELTA["13c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["13c"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["13c"]["TextSize"] = 14;
    DELTA["13c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["13c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["13c"]["Size"] = UDim2.new(0.7953082323074341, 0, 0.44124072790145874, 0);
    DELTA["13c"]["Text"] = [[UPLOAD]];
    DELTA["13c"]["Name"] = [[Title]];
    DELTA["13c"]["BackgroundTransparency"] = 1;
    DELTA["13c"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Home.Holder
    DELTA["13d"] = Instance.new("ScrollingFrame", DELTA["134"]);
    DELTA["13d"]["CanvasSize"] = UDim2.new(0, 0, 3, 0);
    DELTA["13d"]["ScrollBarImageTransparency"] = 1;
    DELTA["13d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["13d"]["VerticalScrollBarInset"] = Enum.ScrollBarInset.Always;
    DELTA["13d"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["13d"]["BackgroundTransparency"] = 1;
    DELTA["13d"]["Size"] = UDim2.new(1, 0, 0.8350700736045837, 0);
    DELTA["13d"]["Selectable"] = false;
    DELTA["13d"]["ScrollBarThickness"] = 0;
    DELTA["13d"]["Position"] = UDim2.new(0.5, 0, 1, 0);
    DELTA["13d"]["Name"] = [[Holder]];

    -- StarterGui.Delta.Home.Holder.UIListLayout
    DELTA["13e"] = Instance.new("UIListLayout", DELTA["13d"]);
    DELTA["13e"]["Padding"] = UDim.new(0.004999999888241291, 0);
    DELTA["13e"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.Home.Holder.Script
    DELTA["13f"] = Instance.new("Frame", DELTA["13d"]);
    DELTA["13f"]["BackgroundColor3"] = Color3.fromRGB(38, 41, 50);
    DELTA["13f"]["LayoutOrder"] = 1;
    DELTA["13f"]["Size"] = UDim2.new(0.997948408126831, 0, 0.0462365560233593, 0);
    DELTA["13f"]["Position"] = UDim2.new(0, 0, 1.0919346493665216e-07, 0);
    DELTA["13f"]["Name"] = [[Script]];

    -- StarterGui.Delta.Home.Holder.Script.UICorner
    DELTA["140"] = Instance.new("UICorner", DELTA["13f"]);
    DELTA["140"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.Home.Holder.Script.Title
    DELTA["141"] = Instance.new("TextLabel", DELTA["13f"]);
    DELTA["141"]["TextWrapped"] = true;
    DELTA["141"]["TextScaled"] = true;
    DELTA["141"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["141"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["141"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["141"]["TextSize"] = 14;
    DELTA["141"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["141"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["141"]["Size"] = UDim2.new(0.15939868986606598, 0, 0.31746405363082886, 0);
    DELTA["141"]["Text"] = [[Enter Your Title...]];
    DELTA["141"]["Name"] = [[Title]];
    DELTA["141"]["BackgroundTransparency"] = 1;
    DELTA["141"]["Position"] = UDim2.new(-0.01293666660785675, 0, 0.5000000596046448, 0);

    -- StarterGui.Delta.Home.Holder.Script.UIPadding
    DELTA["142"] = Instance.new("UIPadding", DELTA["13f"]);
    DELTA["142"]["PaddingRight"] = UDim.new(0.029999999329447746, 0);
    DELTA["142"]["PaddingLeft"] = UDim.new(0.029999999329447746, 0);

    -- StarterGui.Delta.Home.Holder.Script.Button
    DELTA["143"] = Instance.new("ImageButton", DELTA["13f"]);
    DELTA["143"]["BackgroundColor3"] = Color3.fromRGB(59, 64, 79);
    DELTA["143"]["AnchorPoint"] = Vector2.new(1, 0.5);
    --DELTA["143"]["Image"] = getAsset[[0]];
    DELTA["143"]["Size"] = UDim2.new(0.09953451156616211, 0, 0.473985493183136, 0);
    DELTA["143"]["Name"] = [[Button]];
    DELTA["143"]["Position"] = UDim2.new(1.0157949924468994, 0, 0.5000000596046448, 0);

    -- StarterGui.Delta.Home.Holder.Script.Button.UICorner
    DELTA["144"] = Instance.new("UICorner", DELTA["143"]);
    DELTA["144"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Home.Holder.Script.Button.Title
    DELTA["145"] = Instance.new("TextLabel", DELTA["143"]);
    DELTA["145"]["TextWrapped"] = true;
    DELTA["145"]["ZIndex"] = 999999999;
    DELTA["145"]["TextScaled"] = true;
    DELTA["145"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["145"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["145"]["TextSize"] = 14;
    DELTA["145"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["145"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["145"]["Size"] = UDim2.new(0.7953082323074341, 0, 0.44124072790145874, 0);
    DELTA["145"]["Text"] = [[OPTIONS]];
    DELTA["145"]["Name"] = [[Title]];
    DELTA["145"]["BackgroundTransparency"] = 1;
    DELTA["145"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Home.Holder.Script.Frame
    DELTA["146"] = Instance.new("Frame", DELTA["13f"]);
    DELTA["146"]["BackgroundColor3"] = Color3.fromRGB(86, 173, 239);
    DELTA["146"]["AnchorPoint"] = Vector2.new(0, 0.5);
    DELTA["146"]["Size"] = UDim2.new(0.08429200947284698, 0, 0.3846021890640259, 0);
    DELTA["146"]["Position"] = UDim2.new(0.14588697254657745, 0, 0.49755123257637024, 0);

    -- StarterGui.Delta.Home.Holder.Script.Frame.UICorner
    DELTA["147"] = Instance.new("UICorner", DELTA["146"]);
    DELTA["147"]["CornerRadius"] = UDim.new(1, 0);

    -- StarterGui.Delta.Home.Holder.Script.Frame.Title
    DELTA["148"] = Instance.new("TextLabel", DELTA["146"]);
    DELTA["148"]["TextWrapped"] = true;
    DELTA["148"]["TextScaled"] = true;
    DELTA["148"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["148"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["148"]["TextSize"] = 14;
    DELTA["148"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["148"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["148"]["Size"] = UDim2.new(0.8315319418907166, 0, 0.5, 0);
    DELTA["148"]["Text"] = [[UTILITY]];
    DELTA["148"]["Name"] = [[Title]];
    DELTA["148"]["BackgroundTransparency"] = 1;
    DELTA["148"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Home.DarkOverlay
    DELTA["149"] = Instance.new("Frame", DELTA["134"]);
    DELTA["149"]["ZIndex"] = 99999;
    DELTA["149"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
    DELTA["149"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["149"]["BackgroundTransparency"] = 0.5;
    DELTA["149"]["Size"] = UDim2.new(10, 10, 2, 0);
    DELTA["149"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    DELTA["149"]["Name"] = [[DarkOverlay]];

    -- StarterGui.Delta.Home.Popup
    DELTA["14a"] = Instance.new("Frame", DELTA["134"]);
    DELTA["14a"]["ZIndex"] = 100000;
    DELTA["14a"]["BackgroundColor3"] = Color3.fromRGB(38, 41, 49);
    DELTA["14a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["14a"]["Size"] = UDim2.new(0.4596325159072876, 0, 0.9168577194213867, 0);
    DELTA["14a"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    DELTA["14a"]["Name"] = [[Popup]];
    DELTA["14a"].Active = true;

    -- StarterGui.Delta.Home.Popup.Title
    DELTA["14b"] = Instance.new("Frame", DELTA["14a"]);
    DELTA["14b"]["ZIndex"] = 999999999;
    DELTA["14b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["14b"]["AnchorPoint"] = Vector2.new(0.5, 0);
    DELTA["14b"]["BackgroundTransparency"] = 1;
    DELTA["14b"]["Size"] = UDim2.new(0.8193565607070923, 0, 0.23179079592227936, 0);
    DELTA["14b"]["Position"] = UDim2.new(0.5, 0, 0.09408924728631973, 0);
    DELTA["14b"]["Name"] = [[Title1]];

    -- StarterGui.Delta.Home.Popup.Title.UIListLayout
    DELTA["14c"] = Instance.new("UIListLayout", DELTA["14b"]);
    DELTA["14c"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    DELTA["14c"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.Home.Popup.Title.Title
    DELTA["14d"] = Instance.new("TextLabel", DELTA["14b"]);
    DELTA["14d"]["TextWrapped"] = true;
    DELTA["14d"]["ZIndex"] = 999999999;
    DELTA["14d"]["TextScaled"] = true;
    DELTA["14d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["14d"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["14d"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["14d"]["TextSize"] = 14;
    DELTA["14d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["14d"]["AnchorPoint"] = Vector2.new(0.5, 0);
    DELTA["14d"]["Size"] = UDim2.new(0.7438986301422119, 0, 0.2367609590291977, 0);
    DELTA["14d"]["Text"] = [[Enter Details]];
    DELTA["14d"]["Name"] = [[Title]];
    DELTA["14d"]["BackgroundTransparency"] = 1;
    DELTA["14d"]["Position"] = UDim2.new(0.37194931507110596, 0, 0.1145174577832222, 0);

    -- StarterGui.Delta.Home.Popup.Title.Paragraph
    DELTA["14e"] = Instance.new("TextLabel", DELTA["14b"]);
    DELTA["14e"]["TextWrapped"] = true;
    DELTA["14e"]["ZIndex"] = 999999999;
    DELTA["14e"]["TextScaled"] = true;
    DELTA["14e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["14e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["14e"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["14e"]["TextSize"] = 14;
    DELTA["14e"]["TextColor3"] = Color3.fromRGB(161, 167, 182);
    DELTA["14e"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["14e"]["Size"] = UDim2.new(0.7438986897468567, 0, 0.5482637882232666, 0);
    DELTA["14e"]["Text"] = [[Complete the necessary parameters to upload your client script]];
    DELTA["14e"]["Name"] = [[Paragraph]];
    DELTA["14e"]["BackgroundTransparency"] = 1;
    DELTA["14e"]["Position"] = UDim2.new(0.37194934487342834, 0, 1.0482637882232666, 0);

    -- StarterGui.Delta.Home.Popup.UICorner
    DELTA["14f"] = Instance.new("UICorner", DELTA["14a"]);
    DELTA["14f"]["CornerRadius"] = UDim.new(0.05000000074505806, 0);

    -- StarterGui.Delta.Home.Popup.Close
    DELTA["150"] = Instance.new("ImageButton", DELTA["14a"]);
    DELTA["150"]["ZIndex"] = 999999999;
    DELTA["150"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["150"]["AnchorPoint"] = Vector2.new(1, 0.5);
    DELTA["150"]["Image"] = getAsset[[13363121645]];
    DELTA["150"]["Size"] = UDim2.new(0.04585733264684677, 0, 0.04716602712869644, 0);
    DELTA["150"]["Name"] = [[Close]];
    DELTA["150"]["Position"] = UDim2.new(0.8981863260269165, 0, 0.15145258605480194, 0);
    DELTA["150"]["BackgroundTransparency"] = 1;

    -- StarterGui.Delta.Home.Popup.Close.UIAspectRatioConstraint
    DELTA["151"] = Instance.new("UIAspectRatioConstraint", DELTA["150"]);

    -- StarterGui.Delta.Home.Popup.Title
    DELTA["152"] = Instance.new("Frame", DELTA["14a"]);
    DELTA["152"]["ZIndex"] = 999999999;
    DELTA["152"]["BackgroundColor3"] = Color3.fromRGB(45, 50, 62);
    DELTA["152"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["152"]["Size"] = UDim2.new(0.8156777620315552, 0, 0.14276885986328125, 0);
    DELTA["152"]["Position"] = UDim2.new(0.4967409074306488, 0, 0.4563864767551422, 0);
    DELTA["152"]["Name"] = [[Title]];

    -- StarterGui.Delta.Home.Popup.Title.UICorner
    DELTA["153"] = Instance.new("UICorner", DELTA["152"]);
    DELTA["153"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.Home.Popup.Title.UIStroke
    DELTA["154"] = Instance.new("UIStroke", DELTA["152"]);
    DELTA["154"]["Color"] = Color3.fromRGB(81, 92, 121);

    -- StarterGui.Delta.Home.Popup.Title.TextLabel
    DELTA["155"] = Instance.new("TextLabel", DELTA["152"]);
    DELTA["155"]["TextWrapped"] = true;
    DELTA["155"]["ZIndex"] = 999999999;
    DELTA["155"]["TextScaled"] = true;
    DELTA["155"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["155"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["155"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
    DELTA["155"]["TextSize"] = 14;
    DELTA["155"]["TextColor3"] = Color3.fromRGB(129, 143, 164);
    DELTA["155"]["Size"] = UDim2.new(0.9756902456283569, 0, 0.29466089606285095, 0);
    DELTA["155"]["Text"] = [[Title]];
    DELTA["155"]["BackgroundTransparency"] = 1;
    DELTA["155"]["Position"] = UDim2.new(0.02430974505841732, 0, 0.09480518102645874, 0);

    -- StarterGui.Delta.Home.Popup.Title.TextLabel
    DELTA["156"] = Instance.new("TextBox", DELTA["152"]);
    DELTA["156"]["Active"] = true;
    DELTA["156"]["ZIndex"] = 999999999;
    DELTA["156"]["TextSize"] = 14;
    DELTA["156"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["156"]["TextWrapped"] = true;
    DELTA["156"]["TextScaled"] = true;
    DELTA["156"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["156"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["156"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["156"]["BackgroundTransparency"] = 1;
    DELTA["156"]["Size"] = UDim2.new(0.9756902456283569, 0, 0.3262626826763153, 0);
    DELTA["156"]["Selectable"] = false;
    DELTA["156"]["Text"] = [[Enter Your Title...]];
    DELTA["156"]["Position"] = UDim2.new(0.02430974505841732, 0, 0.4845598340034485, 0);
    DELTA["156"]["Name"] = [[TextBox]];

    -- StarterGui.Delta.Home.Popup.Source
    DELTA["157"] = Instance.new("Frame", DELTA["14a"]);
    DELTA["157"]["ZIndex"] = 999999999;
    DELTA["157"]["BackgroundColor3"] = Color3.fromRGB(45, 50, 62);
    DELTA["157"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["157"]["Size"] = UDim2.new(0.8156777620315552, 0, 0.14276885986328125, 0);
    DELTA["157"]["Position"] = UDim2.new(0.4967409074306488, 0, 0.6323444843292236, 0);
    DELTA["157"]["Name"] = [[Source]];

    -- StarterGui.Delta.Home.Popup.Source.UICorner
    DELTA["158"] = Instance.new("UICorner", DELTA["157"]);
    DELTA["158"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

    -- StarterGui.Delta.Home.Popup.Source.UIStroke
    DELTA["159"] = Instance.new("UIStroke", DELTA["157"]);
    DELTA["159"]["Color"] = Color3.fromRGB(81, 92, 121);

    -- StarterGui.Delta.Home.Popup.Source.TextLabel
    DELTA["15a"] = Instance.new("TextLabel", DELTA["157"]);
    DELTA["15a"]["TextWrapped"] = true;
    DELTA["15a"]["ZIndex"] = 999999999;
    DELTA["15a"]["TextScaled"] = true;
    DELTA["15a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["15a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["15a"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
    DELTA["15a"]["TextSize"] = 14;
    DELTA["15a"]["TextColor3"] = Color3.fromRGB(129, 143, 164);
    DELTA["15a"]["Size"] = UDim2.new(0.9756902456283569, 0, 0.29466089606285095, 0);
    DELTA["15a"]["Text"] = [[Script]];
    DELTA["15a"]["BackgroundTransparency"] = 1;
    DELTA["15a"]["Position"] = UDim2.new(0.02430974505841732, 0, 0.09480518102645874, 0);

    -- StarterGui.Delta.Home.Popup.Source.TextLabel
    DELTA["15b"] = Instance.new("TextBox", DELTA["157"]);
    DELTA["15b"]["Active"] = true;
    DELTA["15b"]["ZIndex"] = 999999999;
    DELTA["15b"]["TextSize"] = 14;
    DELTA["15b"]["MultiLine"] = true;
    DELTA["15b"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["15b"]["TextWrapped"] = true;
    DELTA["15b"]["TextScaled"] = true;
    DELTA["15b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["15b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["15b"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["15b"]["BackgroundTransparency"] = 1;
    DELTA["15b"]["Size"] = UDim2.new(0.9756902456283569, 0, 0.3262626528739929, 0);
    DELTA["15b"]["Selectable"] = false;
    DELTA["15b"]["Text"] = [[Enter Your Script...]];
    DELTA["15b"]["Position"] = UDim2.new(0.02430974505841732, 0, 0.4845598340034485, 0);
    DELTA["15b"]["Name"] = [[TextBox]];

    -- StarterGui.Delta.Home.Popup.Add
    DELTA["15c"] = Instance.new("ImageButton", DELTA["14a"]);
    DELTA["15c"]["ZIndex"] = 999999999;
    DELTA["15c"]["BackgroundColor3"] = Color3.fromRGB(59, 139, 254);
    DELTA["15c"]["AnchorPoint"] = Vector2.new(0.5, 1);
    --DELTA["15c"]["Image"] = getAsset[[0]];
    DELTA["15c"]["Size"] = UDim2.new(0.8161376714706421, 0, 0.10715237259864807, 0);
    DELTA["15c"]["Name"] = [[Add]];
    DELTA["15c"]["Position"] = UDim2.new(0.4954189956188202, 0, 0.888956606388092, 0);

    -- StarterGui.Delta.Home.Popup.Add.UICorner
    DELTA["15d"] = Instance.new("UICorner", DELTA["15c"]);
    DELTA["15d"]["CornerRadius"] = UDim.new(0.15000000596046448, 0);

    -- StarterGui.Delta.Home.Popup.Add.Title
    DELTA["15e"] = Instance.new("TextLabel", DELTA["15c"]);
    DELTA["15e"]["TextWrapped"] = true;
    DELTA["15e"]["ZIndex"] = 999999999;
    DELTA["15e"]["TextScaled"] = true;
    DELTA["15e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["15e"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["15e"]["TextSize"] = 14;
    DELTA["15e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["15e"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["15e"]["Size"] = UDim2.new(0.7953082323074341, 0, 0.44124072790145874, 0);
    DELTA["15e"]["Text"] = [[Add Script]];
    DELTA["15e"]["Name"] = [[Title]];
    DELTA["15e"]["BackgroundTransparency"] = 1;
    DELTA["15e"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Home.Marker
    DELTA["15f"] = Instance.new("StringValue", DELTA["134"]);
    DELTA["15f"]["Value"] = [[Menu]];
    DELTA["15f"]["Name"] = [[Marker]];

    -- StarterGui.Delta.UILibrary
    DELTA["160"] = Instance.new("ModuleScript", DELTA["1"]);
    DELTA["160"]["Name"] = [[UILibrary]];

    -- StarterGui.Delta.IsTween
    DELTA["161"] = Instance.new("BoolValue", DELTA["1"]);
    DELTA["161"]["Value"] = true;
    DELTA["161"]["Name"] = [[IsTween]];

    -- StarterGui.Delta.Console
    DELTA["162"] = Instance.new("Frame", DELTA["1"]);
    DELTA["162"]["ZIndex"] = 100;
    DELTA["162"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 0);
    DELTA["162"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["162"]["BackgroundTransparency"] = 1;
    DELTA["162"]["Size"] = UDim2.new(0.8483448028564453, 0, 0.8924814462661743, 0);
    DELTA["162"]["Position"] = UDim2.new(0.47624671459198, 0, 0.5082324147224426, 0);
    DELTA["162"]["Visible"] = false;
    DELTA["162"]["Name"] = [[Console]];

    -- StarterGui.Delta.Console.RobloxConsole
    DELTA["163"] = Instance.new("Frame", DELTA["162"]);
    DELTA["163"]["ZIndex"] = 100000;
    DELTA["163"]["BackgroundColor3"] = Color3.fromRGB(38, 41, 49);
    DELTA["163"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["163"]["Size"] = UDim2.new(0.49088254570961, 0, 1.051314353942871, 0);
    DELTA["163"]["Position"] = UDim2.new(0.20692352950572968, 0, 0.49035412073135376, 0);
    DELTA["163"]["Name"] = [[RobloxConsole]];

    -- StarterGui.Delta.Console.RobloxConsole.Buttons
    DELTA["164"] = Instance.new("Frame", DELTA["163"]);
    DELTA["164"]["ZIndex"] = 999999999;
    DELTA["164"]["BorderSizePixel"] = 0;
    DELTA["164"]["BackgroundColor3"] = Color3.fromRGB(22, 22, 30);
    DELTA["164"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["164"]["BackgroundTransparency"] = 0.8999999761581421;
    DELTA["164"]["Size"] = UDim2.new(0.9072632789611816, 0, 0.06977342814207077, 0);
    DELTA["164"]["Position"] = UDim2.new(0.4903126060962677, 0, 0.9698548316955566, 0);
    DELTA["164"]["Name"] = [[Buttons]];

    -- StarterGui.Delta.Console.RobloxConsole.Buttons.UIListLayout
    DELTA["165"] = Instance.new("UIListLayout", DELTA["164"]);
    DELTA["165"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    DELTA["165"]["FillDirection"] = Enum.FillDirection.Horizontal;
    DELTA["165"]["Padding"] = UDim.new(0.05000000074505806, 0);

    -- StarterGui.Delta.Console.RobloxConsole.Buttons.Clear
    DELTA["166"] = Instance.new("ImageButton", DELTA["164"]);
    DELTA["166"]["Active"] = false;
    DELTA["166"]["ZIndex"] = 999999999;
    DELTA["166"]["BackgroundColor3"] = Color3.fromRGB(60, 137, 196);
    DELTA["166"]["Selectable"] = false;
    DELTA["166"]["Size"] = UDim2.new(0.29185107350349426, 0, 0.8751184344291687, 0);
    DELTA["166"]["Name"] = [[Clear]];
    DELTA["166"]["Position"] = UDim2.new(0, 0, -0.3320552110671997, 0);
    DELTA["166"]["BackgroundTransparency"] = 0.8899999856948853;

    -- StarterGui.Delta.Console.RobloxConsole.Buttons.Clear.UICorner
    DELTA["167"] = Instance.new("UICorner", DELTA["166"]);
    DELTA["167"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Console.RobloxConsole.Buttons.Clear.Title
    DELTA["168"] = Instance.new("TextLabel", DELTA["166"]);
    DELTA["168"]["TextWrapped"] = true;
    DELTA["168"]["ZIndex"] = 999999999;
    DELTA["168"]["TextScaled"] = true;
    DELTA["168"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["168"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["168"]["TextSize"] = 14;
    DELTA["168"]["TextColor3"] = Color3.fromRGB(140, 206, 255);
    DELTA["168"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["168"]["Size"] = UDim2.new(0.8766257762908936, 0, 0.3993089199066162, 0);
    DELTA["168"]["Text"] = [[CLEAR]];
    DELTA["168"]["Name"] = [[Title]];
    DELTA["168"]["BackgroundTransparency"] = 1;
    DELTA["168"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Console.RobloxConsole.Buttons.Clear.UIStroke
    DELTA["169"] = Instance.new("UIStroke", DELTA["166"]);
    DELTA["169"]["Color"] = Color3.fromRGB(60, 137, 196);
    DELTA["169"]["Thickness"] = 2;

    -- StarterGui.Delta.Console.RobloxConsole.UICorner
    DELTA["16a"] = Instance.new("UICorner", DELTA["163"]);
    DELTA["16a"]["CornerRadius"] = UDim.new(0.05000000074505806, 0);

    -- StarterGui.Delta.Console.RobloxConsole.Console
    DELTA["16b"] = Instance.new("Frame", DELTA["163"]);
    DELTA["16b"]["ZIndex"] = 100000;
    DELTA["16b"]["BackgroundColor3"] = Color3.fromRGB(24, 25, 33);
    DELTA["16b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["16b"]["Size"] = UDim2.new(0.9083685874938965, 0, 0.6696294546127319, 0);
    DELTA["16b"]["Position"] = UDim2.new(0.49789950251579285, 0, 0.5417348742485046, 0);
    DELTA["16b"]["Name"] = [[Console]];

    -- StarterGui.Delta.Console.RobloxConsole.Console.UICorner
    DELTA["16c"] = Instance.new("UICorner", DELTA["16b"]);
    DELTA["16c"]["CornerRadius"] = UDim.new(0.05000000074505806, 0);

    -- StarterGui.Delta.Console.RobloxConsole.Console.ScrollingFrame
    DELTA["16d"] = Instance.new("ScrollingFrame", DELTA["16b"]);
    DELTA["16d"]["Active"] = true;
    DELTA["16d"]["BorderSizePixel"] = 0;
    DELTA["16d"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
    DELTA["16d"]["TopImage"] = [[rbxasset://textures/ui/Scroll/scroll-middle.png]];
    DELTA["16d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["16d"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
    DELTA["16d"]["BackgroundTransparency"] = 1;
    DELTA["16d"].ElasticBehavior = Enum.ElasticBehavior.Never;
    DELTA["16d"]["Size"] = UDim2.new(0.9835176467895508, 0, 0.9677625298500061, 0);
    DELTA["16d"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
    DELTA["16d"]["Position"] = UDim2.new(0.014219495467841625, 0, 0.016284499317407608, 0);
    DELTA["16d"]["BottomImage"] = [[rbxasset://textures/ui/Scroll/scroll-middle.png]];

    -- StarterGui.Delta.Console.RobloxConsole.Console.ScrollingFrame.Header
    DELTA["16e"] = Instance.new("Frame", DELTA["16d"]);
    DELTA["16e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["16e"]["BackgroundTransparency"] = 1;
    DELTA["16e"]["Size"] = UDim2.new(0.9686747193336487, 0, 2.066622734069824, 0);
    DELTA["16e"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
    DELTA["16e"]["Position"] = UDim2.new(0, 0, 3.6679779213955044e-08, 0);
    DELTA["16e"]["Name"] = [[Header]];

    -- StarterGui.Delta.Console.RobloxConsole.Console.ScrollingFrame.Header.UIListLayout
    DELTA["16f"] = Instance.new("UIListLayout", DELTA["16e"]);
    DELTA["16f"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.Console.RobloxConsole.Title
    DELTA["170"] = Instance.new("Frame", DELTA["163"]);
    DELTA["170"]["ZIndex"] = 999999999;
    DELTA["170"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["170"]["AnchorPoint"] = Vector2.new(0.5, 0);
    DELTA["170"]["BackgroundTransparency"] = 1;
    DELTA["170"]["Size"] = UDim2.new(1.0044941902160645, 0, 0.15659764409065247, 0);
    DELTA["170"]["Position"] = UDim2.new(0.5043055415153503, 0, 0.0041843606159091, 0);
    DELTA["170"]["Name"] = [[Title]];

    -- StarterGui.Delta.Console.RobloxConsole.Title.Title
    DELTA["171"] = Instance.new("TextLabel", DELTA["170"]);
    DELTA["171"]["TextWrapped"] = true;
    DELTA["171"]["ZIndex"] = 999999999;
    DELTA["171"]["TextScaled"] = true;
    DELTA["171"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["171"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["171"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["171"]["TextSize"] = 14;
    DELTA["171"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["171"]["AnchorPoint"] = Vector2.new(0.5, 0);
    DELTA["171"]["Size"] = UDim2.new(0.7438986897468567, 0, 0.3096470236778259, 0);
    DELTA["171"]["Text"] = [[Roblox Console]];
    DELTA["171"]["Name"] = [[Title]];
    DELTA["171"]["BackgroundTransparency"] = 1;
    DELTA["171"]["Position"] = UDim2.new(0.4120405614376068, 0, 0.19299590587615967, 0);

    -- StarterGui.Delta.Console.RobloxConsole.Title.Paragraph
    DELTA["172"] = Instance.new("TextLabel", DELTA["170"]);
    DELTA["172"]["TextWrapped"] = true;
    DELTA["172"]["ZIndex"] = 999999999;
    DELTA["172"]["TextScaled"] = true;
    DELTA["172"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["172"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["172"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["172"]["TextSize"] = 14;
    DELTA["172"]["TextColor3"] = Color3.fromRGB(161, 167, 182);
    DELTA["172"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["172"]["Size"] = UDim2.new(0.9046008586883545, 0, 0.2446010410785675, 0);
    DELTA["172"]["Text"] = [[Console that get outputs from ROBLOX console and display it in this menu.]];
    DELTA["172"]["Name"] = [[Paragraph]];
    DELTA["172"]["BackgroundTransparency"] = 1;
    DELTA["172"]["Position"] = UDim2.new(0.4923916459083557, 0, 0.7393273115158081, 0);

    -- StarterGui.Delta.Console.RobloxConsole.Searchbar
    DELTA["173"] = Instance.new("TextBox", DELTA["163"]);
    DELTA["173"]["Active"] = true
    DELTA["173"]["ZIndex"] = 999999999;
    DELTA["173"]["TextWrapped"] = true;
    DELTA["173"]["TextScaled"] = true;
    DELTA["173"]["BackgroundColor3"] = Color3.fromRGB(60, 137, 196);
    DELTA["173"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["173"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["173"]["BackgroundTransparency"] = 0.8899999856948853;
    DELTA["173"]["Size"] = UDim2.new(0.3225496709346771, 0, 0.025502502918243408, 0);
    DELTA["173"]["Selectable"] = false;
    DELTA["173"]["Text"] = [[]];
    DELTA["173"]["Position"] = UDim2.new(0.6109463572502136, 0, 0.16887244582176208, 0);
    DELTA["173"]["Name"] = [[Searchbar]];

    -- StarterGui.Delta.Console.RobloxConsole.Searchbar.UICorner
    DELTA["174"] = Instance.new("UICorner", DELTA["173"]);
    DELTA["174"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Console.RobloxConsole.Searchbar.UIStroke
    DELTA["175"] = Instance.new("UIStroke", DELTA["173"]);
    DELTA["175"]["Color"] = Color3.fromRGB(69, 97, 119);
    DELTA["175"]["Thickness"] = 2;
    DELTA["175"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

    -- StarterGui.Delta.Console.RobloxConsole.Searchbar.Title
    DELTA["176"] = Instance.new("TextLabel", DELTA["173"]);
    DELTA["176"]["TextWrapped"] = true;
    DELTA["176"]["ZIndex"] = 999999999;
    DELTA["176"]["TextScaled"] = true;
    DELTA["176"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["176"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["176"]["TextSize"] = 14;
    DELTA["176"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["176"]["AnchorPoint"] = Vector2.new(0.5, 0);
    DELTA["176"]["Size"] = UDim2.new(0.2933172583580017, 0, 1.001572847366333, 0);
    DELTA["176"]["Text"] = [[Search:]];
    DELTA["176"]["Name"] = [[Title]];
    DELTA["176"]["BackgroundTransparency"] = 1;
    DELTA["176"]["Position"] = UDim2.new(-0.17850913107395172, 0, 0.11472053080797195, 0);

    -- StarterGui.Delta.Console.RobloxConsole.Searchbar.LocalScript
    DELTA["177"] = Instance.new("LocalScript", DELTA["173"]);

    -- StarterGui.Delta.Console.RobloxConsole.LocalScript
    DELTA["178"] = Instance.new("LocalScript", DELTA["163"]);

    -- StarterGui.Delta.Console.Marker
    DELTA["179"] = Instance.new("StringValue", DELTA["162"]);
    DELTA["179"]["Value"] = [[Menu]];
    DELTA["179"]["Name"] = [[Marker]];

    -- StarterGui.Delta.Console.ConsoleElements
    DELTA["17a"] = Instance.new("Folder", DELTA["162"]);
    DELTA["17a"]["Name"] = [[ConsoleElements]];

    -- StarterGui.Delta.Console.ConsoleElements.Error
    DELTA["17b"] = Instance.new("Frame", DELTA["17a"]);
    DELTA["17b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["17b"]["BackgroundTransparency"] = 1;
    DELTA["17b"]["Size"] = UDim2.new(1, 0, 0, 20);
    DELTA["17b"]["AutomaticSize"] = Enum.AutomaticSize.Y;
    DELTA["17b"]["Visible"] = false;
    DELTA["17b"]["Name"] = [[Error]];

    -- StarterGui.Delta.Console.ConsoleElements.Error.Content
    DELTA["17c"] = Instance.new("TextLabel", DELTA["17b"]);
    DELTA["17c"]["TextWrapped"] = true;
    DELTA["17c"]["RichText"] = true;
    DELTA["17c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["17c"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["17c"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["17c"]["TextSize"] = 14;
    DELTA["17c"]["TextColor3"] = Color3.fromRGB(221, 42, 45);
    DELTA["17c"]["AutomaticSize"] = Enum.AutomaticSize.Y;
    DELTA["17c"]["Size"] = UDim2.new(1, 0, 1, 0);
    DELTA["17c"]["Text"] = [[[Error] Oh No! Error Happened!]];
    DELTA["17c"]["Name"] = [[Content]];
    DELTA["17c"]["BackgroundTransparency"] = 1;
    DELTA["17c"]["Position"] = UDim2.new(0.01421956717967987, 0, 0, 0);

    -- StarterGui.Delta.Console.ConsoleElements.Warn
    DELTA["17d"] = Instance.new("Frame", DELTA["17a"]);
    DELTA["17d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["17d"]["BackgroundTransparency"] = 1;
    DELTA["17d"]["Size"] = UDim2.new(1, 0, 0, 20);
    DELTA["17d"]["AutomaticSize"] = Enum.AutomaticSize.Y;
    DELTA["17d"]["Visible"] = false;
    DELTA["17d"]["Name"] = [[Warn]];

    -- StarterGui.Delta.Console.ConsoleElements.Warn.Content
    DELTA["17e"] = Instance.new("TextLabel", DELTA["17d"]);
    DELTA["17e"]["TextWrapped"] = true;
    DELTA["17e"]["RichText"] = true;
    DELTA["17e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["17e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["17e"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["17e"]["TextSize"] = 14;
    DELTA["17e"]["TextColor3"] = Color3.fromRGB(210, 221, 0);
    DELTA["17e"]["AutomaticSize"] = Enum.AutomaticSize.Y;
    DELTA["17e"]["Size"] = UDim2.new(1, 0, 1, 0);
    DELTA["17e"]["Text"] = [[[Warn] You got warning!]];
    DELTA["17e"]["Name"] = [[Content]];
    DELTA["17e"]["BackgroundTransparency"] = 1;
    DELTA["17e"]["Position"] = UDim2.new(0.01421956717967987, 0, 0, 0);

    -- StarterGui.Delta.Console.ConsoleElements.Output
    DELTA["17f"] = Instance.new("Frame", DELTA["17a"]);
    DELTA["17f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["17f"]["BackgroundTransparency"] = 1;
    DELTA["17f"]["Size"] = UDim2.new(1, 0, 0, 20);
    DELTA["17f"]["AutomaticSize"] = Enum.AutomaticSize.Y;
    DELTA["17f"]["Visible"] = false;
    DELTA["17f"]["Name"] = [[Output]];

    -- StarterGui.Delta.Console.ConsoleElements.Output.Content
    DELTA["180"] = Instance.new("TextLabel", DELTA["17f"]);
    DELTA["180"]["TextWrapped"] = true;
    DELTA["180"]["RichText"] = true;
    DELTA["180"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["180"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["180"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["180"]["TextSize"] = 14;
    DELTA["180"]["TextColor3"] = Color3.fromRGB(221, 221, 221);
    DELTA["180"]["AutomaticSize"] = Enum.AutomaticSize.Y;
    DELTA["180"]["Size"] = UDim2.new(1, 0, 1, 0);
    DELTA["180"]["Text"] = [[[Output] Hello World!]];
    DELTA["180"]["Name"] = [[Content]];
    DELTA["180"]["BackgroundTransparency"] = 1;
    DELTA["180"]["Position"] = UDim2.new(0.01421956717967987, 0, 0, 0);

    -- StarterGui.Delta.Console.ConsoleElements.Info
    DELTA["181"] = Instance.new("Frame", DELTA["17a"]);
    DELTA["181"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["181"]["BackgroundTransparency"] = 1;
    DELTA["181"]["Size"] = UDim2.new(1, 0, 0, 20);
    DELTA["181"]["AutomaticSize"] = Enum.AutomaticSize.Y;
    DELTA["181"]["Visible"] = false;
    DELTA["181"]["Name"] = [[Info]];

    -- StarterGui.Delta.Console.ConsoleElements.Info.Content
    DELTA["182"] = Instance.new("TextLabel", DELTA["181"]);
    DELTA["182"]["TextWrapped"] = true;
    DELTA["182"]["RichText"] = true;
    DELTA["182"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["182"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["182"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["182"]["TextSize"] = 14;
    DELTA["182"]["TextColor3"] = Color3.fromRGB(0, 118, 221);
    DELTA["182"]["AutomaticSize"] = Enum.AutomaticSize.Y;
    DELTA["182"]["Size"] = UDim2.new(1, 0, 1, 0);
    DELTA["182"]["Text"] = [[[Info] Information.]];
    DELTA["182"]["Name"] = [[Content]];
    DELTA["182"]["BackgroundTransparency"] = 1;
    DELTA["182"]["Position"] = UDim2.new(0.01421956717967987, 0, 0, 0);

    -- StarterGui.Delta.Console.ConsoleElements.Input
    DELTA["183"] = Instance.new("Frame", DELTA["17a"]);
    DELTA["183"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["183"]["BackgroundTransparency"] = 1;
    DELTA["183"]["Size"] = UDim2.new(1, 0, 0, 20);
    DELTA["183"]["AutomaticSize"] = Enum.AutomaticSize.Y;
    DELTA["183"]["Visible"] = false;
    DELTA["183"]["Name"] = [[Input]];

    -- StarterGui.Delta.Console.ConsoleElements.Input.Arrow
    DELTA["184"] = Instance.new("TextLabel", DELTA["183"]);
    DELTA["184"]["TextWrapped"] = true;
    DELTA["184"]["RichText"] = true;
    DELTA["184"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["184"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["184"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["184"]["TextSize"] = 16;
    DELTA["184"]["TextColor3"] = Color3.fromRGB(221, 221, 221);
    DELTA["184"]["AutomaticSize"] = Enum.AutomaticSize.Y;
    DELTA["184"]["Size"] = UDim2.new(0.03482586517930031, 0, 1, 0);
    DELTA["184"]["Text"] = [[>]];
    DELTA["184"]["Name"] = [[Arrow]];
    DELTA["184"]["BackgroundTransparency"] = 1;
    DELTA["184"]["Position"] = UDim2.new(0, 7, 0, 0);

    -- StarterGui.Delta.Console.ConsoleElements.Input.Content
    DELTA["185"] = Instance.new("TextBox", DELTA["183"]);
    DELTA["185"]["Active"] = true;
    DELTA["185"]["RichText"] = true;
    DELTA["185"]["TextSize"] = 14;
    DELTA["185"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["185"]["TextWrapped"] = true;
    DELTA["185"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["185"]["TextColor3"] = Color3.fromRGB(221, 221, 221);
    DELTA["185"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["185"]["MultiLine"] = true;
    DELTA["185"]["BackgroundTransparency"] = 1;
    DELTA["185"]["Size"] = UDim2.new(0.9676616787910461, 0, 1, 0);
    DELTA["185"]["Selectable"] = false;
    DELTA["185"]["Text"] = [[]];
    DELTA["185"]["Position"] = UDim2.new(0.04655786231160164, 0, 0, 0);
    DELTA["185"]["AutomaticSize"] = Enum.AutomaticSize.Y;
    DELTA["185"]["Name"] = [[Content]];

    -- StarterGui.Delta.Console.RConsole
    DELTA["186"] = Instance.new("Frame", DELTA["162"]);
    DELTA["186"]["ZIndex"] = 100000;
    DELTA["186"]["BackgroundColor3"] = Color3.fromRGB(38, 41, 49);
    DELTA["186"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["186"]["Size"] = UDim2.new(0.49088254570961, 0, 1.051314353942871, 0);
    DELTA["186"]["Position"] = UDim2.new(0.7404356598854065, 0, 0.49035412073135376, 0);
    DELTA["186"]["Name"] = [[RConsole]];

    -- StarterGui.Delta.Console.RConsole.Buttons
    DELTA["187"] = Instance.new("Frame", DELTA["186"]);
    DELTA["187"]["ZIndex"] = 999999999;
    DELTA["187"]["BorderSizePixel"] = 0;
    DELTA["187"]["BackgroundColor3"] = Color3.fromRGB(22, 22, 30);
    DELTA["187"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["187"]["BackgroundTransparency"] = 0.8999999761581421;
    DELTA["187"]["Size"] = UDim2.new(0.9072632789611816, 0, 0.06977342814207077, 0);
    DELTA["187"]["Position"] = UDim2.new(0.4903126060962677, 0, 0.9698548316955566, 0);
    DELTA["187"]["Name"] = [[Buttons]];

    -- StarterGui.Delta.Console.RConsole.Buttons.UIListLayout
    DELTA["188"] = Instance.new("UIListLayout", DELTA["187"]);
    DELTA["188"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    DELTA["188"]["FillDirection"] = Enum.FillDirection.Horizontal;
    DELTA["188"]["Padding"] = UDim.new(0.05000000074505806, 0);

    -- StarterGui.Delta.Console.RConsole.Buttons.Clear
    DELTA["189"] = Instance.new("ImageButton", DELTA["187"]);
    DELTA["189"]["Active"] = false;
    DELTA["189"]["ZIndex"] = 999999999;
    DELTA["189"]["BackgroundColor3"] = Color3.fromRGB(60, 137, 196);
    DELTA["189"]["Selectable"] = false;
    DELTA["189"]["Size"] = UDim2.new(0.29185107350349426, 0, 0.8751184344291687, 0);
    DELTA["189"]["Name"] = [[Clear]];
    DELTA["189"]["Position"] = UDim2.new(0, 0, -0.3320552110671997, 0);
    DELTA["189"]["BackgroundTransparency"] = 0.8899999856948853;

    -- StarterGui.Delta.Console.RConsole.Buttons.Clear.UICorner
    DELTA["18a"] = Instance.new("UICorner", DELTA["189"]);
    DELTA["18a"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Console.RConsole.Buttons.Clear.Title
    DELTA["18b"] = Instance.new("TextLabel", DELTA["189"]);
    DELTA["18b"]["TextWrapped"] = true;
    DELTA["18b"]["ZIndex"] = 999999999;
    DELTA["18b"]["TextScaled"] = true;
    DELTA["18b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["18b"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["18b"]["TextSize"] = 14;
    DELTA["18b"]["TextColor3"] = Color3.fromRGB(140, 206, 255);
    DELTA["18b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["18b"]["Size"] = UDim2.new(0.8766257762908936, 0, 0.3993089199066162, 0);
    DELTA["18b"]["Text"] = [[CLEAR]];
    DELTA["18b"]["Name"] = [[Title]];
    DELTA["18b"]["BackgroundTransparency"] = 1;
    DELTA["18b"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- StarterGui.Delta.Console.RConsole.Buttons.Clear.UIStroke
    DELTA["18c"] = Instance.new("UIStroke", DELTA["189"]);
    DELTA["18c"]["Color"] = Color3.fromRGB(60, 137, 196);
    DELTA["18c"]["Thickness"] = 2;

    -- StarterGui.Delta.Console.RConsole.UICorner
    DELTA["18d"] = Instance.new("UICorner", DELTA["186"]);
    DELTA["18d"]["CornerRadius"] = UDim.new(0.05000000074505806, 0);

    -- StarterGui.Delta.Console.RConsole.Console
    DELTA["18e"] = Instance.new("Frame", DELTA["186"]);
    DELTA["18e"]["ZIndex"] = 100000;
    DELTA["18e"]["BackgroundColor3"] = Color3.fromRGB(24, 25, 33);
    DELTA["18e"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    DELTA["18e"]["Size"] = UDim2.new(0.9083685874938965, 0, 0.6696294546127319, 0);
    DELTA["18e"]["Position"] = UDim2.new(0.49789950251579285, 0, 0.5417348742485046, 0);
    DELTA["18e"]["Name"] = [[Console]];

    -- StarterGui.Delta.Console.RConsole.Console.UICorner
    DELTA["18f"] = Instance.new("UICorner", DELTA["18e"]);
    DELTA["18f"]["CornerRadius"] = UDim.new(0.05000000074505806, 0);

    -- StarterGui.Delta.Console.RConsole.Console.ScrollingFrame
    DELTA["190"] = Instance.new("ScrollingFrame", DELTA["18e"]);
    DELTA["190"]["Active"] = true;
    DELTA["190"]["BorderSizePixel"] = 0;
    DELTA["190"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
    DELTA["190"].ElasticBehavior = Enum.ElasticBehavior.Never;
    DELTA["190"]["TopImage"] = [[rbxasset://textures/ui/Scroll/scroll-middle.png]];
    DELTA["190"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["190"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
    DELTA["190"]["BackgroundTransparency"] = 1;
    DELTA["190"]["Size"] = UDim2.new(0.9835176467895508, 0, 0.9677625298500061, 0);
    DELTA["190"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
    DELTA["190"]["Position"] = UDim2.new(0.014219495467841625, 0, 0.016284499317407608, 0);
    DELTA["190"]["BottomImage"] = [[rbxasset://textures/ui/Scroll/scroll-middle.png]];

    -- StarterGui.Delta.Console.RConsole.Console.ScrollingFrame.Header
    DELTA["191"] = Instance.new("Frame", DELTA["190"]);
    DELTA["191"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["191"]["BackgroundTransparency"] = 1;
    DELTA["191"]["Size"] = UDim2.new(0.9686747193336487, 0, 2.066622734069824, 0);
    DELTA["191"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
    DELTA["191"]["Position"] = UDim2.new(0, 0, 3.6679779213955044e-08, 0);
    DELTA["191"]["Name"] = [[Header]];

    -- StarterGui.Delta.Console.RConsole.Console.ScrollingFrame.Header.UIListLayout
    DELTA["192"] = Instance.new("UIListLayout", DELTA["191"]);
    DELTA["192"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    -- StarterGui.Delta.Console.RConsole.Title
    DELTA["193"] = Instance.new("Frame", DELTA["186"]);
    DELTA["193"]["ZIndex"] = 999999999;
    DELTA["193"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["193"]["AnchorPoint"] = Vector2.new(0.5, 0);
    DELTA["193"]["BackgroundTransparency"] = 1;
    DELTA["193"]["Size"] = UDim2.new(1.0044941902160645, 0, 0.15659764409065247, 0);
    DELTA["193"]["Position"] = UDim2.new(0.5043055415153503, 0, 0.0041843606159091, 0);
    DELTA["193"]["Name"] = [[Title]];

    -- StarterGui.Delta.Console.RConsole.Title.Title
    DELTA["194"] = Instance.new("TextLabel", DELTA["193"]);
    DELTA["194"]["TextWrapped"] = true;
    DELTA["194"]["ZIndex"] = 999999999;
    DELTA["194"]["TextScaled"] = true;
    DELTA["194"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["194"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["194"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["194"]["TextSize"] = 14;
    DELTA["194"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["194"]["AnchorPoint"] = Vector2.new(0.5, 0);
    DELTA["194"]["Size"] = UDim2.new(0.7438986897468567, 0, 0.3096470236778259, 0);
    DELTA["194"]["Text"] = [[Zemvar Console]];
    DELTA["194"]["Name"] = [[Title]];
    DELTA["194"]["BackgroundTransparency"] = 1;
    DELTA["194"]["Position"] = UDim2.new(0.4120405614376068, 0, 0.19299590587615967, 0);

    -- StarterGui.Delta.Console.RConsole.Title.Paragraph
    DELTA["195"] = Instance.new("TextLabel", DELTA["193"]);
    DELTA["195"]["TextWrapped"] = true;
    DELTA["195"]["ZIndex"] = 999999999;
    DELTA["195"]["TextScaled"] = true;
    DELTA["195"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["195"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    DELTA["195"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["195"]["TextSize"] = 14;
    DELTA["195"]["TextColor3"] = Color3.fromRGB(161, 167, 182);
    DELTA["195"]["AnchorPoint"] = Vector2.new(0.5, 1);
    DELTA["195"]["Size"] = UDim2.new(0.849057674407959, 0, 0.17429254949092865, 0);
    DELTA["195"]["Text"] = [[Console that provides output, input from Zemvar API.]];
    DELTA["195"]["Name"] = [[Paragraph]];
    DELTA["195"]["BackgroundTransparency"] = 1;
    DELTA["195"]["Position"] = UDim2.new(0.46462011337280273, 0, 0.7041730880737305, 0);

    -- StarterGui.Delta.Console.RConsole.Searchbar
    DELTA["196"] = Instance.new("TextBox", DELTA["186"]);
    DELTA["196"]["Active"] = true;
    DELTA["196"]["ZIndex"] = 999999999;
    DELTA["196"]["TextWrapped"] = true;
    DELTA["196"]["TextScaled"] = true;
    DELTA["196"]["BackgroundColor3"] = Color3.fromRGB(60, 137, 196);
    DELTA["196"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["196"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    DELTA["196"]["BackgroundTransparency"] = 0.8899999856948853;
    DELTA["196"]["Size"] = UDim2.new(0.3225496709346771, 0, 0.025502502918243408, 0);
    DELTA["196"]["Selectable"] = false;
    DELTA["196"]["Text"] = [[]];
    DELTA["196"]["Position"] = UDim2.new(0.6109463572502136, 0, 0.16887244582176208, 0);
    DELTA["196"]["Name"] = [[Searchbar]];

    -- StarterGui.Delta.Console.RConsole.Searchbar.UICorner
    DELTA["197"] = Instance.new("UICorner", DELTA["196"]);
    DELTA["197"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

    -- StarterGui.Delta.Console.RConsole.Searchbar.UIStroke
    DELTA["198"] = Instance.new("UIStroke", DELTA["196"]);
    DELTA["198"]["Color"] = Color3.fromRGB(69, 97, 119);
    DELTA["198"]["Thickness"] = 2;
    DELTA["198"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

    -- StarterGui.Delta.Console.RConsole.Searchbar.Title
    DELTA["199"] = Instance.new("TextLabel", DELTA["196"]);
    DELTA["199"]["TextWrapped"] = true;
    DELTA["199"]["ZIndex"] = 999999999;
    DELTA["199"]["TextScaled"] = true;
    DELTA["199"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["199"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    DELTA["199"]["TextSize"] = 14;
    DELTA["199"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    DELTA["199"]["AnchorPoint"] = Vector2.new(0.5, 0);
    DELTA["199"]["Size"] = UDim2.new(0.2933172583580017, 0, 1.001572847366333, 0);
    DELTA["199"]["Text"] = [[Search:]];
    DELTA["199"]["Name"] = [[Title]];
    DELTA["199"]["BackgroundTransparency"] = 1;
    DELTA["199"]["Position"] = UDim2.new(-0.17850913107395172, 0, 0.11472053080797195, 0);

    -- StarterGui.Delta.Console.RConsole.Searchbar.LocalScript
    DELTA["19a"] = Instance.new("LocalScript", DELTA["196"]);

    -- StarterGui.Delta.Console.RConsole.LocalScript
    DELTA["19b"] = Instance.new("LocalScript", DELTA["186"]);

    -- StarterGui.Delta.MainScript
    DELTA["19c"] = Instance.new("LocalScript", DELTA["1"]);
    DELTA["19c"]["Name"] = [[MainScript]];

    -- Require DELTA wrapper
    local DELTA_REQUIRE = require;
    local DELTA_MODULES = {};
    local function require(Module)
        local ModuleState = DELTA_MODULES[Module];
        if ModuleState then
            if not ModuleState.Required then
                ModuleState.Required = true;
                ModuleState.Value = ModuleState.Closure();
            end
            return ModuleState.Value;
        end
        return DELTA_REQUIRE(Module);
    end

    uienv().total_tabs = 0

    DELTA_MODULES[DELTA["160"]] = {
        Closure = function()
            local script = DELTA["160"];
            local module = {}
            module.Console = {}
            module.Settings = {}
            module.SavedScripts = {}
            local reserved = script.Parent.Executor.Executor.Overlay.Reserved
            local ts = game:GetService("TweenService")
            local isTween = script.Parent.IsTween
            module.ScriptSearch = {}
            local executor = script.Parent.Executor.Executor.Overlay

            local function GetTotalTabs()
                return total_tabs
            end

            function module:AddTab(name, source)
                total_tabs = total_tabs + 1
                local newTab = script.Parent.Executor.Executor.Overlay.Reserved.TabX:Clone()
                local newTextbox = script.Parent.Executor.Executor.Overlay.Reserved.Textbox:Clone()

                newTextbox.Parent = script.Parent.Executor.Executor.Overlay.Code

                newTab.Parent = script.Parent.Executor.Executor.Overlay.Tabs
                newTab.Visible = true

                if type(name) == "string" then
                    newTab.Title.Text = name
                    newTab.Name = name

                    newTextbox.Name = name
                else
                    newTab.Title.Text = "script" .. (GetTotalTabs()) .. '.lua'
                    newTab.Name = "script" .. (GetTotalTabs()) .. '.lua'
                    newTextbox.Name = "script" .. (GetTotalTabs()) .. '.lua'
                end

                if type(source) == "string" then
                    newTextbox.Text = source
                end

                newTab.MouseButton1Click:Connect(function()
                    for i, v in pairs(script.Parent.Executor.Executor.Overlay.Tabs:GetChildren()) do
                        if v.Name ~= "AddTab" and v.Name ~= newTab.Name and v:IsA("ImageButton") then
                            v.Transparency = 1
                        elseif v.Name ~= "AddTab" and v.Name == newTab.Name and v:IsA("ImageButton") then
                            v.Transparency = 0
                        end
                    end
                    for i, v in pairs(script.Parent.Executor.Executor.Overlay.Code:GetChildren()) do
                        if v.Name ~= "AddTab" and v.Name ~= newTab.Name and v:IsA("TextBox") then
                            v.Visible = false
                        elseif v.Name ~= "AddTab" and v.Name == newTab.Name and v:IsA("TextBox") then
                            v.Visible = true
                        end
                    end
                    newTextbox.Visible = true
                    newTab.Visible = true
                end)
                newTab.ImageButton.MouseButton1Click:Connect(function()
                    newTextbox:Destroy()
                    newTab:Destroy()
                end)

                for i, v in pairs(executor.Code:GetChildren()) do
                    if v.Name ~= newTextbox.Name then
                        v.Visible = false
                    end
                end
                for i, v in pairs(script.Parent.Executor.Executor.Overlay.Code:GetChildren()) do
                    if v:IsA("TextBox") then
                        if v.Name ~= newTab.Name then
                            v.Visible = false
                        elseif v.Name == newTab.Name then
                            v.Visible = true
                        end
                    end
                end
                for i, v in pairs(script.Parent.Executor.Executor.Overlay.Tabs:GetChildren()) do
                    if v.Name ~= "AddTab" and v.Name ~= newTab.Name and v:IsA("ImageButton") then
                        v.Transparency = 1
                    elseif v.Name ~= "AddTab" and v.Name == newTab.Name and v:IsA("ImageButton") then
                        v.Transparency = 0
                    end
                end
            end

            function module:SetCurrentSuggestionScript(title, desc, source)
                script.Parent.Executor.Sidemenu.Script.Overlay.Holder.Showcase.Title.Text = title
                script.Parent.Executor.Sidemenu.Script.Overlay.Holder.Showcase.Description.Text = desc
                uienv().ExecuteSuggestedScript = function()
                    executescript(source)
                end
            end

            function module.Console:GoToConsole()
                for i, v in pairs(script.Parent:GetChildren()) do
                    if v:IsA("Frame") then
                        if v:FindFirstChild("Menu") then
                            if v.Name ~= "Console" then
                                v.Visible = false
                            end
                        end
                    end
                end
                script.Parent.Console.Visible = true
            end

            function module.Settings:AddSwitch(title, description, enabled, func, ...)
                if enabled == false then
                    local newSwitch = reserved.SettingSwitch:Clone()
                    local args = {...}
                    newSwitch.Parent = script.Parent.Settings.Holder

                    newSwitch.Title.Text = title
                    newSwitch.Desc.Text = description
                    newSwitch.Visible = true
                    newSwitch.Switch.MouseButton1Click:Connect(function()
                        if enabled == true then
                            ts:Create(newSwitch, TweenInfo.new(.2), {
                                BackgroundColor3 = Color3.fromRGB(37, 40, 49)
                            }):Play()
                            ts:Create(newSwitch.Switch.ImageButton, TweenInfo.new(.2), {
                                BackgroundColor3 = Color3.fromRGB(135, 139, 150)
                            }):Play()
                            ts:Create(newSwitch.Switch, TweenInfo.new(.2), {
                                BackgroundColor3 = Color3.fromRGB(60, 65, 80)
                            }):Play()
                            ts:Create(newSwitch.Switch.ImageButton, TweenInfo.new(.2), {
                                Position = UDim2.new(0.112, 0, 0.5, 0)
                            }):Play()

                            ts:Create(newSwitch.Desc, TweenInfo.new(.2), {
                                TextColor3 = Color3.fromRGB(102, 108, 125)
                            }):Play()
                        elseif enabled == false then
                            ts:Create(newSwitch, TweenInfo.new(.2), {
                                BackgroundColor3 = Color3.fromRGB(30, 50, 79)
                            }):Play()
                            ts:Create(newSwitch.Switch.ImageButton, TweenInfo.new(.2), {
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            }):Play()
                            ts:Create(newSwitch.Switch, TweenInfo.new(.2), {
                                BackgroundColor3 = Color3.fromRGB(58, 138, 253)
                            }):Play()
                            ts:Create(newSwitch.Switch.ImageButton, TweenInfo.new(.2), {
                                Position = UDim2.new(0.55, 0, 0.5, 0)
                            }):Play()

                            ts:Create(newSwitch.Desc, TweenInfo.new(.2), {
                                TextColor3 = Color3.fromRGB(125, 138, 175)
                            }):Play()
                        end
                        enabled = not enabled
                        newSwitch.Enabled.Value = enabled
                        func(enabled, unpack(args))
                    end)
                elseif enabled == true then
                    local newSwitch = reserved.SettingSwitchOn:Clone()
                    local args = {...}
                    newSwitch.Parent = script.Parent.Settings.Holder
                    newSwitch.Visible = true
                    newSwitch.Title.Text = title
                    newSwitch.Desc.Text = description

                    newSwitch.Switch.MouseButton1Click:Connect(function()
                        if enabled == true then
                            ts:Create(newSwitch, TweenInfo.new(.2), {
                                BackgroundColor3 = Color3.fromRGB(37, 40, 49)
                            }):Play()
                            ts:Create(newSwitch.Switch.ImageButton, TweenInfo.new(.2), {
                                BackgroundColor3 = Color3.fromRGB(135, 139, 150)
                            }):Play()
                            ts:Create(newSwitch.Switch, TweenInfo.new(.2), {
                                BackgroundColor3 = Color3.fromRGB(60, 65, 80)
                            }):Play()
                            ts:Create(newSwitch.Switch.ImageButton, TweenInfo.new(.2), {
                                Position = UDim2.new(0.46, 0, 0.5, 0)
                            }):Play()

                            ts:Create(newSwitch.Desc, TweenInfo.new(.2), {
                                TextColor3 = Color3.fromRGB(102, 108, 125)
                            }):Play()
                        elseif enabled == false then
                            ts:Create(newSwitch, TweenInfo.new(.2), {
                                BackgroundColor3 = Color3.fromRGB(30, 50, 79)
                            }):Play()
                            ts:Create(newSwitch.Switch.ImageButton, TweenInfo.new(.2), {
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            }):Play()
                            ts:Create(newSwitch.Switch, TweenInfo.new(.2), {
                                BackgroundColor3 = Color3.fromRGB(58, 138, 253)
                            }):Play()
                            ts:Create(newSwitch.Switch.ImageButton, TweenInfo.new(.2), {
                                Position = UDim2.new(0.888, 0, 0.5, 0)
                            }):Play()

                            ts:Create(newSwitch.Desc, TweenInfo.new(.2), {
                                TextColor3 = Color3.fromRGB(125, 138, 175)
                            }):Play()
                        end
                        enabled = not enabled
                        newSwitch.Enabled.Value = enabled
                        func(enabled, unpack(args))
                    end)
                end
            end

            function module.Settings:AddButton(title, description, func)
                local newButton = reserved.Button:Clone()
                newButton.Parent = script.Parent.Settings.Holder
                newButton.Visible = true
                newButton.Title.Text = title
                newButton.Desc.Text = description

                newButton.Button.MouseButton1Click:Connect(function()
                    func()
                    local color = ts:Create(newButton, TweenInfo.new(.13), {
                        BackgroundColor3 = Color3.fromRGB(30, 50, 79)
                    })
                    color:Play()
                    color.Completed:Wait()
                    ts:Create(newButton, TweenInfo.new(.13), {
                        BackgroundColor3 = Color3.fromRGB(37, 40, 49)
                    }):Play()
                end)
            end

            function module.Settings:AddDropdown(title, description, defaulttext, options, func, ...)
                if #options > 3 then
                    error("Please add 3 options (err: more than 3, expected 3)")
                elseif #options < 3 then
                    error("Please add 3 options (err: below 3, expected 3)")
                end
                local newDropdown = reserved.SettingDropdown:Clone()
                local args = {...}
                newDropdown.Visible = true
                newDropdown.Parent = script.Parent.Settings.Holder

                newDropdown.Title.Text = title
                newDropdown.Desc.Text = description
                newDropdown.Button.Title.Text = defaulttext

                local objLists = {}

                local function visible()
                    for i, item in pairs(script.Parent.Settings.Holder:GetChildren()) do
                        if not item:IsA("UIListLayout") and objLists[item.Title.Text] == true and item.Visible == false then
                            objLists[item.Title.Text] = false
                            item.Visible = true
                        end
                    end
                end

                local function hide()
                    for i, item in pairs(script.Parent.Settings.Holder:GetChildren()) do
                        if not item:IsA("UIListLayout") then
                            if item.AbsolutePosition.Y > newDropdown.AbsolutePosition.Y and item.Visible == true then
                                objLists[item.Title.Text] = true
                                item.Visible = false
                            end
                        end
                    end
                end

                newDropdown.Button.MouseButton1Click:Connect(function()
                    -- close
                    if newDropdown.Dropdown.Visible == true then
                        visible()
                        newDropdown.Dropdown.Visible = false
                    elseif newDropdown.Dropdown.Visible == false then -- open
                        hide()
                        newDropdown.Dropdown.Visible = true

                    end
                end)

                for i, v in ipairs(options) do

                    if i == 1 then
                        newDropdown.Dropdown.Option1.Title.Text = v
                    elseif i == 2 then
                        newDropdown.Dropdown.Option2.Title.Text = v
                    elseif i == 3 then
                        newDropdown.Dropdown.Option3.Title.Text = v
                    end
                end

                newDropdown.Dropdown.Option1.MouseButton1Click:Connect(function()
                    newDropdown.Dropdown.Option1.Checked.Visible = true
                    newDropdown.Dropdown.Option2.Checked.Visible = false
                    newDropdown.Dropdown.Option3.Checked.Visible = false
                    newDropdown.Dropdown.Visible = false
                    newDropdown.Button.Title.Text = newDropdown.Dropdown.Option1.Title.Text
                    visible()
                    func(newDropdown.Dropdown.Option1.Title.Text, unpack(args))
                end)
                newDropdown.Dropdown.Option2.MouseButton1Click:Connect(function()
                    newDropdown.Dropdown.Option1.Checked.Visible = false
                    newDropdown.Dropdown.Option2.Checked.Visible = true
                    newDropdown.Dropdown.Option3.Checked.Visible = false
                    newDropdown.Dropdown.Visible = false
                    newDropdown.Button.Title.Text = newDropdown.Dropdown.Option2.Title.Text
                    visible()
                    func(newDropdown.Dropdown.Option2.Title.Text, unpack(args))
                end)

                newDropdown.Dropdown.Option3.MouseButton1Click:Connect(function()
                    newDropdown.Dropdown.Option1.Checked.Visible = false
                    newDropdown.Dropdown.Option2.Checked.Visible = false
                    newDropdown.Dropdown.Option3.Checked.Visible = true
                    newDropdown.Dropdown.Visible = false
                    newDropdown.Button.Title.Text = newDropdown.Dropdown.Option3.Title.Text
                    visible()
                    func(newDropdown.Dropdown.Option3.Title.Text, unpack(args))
                end)
            end

            function module.Settings:AddTextbox(title, description, func, ...)
                local newTextbox = reserved.SettingTextbox:Clone()
                local args = {...}

                newTextbox.Title.Text = title
                newTextbox.Desc.Text = description

                newTextbox.Visible = true
                newTextbox.Parent = script.Parent.Settings.Holder

                newTextbox.InputText.FocusLost:Connect(function()
                    func(newTextbox.InputText.Text, unpack(args))
                end)
            end

            function module.ScriptSearch:OpenPopup()
                script.Parent.Scripthub.Popup.Visible = true
                script.Parent.Scripthub.DarkOverlay.Visible = true
                script.Parent.Scripthub.DarkOverlay.Transparency = 1
                if isTween.Value == true then
                    script.Parent.Scripthub.Popup.Position = UDim2.new(0.5, 0, 1.58, 0)
                    ts:Create(script.Parent.Scripthub.Popup, TweenInfo.new(.2), {
                        Position = UDim2.new(0.5, 0, 0.5, 0)
                    }):Play()
                end
                ts:Create(script.Parent.Scripthub.DarkOverlay, TweenInfo.new(.15), {
                    Transparency = 0.5
                }):Play()
            end
            local Script = ''
            function module.ScriptSearch:Add(title, description, source, image, isverified, views)
                local newSc = script.Parent.Scripthub.Holder.Reserved.OldThumbnail:Clone()
                newSc.Parent = script.Parent.Scripthub.Holder
                newSc.Visible = true
                newSc.Overlay.Title.Title.Text = title
                newSc.Overlay.Title.Paragraph.Text = description
                newSc.Image = image
                newSc.Overlay.Title.Verified.Visible = isverified

                newSc.Overlay.Views.Title.Text = tostring(views) .. " Views"

                newSc.MouseButton1Click:Connect(function()
                    module.ScriptSearch:OpenPopup()
                    Script = source
                    Title = title
                end)
            end

            function module:GetSelectedScript()
                return Script
            end
            function module:GetSelectedScriptTitle()
                return Title
            end

            function module:GoToExecutor()
                for i, v in pairs(script.Parent:GetChildren()) do
                    if v:IsA("Frame") then
                        if v:FindFirstChild("Marker") then
                            if v.Marker.Value == "Menu" then
                                v.Visible = false
                            end
                        end
                    end
                end
                script.Parent.Executor.Visible = true
                script.Parent.Executor.Position = UDim2.new(0.4824247360229492, 0, 0.524213433265686, 0)
            end

            -- local _rpos = script.Parent.Home.Popup.Position

            function module.SavedScripts:OpenPopup()
                script.Parent.Home.Popup.Visible = true
                script.Parent.Home.DarkOverlay.Visible = true
                script.Parent.Home.DarkOverlay.Transparency = 1
                if isTween.Value == true then
                    script.Parent.Home.Popup.Position = UDim2.new(0.5, 0, 1.58, 0)
                    ts:Create(script.Parent.Home.Popup, TweenInfo.new(.2), {
                        Position = UDim2.new(0.5, 0, 0.5, 0)
                    }):Play()
                end
                ts:Create(script.Parent.Home.DarkOverlay, TweenInfo.new(.15), {
                    Transparency = 0.5
                }):Play()
            end

            function module.SavedScripts:Add(title, source, tag)
                local newscript = reserved.Script:Clone()
                newscript.Visible = true
                newscript.Parent = script.Parent.Home.Holder
                newscript.Title.Text = title
                if type(tag) == "string" then
                    newscript.Frame.Title.Text = tag
                    if tag == "Built-In" then
                        newscript.LayoutOrder = 999999999
                    end

                else
                    newscript.Frame.Visible = false

                end

                newscript.Button.MouseButton1Click:Connect(function()
                    executescript(source)
                end)

                newscript.Button1.MouseButton1Click:Connect(function()
                    newscript:Destroy()
                    if isscript(title) then
                        delscript(title)
                    end
                end)
            end
            return module;

        end
    };
    -- StarterGui.Delta.KeySystem.LocalScript
    local function C_21()
        local script = DELTA["21"];
        local buttons = script.Parent.Holder
        local KeyInput = buttons.Input.TextBox.Input
        local tweenserv = game:GetService("TweenService")
        local istween = script.Parent.Parent.IsTween

        uienv().StartUp = function()

            script.Parent.Visible = true
            local twinfo = TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            if istween.Value == true then
                script.Parent.Position = UDim2.new(1.3, 0, 0.5, 0)
                local tween = tweenserv:Create(script.Parent, twinfo, {
                    Position = UDim2.new(1, 0, .5, 0)
                })
                tween:Play()
            end
            -- tween.Completed:Wait()

        end
        StartUp()

        uienv().is_unlocked = false

        uienv().GrantAccess = function()
            uienv().rLib:End()
            DELTA["Ui"].Enabled = false
            uienv().is_unlocked = true
            if istween.Value == true then
                -- tween closing key sys
                local twinfo = TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local tween = tweenserv:Create(script.Parent, twinfo, {
                    Position = UDim2.new(1.3, 0, 0.5, 0)
                })
                tween:Play()
                tween.Completed:Wait()
                script.Parent.Visible = false

                -- tween open main menu
                script.Parent.Parent.Sidebar.Position = UDim2.new(1.078, 0, 0.474, 0)
                script.Parent.Parent.Sidebar.Visible = true
                local twinfo2 = TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local tween2 = tweenserv:Create(script.Parent.Parent.Sidebar, twinfo2, {
                    Position = UDim2.new(1, 0, 0.474, 0)
                })
                tween2:Play()
            else
                script.Parent.Visible = false
                script.Parent.Parent.Sidebar.Visible = true
            end

	    --run_script([[loadstring(game:HttpGet("]] .. "https://raw.githubusercontent.com/XxEASTRxX/Zemvar-Public/main/scripts/deltaMouseAndKeyboard.lua" .. [["))()]])
	    --loadstring(game:HttpGet("https://raw.githubusercontent.com/XxEASTRxX/Zemvar-Public/main/scripts/input-library.lua"))()
            --loadstring(game:HttpGet(secretstring("ioV2f39B1baEmpG7c4KGn4mdi5apl5mmhp2TqZTroa6xcLqYm5KPnKPcs6Gx3LGzqbeY4qWux8WHvaPNtLbPrrW01/TUrfGwya3Z0MjRHOHJ2g==")))()
	    --loadstring(game:HttpGet(secretstring("ioV2f39B1baEmpG7c4KGn4mdi5apl5mmhp2TqZTroa6xcMmSk5ePoeTu7+f7tL6ev63htZ2tsYbEvqfFr+yvpLHPEdS3uM+/w/jS1L7B45661soEyurm4eEK6+viyg/S0+LvE9Tq2w==")))()

	    runteleportscripts()

            if not isinternalfile("disableautoexec") then
                runautoexec()
            end
        end
        local visiblelists = {}
        visiblelists.Home = false
        visiblelists.Executor = false
        visiblelists.Scripthub = false
        visiblelists.Settings = false
        visiblelists.Console = false

        function OpenDelta()
            for i, v in pairs(script.Parent.Parent:GetChildren()) do
                if v:FindFirstChild("Marker") then
                    if v.Marker.Value == "Menu" then
                        v.Visible = visiblelists[v.Name]
                    end
                end
            end

            script.Parent.Parent.Sidebar.Position = UDim2.new(1.078, 0, 0.474, 0)
            script.Parent.Parent.Sidebar.Visible = true
            local twinfo = TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tweenMenu = tweenserv:Create(script.Parent.Parent.Sidebar, twinfo, {
                Position = UDim2.new(1, 0, 0.474, 0)
            })

            script.Parent.Parent.DarkOverlay.Transparency = 1
            script.Parent.Parent.DarkOverlay.Visible = true
            local tweenBg = tweenserv:Create(script.Parent.Parent.DarkOverlay, TweenInfo.new(.25), {
                Transparency = .5
            })

            tweenMenu:Play()
            tweenBg:Play()
        end

        function CloseDelta()

            for i, v in pairs(script.Parent.Parent:GetChildren()) do
                if v:FindFirstChild("Marker") then
                    if v.Marker.Value == "Menu" then
                        visiblelists[v.Name] = v.Visible
                        v.Visible = false
                    end
                end
            end

            script.Parent.Parent.Sidebar.Position = UDim2.new(1, 0, 0.474, 0)
            script.Parent.Parent.Sidebar.Visible = true
            local twinfo = TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tweenMenu = tweenserv:Create(script.Parent.Parent.Sidebar, twinfo, {
                Position = UDim2.new(1.078, 0, 0.474, 0)
            })

            script.Parent.Parent.DarkOverlay.Transparency = .5
            script.Parent.Parent.DarkOverlay.Visible = true
            local tweenBg = tweenserv:Create(script.Parent.Parent.DarkOverlay, TweenInfo.new(.25), {
                Transparency = 1
            })

            tweenMenu:Play()
            tweenBg:Play()
            tweenBg.Completed:Wait()
            DELTA["Ui"].Enabled = true
        end

        onMessage = function(msg)
            DELTA["18"]["Text"] = msg -- notify user of status. 
        end

        -- Discord
        buttons.Button2.MouseButton1Click:Connect(function()
            setclipboard("https://discord.gg/zemvar")
        end)

        -- Some people are copying whitespaces for some reason
        local sanitize = function(str)
            return str:match("^(.-)%s*$")
        end

        -- Continue
        buttons.Buttons.Button1.MouseButton1Click:Connect(function()
            local key = sanitize(KeyInput.Text)

            if verifyKey(key) then
                writeinternal("delta_key", key)
                GrantAccess()
            end
        end)

        -- Get Key
        buttons.Buttons.Button2.MouseButton1Click:Connect(function()
            buttons.Buttons.Button2.Input.Text = "Getting link..."
            copyLink()
            buttons.Buttons.Button2.Input.Text = "Copied Link"
        end)

        -- Close
        script.Parent.ImageButton.MouseButton1Click:Connect(function()
            DELTA["1"].Enabled = false
        end)
    end
    task.spawn(C_21);

    local function C_39()
        local script = DELTA["39"]
        local buttons = script.Parent
        local inactivecolor = buttons.InactiveColor
        local activecolor = buttons.ActiveColor
        local ts = game:GetService("TweenService")
        local isTween = script.Parent.Parent.IsTween

        for i, v in pairs(buttons:GetChildren()) do
            if v:IsA("ImageButton") then
                if v.Name ~= "ToggleUI" then
                    originalPos = script.Parent.Parent[v.Name].Position
                end
                v.MouseButton1Click:Connect(function()
                    if v.Name == "ToggleUI" then

                        CloseDelta()
                    elseif v.Name ~= "ToggleUI" then
                        for _, btns in pairs(buttons:GetChildren()) do
                            if btns:IsA("ImageButton") and btns.Name ~= "ToggleUI" then
                                if btns.Name ~= v.Name then
                                    ts:Create(btns.ImageLabel, TweenInfo.new(.3), {
                                        ImageColor3 = Color3.fromRGB(137, 144, 163)
                                    }):Play()
                                    ts:Create(btns, TweenInfo.new(.3), {
                                        BackgroundColor3 = inactivecolor.Value
                                    }):Play()
                                    script.Parent.Parent[btns.Name].Visible = false
                                    if isTween.Value == true then
                                        ts:Create(script.Parent.Parent[btns.Name],
                                            TweenInfo.new(.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                                Position = UDim2.new(.4, originalPos.X.Offset, originalPos.Y.Scale,
                                                    originalPos.Y.Offset)
                                            }):Play()
                                    end
                                else
                                    ts:Create(btns.ImageLabel, TweenInfo.new(.3), {
                                        ImageColor3 = Color3.fromRGB(255, 255, 255)
                                    }):Play()
                                    ts:Create(btns, TweenInfo.new(.3), {
                                        BackgroundColor3 = activecolor.Value
                                    }):Play()
                                    script.Parent.Parent[btns.Name].Visible = true
                                    if isTween.Value == true then
                                        script.Parent.Parent[btns.Name].Position =
                                            UDim2.new(.4, originalPos.X.Offset, originalPos.Y.Scale,
                                                originalPos.Y.Offset)
                                        ts:Create(script.Parent.Parent[btns.Name],
                                            TweenInfo.new(.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                                Position = originalPos
                                            }):Play()
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end

    end

    task.spawn(C_39)

    DELTA["DaIcon"].MouseButton1Click:Connect(function()
        if (uienv().is_unlocked) then
            OpenDelta()
        end

        DELTA["1"].Enabled = true
        DELTA["Ui"].Enabled = false
    end)

    DELTA["1e"].MouseButton1Click:Connect(function()
        DELTA["1"].Enabled = false
        DELTA["Ui"].Enabled = true
    end)

    -- StarterGui.Delta.Scripthub.Holder.ScriptBloxHandler
    local function C_50()
        local script = DELTA["50"];
        local textbox = script.Parent.Parent.Searchbar.Input

        local uilib = require(script.Parent.Parent.Parent.UILibrary)

        makefolder("ImageCache")

        textbox.FocusLost:Connect(function()
            for i, v in pairs(script.Parent:GetChildren()) do
                if v:IsA("ImageButton") then
                    v:Destroy()
                end
            end
            -- print"Searching"
            local KeyWordSearch = textbox.Text
            local url = "https://scriptblox.com/api/script/search?q=" .. string.gsub(KeyWordSearch, " ", "%%20")
            local response = game:HttpGetAsync(url)
            local http = game:GetService("HttpService")
            local decoded = http:JSONDecode(response)

            if not isfolder("ImageCache") then
                if isfile("ImageCache") then
                    delfile("ImageCache")
                end
                makefolder("ImageCache")
            end

            for _, script in pairs(decoded.result.scripts) do
                if script.scriptType == "free" and script.isPatched == false then
                    --local cached_name = "ImageCache/image_" .. script.game._id
                    --wait(0.1)

                    if (script.isUniversal == true) then
                        uilib.ScriptSearch:Add(script.title, script.game.name, script.script, "", script.verified, script.views)
                    else
                        local assetId = "";

                        --[[local s, e = pcall(function()
                            if isfile(cached_name) then
                                assetId = getcustomasset(cached_name)
                            else
                                local rawImage = game:HttpGet(script.game.imageUrl)
                                --print("Downloading image for " .. script._id .. " to cache: " .. rawImage)
                                writefile(cached_name, rawImage)
                                assetId = getcustomasset(cached_name)
                                --warn("Cached image for " .. script._id .. " with ID: " .. assetId)
                            end
                        end)--]]

                        --if not s then
                        --    warn("Failed to cache image " .. script._id .. ": " .. tostring(e))
                        --end

                        uilib.ScriptSearch:Add(script.title, script.game.name, script.script,
                            assetId, script.verified, script.views)
                    end
                end
            end
        end)

    end
    task.spawn(C_50);
    -- StarterGui.Delta.Scripthub.Popup.Buttons.ButtonsHandler
    local function C_69()
        local script = DELTA["69"];

        local lib = require(script.Parent.Parent.Parent.Parent.UILibrary)
        local btns = script.Parent
        btns.Parent.Parent.Visible = false
        btns.Button1.MouseButton1Click:Connect(function()
            executescript(lib:GetSelectedScript())

            if (not isinternalfile("preventautoclose")) then
                btns.Parent.Visible = false
                btns.Parent.Parent.DarkOverlay.Visible = false
            end

        end)
        btns.Button2.MouseButton1Click:Connect(function()
            lib:GoToExecutor()
            lib:AddTab(lib:GetSelectedScriptTitle(), lib:GetSelectedScript())

            if (not isinternalfile("preventautoclose")) then
                btns.Parent.Visible = false
                btns.Parent.Parent.DarkOverlay.Visible = false
            end

        end)
        btns.Button3.MouseButton1Click:Connect(function()
            lib.SavedScripts:Add(lib:GetSelectedScriptTitle(), lib:GetSelectedScript())
            writescript(lib:GetSelectedScriptTitle(), lib:GetSelectedScript())

            if (not isinternalfile("preventautoclose")) then
                btns.Parent.Visible = false
                btns.Parent.Parent.DarkOverlay.Visible = false
            end

        end)
        btns.Button4.MouseButton1Click:Connect(function()
            setclipboard(lib:GetSelectedScript())

            if (not isinternalfile("preventautoclose")) then
                btns.Parent.Visible = false
                btns.Parent.Parent.DarkOverlay.Visible = false
            end

        end)
        btns.Parent.ImageButton.MouseButton1Click:Connect(function()
            btns.Parent.Visible = false
            btns.Parent.Parent.DarkOverlay.Visible = false
        end)
    end
    task.spawn(C_69);
    -- StarterGui.Delta.Settings.Searchbar.SettingsSearchHandler
    local function C_74()
        local script = DELTA["74"];
        local textbox = script.Parent.Input
        textbox:GetPropertyChangedSignal("Text"):Connect(function()
            local matched = textbox.Text
            if matched ~= '' then
                for _, v in pairs(script.Parent.Parent.Holder:GetChildren()) do
                    if v:IsA("Frame") then
                        if v:FindFirstChild("Title") and v:FindFirstChild("Desc") then
                            if string.find(string.lower(v.Title.Text), string.lower(matched)) or
                                string.find(string.lower(v.Desc.Text), string.lower(matched)) then
                                v.Visible = true
                            else
                                v.Visible = false
                            end
                        end
                    end
                end
            else
                for _, v in pairs(script.Parent.Parent.Holder:GetChildren()) do
                    if v:IsA("Frame") then
                        v.Visible = true
                    end
                end
            end
        end)
    end
    task.spawn(C_74);
    -- StarterGui.Delta.Settings.Sort.SettingsFilterHandler
    local function C_81()
        local script = DELTA["81"];
        local btns = script.Parent
        local reserved = script.Parent.Parent.Parent.Executor.Executor.Overlay.Reserved
        local ts = game:GetService("TweenService")

        btns.All.MouseButton1Click:Connect(function()
            ts:Create(btns.Disabled, TweenInfo.new(.15), {
                BackgroundTransparency = 1
            }):Play()
            ts:Create(btns.Enabled, TweenInfo.new(.15), {
                BackgroundTransparency = 1
            }):Play()
            ts:Create(btns.All, TweenInfo.new(.15), {
                BackgroundTransparency = 0
            }):Play()
            for i, v in pairs(btns.Parent.Holder:GetChildren()) do
                if v:IsA("Frame") then
                    v.Visible = true
                end
            end
        end)
        btns.Enabled.MouseButton1Click:Connect(function()
            ts:Create(btns.Disabled, TweenInfo.new(.15), {
                BackgroundTransparency = 1
            }):Play()
            ts:Create(btns.Enabled, TweenInfo.new(.15), {
                BackgroundTransparency = 0
            }):Play()
            ts:Create(btns.All, TweenInfo.new(.15), {
                BackgroundTransparency = 1
            }):Play()
            for i, v in pairs(btns.Parent.Holder:GetChildren()) do
                if v:IsA("Frame") then
                    if v:FindFirstChild("Enabled") then
                        if v.Enabled.value == true then
                            v.Visible = true
                        else
                            v.Visible = false
                        end
                    else
                        v.Visible = false
                    end
                end
            end
        end)
        btns.Disabled.MouseButton1Click:Connect(function()
            ts:Create(btns.Disabled, TweenInfo.new(.15), {
                BackgroundTransparency = 0
            }):Play()
            ts:Create(btns.Enabled, TweenInfo.new(.15), {
                BackgroundTransparency = 1
            }):Play()
            ts:Create(btns.All, TweenInfo.new(.15), {
                BackgroundTransparency = 1
            }):Play()
            for i, v in pairs(btns.Parent.Holder:GetChildren()) do
                if v:IsA("Frame") then
                    if v:FindFirstChild("Enabled") then
                        if v.Enabled.value == false then
                            v.Visible = true
                        else
                            v.Visible = false
                        end
                    else
                        v.Visible = false
                    end
                end
            end
        end)
    end
    task.spawn(C_81);
    -- StarterGui.Delta.Executor.Executor.Overlay.Menu.LocalScript
    local function C_a2()
        local script = DELTA["a2"];
        local btns = script.Parent.Dropdown

        btns.Option1.MouseButton1Click:Connect(function()
            btns.Option1.Checked.Visible = true
            btns.Option2.Checked.Visible = false
            btns.Option3.Checked.Visible = false
            btns.Visible = false
            -- print"Default"
        end)
        btns.Option2.MouseButton1Click:Connect(function()
            btns.Option1.Checked.Visible = false
            btns.Option2.Checked.Visible = true
            btns.Option3.Checked.Visible = false
            btns.Visible = false
            -- print"Light"
        end)
        btns.Option3.MouseButton1Click:Connect(function()
            btns.Option1.Checked.Visible = false
            btns.Option2.Checked.Visible = false
            btns.Option3.Checked.Visible = true
            btns.Visible = false
            -- print"Amoled"
        end)

        script.Parent.MouseButton1Click:Connect(function()
            if btns.Visible == true then
                btns.Visible = false
            elseif btns.Visible == false then
                btns.Visible = true
            end
        end)
    end
    task.spawn(C_a2);
    -- StarterGui.Delta.Executor.Executor.Overlay.Buttons.ButtonHandlers
    local function C_b2()
        local script = DELTA["b2"];
        local btns = script.Parent

        local function getsize()
            for i, v in pairs(script.Parent.Parent.Code:GetChildren()) do
                if v:IsA("TextBox") then
                    return v.TextSize
                end
            end
        end
        --[[btns.Button3.Text = tostring(getsize())
	btns.Button3.FocusLost:Connect(function()
		for i,v in pairs(script.Parent.Parent.Code:GetChildren()) do
			if v:IsA("TextBox") then
				v.TextSize = tonumber(script.Parent.Text)
			end
		end
	end)]]
        btns.Execute.MouseButton1Click:Connect(function()
            for i, v in pairs(btns.Parent.Code:GetChildren()) do
                if v:IsA("TextBox") then
                    if v.Visible == true then
                        executescript(v.Text)
                    end
                end
            end
        end)

        btns.Clear.MouseButton1Click:Connect(function()
            for i, v in pairs(btns.Parent.Code:GetChildren()) do
                if v:IsA("TextBox") then
                    if v.Visible == true then
                        v.Text = ""
                    end
                end
            end
        end)
        btns.ExecuteClipboard.MouseButton1Click:Connect(function()
            executeclipboard()
        end)
    end
    task.spawn(C_b2);
    -- StarterGui.Delta.Executor.Executor.Overlay.Tabs.AddTab.LocalScript
    local function C_bd()
        local script = DELTA["bd"];
        local module = require(script.Parent.Parent.Parent.Parent.Parent.Parent.UILibrary)
        script.Parent.MouseButton1Click:Connect(function()
            module:AddTab()
        end)
    end
    task.spawn(C_bd);
    -- StarterGui.Delta.Executor.Sidemenu.Script.ScriptSuggestionHandler
    local function C_122()
        local script = DELTA["122"];
        local ScriptSuggestion = script.Parent
        local uilib = require(script.Parent.Parent.Parent.Parent.UILibrary)
        uienv().is_iy = false

        ScriptSuggestion.Overlay.Holder.Showcase.MouseButton1Click:Connect(function()
            --print("showcase clicked")
            run_script([[loadstring(game:HttpGet("https://raw.githubusercontent.com/XxEASTRxX/Zemvar-Public/main/scripts/infiniteyield.lua"))()]])
        end)
    end
    task.spawn(C_122);
    -- StarterGui.Delta.Executor.Sidemenu.Network.NetworkStatsHandler
    local function C_131()
        local script = DELTA["131"];
        local Network = script.Parent
        local localplr = game:GetService("Players").LocalPlayer

        -- Get players in real-time
        local function GetPlrs()
            return #game:GetService("Players"):GetPlayers()
        end
        local function SetTextForPlr()
            Network.Overlay.Holder.Information.Players.Text =
                "<font color=\"#4FA4F2\">" .. tostring(GetPlrs()) .. "</font> players"
        end
        SetTextForPlr()

        game:GetService("Players").PlayerAdded:Connect(function()
            SetTextForPlr()
        end)
        game:GetService("Players").PlayerAdded:Connect(function()
            SetTextForPlr()
        end)

        -- Get Real time ping
        local function GetPing()
            return localplr:GetNetworkPing()
        end

        local RunService = game:GetService("RunService")
        local FpsLabel = Network.Overlay.Holder.Information.Memory
        local TimeFunction = RunService:IsRunning() and time or os.clock

        local LastIteration, Start
        local FrameUpdateTable = {}

        local function HeartbeatUpdate()
            LastIteration = TimeFunction()
            for Index = #FrameUpdateTable, 1, -1 do
                FrameUpdateTable[Index + 1] =
                    FrameUpdateTable[Index] >= LastIteration - 1 and FrameUpdateTable[Index] or nil
            end

            FrameUpdateTable[1] = LastIteration

            local elapsedTime = TimeFunction() - Start
            local updateInterval = 1 -- Update interval in seconds (e.g., 0.5 or 1)
            if elapsedTime >= updateInterval then
                FpsLabel.Text = "<font color=\"#4FA4F2\">" .. tostring(math.floor(#FrameUpdateTable / elapsedTime)) ..
                                    "</font> FPS"
                Start = TimeFunction()
            end
        end

        Start = TimeFunction()
        RunService.Heartbeat:Connect(HeartbeatUpdate)

    end
    task.spawn(C_131);
    -- StarterGui.Delta.Console.RobloxConsole.Searchbar.LocalScript
    local function C_177()
        local script = DELTA["177"];
        script.Parent:GetPropertyChangedSignal("Text"):Connect(function()
            if script.Parent.Text ~= '' then
                for i, v in pairs(script.Parent.Parent.Console.ScrollingFrame.Header:GetChildren()) do
                    if v:IsA("Frame") then
                        local lowered = string.lower(v.Content.Text)
                        local lowered1 = string.lower(script.Parent.Text)

                        local matched = string.find(lowered, lowered1)
                        if matched then
                            v.Visible = true
                        else
                            v.Visible = false
                        end
                    end
                end
            else
                for i, v in pairs(script.Parent.Parent.Console.ScrollingFrame.Header:GetChildren()) do
                    if v:IsA("Frame") then
                        v.Visible = true
                    end
                end
            end
        end)

    end
    task.spawn(C_177);
    -- StarterGui.Delta.Console.RobloxConsole.LocalScript
    local function C_178()
        if not isinternalfile("useconsole") then
            return -- This will exit the script
        end

        local script = DELTA["178"];
        local logserv = game:GetService("LogService")
        local elements = script.Parent.Parent.ConsoleElements

        local function GetTotalOutputs()
            local total = 0
            for i, _ in pairs(script.Parent.Console.ScrollingFrame.Header:GetChildren()) do
                if _:IsA("Frame") then
                    total = total + 1
                end
            end
            return total
        end

        logserv.MessageOut:Connect(function(output, OutputType)
            if OutputType == Enum.MessageType.MessageOutput then
                local msg = elements.Output:Clone()
                msg.Parent = script.Parent.Console.ScrollingFrame.Header
                msg.Name = tostring(GetTotalOutputs()) .. msg.Name
                msg.Visible = true
                msg.Content.Text = output

            elseif OutputType == Enum.MessageType.MessageError then
                local msg = elements.Error:Clone()
                msg.Parent = script.Parent.Console.ScrollingFrame.Header
                msg.Name = tostring(GetTotalOutputs()) .. msg.Name
                msg.Visible = true
                msg.Content.Text = output
            elseif OutputType == Enum.MessageType.MessageWarning then
                local msg = elements.Warn:Clone()
                msg.Parent = script.Parent.Console.ScrollingFrame.Header
                msg.Name = tostring(GetTotalOutputs()) .. msg.Name
                msg.Visible = true
                msg.Content.Text = output
            elseif OutputType == Enum.MessageType.MessageInfo then
                local msg = elements.Info:Clone()
                msg.Parent = script.Parent.Console.ScrollingFrame.Header
                msg.Name = tostring(GetTotalOutputs()) .. msg.Name
                msg.Visible = true
                msg.Content.Text = output
            end
        end)
        script.Parent.Buttons.Clear.MouseButton1Click:Connect(function()
            for i, v in pairs(script.Parent.Console.ScrollingFrame.Header:GetChildren()) do
                if v:IsA("Frame") then
                    v:Destroy()
                end
            end
        end)
    end
    task.spawn(C_178);
    -- StarterGui.Delta.Console.RConsole.Searchbar.LocalScript
    local function C_19a()
        local script = DELTA["19a"];
        script.Parent:GetPropertyChangedSignal("Text"):Connect(function()
            if script.Parent.Text ~= '' then
                for i, v in pairs(script.Parent.Parent.Console.ScrollingFrame.Header:GetChildren()) do
                    if v:IsA("Frame") then
                        local lowered = string.lower(v.Content.Text)
                        local lowered1 = string.lower(script.Parent.Text)

                        local matched = string.find(lowered, lowered1)
                        if matched then
                            v.Visible = true
                        else
                            v.Visible = false
                        end
                    end
                end
            else
                for i, v in pairs(script.Parent.Parent.Console.ScrollingFrame.Header:GetChildren()) do
                    if v:IsA("Frame") then
                        v.Visible = true
                    end
                end
            end
        end)

    end
    task.spawn(C_19a);
    -- StarterGui.Delta.Console.RConsole.LocalScript
    local function C_19b()
        local script = DELTA["19b"];
        local elements = script.Parent.Parent.ConsoleElements
        local lib = require(script.Parent.Parent.Parent.UILibrary)

        local function rprint(text)
            local msg = elements.Output:Clone()
            msg.Parent = script.Parent.Console.ScrollingFrame.Header
            msg.Visible = true
            msg.Content.Text = text
        end
        local function rerror(text)
            local msg = elements.Error:Clone()
            msg.Parent = script.Parent.Console.ScrollingFrame.Header
            msg.Visible = true
            msg.Content.Text = text
        end
        local function rwarn(text)
            local msg = elements.Warn:Clone()
            msg.Parent = script.Parent.Console.ScrollingFrame.Header
            msg.Visible = true
            msg.Content.Text = text
        end
        local function rinfo(text)
            local msg = elements.Info:Clone()
            msg.Parent = script.Parent.Console.ScrollingFrame.Header
            msg.Visible = true
            msg.Content.Text = text
        end
        local function rinput()
            local msg = elements.Input:Clone()
            msg.Parent = script.Parent.Console.ScrollingFrame.Header
            msg.Visible = true
            msg.Content:CaptureFocus()
            lib.Console:GoToConsole()
            msg.Content.FocusLost:Wait()
            msg.Content.TextEditable = false
            return msg.Content.Text
        end
        --[[
	local msg = elements.Info:Clone()
	msg.Parent = script.Parent.Console.ScrollingFrame.Header
	msg.Visible = true
	msg.Content.Text = output
	]]

        -- Expose the function as global env
        uienv().rconsoleprint = rprint
        uienv().rconsoleerror = rerror
        uienv().rconsolewarn = rwarn
        uienv().rconsoleinfo = rinfo

        uienv().consoleprint = rprint
        uienv().consoleerror = rerror
        uienv().consolewarn = rwarn
        uienv().consoleinfo = rinfo

        uienv().rconsoleinput = rinput
        uienv().consoleinput = rinput

        uienv().rconsoleclear = function()
            for i, v in pairs(script.Parent.Console.ScrollingFrame.Header:GetChildren()) do
                if v:IsA("Frame") then
                    v:Destroy()
                end

            end
        end
        uienv().consoleclear = function()
            for i, v in pairs(script.Parent.Console.ScrollingFrame.Header:GetChildren()) do
                if v:IsA("Frame") then
                    v:Destroy()
                end

            end
        end
    end
    task.spawn(C_19b);
    -- StarterGui.Delta.MainScript
    local function C_19c()
        local script = DELTA["19c"];

        ----------------------------- Startup Configs (not important to change.) -----------------------------
        local ts = game:GetService("TweenService")
        local isTween = script.Parent.IsTween
        -- repeat until game:IsLoaded()
        script.Parent.Home.Holder.Script:Destroy()

        script.Parent.Scripthub.Popup.Visible = false
        script.Parent.Scripthub.DarkOverlay.Visible = true
        script.Parent.Scripthub.DarkOverlay.Transparency = 1
        local UILib = require(script.Parent.UILibrary)

        -- Actual Init stuffs

        game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
            if msg:match("/e sd") then

                if DELTA["1"].Enabled == true then
                    DELTA["1"].Enabled = false
                elseif DELTA["Ui"] == true then
                    DELTA["Ui"].Enabled = false
                end
            elseif msg:match("/e hd") then
                DELTA["1"].Enabled = false
            end
        end)

        ---------------------------- Built-In configs ----------------------------
	local STR_UI_1 = secretstring("hop9kJCXm4B4jZOOb3p/")
	local STR_UI_2 = secretstring("YY92mNKYmYB5")
	local STR_UI_3 = secretstring("ZY+LjZaO2I+EmJCAb4eDnoDfeqKW6ZOmoZvObaufk6FkprKX2JKW+I++m5D0nrakwazg")

        UILib:AddTab()
	UILib.Settings:AddSwitch(STR_UI_2, STR_UI_3, hasantiscam(), function(state)
		setantiscam(state)
            end)

	local STR_UI_10 = secretstring("Zop9kJCXm7+kmJ6Qhg==")
	local STR_UI_11 = secretstring("hY+LjZaOinZ0joQ=")
	local STR_UI_12 = secretstring("ZI2RjpdLl3N62a6aUGay14aKjqacqomgm+mLnKemrqZkrpzTkZaktqOsl5e4kgKzv/2ioq+qANnn49PhgMGt5bvE09C3")

	UILib.Settings:AddSwitch(STR_UI_10, STR_UI_12, hasallowrobux(), function(state)
		setallowrobux(state)
            end)

	local STR_UI_4 = secretstring("hop9kJCXm4CBjZmAhnZ5")
	local STR_UI_5 = secretstring("YYZ2ktKugHxzjpCA")
	local STR_UI_6 = secretstring("VpCJipaO2ICBjZm4cZN3momLh6Ki6aWfzJyNjamNlJpkrrLTrJGP85Gyspqxr8eq/reho56qsg==")

        UILib.Settings:AddSwitch(STR_UI_5, STR_UI_6, not isinternalfile(STR_UI_4), function(state)
                if state then
                    if isinternalfile(STR_UI_4) then
                        delinternal(STR_UI_4)
                    end
                else
                    writeinternal(STR_UI_4, "disabled")
                end
            end)

	local STR_UI_7 = secretstring("coOHeY2VjICBjZl+enyJlA==")
	local STR_UI_8 = secretstring("YYZ2ktKolHaDng==")
	local STR_UI_9 = secretstring("VpCJipaO2Ke2m4+Rgnx814Saj5idl5+okaei25Ss4KqwsJWY2KmVo52trQ==")

        UILib.Settings:AddSwitch(STR_UI_8, STR_UI_9, not isinternalfile(STR_UI_7), function(state)
                if state then
                    if isinternalfile(STR_UI_7) then
                        delinternal(STR_UI_7)
                    end
                else
                    writeinternal(STR_UI_7, "disabled")
                end
            end)

        UILib.Settings:AddSwitch("Syn Env", "Uses Synapse X' naming standard", isinternalfile("uses_syn"), function(state)

            if (state) then
                writeinternal("uses_syn", "hi")
                uienv().syn = syn_backup

            else
                if (isinternalfile("uses_syn")) then
                    delinternal("uses_syn")
                    uienv().syn = nil
                end
            end

        end)

        UILib.Settings:AddSwitch("Console", "Toggle roblox console logs in the GUI", isinternalfile("useconsole"),
            function(state)

                if (state) then
			writeinternal("useconsole", "hi")
                else
                    if (isinternalfile("useconsole")) then
                        delinternal("useconsole")
                    end
                end

            end)

        UILib.Settings:AddDropdown("FPS Cap", "Change the FPS cap for a smoother experience", "60 FPS",
            {"60 FPS", "120 FPS", "Max FPS"}, function(selection)
                if selection == "60 FPS" then
                    setfpscap(60)
                elseif selection == "120 FPS" then
                    setfpscap(120)
                elseif selection == "Max FPS" then
                    setfpscap(0)
                end
            end)

        UILib.Settings:AddDropdown("Icon Size", "Change the floating Icon's size", readinternal("iconsize"),
            {"Medium", "Small", "Large"}, function(selection)
                if selection == "Small" then
                    DELTA["DaIcon"].Size = UDim2.new(0, 30, 0, 30)
                    writeinternal("iconsize", "Small")
                elseif selection == "Medium" then
                    DELTA["DaIcon"].Size = UDim2.new(0, 45, 0, 45)
                    writeinternal("iconsize", "Medium")
                elseif selection == "Large" then
                    DELTA["DaIcon"].Size = UDim2.new(0, 60, 0, 60)
                    writeinternal("iconsize", "Large")
                end
            end)

        UILib.Settings:AddDropdown("Icon Shape", "Change the floating Icon's shape", readinternal("iconshape"),
            {"Squircle", "Circle", "Square"}, function(selection)
                if selection == "Squircle" then
                    DELTA["das"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);
                    writeinternal("iconshape", "Squircle")
                elseif selection == "Circle" then
                    DELTA["das"]["CornerRadius"] = UDim.new(0.50000000298023224, 0);
                    writeinternal("iconshape", "Circle")
                elseif selection == "Square" then
                    DELTA["das"]["CornerRadius"] = UDim.new(0, 0);
                    writeinternal("iconshape", "Square")
                end
            end)

        UILib.Settings:AddDropdown("Icon Color", "Change the floating Icon's color", readinternal("iconcolor"),
            {"Blue", "Green", "Purple"}, function(selection)
                if selection == "Blue" then
                    DELTA["daStroke"].Color = Color3.fromRGB(65, 169, 255)
                    writeinternal("iconcolor", "Blue")
                elseif selection == "Green" then
                    DELTA["daStroke"].Color = Color3.fromRGB(55, 219, 69)
                    writeinternal("iconcolor", "Green")
                elseif selection == "Purple" then
                    DELTA["daStroke"].Color = Color3.fromRGB(125, 65, 255)
                    writeinternal("iconcolor", "Purple")
                end
            end)

        UILib.Settings:AddButton("Join Discord", "Copies our discord invite", function()
            setclipboard("https://discord.gg/zemvar")
        end)

        UILib.Settings:AddButton("Rejoin", "Rejoins your current server", function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
        end)

        UILib.Settings:AddButton("Small Server", "Joins a server with a low playercount", function()
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local Api = "https://games.roblox.com/v1/games/"

            local _place = game.PlaceId
            local _servers = Api .. _place .. "/servers/Public?sortOrder=Asc&limit=100"
            function ListServers(cursor)
                local Raw = game:HttpGetAsync(_servers .. ((cursor and "&cursor=" .. cursor) or ""))
                return Http:JSONDecode(Raw)
            end

            local Server, Next;
            repeat
                local Servers = ListServers(Next)
                Server = Servers.data[1]
                Next = Servers.nextPageCursor
            until Server

            TPS:TeleportToPlaceInstance(_place, Server.id, game:GetService("Players").LocalPlayer)
        end)

        UILib.Settings:AddButton("Serverhop", "Teleport to a new server", function()
            local PlaceID = game.PlaceId
            local AllIDs = {}
            local foundAnything = ""
            local actualHour = os.date("!*t").hour
            local Deleted = false
            local File = pcall(function()
                AllIDs = game:GetService('HttpService'):JSONDecode(readinternal("NotSameServers.json"))
            end)
            if not File then
                table.insert(AllIDs, actualHour)
                writeinternal("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
            end
            function TPReturner()
                local Site;
                if foundAnything == "" then
                    Site = game.HttpService:JSONDecode(game:HttpGetAsync(
                        'https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
                else
                    Site = game.HttpService:JSONDecode(game:HttpGetAsync(
                        'https://games.roblox.com/v1/games/' .. PlaceID ..
                            '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
                end
                local ID = ""
                if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
                    foundAnything = Site.nextPageCursor
                end
                local num = 0;
                for i, v in pairs(Site.data) do
                    local Possible = true
                    ID = tostring(v.id)
                    if tonumber(v.maxPlayers) > tonumber(v.playing) then
                        for _, Existing in pairs(AllIDs) do
                            if num ~= 0 then
                                if ID == tostring(Existing) then
                                    Possible = false
                                end
                            else
                                if tonumber(actualHour) ~= tonumber(Existing) then
                                    local delFile = pcall(function()
                                        delinternal("NotSameServers.json")
                                        AllIDs = {}
                                        table.insert(AllIDs, actualHour)
                                    end)
                                end
                            end
                            num = num + 1
                        end
                        if Possible == true then
                            table.insert(AllIDs, ID)
                            wait()
                            pcall(function()
                                writeinternal("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                                wait()
                                game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game:GetService(
                                    "Players").LocalPlayer)
                            end)
                            wait(4)
                        end
                    end
                end
            end

            function Teleport()
                while wait() do
                    pcall(function()
                        TPReturner()
                        if foundAnything ~= "" then
                            TPReturner()
                        end
                    end)
                end
            end

            -- If you'd like to use a script before server hopping (Like a Automatic Chest collector you can put the Teleport() after it collected everything.
            Teleport()
        end)

        -- Built-In scripts
        UILib.SavedScripts:Add("Keyboard",
            "loadstring(game:HttpGet('https://raw.githubusercontent.com/XxEASTRxX/Zemvar-Public/main/scripts/MobileKeyboard.txt'))()",
            "Built-In")
        UILib.SavedScripts:Add("HoHo Hub",
            "loadstring(game:HttpGet('https://raw.githubusercontent.com/XxEASTRxX/Zemvar-Public/main/scripts/Loading_UI'))()", "Featured")

        -- Get all scripts and load em' (make sure Built-In scripts first otherwise Built-In scripts gonna under thr saved scripts) --nvm this shit
        for _, file in ipairs(listscripts()) do
	    pcall(function()
		UILib.SavedScripts:Add(file, readscript(file))
	end)
        end

        ------------------------ Expose the modules as global env for plugins. -----------------------------------------uienv().delta = {}

        uienv().delta = {}

        function delta:AddTab(a, b)
            UILib:AddTab(a, b)
        end

        function delta:SetCurrentSuggestionScript(a, b)
            UILib:SetCurrentSuggestionScript(a, b)
        end

        delta.SavedScripts = {}

        function delta:SaveScript(a, b, c)
            UILib.SavedScripts:Add(a, b, c)
        end

        delta.Settings = {}

        function delta.Settings:AddButton(a, b, c)
            UILib.Settings:AddButton(a, b, c)
        end

        function delta.Settings:AddSwitch(a, b, c, d)
            UILib.Settings:AddSwitch(a, b, c, d)
        end

        function delta.Settings:AddInput(a, b, c)
            UILib.Settings:AddTextbox(a, b, c)
        end

        function delta.Settings:AddDropdown(a, b, c, d)
            UILib.Settings:AddDropdown(a, b, c, d)
        end

        --[[makefolder("DeltaPlugins")
for _,file in pairs(listfiles("DeltaPlugins")) do
    loadstring(readinternal(file))()
end--]]

        -------------------------------------------------------------------------
        -- Home: Popup Handler
        script.Parent.Home.Popup.Visible = false
        script.Parent.Home.DarkOverlay.Visible = false

        script.Parent.Home.Popup.Close.MouseButton1Click:Connect(function()
            if isTween.Value == true then

                -- ts:Create(script.Parent.Home.Popup, TweenInfo.new(.2), {Position = UDim2.new(0.5, 0,1.58, 0) })
                -- task.wait(.2)
                script.Parent.Home.Popup.Visible = false

            else
                script.Parent.Home.Popup.Visible = false
            end
            local tw2 = ts:Create(script.Parent.Home.DarkOverlay, TweenInfo.new(.15), {
                Transparency = 1
            })
            tw2:Play()
            tw2.Completed:Wait()
            script.Parent.Home.DarkOverlay.Visible = false
        end)
        script.Parent.Home.Popup.Add.MouseButton1Click:Connect(function()
            UILib.SavedScripts:Add(script.Parent.Home.Popup.Title.TextBox.Text,
                script.Parent.Home.Popup.Source.TextBox.Text)
           	writescript(script.Parent.Home.Popup.Title.TextBox.Text, script.Parent.Home.Popup.Source.TextBox.Text)

            if (not isinternalfile("preventautoclose")) then
                script.Parent.Home.DarkOverlay.Visible = false
                script.Parent.Home.Popup.Visible = false
            end

        end)

        script.Parent.Home.Searchbar.Button.MouseButton1Click:Connect(function()
            UILib.SavedScripts:OpenPopup()
        end)

        script.Parent.Home.Searchbar.Input:GetPropertyChangedSignal("Text"):Connect(function()
            for i, v in pairs(script.Parent.Home.Holder:GetChildren()) do
                if v:IsA("ImageLabel") then
                    if string.find(string.lower(v.Title.Text), string.lower(script.Parent.Home.Searchbar.Input.Text)) then
                        v.Visible = true
                    else
                        v.Visible = false
                    end
                end
            end
            if script.Parent.Home.Searchbar.Input.Text == "" then
                for i, v in pairs(script.Parent.Home.Holder:GetChildren()) do
                    if v:IsA("ImageLabel") then
                        v.Visible = true
                    end
                end
            end
        end)

    end
    task.spawn(C_19c);

    local LOADER = {};

    local GuiService2 = game:GetService("GuiService")

    -- LOADERLoadingScreen
    LOADER["1"] = Instance.new("ScreenGui", gethui());
    LOADER["1"]["IgnoreGuiInset"] = true;
    LOADER["1"]["Enabled"] = false;
    LOADER["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
    LOADER["1"]["Name"] = [[LOADERLoadingScreen]];
    LOADER["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
    LOADER["1"]["ResetOnSpawn"] = false;

    -- LOADERLoadingScreen.DarkOverlay
    LOADER["2"] = Instance.new("Frame", LOADER["1"]);
    LOADER["2"]["ZIndex"] = -100;
    LOADER["2"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
    LOADER["2"]["BackgroundTransparency"] = 0.6600000262260437;
    LOADER["2"]["Size"] = UDim2.new(2, 0, 2, 0);
    LOADER["2"]["Position"] = UDim2.new(-1, 0, -1, 0);
    LOADER["2"]["Name"] = [[DarkOverlay]];

    -- LOADERLoadingScreen.MainFrame
    LOADER["3"] = Instance.new("ImageLabel", LOADER["1"]);
    LOADER["3"].BorderSizePixel = 0;
    LOADER["3"].ScaleType = Enum.ScaleType.Crop;
    LOADER["3"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    LOADER["3"].Image = getAsset"13387419794";
    LOADER["3"].LayoutOrder = 10;
    LOADER["3"].Size = UDim2.new(0.32863849401474, 0, 0.31259891390800476, 0);
    LOADER["3"].BorderColor3 = Color3.fromRGB(0, 0, 0);
    LOADER["3"].Name = "MainFrame";

    local DaIconSize = LOADER["3"].Size
    local ScreenCenterX = GuiService2:GetScreenResolution().X / 2
    local ScreenCenterY = GuiService2:GetScreenResolution().Y / 2

    local DaIconPositionX = ScreenCenterX - DaIconSize.X.Offset / 2
    local DaIconPositionY = ScreenCenterY - DaIconSize.Y.Offset / 2
    LOADER["3"].Position = UDim2.new(0, DaIconPositionX, 0, DaIconPositionY / 20)

    -- LOADERLoadingScreen.MainFrame.UICorner
    LOADER["4"] = Instance.new("UICorner", LOADER["3"]);
    LOADER["4"]["CornerRadius"] = UDim.new(0.07000000029802322, 0);

    -- LOADERLoadingScreen.MainFrame.Overlay
    LOADER["5"] = Instance.new("ImageLabel", LOADER["3"]);
    LOADER["5"]["BackgroundColor3"] = Color3.fromRGB(26, 27, 36);
    LOADER["5"]["Image"] = getAsset[[13387657138]];
    LOADER["5"]["LayoutOrder"] = 10;
    LOADER["5"]["Size"] = UDim2.new(1, 0, 1, 0);
    LOADER["5"]["Name"] = [[Overlay]];
    LOADER["5"]["BackgroundTransparency"] = 0.800000011920929;

    -- LOADERLoadingScreen.MainFrame.Overlay.UICorner
    LOADER["6"] = Instance.new("UICorner", LOADER["5"]);
    LOADER["6"]["CornerRadius"] = UDim.new(0.07000000029802322, 0);

    -- LOADERLoadingScreen.MainFrame.Overlay.Title
    LOADER["7"] = Instance.new("TextLabel", LOADER["5"]);
    LOADER["7"]["TextWrapped"] = true;
    LOADER["7"]["TextScaled"] = true;
    LOADER["7"]["BackgroundColor3"] = Color3.fromRGB(118, 192, 255);
    LOADER["7"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    LOADER["7"]["TextSize"] = 14;
    LOADER["7"]["TextColor3"] = Color3.fromRGB(203, 244, 255);
    LOADER["7"]["AnchorPoint"] = Vector2.new(0, 0.5);
    LOADER["7"]["Size"] = UDim2.new(0.6451469659805298, 0, 0.1418459564447403, 0);
    LOADER["7"]["Text"] = [[Please wait a while!]];
    LOADER["7"]["Name"] = [[Title]];
    LOADER["7"]["BackgroundTransparency"] = 1;
    LOADER["7"]["Position"] = UDim2.new(0.1773512363433838, 0, 0.4073548913002014, 0);

    -- LOADERLoadingScreen.MainFrame.Overlay.Desc
    LOADER["8"] = Instance.new("TextLabel", LOADER["5"]);
    LOADER["8"]["TextWrapped"] = true;
    LOADER["8"]["TextScaled"] = true;
    LOADER["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    LOADER["8"]["FontFace"] = Font.new(getAsset[[11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    LOADER["8"]["TextSize"] = 14;
    LOADER["8"]["TextColor3"] = Color3.fromRGB(199, 220, 255);
    LOADER["8"]["AnchorPoint"] = Vector2.new(0, 0.5);
    LOADER["8"]["Size"] = UDim2.new(0.8879498243331909, 0, 0.1277613639831543, 0);
    LOADER["8"]["Text"] = [[We are currently setting everything up for you]];
    LOADER["8"]["Name"] = [[Desc]];
    LOADER["8"]["BackgroundTransparency"] = 1;
    LOADER["8"]["Position"] = UDim2.new(0.06185942143201828, 0, 0.5393086075782776, 0);

    -- LOADERLoadingScreen.MainFrame.DropShadowHolder
    LOADER["9"] = Instance.new("Frame", LOADER["3"]);
    LOADER["9"]["ZIndex"] = 0;
    LOADER["9"]["BorderSizePixel"] = 0;
    LOADER["9"]["BackgroundTransparency"] = 1;
    LOADER["9"]["Size"] = UDim2.new(1, 0, 1, 0);
    LOADER["9"]["Name"] = [[DropShadowHolder]];

    -- LOADERLoadingScreen.MainFrame.DropShadowHolder.DropShadow
    LOADER["a"] = Instance.new("ImageLabel", LOADER["9"]);
    LOADER["a"]["ZIndex"] = 0;
    LOADER["a"]["BorderSizePixel"] = 0;
    LOADER["a"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
    LOADER["a"]["ScaleType"] = Enum.ScaleType.Slice;
    LOADER["a"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
    LOADER["a"]["ImageTransparency"] = 0.699999988079071;
    LOADER["a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    LOADER["a"]["Image"] = getAsset[[6014261993]];
    LOADER["a"]["Size"] = UDim2.new(1, 47, 1, 47);
    LOADER["a"]["Name"] = [[DropShadow]];
    LOADER["a"]["BackgroundTransparency"] = 1;
    LOADER["a"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

    -- LOADERLoadingScreen.MainFrame.UIAspectRatioConstraint
    LOADER["b"] = Instance.new("UIAspectRatioConstraint", LOADER["3"]);
    LOADER["b"]["AspectRatio"] = 1.8712739944458008;

    -- LOADERLoadingScreen.LoadingModule
    LOADER["c"] = Instance.new("ModuleScript", LOADER["1"]);
    LOADER["c"]["Name"] = [[LoadingModule]];

    -- Require LOADER wrapper
    local LOADER_REQUIRE = require;
    local LOADER_MODULES = {};
    local function require(Module)
        local ModuleState = LOADER_MODULES[Module];
        if ModuleState then
            if not ModuleState.Required then
                ModuleState.Required = true;
                ModuleState.Value = ModuleState.Closure();
            end
            return ModuleState.Value;
        end
        return LOADER_REQUIRE(Module);
    end

    LOADER_MODULES[LOADER["c"]] = {
        Closure = function()
            local script = LOADER["c"];
            local lib = {}

            local tweenserv = game:GetService("TweenService")
            local frame = script.Parent.MainFrame
            local DarkOverlay = script.Parent.DarkOverlay

            local isLoading = false
            local delayz = 0.6

            local function TextFadeLoop()
                local title = frame.Overlay.Title
                local desc = frame.Overlay.Desc

                local timeToFade = 1

                local titleStart = tweenserv:Create(title, TweenInfo.new(timeToFade, Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out), {
                    TextTransparency = 0.8
                })
                local titleEnd = tweenserv:Create(title, TweenInfo.new(timeToFade, Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out), {
                    TextTransparency = 0
                })

                local descStart = tweenserv:Create(desc, TweenInfo.new(timeToFade, Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out), {
                    TextTransparency = 0.8
                })
                local descEnd = tweenserv:Create(desc, TweenInfo.new(timeToFade, Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out), {
                    TextTransparency = 0
                })

                while isLoading == true do
                    titleStart:Play()
                    descStart:Play()
                    titleStart.Completed:Wait()
                    titleEnd:Play()
                    descEnd:Play()
                    titleEnd.Completed:Wait()
                end
            end

            function lib:Start()
                isLoading = true

                script.Parent.Enabled = true
                frame.Position = UDim2.new(0.336, 0, -0.372, 0)
                DarkOverlay.Transparency = 1

                local tw1 = tweenserv:Create(frame,
                    TweenInfo.new(delayz, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = UDim2.new(0.336, 0, 0.322, 0)
                    })
                local tw2 = tweenserv:Create(DarkOverlay,
                    TweenInfo.new(delayz, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Transparency = 0.66
                    })
                tw1:Play()
                tw2:Play()
                tw2.Completed:Wait()
                TextFadeLoop()
            end

            function lib:End()
                isLoading = false

                DarkOverlay.Transparency = 1

                local tw1 = tweenserv:Create(frame,
                    TweenInfo.new(delayz, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = UDim2.new(0.336, 0, -0.372, 0)
                    })
                local tw2 = tweenserv:Create(DarkOverlay,
                    TweenInfo.new(delayz, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Transparency = 1
                    })
                tw1:Play()
                tw2:Play()
            end

            return lib
        end
    }

    uienv().rLib = require(LOADER["c"])

    -- Create a coroutine to run the loading animation asynchronously
    coroutine.wrap(function()
        uienv().rLib:Start()
    end)()

    function checkkey()
	local keyless = getFlag("keyless");

	if keyless then
            GrantAccess()
	    return true
	end

        local key = "empty";

        if isinternalfile("delta_key") then
            key = readinternal("delta_key")
        elseif type(ZEMVAR_AUTH.getStoredLicenseKey()) == "string" then
            key = ZEMVAR_AUTH.getStoredLicenseKey()
        end

        if verifyKey(key) then
            GrantAccess()
            return true
        end

        -- Restart-safe resume: the claim may have completed while we were closed.
        local claimStatus, _claimErr = ZEMVAR_AUTH.resumePendingClaim()
        if claimStatus == "completed-allow" then
            GrantAccess()
            return true
        end

	return false
    end

    coroutine.wrap(function()
        local status, err = pcall(function()         
            local bool = checkkey()
            -- This is being ran when no saved key is found
            if not bool then
                -- print("no valid key")
                task.wait(1)
                uienv().rLib:End()
                DELTA["1"].Enabled = true
                StartUp()
            else
                DELTA["1"].Enabled = true
            end
        end)

        if not status then warn("Zemvar coroutine errored: " .. err) end
    end)()

    return DELTA["1"], require;
end)

if not status then
    warn("Zemvar failed to load: " .. res1)
else
    return res1, res2
end
