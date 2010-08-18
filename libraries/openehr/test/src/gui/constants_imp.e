note
	description: "Objects that provide access to constants loaded from files."
	date: "$LastChangedDate$"
	revision: "$LastChangedRevision$"

class
	CONSTANTS_IMP
	
feature {NONE} -- Initialization

	initialize_constants
			-- Load all constants from file.
		local
			file: PLAIN_TEXT_FILE
		do
			if not constants_initialized then
				create file.make (file_name)
				if file.exists then
					file.open_read
					file.readstream (file.count)
					file.close
					parse_file_contents (file.laststring)
				end
				initialized_cell.put (True)
			end
		ensure
			initialized: constants_initialized
		end

feature -- Access

	test_list_width: INTEGER 
			-- `Result' is INTEGER constant named test_list_width.
		once
			Result := integer_constant_by_name ("test_list_width")
		end

	test_cases_label: STRING
			-- `Result' is STRING constant named `test_cases_label'.
		once
			Result := string_constant_by_name ("test_cases_label")
		end

	run_test_button_text: STRING
			-- `Result' is STRING constant named `run_test_button_text'.
		once
			Result := string_constant_by_name ("run_test_button_text")
		end

	test_suites_label: STRING
			-- `Result' is STRING constant named `test_suites_label'.
		once
			Result := string_constant_by_name ("test_suites_label")
		end

	execution_label_name: STRING
			-- `Result' is STRING constant named `execution_label_name'.
		once
			Result := string_constant_by_name ("execution_label_name")
		end

	button_width: INTEGER 
			-- `Result' is INTEGER constant named button_width.
		once
			Result := integer_constant_by_name ("button_width")
		end

	screen_depth: INTEGER 
			-- `Result' is INTEGER constant named screen_depth.
		once
			Result := integer_constant_by_name ("screen_depth")
		end

	test_list_height: INTEGER 
			-- `Result' is INTEGER constant named test_list_height.
		once
			Result := integer_constant_by_name ("test_list_height")
		end

	output_text_height: INTEGER 
			-- `Result' is INTEGER constant named output_text_height.
		once
			Result := integer_constant_by_name ("output_text_height")
		end

	main_window_title: STRING
			-- `Result' is STRING constant named `main_window_title'.
		once
			Result := string_constant_by_name ("main_window_title")
		end

	screen_width: INTEGER 
			-- `Result' is INTEGER constant named screen_width.
		once
			Result := integer_constant_by_name ("screen_width")
		end

	test_case_list_width: INTEGER 
			-- `Result' is INTEGER constant named test_case_list_width.
		once
			Result := integer_constant_by_name ("test_case_list_width")
		end

	test_output_text_width: INTEGER 
			-- `Result' is INTEGER constant named test_output_text_width.
		once
			Result := integer_constant_by_name ("test_output_text_width")
		end

	test_case_output_name: STRING
			-- `Result' is STRING constant named `test_case_output_name'.
		once
			Result := string_constant_by_name ("test_case_output_name")
		end

	test_case_report: STRING
			-- `Result' is STRING constant named `test_case_report'.
		once
			Result := string_constant_by_name ("test_case_report")
		end


feature -- Access

--| FIXME `constant_by_name' and `has_constant' `constants_initialized' are only required until the complete change to
--| constants is complete. They are required for the pixmaps at the moment.

	constants_initialized: BOOLEAN
			-- Have constants been initialized from file?
		do
			Result := initialized_cell.item
		end

	string_constant_by_name (a_name: STRING): STRING
			-- `Result' is STRING 
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
			has_constant (a_name)
		do
			Result := clone (all_constants.item (a_name))
		ensure
			Result_not_void: Result /= Void
		end
		
	integer_constant_by_name (a_name: STRING): INTEGER
			-- `Result' is STRING 
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
			has_constant (a_name)
		local
			l_string: STRING
		do
			l_string := clone (all_constants.item (a_name))
			check
				is_integer: l_string.is_integer
			end
			
			Result := l_string.to_integer
		end
		
	has_constant (a_name: STRING): BOOLEAN
			-- Does constant `a_name' exist?
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
		do
			Result := all_constants.item (a_name) /= Void
		end

feature {NONE} -- Implementation

	initialized_cell: CELL [BOOLEAN]
			-- A cell to hold whether the constants have been loaded.
		once
			create Result
		end
		
	all_constants: HASH_TABLE [STRING, STRING]
			-- All constants loaded from constants file.
		once
			create Result.make (4)
		end
		
	file_name: STRING = "constants.txt"
		-- File name from which constants must be loaded.
		
	String_constant: STRING = "STRING"
	
	Integer_constant: STRING = "INTEGER"
		
	parse_file_contents (content: STRING)
			-- Parse contents of `content' into `all_constants'.
		local
			line_contents: STRING
			is_string: BOOLEAN
			is_integer: BOOLEAN
			start_quote1, end_quote1, start_quote2, end_quote2: INTEGER
			name, value: STRING
		do
			from
			until
				content.is_equal ("")
			loop
				line_contents := first_line (content)
				if line_contents.count /= 1 then
					is_string := line_contents.substring_index (String_constant, 1) /= 0
					is_integer := line_contents.substring_index (Integer_constant, 1) /= 0
					if is_string or is_integer then
						start_quote1 := line_contents.index_of ('"', 1)
						end_quote1 := line_contents.index_of ('"', start_quote1 + 1)
						start_quote2 := line_contents.index_of ('"', end_quote1 + 1)
						end_quote2 := line_contents.index_of ('"', start_quote2 + 1)
						name := line_contents.substring (start_quote1 + 1, end_quote1 - 1)
						value := line_contents.substring (start_quote2 + 1, end_quote2 - 1)
						all_constants.extend (value, name)
					end
				end
			end
		end
		
	first_line (content: STRING): STRING
			-- `Result' is first line of `Content',
			-- which will be stripped from `content'.
		require
			content_not_void: content /= Void
			content_not_empty: not content.is_empty
		local
			new_line_index: INTEGER		
		do
			new_line_index := content.index_of ('%N', 1)
			if new_line_index /= 0 then
				Result := content.substring (1, new_line_index)
				content.keep_tail (content.count - new_line_index)
			else
				Result := clone (content)
				content.keep_head (0)
			end
		ensure
			Result_not_void: Result /= Void
			no_characters_lost: old content.count = Result.count + content.count
		end

	set_with_named_file (a_pixmap: EV_PIXMAP; a_file_name: STRING)
			-- Set image of `a_pixmap' from file, `a_file_name'.
			-- If `a_file_name' does not exist, do nothing.
		require
			a_pixmap_not_void: a_pixmap /= Void
			a_file_name /= Void
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_file_name)
			if l_file.exists then
				a_pixmap.set_with_named_file (a_file_name)
			end
		end

invariant
	all_constants_not_void: all_constants /= Void

end -- class CONSTANTS_IMP
