note
	component:   "openEHR Archetype Project"
	description: "Test case for archetype parse, simulating call from java"
	keywords:    "test, ADL, java"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2005 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"


class TC_JS_ARCHETYPE_PARSE

inherit
	TEST_CASE
		export
			{NONE} all
		end

	SHARED_TEST_ENV
		export
			{NONE} all
		end

create
	make

feature -- Initialisation

	make(arg:ANY)
	    do
	    end

feature -- Access

	title: STRING = "Test Archetype Create"

	infile: STRING
		once
			create Result.make(0)
			Result.append("openEHR-EHR-OBSERVATION.blood_pressure.v1.adl")
		end

	outfile: STRING
		once
			create Result.make(0)
			Result.append("openEHR-EHR-OBSERVATION.blood_pressure.v1.html")
		end

feature -- testing

	execute
		local
			c_status, c_infile, c_outfile, c_format: BASE_C_STRING
		do
			create c_infile.make (infile)
			create c_outfile.make (outfile)
			create c_format.make("html")
			c_adl_interface.open_adl_file(c_infile.item)

			create c_status.make_by_pointer (c_adl_interface.status)
			if c_adl_interface.archetype_source_loaded then
				io.put_string("Loaded " + infile + "; status: " + c_status.string + "%N")

				c_adl_interface.parse_archetype
				create c_status.make_by_pointer (c_adl_interface.status)
				if c_adl_interface.parse_succeeded then
					c_adl_interface.save_archetype(c_outfile.item, c_format.item)

					if c_adl_interface.save_succeeded then
						io.put_string("Saved to " + outfile + "%N")
					else
						create c_status.make_by_pointer (c_adl_interface.status)
						io.put_string("failed to serialise; status = " + c_status.string + "%N")
					end
				else
					io.put_string("failed to parse; status = " + c_status.string + "%N")
				end
			else
				io.put_string("Unable to load " + infile + " because of " + c_status.string + "%N")
			end
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
--| The Original Code is tc_archetype_create.e.
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