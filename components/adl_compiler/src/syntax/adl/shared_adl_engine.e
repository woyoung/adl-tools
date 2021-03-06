note
	component:   "openEHR ADL Tools"
	description: "[
			 Shared access to ARCHETYPE_PARSER.
			 ]"
	keywords:    "C wrapper"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.com>"
	copyright:   "Copyright (c) 2009 Ocean Informatics Pty Ltd"
	license:     "Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>"


class SHARED_ADL_ENGINE

feature {NONE} -- Implementation

	adl15_engine: attached ADL15_ENGINE
		once
			create Result.make
		end

end


