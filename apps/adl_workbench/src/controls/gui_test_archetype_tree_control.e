indexing
	component:   "openEHR Archetype Project"
	description: "Populate ontology controls in ADL test workbench"
	keywords:    "ADL"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2006 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL$"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"


class GUI_TEST_ARCHETYPE_TREE_CONTROL

inherit
	SHARED_ARCHETYPE_DIRECTORY
		export
			{NONE} all
		end

	SHARED_ARCHETYPE_COMPILER
		export
			{NONE} all
		undefine
			copy, default_create
		end

	SHARED_UI_RESOURCES
		export
			{NONE} all
		end

	ARCHETYPE_DEFINITIONS
		export
			{NONE} all
		end

	STRING_UTILITIES

create
	make

feature -- Definitions

	First_test_col: INTEGER is 3
			-- number of first column in grid to be used for test results

	Test_passed: INTEGER is 101

	Test_failed: INTEGER is 102

	Test_not_applicable: INTEGER is 103

	Test_unknown: INTEGER is 104

feature {NONE} -- Initialisation

	make (a_main_window: MAIN_WINDOW)
			-- create tree control repersenting archetype files found in repository_path
		require
			a_main_window /= Void
		do
			gui := a_main_window
			grid := gui.archetype_test_tree_grid
			grid.enable_tree
			grid.key_press_actions.extend (agent on_grid_key_press)
			grid.mouse_wheel_actions.extend (agent on_mouse_wheel)

			gui.archetype_test_go_bn.set_pixmap (pixmaps ["go"])
		end

feature -- Access

	selected_file_path: STRING
			-- full path of file selected from tree control

	has_selected_file: BOOLEAN
			-- True if a file was selected

	tests: DS_HASH_TABLE [FUNCTION [ANY, TUPLE [ARCHETYPE_REPOSITORY_ARCHETYPE], INTEGER], STRING] is
			-- table of test routines
		once
			create Result.make (5)
			Result.put (agent test_parse, "Parse")
			Result.put (agent test_save_html, "Save to HTML")
			Result.put (agent test_save_adl, "Save to ADL")
			Result.put (agent test_reparse, "Reparse")
			Result.put (agent test_diff, "Diff")
		end

	last_tested_archetypes_count: INTEGER
			-- number of archetypes tested in last run

feature -- Status Setting

	is_expanded: BOOLEAN
			-- True if archetype tree is in expanded state

	overwrite: BOOLEAN
			-- set to True if old files are to be overwritten by new files
			-- useful for upgrading ADL syntax in one go

	remove_unused_codes: BOOLEAN
			-- True means remove unused codes from every archetype	

	test_execution_underway: BOOLEAN
			-- True during a test run

	test_stop_requested: BOOLEAN
			-- user requested stop

feature -- Commands

	clear is
			-- wipe out content from controls
		do
			grid.wipe_out
			gui.test_status_area.remove_text
			has_selected_file := False
		end

	populate is
			-- populate the ADL tree control by creating it from scratch
		local
			gli: EV_GRID_LABEL_ITEM
			col_csr: INTEGER
		do
			clear
 			create grid_row_stack.make (0)

 			-- populate first column with archetype tree
			create gli.make_with_text ("Root")
			grid.set_item (1, 1, gli)
			add_checkbox (gli.row)
			gli.enable_select
			grid_row_stack.extend (gli.row)

 			archetype_directory.do_all (agent populate_gui_tree_node_enter, agent populate_gui_tree_node_exit)
			grid.column (1).set_title ("Archetype")

			-- put names on columns
			if grid.column_count >= first_test_col then
				from
					tests.start
					col_csr := first_test_col
				until
					tests.off
				loop
					grid.column (col_csr).set_title (tests.key_for_iteration)
					tests.forth
					col_csr := col_csr + 1
				end
			end

			is_expanded := False
			toggle_expand_tree
			grid.column (1).resize_to_content
			grid.column (2).resize_to_content

			gui.arch_test_processed_count.set_text ("0")
			gui.remove_unused_codes_rb.disable_select
			gui.overwrite_adl_rb.disable_select
		end

	item_select is
			-- do something when an item is selected
		local
			arch_item: ARCHETYPE_REPOSITORY_ARCHETYPE
		do
			arch_item ?= grid.selected_rows.first.data

			if arch_item /= Void then
				has_selected_file := True
				selected_file_path := arch_item.full_path
			end
		end

	archetype_test_go_stop is
			-- start or stop test run
		do
			if test_execution_underway then
				test_stop_requested := True
			else
				run_tests
			end
		end

	run_tests is
			-- execute tests on all marked archetypes
		local
			arch_item: ARCHETYPE_REPOSITORY_ARCHETYPE
			row_csr, col_csr: INTEGER
			gr: EV_GRID_ROW
			gli: EV_GRID_LABEL_ITEM
			res_label: STRING
			checked: BOOLEAN
			test_result: INTEGER
		do
			test_execution_underway := True
			test_stop_requested := False
			set_archetype_test_go_bn_icon
			overwrite := gui.overwrite_adl_rb.is_selected
			remove_unused_codes := gui.remove_unused_codes_rb.is_selected

			from
				row_csr := 1
				last_tested_archetypes_count := 0
			until
				row_csr > grid.row_count or test_stop_requested
			loop
				gr := grid.row (row_csr)
				arch_item ?= gr.item (1).data
				checked ?= gr.item (2).data

				if arch_item /= Void and checked then
					gr.ensure_visible
					gui.parent_app.process_events
					archetype_compiler.reset

					from
						tests.start
						col_csr := First_test_col
						test_result := Test_unknown
					until
						tests.off or test_result = Test_failed
					loop
						gr.set_item (col_csr, create {EV_GRID_LABEL_ITEM}.make_with_text ("processing..."))
						gui.parent_app.process_events

						create test_status.make_empty

						test_result := tests.item_for_iteration.item ([arch_item])

						inspect test_result
						when Test_passed then
							res_label := "test_passed"
						when Test_failed then
							res_label := "test_failed"
						when Test_not_applicable then
							res_label := "test_not_applicable"
						else

						end

						create gli.make_with_text ("")
						gli.set_pixmap (pixmaps [res_label])
						gr.set_item (col_csr, gli)

						if not test_status.is_empty then
							gui.test_status_area.append_text ("--------------- " + arch_item.id.as_string + " -----------------%N" + test_status)
						end

						gui.parent_app.process_events

						tests.forth
						col_csr := col_csr + 1
					end

					last_tested_archetypes_count := last_tested_archetypes_count + 1
					gui.arch_test_processed_count.set_text (last_tested_archetypes_count.out)
					gui.parent_app.process_events
				end

				set_checkbox (gr.item (2), False)
				row_csr := row_csr + 1
			end

			gui.test_status_area.append_text ("****** Executed tests on " + last_tested_archetypes_count.out + " Archetypes ******%N")
			test_execution_underway := False
			set_archetype_test_go_bn_icon
		end

	toggle_expand_tree is
			-- toggle expanded status of tree view
		do
			if is_expanded then
				collapse_tree (grid.row (1))
				gui.arch_test_tree_toggle_expand_bn.set_text ("Expand Tree")
				is_expanded := False
			else
				expand_tree (grid.row (1))
				gui.arch_test_tree_toggle_expand_bn.set_text ("Collapse Tree")
				is_expanded := True
			end
		end

feature -- Tests

	test_parse (ara: ARCHETYPE_REPOSITORY_ARCHETYPE): INTEGER is
			-- parse archetype and return result
		local
			unused_at_codes, unused_ac_codes: ARRAYED_LIST [STRING]
		do
			Result := Test_failed
			archetype_compiler.set_target (ara)

			archetype_compiler.parse_archetype

			if archetype_compiler.parse_succeeded then
				Result := Test_passed

				if remove_unused_codes then
					unused_at_codes := ara.archetype.ontology_unused_term_codes
					unused_ac_codes := ara.archetype.ontology_unused_constraint_codes

					if not unused_at_codes.is_empty or not unused_ac_codes.is_empty then
						test_status.append(">>>>>>>>>> removing unused codes%N")

						if not unused_at_codes.is_empty then
							test_status.append("Unused AT codes: " + display_arrayed_list (unused_at_codes) + "%N")
						end

						if not unused_ac_codes.is_empty then
							test_status.append("Unused AC codes: " + display_arrayed_list (unused_ac_codes) + "%N")
						end

						ara.archetype.ontology_remove_unused_codes
					end
				end
			else
				test_status.append(ara.id.as_string + " parse failed%N")
			end
		end

	test_save_html (ara: ARCHETYPE_REPOSITORY_ARCHETYPE): INTEGER is
			-- parse archetype and return result
		local
			html_fname: STRING
		do
			Result := Test_failed

			if archetype_compiler.parse_succeeded then
				-- FIXME: Sam doesn't want the html files to go in the same place as the adl files anymore
				-- now they should go in the path html/adl, where html is a sibling directory of the main
				-- 'adl' directory in the repository path; 'html/adl' means "the ADL form of HTML", since
				-- there are other things in the html directory.
				html_fname := ara.full_path.twin
				html_fname.replace_substring(".html", html_fname.count - Archetype_file_extension.count, html_fname.count)
				archetype_compiler.save_archetype_as(html_fname, "html")

				if archetype_compiler.save_succeeded then
					Result := Test_passed
				else
					test_status.append (archetype_compiler.status + "%N")
				end
			end
		end

	test_save_adl (ara: ARCHETYPE_REPOSITORY_ARCHETYPE): INTEGER is
			-- parse archetype and return result
		local
			new_adl_file_path: STRING
		do
			Result := Test_failed

			if archetype_compiler.parse_succeeded then
				if overwrite then
					archetype_compiler.save_archetype
				else
					new_adl_file_path := system_temp_file_directory + ara.archetype_file_name
					archetype_compiler.save_archetype_as(new_adl_file_path, "adl")
				end

				if archetype_compiler.save_succeeded then
					Result := Test_passed
				else
					test_status.append (archetype_compiler.status + "%N")
				end
			else
				Result := Test_not_applicable
			end
		end

	test_reparse (ara: ARCHETYPE_REPOSITORY_ARCHETYPE): INTEGER is
			-- parse archetype and return result
		local
			new_adl_file_path: STRING
		do
			Result := Test_failed

			if overwrite then
				new_adl_file_path := ara.full_path
			else
				new_adl_file_path := system_temp_file_directory + ara.archetype_file_name
			end

			-- FIXME: these are the right paths, but we don't yet have a way of overriding the source
			-- of an archetype from what is in its file
			-- DO SOMETHING HERE

			archetype_compiler.parse_archetype

			if archetype_compiler.parse_succeeded then
				Result := Test_passed
			else
				test_status.append ("Parse failed; reason: " + archetype_compiler.status + "%N")
			end
		end

	test_diff (ara: ARCHETYPE_REPOSITORY_ARCHETYPE): INTEGER is
			-- parse archetype and return result
		local
			new_adl_file_path: STRING
			orig_arch_source, new_arch_source: STRING
		do
			Result := Test_failed

			if not overwrite then
				orig_arch_source := ara.source

				new_adl_file_path := system_temp_file_directory + ara.archetype_file_name
				-- FIXME: DO SOMETIHNG HERE TO OPEN THE NEW FILE
				-- new_arch_source := adl_interface.adl_engine.source

				if orig_arch_source.count = new_arch_source.count then
					if orig_arch_source.is_equal (new_arch_source) then
						Result := Test_passed
					else
						test_status.append ("Archetype source lengths same but texts differ%N")
					end
				else
					test_status.append ("Archetype source lengths differ: original =  " + orig_arch_source.count.out +
						"; new = " + new_arch_source.count.out + "%N")
				end
			else
				Result := Test_not_applicable
			end
		end

feature {NONE} -- Implementation

	gui: MAIN_WINDOW
			-- main window of system

	grid: EV_GRID
			-- reference to MAIN_WINDOW.archetype_test_tree_grid

	grid_row_stack: ARRAYED_STACK [EV_GRID_ROW]
			-- Stack used during `populate_gui_tree_node_enter'.

	test_status: STRING
			-- Cumulative status message during running of test.

   	populate_gui_tree_node_enter (an_item: ARCHETYPE_REPOSITORY_ITEM) is
   			-- Add a node representing `an_item' to `gui_file_tree'.
		require
			an_item /= Void
   		local
			gli: EV_GRID_LABEL_ITEM
   			ada: ARCHETYPE_REPOSITORY_ARCHETYPE
   			adf: ARCHETYPE_REPOSITORY_FOLDER
   			gr: EV_GRID_ROW
 			col_csr: INTEGER
  		do
  			-- add a new row to the current item in the grid row stack
 			grid_row_stack.item.insert_subrow (grid_row_stack.item.subrow_count + 1)

 			-- now get a ref to the newly added subrow
			gr := grid_row_stack.item.subrow (grid_row_stack.item.subrow_count)
			add_checkbox (gr)

  			adf ?= an_item

			if adf /= Void then
				-- First column (explorer)
 				create gli.make_with_text (utf8 (adf.base_name))
				gli.set_pixmap (pixmaps ["file_folder_" + adf.group_id.out])
				gli.set_data (adf)
				gr.set_item (1, gli)
			else
				ada ?= an_item

				if ada /= Void then
					-- First column (explorer)
					create gli.make_with_text (utf8 (ada.id.domain_concept_tail + "(" + ada.id.version_id + ")"))
					gli.set_data (ada)

					if ada.id.is_specialised then
						gli.set_pixmap (pixmaps ["archetype_specialised_" + ada.group_id.out])
					else
						gli.set_pixmap (pixmaps ["archetype_" + ada.group_id.out])
					end

					gr.set_item (1, gli)

					-- test columns
					from
						tests.start
						col_csr := First_test_col
					until
						tests.off
					loop
						gr.set_item (col_csr, create {EV_GRID_LABEL_ITEM}.make_with_text ("?"))
						tests.forth
						col_csr := col_csr + 1
					end
				end
   			end

			grid_row_stack.extend (gr)
		end

	populate_gui_tree_node_exit (an_item: ARCHETYPE_REPOSITORY_ITEM) is
		do
			grid_row_stack.remove
		end

	add_checkbox (row: EV_GRID_ROW)
			-- Add the checkbox column to `row'.
			-- TODO: When we move to EiffelStudio 6.0, replace this with EV_GRID_CHECKABLE_LABEL_ITEM on column 1.
		require
			row_attached: row /= Void
		local
			item: EV_GRID_LABEL_ITEM
   		do
			create item
			row.set_item (2, item)
			set_checkbox (item, True)
			item.pointer_button_release_actions.force_extend (agent toggle_checkbox (item))
		end

	toggle_checkbox (item: EV_GRID_ITEM) is
			-- Toggle checkbox indicating whether to test archetypes on `item' and its sub-rows.
		require
			item_attached: item /= Void
		local
			checked: BOOLEAN
		do
			if item.column.index = 2 then
				checked ?= item.data
				set_checkbox_recursively (item, not checked)
			end
		end

	set_checkbox_recursively (item: EV_GRID_ITEM; checked: BOOLEAN) is
			-- Set checkbox indicating whether to test archetypes on `item' and its sub-rows.
		require
			item_attached: item /= Void
			column_2: item.column.index = 2
		local
			i: INTEGER
		do
			set_checkbox (item, checked)

			from
				i := 0
			until
				i = item.row.subrow_count
			loop
				i := i + 1
				set_checkbox_recursively (item.row.subrow (i).item (2), checked)
			end
		end

	set_checkbox (item: EV_GRID_ITEM; checked: BOOLEAN) is
			-- Set checkbox indicating whether to test archetype on `item'.
		require
			item_attached: item /= Void
			column_2: item.column.index = 2
		local
			gli: EV_GRID_LABEL_ITEM
		do
			item.set_data (checked)
			gli ?= item

			if gli /= Void then
				if checked then
					gli.set_pixmap (pixmaps ["checked_box"])
				else
					gli.set_pixmap (pixmaps ["unchecked_box"])
				end
			end
		end

	on_grid_key_press (key: EV_KEY)
			-- Process keystrokes in `grid' to scroll, expand and collapse rows, etc.
		local
			selected: EV_GRID_ITEM
		do
			if key /= Void then
				if not gui.parent_app.shift_pressed and not gui.parent_app.alt_pressed then
					if gui.parent_app.ctrl_pressed then
						if key.code = {EV_KEY_CONSTANTS}.key_up then
							key.set_code ({EV_KEY_CONSTANTS}.key_menu)
							scroll_to_row (grid.first_visible_row.index - 1)
						elseif key.code = {EV_KEY_CONSTANTS}.key_down then
							key.set_code ({EV_KEY_CONSTANTS}.key_menu)

							if grid.visible_row_indexes.count > 1 then
								scroll_to_row (grid.visible_row_indexes [2])
							end
						elseif key.code = {EV_KEY_CONSTANTS}.key_home then
							scroll_to_row (1)
						elseif key.code = {EV_KEY_CONSTANTS}.key_end then
							scroll_to_row (grid.row_count)
						elseif key.code = {EV_KEY_CONSTANTS}.key_page_up then
							scroll_to_row (grid.first_visible_row.index - grid.visible_row_indexes.count + 1)
						elseif key.code = {EV_KEY_CONSTANTS}.key_page_down then
							scroll_to_row (grid.last_visible_row.index)
						end
					elseif key.code = {EV_KEY_CONSTANTS}.key_home then
						step_to_row (1)
					elseif key.code = {EV_KEY_CONSTANTS}.key_end then
						step_to_row (grid.row_count)
					elseif not grid.selected_items.is_empty then
						selected := grid.selected_items.first

						if key.code = {EV_KEY_CONSTANTS}.key_page_up then
							step_to_row (grid.first_visible_row.index.min (selected.row.index - grid.visible_row_indexes.count + 1))
						elseif key.code = {EV_KEY_CONSTANTS}.key_page_down then
							step_to_row (grid.last_visible_row.index.max (selected.row.index + grid.visible_row_indexes.count - 1))
						elseif key.code = {EV_KEY_CONSTANTS}.key_numpad_multiply then
							expand_tree (selected.row)
						elseif key.code = {EV_KEY_CONSTANTS}.key_numpad_add or key.code = {EV_KEY_CONSTANTS}.key_right then
							if selected.row.is_expandable then
								selected.row.expand
							end
						elseif key.code = {EV_KEY_CONSTANTS}.key_numpad_subtract then
							if selected.row.is_expanded then
								selected.row.collapse
							end
						elseif key.code = {EV_KEY_CONSTANTS}.key_left then
							if selected.column.index = 1 then
								if selected.row.is_expanded then
									selected.row.collapse
								elseif selected.row.parent_row /= Void then
									step_to_row (selected.row.parent_row.index)
								end
							end
						elseif key.code = {EV_KEY_CONSTANTS}.key_back_space then
							if selected.row.parent_row /= Void then
								step_to_row (selected.row.parent_row.index)
							end
						elseif key.code = {EV_KEY_CONSTANTS}.key_space then
							toggle_checkbox (selected)
						end
					end
				end
			end
		end

	on_mouse_wheel (step: INTEGER) is
			-- Scroll `grid' when the mouse wheel moves.
		do
			if step > 0 then
				scroll_to_row (grid.first_visible_row.index - step)
			else
				scroll_to_row (grid.visible_row_indexes [grid.visible_row_indexes.count.min (1 - step)])
			end
		end

	scroll_to_row (index: INTEGER)
			-- Scroll `grid' so the row at `index' is at the top if Ctrl is held down, else selecting it.
		local
			i: INTEGER
		do
			i := index.max (1).min (grid.row_count)
			grid.set_first_visible_row (i)
		end

	step_to_row (index: INTEGER)
			-- Scroll `grid' so the row at `index' is at the top if Ctrl is held down, else selecting it.
		local
			i: INTEGER
			row: EV_GRID_ROW
		do
			from
				i := index.max (1).min (grid.row_count)
				row := grid.row (i)
			until
				row.parent_row = Void
			loop
				if not row.is_expanded then
					i := row.index
				end

				row := row.parent_row
			end

			grid.remove_selection
			row := grid.row (i)
			row.item (1).enable_select
			row.ensure_visible
		end

	expand_tree (row: EV_GRID_ROW) is
			-- Expand `row' and all of its sub-rows, recursively.
		local
			i: INTEGER
		do
			if row.subrow_count > 0 then
				row.expand

				from
					i := 1
				until
					i > row.subrow_count
				loop
					expand_tree (row.subrow (i))
					i := i + 1
				end
			end
		end

	collapse_tree (row: EV_GRID_ROW) is
			-- Collapse `row' and all of its sub-rows, recursively.
		local
			i: INTEGER
		do
			if row.subrow_count > 0 then
				from
					i := 1
				until
					i > row.subrow_count
				loop
					collapse_tree (row.subrow (i))
					i := i + 1
				end

				row.collapse
			end
		end

	set_archetype_test_go_bn_icon is
			-- Set go button to be either "go" or "stop" icon depending on
			-- setting of test_execution_underway
		do
			if test_execution_underway then
				gui.archetype_test_go_bn.set_pixmap (pixmaps ["stop"])
				gui.archetype_test_go_bn.set_text ("Stop")
			else
				gui.archetype_test_go_bn.set_pixmap (pixmaps ["go"])
				gui.archetype_test_go_bn.set_text ("Go")
			end
		end

	display_arrayed_list (str_lst: ARRAYED_LIST [STRING]): STRING is
			--
		require
			str_lst /= Void
		do
			create Result.make_empty

			from
				str_lst.start
			until
				str_lst.off
			loop
				if not str_lst.isfirst then
					Result.append (", ")
				end

				Result.append (str_lst.item)
				str_lst.forth
			end
		end

invariant
	grid_attached: grid /= Void

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
--| The Original Code is adl_node_control.e.
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
