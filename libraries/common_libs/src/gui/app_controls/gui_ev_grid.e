note
	component:   "openEHR Archetype Project"
	description: "Visual control for a EV_GRID that adds basic app-level routines."
	keywords:    "UI, ADL"
	author:      "Thomas Beale <thomas.beale@OceanInformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2012 Ocean Informatics Pty Ltd <http://www.oceaninfomatics.com>"
	license:     "See notice at bottom of class"

	file:        "$URL$"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"


class GUI_EV_GRID

inherit
	STRING_UTILITIES
		export
			{NONE} all
		end

	GUI_DEFINITIONS
		export
			{NONE} all
		end

create
	make

feature -- Initialisation

	make (enable_tree, row_height_fixed, col_resize_on_collapse_expand: BOOLEAN)
		do
			create ev_grid.make
			if enable_tree then
				ev_grid.enable_tree
			end
			if not row_height_fixed then
				ev_grid.disable_row_height_fixed
			end
			if col_resize_on_collapse_expand then
				ev_grid.row_expand_actions.extend (agent (a_row: EV_GRID_ROW) do ev_grid.resize_columns_to_content (Default_grid_expansion_factor) end)
				ev_grid.row_collapse_actions.extend (agent (a_row: EV_GRID_ROW) do ev_grid.resize_columns_to_content (Default_grid_expansion_factor) end)
			end
		end

feature -- Access

	ev_grid: EV_GRID_KBD_MOUSE

	last_row: EV_GRID_ROW
			-- result of last successful call to `add_row' or `add_sub_row'

	row_count: INTEGER
		do
			Result := ev_grid.row_count
		end

feature -- Status Report

feature -- Modification

	add_row (row_idx: INTEGER; a_data: detachable ANY)
		require
			valid_row_index: row_idx > 0 and row_idx <= row_count + 1
		do
			ev_grid.insert_new_row (row_idx)
			last_row := ev_grid.row (row_idx)
			if attached a_data then
				last_row.set_data (a_data)
			end
		end

	add_sub_row (a_parent_row: EV_GRID_ROW; a_data: detachable ANY)
		do
			a_parent_row.insert_subrow (a_parent_row.subrow_count + 1)
			last_row := a_parent_row.subrow (a_parent_row.subrow_count)
			if attached a_data then
				last_row.set_data (a_data)
			end
		end

	set_last_row (a_row: EV_GRID_ROW)
		do
			last_row := a_row
		end

	set_last_row_label_col (a_col: INTEGER; a_text, a_tooltip: detachable STRING; a_fg_colour: detachable EV_COLOR; a_pixmap: detachable EV_PIXMAP)
			-- add column details to `last_sub_row'
		local
			gli: EV_GRID_LABEL_ITEM
		do
			if attached a_text then
				create gli.make_with_text (utf8_to_utf32 (a_text))
			else
				create gli.default_create
			end
			if attached a_fg_colour then
				gli.set_foreground_color (a_fg_colour)
			end
			if attached a_pixmap then
				gli.set_pixmap (a_pixmap)
			end
			if attached a_tooltip then
				gli.set_tooltip (utf8_to_utf32 (a_tooltip))
			end
			last_row.set_item (a_col, gli)
		end

	update_last_row_label_col (a_col: INTEGER; a_text, a_tooltip: detachable STRING; a_fg_colour: detachable EV_COLOR; a_pixmap: detachable EV_PIXMAP)
			-- update column details to `last_sub_row'; any detail that is Void is not changed in existing column
		do
			if attached {EV_GRID_LABEL_ITEM} last_row.item (a_col) as gli then
				if attached a_text then
					gli.set_text (utf8_to_utf32 (a_text))
				end
				if attached a_tooltip then
					gli.set_tooltip (utf8_to_utf32 (a_tooltip))
				end
				if attached a_fg_colour then
					gli.set_foreground_color (a_fg_colour)
				end
				if attached a_pixmap then
					gli.set_pixmap (a_pixmap)
				end
			end
		end

	set_last_row_label_col_multi_line (a_col: INTEGER; a_text, a_tooltip: detachable STRING; a_fg_colour: detachable EV_COLOR; a_pixmap: detachable EV_PIXMAP)
		do
			set_last_row_label_col (a_col, a_text, a_tooltip, a_fg_colour, a_pixmap)
			if attached {EV_GRID_LABEL_ITEM} last_row.item (a_col) as gli then
				last_row.set_height (gli.text_height + Default_grid_row_expansion)
			end
		end

	remove_matching_sub_rows (a_parent_row: EV_GRID_ROW; a_row_test: FUNCTION [ANY, TUPLE [EV_GRID_ROW], BOOLEAN])
		local
			remove_list: SORTED_TWO_WAY_LIST [INTEGER]
			sub_row: EV_GRID_ROW
			i: INTEGER
		do
			create remove_list.make
			from i := 1 until i > a_parent_row.subrow_count loop
				sub_row := a_parent_row.subrow (i)
				if a_row_test.item ([sub_row]) then
					remove_list.extend (sub_row.index)
				end
				i := i + 1
			end
			from remove_list.finish	until remove_list.off loop
				ev_grid.remove_row (remove_list.item)
				remove_list.back
			end
		end

	set_column_titles (col_names: ARRAYED_LIST [STRING])
			-- set grid column titles
		local
			i: INTEGER
		do
			if ev_grid.row_count > 0 then
				from i := 1 until i > ev_grid.column_count loop
					ev_grid.column (i).set_title (utf8_to_utf32 (col_names.i_th (i)))
					i := i + 1
				end
			end
			ev_grid.resize_columns_to_content (Default_grid_expansion_factor)
		end

	wipe_out
		do
			ev_grid.wipe_out
		end

feature -- Commands

	resize_columns_to_content
		do
			ev_grid.resize_columns_to_content (Default_grid_expansion_factor)
		end

feature {NONE} -- Implementation

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
--| The Original Code is gui_hash_table.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2012
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
