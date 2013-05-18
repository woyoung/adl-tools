note
	component:   "openEHR Reusable Libraries"
	description: "Test suite for object graph parse tree."
	keywords:    "test, parse, parsing, object graph"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2004 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"


class TS_DADL

inherit
	TEST_SUITE

create
	make

feature -- Initialisation

	make(arg:ANY)
	    do
	    end

feature -- Access

	title:STRING = "dADL test suite"

	test_cases: LINKED_LIST[TEST_CASE]
		local
			tc:TEST_CASE
		once
			create Result.make

			create {TC_DADL2_BASIC_TYPES} tc.make(Void) Result.extend(tc)
		--	create {TC_DADL1_SINGLE_ATTR} tc.make(Void) Result.extend(tc)
			create {TC_DADL2_SINGLE_ATTR} tc.make(Void) Result.extend(tc)
		--	create {TC_DADL1_MULTIPLE_ATTR} tc.make(Void) Result.extend(tc)
			create {TC_DADL2_MULTIPLE_ATTR} tc.make(Void) Result.extend(tc)
			create {TC_DADL2_NESTED_MULTIPLE_ATTR} tc.make(Void) Result.extend(tc)
			create {TC_DADL2_MULTIPLE_ATTR2} tc.make(Void) Result.extend(tc)
			create {TC_DADL2_TYPED} tc.make(Void) Result.extend(tc)
			create {TC_DADL2_TYPED_ANON} tc.make(Void) Result.extend(tc)
			create {TC_DADL2_EMPTY} tc.make(Void) Result.extend(tc)
			create {TC_DADL2_AS_OBJECT_SIMPLE} tc.make(Void) Result.extend(tc)
			create {TC_DADL_EMBEDDED_CADL} tc.make(Void) Result.extend(tc)
			create {TC_DADL2_TERM_CODE} tc.make(Void) Result.extend(tc)

			create {TC_DADL_LINE_BREAK} tc.make(Void) Result.extend(tc)
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
--| The Original Code is units_suite.e.
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