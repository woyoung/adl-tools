note
	component:   "openEHR ADL Tools"
	description: "Interface of any Editor context"
	keywords:    "archetype, editing"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2012- Ocean Informatics Pty Ltd <http://www.oceaninfomatics.com>"
	license:     "Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>"

deferred class ANY_ED_CONTEXT

inherit
	SHARED_APP_UI_RESOURCES
		export
			{NONE} all;
			{ANY} deep_twin, is_deep_equal, standard_is_equal
		end

	EVX_UTILITIES
		export
			{NONE} all
		end

	SPECIALISATION_STATUSES
		export
			{NONE} all
		end

	ARCHETYPE_TERM_CODE_TOOLS
		export
			{NONE} all
		end

	SHARED_GUI_AGENTS
		export
			{NONE} all
		end

	SHARED_GUI_ARCHETYPE_TOOL_AGENTS
		export
			{NONE} all
		end

feature -- Definitions

	c_meaning_colours: HASH_TABLE [EV_COLOR, INTEGER]
			-- foreground colours for meaning (node_id rubric) based on inheritance status
		once
			create Result.make(0)
			Result.put (archetype_rm_type_redefined_color, ss_redefined)
			Result.put (archetype_rm_type_inherited_color, ss_inherited)
		end

	c_constraint_colours: HASH_TABLE [EV_COLOR, INTEGER]
			-- foreground colours for constraints
		once
			create Result.make(0)
			Result.put (archetype_rm_type_inherited_color, ss_inherited)
		end

	c_attribute_colours: HASH_TABLE [EV_COLOR, INTEGER]
			-- foreground colours for meaning (node_id rubric) based on inheritance status
		once
			create Result.make(0)
			Result.put (archetyped_attribute_color, ss_added)
			Result.put (archetype_rm_type_redefined_color, ss_redefined)
			Result.put (archetype_rm_type_inherited_color, ss_inherited)
		end

feature -- Initialisation

	make (an_arch_node: attached like arch_node; an_ed_context: ARCH_ED_CONTEXT_STATE)
		do
			create display_settings.make_default
			ed_context := an_ed_context
			arch_node := an_arch_node
		ensure
			Is_constraint: not is_rm
			Not_in_grid: not is_prepared
		end

feature -- Access

	ed_context: ARCH_ED_CONTEXT_STATE
			-- assembled context information for display / editing

	arch_node: detachable ANY
			-- archetype node being edited in this context

	evx_grid: detachable EVX_GRID
			-- note: stable once attached
		note
			option: stable
		attribute
		end

	ev_grid_row: detachable EV_GRID_ROW
			-- note: stable once attached
		note
			option: stable
		attribute
		end

	display_settings: GUI_DEFINITION_SETTINGS

feature -- Status Report

	is_shown_in_grid: BOOLEAN
			-- True if this node is included in the grid tree; False if it is there but hidden
		do
			Result := ev_grid_row.is_show_requested
		end

	is_rm: BOOLEAN
			-- True if this node represents an unarchetyped RM property
		do
			Result := not attached arch_node
		end

	is_prepared: BOOLEAN
		do
			Result := attached evx_grid and attached ev_grid_row
		end

	is_displayed: BOOLEAN
			-- True if `display_in_grid' has ever been called

feature -- Display

	prepare_display_in_grid (a_gui_grid: EVX_GRID)
		deferred
		ensure
			prepared: is_prepared
		end

	display_in_grid (ui_settings: GUI_DEFINITION_SETTINGS)
		require
			is_prepared
		do
			display_settings := ui_settings
			check attached ev_grid_row as gr then
				evx_grid.set_last_row (gr)
			end
			is_displayed := True
		ensure
			has_been_displayed: is_displayed
		end

	hide_in_grid
		do
			ev_grid_row.hide
		ensure
			not is_shown_in_grid
		end

	show_in_grid
		do
			--- the following will open out just the one row
--			if attached gui_grid_row.parent_row as pr and then pr.is_expandable and then not pr.is_expanded then
--				pr.expand
--			end

			-- the following opens out a row and its children
			check attached ev_grid_row as gr then
				evx_grid.ev_grid.ensure_visible (gr)
				gr.show
			end
		ensure
			is_shown_in_grid
		end

feature {NONE} -- Implementation

	c_meaning_colour: EV_COLOR
			-- generate a foreground colour for RM attribute representing inheritance status
		do
			if display_settings.show_rm_inheritance and c_meaning_colours.has (node_specialisation_status) then
				check attached c_meaning_colours.item (node_specialisation_status) as cmc then
					Result := cmc
				end
			else
				Result := archetype_rm_type_color
			end
		end

	c_constraint_colour: EV_COLOR
			-- generate a foreground colour for RM attribute representing inheritance status
		do
			if display_settings.show_rm_inheritance and c_constraint_colours.has (node_specialisation_status) then
				check attached c_constraint_colours.item (node_specialisation_status) as ccc then
					Result := ccc
				end
			else
				Result := archetype_constraint_color
			end
		end

	c_attribute_colour: EV_COLOR
			-- generate a foreground colour for RM attribute representing inheritance status
		do
			if display_settings.show_rm_inheritance and c_attribute_colours.has (node_specialisation_status) then
				check attached c_attribute_colours.item (node_specialisation_status) as cac then
					Result := cac
				end
			else
				Result := archetyped_attribute_color
			end
		end

	c_pixmap: EV_PIXMAP
		deferred
		end

	local_term_string (a_code: STRING): STRING
			-- generate a string of the form "code|rubric|" if showing codes
			-- or else "rubric"
		do
			create Result.make_empty
			if attached {ARCHETYPE_TERM} ed_context.flat_ontology.definition_for_code (display_settings.language, a_code) as ont_term then
				if display_settings.show_codes then
					Result.append (a_code + "|" + ont_term.text + "|")
				else
					Result.append (ont_term.text)
				end
			else
				Result.append (a_code)
			end
		end

	term_string (a_terminology_id, a_code: STRING): STRING
			-- generate a string of the form "[code|rubric|]" if in showing codes,
			-- or else "rubric"
		local
			a_term: DV_CODED_TEXT
		do
			create Result.make_empty
			if a_terminology_id.is_equal (Local_terminology_id) then
				Result := local_term_string (a_code)
			elseif ts.has_terminology (a_terminology_id) then
				if ts.terminology (a_terminology_id).has_concept_id (a_code, display_settings.language) then
					check attached ts.terminology (a_terminology_id).term (a_code, display_settings.language) as t then
						a_term := t
					end
				else
					check attached ts.terminology (a_terminology_id).term (a_code, Default_language) as t then
						a_term := t
					end
				end
				if display_settings.show_codes then
					Result.append (a_term.as_string)
				else
					Result.append (a_term.value)
				end
			else
				Result.append (a_code)
			end
		end

	c_terminology_code_str (a_ccp: C_TERMINOLOGY_CODE): STRING
			-- output just the code rubrics from `a_ccp' in the form of a list:
			--	term1
			--	term2 (assumed)
			--	term3
		do
			create Result.make_empty
			if attached a_ccp.code_list as cl then
				across cl as codes_csr loop
					Result.append_string (term_string (a_ccp.terminology_id, codes_csr.item))
					if a_ccp.has_assumed_value and then a_ccp.assumed_value.code_string.is_equal (codes_csr.item) then
						Result.append (" (" + get_text (ec_assumed_text) + ")")
					end
					if not codes_csr.is_last then
						Result.append_string ("%N")
					end
				end
			end
		end

	node_specialisation_status: INTEGER
			-- specialisation status of `arch_node'
		require
			not is_rm
		deferred
		end

	arch_node_aom_type: STRING
			-- generate the type name of `arch_node'
			-- FIXME: this is a hack, but there seems no other nice way to do it - once functions to generate
			-- a default instance can't be anchored!
		do
			Result := generator
			Result.remove_tail (("_ED_CONTEXT").count)
		end

end


