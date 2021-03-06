note
	component:   "openEHR ADL Tools"
	description: "[
				 Second order constraint representing a tuple form of a C_ATTRIBUTE.
				 ]"
	keywords:    "AOM, ADL"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2013- Ocean Informatics Pty Ltd <http://www.oceaninfomatics.com>"
	license:     "Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>"

class C_ATTRIBUTE_TUPLE

inherit
	C_2ND_ORDER
		redefine
			member_type
		end

create
	make

feature -- Access

	member_type: detachable C_ATTRIBUTE

	tuple_count: INTEGER
			-- number of actual tuples. determined by looking at first child of first C_ATTRIBUTE and
			-- obtaining its count
		do
			if not members.is_empty and then i_th_member (1).has_children and then
				attached {C_PRIMITIVE_OBJECT} i_th_member (1).children.first as cpo
			then
				Result := cpo.list_count
			end
		end

end


