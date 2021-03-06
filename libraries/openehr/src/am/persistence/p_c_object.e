note
	component:   "openEHR ADL Tools"
	description: "Persistent form of C_OBJECT"
	keywords:    "persistence"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2011- Ocean Informatics Pty Ltd <http://www.oceaninfomatics.com>"
	license:     "Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>"

deferred class P_C_OBJECT

inherit
	P_ARCHETYPE_CONSTRAINT

	ARCHETYPE_DEFINITIONS
		export
			{NONE} all;
		end

feature -- Initialisation

	make (a_co: C_OBJECT)
		do
			rm_type_name := a_co.rm_type_name
			if a_co.is_addressable then
				node_id := a_co.node_id
			end
			if attached a_co.occurrences then
				occurrences := a_co.occurrences.as_string
			end
			sibling_order := a_co.sibling_order
		end

feature -- Access

	rm_type_name: STRING
			-- type name from reference model, of object to instantiate

	node_id: STRING
		attribute
			create Result.make_from_string (Anonymous_node_id)
		end

	occurrences: detachable STRING

	sibling_order: detachable SIBLING_ORDER
			-- set if this node should be ordered with respect to an inherited sibling; only settable
			-- on specialised nodes

feature -- Factory

	populate_c_instance (a_c_o: C_OBJECT)
			-- populate fields not already populated from creation of a C_XXX instance
		do
			a_c_o.set_node_id (node_id)
			if attached occurrences as occ then
				a_c_o.set_occurrences (create {MULTIPLICITY_INTERVAL}.make_from_string (occ))
			end
			if attached sibling_order as so then
				a_c_o.set_sibling_order (so)
			end
		end

end


