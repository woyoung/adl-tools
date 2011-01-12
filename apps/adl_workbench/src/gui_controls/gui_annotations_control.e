note
	component:   "openEHR Archetype Project"
	description: "Archetype annotations grid control. We use a grid here to allow for a more tree-like representation in the future"
	keywords:    "ADL"
	author:      "Thomas Beale"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2011 Ocean Informatics Pty Ltd <http://www.oceaninfomatics.com>"
	license:     "See notice at bottom of class"

	file:        "$URL$"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"


class GUI_ANNOTATIONS_CONTROL

inherit
	SHARED_KNOWLEDGE_REPOSITORY
		export
			{NONE} all;
			{ANY} has_current_profile
		end

	GUI_UTILITIES
		export
			{NONE} all
		end

	GUI_GRID_CONTROLLER
		export
			{NONE} all
		end

	SHARED_APP_UI_RESOURCES
		export
			{NONE} all
		end

create
	make

feature -- Definitions

	Grid_path_col: INTEGER = 1
	Grid_ann_key_col: INTEGER = 2
	Grid_ann_value_col: INTEGER = 3

feature {NONE} -- Initialisation

	make (a_main_window: attached MAIN_WINDOW)
			-- Create controller for the test grid.
		do
			gui := a_main_window
			make_for_grid (gui.annotations_grid)
			grid.enable_tree
		end

feature -- Access

feature -- Status Setting

feature -- Commands

	clear
			-- Wipe out content from widgets.
		do
			grid.wipe_out
		end

	populate
			-- populate the ADL tree control by creating it from scratch
		require
			has_current_profile
		local
			lang_key: STRING
			anns_by_path: HASH_TABLE [RESOURCE_ANNOTATION_ITEMS, STRING]
			ann_list: HASH_TABLE [STRING, STRING]
			gli: EV_GRID_LABEL_ITEM
			path_row, ann_row: EV_GRID_ROW
		do
			clear

			-- set `target_archetype'
			if current_arch_dir.has_validated_selected_archetype then
				if differential_view then
					target_archetype := current_arch_dir.selected_archetype.differential_archetype
				else
					target_archetype := current_arch_dir.selected_archetype.flat_archetype
				end

				-- figure out if there are any annotations, and what actual language tag they are under
				if target_archetype.has_annotations_language_matching_tag (current_language) then
					lang_key := target_archetype.matching_annotations_language_tag (current_language)

					-- populate grid
					anns_by_path := target_archetype.annotations.item (lang_key).items
					from anns_by_path.start until anns_by_path.off loop
						-- put the path in the first column
						create gli.make_with_text (anns_by_path.key_for_iteration)
						grid.set_item (Grid_path_col, grid.row_count + 1, gli)
						path_row := gli.row

						-- for each item in the annotations list, add a sub-row with the key in col 2 and the value in col 3
						ann_list := anns_by_path.item_for_iteration.items
						from ann_list.start until ann_list.off loop

							-- create a new sub row
							path_row.insert_subrow (path_row.subrow_count + 1)

							-- get the sub row
							ann_row := path_row.subrow (path_row.subrow_count)
							create gli.make_with_text (ann_list.key_for_iteration)
							ann_row.set_item (Grid_ann_key_col, gli)

							create gli.make_with_text (ann_list.item_for_iteration)
							ann_row.set_item (Grid_ann_value_col, gli)

							ann_list.forth
						end
						anns_by_path.forth
					end

					-- put names on columns
					if grid.column_count > 0 then
						grid.column (Grid_path_col).set_title ("Path")
						grid.column (Grid_path_col).resize_to_content
						grid.column (Grid_ann_key_col).set_title ("Annotation key")
						grid.column (Grid_ann_key_col).resize_to_content
						grid.column (Grid_ann_value_col).set_title ("Annotation value")
						grid.column (Grid_ann_value_col).resize_to_content
					end
				end
			end
		end

   	set_row_pixmap (row: attached EV_GRID_ROW)
   			-- Set the icon appropriate to the item attached to `row'.
   		do
			if attached {EV_GRID_LABEL_ITEM} row.item (1) as gli and attached {ARCH_REP_ITEM} row.data as ari then
				if attached {EV_PIXMAP} pixmaps [ari.group_name] as pixmap then
					gli.set_pixmap (pixmap)
				end
			end
		end

	toggle_expand_tree
			-- toggle expanded status of tree view
		do
--			if is_expanded then
--				is_expanded := False
--			else
--				is_expanded := True
--			end
		end

feature {NONE} -- Commands


feature {NONE} -- Implementation

	gui: MAIN_WINDOW
			-- main window of system

	target_archetype: attached ARCHETYPE
			-- Differential or flat version of archetype, depending on setting of `differential_view'.

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
--| The Original Code is gui_test_archetype_tree_control.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2003-2008
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
