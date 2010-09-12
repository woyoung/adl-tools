note
	component:   "openEHR Project"
	description: "Structured error list with some useful facilities"
	keywords:    "ADL, archetype"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.com>"
	copyright:   "Copyright (c) 2010 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL$"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"


class ERROR_ACCUMULATOR

inherit
	ERROR_SEVERITY_TYPES

create
	make

feature -- Initialisation

	make
		do
			create list.make(0)
		end

feature -- Access

	list: attached ARRAYED_LIST[ERROR_DESCRIPTOR]
			-- error output of validator - things that must be corrected

	as_string: STRING
		do
			create Result.make(0)
			from list.start until list.off loop
				Result.append(list.item.as_string)
				list.forth
			end
		end

	last: attached ERROR_DESCRIPTOR
		do
			Result := list.last
		end

	error_codes: ARRAYED_LIST[STRING]
		do
			create Result.make(0)
			Result.compare_objects
			from list.start until list.off loop
				if list.item.severity = error_type_error then
					Result.extend(list.item.code)
				end
				list.forth
			end
		end

	warning_codes: ARRAYED_LIST[STRING]
		do
			create Result.make(0)
			Result.compare_objects
			from list.start until list.off loop
				if list.item.severity = error_type_warning then
					Result.extend(list.item.code)
				end
				list.forth
			end
		end

feature -- Status Report

	is_empty: BOOLEAN
		do
			Result := list.is_empty
		end

feature -- Modification

	extend(err_desc: attached ERROR_DESCRIPTOR)
		do
			list.extend(err_desc)
		end

	append(other: attached ERROR_ACCUMULATOR)
		do
			list.append(other.list)
		end

	wipe_out
		do
			list.wipe_out
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
--| The Original Code is error_accumulator.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2007
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