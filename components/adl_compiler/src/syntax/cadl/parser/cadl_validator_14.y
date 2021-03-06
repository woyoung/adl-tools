%{
note
	component:   "openEHR ADL Tools"
	description: "Parser for Archetype Description Language 1.4 (ADL)"
	keywords:	 "ADL, 1.4"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2003- Ocean Informatics Pty Ltd <http://www.oceaninfomatics.com>"
	license:     "Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>"

class CADL_VALIDATOR_14

inherit
	PARSER_VALIDATOR
		rename
			reset as validator_reset,
			make as make_parser_skeleton
		end

	CADL_SCANNER_14
		rename
			make as make_scanner
		redefine
			reset
		end

	C_COMMON

	ARCHETYPE_TERM_CODE_TOOLS
		export
			{NONE} all
		end

	OPERATOR_TYPES
		export
			{NONE} all
		end

	SHARED_ADL_APP_RESOURCES
		export
			{NONE} all
		end

	SHARED_C_FACTORY
		export
			{NONE} all
		end

	DATE_TIME_ROUTINES
		export
			{NONE} all
		end

	KL_SHARED_EXCEPTIONS
	KL_SHARED_ARGUMENTS

create
	make
%}

%token <STRING> V_ARCHETYPE_ID
%token <INTEGER> V_INTEGER 
%token <REAL> V_REAL 
%token <STRING> V_TYPE_IDENTIFIER V_GENERIC_TYPE_IDENTIFIER V_ATTRIBUTE_IDENTIFIER V_FEATURE_CALL_IDENTIFIER V_STRING
%token <STRING> V_LOCAL_CODE V_LOCAL_TERM_CODE_REF V_QUALIFIED_TERM_CODE_REF V_TERM_CODE_CONSTRAINT
%token <STRING> V_REGEXP
%token <STRING> V_ABS_PATH V_REL_PATH
%token <CHARACTER> V_CHARACTER
%token <STRING> V_URI
%token <STRING> V_ISO8601_EXTENDED_DATE V_ISO8601_EXTENDED_TIME V_ISO8601_EXTENDED_DATE_TIME V_ISO8601_DURATION
%token <STRING> V_ISO8601_DATE_TIME_CONSTRAINT_PATTERN V_ISO8601_TIME_CONSTRAINT_PATTERN
%token <STRING> V_ISO8601_DATE_CONSTRAINT_PATTERN V_ISO8601_DURATION_CONSTRAINT_PATTERN
%token <C_DOMAIN_TYPE> V_C_DOMAIN_TYPE

%token SYM_START_CBLOCK SYM_END_CBLOCK	-- constraint block

%token SYM_ANY -- used outside of parser & scanner

%token SYM_INTERVAL_DELIM
%token SYM_TRUE SYM_FALSE 
%token SYM_THEN SYM_ELSE

%token SYM_EXISTENCE SYM_OCCURRENCES SYM_CARDINALITY 
%token SYM_UNORDERED SYM_ORDERED SYM_UNIQUE SYM_ELLIPSIS SYM_LIST_CONTINUE
%token SYM_MATCHES SYM_USE_ARCHETYPE SYM_ALLOW_ARCHETYPE SYM_USE_NODE 
%token SYM_INCLUDE SYM_EXCLUDE
%token SYM_AFTER SYM_BEFORE SYM_CLOSED

%token ERR_CHARACTER ERR_STRING ERR_C_DOMAIN_TYPE ERR_TERM_CODE_CONSTRAINT ERR_V_QUALIFIED_TERM_CODE_REF ERR_V_ISO8601_DURATION

%left SYM_IMPLIES
%left SYM_OR SYM_XOR
%left SYM_AND
%left SYM_EXISTS SYM_FORALL SYM_NOT
%left '=' SYM_NE SYM_LT SYM_GT SYM_LE SYM_GE SYM_MATCHES
%left '+' '-'
%left '*' '/' SYM_DIV SYM_MODULO
%left UNARY_MINUS
%left '^'

%type <ARRAYED_LIST [ASSERTION]> assertions c_includes c_excludes
%type <ASSERTION> assertion

%type <C_ARCHETYPE_ROOT> c_archetype_root
%type <ARCHETYPE_INTERNAL_REF> archetype_internal_ref

%type <STRING> type_identifier
%type <SIBLING_ORDER> sibling_order
%type <MULTIPLICITY_INTERVAL> c_occurrences c_existence occurrence_spec existence_spec
%type <C_PRIMITIVE_OBJECT> c_primitive_object
%type <C_PRIMITIVE> c_primitive
%type <ARCHETYPE_SLOT> c_archetype_slot_id c_archetype_slot_head archetype_slot

%type <EXPR_ITEM> boolean_node
%type <EXPR_UNARY_OPERATOR> boolean_unop_expr
%type <EXPR_BINARY_OPERATOR> boolean_binop_expr arithmetic_relop_expr arithmetic_arith_binop_expr arch_outer_constraint_expr boolean_constraint_expr
%type <EXPR_LEAF> arithmetic_leaf boolean_leaf 
%type <EXPR_ITEM> arithmetic_node

%type <INTEGER> integer_value
%type <REAL> real_value
%type <BOOLEAN> boolean_value
%type <CHARACTER> character_value
%type <ISO8601_DATE> date_value
%type <ISO8601_DATE_TIME> date_time_value
%type <ISO8601_TIME> time_value
%type <ISO8601_DURATION> duration_value
%type <CODE_PHRASE> term_code
%type <STRING> any_identifier
%type <STRING> string_value
%type <URI> uri_value

%type <ARRAYED_LIST[STRING]> string_list_value string_list_value_continue
%type <ARRAYED_LIST[INTEGER]> integer_list_value
%type <ARRAYED_LIST[REAL]> real_list_value
%type <ARRAYED_LIST[CHARACTER_REF]> character_list_value
%type <ARRAYED_LIST[BOOLEAN_REF]> boolean_list_value
%type <ARRAYED_LIST[ISO8601_DATE]> date_list_value
%type <ARRAYED_LIST[ISO8601_TIME]> time_list_value
%type <ARRAYED_LIST[ISO8601_DATE_TIME]> date_time_list_value
%type <ARRAYED_LIST[ISO8601_DURATION]> duration_list_value
%type <ARRAYED_LIST[CODE_PHRASE]> term_code_list_value

%type <INTERVAL[INTEGER]> integer_interval_value
%type <INTERVAL[REAL]> real_interval_value
%type <INTERVAL[ISO8601_TIME]> time_interval_value
%type <INTERVAL[ISO8601_DATE]> date_interval_value
%type <INTERVAL[ISO8601_DATE_TIME]> date_time_interval_value
%type <INTERVAL[ISO8601_DURATION]> duration_interval_value

%type <STRING> arithmetic_binop_symbol
%type <STRING> relational_binop_symbol
%type <STRING> boolean_binop_symbol

%type <CARDINALITY> c_cardinality cardinality_range
%type <CONSTRAINT_REF> constraint_ref
%type <C_CODE_PHRASE> c_code_phrase
%type <C_DV_ORDINAL> c_ordinal
%type <ORDINAL> ordinal
%type <C_BOOLEAN> c_boolean
%type <C_STRING> c_string
%type <C_DATE_TIME> c_date_time
%type <C_DURATION> c_duration
%type <C_DATE> c_date
%type <C_TIME> c_time
%type <C_REAL> c_real
%type <C_INTEGER> c_integer

%%

input: c_complex_object
		{
			debug("ADL_parse")
				io.put_string("CADL definition parsed%N")
			end
			output := $1
			accept
		}
	| assertions
		{
			debug("ADL_parse")
				io.put_string("assertion definition parsed%N")
			end
			output := $1
			accept
		}
	| error
		{
			debug("ADL_parse")
				io.put_string("CADL definition NOT parsed%N")
			end
			abort
		}
	;

c_complex_object: c_complex_object_head SYM_MATCHES SYM_START_CBLOCK c_complex_object_body SYM_END_CBLOCK
		{ 
			debug("ADL_parse")
				io.put_string(indent + "POP OBJECT_NODE " + object_nodes.item.rm_type_name + " [id=" + object_nodes.item.node_id + "]%N") 
				indent.remove_tail(1)
			end
			$$ := object_nodes.item
			object_nodes.remove
		}
	| c_complex_object_head
		{
			-- ok in case where occurrences or node_id is being redefined in a specialised archetype or template
			if differential_syntax then
				debug("ADL_parse")
					io.put_string(indent + "POP OBJECT_NODE " + object_nodes.item.rm_type_name + " [id=" + object_nodes.item.node_id + "]%N") 
					indent.remove_tail(1)
				end
				$$ := object_nodes.item
				object_nodes.remove
			else
				abort_with_error (ec_VCOCDocc, <<complex_obj.rm_type_name, complex_obj.path>>)
			end
		}
	;

c_complex_object_head: c_complex_object_id c_occurrences 
		{
			if $2 /= Void then
				complex_obj.set_occurrences($2)
			end

			if rm_schema.has_class_definition (complex_obj.rm_type_name) then
				object_nodes.extend(complex_obj)
				debug("ADL_parse")
					io.put_string(indent + "PUSH create OBJECT_NODE " + complex_obj.rm_type_name + " [id=" + complex_obj.node_id + "] ")
					if $2 /= Void then
						io.put_string("; occurrences=(" + $2.as_string + ")") 
					end
					io.new_line
					indent.append("%T")
				end

				-- put it under current attribute, unless it is the root object, in which case it will be returned
				-- via the 'output' attribute of this parser
				if not c_attrs.is_empty then
					safe_put_c_attribute_child (c_attrs.item, complex_obj)
				end
			else
				abort_with_error (ec_VCORM, <<complex_obj.rm_type_name, complex_obj.path>>)
			end
		}
	;

c_complex_object_id: type_identifier
		{
			create complex_obj.make_anonymous($1)
		}
	| type_identifier V_LOCAL_TERM_CODE_REF
		{
			create complex_obj.make_identified($1, $2)
		}
	;

c_complex_object_body: c_any -- used to indicate that any value of a type is ok
		{
			debug("ADL_parse")
				io.put_string(indent + "OBJECT_NODE " + object_nodes.item.rm_type_name + 
					" [id=" + object_nodes.item.node_id + "] - any_allowed%N") 
			end
		}
	| c_attributes			
		{
		}
	| error
		{
			abort_with_error (ec_SCOAT, Void)
		}
	;



------------------------- node types -----------------------

c_object: c_complex_object 
		{
		}
	| c_archetype_root 
		{
			safe_put_c_attribute_child (c_attrs.item, $1)
		}
	| archetype_internal_ref 
		{
			safe_put_c_attribute_child (c_attrs.item, $1)
		}
	| archetype_slot
		{
			safe_put_c_attribute_child (c_attrs.item, $1)
		}
	| constraint_ref
		{
			safe_put_c_attribute_child (c_attrs.item, $1)
		}
	| c_code_phrase
		{
			safe_put_c_attribute_child (c_attrs.item, $1)
		}
	| c_ordinal 
		{
			safe_put_c_attribute_child (c_attrs.item, $1)
		}
	| c_primitive_object
		{
			safe_put_c_attribute_child (c_attrs.item, $1)
		}
	| V_C_DOMAIN_TYPE
		{
			safe_put_c_attribute_child (c_attrs.item, c_domain_type)
		}
	| ERR_C_DOMAIN_TYPE
		{
			abort_with_error (ec_SDINV, <<odin_parser_error.as_string>>)
		}
	| error		
		{
			abort_with_error (ec_SCCOG, Void)
		}
	;


--
-- The first two forms below correspond to source archetypes, which have no body under a C_ARCHETYPE_ROOT
-- A c_complex_object-like variant would be needed to parse fully flattened templates.
--
c_archetype_root: SYM_USE_ARCHETYPE type_identifier '[' V_ARCHETYPE_ID ']' c_occurrences 
		{
			if (create {ARCHETYPE_ID}).valid_id($4) then
				create $$.make_external_ref ($2, $4)
				if $6 /= Void then
					$$.set_occurrences($6)
				end
			end
		}
	| SYM_USE_ARCHETYPE type_identifier '[' V_LOCAL_CODE ',' V_ARCHETYPE_ID ']' c_occurrences
		{
			if (create {ARCHETYPE_ID}).valid_id($6) then
				create $$.make_slot_filler ($2, $6, $4)
				if $8 /= Void then
					$$.set_occurrences($8)
				end
			end
		}
	| SYM_USE_ARCHETYPE type_identifier error
		{
			abort_with_error (ec_SUAID, Void)
		}
	;

archetype_internal_ref: archetype_internal_ref_head c_occurrences V_ABS_PATH
		{
			create og_path.make_from_string ($3)
			if attached arch_internal_ref_node_id then
				create $$.make_identified (arch_internal_ref_rm_type_name, arch_internal_ref_node_id, $3)
			else
				create $$.make (arch_internal_ref_rm_type_name, $3)

				-- if the C_ATTRIBUTE above this node requires that this node has an identifier, then take it from the target path
				if c_attrs.item.candidate_child_requires_id ($$.rm_type_name) then
					-- default to the id from the target path
					if not og_path.last.object_id.is_empty then
						$$.set_node_id (og_path.last.object_id)
					else
						-- error will be generated when attempt is made to add this object to C_ATTRIBUTE
					end
				end

			end
			if attached $2 then
				$$.set_occurrences ($2)
			end

			debug("ADL_parse")
				io.put_string(indent + "create ARCHETYPE_INTERNAL_REF ")
				io.put_string ($$.rm_type_name) 
				if $$.is_addressable then
					io.put_string("[" + $$.node_id + "] ")
				else
					io.put_string(" ")
				end
				if $$.use_target_occurrences then
					io.put_string("occurrences=(use target) ")
				elseif $2 /= Void then
					io.put_string("occurrences=" + $$.occurrences.as_string + " ")
				end
				io.put_string (" => " + $$.target_path + "%N") 
				io.put_string (indent + "C_ATTR " + c_attrs.item.rm_attribute_name + " safe_put_c_attribute_child(ARCHETYPE_INTERNAL_REF)%N") 
			end
		}
	| SYM_USE_NODE type_identifier error 
		{
			abort_with_error (ec_SUNPA, Void)
		}
	;

archetype_internal_ref_head: SYM_USE_NODE type_identifier
		{
			arch_internal_ref_rm_type_name := $2
			arch_internal_ref_node_id := Void
		}
	| SYM_USE_NODE type_identifier V_LOCAL_TERM_CODE_REF
		{
			arch_internal_ref_rm_type_name := $2
			arch_internal_ref_node_id := $3
		}
	;

archetype_slot: c_archetype_slot_head SYM_MATCHES SYM_START_CBLOCK c_includes c_excludes SYM_END_CBLOCK
		{
			if attached $4 then
				$1.set_includes($4)
			end
			if attached $5 then
				$1.set_excludes($5)
			end

			debug("ADL_parse")
				indent.remove_tail(1)
			end
			$$ := $1
		}
	| c_archetype_slot_head -- if closed or occurrences = 0
		{
			if not ($1.is_closed or $1.is_prohibited) then
				abort_with_error (ec_VASMD, <<$1.rm_type_name, c_attrs.item.path>>)
			end
			$$ := $1
		}
	;

c_archetype_slot_head: c_archetype_slot_id c_occurrences 
		{
			if attached $2 then
				$1.set_occurrences($2)
			end

			debug("ADL_parse")
				io.put_string(indent + "create ARCHETYPE_SLOT " + $1.rm_type_name + " [id=" + $1.node_id + "]")
				if attached $2 then
					io.put_string("; occurrences=(" + $2.as_string + ")") 
				end
				io.new_line
				indent.append("%T")
			end
			$$ := $1
		}
	;

c_archetype_slot_id: SYM_ALLOW_ARCHETYPE type_identifier
		{
			create $$.make_anonymous($2)
		}
	| sibling_order SYM_ALLOW_ARCHETYPE type_identifier
		{
			if differential_syntax then
				create $$.make_anonymous($3)
				$$.set_sibling_order($1)
			else
				abort_with_error (ec_SDSF, Void)
			end
		}
	| SYM_ALLOW_ARCHETYPE type_identifier V_LOCAL_TERM_CODE_REF
		{
			create $$.make_identified($2, $3)
		}
	| sibling_order SYM_ALLOW_ARCHETYPE type_identifier V_LOCAL_TERM_CODE_REF
		{
			if differential_syntax then
				create $$.make_identified($3, $4)
				$$.set_sibling_order($1)
			else
				abort_with_error (ec_SDSF, Void)
			end
		}
	| SYM_ALLOW_ARCHETYPE type_identifier SYM_CLOSED
		{
			create $$.make_anonymous($2)
			$$.set_closed
		}
	| SYM_ALLOW_ARCHETYPE type_identifier V_LOCAL_TERM_CODE_REF SYM_CLOSED
		{
			create $$.make_identified($2, $3)
			$$.set_closed
		}
	| SYM_ALLOW_ARCHETYPE error
		{
			abort_with_error (ec_SUAS, Void)
		}
	;

c_primitive_object: c_primitive
		{
			create $$.make ($1)
		}
	;

c_primitive: c_integer 
		{
			debug("ADL_parse")
				io.put_string(indent + "C_INTEGER: " +  $1.as_string + "%N")
			end
			$$ := $1
		}
	| c_real
		{
			debug("ADL_parse")
				io.put_string(indent + "C_REAL: " +  $1.as_string + "%N")
			end
			$$ := $1
		}
	| c_date
		{
			debug("ADL_parse")
				io.put_string(indent + "C_DATE: " +  $1.as_string + "%N")
			end
			$$ := $1
		}
	| c_time
		{
			debug("ADL_parse")
				io.put_string(indent + "C_TIME: " +  $1.as_string + "%N")
			end
			$$ := $1
		}
	| c_date_time
		{
			debug("ADL_parse")
				io.put_string(indent + "C_DATE_TIME: " +  $1.as_string + "%N")
			end
			$$ := $1
		}
	| c_duration
		{
			debug("ADL_parse")
				io.put_string(indent + "C_DURATION: " +  $1.as_string + "%N")
			end
			$$ := $1
		}
	| c_string
		{
			debug("ADL_parse")
				io.put_string(indent + "C_STRING: " +  $1.as_string + "%N")
			end
			$$ := $1
		}
	| c_boolean
		{
			debug("ADL_parse")
				io.put_string(indent + "C_BOOLEAN: " +  $1.as_string + "%N")
			end
			$$ := $1
		}
	;

c_any: '*' 
		{
		}
	;

---------------- BODY - relationships ----------------

c_attributes: c_attribute			
		{
		}
	| c_attributes c_attribute		
		{
		}
	;

c_attribute: c_attr_head SYM_MATCHES SYM_START_CBLOCK c_attr_values SYM_END_CBLOCK	
		{
			debug("ADL_parse")
				io.put_string(indent + "POP ATTR_NODE " + c_attrs.item.rm_attribute_name + "%N") 
				indent.remove_tail(1)
			end
			c_attrs.remove
		}
	| c_attr_head -- ok if existence is being changed in specialised archetype
		{
			if differential_syntax then
				c_attrs.remove
			else
				abort_with_error (ec_SCAS, Void)
			end
		}
	| c_attr_head SYM_MATCHES SYM_START_CBLOCK error SYM_END_CBLOCK	
		{
			abort_with_error (ec_SCAS, Void)
		}
	;

c_attr_head: V_ATTRIBUTE_IDENTIFIER c_existence c_cardinality
		{
			rm_attribute_name := $1
			if not object_nodes.item.has_attribute(rm_attribute_name) then
				if rm_schema.has_property (object_nodes.item.rm_type_name, rm_attribute_name) then
					bmm_prop_def := rm_schema.property_definition (object_nodes.item.rm_type_name, rm_attribute_name)
					if bmm_prop_def.is_container then
						create attr_node.make_multiple(rm_attribute_name, $2, $3)
						c_attrs.put(attr_node)
						debug("ADL_parse")
							io.put_string(indent + "PUSH create ATTR_NODE " + rm_attribute_name + "; container = " + attr_node.is_multiple.out)
							if $2 /= Void then io.put_string(" existence={" + $2.as_string + "}") end
							if $3 /= Void then io.put_string("; cardinality=(" + $3.as_string + ")") end
							io.new_line
							io.put_string(indent + "OBJECT_NODE " + object_nodes.item.rm_type_name + " [id=" + object_nodes.item.node_id + "] put_attribute(REL)%N") 
							indent.append("%T")
						end
						object_nodes.item.put_attribute(attr_node)
					elseif $3 = Void then
						create attr_node.make_single(rm_attribute_name, $2)
						c_attrs.put(attr_node)
						debug("ADL_parse")
							io.put_string(indent + "PUSH create ATTR_NODE " + rm_attribute_name + "; container = " + attr_node.is_multiple.out) 
							if $2 /= Void then io.put_string(" existence={" + $2.as_string + "}") end
							if $3 /= Void then io.put_string("; cardinality=(" + $3.as_string + ")") end
							io.new_line
							io.put_string(indent + "OBJECT_NODE " + object_nodes.item.rm_type_name + " [id=" + object_nodes.item.node_id + "] put_attribute(REL)%N") 
							indent.append("%T")
						end
						object_nodes.item.put_attribute(attr_node)
					else -- error - cardinality stated, but on a non-container attribute
						abort_with_error (ec_VSAM2, <<rm_attribute_name>>)
					end
				else
					abort_with_error (ec_VCARM, <<rm_attribute_name, object_nodes.item.path, object_nodes.item.rm_type_name>>)
				end
			else
				abort_with_error (ec_VCATU, <<rm_attribute_name>>)
			end
		}
	;

c_attr_values: c_object
		{
		}
	| c_attr_values c_object
		{
		} 
	| c_any	-- to allow a property to have any value
		{
			debug("ADL_parse")
				io.put_string(indent + "ATTR_NODE " + attr_node.rm_attribute_name + "  - any_allowed%N") 
			end
		}
	;

c_includes: -- Empty
	| SYM_INCLUDE assertions
		{
			debug("include list")
				io.put_string(indent + "[---assertion expression---] %N")
			end
			$$ := $2
		}
	;

c_excludes: -- Empty
	| SYM_EXCLUDE assertions
		{
			debug("exclude list")
				io.put_string(indent + "[---assertion expression---] %N")
			end
			$$ := $2
		}
	;

----------------------------------------------------------
---------------------- ASSERTIONS ------------------------
----------------------------------------------------------

assertions: assertion
		{
			create $$.make(0)
			$$.extend ($1)
		}
	| assertions assertion
		{
			$1.extend ($2)
			$$ := $1
		}
	;

assertion: any_identifier ':' boolean_node
		{
			create $$.make ($3, $1)
		}
	| boolean_node
		{
			create $$.make ($1, Void)
		}
	-- 
	-- TODO: redesign path referencing mechanism for constraints on archetype
	-- elements outside the definition
	--
	| arch_outer_constraint_expr
		{
			create $$.make ($1, Void)
		}
	| any_identifier ':' error
		{
			abort_with_error (ec_SINVS, <<$1>>)
		}
	;

---------------------- expressions ---------------------

boolean_node: boolean_leaf
		{
			$$ := $1
		}
	| boolean_unop_expr
		{
			debug("ADL_invariant")
				io.put_string(indent + "boolean_node: REDUCE from boolean_unop_expr: [" + $1.as_string + "]%N") 
			end
			$$ := $1
		}
	| boolean_binop_expr
		{
			$$ := $1
		}
	| arithmetic_relop_expr
		{
			$$ := $1
		}
	| boolean_constraint_expr
		{
			debug("ADL_invariant")
				io.put_string(indent + "boolean_node: REDUCE from boolean_constraint_expr: [" + $1.as_string + "]%N") 
			end
			$$ := $1
		}
	| '(' boolean_node ')'
		{
			$$ := $2
		}
	;
		
--
-- the following form of expression has a relative path which is only allowed with Slot definitions.
-- The absolute path form is for assertions in the rules section
--
arch_outer_constraint_expr: V_REL_PATH SYM_MATCHES SYM_START_CBLOCK c_primitive SYM_END_CBLOCK
		{
			debug("ADL_invariant")
				io.put_string(indent + "arch_outer_constraint_expr: Archetype outer feature " + $1 + " matches {" + $4.as_string + "}%N") 
			end
			create $$.make(create {OPERATOR_KIND}.make(op_matches),
				create {EXPR_LEAF}.make_archetype_ref ($1),
				create {EXPR_LEAF}.make_constraint ($4))
		}
	;

boolean_constraint_expr: V_ABS_PATH SYM_MATCHES SYM_START_CBLOCK c_primitive SYM_END_CBLOCK
		{
			debug("ADL_invariant")
				io.put_string(indent + "boolean_constraint_expr:" + $1 + " matches {" + $4.as_string + "}%N") 
			end
			create $$.make(create {OPERATOR_KIND}.make(op_matches), 
				create {EXPR_LEAF}.make_archetype_definition_ref ($1),
				create {EXPR_LEAF}.make_constraint ($4))
		}
	| V_ABS_PATH SYM_MATCHES SYM_START_CBLOCK c_code_phrase SYM_END_CBLOCK
		{
			debug("ADL_invariant")
				io.put_string(indent + "boolean_constraint_expr:" + $1 + " matches {" + $4.as_string + "}%N") 
			end
			create $$.make (create {OPERATOR_KIND}.make (op_matches), 
				create {EXPR_LEAF}.make_archetype_definition_ref ($1),
				create {EXPR_LEAF}.make_coded_term ($4))
		}
	;

--
-- expressions with signature
--	OP BOOLEAN: BOOLEAN
--
boolean_unop_expr: SYM_EXISTS V_ABS_PATH
		{
			debug("ADL_invariant")
				io.put_string(indent + "boolean_unop_expr: exists " + $2 + "%N") 
			end
			create $$.make (create {OPERATOR_KIND}.make (op_exists), create {EXPR_LEAF}.make_archetype_definition_ref ($2))
		}
	| SYM_NOT V_ABS_PATH
		{
			debug("ADL_invariant")
				io.put_string(indent + "boolean_unop_expr: not " + $2 + "%N") 
			end
			create $$.make (create {OPERATOR_KIND}.make (op_not), create {EXPR_LEAF}.make_archetype_definition_ref ($2))
		}
	| SYM_NOT '(' boolean_node ')'
		{
			debug("ADL_invariant")
				io.put_string(indent + "boolean_unop_expr: not [(" + $3.as_string + ")] %N") 
			end
			create $$.make (create {OPERATOR_KIND}.make (op_not), $3)
		}
	| SYM_EXISTS error 
		{
			abort_with_error (ec_SEXPT, Void)
		}
	;

--
-- expressions with signature
--	BOOLEAN OP BOOLEAN: BOOLEAN
--
boolean_binop_expr: boolean_node boolean_binop_symbol boolean_node
		{
			debug("ADL_invariant")
				io.put_string(indent + "boolean_binop_expr: [" + $1.as_string + "] " + $2 + " [" + $3.as_string + "]%N") 
			end
			create $$.make (create {OPERATOR_KIND}.make (operator_ids_from_symbols.item ($2)), $1, $3)
		}
	;

boolean_binop_symbol: SYM_OR
		{
			$$ := operator_symbols.item (op_or)
		}
	| SYM_AND
		{
			$$ := operator_symbols.item (op_and)
		}
	| SYM_XOR
		{
			$$ := operator_symbols.item (op_xor)
		}
	| SYM_IMPLIES
		{
			$$ := operator_symbols.item (op_implies)
		}
	;

--
-- leaves with signature
--	BOOLEAN
--
boolean_leaf: SYM_TRUE
		{
			create $$.make_boolean (True)
		}
	| SYM_FALSE
		{
			create $$.make_boolean (False)
		}
	;

--
-- expressions with signature
--	ARITHMETIC OP ARITHMETIC: BOOLEAN
--
arithmetic_relop_expr: arithmetic_node relational_binop_symbol arithmetic_node
		{
			debug("ADL_invariant")
				io.put_string(indent + "arithmetic_relop_expr: [" + $1.as_string + "] " + $2 + " [" + $3.as_string + "]%N") 
			end
			create $$.make (create {OPERATOR_KIND}.make (operator_ids_from_symbols.item ($2)), $1, $3)
		}
	;

--
-- nodes with signature
--	ARITHMETIC
--
arithmetic_node: arithmetic_leaf
		{
			$$ := $1
		}
	| arithmetic_arith_binop_expr
		{
			$$ := $1
		}
	| '(' arithmetic_node ')'
		{
			debug("ADL_invariant")
				io.put_string (indent + "(expr) %N") 
			end
			$$ := $2
		}
	;

--
-- expressions with signature
--	ARITHMETIC OP ARITHMETIC: ARITHMETIC
--
arithmetic_arith_binop_expr: arithmetic_node arithmetic_binop_symbol arithmetic_node
		{
			debug("ADL_invariant")
				io.put_string(indent + "arithmetic_arith_binop_expr: [" + $1.as_string + "] " + $2 + " [" + $3.as_string + "]%N") 
			end
			create $$.make (create {OPERATOR_KIND}.make (operator_ids_from_symbols.item ($2)), $1, $3)
		}
	;

--
-- leaves with signature
--	ARITHMETIC
--
arithmetic_leaf:  integer_value
		{
			debug("ADL_invariant")
				io.put_string(indent + "arith_leaf - integer: " + $1.out + "%N") 
			end
			create $$.make_integer ($1)
		}
	| real_value
		{
			debug("ADL_invariant")
				io.put_string(indent + "arith_leaf - real: " + $1.out + "%N") 
			end
			create $$.make_real ($1)
		}
	| V_ABS_PATH
		{
			debug("ADL_invariant")
				io.put_string(indent + "arith_leaf - path: " + $1 + "%N") 
			end
			create $$.make_archetype_definition_ref ($1)
		}
	;

relational_binop_symbol: '='
		{
			$$ := operator_symbols.item (op_eq)
		}
	| SYM_NE
		{
			$$ := operator_symbols.item (op_ne)
		}
	| SYM_LE
		{
			$$ := operator_symbols.item (op_le)
		}
	| SYM_LT
		{
			$$ := operator_symbols.item (op_lt)
		}
	| SYM_GE
		{
			$$ := operator_symbols.item (op_ge)
		}
	| SYM_GT
		{
			$$ := operator_symbols.item (op_gt)
		}
	;

arithmetic_binop_symbol: '/'
		{
			$$ := operator_symbols.item (op_divide)
		}
	| '*'
		{
			$$ := operator_symbols.item (op_multiply)
		}
	| '+'
		{
			$$ := operator_symbols.item (op_plus)
		}
	| '-'
		{
			$$ := operator_symbols.item (op_minus)
		}
	| '^'
		{
			$$ := operator_symbols.item (op_exp)
		}
	;


---------------- existence, occurrences, cardinality ----------------

c_existence:  	-- empty is ok
	| SYM_EXISTENCE SYM_MATCHES SYM_START_CBLOCK existence_spec SYM_END_CBLOCK	
		{
			$$ := $4
		}
	;

existence_spec:  V_INTEGER -- can only be 0 or 1
		{
			if $1 = 0 then
				create $$.make_prohibited
			elseif $1 = 1 then
				create $$.make_mandatory
			else
				abort_with_error (ec_SEXLSG, Void)
			end
		}
	| V_INTEGER SYM_ELLIPSIS V_INTEGER -- can only be 0..0, 0..1, 1..1
		{
			if $1 = 0 then
				if $3 = 0 then
					create $$.make_point(0)
				elseif $3 = 1 then
					create $$.make_bounded (0, 1)
				else
					abort_with_error (ec_SEXLU1, Void)
				end
			elseif $1 = 1 then
				if $3 = 1 then
					create $$.make_point(1)
				else
					abort_with_error (ec_SEXLU2, Void)
				end
			else
				abort_with_error (ec_SEXLMG, Void)
			end
		}
	;

c_cardinality: -- empty is ok
	| SYM_CARDINALITY SYM_MATCHES SYM_START_CBLOCK cardinality_range SYM_END_CBLOCK	
		{
			$$ := $4
		}
	;

cardinality_range: occurrence_spec
		{
			create $$.make ($1)
		}
	| occurrence_spec ';' SYM_ORDERED
		{
			create $$.make ($1)
		}
	| occurrence_spec ';' SYM_UNORDERED
		{
			create $$.make ($1)
			$$.set_unordered
		}
	| occurrence_spec ';' SYM_UNIQUE
		{
			create $$.make ($1)
			$$.set_unique
		}
	| occurrence_spec ';' SYM_ORDERED ';' SYM_UNIQUE
		{
			create $$.make ($1)
			$$.set_unique
		}
	| occurrence_spec ';' SYM_UNORDERED ';' SYM_UNIQUE
		{
			create $$.make ($1)
			$$.set_unique
			$$.set_unordered
		}
	| occurrence_spec ';' SYM_UNIQUE ';' SYM_ORDERED
		{
			create $$.make ($1)
			$$.set_unique
		}
	| occurrence_spec ';' SYM_UNIQUE ';' SYM_UNORDERED
		{
			create $$.make ($1)
			$$.set_unique
			$$.set_unordered
		}
	;

c_occurrences:  -- empty is ok
	| SYM_OCCURRENCES SYM_MATCHES SYM_START_CBLOCK occurrence_spec SYM_END_CBLOCK	
		{
			$$ := $4
		}
	| SYM_OCCURRENCES error
		{
			abort_with_error (ec_SOCCF, Void)
		}
	;

occurrence_spec: integer_value
		{
			create $$.make_point ($1)
		}
	| '*'
		{
			create $$.make_upper_unbounded (0)
		}
	| V_INTEGER SYM_ELLIPSIS integer_value 
		{
			create $$.make_bounded ($1, $3)
		}
	| V_INTEGER SYM_ELLIPSIS '*' 
		{
			create $$.make_upper_unbounded ($1)
		}
	;

---------------------- leaf constraint types -----------------------

c_integer: integer_value
		{
			create $$.make_list (create {ARRAYED_LIST [INTEGER]}.make_from_array (<<$1>>))
		}
	| integer_list_value
		{
			create $$.make_list ($1)
		}
	| integer_interval_value
		{
			create $$.make_range ($1)
		}
	| c_integer ';' integer_value
		{
			if $1.valid_value ($3) then
				$1.set_assumed_value ($3)
				$$ := $1
			else
				abort_with_error (ec_VOBAV, <<$3.out>>)
			end
		}
	| c_integer ';' error
		{
			abort_with_error (ec_SCIAV, Void)
		}
	;

c_real: real_value
		{
			create $$.make_list (create {ARRAYED_LIST [REAL]}.make_from_array (<<$1>>))
		}
	| real_list_value
		{
			create $$.make_list ($1)
		}
	| real_interval_value
		{
			create $$.make_range ($1)
		}
	| c_real ';' real_value
		{
			if $1.valid_value ($3) then
				$1.set_assumed_value ($3)
				$$ := $1
			else
				abort_with_error (ec_VOBAV, <<$3.out>>)
			end
		}
	| c_real ';' error
		{
			abort_with_error (ec_SCRAV, Void)
		}
	;

c_date: V_ISO8601_DATE_CONSTRAINT_PATTERN
		{
			if valid_iso8601_date_constraint_pattern($1) then
				create $$.make_from_pattern($1)
			else
				create str.make(0)
				from valid_date_constraint_patterns.start until valid_date_constraint_patterns.off loop
					if not valid_date_constraint_patterns.isfirst then
						str.append(", ")
					end
					str.append(valid_date_constraint_patterns.item)
					valid_date_constraint_patterns.forth
				end
				abort_with_error (ec_SCDPT, <<str>>)
			end
		}
	| date_value
		{
			create $$.make_range (create {INTERVAL [ISO8601_DATE]}.make_point($1))
		}
	| date_interval_value
		{
			create $$.make_range ($1)
		}
	| c_date ';' date_value
		{
			if $1.valid_value ($3) then
				$1.set_assumed_value ($3)
				$$ := $1
			else
				abort_with_error (ec_VOBAV, <<$3.out>>)
			end
		}
	| c_date ';' error
		{
			abort_with_error (ec_SCDAV, Void)
		}
	;

c_time: V_ISO8601_TIME_CONSTRAINT_PATTERN
		{
			if valid_iso8601_time_constraint_pattern($1) then
				create $$.make_from_pattern($1)
			else
				create str.make(0)
				across valid_time_constraint_patterns as patterns_csr loop
					if patterns_csr.cursor_index > 1 then
						str.append(", ")
					end
					str.append (patterns_csr.item)
				end
				abort_with_error (ec_SCTPT, <<str>>)
			end
		}
	| time_value
		{
			create $$.make_range (create {INTERVAL [ISO8601_TIME]}.make_point($1))
		}
	| time_interval_value
		{
			create $$.make_range ($1)
		}
	| c_time ';' time_value
		{
			if $1.valid_value ($3) then
				$1.set_assumed_value ($3)
				$$ := $1
			else
				abort_with_error (ec_VOBAV, <<$3.out>>)
			end
		}
	| c_time ';' error
		{
			abort_with_error (ec_SCTAV, Void)
		}
	;

c_date_time: V_ISO8601_DATE_TIME_CONSTRAINT_PATTERN
		{
			if valid_iso8601_date_time_constraint_pattern ($1) then
				create $$.make_from_pattern($1)
			else
				create str.make (0)
				across valid_date_time_constraint_patterns as patterns_csr loop
					if patterns_csr.cursor_index > 1 then
						str.append(", ")
					end
					str.append (patterns_csr.item)
				end
				abort_with_error (ec_SCDTPT, <<str>>)
			end
		}
	| date_time_value
		{
			create $$.make_range (create {INTERVAL [ISO8601_DATE_TIME]}.make_point($1))
		}
	| date_time_interval_value
		{
			create $$.make_range ($1)
		}
	| c_date_time ';' date_time_value
		{
			if $1.valid_value($3) then
				$1.set_assumed_value($3)
				$$ := $1
			else
				abort_with_error (ec_VOBAV, <<$3.out>>)
			end
		}
	| c_date_time ';' error
		{
			abort_with_error (ec_SCDTAV, Void)
		}
	;

c_duration: V_ISO8601_DURATION_CONSTRAINT_PATTERN
		{
			if valid_iso8601_duration_constraint_pattern ($1) then
				create $$.make_from_pattern ($1)
			else
				abort_with_error (ec_SCDUPT, Void)
			end
		}
	| V_ISO8601_DURATION_CONSTRAINT_PATTERN '/' duration_interval_value
		{
			if valid_iso8601_duration_constraint_pattern ($1) then
				create $$.make_pattern_with_range ($1, $3)
			else
				abort_with_error (ec_SCDUPT, Void)
			end
		}
	| duration_value
		{
			create $$.make_range (create {INTERVAL [ISO8601_DURATION]}.make_point($1))
		}
	| duration_interval_value
		{
			create $$.make_range ($1)
		}
	| c_duration ';' duration_value
		{
			if $1.valid_value ($3) then
				$1.set_assumed_value ($3)
				$$ := $1
			else
				abort_with_error (ec_VOBAV, <<$3.out>>)
			end
		}
	| c_duration ';' error
		{
			abort_with_error (ec_SCDUAV, Void)
		}
	;

c_string: V_STRING 	-- single value, generates closed list
		{
			create $$.make_from_string_list (create {ARRAYED_LIST [STRING]}.make_from_array (<<$1>>))
		}
	| string_list_value
		{
			create $$.make_from_string_list ($1)
		}
	| string_list_value_continue
		{
			create $$.make_from_string_list ($1)
			$$.set_open
		}
	| V_REGEXP -- regular expression with "//" or "^^" delimiters
		{
			create $$.make_from_regexp ($1.substring (2, $1.count - 1), $1.item(1) = '/')
			if $$.regexp.is_equal ({C_STRING}.regexp_compile_error) then
				abort_with_error (ec_SCSRE, <<$1>>)
			end
		}
	| c_string ';' string_value
		{
			if $1.valid_value ($3) then
				$1.set_assumed_value ($3)
				$$ := $1
			else
				abort_with_error (ec_VOBAV, <<$3.out>>)
			end
		}
	| c_string ';' error
		{
			abort_with_error (ec_SCSAV, Void)
		}
	;

c_boolean: SYM_TRUE
		{
			create $$.make_true
		}
	| SYM_FALSE 
		{
			create $$.make_false
		}
	| SYM_TRUE ',' SYM_FALSE 
		{
			create $$.make_true_false
		}
	| SYM_FALSE ',' SYM_TRUE 
		{
			create $$.make_true_false
		}
	| c_boolean ';' boolean_value
		{
			if $1.valid_value ($3) then
				$1.set_assumed_value ($3)
			else
				abort_with_error (ec_VOBAV, <<$3.out>>)
			end
			$$ := $1
		}
	| c_boolean ';' error
		{
			abort_with_error (ec_SCBAV, Void)
		}
	;

c_ordinal: ordinal
		{
			create $$.default_create
			$$.add_item ($1)
		}
	| c_ordinal ',' ordinal
		{
			if $1.has_item ($3.value) then
				abort_with_error (ec_VCOV, <<$3.value.out>>)
			elseif $1.has_code_phrase ($3.symbol) then
				abort_with_error (ec_VCOC, <<$3.symbol.code_string>>)
			else
				$1.add_item ($3)
			end
			$$ := $1
		}
 	| c_ordinal ';' integer_value
 		{
			if $1.has_item ($3) then
				$1.set_assumed_value_from_integer ($3)
			else
				abort_with_error (ec_VOBAV, <<$3.out>>)
			end
			$$ := $1
 		}
 	| c_ordinal ';' error
 		{
			abort_with_error (ec_SCOAV, Void)
 		}
	;

ordinal: integer_value SYM_INTERVAL_DELIM V_QUALIFIED_TERM_CODE_REF
		{
			create $$.make ($1, create {CODE_PHRASE}.make_from_string ($3))
		}
	;

c_code_phrase: V_TERM_CODE_CONSTRAINT	-- e.g. "[local::at0040, at0041; at0040]"
		{
			create $$.default_create

			if $$.valid_pattern ($1) then
				$$.make_from_pattern ($1)
			else
				abort_with_error (ec_VOBAV, <<$$.fail_reason>>)
			end
		}
	| V_QUALIFIED_TERM_CODE_REF
		{
			create $$.make_from_pattern($1)
		}
	;
 
constraint_ref: V_LOCAL_TERM_CODE_REF	-- e.g. "ac0003"
		{
			create $$.make($1)
		}
	;

any_identifier: type_identifier
		{
			$$ := $1
		}
	| V_ATTRIBUTE_IDENTIFIER
		{
			$$ := $1
		}
	;
		
-----------------------------------------------------------------
----------------- TAKEN FROM ODIN_VALIDATOR.Y -------------------
-----------------        DO NOT MODIFY        -------------------
-----------------------------------------------------------------
---------------------- BASIC DATA VALUES -----------------------

type_identifier: '(' V_TYPE_IDENTIFIER ')'
		{
			$$ := $2
		}
	| '(' V_GENERIC_TYPE_IDENTIFIER ')'
		{
			$$ := $2
		}
	| V_TYPE_IDENTIFIER
		{
			$$ := $1
		}
	| V_GENERIC_TYPE_IDENTIFIER
		{
			$$ := $1
		}
	;

string_value: V_STRING
		{
			$$ := $1
		}
	;

string_list_value: V_STRING ',' V_STRING
		{
			create $$.make(0)
			$$.extend($1)
			$$.extend($3)
		}
	| string_list_value ',' V_STRING
		{
			$1.extend($3)
			$$ := $1
		}
	;

--
-- FIXME: the first one below only for badly formed lists with superfluous continue marks
--
string_list_value_continue: string_list_value ',' SYM_LIST_CONTINUE
		{
			$$ := $1
		}
	| V_STRING ',' SYM_LIST_CONTINUE
		{
			create $$.make (0)
			$$.extend ($1)
		}
	;

integer_value: V_INTEGER {
			$$ := $1
		}
	| '+' V_INTEGER {
			$$ := $2
		}
	| '-' V_INTEGER {
			$$ := - $2
		}
	;

integer_list_value: integer_value ',' integer_value
		{
			create $$.make(0)
			$$.extend($1)
			$$.extend($3)
		}
	| integer_list_value ',' integer_value
		{
			$1.extend($3)
			$$ := $1
		}
	| integer_value ',' SYM_LIST_CONTINUE
		{
			create $$.make(0)
			$$.extend($1)
		}
	;

integer_interval_value: SYM_INTERVAL_DELIM integer_value SYM_ELLIPSIS integer_value SYM_INTERVAL_DELIM
		{
			if $2 <= $4 then
				create $$.make_bounded ($2, $4, True, True)
			else
				abort_with_error (ec_VIVLO, <<$2.out, $4.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_GT integer_value SYM_ELLIPSIS integer_value SYM_INTERVAL_DELIM
		{
			if $3 <= $5 then
				create $$.make_bounded ($3, $5, False, True)
			else
				abort_with_error (ec_VIVLO, <<$3.out, $5.out>>)
			end
		}
	| SYM_INTERVAL_DELIM integer_value SYM_ELLIPSIS SYM_LT integer_value SYM_INTERVAL_DELIM
		{
			if $2 <= $5 then
				create $$.make_bounded ($2, $5, True, False)
			else
				abort_with_error (ec_VIVLO, <<$2.out, $5.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_GT integer_value SYM_ELLIPSIS SYM_LT integer_value SYM_INTERVAL_DELIM
		{
			if $3 <= $6 then
				create $$.make_bounded ($3, $6, False, False)
			else
				abort_with_error (ec_VIVLO, <<$3.out, $6.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_LT integer_value SYM_INTERVAL_DELIM
		{
			create $$.make_lower_unbounded ($3, False)
		}
	| SYM_INTERVAL_DELIM SYM_LE integer_value SYM_INTERVAL_DELIM
		{
			create $$.make_lower_unbounded ($3, True)
		}
	| SYM_INTERVAL_DELIM SYM_GT integer_value SYM_INTERVAL_DELIM
		{
			create $$.make_upper_unbounded ($3, False)
		}
	| SYM_INTERVAL_DELIM SYM_GE integer_value SYM_INTERVAL_DELIM
		{
			create $$.make_upper_unbounded ($3, True)
		}
	| SYM_INTERVAL_DELIM integer_value SYM_INTERVAL_DELIM
		{
			create $$.make_point($2)
		}
	;

real_value: V_REAL 
		{
			$$ := $1
		}
	| '+' V_REAL %prec UNARY_MINUS
		{
			$$ := $2
		}
	| '-' V_REAL %prec UNARY_MINUS
		{
			$$ := - $2
		}
	;

real_list_value: real_value ',' real_value
		{
			create $$.make(0)
			$$.extend($1)
			$$.extend($3)
		}
	| real_list_value ',' real_value
		{
			$1.extend($3)
			$$ := $1
		}
	| real_value ',' SYM_LIST_CONTINUE
		{
			create $$.make(0)
			$$.extend($1)
		}
	;

real_interval_value: SYM_INTERVAL_DELIM real_value SYM_ELLIPSIS real_value SYM_INTERVAL_DELIM
		{
			if $2 <= $4 then
				create $$.make_bounded ($2, $4, True, True)
			else
				abort_with_error (ec_VIVLO, <<$2.out, $4.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_GT real_value SYM_ELLIPSIS real_value SYM_INTERVAL_DELIM
		{
			if $3 <= $5 then
				create $$.make_bounded ($3, $5, False, True)
			else
				abort_with_error (ec_VIVLO, <<$3.out, $5.out>>)
			end
		}
	| SYM_INTERVAL_DELIM real_value SYM_ELLIPSIS SYM_LT real_value SYM_INTERVAL_DELIM
		{
			if $2 <= $5 then
				create $$.make_bounded ($2, $5, True, False)
			else
				abort_with_error (ec_VIVLO, <<$2.out, $5.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_GT real_value SYM_ELLIPSIS SYM_LT real_value SYM_INTERVAL_DELIM
		{
			if $3 <= $6 then
				create $$.make_bounded ($3, $6, False, False)
			else
				abort_with_error (ec_VIVLO, <<$3.out, $6.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_LT real_value SYM_INTERVAL_DELIM
		{
			create $$.make_lower_unbounded ($3, False)
		}
	| SYM_INTERVAL_DELIM SYM_LE real_value SYM_INTERVAL_DELIM
		{
			create $$.make_lower_unbounded ($3, True)
		}
	| SYM_INTERVAL_DELIM SYM_GT real_value SYM_INTERVAL_DELIM
		{
			create $$.make_upper_unbounded ($3, False)
		}
	| SYM_INTERVAL_DELIM SYM_GE real_value SYM_INTERVAL_DELIM
		{
			create $$.make_upper_unbounded ($3, True)
		}
	| SYM_INTERVAL_DELIM real_value SYM_INTERVAL_DELIM
		{
			create $$.make_point($2)
		}
	;

boolean_value: SYM_TRUE
		{
			$$ := True
		}
	| SYM_FALSE
		{
			$$ := False
		}
	;

boolean_list_value: boolean_value ',' boolean_value
		{
			create $$.make(0)
			$$.extend($1)
			$$.extend($3)
		}
	| boolean_list_value ',' boolean_value
		{
			$1.extend($3)
			$$ := $1
		}
	| boolean_value ',' SYM_LIST_CONTINUE
		{
			create $$.make(0)
			$$.extend($1)
		}
	;

character_value: V_CHARACTER
		{
			$$ := $1
		}
	;

character_list_value: character_value ',' character_value
		{
			create $$.make(0)
			$$.extend($1)
			$$.extend($3)
		}
	| character_list_value ',' character_value
		{
			$1.extend($3)
			$$ := $1
		}
	| character_value ',' SYM_LIST_CONTINUE
		{
			create $$.make(0)
			$$.extend($1)
		}
	;

date_value: V_ISO8601_EXTENDED_DATE -- in ISO8601 form yyyy-MM-dd
		{
			if valid_iso8601_date($1) then
				create $$.make_from_string($1)
			else
				abort_with_error (ec_VIDV, <<$1>>)
			end
		}
	;

date_list_value: date_value ',' date_value
		{
			create $$.make(0)
			$$.extend($1)
			$$.extend($3)
		}
	| date_list_value ',' date_value
		{
			$1.extend($3)
			$$ := $1
		}
	| date_value ',' SYM_LIST_CONTINUE
		{
			create $$.make(0)
			$$.extend($1)
		}
	;

date_interval_value: SYM_INTERVAL_DELIM date_value SYM_ELLIPSIS date_value SYM_INTERVAL_DELIM
		{
			if $2 <= $4 then
				create $$.make_bounded ($2, $4, True, True)
			else
				abort_with_error (ec_VIVLO, <<$2.out, $4.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_GT date_value SYM_ELLIPSIS date_value SYM_INTERVAL_DELIM
		{
			if $3 <= $5 then
				create $$.make_bounded ($3, $5, False, True)
			else
				abort_with_error (ec_VIVLO, <<$3.out, $5.out>>)
			end
		}
	| SYM_INTERVAL_DELIM date_value SYM_ELLIPSIS SYM_LT date_value SYM_INTERVAL_DELIM
		{
			if $2 <= $5 then
				create $$.make_bounded ($2, $5, True, False)
			else
				abort_with_error (ec_VIVLO, <<$2.out, $5.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_GT date_value SYM_ELLIPSIS SYM_LT date_value SYM_INTERVAL_DELIM
		{
			if $3 <= $6 then
				create $$.make_bounded ($3, $6, False, False)
			else
				abort_with_error (ec_VIVLO, <<$3.out, $6.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_LT date_value SYM_INTERVAL_DELIM
		{
			create $$.make_lower_unbounded ($3, False)
		}
	| SYM_INTERVAL_DELIM SYM_LE date_value SYM_INTERVAL_DELIM
		{
			create $$.make_lower_unbounded ($3, True)
		}
	| SYM_INTERVAL_DELIM SYM_GT date_value SYM_INTERVAL_DELIM
		{
			create $$.make_upper_unbounded ($3, False)
		}
	| SYM_INTERVAL_DELIM SYM_GE date_value SYM_INTERVAL_DELIM
		{
			create $$.make_upper_unbounded ($3, True)
		}
	| SYM_INTERVAL_DELIM date_value SYM_INTERVAL_DELIM
		{
			create $$.make_point($2)
		}
	;

time_value: V_ISO8601_EXTENDED_TIME
		{
			if valid_iso8601_time($1) then
				create $$.make_from_string($1)
			else
				abort_with_error (ec_VITV, <<$1>>)
			end
		}
	;

time_list_value: time_value ',' time_value
		{
			create $$.make(0)
			$$.extend($1)
			$$.extend($3)
		}
	| time_list_value ',' time_value
		{
			$1.extend($3)
			$$ := $1
		}
	| time_value ',' SYM_LIST_CONTINUE
		{
			create $$.make(0)
			$$.extend($1)
		}
	;

time_interval_value: SYM_INTERVAL_DELIM time_value SYM_ELLIPSIS time_value SYM_INTERVAL_DELIM
		{
			if $2 <= $4 then
				create $$.make_bounded ($2, $4, True, True)
			else
				abort_with_error (ec_VIVLO, <<$2.out, $4.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_GT time_value SYM_ELLIPSIS time_value SYM_INTERVAL_DELIM
		{
			if $3 <= $5 then
				create $$.make_bounded ($3, $5, False, True)
			else
				abort_with_error (ec_VIVLO, <<$3.out, $5.out>>)
			end
		}
	| SYM_INTERVAL_DELIM time_value SYM_ELLIPSIS SYM_LT time_value SYM_INTERVAL_DELIM
		{
			if $2 <= $5 then
				create $$.make_bounded ($2, $5, True, False)
			else
				abort_with_error (ec_VIVLO, <<$2.out, $5.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_GT time_value SYM_ELLIPSIS SYM_LT time_value SYM_INTERVAL_DELIM
		{
			if $3 <= $6 then
				create $$.make_bounded ($3, $6, False, False)
			else
				abort_with_error (ec_VIVLO, <<$3.out, $6.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_LT time_value SYM_INTERVAL_DELIM
		{
			create $$.make_lower_unbounded ($3, False)
		}
	| SYM_INTERVAL_DELIM SYM_LE time_value SYM_INTERVAL_DELIM
		{
			create $$.make_lower_unbounded ($3, True)
		}
	| SYM_INTERVAL_DELIM SYM_GT time_value SYM_INTERVAL_DELIM
		{
			create $$.make_upper_unbounded ($3, False)
		}
	| SYM_INTERVAL_DELIM SYM_GE time_value SYM_INTERVAL_DELIM
		{
			create $$.make_upper_unbounded ($3, True)
		}
	| SYM_INTERVAL_DELIM time_value SYM_INTERVAL_DELIM
		{
			create $$.make_point($2)
		}
	;

date_time_value: V_ISO8601_EXTENDED_DATE_TIME
		{
			if valid_iso8601_date_time($1) then
				create $$.make_from_string($1)
			else
				abort_with_error (ec_VIDTV, <<$1>>)
			end
		}
	;

date_time_list_value: date_time_value ',' date_time_value
		{
			create $$.make(0)
			$$.extend($1)
			$$.extend($3)
		}
	| date_time_list_value ',' date_time_value
		{
			$1.extend($3)
			$$ := $1
		}
	| date_time_value ',' SYM_LIST_CONTINUE
		{
			create $$.make(0)
			$$.extend($1)
		}
	;

date_time_interval_value: SYM_INTERVAL_DELIM date_time_value SYM_ELLIPSIS date_time_value  SYM_INTERVAL_DELIM
		{
			if $2 <= $4 then
				create $$.make_bounded ($2, $4, True, True)
			else
				abort_with_error (ec_VIVLO, <<$2.out, $4.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_GT date_time_value SYM_ELLIPSIS date_time_value SYM_INTERVAL_DELIM
		{
			if $3 <= $5 then
				create $$.make_bounded ($3, $5, False, True)
			else
				abort_with_error (ec_VIVLO, <<$3.out, $5.out>>)
			end
		}
	| SYM_INTERVAL_DELIM date_time_value SYM_ELLIPSIS SYM_LT date_time_value SYM_INTERVAL_DELIM
		{
			if $2 <= $5 then
				create $$.make_bounded ($2, $5, True, False)
			else
				abort_with_error (ec_VIVLO, <<$2.out, $5.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_GT date_time_value SYM_ELLIPSIS SYM_LT date_time_value SYM_INTERVAL_DELIM
		{
			if $3 <= $6 then
				create $$.make_bounded ($3, $6, False, False)
			else
				abort_with_error (ec_VIVLO, <<$3.out, $6.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_LT date_time_value SYM_INTERVAL_DELIM
		{
			create $$.make_lower_unbounded ($3, False)
		}
	| SYM_INTERVAL_DELIM SYM_LE date_time_value SYM_INTERVAL_DELIM
		{
			create $$.make_lower_unbounded ($3, True)
		}
	| SYM_INTERVAL_DELIM SYM_GT date_time_value SYM_INTERVAL_DELIM
		{
			create $$.make_upper_unbounded ($3, False)
		}
	| SYM_INTERVAL_DELIM SYM_GE date_time_value SYM_INTERVAL_DELIM
		{
			create $$.make_upper_unbounded ($3, True)
		}
	| SYM_INTERVAL_DELIM date_time_value SYM_INTERVAL_DELIM
		{
			create $$.make_point($2)
		}
	;

duration_value: V_ISO8601_DURATION
		{
			if valid_iso8601_duration($1) then
				create $$.make_from_string($1)
			else
				abort_with_error (ec_VIDUV, <<$1>>)
			end
		}
	;

duration_list_value: duration_value ',' duration_value
		{
			create $$.make(0)
			$$.extend($1)
			$$.extend($3)
		}
	| duration_list_value ',' duration_value
		{
			$1.extend($3)
			$$ := $1
		}
	| duration_value ',' SYM_LIST_CONTINUE
		{
			create $$.make(0)
			$$.extend($1)
		}
	;

duration_interval_value: SYM_INTERVAL_DELIM duration_value SYM_ELLIPSIS duration_value SYM_INTERVAL_DELIM
		{
			if $2 <= $4 then
				create $$.make_bounded ($2, $4, True, True)
			else
				abort_with_error (ec_VIVLO, <<$2.out, $4.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_GT duration_value SYM_ELLIPSIS duration_value SYM_INTERVAL_DELIM
		{
			if $3 <= $5 then
				create $$.make_bounded ($3, $5, False, True)
			else
				abort_with_error (ec_VIVLO, <<$3.out, $5.out>>)
			end
		}
	| SYM_INTERVAL_DELIM duration_value SYM_ELLIPSIS SYM_LT duration_value SYM_INTERVAL_DELIM
		{
			if $2 <= $5 then
				create $$.make_bounded ($2, $5, True, False)
			else
				abort_with_error (ec_VIVLO, <<$2.out, $5.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_GT duration_value SYM_ELLIPSIS SYM_LT duration_value SYM_INTERVAL_DELIM
		{
			if $3 <= $6 then
				create $$.make_bounded ($3, $6, False, False)
			else
				abort_with_error (ec_VIVLO, <<$3.out, $6.out>>)
			end
		}
	| SYM_INTERVAL_DELIM SYM_LT duration_value SYM_INTERVAL_DELIM
		{
			create $$.make_lower_unbounded ($3, False)
		}
	| SYM_INTERVAL_DELIM SYM_LE duration_value SYM_INTERVAL_DELIM
		{
			create $$.make_lower_unbounded ($3, True)
		}
	| SYM_INTERVAL_DELIM SYM_GT duration_value SYM_INTERVAL_DELIM
		{
			create $$.make_upper_unbounded ($3, False)
		}
	| SYM_INTERVAL_DELIM SYM_GE duration_value SYM_INTERVAL_DELIM
		{
			create $$.make_upper_unbounded ($3, True)
		}
	| SYM_INTERVAL_DELIM duration_value SYM_INTERVAL_DELIM
		{
			create $$.make_point($2)
		}
	;

term_code: V_QUALIFIED_TERM_CODE_REF
		{
			create $$.make_from_string($1)
		}
	| ERR_V_QUALIFIED_TERM_CODE_REF
		{
			abort_with_error (ec_STCV, <<$1>>)
		}
	;

term_code_list_value: term_code ',' term_code
		{
			create $$.make(0)
			$$.extend($1)
			$$.extend($3)
		}
	| term_code_list_value ',' term_code
		{
			$1.extend($3)
			$$ := $1
		}
	| term_code ',' SYM_LIST_CONTINUE
		{
			create $$.make(0)
			$$.extend($1)
		}
	;

uri_value: V_URI
		{
			create $$.make_from_string($1)
		}
	;

-----------------------------------------------------------------
------------- END TAKEN FROM ODIN_VALIDATOR.Y -------------------
-----------------------------------------------------------------

%%

feature -- Definitions

	Unbounded_value: INTEGER = -1

feature -- Initialization

	make
		do
			make_scanner
			make_parser_skeleton
			create object_nodes.make(0)
			create c_attrs.make(0)
			create time_vc
			create date_vc
		end

	reset
		do
			precursor
			validator_reset
			accept
		end

	execute (in_text:STRING; a_source_start_line: INTEGER; differential_flag: BOOLEAN; an_rm_schema: BMM_SCHEMA)
		do
			reset
			rm_schema := an_rm_schema
			source_start_line := a_source_start_line
			differential_syntax := differential_flag

			create indent.make_empty

			object_nodes.wipe_out
			c_attrs.wipe_out

			create time_vc
			create date_vc
	
			set_input_buffer (new_string_buffer (in_text))
			parse
		end

	error_loc: STRING
		do
			create Result.make_empty
			if attached {YY_FILE_BUFFER} input_buffer as f_buffer then
				Result.append (f_buffer.file.name + ", ")
			end
			Result.append ("line " + (in_lineno + source_start_line).out)
			Result.append(" [last token = " + token_name (last_token) + "]")
		end

feature -- Access

	differential_syntax: BOOLEAN
			-- True if the supplied text to parse is differential, in which case it can contain the 
			-- differential syntax variants, i.e. ordering markers and specialisation paths

feature {NONE} -- Implementation

	rm_schema: detachable BMM_SCHEMA

	safe_put_c_attribute_child (an_attr: C_ATTRIBUTE; an_obj: C_OBJECT)
			-- check child object for validity and then put as new child
		require
			Not_already_added: not an_attr.has_child(an_obj)
		do
			debug("ADL_parse")
				io.put_string(indent + "ATTR_NODE " + an_attr.rm_attribute_name + " put_child(" + 
						an_obj.generating_type + ": " + an_obj.rm_type_name + " [id=" + an_obj.node_id + "])%N") 
			end
			-- attach the object if it is either in the RM or if it is a built-in domain type like C_CODE_PHRASE
			-- This still might fail later on, because the domain type needs to have a wrapper in the RM
			if rm_schema.has_class_definition (an_obj.rm_type_name) or attached {C_DOMAIN_TYPE} an_obj then
				if check_c_attribute_child(an_attr, an_obj) then
					c_attrs.item.put_child(an_obj)
				end
			else
				abort_with_error (ec_VCORM, <<an_obj.rm_type_name, c_attrs.item.path>>)
			end
		end

	check_c_attribute_child (an_attr: C_ATTRIBUTE; an_obj: C_OBJECT): BOOLEAN
			-- check a new child node
			-- FIXME: the semantics here should be rationalised with C_ATTRIBUTE.valid_child and related functions
		local
			err_code: STRING
			ar: ARRAYED_LIST[STRING]
		do
			create ar.make (0)
			ar.extend (an_obj.generating_type) -- $1
			if an_obj.is_addressable then
				ar.extend ("node_id=" + an_obj.node_id) -- $2
			else
				ar.extend ("rm_type_name=" + an_obj.rm_type_name) -- $2
			end
			ar.extend(an_attr.rm_attribute_name) -- $3

			if an_attr.is_single then
				if an_obj.occurrences /= Void and then (an_obj.occurrences.upper_unbounded or an_obj.occurrences.upper > 1) then
					err_code := "VACSO"
				elseif an_obj.is_addressable and an_attr.has_child_with_id (an_obj.node_id) then
					err_code := "VACSI"
				elseif not an_obj.is_addressable and an_attr.has_child_with_rm_type_name (an_obj.rm_type_name) then
					err_code := "VACSIT"
				else
					Result := True
				end
			elseif an_attr.is_multiple then
				if not an_obj.is_addressable then
					err_code := "VACMI"
				elseif an_attr.has_child_with_id (an_obj.node_id) then
					err_code := "VACMM"
				elseif (an_attr.cardinality /= Void and then not an_attr.cardinality.interval.upper_unbounded) and 
						(an_obj.occurrences /= Void and then not an_obj.occurrences.upper_unbounded) and
						an_obj.occurrences.upper > an_attr.cardinality.interval.upper then
					err_code := "VACMCU"
					ar.extend (an_obj.occurrences.upper.out)
					ar.extend (an_attr.cardinality.interval.upper.out)
				else
					Result := True
				end
			end

			if not Result then
				abort_with_error (err_code, ar.to_array)
			end
		end

feature {NONE} -- Parse Tree

	object_nodes: ARRAYED_STACK [C_COMPLEX_OBJECT]
	complex_obj: C_COMPLEX_OBJECT

	c_attrs: ARRAYED_STACK [C_ATTRIBUTE]
			-- main stack of attributes during construction
		attribute
			create Result.make (0)
		end

	c_diff_attrs: ARRAYED_LIST [C_ATTRIBUTE]
			-- reference list of attributes with differential paths that require a special grafting process
		attribute
			create Result.make (0)
		end

	attr_node: detachable C_ATTRIBUTE

	rm_attribute_name: detachable STRING
	parent_path_str: detachable STRING

	invariant_expr: detachable STRING

	time_vc: TIME_VALIDITY_CHECKER
	date_vc: DATE_VALIDITY_CHECKER

	bmm_prop_def: detachable BMM_PROPERTY_DEFINITION

-------------- FOLLOWING TAKEN FROM ODIN_VALIDATOR.Y ---------------
feature {NONE} -- Implementation 

	arch_internal_ref_rm_type_name: detachable STRING
	arch_internal_ref_node_id: detachable STRING

	indent: STRING
		attribute
			create Result.make_empty
		end

	str: detachable STRING

	og_path: detachable OG_PATH

end
