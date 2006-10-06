indexing
	component:   "openEHR Archetype Project"
	description: "node in ADL parse tree"
	keywords:    "test, ADL"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2003 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL$"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class C_ATTRIBUTE

inherit
	ARCHETYPE_CONSTRAINT
		redefine
			default_create, parent, representation
		end

creation
	make_single, make_multiple

feature -- Initialisation
	
	default_create is
			-- 
		do
			create children.make(0)
			set_existence(create {OE_INTERVAL[INTEGER]}.make_bounded(1,1, True, True))
		end
	
	make_single(a_name: STRING) is
			-- set attr name
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			default_create
			create representation.make(a_name, Current)
		ensure
			not is_multiple
		end

	make_multiple(a_name: STRING; a_cardinality: CARDINALITY) is
			-- set attr name & cardinality
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
			cardinality_exists: a_cardinality /= Void
		do
			default_create
			create representation.make(a_name, Current)
			set_cardinality(a_cardinality)
		ensure
			is_multiple
		end

feature -- Access

	rm_attribute_name: STRING is
			-- name of this attribute in reference model
		do
			Result := representation.node_id
		end

	existence: OE_INTERVAL[INTEGER]
	
	cardinality: CARDINALITY
		
	parent: C_COMPLEX_OBJECT
	
	children: ARRAYED_LIST [C_OBJECT]
	
	child_count: INTEGER is
			-- number of children; 0 if any_allowed is True
		do
			if not any_allowed then
				Result := children.count
			end
		end

feature -- Status Report

	is_relationship: BOOLEAN is
			-- (in the UML sense) - True if attribute target type is not a primitive data type
		local
			a_prim: C_PRIMITIVE_OBJECT
		do
			a_prim ?= children.first
			Result := a_prim = Void
		end
		
	is_multiple: BOOLEAN is
			-- True if this attribute has multiple cardinality
		do
			Result := cardinality /= Void
		end

	is_valid: BOOLEAN is
			-- report on validity
		do
			create invalid_reason.make(0)
			invalid_reason.append(rm_attribute_name + ": ")
			if not (any_allowed xor representation.has_children) then
				invalid_reason.append("must be either 'any' node or have child nodes")
			elseif existence = Void then
				invalid_reason.append("existence must be specified")
			else
				Result := True
				from 
					children.start
				until
					not Result or else children.off
				loop
					-- check occurrences consistent with attribute cardinality
					if Result and not is_multiple and children.item.occurrences.upper > 1 then
						Result := False
						invalid_reason.append("occurrences on child node " + children.item.node_id.out + 
							" must be singular for non-container attribute")		
					end
					
					if Result and not children.item.is_valid then
						Result := False
						invalid_reason.append("(invalid child node) " + children.item.invalid_reason + "%N")
					end

					children.forth
				end
			end
		end

	has_child_node (a_path_id: STRING): BOOLEAN is
			-- (from OG_NODE)
		require -- from OG_NODE
			path_id_valid: a_path_id /= void and then not a_path_id.is_empty
		do
			Result := representation.has_child_node (a_path_id)
		end
		
feature -- Modification

	set_existence(an_interval: OE_INTERVAL[INTEGER]) is
			-- set existence constraint on this relation - applies whether single or multiple
		require
			Interval_exists: an_interval /= Void
		do
			existence := an_interval
		end
		
	set_cardinality(a_cardinality: CARDINALITY) is
			-- 
		require
			cardinality_exists: a_cardinality /= Void
		do
			cardinality := a_cardinality
		end		

	put_child(an_obj: C_OBJECT) is
			-- put a new child node
		require
			Object_exists: an_obj /= Void
			Object_occurrences_valid: not is_multiple implies an_obj.occurrences.upper <= 1
			Object_id_valid: not (an_obj.is_addressable and has_child_node(an_obj.node_id))
		do
			representation.put_child(an_obj.representation)
			children.extend(an_obj)
			an_obj.set_parent(Current)
		end

feature -- Representation

	representation: OG_ATTRIBUTE_NODE

feature -- Serialisation

	enter_block(serialiser: CONSTRAINT_MODEL_SERIALISER; depth: INTEGER) is
			-- perform serialisation at start of block for this node
		do
			serialiser.start_c_attribute(Current, depth)
		end
		
	exit_block(serialiser: CONSTRAINT_MODEL_SERIALISER; depth: INTEGER) is
			-- perform serialisation at end of block for this node
		do
			serialiser.end_c_attribute(Current, depth)
		end
	
invariant
	Rm_attribute_name_valid: rm_attribute_name /= Void and then not rm_attribute_name.is_empty
	Existence_set: existence /= Void
	Children_validity: any_allowed xor children /= Void
	
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
--| The Original Code is cadl_rel_node.e.
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
