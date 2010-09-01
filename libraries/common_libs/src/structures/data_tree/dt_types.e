note
	component:   "openEHR Archetype Project"
	description: "Type definitions for DT structures and coversion"
	keywords:    "Data Tree"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2005 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL$"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class DT_TYPES

inherit
	INTERNAL
		export
			{NONE} all
		end

feature {NONE} -- Definitions

	primitive_types: ARRAYED_LIST [INTEGER]
		once
			create Result.make (0)
			Result.compare_objects

			Result.extend (({NATURAL}).type_id)
			Result.extend (({NATURAL_8}).type_id)
			Result.extend (({NATURAL_16}).type_id)
			Result.extend (({NATURAL_32}).type_id)
			Result.extend (({NATURAL_64}).type_id)

			Result.extend (({INTEGER}).type_id)
			Result.extend (({INTEGER_8}).type_id)
			Result.extend (({INTEGER_16}).type_id)
			Result.extend (({INTEGER_32}).type_id)
			Result.extend (({INTEGER_64}).type_id)

			Result.extend (({REAL}).type_id)
			Result.extend (({REAL_32}).type_id)
			Result.extend (({REAL_64}).type_id)
			Result.extend (({DOUBLE}).type_id)

			Result.extend (({BOOLEAN}).type_id)

			Result.extend (({CHARACTER}).type_id)
			Result.extend (({CHARACTER_8}).type_id)
			Result.extend (({CHARACTER_32}).type_id)

			Result.extend (({STRING}).type_id)
			Result.extend (({STRING_8}).type_id)
			Result.extend (({STRING_32}).type_id)

			Result.extend (({DATE}).type_id)
			Result.extend (({DATE_TIME}).type_id)
			Result.extend (({TIME}).type_id)
			Result.extend (({DATE_TIME_DURATION}).type_id)

			Result.extend (({ISO8601_DATE}).type_id)
			Result.extend (({ISO8601_DATE_TIME}).type_id)
			Result.extend (({ISO8601_TIME}).type_id)
			Result.extend (({ISO8601_DURATION}).type_id)

			Result.extend (({CODE_PHRASE}).type_id)
			Result.extend (({URI}).type_id)
		end

	primitive_sequence_types: ARRAYED_LIST [INTEGER]
			-- the list of dynamic types of abstract types from cvt_table
			-- e.g. types like LIST[INTEGER] are there, but not LINKED_LIST[INTEGER]
		once
			Create Result.make (0)
			Result.compare_objects

			Result.extend (({SEQUENCE [NATURAL]}).type_id)
			Result.extend (({SEQUENCE [NATURAL_8]}).type_id)
			Result.extend (({SEQUENCE [NATURAL_16]}).type_id)
			Result.extend (({SEQUENCE [NATURAL_32]}).type_id)
			Result.extend (({SEQUENCE [NATURAL_64]}).type_id)

			Result.extend (({SEQUENCE [INTEGER]}).type_id)
			Result.extend (({SEQUENCE [INTEGER_8]}).type_id)
			Result.extend (({SEQUENCE [INTEGER_16]}).type_id)
			Result.extend (({SEQUENCE [INTEGER_32]}).type_id)
			Result.extend (({SEQUENCE [INTEGER_64]}).type_id)

			Result.extend (({SEQUENCE [REAL]}).type_id)
			Result.extend (({SEQUENCE [REAL_32]}).type_id)
			Result.extend (({SEQUENCE [REAL_64]}).type_id)
			Result.extend (({SEQUENCE [DOUBLE]}).type_id)

			Result.extend (({SEQUENCE [BOOLEAN]}).type_id)

			Result.extend (({SEQUENCE [CHARACTER]}).type_id)
			Result.extend (({SEQUENCE [CHARACTER_8]}).type_id)
			Result.extend (({SEQUENCE [CHARACTER_32]}).type_id)

			Result.extend (({SEQUENCE [STRING]}).type_id)
			Result.extend (({SEQUENCE [STRING_8]}).type_id)
			Result.extend (({SEQUENCE [STRING_32]}).type_id)

			Result.extend (({SEQUENCE [DATE]}).type_id)
			Result.extend (({SEQUENCE [DATE_TIME]}).type_id)
			Result.extend (({SEQUENCE [TIME]}).type_id)
			Result.extend (({SEQUENCE [DATE_TIME_DURATION]}).type_id)

			Result.extend (({SEQUENCE [ISO8601_DATE]}).type_id)
			Result.extend (({SEQUENCE [ISO8601_DATE_TIME]}).type_id)
			Result.extend (({SEQUENCE [ISO8601_TIME]}).type_id)
			Result.extend (({SEQUENCE [ISO8601_DURATION]}).type_id)

			Result.extend (({SEQUENCE [CODE_PHRASE]}).type_id)
			Result.extend (({SEQUENCE [URI]}).type_id)
		end

	primitive_interval_types: ARRAYED_LIST [INTEGER]
			-- the list of dynamic types of intervals of primitives
		once
			Create Result.make (0)
			Result.compare_objects

			Result.extend (({INTERVAL [NATURAL]}).type_id)
			Result.extend (({INTERVAL [NATURAL_8]}).type_id)
			Result.extend (({INTERVAL [NATURAL_16]}).type_id)
			Result.extend (({INTERVAL [NATURAL_32]}).type_id)
			Result.extend (({INTERVAL [NATURAL_64]}).type_id)

			Result.extend (({INTERVAL [INTEGER]}).type_id)
			Result.extend (({INTERVAL [INTEGER_8]}).type_id)
			Result.extend (({INTERVAL [INTEGER_16]}).type_id)
			Result.extend (({INTERVAL [INTEGER_32]}).type_id)
			Result.extend (({INTERVAL [INTEGER_64]}).type_id)

			Result.extend (({INTERVAL [REAL]}).type_id)
			Result.extend (({INTERVAL [REAL_32]}).type_id)
			Result.extend (({INTERVAL [REAL_64]}).type_id)
			Result.extend (({INTERVAL [DOUBLE]}).type_id)

			Result.extend (({INTERVAL [DATE]}).type_id)
			Result.extend (({INTERVAL [DATE_TIME]}).type_id)
			Result.extend (({INTERVAL [TIME]}).type_id)
			Result.extend (({INTERVAL [DATE_TIME_DURATION]}).type_id)

			Result.extend (({INTERVAL [ISO8601_DATE]}).type_id)
			Result.extend (({INTERVAL [ISO8601_DATE_TIME]}).type_id)
			Result.extend (({INTERVAL [ISO8601_TIME]}).type_id)
			Result.extend (({INTERVAL [ISO8601_DURATION]}).type_id)
		end

feature -- Access

	primitive_sequence_conforming_type(a_type_id: INTEGER): INTEGER
			-- Type which is the primitive_sequence type to which a_type_id conforms
			-- Returns 0 if not found
		require
			Type_valid: a_type_id >= 0
		do
			if type_conforms_to(a_type_id, sequence_any_type_id) then
				if primitive_sequence_conforming_types.has(a_type_id) then
					Result := primitive_sequence_conforming_types.item(a_type_id)
				else
					if primitive_sequence_types.has(a_type_id) then
						Result := a_type_id
					else
						from primitive_sequence_types.start until primitive_sequence_types.off or Result /= 0 loop
							debug ("DT")
								io.put_string(generator +
									".primitive_sequence_conforming_type: call to type_conforms_to(" +
									type_name_of_type(a_type_id) + ", " +
									type_name_of_type(primitive_sequence_types.item)
									+ "):")
							end
							if type_conforms_to(a_type_id, primitive_sequence_types.item) then
								Result := primitive_sequence_types.item
								debug ("DT")
									io.put_string(" True%N")
								end
							else
								debug ("DT")
									io.put_string(" False%N")
								end
							end
							primitive_sequence_types.forth
						end
					end
					if Result /= 0 then
						primitive_sequence_conforming_types.put(Result, a_type_id)
					end
				end
			end
		end

	any_primitive_conforming_type(a_type_id: INTEGER): INTEGER
			-- Returns a_type_id if in any of the primitive types which
			-- a_type_id, or
			-- one of the primitive_sequence types to which a_type_id conforms
			-- or 0 if not found
		require
			Type_valid: a_type_id >= 0
		do
			debug ("DT")
				io.put_string("--->ENTER any_primitive_conforming_type(" + a_type_id.out + ")%N")
			end
			if is_any_primitive_type(a_type_id) then
				Result := a_type_id
			elseif generic_count_of_type(a_type_id) > 0 then
				Result := primitive_sequence_conforming_type(a_type_id)
			end
			debug ("DT")
				io.put_string("<---EXIT any_primitive_conforming_type(" + a_type_id.out + ")=" + Result.out + "%N")
			end
		end

feature -- Status Report

	is_any_primitive_type(a_type_id: INTEGER): BOOLEAN
			-- True if a_type_id is any of the primitive, primitive_sequence or
			-- primitive_interval types
		require
			Type_valid: a_type_id >= 0
		do
			Result := is_primitive_type(a_type_id)
			if not Result and generic_count_of_type(a_type_id) > 0 then
				Result := primitive_sequence_types.has(a_type_id) or primitive_interval_types.has(a_type_id)
			end
		end

	is_any_primitive_conforming_type(a_type_id: INTEGER): BOOLEAN
			-- True if a_type_id is any of the primitive, primitive_sequence or
			-- primitive_interval types, or conforms to one of those
		require
			Type_valid: a_type_id >= 0
		do
			Result := any_primitive_conforming_type(a_type_id) /= 0
		end

	is_primitive_type(a_type_id: INTEGER): BOOLEAN
			-- True if one of the types STRING, INTEGER, REAL, BOOLEAN, CHARACTER,
			-- DATE, TIME, DATE_TIME, DATE_TIME_DURATION
		require
			Type_valid: a_type_id >= 0
		do
			Result := primitive_types.has(a_type_id)
		end

	is_primitive_sequence_type(a_type_id: INTEGER): BOOLEAN
			-- True if a_type_id conforms to SEQUENCE of STRING, INTEGER, REAL, BOOLEAN, CHARACTER,
			-- DATE, TIME, DATE_TIME, DATE_TIME_DURATION, CODE_PHRASE, URI
		require
			Type_valid: a_type_id >= 0
		do
			Result := primitive_sequence_types.has(a_type_id)
		end

	is_primitive_interval_type(a_type_id: INTEGER): BOOLEAN
			-- True if a_type_id conforms to INTERVAL of STRING, INTEGER, REAL, BOOLEAN, CHARACTER,
			-- DATE, TIME, DATE_TIME, DATE_TIME_DURATION, CODE_PHRASE, URI
		require
			Type_valid: a_type_id >= 0
		do
			Result := primitive_interval_types.has(a_type_id)
		end

	is_primitive_sequence_conforming_type(a_type_id: INTEGER): BOOLEAN
			-- True if a_type_id is either any of the primitive_sequence types, or else
			-- a type which conforms to one of those types
		require
			Type_valid: a_type_id >= 0
		do
			Result := primitive_sequence_conforming_type(a_type_id) /= 0
		end

	has_primitive_type(an_obj: ANY): BOOLEAN
			-- True if one of the types STRING, INTEGER, REAL, BOOLEAN, CHARACTER,
			-- DATE, TIME, DATE_TIME, DATE_TIME_DURATION
		require
			Object_valid: an_obj /= Void
		do
			Result := is_primitive_type(dynamic_type(an_obj))
		end

	has_primitive_sequence_type(an_obj: ANY): BOOLEAN
			-- True if an_obj conforms to SEQUENCE of STRING, INTEGER, REAL, BOOLEAN, CHARACTER,
			-- DATE, TIME, DATE_TIME, DATE_TIME_DURATION, CODE_PHRASE, URI
		require
			Object_valid: an_obj /= Void
		do
			Result := is_primitive_sequence_type(dynamic_type(an_obj))
		end

	has_primitive_interval_type(an_obj: ANY): BOOLEAN
			-- True if an_obj conforms to INTERVAL of STRING, INTEGER, REAL, BOOLEAN, CHARACTER,
			-- DATE, TIME, DATE_TIME, DATE_TIME_DURATION, CODE_PHRASE, URI
		require
			Object_valid: an_obj /= Void
		do
			Result := is_primitive_interval_type(dynamic_type(an_obj))
		end

	is_container_type(a_type_id: INTEGER): BOOLEAN
			-- True if a_type_id is of a type which is a SEQUENCE or HASH_TABLE, which are the only
			-- CONTAINERs used in DT structures
		do
			debug ("DT")
				io.put_string(generator +
					".is_container_type: call to type_conforms_to(" +
						type_name_of_type(a_type_id) + ", " +
						type_name_of_type(sequence_any_type_id) + "), type_conforms_to(" +
						type_name_of_type(a_type_id) + ", " +
						type_name_of_type(hash_table_any_hashable_type_id) + ")%N")
			end
			Result := type_conforms_to(a_type_id, sequence_any_type_id) or
				type_conforms_to(a_type_id, hash_table_any_hashable_type_id)
			debug ("DT")
				io.put_string("%T(return)%N")
			end
		end

feature {NONE} -- Implementation

	sequence_any_type_id: INTEGER
			-- dynamic type of SEQUENCE[ANY] in this system
		once
			Result := dynamic_type_from_string("SEQUENCE[ANY]")
		end

	interval_any_type_id: INTEGER
			-- dynamic type of INTERVAL [PART_COMPARABLE] in this system
		once
			Result := dynamic_type (create {INTERVAL [PART_COMPARABLE]}.default_create)
		end

	arrayed_list_any_type_id: INTEGER
			-- dynamic type of ARRAYED_LIST[ANY] in this system
		once
			Result := dynamic_type (create {ARRAYED_LIST[ANY]}.make(0))
		end

	hash_table_any_hashable_type_id: INTEGER
			-- dynamic type of HASH_TABLE[ANY, HASHABLE] in this system
		once
			Result := dynamic_type (create {HASH_TABLE [ANY, HASHABLE]}.make (0))
		end

	primitive_sequence_conforming_types: HASH_TABLE [INTEGER, INTEGER]
		once
			create Result.make(0)
		end

end


--|
--| ***** BEGIN LICENSE BLOCK *****
--| Version: MPL 1.1/GPL 2.0/LGPL 2.1
--|
--| The contents of this file are subject to the Mozilla Public License Version
--| 1.1 (the 'License'); you may not use this file except in compliance with
--| the License. You may obtain a copy of the License at
--| http://www.mozilla.org/MPL/
--|
--| Software distributed under the License is distributed on an 'AS IS' basis,
--| WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
--| for the specific language governing rights and limitations under the
--| License.
--|
--| The Original Code is dadl_factory.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2003-2004
--| the Initial Developer. All Rights Reserved.
--|
--| Contributor(s):
--|
--| Alternatively, the contents of this file may be used under the terms of
--| either the GNU General Public License Version 2 or later (the 'GPL'), or
--| the GNU Lesser General Public License Version 2.1 or later (the 'LGPL'),
--| in which case the provisions of the GPL or the LGPL are applicable instead
--| of those above. If you wish to allow use of your version of this file only
--| under the terms of either the GPL or the LGPL, and not to allow others to
--| use your version of this file under the terms of the MPL, indicate your
--| decision by deleting the provisions above and replace them with the notice
--| and other provisions required by the GPL or the LGPL. If you do not delete
--| the provisions above, a recipient may use your version of this file under
--| the terms of any one of the MPL, the GPL or the LGPL.
--|
--| ***** END LICENSE BLOCK *****
--|
