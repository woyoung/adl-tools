note
	component:   "openEHR ADL Tools"
	description: "Tests for manipulating an archetype directory"
	keywords:    "archetype, ontology, terminology"
	author:      "Peter Gummer"
	support:     "Ocean Informatics <support@OceanInformatics.com>"
	copyright:   "Copyright (c) 2009 Ocean Informatics Pty Ltd"
	license:     "Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>"

class
	TEST_ARCHETYPE_DIRECTORY

inherit
	ADL_TEST_SET
		redefine
			on_prepare
		end

	SHARED_APP_ROOT
		undefine
			default_create
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
			Precursor
			application_developer_name.make_from_string ("openEHR")

			app_root.initialise_shell
			if app_root.ready_to_initialise_app then
				app_root.initialise_app

				if repository_config_table.has_repository ("Test") then
					set_current_repository ("Test")
				elseif repository_config_table.has_repository ("test") then
					set_current_repository ("test")
				else
					assert ("Please define the %"Test%" repository in " + app_cfg.file_path, False)
				end

				set_error_reporting_level (Error_type_error)
				use_current_repository (True)
				test_repository := repository_config_table.current_repository.reference_path
			end
		end

feature -- Access

	test_repository: detachable STRING
			-- Repository of test archetypes. Its path must be defined in the cfg file, otherwise these unit tests fail.
		note
			option: stable
		attribute
		end

feature -- Test routines

	test_add_adhoc_item
			-- Check that an ad-hoc archetype can be added.
		note
			testing: "covers/{ARCHETYPE_CATALOGUE}.add_adhoc_item"
		local
			adl: STRING
			name: STRING
		do
			adl := "[
				archetype (adl_version=1.5)
					openehr-TEST_PKG-WHOLE.add_adhoc_item.v1
				language original_language = <[ISO_639-1::en]>
				description original_author = < ["name"] = <"unknown"> >
				definition WHOLE[at0000] matches {*}
				ontology term_definitions = < ["en"] = < items = < ["at0000"] = < description = <""> text = <""> > > > >
				]"

			name := file_system.pathname (test_directory, "openehr-TEST_PKG-WHOLE.add_adhoc_item.v1.adls")
			file_context.save_file (name, adl)
			assert_equal (False, attached current_arch_cat.last_added_archetype)
			current_arch_cat.add_adhoc_archetype (name)
			assert_equal (True, attached current_arch_cat.last_added_archetype)
		end

	test_populate
			-- Check that the repository can be populated.
		note
			testing: "covers/{ARCHETYPE_CATALOGUE}.populate"
		do
			assert_equal (test_repository, current_arch_cat.repository_access.reference_repository.full_path)
			assert_equal (0, current_arch_cat.compile_attempt_count)
		--	assert ("Expected warning about ADL version", billboard.content.has_substring ("WARNING - Using ADL version"))
		end

end


