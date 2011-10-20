note
	component:   "openEHR Archetype Project"
	description: "Main window"
	keywords:    "AWB, archetypes, workbench"
	author:      "Thomas Beale <thomas.beale@OceanInformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2003-2011 Ocean Informatics Pty Ltd <http://www.oceaninfomatics.com>"
	license:     "See notice at bottom of class"

	file:        "$URL$"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class
	MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			show, initialize, is_in_default_state
		end

	GUI_DEFINITIONS
		undefine
			is_equal, default_create, copy
		end

	WINDOW_ACCELERATORS
		undefine
			copy, default_create
		end

	SHARED_APP_ROOT
		undefine
			copy, default_create
		end

	SHARED_APP_UI_RESOURCES
		undefine
			copy, default_create
		end

	SHARED_XML_RULES
		undefine
			copy, default_create
		end

	GUI_UTILITIES
		export
			{NONE} all
		undefine
			copy, default_create
		end

feature {NONE} -- Initialization

	frozen initialize
			-- Initialize `Current'.
		do
			Precursor {EV_TITLED_WINDOW}

			-- create widgets
			create menu
			create file_menu
			create file_menu_open
			create l_ev_menu_separator_1
			create file_menu_save_as
			create l_ev_menu_separator_2
			create file_menu_exit

			create edit_menu
			create edit_menu_copy
			create edit_menu_select_all
			create l_ev_menu_separator_3
			create edit_menu_clipboard

			create view_menu
			create view_menu_differential
			create view_menu_flat
			create view_menu_new_archetype_tool
			create view_menu_new_class_tool
			create l_ev_menu_separator_4
			create view_menu_reset_layout

			create history_menu
			create history_menu_back
			create history_menu_forward
			create history_menu_separator
			create repository_menu
			create repository_menu_build_all
			create repository_menu_rebuild_all
			create l_ev_menu_separator_5
			create repository_menu_build_subtree
			create repository_menu_rebuild_subtree
			create l_ev_menu_separator_6
			create repository_menu_export_html
			create repository_menu_export_repository_report
			create l_ev_menu_separator_7
			create repository_menu_interrupt_build
			create repository_menu_refresh
			create l_ev_menu_separator_8
			create repository_menu_set_repository
			create rm_schemas_menu
			create rm_schemas_menu_reload_schemas
			create l_ev_menu_separator_9
			create rm_schemas_menu_configure_rm_schemas
			create xml_menu
			create l_ev_menu_separator_10
			create xml_menu_conv_rules
			create tools_menu
			create tools_menu_clean_generated_files
			create l_ev_menu_separator_11
			create tools_menu_options
			create help_menu
			create help_menu_contents
			create help_menu_release_notes
			create help_menu_icons
			create l_ev_menu_separator_12
			create help_menu_clinical_knowledge_manager
			create help_menu_report_bug
			create help_menu_about
			create ev_main_vbox
			create action_bar
			create archetype_profile_combo
			create arch_history_tool_bar
			create arch_compile_tool_bar
			create compile_button
			create tool_bar_sep_1
			create open_button
			create tool_bar_sep_2
			create history_back_button
			create tool_bar_sep_3
			create history_forward_button

			create arch_output_version_hbox
			create arch_output_version_label
			create arch_output_version_combo

			create viewer_main_cell

			-- Connect widgets
			set_menu_bar (menu)
			menu.extend (file_menu)
			file_menu.extend (file_menu_open)
			file_menu.extend (l_ev_menu_separator_1)
			file_menu.extend (file_menu_save_as)
			file_menu.extend (l_ev_menu_separator_2)
			file_menu.extend (file_menu_exit)
			menu.extend (edit_menu)
			edit_menu.extend (edit_menu_copy)
			edit_menu.extend (edit_menu_select_all)
			edit_menu.extend (l_ev_menu_separator_3)
			edit_menu.extend (edit_menu_clipboard)
			menu.extend (view_menu)
			view_menu.extend (view_menu_differential)
			view_menu.extend (view_menu_flat)
			view_menu.extend (view_menu_new_archetype_tool)
			view_menu.extend (view_menu_new_class_tool)
			view_menu.extend (l_ev_menu_separator_4)
			view_menu.extend (view_menu_reset_layout)
			menu.extend (history_menu)
			history_menu.extend (history_menu_back)
			history_menu.extend (history_menu_forward)
			history_menu.extend (history_menu_separator)
			menu.extend (repository_menu)
			repository_menu.extend (repository_menu_build_all)
			repository_menu.extend (repository_menu_rebuild_all)
			repository_menu.extend (l_ev_menu_separator_5)
			repository_menu.extend (repository_menu_build_subtree)
			repository_menu.extend (repository_menu_rebuild_subtree)
			repository_menu.extend (l_ev_menu_separator_6)
			repository_menu.extend (repository_menu_export_html)
			repository_menu.extend (repository_menu_export_repository_report)
			repository_menu.extend (l_ev_menu_separator_7)
			repository_menu.extend (repository_menu_interrupt_build)
			repository_menu.extend (repository_menu_refresh)
			repository_menu.extend (l_ev_menu_separator_8)
			repository_menu.extend (repository_menu_set_repository)
			menu.extend (rm_schemas_menu)
			rm_schemas_menu.extend (rm_schemas_menu_reload_schemas)
			rm_schemas_menu.extend (l_ev_menu_separator_9)
			rm_schemas_menu.extend (rm_schemas_menu_configure_rm_schemas)
			menu.extend (xml_menu)
			xml_menu.extend (l_ev_menu_separator_10)
			xml_menu.extend (xml_menu_conv_rules)
			menu.extend (tools_menu)
			tools_menu.extend (tools_menu_clean_generated_files)
			tools_menu.extend (l_ev_menu_separator_11)
			tools_menu.extend (tools_menu_options)
			menu.extend (help_menu)
			help_menu.extend (help_menu_contents)
			help_menu.extend (help_menu_release_notes)
			help_menu.extend (help_menu_icons)
			help_menu.extend (l_ev_menu_separator_12)
			help_menu.extend (help_menu_clinical_knowledge_manager)
			help_menu.extend (help_menu_report_bug)
			help_menu.extend (help_menu_about)
			extend (ev_main_vbox)

			ev_main_vbox.extend (action_bar)
			action_bar.extend (arch_history_tool_bar)
			arch_history_tool_bar.extend (history_back_button)
			arch_history_tool_bar.extend (tool_bar_sep_3)
			arch_history_tool_bar.extend (history_forward_button)
			action_bar.extend (archetype_profile_combo)
			action_bar.extend (arch_compile_tool_bar)
			arch_compile_tool_bar.extend (compile_button)
			arch_compile_tool_bar.extend (tool_bar_sep_1)
--			arch_compile_tool_bar.extend (open_button)
--			arch_compile_tool_bar.extend (tool_bar_sep_2)
			action_bar.extend (address_bar.ev_root_container)

			-- ADL output version combo
			action_bar.extend (arch_output_version_hbox)
			arch_output_version_hbox.extend (arch_output_version_label)
			arch_output_version_hbox.extend (arch_output_version_combo)

			ev_main_vbox.extend (viewer_main_cell)

			-- Set visual characteristics
			file_menu.set_text ("&File")
			file_menu_open.set_text ("&Open...")
			file_menu_save_as.set_text ("Save &As...")
			file_menu_exit.set_text ("E&xit")
			edit_menu.set_text ("&Edit")
			edit_menu_copy.set_text ("&Copy")
			edit_menu_select_all.set_text ("Select &All")
			edit_menu_clipboard.set_text ("Clip&board...")
			view_menu.set_text ("&View")
			view_menu_differential.set_text ("&Differential")
			view_menu_flat.set_text ("&Flat")
			view_menu_new_archetype_tool.set_text ("New Archetype &Tab")
			view_menu_new_class_tool.set_text ("New Class Tab")
			view_menu_reset_layout.set_text ("&Reset tool layout")
			history_menu.set_text ("H&istory")
			history_menu_back.set_text ("&Back")
			history_menu_forward.set_text ("&Forward")
			repository_menu.set_text ("&Repository")
			repository_menu_build_all.set_text ("&Build All")
			repository_menu_rebuild_all.set_text ("&Rebuild All")
			repository_menu_build_subtree.set_text ("Build Sub&tree")
			repository_menu_rebuild_subtree.set_text ("Rebuild S&ubtree")
			repository_menu_export_html.set_text ("Export &HTML...")
			repository_menu_export_repository_report.set_text ("&Export Repository Report...")
			repository_menu_interrupt_build.disable_sensitive
			repository_menu_interrupt_build.set_text ("&Interrupt Build")
			repository_menu_refresh.set_text ("Refresh Repository")
			repository_menu_set_repository.set_text ("&Configure Repository Profiles...")
			rm_schemas_menu.set_text ("RM &Schemas")
			rm_schemas_menu_reload_schemas.set_text ("&Reload Schemas")
			rm_schemas_menu_configure_rm_schemas.set_text ("&Configure Schemas...")
			xml_menu.set_text ("&XML")
			xml_menu_conv_rules.set_text ("Edit &Conversion Rules...")
			tools_menu.set_text ("&Tools")
			tools_menu_clean_generated_files.set_text ("&Clean Generated Files")
			tools_menu_options.set_text ("&Options...")
			help_menu.set_text ("&Help")
			help_menu_contents.set_text ("&Contents")
			help_menu_release_notes.set_text ("&Release Notes")
			help_menu_icons.set_text ("&Icons ")
			help_menu_clinical_knowledge_manager.set_text ("Clinical &Knowledge Manager")
			help_menu_report_bug.set_text ("Report a &Bug")
			help_menu_about.set_text ("&About ADL Workbench")
			set_minimum_width (500)
			set_minimum_height (350)
			set_maximum_width (2000)
			set_maximum_height (2000)
			set_title ("Archetype Definition Language " + latest_adl_version + " Workbench")

			-- Connect events.
			file_menu_open.select_actions.extend (agent open_archetype)
			file_menu_save_as.select_actions.extend (agent save_archetype_as)
			file_menu_exit.select_actions.extend (agent exit_app)
			edit_menu_clipboard.select_actions.extend (agent show_clipboard)
			view_menu_reset_layout.select_actions.extend (agent on_reset_tool_layout)
			history_menu.select_actions.extend (agent on_history)
			history_menu_back.select_actions.extend (agent on_back)
			history_menu_forward.select_actions.extend (agent on_forward)
			repository_menu_build_all.select_actions.extend (agent build_all)
			repository_menu_rebuild_all.select_actions.extend (agent rebuild_all)
			repository_menu_build_subtree.select_actions.extend (agent build_subtree)
			repository_menu_rebuild_subtree.select_actions.extend (agent rebuild_subtree)
			repository_menu_export_html.select_actions.extend (agent export_html)
			repository_menu_export_repository_report.select_actions.extend (agent export_repository_report)
			repository_menu_interrupt_build.select_actions.extend (agent interrupt_build)
			repository_menu_refresh.select_actions.extend (agent refresh_directory)
			repository_menu_set_repository.select_actions.extend (agent configure_profiles)
			rm_schemas_menu_reload_schemas.select_actions.extend (agent reload_schemas)
			rm_schemas_menu_configure_rm_schemas.select_actions.extend (agent set_rm_schemas)
			xml_menu_conv_rules.select_actions.extend (agent set_xml_rules)
			tools_menu_clean_generated_files.select_actions.extend (agent clean_generated_files)
			tools_menu_options.select_actions.extend (agent set_options)
			help_menu_contents.select_actions.extend (agent show_online_help)
			help_menu_release_notes.select_actions.extend (agent show_release_notes)
			help_menu_icons.select_actions.extend (agent show_icon_help)
			help_menu_clinical_knowledge_manager.select_actions.extend (agent show_clinical_knowledge_manager)
			help_menu_report_bug.select_actions.extend (agent show_bug_reporter)
			help_menu_about.select_actions.extend (agent show_about)
			close_request_actions.extend (agent exit_app)

			-- set visual characteristics - menu
			set_icon_pixmap (adl_workbench_icon)

			file_menu_open.set_pixmap (pixmaps ["open_archetype"])
			history_menu_back.set_pixmap (pixmaps ["history_back"])
			history_menu_forward.set_pixmap (pixmaps ["history_forward"])

			view_menu_differential.set_pixmap (pixmaps ["diff_class"])
			view_menu_flat.set_pixmap (pixmaps ["flat_class"])
			view_menu_new_archetype_tool.set_pixmap (pixmaps ["archetype_2"])
			view_menu_new_class_tool.set_pixmap (pixmaps ["class_tool_new"])

			repository_menu_set_repository.set_pixmap (pixmaps ["tools"])
			rm_schemas_menu_configure_rm_schemas.set_pixmap (pixmaps ["tools"])
			tools_menu_options.set_pixmap (pixmaps ["tools"])

			-- set visual characteristics - action bar
			ev_main_vbox.disable_item_expand (action_bar)
			action_bar.set_minimum_width (800)
			action_bar.set_padding (10)
			action_bar.set_border_width (4)
			action_bar.disable_item_expand (archetype_profile_combo)
			action_bar.disable_item_expand (arch_history_tool_bar)
			action_bar.disable_item_expand (arch_compile_tool_bar)
			archetype_profile_combo.set_tooltip ("Select repository profile")
			archetype_profile_combo.set_minimum_width (160)
			archetype_profile_combo.disable_edit
			arch_history_tool_bar.disable_vertical_button_style
			arch_compile_tool_bar.disable_vertical_button_style
			compile_button.set_text ("Compile")
			compile_button.set_pixmap (pixmaps ["compile"])
			compile_button.set_tooltip ("Compile all archetypes (F7)")
--			open_button.set_text ("Open")
--			open_button.set_tooltip ("Open an ad hoc archetype")
			history_back_button.set_tooltip ("Go back one archetype")
			history_forward_button.set_tooltip ("Go forward one archetype")

--			open_button.set_pixmap (pixmaps ["open_archetype"])
			history_back_button.set_pixmap (pixmaps ["history_back"])
			history_forward_button.set_pixmap (pixmaps ["history_forward"])

			action_bar.disable_item_expand (arch_output_version_hbox)
			arch_output_version_hbox.disable_item_expand (arch_output_version_label)
			arch_output_version_hbox.disable_item_expand (arch_output_version_combo)
			arch_output_version_combo.set_minimum_width (50)
			arch_output_version_label.set_text ("ADL output version: ")
			arch_output_version_label.set_tooltip ("Release of ADL and AOM XSD to use in output serialisation")
			arch_output_version_combo.set_strings (Adl_versions)

			-- set up docking
			create docking_manager.make (viewer_main_cell, Current)
			create_new_catalogue_tool
			create_new_rm_schema_tool
			create_new_console_tool
			create_new_error_tool
			create_new_statistics_tool
			create_new_test_tool
			archetype_tools.create_new_tool

			-- populate any statically populated controls
			populate_ui_arch_output_version

			-- set up events
			edit_menu_copy.select_actions.extend (agent text_widget_handler.on_copy)
			edit_menu_select_all.select_actions.extend (agent text_widget_handler.on_select_all)

			view_menu_differential.select_actions.extend (agent on_differential_view)
			view_menu_flat.select_actions.extend (agent on_flat_view)
			view_menu_new_archetype_tool.select_actions.extend (agent archetype_tools.create_new_tool)
			view_menu_new_class_tool.select_actions.extend (agent class_map_tools.create_new_tool)

			compile_button.select_actions.extend (agent compile_toggle)
--			open_button.select_actions.extend (agent open_archetype)
			history_back_button.select_actions.extend (agent on_back)
			history_forward_button.select_actions.extend (agent on_forward)
			archetype_profile_combo.select_actions.extend (agent select_profile)

			arch_output_version_combo.select_actions.extend (agent set_adl_version_from_combo)

			-- set UI feedback handlers
			archetype_compiler.set_global_visual_update_action (agent compiler_global_gui_update)
			archetype_compiler.set_archetype_visual_update_action (agent compiler_archetype_gui_update)

			-- text widget handling
			text_widget_handler.focus_first_widget (viewer_main_cell)

			-- accelerators
			initialise_accelerators
		end

	initialise_accelerators
			-- Initialise keyboard accelerators for various widgets.
		do
			add_shortcut (agent text_widget_handler.step_focused_notebook_tab (1), key_tab, True, False, False)
			add_shortcut (agent text_widget_handler.step_focused_notebook_tab (-1), key_tab, True, False, True)

			add_menu_shortcut (file_menu_open, key_o, True, False, False)
			add_menu_shortcut (file_menu_save_as, key_s, True, False, False)
			add_menu_shortcut_for_action (edit_menu_copy, agent text_widget_handler.call_unless_text_focused (agent text_widget_handler.on_copy), key_c, True, False, False)
			add_menu_shortcut (edit_menu_select_all, key_a, True, False, False)

			add_menu_shortcut (view_menu_differential, key_d, True, False, True)
			add_menu_shortcut (view_menu_flat, key_f, True, False, True)
			add_menu_shortcut (view_menu_new_archetype_tool, key_t, True, False, False)
			add_menu_shortcut (view_menu_new_class_tool, key_t, True, False, True)

			add_menu_shortcut (repository_menu_build_all, key_f7, False, False, False)
			add_menu_shortcut (repository_menu_rebuild_all, key_f7, False, False, True)
			add_menu_shortcut (repository_menu_build_subtree, key_f7, True, False, False)
			add_menu_shortcut (repository_menu_rebuild_subtree, key_f7, True, False, True)
			add_menu_shortcut (repository_menu_interrupt_build, key_escape, False, False, True)
			add_menu_shortcut (repository_menu_refresh, key_r, True, False, False)

			add_menu_shortcut (rm_schemas_menu_reload_schemas, key_l, True, False, False)

			add_menu_shortcut (history_menu_back, key_left, False, True, False)
			add_menu_shortcut (history_menu_forward, key_right, False, True, False)
		end

	initialise_session_ui_basic
			-- initialise visual settings of window remembered from previous session
		do
			if app_x_position > Sane_screen_coord and app_y_position > Sane_screen_coord then
				set_position (app_x_position, app_y_position)
			else
				set_position (10, 10)
			end

			if app_width > 0 and app_height > 0 then
				set_size (app_width, app_height)
			else
				set_size (1024, 768)
			end
		end

	initialise_docking_layout
			-- initialise visual settings of window remembered from previous session
		local
			docking_file_to_use: STRING
		do
			if app_maximised then
				maximize
			end

			-- Determine which Docking layout file to read
			-- if the default one is the only one, or more recent than the user one, use it
			-- else use the user's one
			if file_system.file_exists (default_docking_layout_file_path) then
				if file_system.file_exists (user_docking_layout_file_path) then
					if file_system.file_time_stamp (default_docking_layout_file_path) > file_system.file_time_stamp (user_docking_layout_file_path) then
						docking_file_to_use := default_docking_layout_file_path
					else
						docking_file_to_use := user_docking_layout_file_path
					end
				end
			elseif file_system.file_exists (user_docking_layout_file_path) then
				docking_file_to_use := user_docking_layout_file_path
				console_tool.append_text (create_message_line ("copy_docking_file", <<user_docking_layout_file_path, default_docking_layout_file_path>>))
				file_system.copy_file (user_docking_layout_file_path, default_docking_layout_file_path)
			else
				console_tool.append_text (create_message_line ("no_docking_file_found", <<user_docking_layout_file_path, default_docking_layout_file_path>>))
			end

			if attached docking_file_to_use and then not docking_manager.open_config (docking_file_to_use) then
				console_tool.append_text (create_message_line ("read_docking_file_failed", <<user_docking_layout_file_path>>))
			end

			-- Splitter layout
			initialise_splitter (test_tool.ev_root_container, test_split_position)
		end

feature -- Status setting

	show
			-- Do a few adjustments and load the repository before displaying the window.
		do
			append_billboard_to_console

			initialise_session_ui_basic
			Precursor
			initialise_docking_layout

			if text_editor_command.is_empty then
				set_text_editor_command (default_text_editor_command)
			end

			if editor_app_command.is_empty then
				set_editor_app_command (default_editor_app_command)
			end

			if difftool_command.is_empty then
				set_difftool_command (default_difftool_command)
			end

			-- if no RM schemas yet available, ask user to configure
			if not directory_exists (rm_schema_directory) or not rm_schemas_access.found_valid_schemas then
				set_rm_schemas
			end

			-- if some RM schemas now found, set up a repository if necessary
			if rm_schemas_access.found_valid_schemas then
				rm_schema_tool.populate
				if repository_profiles.current_reference_repository_path.is_empty then
					configure_profiles
				else
					populate_archetype_profile_combo
					refresh_profile_context (True)
				end
			end

			append_billboard_to_console
		end

feature -- File events

	open_archetype
			-- Let the user select an ADL file, and then load and parse it.
		local
			dialog: EV_FILE_OPEN_DIALOG
			fname: STRING
		do
			create dialog
			dialog.set_start_directory (current_work_directory)
			dialog.filters.extend (["*" + File_ext_archetype_source, "ADL 1.5 source files"])
			dialog.filters.extend (["*" + File_ext_archetype_adl14, "ADL 1.4 files"])
			dialog.show_modal_to_window (Current)
			fname := dialog.file_name.as_string_8

			if not fname.is_empty then
				if not source_repositories.adhoc_source_repository.has_path (fname) then
					set_current_work_directory (file_system.dirname (fname))
					if not file_system.file_exists (fname) then
						(create {EV_INFORMATION_DIALOG}.make_with_text ("%"" + fname + "%" not found.")).show_modal_to_window (Current)
					elseif has_current_profile then
						current_arch_cat.add_adhoc_item (fname)
						if not billboard.has_errors then
							catalogue_tool.show
							catalogue_tool.populate
						end
						console_tool.append_text (billboard.content)
					end
				else
					(create {EV_INFORMATION_DIALOG}.make_with_text ("%"" + fname + "%" already added.")).show_modal_to_window (Current)
				end
			end
		end

	parse_archetype
			-- Load and parse the archetype currently selected in `archetype_directory'.
		do
			if has_current_profile and then attached {ARCH_CAT_ARCHETYPE} current_arch_cat.selected_archetype as ara then
				clear_toolbar_controls
				do_with_wait_cursor (Current, agent archetype_compiler.build_lineage (ara, 0))
				archetype_tools.active_tool.on_select_archetype_notebook
			end
		end

	edit_archetype
			-- Launch the external editor with the archetype currently selected in `archetype_directory'.
		local
			question_dialog: EV_QUESTION_DIALOG
			info_dialog: EV_INFORMATION_DIALOG
			path: STRING
		do
			if has_current_profile and then attached {ARCH_CAT_ARCHETYPE} current_arch_cat.selected_archetype as ara then
				path := ara.differential_path
				if ara.has_differential_file and ara.has_legacy_flat_file then
					create question_dialog.make_with_text (create_message_line("edit_which_file_question", <<file_system.basename (path), file_system.basename (ara.legacy_flat_path)>>))
					question_dialog.set_title ("Edit " + ara.qualified_name)
					question_dialog.set_buttons (<<"Differential", "Legacy (flat)">>)
					question_dialog.show_modal_to_window (Current)

					if question_dialog.selected_button.starts_with ("L") then
						path := ara.legacy_flat_path
					end
				elseif ara.has_legacy_flat_file then
					create info_dialog.make_with_text (create_message_line("edit_legacy_file_info", <<file_system.basename (ara.legacy_flat_path)>>))
					info_dialog.set_title ("Edit " + ara.id.as_string)
					info_dialog.show_modal_to_window (Current)
					path := ara.legacy_flat_path
				end

				execution_environment.launch (editor_app_command + " %"" + path + "%"")
			end
		end

	save_archetype_as
			-- Save to an ADL or HTML file via a GUI file save dialog.
		local
			ok_to_write: BOOLEAN
			question_dialog: EV_QUESTION_DIALOG
			error_dialog: EV_INFORMATION_DIALOG
			file: PLAIN_TEXT_FILE
			save_dialog: EV_FILE_SAVE_DIALOG
			name, format: STRING
		do
			if attached current_arch_cat as dir and then dir.has_validated_selected_archetype then
				name := extension_replaced (dir.selected_archetype.full_path, "")

				create save_dialog
				save_dialog.set_title ("Save Archetype")
				save_dialog.set_file_name (name)
				save_dialog.set_start_directory (current_work_directory)

				from archetype_serialiser_formats.start until archetype_serialiser_formats.off loop
					format := archetype_serialiser_formats.item
					save_dialog.filters.extend (["*" + archetype_file_extensions [format], "Save as " + format.as_upper])
					archetype_serialiser_formats.forth
				end

				save_dialog.show_modal_to_window (Current)
				name := save_dialog.file_name.as_string_8

				if not name.is_empty then
					set_current_work_directory (file_system.dirname (name))
					format := archetype_serialiser_formats [save_dialog.selected_filter_index]

					if not file_system.has_extension (name, archetype_file_extensions [format]) then
						name.append (archetype_file_extensions [format])
					end

					ok_to_write := True
					create file.make (name)

					if file.exists then
						create question_dialog.make_with_text (create_message_content ("file_exists_replace_question", <<file_system.basename (name)>>))
						question_dialog.set_title ("Save as " + format.as_upper)
						question_dialog.set_buttons (<<"Yes", "No">>)
						question_dialog.show_modal_to_window (Current)
						ok_to_write := question_dialog.selected_button.same_string ("Yes")
					end

					if ok_to_write then
						dir.selected_archetype.save_differential_as (name, format)
						console_tool.append_text (dir.selected_archetype.status)
					end
				end
			else
				create error_dialog.make_with_text (create_message_content ("compile_before_serialising", Void))
				error_dialog.show_modal_to_window (Current)
			end
		end

	exit_app
			-- Terminate the application, saving the window location.
		do
			set_app_width (width)
			set_app_height (height)
			if not is_minimized then
				set_app_x_position (x_position)
				set_app_y_position (y_position)
			end
			set_app_maximised (is_maximized)
			set_test_split_position (test_tool.ev_root_container.split_position)

			app_cfg.save

			if not docking_manager.save_data (user_docking_layout_file_path) then
				console_tool.append_text (create_message_line ("write_docking_file_failed", <<user_docking_layout_file_path>>))
			end

			ev_application.destroy
		end

feature -- View Events

	on_differential_view
			-- set differential view on currently visible Archetype and Class Tools
		do
			archetype_tools.do_all_visible_tools (agent
				(a_tool: GUI_ARCHETYPE_TOOL) do a_tool.select_differential_view end
			)
			class_map_tools.do_all_visible_tools (agent
				(a_tool: GUI_CLASS_TOOL) do a_tool.select_differential_view end
			)
		end

	on_flat_view
			-- set flat view on currently visible Tool
		do
			archetype_tools.do_all_visible_tools (agent
				(a_tool: GUI_ARCHETYPE_TOOL) do a_tool.select_flat_view end
			)
			class_map_tools.do_all_visible_tools (agent
				(a_tool: GUI_CLASS_TOOL) do a_tool.select_flat_view end
			)
		end

	on_reset_tool_layout
			-- Called by `select_actions' of `view_menu_reset_layout'.
			-- reset visual settings of window remembered to something sane
		do
			-- reset Docking layout
			if file_system.file_exists (default_docking_layout_file_path) then
				file_system.copy_file (default_docking_layout_file_path, user_docking_layout_file_path)
				initialise_docking_layout
			else
				console_tool.append_text (create_message_line ("read_docking_file_failed", <<default_docking_layout_file_path>>))
			end
		end


feature {NONE} -- Repository events

	configure_profiles
			-- Display the Repository Settings dialog. This dialog allows changing of
			-- the repository profiles, adding new ones and removal. Removal of the current
			-- repository or changing current repository paths will cause visual update;
			-- adding a new profile won't - the current selection stays.
		local
			dialog: REPOSITORY_DIALOG
			any_profile_changes_made: BOOLEAN
			current_profile_removed: BOOLEAN
			current_profile_changed: BOOLEAN
		do
			create dialog
			dialog.show_modal_to_window (Current)

			any_profile_changes_made := dialog.any_profile_changes_made
			if any_profile_changes_made then
				current_profile_removed := dialog.current_profile_removed
				current_profile_changed := dialog.current_profile_changed
				save_resources
			end

			dialog.destroy

			-- if the list of profiles changed, repopulate the profile combo box selectors
			if dialog.any_profile_changes_made then
				populate_archetype_profile_combo
			end

			-- if the current profile changed or was removed, repopulate the explorers
			if current_profile_removed or current_profile_changed then
				console_tool.clear
				refresh_profile_context (True)
			end
		end

	select_profile
			-- Called by `select_actions' of profile selector
		do
			if not archetype_profile_combo.text.same_string (repository_profiles.current_profile_name) then
				console_tool.clear
				set_current_profile (archetype_profile_combo.text)
			end
			refresh_profile_context (False)
			clear_all_editors
		end

	build_all
			-- Build the whole system.
		do
			console_tool.show
			do_build_action (agent archetype_compiler.build_all)
		end

	rebuild_all
			-- Force the whole system to rebuild.
		do
			error_tool.clear
			console_tool.show
			do_build_action (agent archetype_compiler.rebuild_all)
		end

	build_subtree
			-- Build the subsystem below the currently selected node.
		do
			console_tool.show
			do_build_action (agent archetype_compiler.build_subtree)
		end

	rebuild_subtree
			-- Force rebuilding of the whole subsystem below the currently selected node.
		do
			console_tool.show
			do_build_action (agent archetype_compiler.rebuild_subtree)
		end

	compile_toggle
			-- start or stop current compilation
		do
			if archetype_compiler.is_building then
				interrupt_build
			else
				build_all
			end
		end

	interrupt_build
			-- Cancel the build currently in progress.
		do
			archetype_compiler.signal_interrupt
		end

	export_html
			-- Generate HTML from flat archetypes into `html_export_directory'.
		local
			dialog: EV_QUESTION_DIALOG
			yes_text, no_text: STRING
		do
			create dialog.make_with_text (create_message_line ("export_html_question", Void))
			dialog.set_title ("Export HTML")
			yes_text := create_message_content ("build_and_export_all", Void)
			no_text := create_message_content ("export_only_built", Void)
			dialog.set_buttons (<<yes_text, no_text, "Cancel">>)

			dialog.set_default_cancel_button (dialog.button ("Cancel"))
			dialog.show_modal_to_window (Current)

			if dialog.selected_button.same_string (yes_text) then
				do_build_action (agent archetype_compiler.build_and_export_all_html (html_export_directory))
			elseif dialog.selected_button.same_string (no_text) then
				do_build_action (agent archetype_compiler.export_all_html (html_export_directory))
			end
		end

	export_repository_report
			-- Export the contents of the Errors grid and other statistics to an XML file via a GUI file save dialog.
		local
			ok_to_write: BOOLEAN
			question_dialog: EV_QUESTION_DIALOG
			file: PLAIN_TEXT_FILE
			save_dialog: EV_FILE_SAVE_DIALOG
			xml_name: STRING
		do
			create save_dialog
			save_dialog.set_title ("Export Repository Report")
			save_dialog.set_file_name ("ArchetypeRepositoryReport.xml")
			save_dialog.set_start_directory (current_work_directory)
			save_dialog.filters.extend (["*.xml", "Save as XML"])
			save_dialog.show_modal_to_window (Current)
			xml_name := save_dialog.file_name.as_string_8

			if not xml_name.is_empty then
				set_current_work_directory (file_system.dirname (xml_name))

				if not file_system.has_extension (xml_name, ".xml") then
					xml_name.append (".xml")
				end

				ok_to_write := True
				create file.make (xml_name)

				if file.exists then
					create question_dialog.make_with_text (create_message_line ("file_exists_replace_question", <<xml_name>>))
					question_dialog.set_title ("Export Repository Report")
					question_dialog.set_buttons (<<"Yes", "No">>)
					question_dialog.show_modal_to_window (Current)
					ok_to_write := question_dialog.selected_button.same_string ("Yes")
				end

				if ok_to_write then
					do_with_wait_cursor (Current, agent error_tool.export_repository_report (xml_name))

					if file.exists then
						console_tool.append_text (create_message_line ("export_repository_report_replace_info", <<xml_name>>))
						show_in_system_browser (xml_name)
					else
						console_tool.append_text (create_message_line ("export_repository_report_replace_err", <<xml_name>>))
					end
				end
			end
		end

	refresh_directory
			-- reload current directory
		do
			refresh_profile_context (True)
		end

feature {NONE} -- History events

	on_history
			-- On opening the History menu, append the list of recent archetypes.
		do
			history_menu.wipe_out
			history_menu.extend (history_menu_back)
			history_menu.extend (history_menu_forward)
			history_menu.extend (history_menu_separator)

			if attached current_arch_cat as cat then
				cat.recently_selected_items (20).do_all (
					agent (aci: attached ARCH_CAT_ITEM)
						local
							mi: EV_MENU_ITEM
							pixmap: EV_PIXMAP
							text: STRING
							agt: PROCEDURE [ANY, TUPLE]
						do
				 			if attached {ARCH_CAT_MODEL_NODE} aci as acmn and then acmn.is_class then
							--	pixmap := object_node_pixmap (acmn) -- RM icon version; but seems confusing on UI in history menu
								pixmap := pixmaps [acmn.group_name]
								text := acmn.class_definition.globally_qualified_path
								agt := agent select_class_in_rm_schema_tool (acmn.class_definition.globally_qualified_path)
							elseif attached {ARCH_CAT_ARCHETYPE} aci as aca then
								pixmap := pixmaps [aca.group_name]
								text := aca.id.as_string
								agt := agent catalogue_tool.select_item (aca.id.as_string)
							end
							create mi.make_with_text (text)
							mi.set_pixmap (pixmap)
							mi.select_actions.extend (agt)
							history_menu.extend (mi)
						end
				)
			end
		end

	on_back
			-- Go back to the last archetype previously selected.
		do
			if attached current_arch_cat as cat then
				if cat.selection_history_has_previous then
					cat.selection_history_back
					catalogue_tool.go_to_selected_item
					populate_history_controls
				end
			end
		end

	on_forward
			-- Go forth to the next archetype previously selected.
		do
			if attached current_arch_cat as cat then
				if cat.selection_history_has_next then
					cat.selection_history_forth
					catalogue_tool.go_to_selected_item
					populate_history_controls
				end
			end
		end

feature {NONE} -- XML Menu events

	set_xml_rules
			-- Called by `select_actions' of `xml_menu_conv_rules'.
		do
			execution_environment.launch (text_editor_command + " %"" + xml_rules_file_path + "%"")
			mark_xml_rules_put_of_date -- assume that the user makes a change; not very scientific, but good enough for now
		end

feature {NONE} -- Tools menu events

	set_options
			-- Display the Options dialog.
		local
			dialog: OPTION_DIALOG
		do
			create dialog
			dialog.show_modal_to_window (Current)

			if dialog.has_changed_ui_options then
				save_resources
				populate_ui_arch_output_version
				if archetype_tools.has_tools then
					update_all_tools_rm_icons_setting
				end
			end
			if dialog.has_changed_navigator_options and repository_profiles.has_current_profile then
				save_resources
				catalogue_tool.populate
				test_tool.populate
			end
		end

	update_all_tools_rm_icons_setting
		do
			archetype_tools.do_all_tools (agent (a_tool: GUI_ARCHETYPE_TOOL) do a_tool.update_rm_icons_setting end)
			class_map_tools.do_all_tools (agent (a_tool: GUI_CLASS_TOOL) do a_tool.update_rm_icons_setting end)
			catalogue_tool.update_rm_icons_setting
		end

	clean_generated_files
			-- Remove all generated files below the repository directory and repopulate from scratch
		do
			if has_current_profile then
				do_with_wait_cursor (Current, agent current_arch_cat.do_all_archetypes (agent delete_generated_files))
				refresh_profile_context (True)
			end
		end

	delete_generated_files (ara: attached ARCH_CAT_ARCHETYPE)
			-- delete a generated file associated with `ara'
		do
			ara.clean_generated
			console_tool.append_text (ara.status)
		end

feature -- RM Schemas Events

	set_rm_schemas
			-- Called by `select_actions' of `tools_menu_rm_schemas'.
		local
			dialog: RM_SCHEMA_DIALOG
		do
			create dialog
			dialog.show_modal_to_window (Current)

			populate_archetype_profile_combo
			if dialog.has_changed_schema_load_list then
				console_tool.clear
				rm_schemas_access.load_schemas
				if not rm_schemas_access.found_valid_schemas then
					append_billboard_to_console
				else
					rm_schema_tool.populate
					refresh_profile_context (True)
				end
			elseif dialog.has_changed_schema_dir then
				rm_schema_tool.populate
				refresh_profile_context (True)
			end
		end

	reload_schemas
			-- user-initiated reload
		do
			rm_schemas_access.load_schemas
			refresh_profile_context (True)
		end

feature {NONE} -- Help events

	show_online_help
			-- Display the application's online help in an external browser.
		do
			show_in_system_browser (adl_help_page_url)
		end

	show_icon_help
			-- Display the icons help dialog.
		do
			(create {ICON_DIALOG}).show_modal_to_window (Current)
		end

	show_release_notes
			-- Display news about the latest release.
		do
			show_in_system_browser (Release_notes_file_path)
		end

	show_clinical_knowledge_manager
			-- Display CKM in an external browser.
		do
			show_in_system_browser (clinical_knowledge_manager_url)
		end

	show_bug_reporter
			-- Display the problem reporter in an external browser.
		do
			show_in_system_browser (bug_reporter_url)
		end

	show_about
			-- Display the application's About box.
		local
			dialog: EV_INFORMATION_DIALOG
		do
			create dialog.make_with_text (splash_text)
			dialog.set_title ("About ADL Workbench")
			dialog.set_pixmap (pixmaps ["adl_workbench_logo"])
			dialog.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 248))
			dialog.set_position (app_x_position + (app_width - dialog.width) // 2, app_y_position + (app_height - dialog.height) // 2)
			dialog.show_modal_to_window (Current)
		end

feature -- Archetype Events

	select_archetype_from_gui_data (gui_item: EV_ANY)
			-- Select and display the node of `archetype_file_tree' corresponding to the folder or archetype attached to `gui_item'.
		do
			if attached gui_item and has_current_profile then
				if attached {ARCH_CAT_ITEM} gui_item.data as aci then
					current_arch_cat.set_selected_item (aci)
					catalogue_tool.go_to_selected_item
				end
			end
		end

	display_class (a_class_def: BMM_CLASS_DEFINITION)
			-- display a class selected in some tool
		do
			class_map_tools.populate_active_tool (a_class_def)
		end

	select_class_in_rm_schema_tool (a_key: STRING)
			-- display a particular class in the RM schema tool
		do
			if rm_schema_tool.valid_item_id (a_key) then
				rm_schema_tool.select_item (a_key)
			end
		end

feature -- Address Bar control

	address_bar: GUI_ADDRESS_BAR
		once
			create Result.make (agent windows_hide_combo_dropdown, agent windows_show_combo_dropdown)
			Result.add_client_control (catalogue_tool)
			Result.add_client_control (rm_schema_tool)
		end

feature -- Docking controls

	attached_docking_manager: SD_DOCKING_MANAGER
			-- Attached `manager'
		require
			not_void: docking_manager /= Void
		local
			l_result: like docking_manager
		do
			l_result := docking_manager
			check l_result /= Void end -- Implied by precondition `not_void'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	docking_manager: detachable SD_DOCKING_MANAGER
			-- Docking manager

	tool_bar_content: detachable SD_TOOL_BAR_CONTENT
			-- Tool bar content

feature -- Catalogue tool

	catalogue_tool: GUI_CATALOGUE_TOOL
		once
			create Result.make (agent parse_archetype,
					agent edit_archetype,
					agent create_and_populate_new_archetype_tool,
					agent display_class,
					agent create_and_populate_new_class_tool,
					agent select_class_in_rm_schema_tool)
		end

	create_new_catalogue_tool
		local
			a_docking_pane: SD_CONTENT
		do
			create a_docking_pane.make_with_widget_title_pixmap (catalogue_tool.ev_root_container, pixmaps ["archetype_category"], create_message_content ("catalogue_tool_title", Void))
			attached_docking_manager.contents.extend (a_docking_pane)
			catalogue_tool.set_docking_pane (a_docking_pane)
			a_docking_pane.set_long_title (create_message_content ("catalogue_tool_title", Void))
			a_docking_pane.set_short_title (create_message_content ("catalogue_tool_title", Void))
			a_docking_pane.set_type ({SD_ENUMERATION}.tool)
			a_docking_pane.set_top ({SD_ENUMERATION}.left)
			a_docking_pane.show_actions.extend (agent address_bar.set_current_client (catalogue_tool))
			a_docking_pane.focus_in_actions.extend (agent address_bar.set_current_client (catalogue_tool))
		end

feature -- RM Schema tool

	rm_schema_tool: GUI_RM_SCHEMA_EXPLORER
		once
			create Result.make (agent display_class, agent create_and_populate_new_class_tool)
		end

	create_new_rm_schema_tool
		local
			a_docking_pane: SD_CONTENT
		do
			create a_docking_pane.make_with_widget_title_pixmap (rm_schema_tool.ev_root_container, pixmaps ["rm_schema"], "Reference Models")
			attached_docking_manager.contents.extend (a_docking_pane)
			a_docking_pane.set_long_title ("Reference Models")
			a_docking_pane.set_short_title ("Reference Models")
			a_docking_pane.set_type ({SD_ENUMERATION}.tool)
			a_docking_pane.set_auto_hide ({SD_ENUMERATION}.left)
			a_docking_pane.show_actions.extend (agent address_bar.set_current_client (rm_schema_tool))
			a_docking_pane.focus_in_actions.extend (agent address_bar.set_current_client (rm_schema_tool))
		end

feature -- Archetype tools

	archetype_tools: GUI_ARCHETYPE_TOOLS_CONTROLLER
		once
			create Result.make (attached_docking_manager, agent select_archetype_from_gui_data, agent update_all_tools_rm_icons_setting)
		end

	create_and_populate_new_archetype_tool
		do
			archetype_tools.create_new_tool
			if current_arch_cat.has_selected_archetype then
				archetype_tools.populate_active_tool
			end
		end

feature -- Class map tool

	class_map_tools: GUI_CLASS_TOOL_CONTROLLER
		once
			create Result.make (attached_docking_manager, agent update_all_tools_rm_icons_setting, agent display_class,
					agent create_and_populate_new_class_tool)
		end

	create_and_populate_new_class_tool (a_class_def: BMM_CLASS_DEFINITION)
		do
			class_map_tools.create_new_tool
			class_map_tools.populate_active_tool (a_class_def)
		end

feature -- Test tool

	test_tool: GUI_TEST_ARCHETYPE_TREE_CONTROL
		once
			create Result.make (agent statistics_tool.populate, agent info_feedback)
		end

	create_new_test_tool
		local
			a_docking_pane: SD_CONTENT
		do
			create a_docking_pane.make_with_widget_title_pixmap (test_tool.ev_root_container, pixmaps ["tools"], "Test")
			attached_docking_manager.contents.extend (a_docking_pane)
			a_docking_pane.set_long_title ("Test")
			a_docking_pane.set_short_title ("Test")
			a_docking_pane.set_type ({SD_ENUMERATION}.tool)
			a_docking_pane.set_auto_hide ({SD_ENUMERATION}.bottom)
		end

feature -- Console Tool

	console_tool: GUI_CONSOLE_TOOL
		once
			create Result.make
		end

	create_new_console_tool
		local
			docking_pane: SD_CONTENT
		do
			create docking_pane.make_with_widget_title_pixmap (console_tool.ev_console, pixmaps ["console"], "Console")
			console_tool.set_docking_pane (docking_pane)
			attached_docking_manager.contents.extend (docking_pane)
			docking_pane.set_type ({SD_ENUMERATION}.tool)
			docking_pane.set_long_title ("Console")
			docking_pane.set_short_title ("Console")
			docking_pane.set_auto_hide ({SD_ENUMERATION}.bottom)
		end

feature -- Error Tool

	error_tool: GUI_ERROR_TOOL
		once
			create Result.make (agent select_archetype_from_gui_data, agent error_tool_title_update)
		end

	error_docking_pane: SD_CONTENT

	create_new_error_tool
		do
			create error_docking_pane.make_with_widget_title_pixmap (error_tool.grid, pixmaps ["errors"], "Errors")
			attached_docking_manager.contents.extend (error_docking_pane)
			error_docking_pane.set_type ({SD_ENUMERATION}.tool)
			error_docking_pane.set_long_title ("Errors")
			error_docking_pane.set_short_title ("Errors")
			error_docking_pane.set_auto_hide ({SD_ENUMERATION}.bottom)
		end

	error_tool_title_update (parse_error_count, validity_error_count, warning_count: NATURAL)
		do
			error_docking_pane.set_short_title ("Errors (" + parse_error_count.out + "/" + validity_error_count.out + "/" + warning_count.out + ")")
			error_docking_pane.set_long_title ("Errors (" + parse_error_count.out + "/" + validity_error_count.out + "/" + warning_count.out + ")")
		end

feature -- Statistics Tool

	statistics_tool: GUI_STATISTICS_TOOL
		once
			create Result.make
		end

	create_new_statistics_tool
		local
			docking_pane: SD_CONTENT
		do
			create docking_pane.make_with_widget_title_pixmap (statistics_tool.ev_root_container, pixmaps ["info"], "Statistics")
			attached_docking_manager.contents.extend (docking_pane)
			docking_pane.set_type ({SD_ENUMERATION}.tool)
			docking_pane.set_long_title ("Statistics")
			docking_pane.set_short_title ("Statistics")
			docking_pane.set_auto_hide ({SD_ENUMERATION}.bottom)
		end

feature -- Clipboard

	show_clipboard
			-- Display the current contents of the clipboard.
		local
			dialog: EV_INFORMATION_DIALOG
		do
			create dialog.make_with_text (ev_application.clipboard.text)
			dialog.set_title ("Clipboard Contents")
			dialog.show_modal_to_window (Current)
		end

feature {NONE} -- Implementation

	info_feedback (a_message: attached STRING)
		local
			info_dialog: EV_INFORMATION_DIALOG
		do
			create info_dialog.make_with_text (a_message)
			info_dialog.set_title ("Information")
			info_dialog.show_modal_to_window (Current)
		end

	text_widget_handler: GUI_TEXT_WIDGET_HANDLER
			-- FIXME: this is a hack to get round lack of standard behaviour in Vision2 for
			-- focussed text widgets & cut & paste behaviours
		once
			create Result.make (Current)
		end

	append_billboard_to_console
			-- Append bilboard contents to console and clear billboard.
		do
			console_tool.append_text (billboard.content)
			billboard.clear
		end

	save_resources
			-- Save the application configuration file and update the status area.
		do
			app_cfg.save
			post_info (Current, "save_resources_and_show_status", "cfg_file_i1", <<user_config_file_path>>)
		end

	refresh_profile_context (refresh_from_repository: BOOLEAN)
			-- Rebuild archetype directory & repopulate relevant GUI parts.
		do
			do_with_wait_cursor (Current, agent do_refresh_profile_context (refresh_from_repository))
		end

	do_refresh_profile_context (refresh_from_repository: BOOLEAN)
		do
			console_tool.show
			console_tool.append_text (create_message_line ("populating_directory_start", <<repository_profiles.current_profile_name>>))
			use_current_profile (refresh_from_repository)
			console_tool.append_text (create_message_line ("populating_directory_complete", Void))

			clear_toolbar_controls
			error_tool.clear
			clear_all_editors

			append_billboard_to_console

			catalogue_tool.populate
			test_tool.populate
			statistics_tool.populate
		end

	clear_toolbar_controls
			-- Wipe out content from visual controls.
		do
			populate_history_controls
			address_bar.clear
		end

	clear_all_editors
		do
			class_map_tools.clear_all_tools_content
			archetype_tools.clear_all_tools_content
		end

	populate_archetype_profile_combo
			-- Initialise the dialog's widgets from shared settings.
		do
			archetype_profile_combo.select_actions.block
			archetype_profile_combo.change_actions.block
			if not repository_profiles.is_empty then
				archetype_profile_combo.set_strings (repository_profiles.names)
				if repository_profiles.has_current_profile then
					archetype_profile_combo.do_all (agent (li: EV_LIST_ITEM) do if li.text.same_string (repository_profiles.current_profile_name) then li.enable_select end end)
				end
			else
				archetype_profile_combo.wipe_out
			end
			archetype_profile_combo.select_actions.resume
			archetype_profile_combo.change_actions.resume
		end

	populate_compile_button
		do
			if not archetype_compiler.is_building then
				compile_button.set_pixmap (pixmaps ["compile"])
			else
				compile_button.set_pixmap (pixmaps ["pause"])
			end
		end

	populate_history_controls
		do
			if has_current_profile and then current_arch_cat.selection_history_has_previous then
				history_menu_back.enable_sensitive
				history_back_button.enable_sensitive
			else
				history_menu_back.disable_sensitive
				history_back_button.disable_sensitive
			end

			if has_current_profile and then current_arch_cat.selection_history_has_next then
				history_menu_forward.enable_sensitive
				history_forward_button.enable_sensitive
			else
				history_menu_forward.disable_sensitive
				history_forward_button.disable_sensitive
			end
		end

	populate_ui_arch_output_version
			-- populate ADL output version wherever it appears in the UI
		do
			-- main form combo
			arch_output_version_combo.do_all (
				agent (li: EV_LIST_ITEM)
					do
						if li.text.same_string (adl_version_for_flat_output) then
							li.enable_select
						end
					end
			)

			-- archetype tool
			if archetype_tools.has_tools then
				archetype_tools.active_tool.change_adl_serialisation_version
			end
		end

feature {GUI_TEST_ARCHETYPE_TREE_CONTROL} -- Statistics

	populate_statistics
			-- Populate the statistics tab.
		do
			statistics_tool.populate
		end

feature {NONE} -- Build commands

	do_build_action (action: attached PROCEDURE [ANY, TUPLE])
			-- Perform `action', with an hourglass mouse cursor and disabling the build menus, until done.
		local
			menu_items: ARRAY [EV_MENU_ITEM]
		do
			if menu_items = Void then
				menu_items := <<
					repository_menu_build_all,
					repository_menu_rebuild_all,
					repository_menu_build_subtree,
					repository_menu_rebuild_subtree,
					repository_menu_export_html
				>>

				menu_items.do_all (agent {EV_MENU_ITEM}.disable_sensitive)
				repository_menu_interrupt_build.enable_sensitive
				do_with_wait_cursor (Current, action)
			end

			menu_items.do_all (agent {EV_MENU_ITEM}.enable_sensitive)
			repository_menu_interrupt_build.disable_sensitive
		rescue
			retry
		end

	compiler_global_gui_update (msg: attached STRING)
			-- Update GUI with progress on build.
		do
			populate_compile_button
			console_tool.append_text (msg)
			ev_application.process_events
		end

	compiler_archetype_gui_update (msg: attached STRING; aca: attached ARCH_CAT_ARCHETYPE; dependency_depth: INTEGER)
			-- Update GUI with progress on build.
		do
			if not msg.is_empty then
				console_tool.append_text (indented (msg, create {STRING}.make_filled ('%T', dependency_depth)))
			end

			catalogue_tool.update (aca)
			test_tool.do_row_for_item (aca)

			if attached aca.last_compile_attempt_timestamp then
				error_tool.extend_and_select (aca)
				statistics_tool.populate

				if attached current_arch_cat then
					if aca = current_arch_cat.selected_archetype then
						archetype_tools.populate_active_tool
					end
				end
			end

			ev_application.process_events
		end

	set_adl_version_from_combo
			-- set ADL version
		local
			info_dialog: EV_INFORMATION_DIALOG
		do
			set_adl_version_for_flat_output (arch_output_version_combo.selected_text.as_string_8)

			-- update archetype tool
			if archetype_tools.has_tools then
				archetype_tools.active_tool.change_adl_serialisation_version
			end

			-- for the moment, post a message about ADL 1.4 XML not being available
			if adl_version_for_flat_output_numeric < 150 then
				create info_dialog.make_with_text ("XML based on ADL 1.4 available in next release")
				info_dialog.set_title ("Configuration warning")
				info_dialog.show_modal_to_window (Current)
			end
		end

feature {NONE} -- GUI Widgets

	action_bar, arch_output_version_hbox: EV_HORIZONTAL_BOX
	archetype_profile_combo, arch_output_version_combo: EV_COMBO_BOX
	arch_history_tool_bar, arch_compile_tool_bar: EV_TOOL_BAR
	compile_button, open_button, history_back_button, history_forward_button: EV_TOOL_BAR_BUTTON
	tool_bar_sep_1, tool_bar_sep_2, tool_bar_sep_3: EV_TOOL_BAR_SEPARATOR
	arch_output_version_label: EV_LABEL

	viewer_main_cell: EV_CELL

	menu: EV_MENU_BAR
	file_menu, edit_menu, view_menu, history_menu, repository_menu, rm_schemas_menu,
	xml_menu, tools_menu, help_menu: EV_MENU
	file_menu_open, file_menu_save_as, file_menu_exit, edit_menu_copy, edit_menu_select_all, edit_menu_clipboard,
	view_menu_differential, view_menu_flat, view_menu_new_archetype_tool, view_menu_new_class_tool,
	view_menu_reset_layout, history_menu_back, history_menu_forward, repository_menu_build_all,
	repository_menu_rebuild_all, repository_menu_build_subtree, repository_menu_rebuild_subtree,
	repository_menu_export_html, repository_menu_export_repository_report, repository_menu_interrupt_build,
	repository_menu_refresh, repository_menu_set_repository, rm_schemas_menu_reload_schemas,
	rm_schemas_menu_configure_rm_schemas, xml_menu_conv_rules, tools_menu_clean_generated_files,
	tools_menu_options, help_menu_contents, help_menu_release_notes, help_menu_icons,
	help_menu_clinical_knowledge_manager, help_menu_report_bug, help_menu_about: EV_MENU_ITEM
	l_ev_menu_separator_1,
	l_ev_menu_separator_2, l_ev_menu_separator_3, l_ev_menu_separator_4, history_menu_separator,
	l_ev_menu_separator_5, l_ev_menu_separator_6, l_ev_menu_separator_7, l_ev_menu_separator_8,
	l_ev_menu_separator_9, l_ev_menu_separator_10, l_ev_menu_separator_11, l_ev_menu_separator_12: EV_MENU_SEPARATOR
	ev_main_vbox: EV_VERTICAL_BOX

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := True
		end

	windows_hide_combo_dropdown (a_combo: EV_COMBO_BOX)
		do
			if attached {EV_COMBO_BOX_IMP} a_combo.implementation as imp then
				(create {GUI_PLATFORM_SPECIFIC_TOOLS}).hide_combo_box_list (imp)
			end
		end

	windows_show_combo_dropdown (a_combo: EV_COMBO_BOX)
		do
			if attached {EV_COMBO_BOX_IMP} a_combo.implementation as imp then
				(create {GUI_PLATFORM_SPECIFIC_TOOLS}).show_combo_box_list (imp)
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
--| The Original Code is main_window.e.
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
