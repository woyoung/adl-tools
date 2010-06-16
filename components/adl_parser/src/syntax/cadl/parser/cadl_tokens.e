note

	description: "Parser token codes"
	generator: "geyacc version 3.9"

class CADL_TOKENS

inherit

	YY_PARSER_TOKENS

feature -- Last values

	last_any_value: ANY
	last_string_value: STRING
	last_integer_value: INTEGER
	last_real_value: REAL
	last_character_value: CHARACTER
	last_c_domain_type_value: C_DOMAIN_TYPE

feature -- Access

	token_name (a_token: INTEGER): STRING
			-- Name of token `a_token'
		do
			inspect a_token
			when 0 then
				Result := "EOF token"
			when -1 then
				Result := "Error token"
			when V_ARCHETYPE_ID then
				Result := "V_ARCHETYPE_ID"
			when V_INTEGER then
				Result := "V_INTEGER"
			when V_REAL then
				Result := "V_REAL"
			when V_TYPE_IDENTIFIER then
				Result := "V_TYPE_IDENTIFIER"
			when V_GENERIC_TYPE_IDENTIFIER then
				Result := "V_GENERIC_TYPE_IDENTIFIER"
			when V_ATTRIBUTE_IDENTIFIER then
				Result := "V_ATTRIBUTE_IDENTIFIER"
			when V_FEATURE_CALL_IDENTIFIER then
				Result := "V_FEATURE_CALL_IDENTIFIER"
			when V_STRING then
				Result := "V_STRING"
			when V_LOCAL_CODE then
				Result := "V_LOCAL_CODE"
			when V_LOCAL_TERM_CODE_REF then
				Result := "V_LOCAL_TERM_CODE_REF"
			when V_QUALIFIED_TERM_CODE_REF then
				Result := "V_QUALIFIED_TERM_CODE_REF"
			when V_TERM_CODE_CONSTRAINT then
				Result := "V_TERM_CODE_CONSTRAINT"
			when V_REGEXP then
				Result := "V_REGEXP"
			when V_CHARACTER then
				Result := "V_CHARACTER"
			when V_URI then
				Result := "V_URI"
			when V_ISO8601_EXTENDED_DATE then
				Result := "V_ISO8601_EXTENDED_DATE"
			when V_ISO8601_EXTENDED_TIME then
				Result := "V_ISO8601_EXTENDED_TIME"
			when V_ISO8601_EXTENDED_DATE_TIME then
				Result := "V_ISO8601_EXTENDED_DATE_TIME"
			when V_ISO8601_DURATION then
				Result := "V_ISO8601_DURATION"
			when V_ISO8601_DATE_TIME_CONSTRAINT_PATTERN then
				Result := "V_ISO8601_DATE_TIME_CONSTRAINT_PATTERN"
			when V_ISO8601_TIME_CONSTRAINT_PATTERN then
				Result := "V_ISO8601_TIME_CONSTRAINT_PATTERN"
			when V_ISO8601_DATE_CONSTRAINT_PATTERN then
				Result := "V_ISO8601_DATE_CONSTRAINT_PATTERN"
			when V_ISO8601_DURATION_CONSTRAINT_PATTERN then
				Result := "V_ISO8601_DURATION_CONSTRAINT_PATTERN"
			when V_C_DOMAIN_TYPE then
				Result := "V_C_DOMAIN_TYPE"
			when SYM_START_CBLOCK then
				Result := "SYM_START_CBLOCK"
			when SYM_END_CBLOCK then
				Result := "SYM_END_CBLOCK"
			when SYM_ANY then
				Result := "SYM_ANY"
			when SYM_INTERVAL_DELIM then
				Result := "SYM_INTERVAL_DELIM"
			when SYM_TRUE then
				Result := "SYM_TRUE"
			when SYM_FALSE then
				Result := "SYM_FALSE"
			when SYM_GE then
				Result := "SYM_GE"
			when SYM_LE then
				Result := "SYM_LE"
			when SYM_NE then
				Result := "SYM_NE"
			when SYM_EXISTS then
				Result := "SYM_EXISTS"
			when SYM_FORALL then
				Result := "SYM_FORALL"
			when SYM_THEN then
				Result := "SYM_THEN"
			when SYM_ELSE then
				Result := "SYM_ELSE"
			when SYM_EXISTENCE then
				Result := "SYM_EXISTENCE"
			when SYM_OCCURRENCES then
				Result := "SYM_OCCURRENCES"
			when SYM_CARDINALITY then
				Result := "SYM_CARDINALITY"
			when SYM_UNORDERED then
				Result := "SYM_UNORDERED"
			when SYM_ORDERED then
				Result := "SYM_ORDERED"
			when SYM_UNIQUE then
				Result := "SYM_UNIQUE"
			when SYM_ELLIPSIS then
				Result := "SYM_ELLIPSIS"
			when SYM_INFINITY then
				Result := "SYM_INFINITY"
			when SYM_LIST_CONTINUE then
				Result := "SYM_LIST_CONTINUE"
			when SYM_INVARIANT then
				Result := "SYM_INVARIANT"
			when SYM_MATCHES then
				Result := "SYM_MATCHES"
			when SYM_USE_ARCHETYPE then
				Result := "SYM_USE_ARCHETYPE"
			when SYM_ALLOW_ARCHETYPE then
				Result := "SYM_ALLOW_ARCHETYPE"
			when SYM_USE_NODE then
				Result := "SYM_USE_NODE"
			when SYM_INCLUDE then
				Result := "SYM_INCLUDE"
			when SYM_EXCLUDE then
				Result := "SYM_EXCLUDE"
			when SYM_AFTER then
				Result := "SYM_AFTER"
			when SYM_BEFORE then
				Result := "SYM_BEFORE"
			when SYM_CLOSED then
				Result := "SYM_CLOSED"
			when SYM_DT_UNKNOWN then
				Result := "SYM_DT_UNKNOWN"
			when ERR_CHARACTER then
				Result := "ERR_CHARACTER"
			when ERR_STRING then
				Result := "ERR_STRING"
			when ERR_C_DOMAIN_TYPE then
				Result := "ERR_C_DOMAIN_TYPE"
			when ERR_TERM_CODE_CONSTRAINT then
				Result := "ERR_TERM_CODE_CONSTRAINT"
			when ERR_V_QUALIFIED_TERM_CODE_REF then
				Result := "ERR_V_QUALIFIED_TERM_CODE_REF"
			when ERR_V_ISO8601_DURATION then
				Result := "ERR_V_ISO8601_DURATION"
			when SYM_IMPLIES then
				Result := "SYM_IMPLIES"
			when SYM_OR then
				Result := "SYM_OR"
			when SYM_XOR then
				Result := "SYM_XOR"
			when SYM_AND then
				Result := "SYM_AND"
			when SYM_LT then
				Result := "SYM_LT"
			when SYM_GT then
				Result := "SYM_GT"
			when SYM_DIV then
				Result := "SYM_DIV"
			when SYM_MODULO then
				Result := "SYM_MODULO"
			when SYM_NOT then
				Result := "SYM_NOT"
			else
				Result := yy_character_token_name (a_token)
			end
		end

feature -- Token codes

	V_ARCHETYPE_ID: INTEGER = 258
	V_INTEGER: INTEGER = 259
	V_REAL: INTEGER = 260
	V_TYPE_IDENTIFIER: INTEGER = 261
	V_GENERIC_TYPE_IDENTIFIER: INTEGER = 262
	V_ATTRIBUTE_IDENTIFIER: INTEGER = 263
	V_FEATURE_CALL_IDENTIFIER: INTEGER = 264
	V_STRING: INTEGER = 265
	V_LOCAL_CODE: INTEGER = 266
	V_LOCAL_TERM_CODE_REF: INTEGER = 267
	V_QUALIFIED_TERM_CODE_REF: INTEGER = 268
	V_TERM_CODE_CONSTRAINT: INTEGER = 269
	V_REGEXP: INTEGER = 270
	V_CHARACTER: INTEGER = 271
	V_URI: INTEGER = 272
	V_ISO8601_EXTENDED_DATE: INTEGER = 273
	V_ISO8601_EXTENDED_TIME: INTEGER = 274
	V_ISO8601_EXTENDED_DATE_TIME: INTEGER = 275
	V_ISO8601_DURATION: INTEGER = 276
	V_ISO8601_DATE_TIME_CONSTRAINT_PATTERN: INTEGER = 277
	V_ISO8601_TIME_CONSTRAINT_PATTERN: INTEGER = 278
	V_ISO8601_DATE_CONSTRAINT_PATTERN: INTEGER = 279
	V_ISO8601_DURATION_CONSTRAINT_PATTERN: INTEGER = 280
	V_C_DOMAIN_TYPE: INTEGER = 281
	SYM_START_CBLOCK: INTEGER = 282
	SYM_END_CBLOCK: INTEGER = 283
	SYM_ANY: INTEGER = 284
	SYM_INTERVAL_DELIM: INTEGER = 285
	SYM_TRUE: INTEGER = 286
	SYM_FALSE: INTEGER = 287
	SYM_GE: INTEGER = 288
	SYM_LE: INTEGER = 289
	SYM_NE: INTEGER = 290
	SYM_EXISTS: INTEGER = 291
	SYM_FORALL: INTEGER = 292
	SYM_THEN: INTEGER = 293
	SYM_ELSE: INTEGER = 294
	SYM_EXISTENCE: INTEGER = 295
	SYM_OCCURRENCES: INTEGER = 296
	SYM_CARDINALITY: INTEGER = 297
	SYM_UNORDERED: INTEGER = 298
	SYM_ORDERED: INTEGER = 299
	SYM_UNIQUE: INTEGER = 300
	SYM_ELLIPSIS: INTEGER = 301
	SYM_INFINITY: INTEGER = 302
	SYM_LIST_CONTINUE: INTEGER = 303
	SYM_INVARIANT: INTEGER = 304
	SYM_MATCHES: INTEGER = 305
	SYM_USE_ARCHETYPE: INTEGER = 306
	SYM_ALLOW_ARCHETYPE: INTEGER = 307
	SYM_USE_NODE: INTEGER = 308
	SYM_INCLUDE: INTEGER = 309
	SYM_EXCLUDE: INTEGER = 310
	SYM_AFTER: INTEGER = 311
	SYM_BEFORE: INTEGER = 312
	SYM_CLOSED: INTEGER = 313
	SYM_DT_UNKNOWN: INTEGER = 314
	ERR_CHARACTER: INTEGER = 315
	ERR_STRING: INTEGER = 316
	ERR_C_DOMAIN_TYPE: INTEGER = 317
	ERR_TERM_CODE_CONSTRAINT: INTEGER = 318
	ERR_V_QUALIFIED_TERM_CODE_REF: INTEGER = 319
	ERR_V_ISO8601_DURATION: INTEGER = 320
	SYM_IMPLIES: INTEGER = 321
	SYM_OR: INTEGER = 322
	SYM_XOR: INTEGER = 323
	SYM_AND: INTEGER = 324
	SYM_LT: INTEGER = 325
	SYM_GT: INTEGER = 326
	SYM_DIV: INTEGER = 327
	SYM_MODULO: INTEGER = 328
	SYM_NOT: INTEGER = 329

end
